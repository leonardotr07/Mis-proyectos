using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class VerVentaResumen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    CargarVenta(Convert.ToInt32(id));
                }
            }
        }

        private void CargarVenta(int id)
        {
            // Aquí iría tu lógica para cargar los datos desde la BD
            // Por ahora dejamos valores de ejemplo:

            txtIDVenta.Text = id.ToString();
            txtDNICliente.Text = "76453218";
            txtIDEmpleado.Text = "E001";
            txtUsuarioEmpleado.Text = "vendedor01";
            txtFecha.Text = DateTime.Now.ToShortDateString();
            txtMontoTotal.Text = "350.00";
            txtTipoComprobante.Text = "Boleta";
        }

        protected void btnVerComprobante_Click(object sender, EventArgs e)
        {
            // Redirige a la página del comprobante
            string tipo = txtTipoComprobante.Text.Trim();
            if (tipo == "Boleta")
                Response.Redirect("~/RegistrarVentaBoleta.aspx");
            else
                Response.Redirect("~/RegistrarVentaFactura.aspx");
        }

        protected void btnVerItemsVenta_Click(object sender, EventArgs e)
        {
            // Obtenemos el ID de la venta desde el query string
            string idVentaStr = Request.QueryString["id"];

            if (!string.IsNullOrEmpty(idVentaStr))
            {
                // Redirigimos a la página de items con el ID
                Response.Redirect($"~/VerItemsVenta.aspx?id={idVentaStr}");
            }
            else
            {
                // Manejo básico por si no hay ID
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No se encontró el ID de la venta.');", true);
            }
        }

        protected void btnRegresarVenta_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionarVentas.aspx");
        }
    }
}