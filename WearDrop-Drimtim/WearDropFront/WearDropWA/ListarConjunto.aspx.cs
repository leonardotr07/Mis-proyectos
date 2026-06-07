using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.PromocionConjunto;
namespace WearDropWA
{
    public partial class ListarConjunto : System.Web.UI.Page
    {
        private PromocionConjuntoWSClient boProm;
        private BindingList<promocionConjunto> promociones;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            if (!IsPostBack)
            {
                Session["UltimaPagina"] = null;
            }
            boProm = new PromocionConjuntoWSClient();

            try
            {
                promociones = new BindingList<promocionConjunto>(boProm.mostrar_promocionesconjuntoactivos());
                gvConjunto.DataSource = promociones;
                gvConjunto.DataBind();
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
            Response.Redirect("RegistrarConjunto.aspx");
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

                int resultado = boProm.eliminarPromocionConjunto(idDesc);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Promocion eliminada correctamente.'); cerrarModal(); window.location='ListarConjunto.aspx';", true);
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
            Response.Redirect("ModificarConjunto.aspx");
        }
        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idProm = int.Parse(btn.CommandArgument);
                promocionConjunto datProm = promociones.SingleOrDefault(x => x.idPromocion == idProm);

                if (datProm != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["promocionSeleccionada"] = datProm;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect("MostrarPromocionConjunto.aspx");
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