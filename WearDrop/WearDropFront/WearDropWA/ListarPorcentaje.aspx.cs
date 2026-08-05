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
    public partial class ListarPorcentaje : System.Web.UI.Page
    {
        private DescuentoPorcentajeWSClient boDesc;
        private BindingList<descuentoPorcentaje> descuentos;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            if (!IsPostBack)
            {
                Session["Última página"] = null;
            }
            boDesc = new DescuentoPorcentajeWSClient();
            try
            {
                descuentos = new BindingList<descuentoPorcentaje>(boDesc.mostrar_descuentosporcentajeactivos());
                gvPorcentajes.DataSource = descuentos;
                gvPorcentajes.DataBind();
            }
            catch (Exception ex)
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
            Response.Redirect("RegistrarPorcentaje.aspx");
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

                int resultado = boDesc.eliminarDescuentoPorcentaje(idDesc);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Descuento eliminado correctamente.'); cerrarModal(); window.location='ListarPorcentaje.aspx';", true);
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
                descuentoPorcentaje datDesc = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datDesc != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datDesc;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect($"ModificarPorcentaje.aspx?id={idProm}");
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
                descuentoPorcentaje datProm = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datProm != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datProm;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect("MostrarDescuentoPorcentaje.aspx");
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