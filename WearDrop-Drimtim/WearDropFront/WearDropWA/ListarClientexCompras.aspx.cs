using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ListarClientexCompras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("IdCompra");
            dt.Columns.Add("Fecha");
            dt.Columns.Add("Monto");
            dt.Columns.Add("Comprobante");
            dt.Columns.Add("Empleado");

            // Agrega filas de prueba para ver el formato
            dt.Rows.Add("1", "12-05-2025", "1000.00", "73024207", "Ferro");
            dt.Rows.Add("2", "12-05-2025", "1000.00", "73024207", "Ferro");
            dt.Rows.Add("3", "12-05-2025", "1000.00", "73024207", "Ferro");

            gvCompras.DataSource = dt;
            gvCompras.DataBind();
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {

        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }

        protected void lkRegresar_Click(object sender, EventArgs e)
        {

        }
    }
}