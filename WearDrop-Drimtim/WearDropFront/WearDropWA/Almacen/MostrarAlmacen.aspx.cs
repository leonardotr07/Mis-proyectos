using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackageAlmacen;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class MostrarAlmacen : System.Web.UI.Page
    {
        private CuentaUsuarioWSClient boCuentaUsuario;
        private MovimientoAlmacenWSClient boMovimientoAlmacen;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovimientoAlmacenXLote;
        private almacen datAlmacen;

        // ✅ CORREGIDO: Propiedades simplificadas sin retornar lista vacía
        private BindingList<lote> listaLotes
        {
            get { return ViewState["listaLotes"] as BindingList<lote>; }
            set { ViewState["listaLotes"] = value; }
        }

        private BindingList<movimientoAlmacen> listaMovimientoAlmacen
        {
            get { return ViewState["listaMovimientoAlmacen"] as BindingList<movimientoAlmacen>; }
            set { ViewState["listaMovimientoAlmacen"] = value; }
        }

        private BindingList<movimientoAlmacenXLote> listaMovimientoAlmacenXLote
        {
            get { return ViewState["listaMovimientoAlmacenXLote"] as BindingList<movimientoAlmacenXLote>; }
            set { ViewState["listaMovimientoAlmacenXLote"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boCuentaUsuario = new CuentaUsuarioWSClient();
            boMovimientoAlmacen = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovimientoAlmacenXLote = new MovimientoAlmacenXLoteWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    datAlmacen = (almacen)Session["almacenSeleccionado"];

                    if (datAlmacen == null)
                    {
                        Response.Redirect("ListarAlmacenes.aspx");
                        return;
                    }

                    ViewState["AlmacenCompleto"] = datAlmacen;

                    string tabActiva = Session["UltimaPagina"]?.ToString() ?? "Lotes";
                    ViewState["TabActiva"] = tabActiva;

                    CargarDatosAlmacen();
                    CargarPestanaActiva(tabActiva);
                }
                else
                {
                    Response.Redirect("ListarAlmacenes.aspx");
                }
            }
            else
            {
                datAlmacen = (almacen)ViewState["AlmacenCompleto"];

                if (datAlmacen == null)
                {
                    datAlmacen = (almacen)Session["almacenSeleccionado"];

                    if (datAlmacen == null)
                    {
                        Response.Redirect("ListarAlmacenes.aspx");
                        return;
                    }
                }
            }
        }

        private void CargarDatosAlmacen()
        {
            txtId.Text = datAlmacen.id.ToString();
            txtNombre.Text = datAlmacen.nombre;
            txtUbicacion.Text = datAlmacen.ubicacion;
        }

        private void CargarPestanaActiva(string tabActiva)
        {
            switch (tabActiva)
            {
                case "Movimientos":
                    MostrarPanel(panelMovimientos);
                    ActualizarEstiloTab(tabMovimientos);
                    CargarMovimientos();
                    break;
                case "MovimientosXLote":
                    MostrarPanel(panelMovimientosXLotes);
                    ActualizarEstiloTab(tabMovimientosXLotes);
                    CargarMovimientosXLotes();
                    break;
                default: // "Lotes"
                    MostrarPanel(panelLotes);
                    ActualizarEstiloTab(tabLotes);
                    CargarLotes();
                    break;
            }
        }

        #region Manejo de Pestañas

        protected void tabLotes_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelLotes);
            ActualizarEstiloTab(tabLotes);

            Session["UltimaPagina"] = "Lotes";
            ViewState["TabActiva"] = "Lotes";

            // ✅ CORREGIDO: Verificar si es null o tiene datos
            if (listaLotes != null && listaLotes.Count > 0)
            {
                gvLotes.DataSource = listaLotes;
                gvLotes.DataBind();
            }
            else
            {
                CargarLotes();
            }
        }

        protected void tabMovimientos_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelMovimientos);
            ActualizarEstiloTab(tabMovimientos);

            Session["UltimaPagina"] = "Movimientos";
            ViewState["TabActiva"] = "Movimientos";

            // ✅ CORREGIDO: Verificar si es null o tiene datos
            if (listaMovimientoAlmacen != null && listaMovimientoAlmacen.Count > 0)
            {
                gvMovimientos.DataSource = listaMovimientoAlmacen;
                gvMovimientos.DataBind();
            }
            else
            {
                CargarMovimientos();
            }
        }

        protected void tabMovimientosXLotes_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelMovimientosXLotes);
            ActualizarEstiloTab(tabMovimientosXLotes);

            Session["UltimaPagina"] = "MovimientosXLote";
            ViewState["TabActiva"] = "MovimientosXLote";

            // ✅ CORREGIDO: Verificar si es null o tiene datos
            if (listaMovimientoAlmacenXLote != null && listaMovimientoAlmacenXLote.Count > 0)
            {
                gvMovimientosXLotes.DataSource = listaMovimientoAlmacenXLote;
                gvMovimientosXLotes.DataBind();
            }
            else
            {
                CargarMovimientosXLotes();
            }
        }

        private void MostrarPanel(Panel panelActivo)
        {
            panelLotes.Visible = false;
            panelMovimientos.Visible = false;
            panelMovimientosXLotes.Visible = false;
            panelActivo.Visible = true;
        }

        private void ActualizarEstiloTab(LinkButton tabActivo)
        {
            tabLotes.CssClass = "nav-link";
            tabMovimientos.CssClass = "nav-link";
            tabMovimientosXLotes.CssClass = "nav-link";
            tabActivo.CssClass = "nav-link active";
        }

        #endregion

        #region Carga de Datos

        private void CargarLotes()
        {
            try
            {
                listaLotes = new BindingList<lote>(boLote.listarLotesActivosPorAlmacen(datAlmacen.id));
                gvLotes.DataSource = listaLotes;
                gvLotes.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar lotes: {ex.Message}');", true);
            }
        }

        private void CargarMovimientos()
        {
            try
            {
                listaMovimientoAlmacen = new BindingList<movimientoAlmacen>(
                    boMovimientoAlmacen.listarMovimientosPorAlmacen(datAlmacen.id)
                );
                gvMovimientos.DataSource = listaMovimientoAlmacen;
                gvMovimientos.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar movimientos: {ex.Message}');", true);
            }
        }

        private void CargarMovimientosXLotes()
        {
            try
            {
                listaMovimientoAlmacenXLote = new BindingList<movimientoAlmacenXLote>(
                    boMovimientoAlmacenXLote.listarMovXLoteActivosPorAlmacen(datAlmacen.id)
                );

                gvMovimientosXLotes.DataSource = listaMovimientoAlmacenXLote;
                gvMovimientosXLotes.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar movimientos por lote: {ex.Message}');", true);
            }
        }

        #endregion

        #region Paginación

        protected void gvLotes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLotes.PageIndex = e.NewPageIndex;
            gvLotes.DataSource = listaLotes;
            gvLotes.DataBind();
        }

        protected void gvMovimientos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMovimientos.PageIndex = e.NewPageIndex;
            gvMovimientos.DataSource = listaMovimientoAlmacen;
            gvMovimientos.DataBind();
        }

        protected void gvMovimientosXLotes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMovimientosXLotes.PageIndex = e.NewPageIndex;
            gvMovimientosXLotes.DataSource = listaMovimientoAlmacenXLote;
            gvMovimientosXLotes.DataBind();
        }

        #endregion

        // ... resto de los métodos (sin cambios)

        #region Acciones de Lotes

        protected void btnModificarLote_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idLote = int.Parse(btn.CommandArgument);
            Response.Redirect($"Lote/ModificarLote.aspx?id={idLote}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Acciones de Movimientos

        protected void btnModificarMovimiento_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idMovimiento = int.Parse(btn.CommandArgument);
            Response.Redirect($"Movimiento/ModificarMovimiento.aspx?id={idMovimiento}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Acciones de Movimientos x Lotes

        protected void btnModificarMovimientoXLote_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idMovimiento = int.Parse(btn.CommandArgument);
            Response.Redirect($"MovimientoXLote/ModificarMovimientoXLote.aspx?id={idMovimiento}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Eliminación con Modal

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int idEliminar = int.Parse(hfIdEliminar.Value);
                string tipoEliminar = hfTipoEliminar.Value;

                switch (tipoEliminar)
                {
                    case "Lote":
                        int resultadoLote = boLote.eliminarLote(idEliminar);
                        if (resultadoLote > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Lote eliminado correctamente'); cerrarModal();", true);
                            CargarLotes();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el lote'); cerrarModal();", true);
                        }
                        break;

                    case "Movimiento":
                        int resultadoMovimiento = boMovimientoAlmacen.eliminarMovimientoAlmacen(idEliminar);
                        if (resultadoMovimiento > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Movimiento eliminado correctamente'); cerrarModal();", true);
                            CargarMovimientos();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el movimiento'); cerrarModal();", true);
                        }
                        break;

                    case "MovimientoXLote":
                        int resultadoMovXLote = boMovimientoAlmacenXLote.eliminarMovXLote(idEliminar);
                        if (resultadoMovXLote > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Movimiento por Lote eliminado correctamente'); cerrarModal();", true);
                            CargarMovimientosXLotes();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el movimiento por lote'); cerrarModal();", true);
                        }
                        break;

                    default:
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('Tipo de eliminación no reconocido'); cerrarModal();", true);
                        break;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModal();", true);
            }
        }

        #endregion

        #region Botones de Navegación

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            string tabActiva = ViewState["TabActiva"]?.ToString() ?? "Lotes";

            switch (tabActiva)
            {
                case "Lotes":
                    Response.Redirect($"Lote/RegistrarLote.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "Movimientos":
                    Response.Redirect($"Movimiento/RegistrarMovimiento.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "MovimientosXLote":
                    Response.Redirect($"MovimientoXLote/RegistrarMovimientoXLote.aspx?idAlmacen={datAlmacen.id}");
                    break;
            }
        }

        protected void lkRetroceder_Click(object sender, EventArgs e)
        {
            Session["UltimaPagina"] = null;
            Response.Redirect("ListarAlmacenes.aspx");
        }

        #endregion
    }
}
