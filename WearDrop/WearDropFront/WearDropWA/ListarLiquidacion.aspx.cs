using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.DescuentoPorcentajeWS;
namespace WearDropWA
{
    public partial class ListarLiquidacion : System.Web.UI.Page
    {
        private DescuentoLiquidacionWSClient boDesc;
        private BindingList<DescuentoLiquidacionWS.descuentoLiquidacion> descuentos;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["Ultima Página"] = null;
            }
            boDesc=new DescuentoLiquidacionWSClient();
            try
            {
                descuentos = new BindingList<DescuentoLiquidacionWS.descuentoLiquidacion>(boDesc.mostrar_descuentosliquidacionactivos());
                gvLiquidaciones.DataSource = descuentos;
                gvLiquidaciones.DataBind();
            }
            catch(Exception ex) 
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                   $"alert('Error al cargar los descuentos: {ex.Message}');", true);
            }
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }
        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarLiquidacion.aspx");
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            int idDesc;
            try
            {
                if (string.IsNullOrEmpty(hfIdDescuentoEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado un descuento para eliminar.'); cerrarModal();", true);
                    return;
                }

                idDesc = int.Parse(hfIdDescuentoEliminar.Value);

                int resultado = boDesc.eliminarDescuentoLiquidacion(idDesc);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Descuento eliminado correctamente.'); cerrarModal(); window.location='ListarLiquidacion.aspx';", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar el descuento. Ocurrió un error.'); cerrarModal();", true);
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModal();", true);
            }
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idProm = Int32.Parse(btn.CommandArgument);

                // Extraer de la lista de Almacenes el almacén seleccionado por el usuario
                descuentoLiquidacion datDesc = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datDesc != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datDesc;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect($"ModificarLiquidacion.aspx?id={idProm}");
                    // Redirigir a la página de modificación con el ID como parámetro

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró el descuento seleccionado.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al modificar: {ex.Message}');", true);
            }
        }
        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idProm = int.Parse(btn.CommandArgument);
                DescuentoLiquidacionWS.descuentoLiquidacion datProm = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datProm != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datProm;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect("MostrarDescuentoLiquidacion.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró el descuento seleccionada.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al visualizar: {ex.Message}');", true);
            }
        }
    }
}