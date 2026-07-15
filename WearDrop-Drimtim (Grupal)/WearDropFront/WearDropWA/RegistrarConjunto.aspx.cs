using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionConjunto;
using WearDropWA.VigenciaWS;

namespace WearDropWA
{
    public partial class RegistrarConjunto : System.Web.UI.Page
    {
        private PromocionConjuntoWSClient boProm;
        private VigenciaWSClient boVig;
        private promocionConjunto prom;
        private VigenciaWS.vigencia vig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boProm=new PromocionConjuntoWSClient();
            boVig=new VigenciaWSClient();
            prom=new promocionConjunto();
            vig=new VigenciaWS.vigencia();

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarConjunto.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

            //}
            vig.fechaFin = DateTime.Parse(txtFechaFin.Text);
            vig.fechaInicio = DateTime.Parse(txtFechaIni.Text);
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
                vig.idVigencia = 7;
                vig.fechaFinSpecified = true;
                vig.fechaInicioSpecified = true;
                int resul = boVig.insertarVigencia(vig);


                prom.nombre = txtNombre.Text.Trim();
                prom.porcentajePromocion = float.Parse(txtPorcentajePromocion.Text);
                prom.idPromocion = 1;
                prom.vigencia = new PromocionConjunto.vigencia();
                var vigWS = boVig.obtenerVigenciaPorId(resul);
                var nuevaVig = new PromocionConjunto.vigencia();
                nuevaVig.fechaInicio = vigWS.fechaInicio;
                nuevaVig.fechaFin = vigWS.fechaFin;
                nuevaVig.idVigencia = vigWS.idVigencia;

                // SI TIENEN Specified
                nuevaVig.fechaInicioSpecified = true;
                nuevaVig.fechaFinSpecified = true;
                prom.vigencia.idVigencia = resul;
                prom.vigencia = nuevaVig;
                int resultado = boProm.insertarPromocionConjunto(prom);
                if (resultado > 0)
                {
                    // Modificación exitosa
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Promocion registrada correctamente.'); window.location='ListarConjunto.aspx';", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('No se pudo registrar la promoción. Ocurrio un error.');", true);
                }
            }
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaConjunto.aspx");
        }
       
    }
}