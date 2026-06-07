using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class VerPrendaSeleccionadaparaVenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarGridTallasStock();
            }
        }


        private void CargarGridTallasStock()
        {
            // Creamos un DataTable con las columnas que usará el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("Talla", typeof(string));
            dt.Columns.Add("Stock", typeof(int));

            // 🧵 Ejemplo de datos — luego puedes reemplazar con datos reales de tu base
            dt.Rows.Add("XS", 15);
            dt.Rows.Add("S", 22);
            dt.Rows.Add("M", 30);
            dt.Rows.Add("L", 18);
            dt.Rows.Add("XL", 12);
            dt.Rows.Add("XXL", 5);

            // Enlazamos al GridView
            dgvTallasStock.DataSource = dt;
            dgvTallasStock.DataBind();
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SeleccionarPrendaAnnadirProducto.aspx"); // Cambia por la página de destino
        }

    }
}