using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class VerItemsVenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idVenta;
                if (int.TryParse(Request.QueryString["id"], out idVenta))
                {
                    CargarItems(idVenta);
                }
            }
        }

        private void CargarItems(int idVenta)
        {
            // 🔹 Ejemplo de datos (reemplazar por datos reales de BD)
            DataTable dt = new DataTable();
            dt.Columns.Add("Nº", typeof(int));
            dt.Columns.Add("Prenda");
            dt.Columns.Add("Talla");
            dt.Columns.Add("Cantidad", typeof(int));
            dt.Columns.Add("Promociones");
            dt.Columns.Add("Descuentos");
            dt.Columns.Add("Subtotal", typeof(decimal));

            dt.Rows.Add(1, "Polo rojo", "M", 2, "Ninguna", "0%", 99.80m);
            dt.Rows.Add(2, "Zapatillas", "42", 1, "10% Off", "10%", 179.91m);

            dgvProductosVenta.DataSource = dt;
            dgvProductosVenta.DataBind();

            txtTotalPagado.Text = "279.71"; // Ejemplo
        }

        protected void btnRegresarVentaProducto_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/VerVentaResumen.aspx");
        }
    }
}