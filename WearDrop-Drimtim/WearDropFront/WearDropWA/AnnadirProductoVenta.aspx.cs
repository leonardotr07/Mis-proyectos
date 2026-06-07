 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.DescuentoPorcentajeWS;
using WearDropWA.PackagePrendas;
using WearDropWA.PromocionComboWS;
using WearDropWA.VentaWS;


namespace WearDropWA
{
    public partial class AnnadirProductoVenta : System.Web.UI.Page
    {
        // 🔹 Propiedades para mantener estado
        private int IdPrendaSeleccionada
        {
            get { return ViewState["IdPrendaSeleccionada"] != null ? (int)ViewState["IdPrendaSeleccionada"] : 0; }
            set { ViewState["IdPrendaSeleccionada"] = value; }
        }

        private string NombrePrendaSeleccionada
        {
            get { return ViewState["NombrePrendaSeleccionada"]?.ToString() ?? ""; }
            set { ViewState["NombrePrendaSeleccionada"] = value; }
        }

        private object PrendaSeleccionada
        {
            get { return ViewState["PrendaSeleccionada"]; }
            set { ViewState["PrendaSeleccionada"] = value; }
        }

        private string TipoPrendaSeleccionada
        {
            get { return ViewState["TipoPrendaSeleccionada"]?.ToString() ?? ""; }
            set { ViewState["TipoPrendaSeleccionada"] = value; }
        }
        ///INIINIIDNIDNADASDHSDASUDHASODHAUSUOD
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine($"=== PAGE_LOAD AnnadirProductoVenta ===");
            System.Diagnostics.Debug.WriteLine($"IsPostBack: {IsPostBack}, ID Prenda: {IdPrendaSeleccionada}");

            if (!IsPostBack)
            {
                CargarTiposDePrenda();

                // 🔹 VERIFICAR SI ESTAMOS EN MODO MODIFICAR
                string modo = Request.QueryString["modo"];
                if (modo == "modificar")
                {
                    CargarDatosModificacion();
                }
                else
                {
                    LimpiarSeleccionPrenda();
                }
            }

            // 🔹 INICIALIZAR BOTONES DE TALLA EN CADA CARGA
            ScriptManager.RegisterStartupScript(this, GetType(), "inicializarTallas",
                "setTimeout(function() { inicializarBotonesTalla(); }, 100);", true);

            // 🔹 MANEJAR EL POSTBACK PARA APLICAR DESCUENTOS Y PROMOCIONES
            if (Request["__EVENTTARGET"] == "AplicarDescuentos")
            {
                AplicarDescuentosDesdeModal();
            }
            else if (Request["__EVENTTARGET"] == "AplicarPromociones")
            {
                AplicarPromocionesDesdeModal();
            }
        }



        // 🔹 MÉTODO NUEVO: Cargar datos para modificación
        private void CargarDatosModificacion()
        {
            try
            {
                // 🔹 OBTENER DATOS DE MODIFICACIÓN DESDE SESIÓN
                var productoModificar = Session["ProductoSeleccionadoModificar"] as VentaWS.itemVenta;
                int indiceModificar = Session["IndiceProductoModificar"] != null ? (int)Session["IndiceProductoModificar"] : -1;

                if (productoModificar != null && indiceModificar >= 0)
                {
                    System.Diagnostics.Debug.WriteLine($"🔹 Cargando datos para modificación:");
                    System.Diagnostics.Debug.WriteLine($"   - ID Prenda: {productoModificar.idPrenda}");
                    System.Diagnostics.Debug.WriteLine($"   - Cantidad: {productoModificar.cantidad}");
                    System.Diagnostics.Debug.WriteLine($"   - Talla: {productoModificar.talla}");
                    System.Diagnostics.Debug.WriteLine($"   - Subtotal: {productoModificar.subtotal}");
                    System.Diagnostics.Debug.WriteLine($"   - Índice: {indiceModificar}");

                    // 🔹 PRIMERO DETERMINAR EL TIPO DE PRENDA
                    string tipoPrenda = ObtenerTipoPrendaPorId(productoModificar.idPrenda);

                    if (!string.IsNullOrEmpty(tipoPrenda))
                    {
                        // 🔹 SELECCIONAR EL TIPO EN EL DROPDOWN
                        ddlTipoPrenda.SelectedValue = tipoPrenda;
                        TipoPrendaSeleccionada = tipoPrenda;
                        System.Diagnostics.Debug.WriteLine($"✅ Tipo de prenda determinado: {tipoPrenda}");

                        // 🔹 CARGAR LA PRENDA COMPLETA
                        CargarPrendaParaModificar(productoModificar.idPrenda, productoModificar);
                    }
                    else
                    {
                        throw new Exception($"No se pudo determinar el tipo de prenda para ID: {productoModificar.idPrenda}");
                    }

                    // 🔹 CONFIGURAR INTERFAZ PARA MODO MODIFICAR
                    ConfigurarInterfazModoModificar();

                    MostrarMensaje("Modo modificar activado. Puede cambiar la cantidad, talla o seleccionar otra prenda.", "info");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("❌ No se encontraron datos para modificar");
                    MostrarMensaje("Error: No se encontraron datos para modificar.", "error");
                    Response.Redirect("~/RegistarVentas.aspx");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarDatosModificacion: {ex.Message}");
                MostrarMensaje($"Error al cargar datos para modificación: {ex.Message}", "error");
                Response.Redirect("~/RegistarVentas.aspx");
            }
        }


        private void CargarPrendaParaModificar(int idPrenda, VentaWS.itemVenta itemVenta)
        {
            try
            {
                // 🔹 CARGAR LA PRENDA COMPLETA
                var prendaCompleta = ObtenerPrendaPorId(idPrenda, TipoPrendaSeleccionada);

                if (prendaCompleta != null)
                {
                    IdPrendaSeleccionada = idPrenda;

                    var tipo = prendaCompleta.GetType();
                    var nombreProp = tipo.GetProperty("nombre");
                    var nombre = nombreProp?.GetValue(prendaCompleta)?.ToString() ?? "Nombre no disponible";

                    NombrePrendaSeleccionada = nombre;
                    PrendaSeleccionada = prendaCompleta;

                    txtNombrePrenda.Text = NombrePrendaSeleccionada;
                    hdnIdPrenda.Value = IdPrendaSeleccionada.ToString();

                    // 🔹 CARGAR PRECIOS
                    CargarPreciosPrenda(prendaCompleta);

                    // 🔹 CARGAR TALLAS DISPONIBLES
                    CargarTallasDisponibles(idPrenda);

                    // 🔹 ESPERAR A QUE LAS TALLAS SE CARGUEN ANTES DE ESTABLECER LOS VALORES
                    ScriptManager.RegisterStartupScript(this, GetType(), "establecerValoresModificacion",
                        $@"
                setTimeout(function() {{
                    // ESTABLECER CANTIDAD
                    document.getElementById('{txtCantidadRequerida.ClientID}').value = '{itemVenta.cantidad}';
                    
                    // ESTABLECER TALLA
                    document.getElementById('{hdnTallaSeleccionada.ClientID}').value = '{itemVenta.talla}';
                    
                    // FORZAR ACTUALIZACIÓN DE TALLA
                    if (typeof seleccionarTallaExistente === 'function') {{
                        seleccionarTallaExistente('{itemVenta.talla}');
                    }}
                    
                    // ACTUALIZAR SUBTOTAL
                    if (typeof actualizarSubtotal === 'function') {{
                        setTimeout(function() {{
                            actualizarSubtotal();
                        }}, 500);
                    }}
                }}, 1000);
                ", true);

                    // 🔹 ESTABLECER SUBTOTAL ORIGINAL
                    txtSubtotal.Text = itemVenta.subtotal.ToString("0.00");

                    // 🔹 GUARDAR EL SUBTOTAL ORIGINAL EN VIEWSTATE
                    ViewState["SubtotalOriginal"] = itemVenta.subtotal;
                    ViewState["SubtotalActual"] = itemVenta.subtotal;

                    // 🔹 HABILITAR BOTONES
                    btnVerPrenda.Enabled = true;
                    btnAnadirProducto.Enabled = true;
                    btnPromocionesAplicadas.Enabled = true;
                    btnDescuentosAplicados.Enabled = true;

                    // 🔹 CAMBIAR TEXTO DEL BOTÓN A "ACTUALIZAR PRODUCTO"
                    btnAnadirProducto.Text = "Actualizar Producto";

                    System.Diagnostics.Debug.WriteLine($"✅ Prenda cargada para modificación - ID: {IdPrendaSeleccionada}");
                }
                else
                {
                    throw new Exception("No se pudo cargar la prenda completa desde el servicio web");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarPrendaParaModificar: {ex.Message}");
                throw;
            }
        }


        // 🔹 MÉTODO NUEVO: Obtener tipo de prenda por ID
        private string ObtenerTipoPrendaPorId(int idPrenda)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔹 Buscando tipo de prenda para ID: {idPrenda}");

                // 🔹 PRIMERO VERIFICAR SI TENEMOS EL TIPO EN LOS DATOS DE MODIFICACIÓN
                var productoModificar = Session["ProductoSeleccionadoModificar"] as VentaWS.itemVenta;
                if (productoModificar != null)
                {
                    // Intentar obtener el tipo de prenda de la sesión o inferirlo
                    string tipoPrendaSession = Session["TipoPrendaModificar"] as string;
                    if (!string.IsNullOrEmpty(tipoPrendaSession))
                    {
                        System.Diagnostics.Debug.WriteLine($"✅ Tipo de prenda obtenido de sesión: {tipoPrendaSession}");
                        return tipoPrendaSession;
                    }
                }

                // 🔹 SI NO HAY DATOS EN SESIÓN, BUSCAR EN LOS SERVICIOS
                var servicios = new Dictionary<string, Func<int, object>>
        {
            { "Blusa", (id) => new PackagePrendas.BlusaWSClient().obtenerBlusaPorId(id) },
            { "Casaca", (id) => new PackagePrendas.CasacaWSClient().obtenerCasacaPorId(id) },
            { "Falda", (id) => new PackagePrendas.FaldaWSClient().obtenerFaldaPorId(id) },
            { "Gorro", (id) => new PackagePrendas.GorroWSClient().obtenerGorroPorId(id) },
            { "Pantalon", (id) => new PackagePrendas.PantalonWSClient().obtenerPantalonPorId(id) },
            { "Polo", (id) => new PackagePrendas.PoloWSClient().obtenerPoloPorId(id) },
            { "Vestido", (id) => new PackagePrendas.VestidoWSClient().obtenerVestidoPorId(id) }
        };

                foreach (var servicio in servicios)
                {
                    try
                    {
                        var prenda = servicio.Value(idPrenda);
                        if (prenda != null)
                        {
                            System.Diagnostics.Debug.WriteLine($"✅ Tipo de prenda encontrado: {servicio.Key}");

                            // 🔹 GUARDAR EN SESIÓN PARA FUTURAS REFERENCIAS
                            Session["TipoPrendaModificar"] = servicio.Key;

                            return servicio.Key;
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"ℹ️ No es {servicio.Key}: {ex.Message}");
                        // Continuar con el siguiente tipo
                    }
                }

                System.Diagnostics.Debug.WriteLine("⚠️ No se pudo determinar el tipo de prenda, usando Polo por defecto");
                return "Polo"; // Valor por defecto
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en ObtenerTipoPrendaPorId: {ex.Message}");
                return "Polo"; // Valor por defecto en caso de error
            }
        }



        private void ConfigurarInterfazModoModificar()
        {
            // Cambiar textos si es necesario
           //ituloPagina.InnerText = "Modificar Producto";

            System.Diagnostics.Debug.WriteLine("🔹 Interfaz configurada para modo modificar");
        }









        private void AplicarPromocionesDesdeModal()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🔹 Aplicando promociones desde modal...");

                // Obtener el total con descuento del modal
                double totalConPromociones = 0;

                if (ViewState["TotalConPromociones"] != null)
                {
                    totalConPromociones = (double)ViewState["TotalConPromociones"];
                    System.Diagnostics.Debug.WriteLine($"🔹 ViewState['TotalConPromociones'] encontrado: S/ {totalConPromociones:0.00}");
                }
                else
                {
                    // Calcular desde los labels del modal
                    totalConPromociones = ObtenerTotalConPromocionesDesdeModal();
                    System.Diagnostics.Debug.WriteLine($"🔹 Total con promociones calculado: S/ {totalConPromociones:0.00}");
                }

                // Validaciones
                double subtotalOriginal = CalcularSubtotal();
                if (totalConPromociones > subtotalOriginal)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ERROR: Total con promociones ({totalConPromociones:0.00}) > Subtotal original ({subtotalOriginal:0.00})");
                    MostrarMensaje("Error: Las promociones no pueden resultar en un valor mayor al subtotal original.", "error");
                    return;
                }

