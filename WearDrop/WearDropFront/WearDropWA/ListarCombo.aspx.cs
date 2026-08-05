using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.PromocionComboWS;

namespace WearDropWA
{
    public partial class ListarCombo : System.Web.UI.Page
    {
        private PromocionComboWSClient boProm;
        private BindingList<promocionCombo> promociones;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["UltimaPagina"] = null;
            }
            boProm = new PromocionComboWSClient();
            try
            {
                promociones = new BindingList<promocionCombo>(boProm.mostrar_promocionescomboactivo());
                gvMonto.DataSource = promociones;
                promocionCombo prom = new promocionCombo();

                gvMonto.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar las promociones: {ex.Message}');", true);
            }
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }
        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCombo.aspx");
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            int idDesc;
            try
            {
                if (string.IsNullOrEmpty(hfIdPromocionEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado una promocion para eliminar.'); cerrarModal();", true);
                    return;
                }

                idDesc = int.Parse(hfIdPromocionEliminar.Value);

                int resultado = boProm.eliminarPromocionCombo(idDesc);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Promocion eliminada correctamente.'); cerrarModal(); window.location='ListarCombo.aspx';", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar la promocion. Ocurrió un error.'); cerrarModal();", true);
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
                promocionCombo datProm = promociones.SingleOrDefault(x => x.idPromocion == idProm);

                if (datProm != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["promocionSeleccionada"] = datProm;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect($"ModificarCombo.aspx?id={idProm}");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró la promocion seleccionada.');", true);
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
            try { 
            LinkButton btn = (LinkButton)sender;
            int idProm = int.Parse(btn.CommandArgument);
            promocionCombo datProm = promociones.SingleOrDefault(x => x.idPromocion == idProm);

            if (datProm != null)
            {
                // Guardar el almacén seleccionado en la sesión
                Session["promocionSeleccionada"] = datProm;

                // Redirigir a la página de modificación con el ID como parámetro
                Response.Redirect("MostrarPromocionCombo.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('No se encontró la promocion seleccionada.');", true);
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