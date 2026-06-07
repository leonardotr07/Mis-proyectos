using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class RegistrarCondicionesdePago : System.Web.UI.Page
    {
        private List<condicionPago> condiciones
        {
            get => (List<condicionPago>)Session["condicionesPago"];
            set => Session["condicionesPago"] = value;
        }

        private string estadoProveedor => Session["estadoProveedor"]?.ToString() ?? "nuevo";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (condiciones == null)
                {
                    condiciones = new List<condicionPago>();
                }

                // 🔹 NUEVO: Configurar interfaz según el estado
                ConfigurarInterfazSegunEstado();
                CargarCondiciones();
            }
        }

        // 🔹 NUEVO: Método para configurar interfaz según estado
        private void ConfigurarInterfazSegunEstado()
        {
            switch (estadoProveedor)
            {
                case "modificar":
                    btnRegistrarCondicion.Text = "Añadir Condición";
                    Page.Title = "Modificar Condiciones de Pago";
                    lblTituloPagina.InnerText = "Modificar Condiciones de Pago"; // 🔹 CAMBIA EL TEXTO
                    break;
                case "ver":
                    btnRegistrarCondicion.Visible = false;
                    btnFiltrarCondiciones.Visible = false;

                    Page.Title = "Ver Condiciones de Pago";
                    lblTituloPagina.InnerText = "Ver Condiciones de Pago"; // 🔹 CAMBIA EL TEXTO
                    break;
                case "nuevo":
                default:
                    Page.Title = "Registrar Condiciones de Pago";
                    lblTituloPagina.InnerText = "Registrar Condiciones de Pago"; // 🔹 CAMBIA EL TEXTO
                    break;
            }
        }

        private void CargarCondiciones()
        {
            dgvCondicionesPago.DataSource = condiciones;
            dgvCondicionesPago.DataBind();
        }

        protected void dgvCondicionesPago_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvCondicionesPago.PageIndex = e.NewPageIndex;
            CargarCondiciones();
        }

        // 🔹 NUEVO: Evento para configurar cada fila del GridView
        protected void dgvCondicionesPago_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Buscar los botones en la fila
                LinkButton btnModificar = (LinkButton)e.Row.FindControl("btnModificarCondicion");
                LinkButton btnEliminar = (LinkButton)e.Row.FindControl("btnEliminarCondicion");
                LinkButton btnVer = (LinkButton)e.Row.FindControl("btnVerCondicion");

                if (estadoProveedor == "ver")
                {
                    // 🔹 Opción 1: Deshabilitar (recomendado)
                    if (btnModificar != null)
                    {
                        btnModificar.Visible = false;
                        btnModificar.CssClass = "btn btn-sm btn-outline-secondary";
                        btnModificar.ToolTip = "No disponible en modo visualización";
                    }

                    if (btnEliminar != null)
                    {
                        btnEliminar.Visible = false;
                        btnEliminar.CssClass = "btn btn-sm btn-outline-secondary";
                        btnEliminar.ToolTip = "No disponible en modo visualización";
                    }

                    // 🔹 Opción 2: Ocultar completamente
                    // if (btnModificar != null) btnModificar.Visible = false;
                    // if (btnEliminar != null) btnEliminar.Visible = false;
                }
                else if (estadoProveedor == "modificar")
                {
                    // En modo modificar, los botones están habilitados
                    if (btnModificar != null) btnModificar.Enabled = true;
                    if (btnEliminar != null) btnEliminar.Enabled = true;
                }
            }
        }

        protected void btnRegistrarCondicion_Click(object sender, EventArgs e)
        {
            // Modo: nuevo (siempre es nuevo para condiciones individuales)
            Session["modoCondicion"] = "nuevo";
            Response.Redirect("~/RegistrarCondicion.aspx");
        }

        protected void btnModificarCondicion_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
            Session["modoCondicion"] = "modificar";
            Session["condicionSeleccionada"] = condiciones.First(c => c.idCondicion == id);
            Response.Redirect("~/RegistrarCondicion.aspx");
        }

        protected void btnVerCondicion_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
            Session["modoCondicion"] = "ver";
            Session["condicionSeleccionada"] = condiciones.First(c => c.idCondicion == id);
            Response.Redirect("~/RegistrarCondicion.aspx");
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Session["condicionesPago"] = condiciones;

            // 🔹 NUEVO: Mantener parámetro de acción al regresar
            string url = "~/RegistrarProveedor.aspx";
            if (estadoProveedor != "nuevo")
            {
                url += $"?accion={estadoProveedor}";
            }

            Response.Redirect(url);
        }

        protected void btnEliminarCondicion_Click(object sender, EventArgs e)
        {
            // 🔹 NUEVO: Prevenir eliminación en modo "ver" (por si acaso)
            if (estadoProveedor == "ver")
            {
                MostrarMensaje("No se pueden eliminar condiciones en modo de visualización.");
                return;
            }

            int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);

            var condicionAEliminar = condiciones.FirstOrDefault(c => c.idCondicion == id);
            if (condicionAEliminar != null)
            {
                condiciones.Remove(condicionAEliminar);
                Session["condicionesPago"] = condiciones;
                CargarCondiciones();
            }
        }

        // 🔹 NUEVO: Método para mostrar mensajes
        private void MostrarMensaje(string mensaje)
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }


    }
}