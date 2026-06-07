using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.PromocionComboWS;
using WearDropWA.VigenciaWS;

namespace WearDropWA
{
    public partial class ModificarLiquidacion : System.Web.UI.Page
    {
        private DescuentoLiquidacionWSClient boDesc;
        private descuentoLiquidacion desc;
        private VigenciaWS.vigencia vig;
        private VigenciaWSClient boVig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boDesc = new DescuentoLiquidacionWSClient();
            boVig = new VigenciaWSClient();
            if (!IsPostBack)
            {
                // Obtener el almacén de la sesión
                desc = (descuentoLiquidacion)Session["descuentoSeleccionado"];

                if (desc != null)
                {
                    txtNombre.Text = desc.nombre;
                    txtPorcentajeLiq.Text = desc.porcentajeLiquidacion.ToString();
                    txtCondicion.Text = desc.condicionStockMin.ToString();
                }

                else
                {

                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarLiquidacion.aspx");
                }
            }

        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el almacén de la sesión
                desc = (descuentoLiquidacion)Session["descuentoSeleccionado"];

                if (desc != null)
                {
                    // Actualizar los datos del almacén con los valores del formulario
                    desc.nombre = txtNombre.Text.Trim();
                    desc.porcentajeLiquidacion = float.Parse(txtPorcentajeLiq.Text);
                    desc.condicionStockMin = int.Parse(txtCondicion.Text);
                    desc.vigencia = new DescuentoLiquidacionWS.vigencia();
                    VigenciaWS.vigencia vig = boVig.obtenerVigenciaPorId(1);
                    desc.vigencia.idVigencia = vig.idVigencia;

                    // Llamar al método modificar del servicio
                    int resultado = boDesc.modificarDecuentoLiquidacion(desc);

                    if (resultado > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                                  "alert('Se pudo modificar el descuento.'); window.location = 'ListarLiquidacion.aspx';", true);
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
            Response.Redirect("ListarLiquidacion.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            desc = (descuentoLiquidacion)Session["descuentoSeleccionado"];
            if (desc != null)
            {

                Response.Redirect($"SeleccionarPrendaLiquidacion.aspx?idDesc={desc.idDescuento}");
            }
        }
    }
}