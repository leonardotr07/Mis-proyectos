using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ListarEmpleadoXVentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("IdVenta");
            dt.Columns.Add("Fecha");
            dt.Columns.Add("Monto");
            dt.Columns.Add("Comprobante");
            dt.Columns.Add("Cliente");

            // Agrega filas de prueba para ver el formato
            dt.Rows.Add("1", "25/10/2025", "234.00", "1234567", "Guanira");
            dt.Rows.Add("2", "25/10/2025", "234.00", "1234567", "Cueva");
            dt.Rows.Add("3", "25/10/2025", "234.00", "1234567", "Tupia");

            gvVentas.DataSource = dt;
            gvVentas.DataBind();
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleadoXVentas.aspx");
        }

        protected void lkRegresar_Click(object sender, EventArgs e)
        {

        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {

        }
    }
}