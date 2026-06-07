using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.PromocionConjunto;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{
    public partial class ModificarConjunto : System.Web.UI.Page
    {
        PromocionConjuntoWSClient boProm;
        promocionConjunto prom;
        VigenciaWSClient boVig;
        VigenciaWS.vigencia vig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boVig = new VigenciaWSClient();
            boProm = new PromocionConjuntoWSClient();
            if (!IsPostBack)
            {
                // Obtener el almacén de la sesión
                prom = (promocionConjunto)Session["promocionSeleccionada"];

                if (prom != null)
                {
                    // Cargar los datos en los controles
                    txtNombre.Text = prom.nombre;
                    txtPorcentajePromocion.Text = prom.porcentajePromocion.ToString();
                }
                else
                {
                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarConjunto.aspx");
                }
            }
        }
        protected void btnModificar_Click1(object sender, EventArgs e)
        {
            try
            {
                // Obtener el almacén de la sesión
                prom = (promocionConjunto)Session["promocionSeleccionada"];

                if (prom != null)
                {
                    // Actualizar los datos del almacén con los valores del formulario
                    prom.nombre = txtNombre.Text.Trim();
                    prom.porcentajePromocion = int.Parse(txtPorcentajePromocion.Text);
                    prom.vigencia = new PromocionConjunto.vigencia();
                    VigenciaWS.vigencia vig = boVig.obtenerVigenciaPorId(1);
                    prom.vigencia.idVigencia = vig.idVigencia;


                    // Llamar al método modificar del servicio
                    int resultado = boProm.modificarPromocionConjunto(prom);

                    if (resultado > 0)
                    {
                        // Modificación exitosa
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Promocion modificada correctamente.'); window.location='ListarConjunto.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No se pudo modificar la promocion.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al modificar: {ex.Message}');", true);
            }
            finally
            {
                if (boProm != null)
                {
                    boProm.Close();
                }
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarConjunto.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            prom = (promocionConjunto)Session["promocionSeleccionada"];
            if (prom != null)
            {

                Response.Redirect($"SeleccionarPrendaConjunto.aspx?idProm={prom.idPromocion}");
            }
        }
    }
}