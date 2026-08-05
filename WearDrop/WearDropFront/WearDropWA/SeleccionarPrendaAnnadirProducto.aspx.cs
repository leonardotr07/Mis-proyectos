using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class SeleccionarPrendaAnnadirProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPrendas();
            }
        }

        private void CargarPrendas()
        {
            // 🔹 Aquí puedes reemplazar esta tabla de ejemplo por tu fuente de datos real
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Tipo", typeof(string));
            dt.Columns.Add("Color", typeof(string));
            dt.Columns.Add("Material", typeof(string));
            dt.Columns.Add("PU", typeof(double));
            dt.Columns.Add("PM", typeof(double));
            dt.Columns.Add("PD", typeof(double));

            // 🔹 Ejemplo de datos de prueba
            dt.Rows.Add(1, "Polera Oversize", "Polera", "Negro", "Algodón", 39.90, 42.50, 45.00);
            dt.Rows.Add(2, "Camisa Clásica", "Camisa", "Blanco", "Lino", 55.90, 58.00, 60.00);
            dt.Rows.Add(3, "Pantalón Cargo", "Pantalón", "Verde", "Gabardina", 69.90, 72.00, 74.00);
            dt.Rows.Add(4, "Casaca Denim", "Casaca", "Azul", "Jean", 120.00, 125.00, 130.00);
            dt.Rows.Add(5, "Hoodie Street", "Polera", "Rojo", "Algodón", 80.00, 82.00, 85.00);

            // 🔹 Enlazar datos al GridView
            dgvPrendas.DataSource = dt;
            dgvPrendas.DataBind();
        }

        protected void dgvPrendas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvPrendas.PageIndex = e.NewPageIndex;
            CargarPrendas();
        }


        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            // 🔹 Aquí puedes agregar la lógica para obtener la prenda seleccionada
            // Por ejemplo, recorrer las filas del GridView y detectar cuál fue marcada
            // (en este ejemplo el botón circular es solo visual, pero se puede adaptar
            // para marcar una fila con CheckBox si deseas guardar el valor en servidor)

            // Ejemplo de mensaje simple:
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Prenda seleccionada correctamente.');", true);
            Response.Redirect("~/AnnadirProductoVenta.aspx");

        }




        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AnnadirProductoVenta.aspx"); // Cambia por la ruta real
        }


        protected void btnVerPrendaParaVenta_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/VerPrendaSeleccionadaparaVenta.aspx"); // Cambia por la ruta real
        }

    }
}