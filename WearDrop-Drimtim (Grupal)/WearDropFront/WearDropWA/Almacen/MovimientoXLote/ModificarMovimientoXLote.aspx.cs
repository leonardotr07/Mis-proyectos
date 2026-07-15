using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackageAlmacen;

namespace WearDropWA
{
    public partial class ModificarMovimientoXLote : System.Web.UI.Page
    {
        private MovimientoAlmacenWSClient boMovimientoAlmacen;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovimientoAlmacenXLote;

        private int idRelacion;

        // OPTIMIZACIÓN: Cachear listas en ViewState
        private BindingList<movimientoAlmacen> ListaMovimientosAlmacen
        {
            get { return ViewState["ListaMovimientosAlmacen"] as BindingList<movimientoAlmacen>; }
            set { ViewState["ListaMovimientosAlmacen"] = value; }
        }

        private BindingList<lote> ListaLotesAlmacen
        {
            get { return ViewState["ListaLotesAlmacen"] as BindingList<lote>; }
            set { ViewState["ListaLotesAlmacen"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimientoAlmacen = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovimientoAlmacenXLote = new MovimientoAlmacenXLoteWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null && Request.QueryString["idAlmacen"] != null)
                {
                    idRelacion = Convert.ToInt32(Request.QueryString["id"]);
                    int idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);

                    ViewState["IdRelacion"] = idRelacion;
                    ViewState["IdAlmacen"] = idAlmacen;

                    // ✅ Cargar listas una sola vez en !IsPostBack
                    CargarListasDelAlmacen(idAlmacen);

                    // Luego cargar los datos de la relación existente
                    CargarDatosRelacion();
                }
                else
                {
                    Response.Redirect("../ListarAlmacenes.aspx");
                }
            }
            else
            {
                idRelacion = (int)ViewState["IdRelacion"];
            }
        }

        // ✅ NUEVO MÉTODO: Cargar listas del almacén una sola vez
        private void CargarListasDelAlmacen(int idAlmacen)
        {
            try
            {
                // Cargar lista de movimientos del almacén
                ListaMovimientosAlmacen = new BindingList<movimientoAlmacen>(
                    boMovimientoAlmacen.listarMovimientosPorAlmacen(idAlmacen)
                );

                // Cargar lista de lotes del almacén
                ListaLotesAlmacen = new BindingList<lote>(
                    boLote.listarLotesActivosPorAlmacen(idAlmacen)
                );
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar datos del almacén: {ex.Message}");
            }
        }

