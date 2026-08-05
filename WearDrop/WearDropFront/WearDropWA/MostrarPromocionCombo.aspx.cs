using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class MostrarPromocionCombo : System.Web.UI.Page
    {
        private PromocionComboWSClient boProm;
        private promocionCombo datProm; 
        protected void Page_Load(object sender, EventArgs e)
        {
            datProm = (promocionCombo)Session["promocionSeleccionada"];
            if (!IsPostBack)
            {

                AsignarValores();
                txtIdPromocion.Enabled = false;
                txtNombre.Enabled = false;
                txtCantidadGratis.Enabled = false;
                txtNombre.Enabled = false;
                txtCantidadRequerida.Enabled = false;
                txtCantidadRequerida.Enabled = false;
            }

        }
        void AsignarValores()
        {
            txtCantidadGratis.Text=datProm.cantidadGratis.ToString();
            txtCantidadRequerida.Text = datProm.cantidadRequerida.ToString();
            txtIdPromocion.Text=datProm.idPromocion.ToString();
            txtNombre.Text = datProm.nombre;
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }
    }
}