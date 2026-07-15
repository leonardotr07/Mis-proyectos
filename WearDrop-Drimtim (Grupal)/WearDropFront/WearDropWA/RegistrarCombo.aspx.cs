using System;
using System.Web.UI;
using WearDropWA.PromocionComboWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class RegistrarCombo : System.Web.UI.Page
    {
        private PromocionComboWSClient boProm;
        private promocionCombo prom;
        private VigenciaWS.vigencia vig;
        private VigenciaWSClient boVig;

        protected void Page_Load(object sender, EventArgs e)
        {
            boProm=new PromocionComboWSClient();
            prom=new promocionCombo();
            vig=new VigenciaWS.vigencia();
            boVig=new VigenciaWSClient();

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
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
                vig.fechaInicioSpecified = true;
                vig.fechaFinSpecified = true;
                vig.idVigencia = 7;
                int resul = boVig.insertarVigencia(vig);

                if (int.Parse(txtCantidadGratis.Text) > int.Parse(txtCantidadRequerida.Text))
                {
                    ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "errorCantidades",
            "alert('La cantidad gratis debe ser MENOR que la cantidad requerida. Corrige los valores.');",
            true
        );
                }
                else
                {
                    prom.cantidadGratis = int.Parse(txtCantidadGratis.Text);
                    prom.cantidadRequerida = int.Parse(txtCantidadRequerida.Text);

                    prom.nombre = txtNombre.Text.Trim();
                    prom.idPromocion = 1;//*por defecto*//
                    prom.vigencia = new PromocionComboWS.vigencia();
                    prom.vigencia.idVigencia = resul;
                    var vigFromWS = boVig.obtenerVigenciaPorId(resul);
                    var nuevaVig = new PromocionComboWS.vigencia();
                    nuevaVig.fechaInicio = vigFromWS.fechaInicio;
                    nuevaVig.fechaFin = vigFromWS.fechaFin;
                    nuevaVig.idVigencia = vigFromWS.idVigencia;

                    // SI TIENEN Specified
                    nuevaVig.fechaInicioSpecified = true;
                    nuevaVig.fechaFinSpecified = true;
                    int resultado = boProm.insertarPromocionCombo(prom);
                    if (resultado > 0)
                    {
                        // Modificación exitosa
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Promocion registrada correctamente.'); window.location='ListarCombo.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No se pudo registrar la promoción. Ocurrio un error.');", true);
                    }
                }
            }
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaCombo.aspx");
        }
       

    }
}