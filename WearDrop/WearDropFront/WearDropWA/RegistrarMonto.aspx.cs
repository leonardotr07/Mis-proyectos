using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class RegistrarMonto : System.Web.UI.Page
    {
        private DescuentoMontoWSClient boDesc;
        private descuentoMonto desc;
        private VigenciaWS.vigencia vig;
        private VigenciaWSClient boVig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boVig = new VigenciaWSClient();
            boDesc = new DescuentoMontoWSClient();
            desc = new descuentoMonto();
            vig = new VigenciaWS.vigencia();

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarMonto.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

            vig.fechaFin = DateTime.Parse(txtFechaFinMonto.Text);
            vig.fechaInicio = DateTime.Parse(txtFechaIniMonto.Text);
            vig.idVigencia = 7;
            vig.fechaFinSpecified = true;
            vig.fechaInicioSpecified = true;
            if (vig.fechaFin < vig.fechaInicio)
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
                if (float.Parse(txtMontoEditable.Text) > float.Parse(txtMontoMaximo.Text))
                {
                    ScriptManager.RegisterStartupScript(
           this,
           GetType(),
           "errorCantidades",
           "alert('El monto editable debe ser menor al monto Máximo. Corrige los valores.');",
           true
       );
                }
                else
                {
                    desc.idDescuento = 1;
                    desc.nombre = txtNombre.Text.Trim();
                    var vigFromWS = boVig.obtenerVigenciaPorId(resul);
                    var nuevaVig = new DescuentoMontoWS.vigencia();
                    nuevaVig.fechaInicio = vigFromWS.fechaInicio;
                    nuevaVig.fechaFin = vigFromWS.fechaFin;
                    nuevaVig.idVigencia = vigFromWS.idVigencia;

                    // SI TIENEN Specified
                    nuevaVig.fechaInicioSpecified = true;
                    nuevaVig.fechaFinSpecified = true;
                    desc.montoEditable = float.Parse(txtMontoEditable.Text);
                    desc.montoMaximo = float.Parse(txtMontoMaximo.Text);
                    desc.vigencia = new DescuentoMontoWS.vigencia();
                    desc.vigencia.idVigencia = resul;
                    desc.vigencia = nuevaVig;
                    int resultado = boDesc.insertarDescuentoMonto(desc);
                    if (resultado > 0)
                    {
                        // Modificación exitosa
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Descuento registrado correctamente.'); window.location='ListarMonto.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No se pudo registrar el descuento. Ocurrio un error.');", true);
                    }
                }
            }
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaMonto.aspx");
        }
      

    }
}