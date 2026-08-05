using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoPorcentajeWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class RegistrarPorcentaje : System.Web.UI.Page
    {
        private DescuentoPorcentajeWSClient boDesc;
        private descuentoPorcentaje desc;
        private VigenciaWSClient boVig;
        private VigenciaWS.vigencia vig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boDesc=new DescuentoPorcentajeWSClient();
            desc = new descuentoPorcentaje();
            boVig=new VigenciaWSClient();
            vig = new VigenciaWS.vigencia();
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarPorcentaje.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            vig.fechaFin = DateTime.Parse(txtFechaFinPor.Text);
            vig.fechaInicio = DateTime.Parse(txtFechaIniPor.Text);
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
                var vigFromWS = boVig.obtenerVigenciaPorId(resul);
                var nuevaVig = new DescuentoPorcentajeWS.vigencia();

                nuevaVig.fechaInicio = vigFromWS.fechaInicio;
                nuevaVig.fechaFin = vigFromWS.fechaFin;
                nuevaVig.idVigencia = vigFromWS.idVigencia;

                // SI TIENEN Specified
                nuevaVig.fechaInicioSpecified = true;
                nuevaVig.fechaFinSpecified = true;
                desc.idDescuento = 1;
                desc.nombre = txtNombrePor.Text.Trim();
                desc.porcentaje = float.Parse(txtPorcentajePor.Text);
                desc.vigencia = new DescuentoPorcentajeWS.vigencia();
                desc.vigencia = nuevaVig;
                desc.vigencia.idVigencia = resul;
                int resultado = boDesc.insertarDescuento(desc);
                if (resultado > 0)
                {
                    // Modificación exitosa
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Descuento registrado correctamente.'); window.location='ListarPorcentaje.aspx';", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('No se pudo registrar el descuento. Ocurrio un error.');", true);
                }
            }
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaPorcentaje.aspx");
        }
        

    }
}