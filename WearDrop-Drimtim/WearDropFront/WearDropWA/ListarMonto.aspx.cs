using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.PromocionConjunto;

namespace WearDropWA
{
    public partial class ListarMonto : System.Web.UI.Page
    {
        private DescuentoMontoWSClient boDesc;
        private BindingList<descuentoMonto> descuentos;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            if (!IsPostBack)
            {
                Session["Ultima Página"] = null;
            }
            boDesc = new DescuentoMontoWSClient();
            try
            {
                descuentos = new BindingList<descuentoMonto>(boDesc.mostrar_descuentosmontosactivos());
                gvMonto.DataSource = descuentos;
                gvMonto.DataBind();
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
            Response.Redirect("RegistrarMonto.aspx");
        }

       
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idProm = Int32.Parse(btn.CommandArgument);

                // Extraer de la lista de Almacenes el almacén seleccionado por el usuario
                descuentoMonto datDesc = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datDesc != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datDesc;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect($"ModificarMonto.aspx?id={idProm}");
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
                descuentoMonto datProm = descuentos.SingleOrDefault(x => x.idDescuento == idProm);

                if (datProm != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["descuentoSeleccionado"] = datProm;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect("MostrarDescuentoMonto.aspx");
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
        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            int idDesc;
            try { 
            if (string.IsNullOrEmpty(hfIdDescuentoEliminar.Value))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('No se ha seleccionado un descuento para eliminar.'); cerrarModal();", true);
                return;
            }

            idDesc = int.Parse(hfIdDescuentoEliminar.Value);

            int resultado = boDesc.eliminarDescuentoMonto(idDesc);

            if (resultado > 0)
            {
                // Eliminación exitosa
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Descuento eliminado correctamente.'); cerrarModal(); window.location='ListarMonto.aspx';", true);
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
    }
}