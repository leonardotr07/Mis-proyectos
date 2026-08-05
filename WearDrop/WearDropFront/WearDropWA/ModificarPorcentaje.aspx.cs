using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.DescuentoPorcentajeWS;
using WearDropWA.VigenciaWS;

namespace WearDropWA
{
    public partial class ModificarPorcentaje : System.Web.UI.Page
    {
        private DescuentoPorcentajeWSClient boDesc;
        private descuentoPorcentaje desc;
        private VigenciaWS.vigencia vig;
        private VigenciaWSClient boVig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boDesc = new DescuentoPorcentajeWSClient();
            boVig = new VigenciaWSClient();
            if (!IsPostBack)
            {
                // Obtener el almacén de la sesión
                desc = (descuentoPorcentaje)Session["descuentoSeleccionado"];

                if (desc != null)
                {
                    txtNombrePor.Text = desc.nombre;
                    txtPorcentajePromocion.Text = desc.porcentaje.ToString();
                }

                else
                {

                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarPorcentaje.aspx");
                }
            }
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el almacén de la sesión
                desc = (descuentoPorcentaje)Session["descuentoSeleccionado"];

                if (desc != null)
                {
                    // Actualizar los datos del almacén con los valores del formulario
                    desc.nombre = txtNombrePor.Text.Trim();
                    desc.porcentaje = float.Parse(txtPorcentajePromocion.Text);
                    desc.vigencia = new DescuentoPorcentajeWS.vigencia();
                    VigenciaWS.vigencia vig = boVig.obtenerVigenciaPorId(1);
                    desc.vigencia.idVigencia = vig.idVigencia;

                    // Llamar al método modificar del servicio
                    int resultado = boDesc.modificarDescuentoPorcentaje(desc);

                    if (resultado > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                                  "alert('Se pudo modificar el descuento.'); window.location = 'ListarPorcentaje.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No se pudo modificar el descuento.');", true);
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
                if (boDesc != null)
                {
                    boDesc.Close();
                }
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarPorcentaje.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            desc = (descuentoPorcentaje)Session["descuentoSeleccionado"];
            if (desc != null)
            {

                Response.Redirect($"SeleccionarPrendaPorcentaje.aspx?idDesc={desc.idDescuento}");
            }
        }
    }
}