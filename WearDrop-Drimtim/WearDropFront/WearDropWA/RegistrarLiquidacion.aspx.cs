using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class RegistrarLiquidacion : System.Web.UI.Page
    {
        private DescuentoLiquidacionWSClient boDesc;
        private descuentoLiquidacion desc;
        private VigenciaWS.vigencia vig;
        private VigenciaWSClient boVig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boDesc=new DescuentoLiquidacionWSClient();
            desc=new descuentoLiquidacion();
           boVig=new VigenciaWSClient();
            vig=new VigenciaWS.vigencia();
            
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            vig.fechaFin = DateTime.Parse(txtFechaFin.Text);
            vig.fechaInicio = DateTime.Parse(txtFechaIni.Text);
            vig.idVigencia = 7;
            vig.fechaInicioSpecified = true;
            vig.fechaFinSpecified = true;
            if (vig.fechaInicio > vig.fechaFin)
            {

                ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "errorFechas",
            "alert('La fecha de inicio debe ser menor que la fecha de fin.');",
            true);

            }
            else
            {
                
                int resul = boVig.insertarVigencia(vig);
                desc.idDescuento = 1;
                desc.nombre = txtNombre.Text.Trim();
                desc.porcentajeLiquidacion = float.Parse(txtPorcentajeLiq.Text);
                desc.condicionStockMin = int.Parse(txtCondicion.Text);
                desc.vigencia = new DescuentoLiquidacionWS.vigencia();
                var vigWs = boVig.obtenerVigenciaPorId(resul);
                var nuevaVig = new DescuentoLiquidacionWS.vigencia();
                nuevaVig.fechaInicio = vigWs.fechaInicio;
                nuevaVig.fechaFin = vigWs.fechaFin;
                nuevaVig.idVigencia = vigWs.idVigencia;

                // SI TIENEN Specified
                nuevaVig.fechaInicioSpecified = true;
                nuevaVig.fechaFinSpecified = true;
                desc.vigencia = nuevaVig;
                desc.vigencia.idVigencia = resul;
                int resultado = boDesc.insertarDescuentoLiquidacion(desc);
                if (resultado > 0)
                {
                    // Modificación exitosa
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Descuento registrado correctamente.'); window.location='ListarLiquidacion.aspx';", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('No se pudo registrar el descuento. Ocurrio un error.');", true);
                }
            }
        }
        

    }
}