                if (totalConPromociones < 0)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ERROR: Total con promociones negativo: {totalConPromociones:0.00}");
                    totalConPromociones = 0;
                }

                // 🔹 CORRECCIÓN: ACTUALIZAR AMBOS VIEWSTATES
                ViewState["TotalConPromociones"] = totalConPromociones;
                ViewState["SubtotalActual"] = totalConPromociones; // También actualizar SubtotalActual

                // Actualizar el subtotal en pantalla
                txtSubtotal.Text = totalConPromociones.ToString("0.00");

                MostrarMensaje($"Promociones aplicadas correctamente. Nuevo subtotal: S/ {totalConPromociones:0.00}", "exito");
                System.Diagnostics.Debug.WriteLine($"✅ Promociones aplicadas - Nuevo subtotal: S/ {totalConPromociones:0.00}");

                // Cerrar el modal
                string cerrarModalScript = @"
            console.log('Cerrando modal de promociones después de aplicar...');
            var modalElement = document.getElementById('modalPromociones');
            if (modalElement) {
                var modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                } else {
                    var newModal = new bootstrap.Modal(modalElement);
                    newModal.hide();
                }
            }
            setTimeout(function() {
                var backdrops = document.querySelectorAll('.modal-backdrop');
                backdrops.forEach(function(backdrop) {
                    backdrop.remove();
                });
                document.body.classList.remove('modal-open');
                document.body.style.paddingRight = '';
                document.body.style.overflow = '';
            }, 150);
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalPromociones", cerrarModalScript, true);
                UpdatePanel1.Update();

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en AplicarPromocionesDesdeModal: {ex.Message}");
                MostrarMensaje($"Error al aplicar promociones: {ex.Message}", "error");
            }
        }

        private double ObtenerTotalConPromocionesDesdeModal()
{
    try
    {
        // Obtener cantidad y precios actuales
        int cantidadRequerida = int.TryParse(txtCantidadRequerida.Text, out int cant) ? cant : 0;
        double precioUnitario = ObtenerPrecioUnitarioSegunCantidad(cantidadRequerida);
        
        double subtotalSinDescuento = precioUnitario * cantidadRequerida;
        
        // Obtener promociones y calcular descuento total
        var promociones = ObtenerPromocionesComboParaPrenda();
        double totalDescuento = 0;

        foreach (var promocion in promociones)
        {
            var (descuentoAplicado, _) = CalcularDescuentoPromocionCombo(cantidadRequerida, promocion, precioUnitario);
            totalDescuento += descuentoAplicado;
        }

        double totalConPromociones = subtotalSinDescuento - totalDescuento;
        
        // Guardar en ViewState para referencia futura
        ViewState["TotalConPromociones"] = totalConPromociones;
        
        return totalConPromociones;
    }
    catch (Exception ex)
    {
        System.Diagnostics.Debug.WriteLine($"❌ Error al obtener total con promociones: {ex.Message}");
        return CalcularSubtotal(); // Fallback al subtotal normal
    }
}



        // 🔹 CARGAR TIPOS DE PRENDA
        private void CargarTiposDePrenda()
        {
            ddlTipoPrenda.Items.Clear();
            ddlTipoPrenda.Items.Add(new ListItem("Seleccionar tipo de prenda", ""));
            ddlTipoPrenda.Items.Add(new ListItem("Blusa", "Blusa"));
            ddlTipoPrenda.Items.Add(new ListItem("Casaca", "Casaca"));
            ddlTipoPrenda.Items.Add(new ListItem("Falda", "Falda"));
            ddlTipoPrenda.Items.Add(new ListItem("Gorro", "Gorro"));
            ddlTipoPrenda.Items.Add(new ListItem("Pantalon", "Pantalon"));
            ddlTipoPrenda.Items.Add(new ListItem("Polo", "Polo"));
            ddlTipoPrenda.Items.Add(new ListItem("Vestido", "Vestido"));
        }





        // 🔹 LIMPIAR SELECCIÓN DE PRENDA
        private void LimpiarSeleccionPrenda()
        {
            txtNombrePrenda.Text = "";
            hdnIdPrenda.Value = "";
            IdPrendaSeleccionada = 0;
            NombrePrendaSeleccionada = "";
            PrendaSeleccionada = null;
            TipoPrendaSeleccionada = "";

            // Limpiar campos
            txtPrecioUnidad.Text = "";
            txtPrecioMayor.Text = "";
            txtPrecioDescuento.Text = "";
            txtCantidadDisponible.Text = "";
            txtCantidadRequerida.Text = "";
            txtSubtotal.Text = "";

            // Deshabilitar botones
            btnVerPrenda.Enabled = false;
            btnAnadirProducto.Enabled = false;
            btnPromocionesAplicadas.Enabled = false;
            btnDescuentosAplicados.Enabled = false;

            // Limpiar talla
            hdnTallaSeleccionada.Value = "";
            hdnStockPorTalla.Value = "";

            // 🔹 LIMPIAR VIEWSTATES DE DESCUENTOS/PROMOCIONES
            ViewState.Remove("TotalConPromociones");
            ViewState.Remove("TotalConDescuentos");
            ViewState.Remove("SubtotalActual");
            ViewState.Remove("SubtotalOriginal");

            // 🔹 RESTAURAR TEXTO ORIGINAL DEL BOTÓN
            btnAnadirProducto.Text = "Añadir Producto";

            System.Diagnostics.Debug.WriteLine("🔄 Selección de prenda limpiada");
        }



        private void ResetearDescuentosAplicados()
        {
            ViewState.Remove("TotalConPromociones");
            ViewState.Remove("TotalConDescuentos");
            ViewState["SubtotalActual"] = CalcularSubtotal();

            System.Diagnostics.Debug.WriteLine("🔄 Descuentos reseteados por cambio de cantidad");
        }

        // Llamar este método cuando cambie la cantidad (necesitarías un evento TextChanged en txtCantidadRequerida)
        protected void txtCantidadRequerida_TextChanged(object sender, EventArgs e)
        {
            ResetearDescuentosAplicados();
            ActualizarSubtotalBase();
        }


        // 🔹 MÉTODO TEMPORAL PARA DEBUG
        private void VerificarViewState()
        {
            System.Diagnostics.Debug.WriteLine("=== VERIFICACIÓN VIEWSTATE ===");

            if (ViewState["TotalConDescuentos"] != null)
            {
                double valor = (double)ViewState["TotalConDescuentos"];
                System.Diagnostics.Debug.WriteLine($"🔍 ViewState['TotalConDescuentos'] = S/ {valor:0.00}");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("🔍 ViewState['TotalConDescuentos'] es NULL");
            }

            if (ViewState["SubtotalActual"] != null)
            {
                double valor = (double)ViewState["SubtotalActual"];
                System.Diagnostics.Debug.WriteLine($"🔍 ViewState['SubtotalActual'] = S/ {valor:0.00}");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("🔍 ViewState['SubtotalActual'] es NULL");
            }

            double subtotalCalculado = CalcularSubtotal();
            System.Diagnostics.Debug.WriteLine($"🔍 Subtotal calculado: S/ {subtotalCalculado:0.00}");
            System.Diagnostics.Debug.WriteLine("=== FIN VERIFICACIÓN ===");
        }




        // 🔹 EVENTO CAMBIO EN DROPDOWN
        protected void ddlTipoPrenda_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlTipoPrenda.SelectedValue;
            bool tieneValorValido = !string.IsNullOrEmpty(selectedValue) && selectedValue != "";

            btnSeleccionarPrenda.Enabled = tieneValorValido;
            LimpiarSeleccionPrenda();
            System.Diagnostics.Debug.WriteLine($"🔄 Dropdown cambiado: {selectedValue}");
        }

        // 🔹 ABRIR MODAL PARA SELECCIONAR PRENDA
        protected void btnSeleccionarPrenda_Click(object sender, EventArgs e)
        {
            string tipoPrenda = ddlTipoPrenda.SelectedValue;

            if (string.IsNullOrEmpty(tipoPrenda))
            {
                MostrarMensaje("Por favor, seleccione un tipo de prenda válido.", "error");
                return;
            }

            try
            {
                CargarPrendasEnModal(tipoPrenda);
                lblTipoPrendaModal.Text = tipoPrenda;
                UpdatePanel1.Update();

                string script = @"
                console.log('Mostrando modal después de actualizar UpdatePanel');
                var modal = new bootstrap.Modal(document.getElementById('modalSeleccionarPrenda'));
                modal.show();
            ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModal", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al abrir el selector de prendas: {ex.Message}", "error");
            }
        }

        // 🔹 CARGAR PRENDAS EN MODAL
        private void CargarPrendasEnModal(string tipoPrenda)
        {
            try
            {
                List<PrendaViewModel> prendas = new List<PrendaViewModel>();

                switch (tipoPrenda)
                {
                    case "Blusa":
                        prendas = ObtenerBlusasReal();
                        break;
                    case "Casaca":
                        prendas = ObtenerCasacasReal();
                        break;
                    case "Falda":
                        prendas = ObtenerFaldasReal();
                        break;
                    case "Gorro":
                        prendas = ObtenerGorrosReal();
                        break;
                    case "Pantalon":
                        prendas = ObtenerPantalonesReal();
                        break;
                    case "Polo":
                        prendas = ObtenerPolosReal();
                        break;
                    case "Vestido":
                        prendas = ObtenerVestidosReal();
                        break;
                    default:
                        MostrarMensaje("Tipo de prenda no válido.", "error");
                        return;
                }

                if (prendas.Count == 0)
                {
                    MostrarMensaje($"No se encontraron prendas de tipo {tipoPrenda} activas.", "info");
                }

                // Asignar datos al GridView
                gvPrendas.DataSource = prendas;
                gvPrendas.DataBind();

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar prendas: {ex.Message}", "error");
            }
        }

        // 🔹 EVENTO SELECCIONAR PRENDA DESDE GRIDVIEW
        // 🔹 EVENTO SELECCIONAR PRENDA DESDE GRIDVIEW
        protected void gvPrendas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int idPrenda = Convert.ToInt32(e.CommandArgument);

                try
                {
                    var prendaCompleta = ObtenerPrendaPorId(idPrenda, ddlTipoPrenda.SelectedValue);

                    if (prendaCompleta != null)
                    {
                        IdPrendaSeleccionada = idPrenda;

                        var tipo = prendaCompleta.GetType();
                        var nombreProp = tipo.GetProperty("nombre");
                        var nombre = nombreProp?.GetValue(prendaCompleta)?.ToString() ?? "Nombre no disponible";

                        NombrePrendaSeleccionada = nombre;
                        PrendaSeleccionada = prendaCompleta;
                        TipoPrendaSeleccionada = ddlTipoPrenda.SelectedValue;

                        txtNombrePrenda.Text = NombrePrendaSeleccionada;
                        hdnIdPrenda.Value = IdPrendaSeleccionada.ToString();

                        CargarPreciosPrenda(prendaCompleta);
                        CargarTallasDisponibles(idPrenda);

                        // 🔹 EN MODO MODIFICAR: MANTENER LA CANTIDAD ORIGINAL PERO RESETEAR DESCUENTOS
                        if (Request.QueryString["modo"] == "modificar")
                        {
                            // Mantener cantidad pero recalcular subtotal base
                            if (int.TryParse(txtCantidadRequerida.Text, out int cantidadOriginal))
                            {
                                double subtotalBase = CalcularSubtotalConCantidad(cantidadOriginal);
                                txtSubtotal.Text = subtotalBase.ToString("0.00");

                                // Resetear descuentos/promociones aplicados
                                ViewState.Remove("TotalConPromociones");
                                ViewState.Remove("TotalConDescuentos");
                                ViewState["SubtotalActual"] = subtotalBase;
                            }
                        }

                        // HABILITAR BOTONES
                        btnVerPrenda.Enabled = true;
                        btnAnadirProducto.Enabled = true;
                        btnPromocionesAplicadas.Enabled = true;
                        btnDescuentosAplicados.Enabled = true;

                        System.Diagnostics.Debug.WriteLine($"✅ Prenda seleccionada - ID: {IdPrendaSeleccionada}, Nombre: {NombrePrendaSeleccionada}");

                        MostrarMensaje($"Prenda seleccionada: {NombrePrendaSeleccionada}", "exito");
                    }
                    else
                    {
                        MostrarMensaje("Error al cargar los detalles de la prenda seleccionada.", "error");
                    }

                    CerrarModalSeleccionarPrenda();
                    UpdatePanel1.Update();

                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al seleccionar prenda: {ex.Message}", "error");
                }
            }
        }

        private double CalcularSubtotalConCantidad(int cantidad)
        {
            try
            {
                double precioUnidad = Convert.ToDouble(txtPrecioUnidad.Text);
                double precioMayor = Convert.ToDouble(txtPrecioMayor.Text);
                double precioDocena = Convert.ToDouble(txtPrecioDescuento.Text);

                double precioAplicado = precioUnidad;

                if (cantidad >= 6 && cantidad < 12)
                {
                    precioAplicado = precioMayor;
                }
                else if (cantidad >= 12)
                {
                    precioAplicado = precioDocena;
                }

                double subtotal = precioAplicado * cantidad;
                System.Diagnostics.Debug.WriteLine($"🧮 Subtotal calculado con cantidad {cantidad}: {cantidad} x S/ {precioAplicado} = S/ {subtotal}");

                return subtotal;
            }
            catch
            {
                return 0;
            }
        }



        // 🔹 OBTENER PRENDA COMPLETA POR ID
        private object ObtenerPrendaPorId(int idPrenda, string tipoPrenda)
        {
            try
            {
                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new PackagePrendas.BlusaWSClient();
                        return blusaWS.obtenerBlusaPorId(idPrenda);
                    case "Casaca":
                        var casacaWS = new PackagePrendas.CasacaWSClient();
                        return casacaWS.obtenerCasacaPorId(idPrenda);
                    case "Falda":
                        var faldaWS = new PackagePrendas.FaldaWSClient();
                        return faldaWS.obtenerFaldaPorId(idPrenda);
                    case "Gorro":
                        var gorroWS = new PackagePrendas.GorroWSClient();
                        return gorroWS.obtenerGorroPorId(idPrenda);
                    case "Pantalon":
                        var pantalonWS = new PackagePrendas.PantalonWSClient();
                        return pantalonWS.obtenerPantalonPorId(idPrenda);
                    case "Polo":
                        var poloWS = new PackagePrendas.PoloWSClient();
                        return poloWS.obtenerPoloPorId(idPrenda);
                    case "Vestido":
                        var vestidoWS = new PackagePrendas.VestidoWSClient();
                        return vestidoWS.obtenerVestidoPorId(idPrenda);
                    default:
                        return null;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al obtener prenda por ID: {ex.Message}");
                return null;
            }
        }

        // 🔹 CARGAR PRECIOS DE LA PRENDA

        private void CargarPreciosPrenda(object prenda)
        {
            try
            {
                if (prenda == null) return;

                var tipo = prenda.GetType();
                var precioUnidadProp = tipo.GetProperty("precioUnidad");
                var precioMayorProp = tipo.GetProperty("precioMayor");
                var precioDocenaProp = tipo.GetProperty("precioDocena");

                if (precioUnidadProp != null)
                    txtPrecioUnidad.Text = Convert.ToDouble(precioUnidadProp.GetValue(prenda)).ToString("0.00");

                if (precioMayorProp != null)
                    txtPrecioMayor.Text = Convert.ToDouble(precioMayorProp.GetValue(prenda)).ToString("0.00");

                if (precioDocenaProp != null)
                    txtPrecioDescuento.Text = Convert.ToDouble(precioDocenaProp.GetValue(prenda)).ToString("0.00");

                System.Diagnostics.Debug.WriteLine("✅ Precios cargados correctamente");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al cargar precios: {ex.Message}");
            }
        }

        // 🔹 CARGAR TALLAS DISPONIBLES
        // 🔹 CARGAR TALLAS DISPONIBLES

        private void CargarTallasDisponibles(int idPrenda)
        {
            try
            {
                var prendaLoteWS = new PackagePrendas.PrendaLoteWSClient();
                var prendasLote = prendaLoteWS.listarPorIDPrenda(idPrenda);

                if (prendasLote != null && prendasLote.Length > 0)
                {
                    var stockPorTalla = new Dictionary<string, int>();
                    var tallasDisponibles = new List<object>();

                    foreach (var prendaLote in prendasLote)
                    {
                        if (prendaLote != null && prendaLote.activo && prendaLote.stock > 0)
                        {
                            string talla = prendaLote.talla.ToString();
                            stockPorTalla[talla] = prendaLote.stock;

                            tallasDisponibles.Add(new
                            {
                                Talla = talla,
                                Stock = prendaLote.stock,
                                Lote = prendaLote.idLote
                            });
                        }
                    }

                    var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    hdnStockPorTalla.Value = serializer.Serialize(stockPorTalla);

                    string script = $@"
                    console.log('Actualizando disponibilidad de tallas...');
                    var stockData = {serializer.Serialize(stockPorTalla)};
                    console.log('Datos de stock:', stockData);
                    
                    actualizarDisponibilidadTallas(stockData);
                    
                    var tallaSeleccionada = document.getElementById('{hdnTallaSeleccionada.ClientID}').value;
                    if (tallaSeleccionada && stockData[tallaSeleccionada] > 0) {{
                        console.log('Restaurando talla seleccionada:', tallaSeleccionada);
                        seleccionarTallaExistente(tallaSeleccionada);
                    }}
                ";

                    ScriptManager.RegisterStartupScript(this, GetType(), "actualizarTallas", script, true);
                    System.Diagnostics.Debug.WriteLine($"✅ Tallas disponibles cargadas: {string.Join(", ", stockPorTalla.Keys)}");
                }
                else
                {
                    MostrarMensaje("No se encontraron tallas disponibles para esta prenda.", "info");

                    string script = @"
                    console.log('No hay tallas disponibles - deshabilitando todos los botones');
                    var botones = document.querySelectorAll('.size-btn');
                    botones.forEach(btn => {
                        btn.classList.add('disabled');
                        btn.style.cursor = 'not-allowed';
                        btn.classList.remove('active');
                    });
                    document.getElementById('" + hdnTallaSeleccionada.ClientID + @"').value = '';
                ";
                    ScriptManager.RegisterStartupScript(this, GetType(), "deshabilitarTallas", script, true);
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar tallas disponibles: {ex.Message}", "error");
            }
        }

        // 🔹 BOTÓN VER PRENDA - ABRIR MODAL CON DETALLES
        protected void btnVerPrenda_Click(object sender, EventArgs e)
        {
            if (PrendaSeleccionada == null || IdPrendaSeleccionada == 0)
            {
                MostrarMensaje("No hay ninguna prenda seleccionada para ver.", "error");
                return;
            }

            try
            {
                // 1. Cargar detalles de la prenda en el modal
                CargarDetallesPrendaEnModal();

                // 2. Cargar tallas en el GridView del modal
                CargarTallasEnModal();

                // 3. Actualizar UpdatePanel
                UpdatePanel1.Update();

                // 4. Mostrar modal
                string script = @"
            console.log('Mostrando modal de detalles de prenda...');
            var modal = new bootstrap.Modal(document.getElementById('modalVerPrenda'));
            modal.show();
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalVerPrenda", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al mostrar detalles de la prenda: {ex.Message}", "error");
            }
        }
        // 🔹 CARGAR DETALLES DE PRENDA EN MODAL (ELIMINANDO STOCK TOTAL)
        private void CargarDetallesPrendaEnModal()
        {
            try
            {
                if (PrendaSeleccionada == null) return;

                var tipo = PrendaSeleccionada.GetType();

                // Propiedades comunes (EXCLUYENDO stockPrenda)
                var idPrendaProp = tipo.GetProperty("idPrenda");
                var nombreProp = tipo.GetProperty("nombre");
                var colorProp = tipo.GetProperty("color");
                var materialProp = tipo.GetProperty("material");
                var precioUnidadProp = tipo.GetProperty("precioUnidad");
                var precioMayorProp = tipo.GetProperty("precioMayor");
                var precioDocenaProp = tipo.GetProperty("precioDocena");

                // Script para cargar detalles en el modal (SIN STOCK TOTAL)
                string script = $@"
            document.getElementById('detalleIdPrenda').textContent = '{(idPrendaProp?.GetValue(PrendaSeleccionada) ?? "N/A")}';
            document.getElementById('detalleNombre').textContent = '{(nombreProp?.GetValue(PrendaSeleccionada) ?? "N/A")}';
            document.getElementById('detalleColor').textContent = '{(colorProp?.GetValue(PrendaSeleccionada) ?? "N/A")}';
            document.getElementById('detalleMaterial').textContent = '{(materialProp?.GetValue(PrendaSeleccionada) ?? "N/A")}';
            document.getElementById('detallePrecioUnidad').textContent = 'S/ {Convert.ToDouble(precioUnidadProp?.GetValue(PrendaSeleccionada) ?? 0):0.00}';
            document.getElementById('detallePrecioMayor').textContent = 'S/ {Convert.ToDouble(precioMayorProp?.GetValue(PrendaSeleccionada) ?? 0):0.00}';
            document.getElementById('detallePrecioDocena').textContent = 'S/ {Convert.ToDouble(precioDocenaProp?.GetValue(PrendaSeleccionada) ?? 0):0.00}';

            // Limpiar campos específicos
            document.getElementById('detalleCamposEspecificos').innerHTML = '';
        ";

                // 🔹 AGREGAR CAMPOS ESPECÍFICOS SEGÚN TIPO DE PRENDA
                script += AgregarCamposEspecificosPorTipo();

                ScriptManager.RegisterStartupScript(this, GetType(), "cargarDetallesPrenda", script, true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al cargar detalles de prenda: {ex.Message}");
            }
        }

        // 🔹 MÉTODO PARA AGREGAR CAMPOS ESPECÍFICOS SEGÚN TIPO DE PRENDA
        private string AgregarCamposEspecificosPorTipo()
        {
            if (PrendaSeleccionada == null) return string.Empty;

            var tipo = PrendaSeleccionada.GetType();
            var camposEspecificos = new System.Text.StringBuilder();

            camposEspecificos.Append(@"
        var camposEspecificos = document.getElementById('detalleCamposEspecificos');
        camposEspecificos.innerHTML += '<h6 class=""mb-3 mt-4"">Características Específicas</h6>';
    ");

            switch (TipoPrendaSeleccionada)
            {
                case "Polo":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoManga", "Tipo Manga");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "estampado", "Estampado");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoCuello", "Tipo Cuello");
                    break;

                case "Vestido":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoVestido", "Tipo Vestido");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoManga", "Tipo Manga");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "largo", "Largo", " cm");
                    break;

                case "Casaca":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoCasaca", "Tipo Casaca");
                    AgregarCampoBooleano(camposEspecificos, tipo, "conCapucha", "Con Capucha");
                    break;

                case "Falda":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoFalda", "Tipo Falda");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "largo", "Largo", " cm");
                    AgregarCampoBooleano(camposEspecificos, tipo, "conForro", "Con Forro");
                    AgregarCampoBooleano(camposEspecificos, tipo, "conVolantes", "Con Volantes");
                    break;

                case "Gorro":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoGorra", "Tipo Gorra");
                    AgregarCampoBooleano(camposEspecificos, tipo, "tallaAjustable", "Talla Ajustable");
                    AgregarCampoBooleano(camposEspecificos, tipo, "impermeable", "Impermeable");
                    break;

                case "Pantalon":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoPantalon", "Tipo Pantalón");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "largoPierna", "Largo Pierna", " cm");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "cintura", "Cintura", " cm");
                    AgregarCampoBooleano(camposEspecificos, tipo, "elasticidad", "Elasticidad");
                    break;

                case "Blusa":
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoBlusa", "Tipo Blusa");
                    AgregarCampoEspecifico(camposEspecificos, tipo, "tipoManga", "Tipo Manga");
                    break;

                default:
                    camposEspecificos.Append(@"
                camposEspecificos.innerHTML += '<div class=""detalle-prenda-row""><div class=""detalle-prenda-label"">Tipo:</div><div class=""detalle-prenda-value"">No hay características específicas disponibles</div></div>';
            ");
                    break;
            }

            return camposEspecificos.ToString();
        }



        // 🔹 MÉTODO HELPER PARA AGREGAR CAMPOS ESPECÍFICOS
        private void AgregarCampoEspecifico(System.Text.StringBuilder builder, Type tipo, string nombrePropiedad, string etiqueta, string sufijo = "")
        {
            var propiedad = tipo.GetProperty(nombrePropiedad);
            if (propiedad != null)
            {
                var valor = propiedad.GetValue(PrendaSeleccionada);
                if (valor != null)
                {
                    string valorStr = valor.ToString();
                    if (!string.IsNullOrEmpty(valorStr) && valorStr != "0")
                    {
                        builder.Append($@"
                    camposEspecificos.innerHTML += '<div class=""detalle-prenda-row""><div class=""detalle-prenda-label"">{etiqueta}:</div><div class=""detalle-prenda-value"">{valorStr}{sufijo}</div></div>';
                ");
                    }
                }
            }
        }

        // 🔹 MÉTODO HELPER PARA AGREGAR CAMPOS BOOLEANOS
        private void AgregarCampoBooleano(System.Text.StringBuilder builder, Type tipo, string nombrePropiedad, string etiqueta)
        {
            var propiedad = tipo.GetProperty(nombrePropiedad);
            if (propiedad != null)
            {
                var valor = propiedad.GetValue(PrendaSeleccionada);
                if (valor is bool valorBool)
                {
                    string texto = valorBool ? "Sí" : "No";
                    string icono = valorBool ? "fa-check text-success" : "fa-times text-secondary";

                    builder.Append($@"
                camposEspecificos.innerHTML += '<div class=""detalle-prenda-row""><div class=""detalle-prenda-label"">{etiqueta}:</div><div class=""detalle-prenda-value""><i class=""fas {icono}""></i> {texto}</div></div>';
            ");
                }
            }
        }

        // 🔹 CARGAR TALLAS EN MODAL
        private void CargarTallasEnModal()
        {
            try
            {
                var prendaLoteWS = new PackagePrendas.PrendaLoteWSClient();
                var prendasLote = prendaLoteWS.listarPorIDPrenda(IdPrendaSeleccionada);

                if (prendasLote != null && prendasLote.Length > 0)
                {
                    var tallasParaGrid = prendasLote
                        .Where(pl => pl != null && pl.activo)
                        .Select(pl => new
                        {
                            Talla = pl.talla.ToString(),
                            Stock = pl.stock,
                            Lote = pl.idLote
                        })
                        .ToList();

                    gvTallasPrenda.DataSource = tallasParaGrid;
                    gvTallasPrenda.DataBind();

                    System.Diagnostics.Debug.WriteLine($"✅ Tallas cargadas en modal: {tallasParaGrid.Count} registros");
                }
                else
                {
                    gvTallasPrenda.DataSource = null;
                    gvTallasPrenda.DataBind();
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay tallas para mostrar en el modal");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al cargar tallas en modal: {ex.Message}");
            }
        }

        // 🔹 CERRAR MODAL SELECCIONAR PRENDA
        private void CerrarModalSeleccionarPrenda()
        {
            string cerrarScript = @"
                console.log('Cerrando modal completamente...');
                var modalElement = document.getElementById('modalSeleccionarPrenda');
                if (modalElement) {
                    var modal = bootstrap.Modal.getInstance(modalElement);
                    if (modal) {
                        modal.hide();
                    } else {
                        var newModal = new bootstrap.Modal(modalElement);
                        newModal.hide();
                    }
                }
                setTimeout(function() {
                    var backdrops = document.querySelectorAll('.modal-backdrop');
                    backdrops.forEach(function(backdrop) {
                        backdrop.remove();
                    });
                    document.body.classList.remove('modal-open');
                    document.body.style.paddingRight = '';
                    document.body.style.overflow = '';
                }, 150);
            ";

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", cerrarScript, true);
        }

        #region MÉTODOS PARA OBTENER PRENDAS REALES (MANTENIDOS)
        private List<PrendaViewModel> ObtenerBlusasReal()
        {
            try
            {
                var blusaWS = new PackagePrendas.BlusaWSClient();
                var blusas = blusaWS.listarBlusas();

                return blusas.Where(b => b != null && b.activo)
                             .Select(b => new PrendaViewModel
                             {
                                 Id = b.idPrenda,
                                 Nombre = b.nombre,
                                 Color = b.color ?? "",
                                 Material = ObtenerMaterialComoString(b.material),
                                 PrecioMayor = b.precioMayor,
                                 Tipo = "Blusa"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar blusas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerCasacasReal()
        {
            try
            {
                var casacaWS = new PackagePrendas.CasacaWSClient();
                var casacas = casacaWS.listarCasacas();

                return casacas.Where(c => c != null && c.activo)
                             .Select(c => new PrendaViewModel
                             {
                                 Id = c.idPrenda,
                                 Nombre = c.nombre,
                                 Color = c.color ?? "",
                                 Material = ObtenerMaterialComoString(c.material),
                                 PrecioMayor = c.precioMayor,
                                 Tipo = "Casaca"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar casacas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerFaldasReal()
        {
            try
            {
                var faldaWS = new PackagePrendas.FaldaWSClient();
                var faldas = faldaWS.listarFaldas();

                return faldas.Where(f => f != null && f.activo)
                             .Select(f => new PrendaViewModel
                             {
                                 Id = f.idPrenda,
                                 Nombre = f.nombre,
                                 Color = f.color ?? "",
                                 Material = ObtenerMaterialComoString(f.material),
                                 PrecioMayor = f.precioMayor,
                                 Tipo = "Falda"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar faldas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerGorrosReal()
        {
            try
            {
                var gorroWS = new PackagePrendas.GorroWSClient();
                var gorros = gorroWS.listarGorros();

                return gorros.Where(g => g != null && g.activo)
                             .Select(g => new PrendaViewModel
                             {
                                 Id = g.idPrenda,
                                 Nombre = g.nombre,
                                 Color = g.color ?? "",
                                 Material = ObtenerMaterialComoString(g.material),
                                 PrecioMayor = g.precioMayor,
                                 Tipo = "Gorro"
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar gorros: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPantalonesReal()
        {
            try
            {
                var pantalonWS = new PackagePrendas.PantalonWSClient();
                var pantalones = pantalonWS.listarPantalones();

                return pantalones.Where(p => p != null && p.activo)
                                 .Select(p => new PrendaViewModel
                                 {
                                     Id = p.idPrenda,
                                     Nombre = p.nombre,
                                     Color = p.color ?? "",
                                     Material = ObtenerMaterialComoString(p.material),
                                     PrecioMayor = p.precioMayor,
                                     Tipo = "Pantalon"
                                 }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar pantalones: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPolosReal()
        {
            try
            {
                var poloWS = new PackagePrendas.PoloWSClient();
                var polos = poloWS.listarPolos();

                return polos.Where(p => p != null && p.activo)
                            .Select(p => new PrendaViewModel
                            {
                                Id = p.idPrenda,
                                Nombre = p.nombre,
                                Color = p.color ?? "",
                                Material = ObtenerMaterialComoString(p.material),
                                PrecioMayor = p.precioMayor,
                                Tipo = "Polo"
                            }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar polos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerVestidosReal()
        {
            try
            {
                var vestidoWS = new PackagePrendas.VestidoWSClient();
                var vestidos = vestidoWS.listarVestidos();

                return vestidos.Where(v => v != null && v.activo)
                               .Select(v => new PrendaViewModel
                               {
                                   Id = v.idPrenda,
                                   Nombre = v.nombre,
                                   Color = v.color ?? "",
                                   Material = ObtenerMaterialComoString(v.material),
                                   PrecioMayor = v.precioMayor,
                                   Tipo = "Vestido"
                               }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar vestidos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private string ObtenerMaterialComoString(object material)
        {
            if (material == null) return "No especificado";
            try { return material.ToString(); } catch { return "No especificado"; }
        }
        #endregion

        // 🔹 MÉTODO PARA MOSTRAR MENSAJES

        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            if (lblMensaje != null)
            {
                lblMensaje.Text = mensaje;
                lblMensaje.CssClass = $"mensaje-alerta mensaje-{tipo}";
                lblMensaje.Visible = true;

                ScriptManager.RegisterStartupScript(this, GetType(), "ocultarMensaje",
                    $"setTimeout(function() {{ document.getElementById('{lblMensaje.ClientID}').style.display = 'none'; }}, 5000);", true);
            }
        }

        protected void btnRegresarAnnadirProd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegistarVentas.aspx");
        }

        protected void btnAnadirProducto_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("=== BOTÓN AÑADIR/ACTUALIZAR PRODUCTO CLICKEADO ===");

            try
            {
                // 1. VALIDAR PRENDA SELECCIONADA
                if (IdPrendaSeleccionada == 0)
                {
                    MostrarMensaje("Por favor, seleccione una prenda antes de continuar.", "error");
                    return;
                }

                // 2. VALIDAR TALLA
                if (string.IsNullOrEmpty(hdnTallaSeleccionada.Value))
                {
                    MostrarMensaje("Por favor, seleccione una talla.", "error");
                    return;
                }

                // 3. VALIDAR CANTIDAD
                if (string.IsNullOrEmpty(txtCantidadRequerida.Text) ||
                    !int.TryParse(txtCantidadRequerida.Text, out int cantidad) ||
                    cantidad <= 0)
                {
                    MostrarMensaje("Por favor, ingrese una cantidad válida mayor a cero.", "error");
                    return;
                }

                // 4. VALIDAR STOCK
                if (!ValidarStockDisponible(cantidad))
                {
                    return;
                }

                // 5. CREAR/ACTUALIZAR OBJETO ITEM VENTA
                var itemActualizado = CrearItemVenta(cantidad);

                // 6. VERIFICAR SI ESTAMOS EN MODO MODIFICAR
                string modo = Request.QueryString["modo"];
                if (modo == "modificar")
                {
                    // 🔹 MODO MODIFICAR: ACTUALIZAR LÍNEA EXISTENTE
                    ActualizarLineaExistente(itemActualizado);
                }
                else
                {
                    // 🔹 MODO NUEVO: AGREGAR NUEVA LÍNEA
                    GuardarItemEnSesion(itemActualizado);
                }

                // 🔹 VERIFICACIÓN FINAL ANTES DE REDIRIGIR
                var lineasFinal = Session["LineasVenta"] as List<VentaWS.itemVenta>;
                if (lineasFinal == null || lineasFinal.Count == 0)
                {
                    System.Diagnostics.Debug.WriteLine("💥 ERROR CRÍTICO: La lista de líneas está VACÍA después de guardar");
                    MostrarMensaje("ERROR: No se pudo guardar el producto en la venta. Por favor, intente nuevamente.", "error");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"✅ VERIFICACIÓN FINAL EXITOSA: {lineasFinal.Count} productos en la venta");

                // 7. PREPARAR REDIRECCIÓN
                PrepararRedireccion();

                // 8. REDIRIGIR
                System.Diagnostics.Debug.WriteLine("🔄 Redirigiendo a RegistarVentas.aspx...");
                Response.Redirect("~/RegistarVentas.aspx");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en btnAnadirProducto_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"💥 StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al procesar producto: {ex.Message}", "error");
            }
        }


        // 🔹 MÉTODO PARA DIAGNOSTICAR EL ESTADO DE LA SESIÓN
        private void DiagnosticarSesion()
        {
            System.Diagnostics.Debug.WriteLine("=== DIAGNÓSTICO DE SESIÓN ===");

            // Verificar si la sesión existe
            if (Session == null)
            {
                System.Diagnostics.Debug.WriteLine("❌ SESIÓN ES NULL");
                return;
            }

            // Verificar LineasVenta
            if (Session["LineasVenta"] == null)
            {
                System.Diagnostics.Debug.WriteLine("❌ Session['LineasVenta'] es NULL");
            }
            else
            {
                var lineas = Session["LineasVenta"] as List<VentaWS.itemVenta>;
                if (lineas == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ Session['LineasVenta'] no es una List<VentaWS.itemVenta>");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Session['LineasVenta'] tiene {lineas.Count} elementos");
                }
            }

            // Verificar otras sesiones importantes
            System.Diagnostics.Debug.WriteLine($"Session['VieneDeAnadirProducto']: {Session["VieneDeAnadirProducto"]}");
            System.Diagnostics.Debug.WriteLine($"Session['VieneDeModificarProducto']: {Session["VieneDeModificarProducto"]}");
            System.Diagnostics.Debug.WriteLine($"Session ID: {Session.SessionID}");

            System.Diagnostics.Debug.WriteLine("=== FIN DIAGNÓSTICO ===");
        }


        // 🔹 CORREGIDO: Actualizar línea existente
        private void ActualizarLineaExistente(VentaWS.itemVenta itemActualizado)
        {
            try
            {
                // 🔹 OBTENER DATOS DE MODIFICACIÓN DESDE SESIÓN
                var productoOriginal = Session["ProductoSeleccionadoModificar"] as VentaWS.itemVenta;
                int indiceOriginal = Session["IndiceProductoModificar"] != null ? (int)Session["IndiceProductoModificar"] : -1;

                if (productoOriginal != null && indiceOriginal >= 0)
                {
                    System.Diagnostics.Debug.WriteLine($"🔹 Actualizando línea existente en índice: {indiceOriginal}");

                    // 🔹 MANTENER EL NÚMERO DE LÍNEA ORIGINAL
                    itemActualizado.numLinea = productoOriginal.numLinea;

                    // 🔹 CORRECCIÓN: USAR LA MISMA SESIÓN
                    var lineasVenta = Session["LineasVenta"] as List<VentaWS.itemVenta>;
                    if (lineasVenta != null && indiceOriginal < lineasVenta.Count)
                    {
                        lineasVenta[indiceOriginal] = itemActualizado;
                        Session["LineasVenta"] = lineasVenta;

                        System.Diagnostics.Debug.WriteLine($"✅ Línea ACTUALIZADA correctamente:");
                        System.Diagnostics.Debug.WriteLine($"   - Índice: {indiceOriginal}");
                        System.Diagnostics.Debug.WriteLine($"   - Nº Línea: {itemActualizado.numLinea}");
                        System.Diagnostics.Debug.WriteLine($"   - Nueva cantidad: {itemActualizado.cantidad}");
                        System.Diagnostics.Debug.WriteLine($"   - Nueva talla: {itemActualizado.talla}");
                        System.Diagnostics.Debug.WriteLine($"   - Nuevo subtotal: S/ {itemActualizado.subtotal:0.00}");

                        MostrarMensaje("Producto actualizado correctamente en la venta.", "exito");
                    }
                    else
                    {
                        throw new Exception("No se encontró la lista de líneas de venta o el índice es inválido");
                    }

                    // 🔹 MARCAR QUE VENIMOS DE MODIFICAR PRODUCTO
                    Session["VieneDeModificarProducto"] = true;
                }
                else
                {
                    throw new Exception("No se encontraron los datos originales para la modificación");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en ActualizarLineaExistente: {ex.Message}");
                throw;
            }
        }


        // 🔹 MEJORADO: Crear item venta con mejor información
        private VentaWS.itemVenta CrearItemVenta(int cantidad)
        {
            try
            {
                // 🔹 CORRECCIÓN: Usar el subtotal ACTUAL (con promociones/descuentos aplicados)
                double subtotalFinal = 0;

                // Verificar si hay un subtotal con promociones/descuentos aplicado
                if (ViewState["TotalConPromociones"] != null)
                {
                    subtotalFinal = (double)ViewState["TotalConPromociones"];
                    System.Diagnostics.Debug.WriteLine($"🔹 Usando subtotal con promociones: S/ {subtotalFinal:0.00}");
                }
                else if (ViewState["TotalConDescuentos"] != null)
                {
                    subtotalFinal = (double)ViewState["TotalConDescuentos"];
                    System.Diagnostics.Debug.WriteLine($"🔹 Usando subtotal con descuentos: S/ {subtotalFinal:0.00}");
                }
                else
                {
                    // Usar el subtotal del campo
                    if (double.TryParse(txtSubtotal.Text, out double subtotalActual))
                    {
                        subtotalFinal = subtotalActual;
                        System.Diagnostics.Debug.WriteLine($"🔹 Usando subtotal del campo: S/ {subtotalFinal:0.00}");
                    }
                    else
                    {
                        // Fallback al subtotal base
                        subtotalFinal = CalcularSubtotal();
                        System.Diagnostics.Debug.WriteLine($"🔹 Usando subtotal base: S/ {subtotalFinal:0.00}");
                    }
                }

                var item = new VentaWS.itemVenta
                {
                    idPrenda = IdPrendaSeleccionada,
                    cantidad = cantidad,
                    talla = ConvertirStringATalla(hdnTallaSeleccionada.Value),
                    subtotal = subtotalFinal,
                    activo = true
                };
                item.tallaSpecified = true;

                // 🔹 EL NÚMERO DE LÍNEA SE ASIGNARÁ AL GUARDAR EN SESIÓN
                System.Diagnostics.Debug.WriteLine($"🆕 Item creado: ID={item.idPrenda}, Cantidad={item.cantidad}, " +
                                                  $"Talla={item.talla}, Subtotal FINAL=S/ {item.subtotal:0.00}");

                return item;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CrearItemVenta: {ex.Message}");
                throw;
            }
        }


        // 🔹 CORREGIDO: Método para guardar item en sesión (CON INICIALIZACIÓN)
        private void GuardarItemEnSesion(VentaWS.itemVenta item)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("=== INICIANDO GUARDADO EN SESIÓN ===");

                // 🔹 INICIALIZAR SI ES NULL
                if (Session["LineasVenta"] == null)
                {
                    Session["LineasVenta"] = new List<VentaWS.itemVenta>();
                    System.Diagnostics.Debug.WriteLine("🆕 Lista LineasVenta INICIALIZADA en sesión");
                }

                var lineasExistentes = Session["LineasVenta"] as List<VentaWS.itemVenta>;

                if (lineasExistentes == null)
                {
                    System.Diagnostics.Debug.WriteLine("💥 ERROR: lineasExistentes es NULL después de inicializar");
                    throw new Exception("No se pudo inicializar la lista de líneas de venta");
                }

                // 🔹 ASIGNAR NÚMERO DE LÍNEA CORRECTO
                item.numLinea = lineasExistentes.Count + 1;
                System.Diagnostics.Debug.WriteLine($"🔹 Número de línea asignado: {item.numLinea}");

                // Agregar el nuevo item
                lineasExistentes.Add(item);

                // 🔹 FORZAR ACTUALIZACIÓN DE LA SESIÓN
                Session["LineasVenta"] = lineasExistentes;

                // 🔹 VERIFICACIÓN INMEDIATA
                var lineasVerificadas = Session["LineasVenta"] as List<VentaWS.itemVenta>;
                if (lineasVerificadas == null || lineasVerificadas.Count == 0)
                {
                    System.Diagnostics.Debug.WriteLine("💥 ERROR CRÍTICO: La sesión no se actualizó correctamente");
                    throw new Exception("Fallo crítico al actualizar la sesión");
                }

                System.Diagnostics.Debug.WriteLine($"✅ Item GUARDADO EXITOSAMENTE en sesión:");
                System.Diagnostics.Debug.WriteLine($"   - ID Prenda: {item.idPrenda}");
                System.Diagnostics.Debug.WriteLine($"   - Cantidad: {item.cantidad}");
                System.Diagnostics.Debug.WriteLine($"   - Talla: {item.talla}");
                System.Diagnostics.Debug.WriteLine($"   - Subtotal: S/ {item.subtotal:0.00}");
                System.Diagnostics.Debug.WriteLine($"   - Nº Línea: {item.numLinea}");
                System.Diagnostics.Debug.WriteLine($"   - Total líneas ahora: {lineasVerificadas.Count}");

                // 🔹 VERIFICACIÓN EXTRA: Mostrar todas las líneas
                System.Diagnostics.Debug.WriteLine("=== CONTENIDO ACTUAL DE LineasVenta ===");
                foreach (var linea in lineasVerificadas)
                {
                    System.Diagnostics.Debug.WriteLine($"   - Línea {linea.numLinea}: Prenda {linea.idPrenda}, " +
                        $"Cantidad {linea.cantidad}, Subtotal S/ {linea.subtotal:0.00}");
                }
                System.Diagnostics.Debug.WriteLine("=== FIN CONTENIDO ===");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR CRÍTICO en GuardarItemEnSesion: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"💥 StackTrace: {ex.StackTrace}");
                throw;
            }
        }


        private int ObtenerProximoNumeroLinea()
        {
            var lineasExistentes = HttpContext.Current.Session["LineasVenta"] as List<VentaWS.itemVenta>;
            return (lineasExistentes?.Count ?? 0) + 1;
        }

        private bool ValidarStockDisponible(int cantidadRequerida)
        {
            var stockPorTalla = ObtenerStockPorTalla();
            string tallaSeleccionada = hdnTallaSeleccionada.Value;

            if (stockPorTalla.ContainsKey(tallaSeleccionada))
            {
                int stockDisponible = stockPorTalla[tallaSeleccionada];

                if (cantidadRequerida > stockDisponible)
                {
                    MostrarMensaje(
                        $"La cantidad requerida ({cantidadRequerida}) no puede ser mayor al stock disponible ({stockDisponible}) para la talla {tallaSeleccionada}.",
                        "error");
                    return false;
                }
                return true;
            }
            else
            {
                MostrarMensaje("No se encontró stock disponible para la talla seleccionada.", "error");
                return false;
            }
        }


        private void PrepararRedireccion()
        {
            string modo = Request.QueryString["modo"];

            if (modo == "modificar")
            {
                // 🔹 MODO MODIFICAR: Marcar que venimos de modificar producto
                Session["VieneDeModificarProducto"] = true;
                System.Diagnostics.Debug.WriteLine("🔀 Redirección preparada con flag VieneDeModificarProducto");
            }
            else
            {
                // 🔹 MODO NUEVO: Marcar que venimos de añadir producto
                Session["VieneDeAnadirProducto"] = true;
                System.Diagnostics.Debug.WriteLine("🔀 Redirección preparada con flag VieneDeAnadirProducto");
            }

            // 🔹 LIMPIAR DATOS DE MODIFICACIÓN
            Session.Remove("ProductoSeleccionadoModificar");
            Session.Remove("IndiceProductoModificar");
        }









        // 🔹 MÉTODO PARA CONVERTIR STRING A TALLA ENUM
        private VentaWS.talla ConvertirStringATalla(string tallaString)
        {
            if (string.IsNullOrEmpty(tallaString)) return VentaWS.talla.M;

            switch (tallaString.ToUpper())
            {
                case "XS": return VentaWS.talla.XS;
                case "S": return VentaWS.talla.S;
                case "M": return VentaWS.talla.M;
                case "L": return VentaWS.talla.L;
                case "XL": return VentaWS.talla.XL;
                case "XXL": return VentaWS.talla.XXL;
                default: return VentaWS.talla.M;
            }
        }


        // 🔹 VALIDAR CANTIDAD REQUERIDA vs DISPONIBLE
        private bool ValidarCantidadRequerida(int cantidadRequerida)
        {
            if (string.IsNullOrEmpty(hdnTallaSeleccionada.Value))
            {
                MostrarMensaje("Por favor, seleccione una talla primero.", "error");
                return false;
            }

            // Obtener stock disponible para la talla seleccionada
            var stockPorTalla = ObtenerStockPorTalla();
            string tallaSeleccionada = hdnTallaSeleccionada.Value;

            if (stockPorTalla.ContainsKey(tallaSeleccionada))
            {
                int stockDisponible = stockPorTalla[tallaSeleccionada];

                if (cantidadRequerida > stockDisponible)
                {
                    MostrarMensaje($"La cantidad requerida ({cantidadRequerida}) no puede ser mayor al stock disponible ({stockDisponible}) para la talla {tallaSeleccionada}.", "error");
                    return false;
                }

                if (cantidadRequerida <= 0)
                {
                    MostrarMensaje("La cantidad requerida debe ser mayor a cero.", "error");
                    return false;
                }

                return true;
            }
            else
            {
                MostrarMensaje("No se encontró stock disponible para la talla seleccionada.", "error");
                return false;
            }
        }

        // 🔹 OBTENER STOCK POR TALLA DESDE EL HIDDEN FIELD
        private Dictionary<string, int> ObtenerStockPorTalla()
        {
            var stockPorTalla = new Dictionary<string, int>();

            try
            {
                if (!string.IsNullOrEmpty(hdnStockPorTalla.Value))
                {
                    var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    stockPorTalla = serializer.Deserialize<Dictionary<string, int>>(hdnStockPorTalla.Value);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al obtener stock por talla: {ex.Message}");
            }

            return stockPorTalla;
        }

        // 🔹 MÉTODO PARA CALCULAR SUBTOTAL CON PRECIOS ESCALONADOS

        private double CalcularSubtotal()
        {
            try
            {
                double precioUnidad = Convert.ToDouble(txtPrecioUnidad.Text);
                double precioMayor = Convert.ToDouble(txtPrecioMayor.Text);
                double precioDocena = Convert.ToDouble(txtPrecioDescuento.Text);
                int cantidad = Convert.ToInt32(txtCantidadRequerida.Text);

                double precioAplicado = precioUnidad;

                if (cantidad >= 6 && cantidad < 12)
                {
                    precioAplicado = precioMayor;
                }
                else if (cantidad >= 12)
                {
                    precioAplicado = precioDocena;
                }

                double subtotal = precioAplicado * cantidad;
                System.Diagnostics.Debug.WriteLine($"🧮 Subtotal calculado: {cantidad} x S/ {precioAplicado} = S/ {subtotal}");

                return subtotal;
            }
            catch
            {
                return 0;
            }
        }






        // 🔹 MÉTODO PARA OBTENER SIGUIENTE NÚMERO DE LÍNEA
        private int ObtenerSiguienteNumLinea()
        {
            var lineasVenta = Session["LineasVenta"] as List<VentaWS.itemVenta>;
            return (lineasVenta?.Count ?? 0) + 1;
        }

        // 🔹 MÉTODO PARA GUARDAR ITEM EN SESIÓN
        private void GuardarItemVentaEnSesion(VentaWS.itemVenta itemVenta)
        {
            var lineasVenta = Session["LineasVenta"] as List<VentaWS.itemVenta>;
            if (lineasVenta == null)
            {
                lineasVenta = new List<VentaWS.itemVenta>();
                Session["LineasVenta"] = lineasVenta;
            }
            lineasVenta.Add(itemVenta);
        }


        // 🔹 CORREGIDO: OBTENER PROMOCIONES COMBO PARA LA PRENDA SELECCIONADA
        private List<PromocionComboWS.promocionCombo> ObtenerPromocionesComboParaPrenda()
        {
            try
            {
                if (IdPrendaSeleccionada == 0)
                {
                    System.Diagnostics.Debug.WriteLine("❌ IdPrendaSeleccionada es 0");
                    return new List<PromocionComboWS.promocionCombo>();
                }

                System.Diagnostics.Debug.WriteLine($"🔹 Buscando promociones para prenda ID: {IdPrendaSeleccionada}");

                var promocionWS = new PromocionComboWSClient();

                // 🔹 CORRECCIÓN: El servicio retorna un array, no una lista
                var promocionesArray = promocionWS.mostrarComboXPrenda(IdPrendaSeleccionada);

                // 🔹 CORRECCIÓN: Verificar si el array es null y luego contar
                if (promocionesArray == null)
                {
                    System.Diagnostics.Debug.WriteLine("🔹 Servicio retornó null");
                    return new List<PromocionComboWS.promocionCombo>();
                }

                System.Diagnostics.Debug.WriteLine($"🔹 Servicio retornó {promocionesArray.Length} promociones");

                // 🔹 CORRECCIÓN CRÍTICA: NO FILTRAR POR ACTIVO - DEJAR QUE EL SERVICIO MANEJE ESTO
                // El servicio ya debería retornar solo promociones activas y vigentes
                var todasLasPromociones = promocionesArray
                    .Where(p => p != null) // Solo eliminar nulos
                    .ToList();

                System.Diagnostics.Debug.WriteLine($"🔹 {todasLasPromociones.Count} promociones después de filtrar nulos");

                // 🔹 DEBUG: Mostrar información de cada promoción
                foreach (var promocion in todasLasPromociones)
                {
                    System.Diagnostics.Debug.WriteLine($"🔹 Promoción: {promocion.nombre}, " +
                        $"ID: {promocion.idPromocion}, " +
                        $"Activo: {promocion.activo}, " +
                        $"Req: {promocion.cantidadRequerida}, " +
                        $"Gratis: {promocion.cantidadGratis}");
                }

                return todasLasPromociones;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al obtener promociones combo: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"❌ StackTrace: {ex.StackTrace}");
                return new List<PromocionComboWS.promocionCombo>();
            }
        }

        // 🔹 CORREGIDO: CALCULAR DESCUENTO POR PROMOCIÓN COMBO
        private (double descuentoAplicado, int prendasGratis) CalcularDescuentoPromocionCombo(int cantidadRequerida, PromocionComboWS.promocionCombo promocion, double precioUnitario)
        {
            try
            {
                if (promocion == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ Promoción es null");
                    return (0, 0);
                }

                if (cantidadRequerida < promocion.cantidadRequerida)
                {
                    System.Diagnostics.Debug.WriteLine($"ℹ️ Cantidad requerida ({cantidadRequerida}) < Cantidad promoción ({promocion.cantidadRequerida}) - No aplica");
                    return (0, 0);
                }

                // Calcular cuántos grupos completos de la promoción se aplican
                int gruposCompletos = cantidadRequerida / promocion.cantidadRequerida;
                int prendasGratis = gruposCompletos * promocion.cantidadGratis;

                // 🔹 CORRECCIÓN: Usar el precio unitario correcto (no siempre el precio unidad)
                double descuentoAplicado = prendasGratis * precioUnitario;

                System.Diagnostics.Debug.WriteLine($"✅ Promoción '{promocion.nombre}': Grupos={gruposCompletos}, Gratis={prendasGratis}, PrecioUnitario=S/ {precioUnitario:0.00}, Descuento=S/ {descuentoAplicado:0.00}");

                return (descuentoAplicado, prendasGratis);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en CalcularDescuentoPromocionCombo: {ex.Message}");
                return (0, 0);
            }
        }

        // 🔹 NUEVO: ACTUALIZAR TOTALES EN EL MODAL
        private void ActualizarTotalesEnModal(double subtotalSinDescuento, double totalDescuento)
        {
            try
            {
                double subtotalConDescuento = subtotalSinDescuento - totalDescuento;

                // 🔹 CORRECCIÓN CRÍTICA: GUARDAR EL SUBTOTAL ACTUALIZADO
                SubtotalActual = subtotalConDescuento;

                string script = $@"
        console.log('Actualizando totales en modal...');
        
        // Actualizar elementos del modal
        var lblSubtotal = document.getElementById('lblSubtotalPromociones');
        var lblDescuento = document.getElementById('lblTotalDescuentoPromociones');
        var lblTotal = document.getElementById('lblTotalConDescuentoPromociones');
        
        if (lblSubtotal) {{
            lblSubtotal.textContent = 'S/ {subtotalSinDescuento:0.00}';
            console.log('Subtotal actualizado: S/ {subtotalSinDescuento:0.00}');
        }} else {{
            console.log('❌ No se encontró lblSubtotalPromociones');
        }}
        
        if (lblDescuento) {{
            lblDescuento.textContent = 'S/ {totalDescuento:0.00}';
            console.log('Descuento actualizado: S/ {totalDescuento:0.00}');
        }} else {{
            console.log('❌ No se encontró lblTotalDescuentoPromociones');
        }}
        
        if (lblTotal) {{
            lblTotal.textContent = 'S/ {subtotalConDescuento:0.00}';
            console.log('Total actualizado: S/ {subtotalConDescuento:0.00}');
        }} else {{
            console.log('❌ No se encontró lblTotalConDescuentoPromociones');
        }}
        
        // También actualizar el subtotal en la página principal
        var txtSubtotalPrincipal = document.getElementById('{txtSubtotal.ClientID}');
        if (txtSubtotalPrincipal) {{
            txtSubtotalPrincipal.value = '{subtotalConDescuento:0.00}';
            console.log('Subtotal principal actualizado: S/ {subtotalConDescuento:0.00}');
        }}
    ";

                ScriptManager.RegisterStartupScript(this, GetType(), "actualizarTotalesModal", script, true);

                // 🔹 ACTUALIZAR TAMBIÉN EN EL BACKEND
                txtSubtotal.Text = subtotalConDescuento.ToString("0.00");

                System.Diagnostics.Debug.WriteLine($"✅ SubtotalActual guardado: S/ {SubtotalActual:0.00}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en ActualizarTotalesEnModal: {ex.Message}");
            }
        }

        // 🔹 CORREGIDO: CARGAR PROMOCIONES EN MODAL
        // 🔹 CORREGIDO: CARGAR PROMOCIONES EN MODAL
        // 🔹 CORREGIDO: CARGAR PROMOCIONES EN MODAL
        private void CargarPromocionesEnModal()
        {
            try
            {
                if (IdPrendaSeleccionada == 0)
                {
                    MostrarMensaje("No hay ninguna prenda seleccionada.", "error");
                    return;
                }

                // Obtener cantidad requerida
                int cantidadRequerida = int.TryParse(txtCantidadRequerida.Text, out int cant) ? cant : 0;
                System.Diagnostics.Debug.WriteLine($"🔹 Cantidad requerida: {cantidadRequerida}");

                // Obtener precio unitario correcto según cantidad
                double precioUnitario = ObtenerPrecioUnitarioSegunCantidad(cantidadRequerida);
                System.Diagnostics.Debug.WriteLine($"🔹 Precio unitario aplicado: S/ {precioUnitario:0.00}");

                // Obtener promociones para la prenda
                var promociones = ObtenerPromocionesComboParaPrenda();

                System.Diagnostics.Debug.WriteLine($"🔹 Encontradas {promociones.Count} promociones para prenda ID: {IdPrendaSeleccionada}");

                // Crear lista para el GridView
                var promocionesConDescuento = new List<PromocionComboViewModel>();
                double totalDescuento = 0;
                double subtotalSinDescuento = 0;

                // Calcular subtotal sin descuento
                subtotalSinDescuento = precioUnitario * cantidadRequerida;

                if (promociones != null && promociones.Count > 0)
                {
                    foreach (var promocion in promociones)
                    {
                        System.Diagnostics.Debug.WriteLine($"🔹 Procesando promoción: {promocion.nombre}, Req: {promocion.cantidadRequerida}, Gratis: {promocion.cantidadGratis}");

                        var (descuentoAplicado, prendasGratis) = CalcularDescuentoPromocionCombo(cantidadRequerida, promocion, precioUnitario);

                        promocionesConDescuento.Add(new PromocionComboViewModel
                        {
                            IdPromocion = promocion.idPromocion,
                            Nombre = promocion.nombre,
                            CantidadRequerida = promocion.cantidadRequerida,
                            CantidadGratis = promocion.cantidadGratis,
                            Aplica = descuentoAplicado > 0,
                            PrendasGratis = prendasGratis,
                            DescuentoAplicado = descuentoAplicado
                        });

                        if (descuentoAplicado > 0)
                        {
                            totalDescuento += descuentoAplicado;
                        }

                        System.Diagnostics.Debug.WriteLine($"🔹 Promoción '{promocion.nombre}': Aplica={descuentoAplicado > 0}, Descuento=S/ {descuentoAplicado:0.00}");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No se encontraron promociones para esta prenda");
                }

                // Asignar al GridView
                gvPromociones.DataSource = promocionesConDescuento;
                gvPromociones.DataBind();

                // 🔹 CORREGIDO: ACTUALIZAR TOTALES EN EL MODAL
                ActualizarTotalesEnModal(subtotalSinDescuento, totalDescuento);

                System.Diagnostics.Debug.WriteLine($"✅ Promociones cargadas: {promocionesConDescuento.Count}, Subtotal: S/ {subtotalSinDescuento:0.00}, Descuento: S/ {totalDescuento:0.00}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en CargarPromocionesEnModal: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"❌ StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al cargar promociones: {ex.Message}", "error");
            }
        }

        private double ObtenerPrecioUnitarioSegunCantidad(int cantidad)
        {
            try
            {
                double precioUnidad = Convert.ToDouble(txtPrecioUnidad.Text);
                double precioMayor = Convert.ToDouble(txtPrecioMayor.Text);
                double precioDocena = Convert.ToDouble(txtPrecioDescuento.Text);

                if (cantidad >= 12)
                    return precioDocena;
                else if (cantidad >= 6)
                    return precioMayor;
                else
                    return precioUnidad;
            }
            catch
            {
                return Convert.ToDouble(txtPrecioUnidad.Text);
            }
        }



        // 🔹 MODIFICADO: EVENTO DEL BOTÓN PROMOCIONES APLICADAS
        protected void btnPromocionesAplicadas_Click(object sender, EventArgs e)
        {
            if (IdPrendaSeleccionada == 0)
            {
                MostrarMensaje("Por favor, seleccione una prenda primero.", "error");
                return;
            }

            if (string.IsNullOrEmpty(txtCantidadRequerida.Text) || !int.TryParse(txtCantidadRequerida.Text, out int cantidad) || cantidad <= 0)
            {
                MostrarMensaje("Por favor, ingrese una cantidad válida mayor a cero.", "error");
                return;
            }

            try
            {
                // 🔹 PRIMERO ACTUALIZAR EL SUBTOTAL BASE
                ActualizarSubtotalBase();

                // Cargar promociones en el modal (esto ahora actualiza los totales)
                CargarPromocionesEnModal();

                // 🔹 ACTUALIZAR EL UPDATE PANEL PARA REFLEJAR CAMBIOS
                UpdatePanel1.Update();

                // 🔹 MOSTRAR EL MODAL DESPUÉS DE ACTUALIZAR
                string script = @"
            console.log('Mostrando modal de promociones después de actualizar datos...');
            var modal = new bootstrap.Modal(document.getElementById('modalPromociones'));
            modal.show();
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalPromociones", script, true);

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al mostrar promociones: {ex.Message}", "error");
            }
        }


        private int ObtenerStockTotalDisponible()
        {
            try
            {
                if (!string.IsNullOrEmpty(hdnTallaSeleccionada.Value))
                {
                    var stockPorTalla = ObtenerStockPorTalla();
                    if (stockPorTalla.ContainsKey(hdnTallaSeleccionada.Value))
                    {
                        return stockPorTalla[hdnTallaSeleccionada.Value];
                    }
                }
                return 0;
            }
            catch
            {
                return 0;
            }
        }

        // 🔹 MÉTODO PRINCIPAL PARA CARGAR DESCUENTOS


        private void CargarDescuentosEnModal()
        {
            try
            {
                if (IdPrendaSeleccionada == 0)
                {
                    MostrarMensaje("No hay ninguna prenda seleccionada.", "error");
                    return;
                }

                // 🔹 CORRECCIÓN: Usar el subtotal actual (puede ser el modificado por promociones)
                double subtotalInicial = SubtotalActual > 0 ? SubtotalActual : CalcularSubtotal();

                System.Diagnostics.Debug.WriteLine($"🔹 SubtotalActual: S/ {SubtotalActual:0.00}");
                System.Diagnostics.Debug.WriteLine($"🔹 Subtotal calculado: S/ {CalcularSubtotal():0.00}");
                System.Diagnostics.Debug.WriteLine($"🔹 Subtotal inicial para descuentos: S/ {subtotalInicial:0.00}");

                // 🔹 ACTUALIZAR EL SUBTOTAL EN PANTALLA POR SI ACASO
                txtSubtotal.Text = subtotalInicial.ToString("0.00");

                // Obtener stock disponible para validar descuentos de liquidación
                int stockDisponible = ObtenerStockTotalDisponible();

                // Obtener descuentos de cada tipo
                var descuentosLiquidacion = ObtenerDescuentosLiquidacionParaPrenda(stockDisponible, subtotalInicial);
                var descuentosPorcentaje = ObtenerDescuentosPorcentajeParaPrenda(subtotalInicial);
                var descuentosMonto = ObtenerDescuentosMontoParaPrenda(subtotalInicial);

                // Seleccionar el mejor descuento de cada tipo
                var mejorLiquidacion = SeleccionarMejorDescuentoLiquidacion(descuentosLiquidacion);
                var mejorPorcentaje = SeleccionarMejorDescuentoPorcentaje(descuentosPorcentaje);
                var mejorMonto = SeleccionarMejorDescuentoMonto(descuentosMonto);

                // Calcular aplicación secuencial de descuentos
                var resultadoDescuentos = CalcularDescuentosSecuenciales(subtotalInicial, mejorLiquidacion, mejorPorcentaje, mejorMonto);

                // 🔹 CORRECCIÓN CRÍTICA: SI NO HAY DESCUENTOS, USAR EL SUBTOTAL INICIAL
                if (resultadoDescuentos.totalDescuentos == 0)
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No se aplicaron descuentos - usando subtotal inicial");
                    resultadoDescuentos.totalConDescuentos = subtotalInicial;
                }

                // 🔹 DEBUG DETALLADO
                System.Diagnostics.Debug.WriteLine($"=== RESUMEN CÁLCULO DESCUENTOS ===");
                System.Diagnostics.Debug.WriteLine($"Subtotal inicial: S/ {subtotalInicial:0.00}");
                System.Diagnostics.Debug.WriteLine($"Total descuentos: S/ {resultadoDescuentos.totalDescuentos:0.00}");
                System.Diagnostics.Debug.WriteLine($"Total con descuentos: S/ {resultadoDescuentos.totalConDescuentos:0.00}");
                System.Diagnostics.Debug.WriteLine($"=== FIN RESUMEN ===");

                // Actualizar GridViews
                gvDescuentosLiquidacion.DataSource = descuentosLiquidacion;
                gvDescuentosLiquidacion.DataBind();

                gvDescuentosPorcentaje.DataSource = descuentosPorcentaje;
                gvDescuentosPorcentaje.DataBind();

                gvDescuentosMonto.DataSource = descuentosMonto;
                gvDescuentosMonto.DataBind();

                // 🔹 CORRECCIÓN: GUARDAR EN VIEWSTATE ANTES DE ACTUALIZAR EL MODAL
                ViewState["TotalConDescuentos"] = resultadoDescuentos.totalConDescuentos;
                System.Diagnostics.Debug.WriteLine($"✅ ViewState['TotalConDescuentos'] establecido: S/ {resultadoDescuentos.totalConDescuentos:0.00}");

                // Actualizar resumen en el modal
                ActualizarResumenDescuentosEnModal(subtotalInicial, resultadoDescuentos);

                System.Diagnostics.Debug.WriteLine($"✅ Descuentos cargados - Liquidación: {mejorLiquidacion?.DescuentoAplicado ?? 0:0.00}, " +
                    $"Porcentaje: {mejorPorcentaje?.DescuentoAplicado ?? 0:0.00}, Monto: {mejorMonto?.DescuentoAplicado ?? 0:0.00}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en CargarDescuentosEnModal: {ex.Message}");
                MostrarMensaje($"Error al cargar descuentos: {ex.Message}", "error");
            }
        }

        // 🔹 OBTENER DESCUENTOS DE LIQUIDACIÓN
        private List<DescuentoLiquidacionViewModel> ObtenerDescuentosLiquidacionParaPrenda(int stockDisponible, double subtotalInicial)
        {
            try
            {
                var descuentoWS = new DescuentoLiquidacionWSClient();
                var descuentosArray = descuentoWS.mostrarLiquidacionXPrenda(IdPrendaSeleccionada);

                var descuentos = new List<DescuentoLiquidacionViewModel>();

                if (descuentosArray != null)
                {
                    foreach (var desc in descuentosArray)
                    {
                        if (desc != null && desc.activo)
                        {
                            bool aplica = stockDisponible <= desc.condicionStockMin;
                            double descuentoAplicado = aplica ? subtotalInicial * (desc.porcentajeLiquidacion / 100) : 0;

                            descuentos.Add(new DescuentoLiquidacionViewModel
                            {
                                IdDescuento = desc.idDescuento,
                                Nombre = desc.nombre,
                                PorcentajeLiquidacion = desc.porcentajeLiquidacion,
                                CondicionStockMin = desc.condicionStockMin,
                                Aplica = aplica,
                                DescuentoAplicado = descuentoAplicado
                            });
                        }
                    }
                }

                return descuentos;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al obtener descuentos liquidación: {ex.Message}");
                return new List<DescuentoLiquidacionViewModel>();
            }
        }


        // 🔹 OBTENER DESCUENTOS POR PORCENTAJE
        private List<DescuentoPorcentajeViewModel> ObtenerDescuentosPorcentajeParaPrenda(double subtotalInicial)
        {
            try
            {
                var descuentoWS = new DescuentoPorcentajeWSClient();
                var descuentosArray = descuentoWS.mostrarPorcentajeXPrenda(IdPrendaSeleccionada);

                var descuentos = new List<DescuentoPorcentajeViewModel>();

                if (descuentosArray != null)
                {
                    foreach (var desc in descuentosArray)
                    {
                        if (desc != null && desc.activo)
                        {
                            double descuentoAplicado = subtotalInicial * (desc.porcentaje / 100);

                            descuentos.Add(new DescuentoPorcentajeViewModel
                            {
                                IdDescuento = desc.idDescuento,
                                Nombre = desc.nombre,
                                Porcentaje = desc.porcentaje,
                                Aplica = true, // Todos aplican por defecto
                                DescuentoAplicado = descuentoAplicado
                            });
                        }
                    }
                }

                return descuentos;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al obtener descuentos porcentaje: {ex.Message}");
                return new List<DescuentoPorcentajeViewModel>();
            }
        }

        // 🔹 OBTENER DESCUENTOS POR MONTO
        private List<DescuentoMontoViewModel> ObtenerDescuentosMontoParaPrenda(double subtotalInicial)
        {
            try
            {
                var descuentoWS = new DescuentoMontoWSClient();
                var descuentosArray = descuentoWS.mostrarMontoXPrenda(IdPrendaSeleccionada);

                var descuentos = new List<DescuentoMontoViewModel>();

                if (descuentosArray != null)
                {
                    foreach (var desc in descuentosArray)
                    {
                        if (desc != null && desc.activo)
                        {
                            // Usar el monto editable como porcentaje de descuento
                            double porcentajeDescuento = desc.montoEditable; // Asumiendo que montoEditable es el porcentaje
                            double descuentoAplicado = subtotalInicial * (porcentajeDescuento / 100);

                            // Validar que no exceda el monto máximo
                            if (descuentoAplicado > desc.montoMaximo)
                            {
                                descuentoAplicado = desc.montoMaximo;
                            }

                            descuentos.Add(new DescuentoMontoViewModel
                            {
                                IdDescuento = desc.idDescuento,
                                Nombre = desc.nombre,
                                MontoEditable = desc.montoEditable,
                                MontoMaximo = desc.montoMaximo,
                                Aplica = true, // Todos aplican por defecto
                                DescuentoAplicado = descuentoAplicado
                            });
                        }
                    }
                }

                return descuentos;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error al obtener descuentos monto: {ex.Message}");
                return new List<DescuentoMontoViewModel>();
            }
        }

        // 🔹 SELECCIONAR MEJOR DESCUENTO DE CADA TIPO
        private DescuentoLiquidacionViewModel SeleccionarMejorDescuentoLiquidacion(List<DescuentoLiquidacionViewModel> descuentos)
        {
            return descuentos.Where(d => d.Aplica).OrderByDescending(d => d.DescuentoAplicado).FirstOrDefault();
        }

        private DescuentoPorcentajeViewModel SeleccionarMejorDescuentoPorcentaje(List<DescuentoPorcentajeViewModel> descuentos)
        {
            return descuentos.OrderByDescending(d => d.DescuentoAplicado).FirstOrDefault();
        }

        private DescuentoMontoViewModel SeleccionarMejorDescuentoMonto(List<DescuentoMontoViewModel> descuentos)
        {
            return descuentos.OrderByDescending(d => d.DescuentoAplicado).FirstOrDefault();
        }

        // 🔹 CALCULAR DESCUENTOS SECUENCIALES
        private (double totalDescuentos, double totalConDescuentos,
          double descLiquidacion, double descPorcentaje, double descMonto)
          CalcularDescuentosSecuenciales(double subtotalInicial,
          DescuentoLiquidacionViewModel liquidacion,
          DescuentoPorcentajeViewModel porcentaje,
          DescuentoMontoViewModel monto)
        {
            double montoActual = subtotalInicial;
            double descLiquidacion = 0;
            double descPorcentaje = 0;
            double descMonto = 0;

            System.Diagnostics.Debug.WriteLine($"🔹 Cálculo descuentos - Subtotal inicial: S/ {subtotalInicial:0.00}");

            // 1. Aplicar descuento de liquidación
            if (liquidacion != null && liquidacion.Aplica)
            {
                descLiquidacion = liquidacion.DescuentoAplicado;
                montoActual -= descLiquidacion;
                System.Diagnostics.Debug.WriteLine($"🔹 Descuento liquidación: S/ {descLiquidacion:0.00}, Monto después: S/ {montoActual:0.00}");
            }

            // 2. Aplicar descuento por porcentaje sobre el resultado anterior
            if (porcentaje != null)
            {
                descPorcentaje = montoActual * (porcentaje.Porcentaje / 100);
                montoActual -= descPorcentaje;
                System.Diagnostics.Debug.WriteLine($"🔹 Descuento porcentaje: S/ {descPorcentaje:0.00}, Monto después: S/ {montoActual:0.00}");
            }

            // 3. Aplicar descuento por monto sobre el resultado anterior
            if (monto != null)
            {
                // Recalcular el descuento por monto basado en el monto actual
                double porcentajeDescuento = monto.MontoEditable;
                descMonto = montoActual * (porcentajeDescuento / 100);

                // Validar monto máximo
                if (descMonto > monto.MontoMaximo)
                {
                    descMonto = monto.MontoMaximo;
                }

                montoActual -= descMonto;
                System.Diagnostics.Debug.WriteLine($"🔹 Descuento monto: S/ {descMonto:0.00}, Monto después: S/ {montoActual:0.00}");
            }

            double totalDescuentos = descLiquidacion + descPorcentaje + descMonto;

            System.Diagnostics.Debug.WriteLine($"🔹 RESUMEN FINAL - Total descuentos: S/ {totalDescuentos:0.00}, Total con descuentos: S/ {montoActual:0.00}");

            return (totalDescuentos, montoActual, descLiquidacion, descPorcentaje, descMonto);
        }

        // 🔹 MEJORADO: ACTUALIZAR RESUMEN EN MODAL CON VALIDACIONES
        private void ActualizarResumenDescuentosEnModal(double subtotalInicial,
       (double totalDescuentos, double totalConDescuentos,
        double descLiquidacion, double descPorcentaje, double descMonto) resultado)
        {
            try
            {
                // 🔹 VALIDACIONES CRÍTICAS
                if (resultado.totalConDescuentos > subtotalInicial)
                {
                    System.Diagnostics.Debug.WriteLine($"⚠️ AJUSTANDO: Total con descuentos ({resultado.totalConDescuentos:0.00}) > Subtotal ({subtotalInicial:0.00})");
                    resultado.totalConDescuentos = subtotalInicial;
                    resultado.totalDescuentos = 0;
                }

                if (resultado.totalConDescuentos < 0)
                {
                    System.Diagnostics.Debug.WriteLine($"⚠️ AJUSTANDO: Total con descuentos negativo: {resultado.totalConDescuentos:0.00}");
                    resultado.totalConDescuentos = 0;
                    resultado.totalDescuentos = subtotalInicial;
                }

                System.Diagnostics.Debug.WriteLine($"🔹 RESUMEN - Subtotal inicial: S/ {subtotalInicial:0.00}");
                System.Diagnostics.Debug.WriteLine($"🔹 RESUMEN - Total descuentos: S/ {resultado.totalDescuentos:0.00}");
                System.Diagnostics.Debug.WriteLine($"🔹 RESUMEN - Total con descuentos: S/ {resultado.totalConDescuentos:0.00}");

                string script = $@"
    // Actualizar subtotal inicial
    document.getElementById('lblSubtotalInicialDescuentos').textContent = 'S/ {subtotalInicial:0.00}';
    
    // Actualizar descuentos individuales
    document.getElementById('lblDescLiquidacionResumen').textContent = 'S/ {resultado.descLiquidacion:0.00}';
    document.getElementById('lblDescPorcentajeResumen').textContent = 'S/ {resultado.descPorcentaje:0.00}';
    document.getElementById('lblDescMontoResumen').textContent = 'S/ {resultado.descMonto:0.00}';
    
    // Actualizar totales
    document.getElementById('lblTotalDescuentosAplicados').textContent = 'S/ {resultado.totalDescuentos:0.00}';
    document.getElementById('lblTotalConDescuentos').textContent = 'S/ {resultado.totalConDescuentos:0.00}';
    
    // Mostrar/ocultar resúmenes según haya descuentos
    {(resultado.descLiquidacion > 0 ? "document.getElementById('resumenLiquidacion').style.display = 'block';" : "document.getElementById('resumenLiquidacion').style.display = 'none';")}
    {(resultado.descPorcentaje > 0 ? "document.getElementById('resumenPorcentaje').style.display = 'block';" : "document.getElementById('resumenPorcentaje').style.display = 'none';")}
    {(resultado.descMonto > 0 ? "document.getElementById('resumenMonto').style.display = 'block';" : "document.getElementById('resumenMonto').style.display = 'none';")}
    
    // Actualizar labels de resumen
    document.getElementById('lblDescuentoLiquidacion').textContent = 'S/ {resultado.descLiquidacion:0.00}';
    document.getElementById('lblDescuentoPorcentaje').textContent = 'S/ {resultado.descPorcentaje:0.00}';
    document.getElementById('lblDescuentoMonto').textContent = 'S/ {resultado.descMonto:0.00}';

    console.log('🔹 JavaScript - Subtotal inicial: S/ {subtotalInicial:0.00}');
    console.log('🔹 JavaScript - Total descuentos: S/ {resultado.totalDescuentos:0.00}');
    console.log('🔹 JavaScript - Total con descuentos: S/ {resultado.totalConDescuentos:0.00}');
";

                ScriptManager.RegisterStartupScript(this, GetType(), "actualizarResumenDescuentos", script, true);

                System.Diagnostics.Debug.WriteLine($"✅ Resumen actualizado en modal");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en ActualizarResumenDescuentosEnModal: {ex.Message}");
            }
        }

        // 🔹 EVENTO DEL BOTÓN DESCUENTOS APLICADOS
        // 🔹 EVENTO DEL BOTÓN DESCUENTOS APLICADOS (CON MÁS DEBUG)
        protected void btnDescuentosAplicados_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("🔹 Botón DescuentosAplicados CLICKEADO");

            if (IdPrendaSeleccionada == 0)
            {
                MostrarMensaje("Por favor, seleccione una prenda primero.", "error");
                System.Diagnostics.Debug.WriteLine("❌ No hay prenda seleccionada");
                return;
            }

            try
            {
                System.Diagnostics.Debug.WriteLine($"🔹 Cargando descuentos para prenda ID: {IdPrendaSeleccionada}");

                // Cargar descuentos en el modal
                CargarDescuentosEnModal();

                // Actualizar el UpdatePanel
                UpdatePanel1.Update();

                // Mostrar el modal
                string script = @"
            console.log('🔹 Mostrando modal de descuentos desde código servidor...');
            var modal = new bootstrap.Modal(document.getElementById('modalDescuentos'));
            modal.show();
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalDescuentos", script, true);
                System.Diagnostics.Debug.WriteLine("✅ Modal de descuentos mostrado correctamente");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en btnDescuentosAplicados_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"❌ StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al mostrar descuentos: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO PARA APLICAR DESCUENTOS DESDE EL MODAL
        private void AplicarDescuentosDesdeModal()
        {
            try
            {
                double totalConDescuentos = 0;

                if (ViewState["TotalConDescuentos"] != null)
                {
                    totalConDescuentos = (double)ViewState["TotalConDescuentos"];
                    System.Diagnostics.Debug.WriteLine($"🔹 ViewState['TotalConDescuentos'] encontrado: S/ {totalConDescuentos:0.00}");
                }
                else
                {
                    totalConDescuentos = CalcularSubtotal();
                    System.Diagnostics.Debug.WriteLine($"🔹 ViewState['TotalConDescuentos'] no encontrado - usando subtotal actual: S/ {totalConDescuentos:0.00}");
                }

                // Validaciones
                double subtotalOriginal = CalcularSubtotal();
                if (totalConDescuentos > subtotalOriginal)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ERROR: Total con descuentos ({totalConDescuentos:0.00}) > Subtotal original ({subtotalOriginal:0.00})");
                    MostrarMensaje("Error: El descuento no puede resultar en un valor mayor al subtotal original.", "error");
                    return;
                }

                if (totalConDescuentos < 0)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ERROR: Total con descuentos negativo: {totalConDescuentos:0.00}");
                    totalConDescuentos = 0;
                }

                // 🔹 CORRECCIÓN: ACTUALIZAR AMBOS VIEWSTATES
                ViewState["TotalConDescuentos"] = totalConDescuentos;
                ViewState["SubtotalActual"] = totalConDescuentos; // También actualizar SubtotalActual

                // Actualizar el subtotal en pantalla
                txtSubtotal.Text = totalConDescuentos.ToString("0.00");

                MostrarMensaje($"Descuentos aplicados correctamente. Nuevo subtotal: S/ {totalConDescuentos:0.00}", "exito");
                System.Diagnostics.Debug.WriteLine($"✅ Descuentos aplicados - Nuevo subtotal: S/ {totalConDescuentos:0.00}");

                // Cerrar el modal
                string cerrarModalScript = @"
            console.log('Cerrando modal de descuentos después de aplicar...');
            var modalElement = document.getElementById('modalDescuentos');
            if (modalElement) {
                var modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                } else {
                    var newModal = new bootstrap.Modal(modalElement);
                    newModal.hide();
                }
            }
            setTimeout(function() {
                var backdrops = document.querySelectorAll('.modal-backdrop');
                backdrops.forEach(function(backdrop) {
                    backdrop.remove();
                });
                document.body.classList.remove('modal-open');
                document.body.style.paddingRight = '';
                document.body.style.overflow = '';
            }, 150);
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalDescuentos", cerrarModalScript, true);
                UpdatePanel1.Update();

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en AplicarDescuentosDesdeModal: {ex.Message}");
                MostrarMensaje($"Error al aplicar descuentos: {ex.Message}", "error");
            }
        }


        private double SubtotalActual
        {
            get { return ViewState["SubtotalActual"] != null ? (double)ViewState["SubtotalActual"] : 0; }
            set { ViewState["SubtotalActual"] = value; }
        }




        // 🔹 NUEVO: ACTUALIZAR SUBTOTAL BASE
        private void ActualizarSubtotalBase()
        {
            try
            {
                if (int.TryParse(txtCantidadRequerida.Text, out int cantidad))
                {
                    double subtotalBase = CalcularSubtotal();
                    txtSubtotal.Text = subtotalBase.ToString("0.00");
                    System.Diagnostics.Debug.WriteLine($"🔹 Subtotal base actualizado: S/ {subtotalBase:0.00}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ Error en ActualizarSubtotalBase: {ex.Message}");
            }
        }


    }

    public class DescuentoLiquidacionViewModel
    {
        public int IdDescuento { get; set; }
        public string Nombre { get; set; }
        public double PorcentajeLiquidacion { get; set; }
        public int CondicionStockMin { get; set; }
        public bool Aplica { get; set; }
        public double DescuentoAplicado { get; set; }

        public string CondicionStock => $"Stock ≤ {CondicionStockMin}";
        public string Porcentaje => $"{PorcentajeLiquidacion:0}%";
        public string Estado => Aplica ? "✅ Aplicado" : "❌ No aplica";
        public string DescuentoAplicadoFormateado => Aplica ? $"S/ {DescuentoAplicado:0.00}" : "S/ 0.00";
    }

    public class DescuentoPorcentajeViewModel
    {
        public int IdDescuento { get; set; }
        public string Nombre { get; set; }
        public double Porcentaje { get; set; }
        public bool Aplica { get; set; }
        public double DescuentoAplicado { get; set; }

        public string PorcentajeFormateado => $"{Porcentaje:0}%";
        public string Estado => Aplica ? "✅ Aplicado" : "❌ No aplica";
        public string DescuentoAplicadoFormateado => Aplica ? $"S/ {DescuentoAplicado:0.00}" : "S/ 0.00";
    }

    public class DescuentoMontoViewModel
    {
        public int IdDescuento { get; set; }
        public string Nombre { get; set; }
        public double MontoEditable { get; set; }
        public double MontoMaximo { get; set; }
        public bool Aplica { get; set; }
        public double DescuentoAplicado { get; set; }

        public string MontoEditableFormateado => $"S/ {MontoEditable:0.00}";
        public string MontoMaximoFormateado => $"S/ {MontoMaximo:0.00}";
        public string Estado => Aplica ? "✅ Aplicado" : "❌ No aplica";
        public string DescuentoAplicadoFormateado => Aplica ? $"S/ {DescuentoAplicado:0.00}" : "S/ 0.00";
    }

    public class PromocionComboViewModel
    {
        public int IdPromocion { get; set; }
        public string Nombre { get; set; }
        public int CantidadRequerida { get; set; }
        public int CantidadGratis { get; set; }
        public bool Aplica { get; set; }
        public int PrendasGratis { get; set; }
        public double DescuentoAplicado { get; set; }

        // Propiedades para formato
        public string DescripcionPromocion
        {
            get { return $"Lleva {CantidadRequerida}, paga {CantidadRequerida - CantidadGratis}"; }
        }

        public string DescuentoFormateado
        {
            get { return Aplica ? $"S/ {DescuentoAplicado:0.00}" : "S/ 0.00"; }
        }

        public string Estado
        {
            get { return Aplica ? "✅ Aplicada" : "❌ No aplica"; }
        }
    }

}