        private void CargarDatosRelacion()
        {
            try
            {
                movimientoAlmacenXLote relacionActual = boMovimientoAlmacenXLote.obtenerMovXLotePorID(idRelacion);

                if (relacionActual != null)
                {
                    if (relacionActual.datMov != null)
                    {
                        txtIdMovimiento.Text = relacionActual.datMov.idMovimiento.ToString();
                        CargarDatosMovimiento(relacionActual.datMov.idMovimiento);
                    }

                    if (relacionActual.datLote != null)
                    {
                        txtIdLote.Text = relacionActual.datLote.idLote.ToString();
                        CargarDatosLote(relacionActual.datLote.idLote);
                    }

                    ViewState["RelacionActual"] = relacionActual;
                }
                else
                {
                    MostrarMensaje("No se encontró la relación especificada");
                    Response.Redirect(ObtenerUrlRedireccion());
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar la relación: {ex.Message}");
                Response.Redirect(ObtenerUrlRedireccion());
            }
        }

        protected void txtIdMovimiento_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtIdMovimiento.Text))
            {
                try
                {
                    int idMovimiento = Convert.ToInt32(txtIdMovimiento.Text.Trim());
                    CargarDatosMovimiento(idMovimiento);
                }
                catch (FormatException)
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje("Por favor, ingrese un ID de movimiento válido (número entero)");
                }
                catch (Exception ex)
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje($"Error al cargar el movimiento: {ex.Message}");
                }
            }
            else
            {
                LimpiarCamposMovimiento();
            }
        }

        // ✅ OPTIMIZADO: Buscar en lista cacheada primero
        private void CargarDatosMovimiento(int idMovimiento)
        {
            try
            {
                movimientoAlmacen movimiento = null;

                // ✅ Buscar primero en la lista cacheada
                if (ListaMovimientosAlmacen != null)
                {
                    movimiento = ListaMovimientosAlmacen.FirstOrDefault(m => m.idMovimiento == idMovimiento);
                }

                // Si no está en caché, buscar en el servicio
                if (movimiento == null)
                {
                    movimiento = boMovimientoAlmacen.obtenerMovimientoPorId(idMovimiento);
                }

                if (movimiento != null && movimiento.idMovimiento > 0)
                {
                    txtLugarOrigen.Text = movimiento.lugarOrigen ?? "";
                    txtLugarDestino.Text = movimiento.lugarDestino ?? "";

                    if (movimiento.fechaSpecified && movimiento.fecha != DateTime.MinValue)
                    {
                        txtFecha.Text = movimiento.fecha.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    }

                    if (movimiento.tipo != null)
                    {
                        txtTipo.Text = movimiento.tipo.ToString();
                    }
                    else
                    {
                        txtTipo.Text = "";
                    }

                    ViewState["MovimientoActual"] = movimiento;
                }
                else
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje($"No se encontró ningún movimiento con el ID {idMovimiento}");
                }
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error del servicio web: {faultEx.Message}");
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error de comunicación con el servicio: {commEx.Message}");
            }
            catch (Exception ex)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error inesperado al cargar el movimiento: {ex.Message}");
            }
        }

        private void LimpiarCamposMovimiento()
        {
            txtLugarOrigen.Text = string.Empty;
            txtLugarDestino.Text = string.Empty;
            txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTipo.Text = string.Empty;
            ViewState["MovimientoActual"] = null;
        }

        protected void txtIdLote_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtIdLote.Text))
            {
                try
                {
                    int idLote = Convert.ToInt32(txtIdLote.Text.Trim());
                    CargarDatosLote(idLote);
                }
                catch (FormatException)
                {
                    LimpiarCamposLote();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Por favor, ingrese un ID de lote válido (número entero)');", true);
                }
                catch (Exception ex)
                {
                    LimpiarCamposLote();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error al cargar el lote: {ex.Message}');", true);
                }
            }
            else
            {
                LimpiarCamposLote();
            }
        }

        // ✅ OPTIMIZADO: Buscar en lista cacheada primero
        private void CargarDatosLote(int idLote)
        {
            try
            {
                lote lote = null;

                // ✅ Buscar primero en la lista cacheada
                if (ListaLotesAlmacen != null)
                {
                    lote = ListaLotesAlmacen.FirstOrDefault(l => l.idLote == idLote);
                }

                // Si no está en caché, buscar en el servicio
                if (lote == null)
                {
                    lote = boLote.obtenerLotePorID(idLote);
                }

                if (lote != null && lote.idLote > 0)
                {
                    txtDescripcion.Text = lote.descripcion ?? "";
                    ViewState["LoteActual"] = lote;
                }
                else
                {
                    LimpiarCamposLote();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('No se encontró ningún lote con el ID {idLote}');", true);
                }
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                LimpiarCamposLote();
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error del servicio web: {faultEx.Message}');", true);
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                LimpiarCamposLote();
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error de comunicación con el servicio: {commEx.Message}');", true);
            }
            catch (Exception ex)
            {
                LimpiarCamposLote();
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error inesperado al cargar el lote: {ex.Message}');", true);
            }
        }

        private void LimpiarCamposLote()
        {
            txtDescripcion.Text = string.Empty;
            ViewState["LoteActual"] = null;
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtIdMovimiento.Text))
                {
                    MostrarMensaje("Por favor, ingrese el ID del Movimiento");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtIdLote.Text))
                {
                    MostrarMensaje("Por favor, ingrese el ID del Lote");
                    return;
                }

                if (ViewState["MovimientoActual"] == null)
                {
                    MostrarMensaje("Los datos del movimiento no están cargados. Verifique el ID del Movimiento.");
                    return;
                }

                if (ViewState["LoteActual"] == null)
                {
                    MostrarMensaje("Los datos del lote no están cargados. Verifique el ID del Lote.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtLugarOrigen.Text) ||
                    string.IsNullOrWhiteSpace(txtLugarDestino.Text))
                {
                    MostrarMensaje("Los datos del movimiento están incompletos. Verifique el ID.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
                {
                    MostrarMensaje("Los datos del lote están incompletos. Verifique el ID.");
                    return;
                }

                string idAlmacenStr = ViewState["IdAlmacen"]?.ToString();
                if (string.IsNullOrEmpty(idAlmacenStr))
                {
                    MostrarMensaje("No se pudo determinar el almacén.");
                    return;
                }

                int idAlmacen = Convert.ToInt32(idAlmacenStr);
                int idMovimiento = Convert.ToInt32(txtIdMovimiento.Text.Trim());
                int idLote = Convert.ToInt32(txtIdLote.Text.Trim());

                // ✅ Validar usando listas cacheadas
                bool movimientoExisteEnAlmacen = ValidarMovimientoEnAlmacen(idMovimiento, idAlmacen);

                if (!movimientoExisteEnAlmacen)
                {
                    MostrarMensaje($"El movimiento con ID {idMovimiento} no pertenece a este almacén.");
                    return;
                }

                bool loteExisteEnAlmacen = ValidarLoteEnAlmacen(idLote, idAlmacen);

                if (!loteExisteEnAlmacen)
                {
                    MostrarMensaje($"El lote con ID {idLote} no se encuentra en este almacén.");
                    return;
                }

                movimientoAlmacenXLote movXLote = ViewState["RelacionActual"] as movimientoAlmacenXLote;

                if (movXLote == null)
                {
                    movXLote = new movimientoAlmacenXLote();
                }

                movXLote.idMov_X_Lote = idRelacion;
                movXLote.datMov = (movimientoAlmacen)ViewState["MovimientoActual"];
                movXLote.datLote = (lote)ViewState["LoteActual"];

                int resultado = boMovimientoAlmacenXLote.modificarMovXLote(movXLote);

                if (resultado > 0)
                {
                    // ✅ Establecer la última pestaña visitada
                    Session["UltimaPagina"] = "MovimientosXLote";

                    MostrarMensajeYRedirigir(
                        "Relación modificada exitosamente",
                        ObtenerUrlRedireccion()
                    );
                }
                else
                {
                    MostrarMensaje("Error al modificar la relación. Intente nuevamente.");
                }
            }
            catch (FormatException)
            {
                MostrarMensaje("Por favor, ingrese valores numéricos válidos para los IDs");
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                MostrarMensaje($"Error del servicio web: {faultEx.Message}");
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al modificar la relación: {ex.Message}");
            }
        }

        // ✅ OPTIMIZADO: Usar lista cacheada
        private bool ValidarMovimientoEnAlmacen(int idMovimiento, int idAlmacen)
        {
            try
            {
                // Usar lista cacheada si existe
                if (ListaMovimientosAlmacen != null)
                {
                    return ListaMovimientosAlmacen.Any(m => m.idMovimiento == idMovimiento);
                }

                // Fallback: cargar desde servicio
                BindingList<movimientoAlmacen> movimientos = new BindingList<movimientoAlmacen>(
                    boMovimientoAlmacen.listarMovimientosPorAlmacen(idAlmacen)
                );
                return movimientos.Any(m => m.idMovimiento == idMovimiento);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al validar movimiento: {ex.Message}");
                return false;
            }
        }

        // ✅ OPTIMIZADO: Usar lista cacheada
        private bool ValidarLoteEnAlmacen(int idLote, int idAlmacen)
        {
            try
            {
                // Usar lista cacheada si existe
                if (ListaLotesAlmacen != null)
                {
                    return ListaLotesAlmacen.Any(l => l.idLote == idLote);
                }

                // Fallback: cargar desde servicio
                BindingList<lote> lotes = new BindingList<lote>(
                    boLote.listarLotesActivosPorAlmacen(idAlmacen)
                );
                return lotes.Any(l => l.idLote == idLote);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al validar lote: {ex.Message}");
                return false;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ObtenerUrlRedireccion());
        }

        private string ObtenerUrlRedireccion()
        {
            string idAlmacen = ViewState["IdAlmacen"]?.ToString();

            if (!string.IsNullOrEmpty(idAlmacen))
            {
                return $"../MostrarAlmacen.aspx?id={idAlmacen}";
            }
            else
            {
                return "../ListarAlmacenes.aspx";
            }
        }

        private void MostrarMensaje(string mensaje)
        {
            string script = $"<script type='text/javascript'>alert('{EscaparComillas(mensaje)}');</script>";
            Response.Write(script);
        }

        private void MostrarMensajeYRedirigir(string mensaje, string url)
        {
            string script = $"<script type='text/javascript'>alert('{EscaparComillas(mensaje)}'); window.location='{url}';</script>";
            Response.Write(script);
        }

        private string EscaparComillas(string texto)
        {
            return texto.Replace("'", "\\'").Replace("\"", "\\\"").Replace("\n", "\\n").Replace("\r", "");
        }
    }
}
