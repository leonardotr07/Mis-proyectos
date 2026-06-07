using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class GestionarPromociones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnConjunto.Visible = false;
        }
        protected void btnConjunto_ServerClick(object sender, EventArgs e)
        {
            // Redirige a la página de Liquidación
            Response.Redirect("ListarConjunto.aspx");
        }

        // Redirige a la página de Porcentaje
        protected void btnCombo_ServerClick(object sender, EventArgs e)
        {
            // Redirige a la página de Porcentaje
            Response.Redirect("ListarCombo.aspx");
        }

        // Redirige a la página de Monto

    }
}