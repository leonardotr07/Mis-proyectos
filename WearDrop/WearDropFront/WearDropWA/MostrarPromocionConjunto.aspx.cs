using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.PromocionConjunto;

namespace WearDropWA
{
    public partial class MostrarPromocionConjunto : System.Web.UI.Page
    {
        private PromocionConjuntoWSClient boProm;
        private promocionConjunto datProm;
        protected void Page_Load(object sender, EventArgs e)
        {
            datProm = (promocionConjunto)Session["promocionSeleccionada"];
            if (!IsPostBack)
            {

                AsignarValores();
                txtNombre.Enabled = false;
                txtIdPromocion.Enabled = false;
                txtPorcentaje.Enabled = false;
            }
        }
        void AsignarValores()
        {
            txtPorcentaje.Text = datProm.porcentajePromocion.ToString();
            txtNombre.Text = datProm.nombre;
            txtIdPromocion.Text = datProm.idPromocion.ToString();
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarConjunto.aspx");
        }
    }
}