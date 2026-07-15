using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoMontoWS;

namespace WearDropWA
{
    public partial class MostrarDescuentoMonto : System.Web.UI.Page
    {
        private DescuentoMontoWSClient boDesc;
        private descuentoMonto datDesc;
        protected void Page_Load(object sender, EventArgs e)
        {
            datDesc = (descuentoMonto)Session["descuentoSeleccionado"];
            if (!IsPostBack)
            {

                AsignarValores();
               txtNombre.Enabled = false;
                txtIdDescuento.Enabled = false;
                txtMontoEditable.Enabled = false;
                txtMontoMáximo.Enabled = false;
            }

        }
        void AsignarValores()
        {
            txtIdDescuento.Text = datDesc.idDescuento.ToString();
            txtMontoEditable.Text = datDesc.montoEditable.ToString();
            txtMontoMáximo.Text = datDesc.montoMaximo.ToString();
            txtNombre.Text = datDesc.nombre;
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarMonto.aspx");
        }
    }

}