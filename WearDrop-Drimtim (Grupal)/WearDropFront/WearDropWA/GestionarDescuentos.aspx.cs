using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class GestionarDescuentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        // Este método se ejecuta cuando se hace clic en el botón "Registrar Descuento"
        protected void btnLiquidacion_ServerClick(object sender, EventArgs e)
        {
            // Redirige a la página de Liquidación
            Response.Redirect("ListarLiquidacion.aspx");
        }

        // Redirige a la página de Porcentaje
        protected void btnPorcentaje_ServerClick(object sender, EventArgs e)
        {
            // Redirige a la página de Porcentaje
            Response.Redirect("ListarPorcentaje.aspx");
        }

        // Redirige a la página de Monto
        protected void btnMonto_ServerClick(object sender, EventArgs e)
        {
            // Redirige a la página de Monto
            Response.Redirect("ListarMonto.aspx");
        }
    }
}