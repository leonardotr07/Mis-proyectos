using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.DescuentoPorcentajeWS;

namespace WearDropWA
{
    public partial class MostrarDescuentoPorcentaje : System.Web.UI.Page
    {
        private DescuentoPorcentajeWSClient boDesc;
        private descuentoPorcentaje datDesc;
        protected void Page_Load(object sender, EventArgs e)
        {
            datDesc = (descuentoPorcentaje)Session["descuentoSeleccionado"];
            if (!IsPostBack)
            {

                AsignarValores();
                txtNombre.Enabled = false;
                txtIdDescuento.Enabled = false;
                txtPorcentaje.Enabled = false;
            }

        }
        void AsignarValores()
        {
            txtIdDescuento.Text = datDesc.idDescuento.ToString();
            txtPorcentaje.Text = datDesc.porcentaje.ToString();
            txtNombre.Text = datDesc.nombre;
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarPorcentaje.aspx");
        }
    }
}