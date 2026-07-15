using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.VigenciaWS;
namespace WearDropWA
{

    public partial class ModificarCombo : System.Web.UI.Page
    {
        PromocionComboWSClient boProm;
        promocionCombo prom;
        VigenciaWSClient boVig;
        protected void Page_Load(object sender, EventArgs e)
        {
            boVig=new VigenciaWSClient();
            boProm = new PromocionComboWSClient();
            if (!IsPostBack)
            {
                // Obtener el almacén de la sesión
                prom = (promocionCombo)Session["promocionSeleccionada"];

                if (prom != null)
                {
                    // Cargar los datos en los controles
                    txtNombre.Text = prom.nombre;
                    txtCantidadGratis.Text = prom.cantidadGratis.ToString();
                    txtCantidadRequerida.Text = prom.cantidadRequerida.ToString();
                }
                else
                {
                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarCombo.aspx");
                }
            }
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            // Lógica para modificar el almacén
            //string nombreAlmacen = txtNombreAlmacen.Text;
            //string direccionAlmacen = txtDireccionAlmacen.Text;
            // Aquí se podría agregar la lógica para actualizar el almacén en la base de datos
            // Redirigir a la página de listar almacenes después de modificar
            try
            {
                // Obtener el almacén de la sesión
                prom = (promocionCombo)Session["promocionSeleccionada"];

                if (prom != null)
                {
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
                        // Actualizar los datos del almacén con los valores del formulario
                        prom.nombre = txtNombre.Text.Trim();
                        prom.cantidadRequerida = int.Parse(txtCantidadRequerida.Text);
                        prom.cantidadGratis = int.Parse(txtCantidadGratis.Text);
                        prom.vigencia = new PromocionComboWS.vigencia();
                        VigenciaWS.vigencia vig = boVig.obtenerVigenciaPorId(1);
                        prom.vigencia.idVigencia = vig.idVigencia;


                        // Llamar al método modificar del servicio
                        int resultado = boProm.modificarPromocionCombo(prom);

                        if (resultado > 0)
                        {
                            // Modificación exitosa
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('Promocion modificada correctamente.'); window.location='ListarCombo.aspx';", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('No se pudo modificar la promocion.');", true);
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
                if (boProm != null)
                {
                    boProm.Close();
                }
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {
            prom = (promocionCombo)Session["promocionSeleccionada"];
            if (prom != null)
            {

                Response.Redirect($"SeleccionarPrendaCombo.aspx?idProm={prom.idPromocion}");
            }
        }
    }
}