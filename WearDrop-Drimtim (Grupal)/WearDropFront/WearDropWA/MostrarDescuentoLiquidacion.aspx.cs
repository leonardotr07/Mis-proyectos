using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;

namespace WearDropWA
{
    public partial class MostrarDescuentoLiquidacion : System.Web.UI.Page
    {
        private DescuentoLiquidacionWSClient boDesc;
        private descuentoLiquidacion datDesc;
        protected void Page_Load(object sender, EventArgs e)
        {
            datDesc = (descuentoLiquidacion)Session["descuentoSeleccionado"];
            if (!IsPostBack)
            {

                AsignarValores();
                txtNombre.Enabled = false;
                txtIdDescuento.Enabled = false;
                txtCondicion.Enabled = false;
                txtPorcentaje.Enabled = false;
            }

        }
        void AsignarValores()
        {
            txtIdDescuento.Text = datDesc.idDescuento.ToString();
            txtCondicion.Text = datDesc.condicionStockMin.ToString();
            txtPorcentaje.Text = datDesc.porcentajeLiquidacion.ToString();
            txtNombre.Text = datDesc.nombre;
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }
    }
}