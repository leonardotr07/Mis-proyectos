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
using WearDropWA.VigenciaWS;

namespace WearDropWA
{
    public partial class ModificarMonto : System.Web.UI.Page
    {
    private DescuentoMontoWSClient boDesc;
    private descuentoMonto desc;
    private VigenciaWS.vigencia vig;
    private VigenciaWSClient boVig;
    protected void Page_Load(object sender, EventArgs e)
    {
        boDesc = new DescuentoMontoWSClient();
        boVig = new VigenciaWSClient();
        if (!IsPostBack)
        { 
            // Obtener el almacén de la sesión
            desc = (descuentoMonto)Session["descuentoSeleccionado"];
            
                if (desc != null)
                {
                    txtNombre.Text = desc.nombre;
                    txtMontoEditable.Text = desc.montoEditable.ToString();
                    txtMontoMaximo.Text = desc.montoMaximo.ToString();
                }

                else
                {

                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarMonto.aspx");
                }
            }

    }

   

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el almacén de la sesión
                desc = (descuentoMonto)Session["descuentoSeleccionado"];

                if (desc != null)
                {
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
                        // Actualizar los datos del almacén con los valores del formulario
                        desc.nombre = txtNombre.Text.Trim();
                        desc.montoMaximo = float.Parse(txtMontoMaximo.Text);
                        desc.montoEditable = float.Parse(txtMontoEditable.Text);
                        desc.vigencia = new DescuentoMontoWS.vigencia();
                        VigenciaWS.vigencia vig = boVig.obtenerVigenciaPorId(1);
                        desc.vigencia.idVigencia = vig.idVigencia;

                        // Llamar al método modificar del servicio
                        int resultado = boDesc.modificarDescuentoMonto(desc);

                        if (resultado > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                                      "alert('Se pudo modificar el descuento.'); window.location = 'ListarMonto.aspx';", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('No se pudo modificar el descuento.');", true);
                        }
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
            Response.Redirect("ListarMonto.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            desc = (descuentoMonto)Session["descuentoSeleccionado"];
            if (desc != null)
            {

                Response.Redirect($"SeleccionarPrendaMonto.aspx?idDesc={desc.idDescuento}");
            }
        }
    }
}