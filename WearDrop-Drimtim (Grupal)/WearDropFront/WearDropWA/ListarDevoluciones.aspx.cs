using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using RefDev = WearDropWA.DevolucionWS;   // ajusta al namespace real de tu referencia

namespace WearDropWA
{
    public partial class ListarDevoluciones : Page
    {
        private RefDev.DevolucionWSClient devClient;

        protected void Page_Load(object sender, EventArgs e)
        {
            devClient = new RefDev.DevolucionWSClient();

            if (!IsPostBack)
            {
                CargarDevoluciones();
            }
        }

        private void CargarDevoluciones()
        {
            // Llamamos al servicio
            var listaWS = devClient.listarDevoluciones();

            // Proyectamos solo lo que queremos mostrar (incluye IdPrenda, NombrePrenda, NombreProveedor)
            var datos = listaWS?
                .Select(d => new
                {
                    d.id,
                    d.descripcion,
                    NombrePrenda = d.nombrePrenda,
                    NombreProveedor = d.proveedor.nombre,
                    d.talla,
                    d.cantidad,
                    d.monto,
                    d.fecha
                })
                .ToList();

            gvDevoluciones.DataSource = datos;
            gvDevoluciones.DataBind();
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarDevoluciones.aspx");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            int id = int.Parse(btn.CommandArgument);
            Response.Redirect("VerDevoluciones.aspx?id=" + id);
        }

        //protected void btnModificar_Click(object sender, EventArgs e)
        //{
        //    var btn = (LinkButton)sender;
        //    int id = int.Parse(btn.CommandArgument);
        //    Response.Redirect("RegistrarDevoluciones.aspx?id=" + id + "&modo=editar");
        //}

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdDevolucionEliminar.Value);
            int resultado = devClient.eliminarDevolucion(id);
            if (resultado > 0) CargarDevoluciones();
        }
    }
}
