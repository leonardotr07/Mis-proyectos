using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.VentaWS;

namespace WearDropWA
{
    public partial class RegistarVentas : System.Web.UI.Page
    {
        // 🔹 LISTA PRINCIPAL EN SESIÓN usando el servicio web real de ventas
        private List<VentaWS.itemVenta> LineasVenta
        {
            get
            {
                if (Session["LineasVenta"] == null)
                {
                    Session["LineasVenta"] = new List<VentaWS.itemVenta>();
                    System.Diagnostics.Debug.WriteLine("🆕 Lista LineasVenta creada en sesión");
                }
                return (List<VentaWS.itemVenta>)Session["LineasVenta"];
            }
            set
            {
                Session["LineasVenta"] = value;
                System.Diagnostics.Debug.WriteLine($"💾 Lista LineasVenta guardada en sesión: {value?.Count ?? 0} elementos");
            }

        }


        // 🔹 MÉTODO DE DIAGNÓSTICO PARA VERIFICAR SESIÓN
        private void VerificarSesionLineasVenta()
        {
            System.Diagnostics.Debug.WriteLine("=== VERIFICACIÓN SESIÓN LINEASVENTA ===");

            var lineas = Session["LineasVenta"] as List<VentaWS.itemVenta>;
            if (lineas == null)
            {
                System.Diagnostics.Debug.WriteLine("❌ Session['LineasVenta'] es NULL");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine($"✅ Session['LineasVenta'] tiene {lineas.Count} elementos");

                foreach (var linea in lineas)
                {
                    System.Diagnostics.Debug.WriteLine($"   - Línea {linea.numLinea}: Prenda {linea.idPrenda}, " +
                        $"Cantidad {linea.cantidad}, Talla {linea.talla}, Subtotal S/ {linea.subtotal:0.00}");
                }
            }

            System.Diagnostics.Debug.WriteLine("=== FIN VERIFICACIÓN ===");
        }

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

        protected void btnModificarProductoVenta_Command(object sender, CommandEventArgs e)
        {
            try
            {
                // 🔹 VERIFICAR SI ESTAMOS EN MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite modificar");
                    return;
                }

                if (e.CommandName == "Modificar")
                {
                    int numeroLinea = Convert.ToInt32(e.CommandArgument);
                    System.Diagnostics.Debug.WriteLine($"✏️ Intentando modificar línea número: {numeroLinea}");

                    // 🔹 OBTENER LA PRENDA DE LA LÍNEA PARA DETERMINAR EL TIPO
                    var lineasActuales = LineasVenta;
                    int indiceAModificar = numeroLinea - 1;

                    if (indiceAModificar >= 0 && indiceAModificar < lineasActuales.Count)
                    {
                        var lineaAModificar = lineasActuales[indiceAModificar];

                        // 🔹 GUARDAR EL TIPO DE PRENDA EN SESIÓN
                        string tipoPrenda = ObtenerTipoPrendaPorId(lineaAModificar.idPrenda);
                        Session["TipoPrendaModificar"] = tipoPrenda;

                        System.Diagnostics.Debug.WriteLine($"🔹 Tipo de prenda guardado en sesión: {tipoPrenda}");
                    }

                    // 🔹 PREPARAR DATOS PARA MODIFICACIÓN
                    PrepararModificacionProducto(numeroLinea);

                    // 🔹 REDIRIGIR A LA PÁGINA DE AÑADIR PRODUCTO EN MODO MODIFICAR
                    Response.Redirect("~/AnnadirProductoVenta.aspx?modo=modificar");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al modificar producto: {ex.Message}");
                MostrarMensaje($"Error al preparar modificación: {ex.Message}", "error");
            }
        }

        private void PrepararModificacionProducto(int numeroLinea)
        {
            try
            {
                // 🔹 OBTENER LISTA ACTUAL
                var lineasActuales = LineasVenta;

                if (lineasActuales == null || lineasActuales.Count == 0)
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay líneas para modificar");
                    return;
                }

                // 🔹 ENCONTRAR LA LÍNEA A MODIFICAR (el número de línea en la interfaz empieza en 1)
                int indiceAModificar = numeroLinea - 1;

                if (indiceAModificar >= 0 && indiceAModificar < lineasActuales.Count)
                {
                    var lineaAModificar = lineasActuales[indiceAModificar];

                    // 🔹 GUARDAR EN SESIÓN LOS DATOS DE MODIFICACIÓN
                    Session["ProductoSeleccionadoModificar"] = lineaAModificar;
                    Session["IndiceProductoModificar"] = indiceAModificar;
                    Session["ModoProducto"] = "modificar";

                    // 🔹 GUARDAR DATOS ADICIONALES NECESARIOS
                    Session["IdPrendaModificar"] = lineaAModificar.idPrenda;
                    Session["TallaModificar"] = lineaAModificar.talla.ToString();
                    Session["CantidadModificar"] = lineaAModificar.cantidad;
                    Session["SubtotalModificar"] = lineaAModificar.subtotal;

                    System.Diagnostics.Debug.WriteLine($"✅ Línea {numeroLinea} preparada para modificación:");
                    System.Diagnostics.Debug.WriteLine($"   - ID Prenda: {lineaAModificar.idPrenda}");
                    System.Diagnostics.Debug.WriteLine($"   - Cantidad: {lineaAModificar.cantidad}");
                    System.Diagnostics.Debug.WriteLine($"   - Talla: {lineaAModificar.talla}");
                    System.Diagnostics.Debug.WriteLine($"   - Subtotal: {lineaAModificar.subtotal}");
                    System.Diagnostics.Debug.WriteLine($"   - Índice: {indiceAModificar}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ Índice inválido: {indiceAModificar}. Total líneas: {lineasActuales.Count}");
                    throw new Exception("La línea seleccionada para modificar no existe.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en PrepararModificacionProducto: {ex.Message}");
                throw;
            }
        }

        protected void btnEliminarProductoVenta_Command(object sender, CommandEventArgs e)
        {
            try
            {
                // 🔹 VERIFICAR SI ESTAMOS EN MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite eliminar");
                    return;
                }

                if (e.CommandName == "Eliminar")
                {
                    int numeroLinea = Convert.ToInt32(e.CommandArgument);
                    System.Diagnostics.Debug.WriteLine($"🗑️ Intentando eliminar línea número: {numeroLinea}");

                    // 🔹 ELIMINAR LA LÍNEA DE LA LISTA
                    EliminarLineaVenta(numeroLinea);

                    // 🔹 RECALCULAR Y ACTUALIZAR LA INTERFAZ
                    CargarLineasVenta();
                    ActualizarTotal();

                    MostrarMensaje("Producto eliminado correctamente de la venta.", "exito");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al eliminar producto: {ex.Message}");
                MostrarMensaje($"Error al eliminar producto: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO EXISTENTE: Eliminar línea específica de la venta
        private void EliminarLineaVenta(int numeroLinea)
        {
            try
            {
                // 🔹 OBTENER LISTA ACTUAL
                var lineasActuales = LineasVenta;

                if (lineasActuales == null || lineasActuales.Count == 0)
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay líneas para eliminar");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"🔹 Líneas antes de eliminar: {lineasActuales.Count}");

                // 🔹 ENCONTRAR Y ELIMINAR LA LÍNEA (el número de línea en la interfaz empieza en 1)
                int indiceAEliminar = numeroLinea - 1;

                if (indiceAEliminar >= 0 && indiceAEliminar < lineasActuales.Count)
                {
                    var lineaAEliminar = lineasActuales[indiceAEliminar];
                    double subtotalEliminado = lineaAEliminar.subtotal;

                    // 🔹 ELIMINAR DE LA LISTA
                    lineasActuales.RemoveAt(indiceAEliminar);

                    // 🔹 ACTUALIZAR LOS NÚMEROS DE LÍNEA RESTANTES
                    ActualizarNumerosLinea(lineasActuales);

                    // 🔹 GUARDAR LISTA ACTUALIZADA
                    LineasVenta = lineasActuales;

                    System.Diagnostics.Debug.WriteLine($"✅ Línea {numeroLinea} eliminada. Subtotal eliminado: S/ {subtotalEliminado:0.00}");
                    System.Diagnostics.Debug.WriteLine($"🔹 Líneas después de eliminar: {lineasActuales.Count}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ Índice inválido: {indiceAEliminar}. Total líneas: {lineasActuales.Count}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en EliminarLineaVenta: {ex.Message}");
                throw;
            }
        }

        private void ActualizarNumerosLinea(List<VentaWS.itemVenta> lineas)
        {
            for (int i = 0; i < lineas.Count; i++)
            {
                lineas[i].numLinea = i + 1;
            }
            System.Diagnostics.Debug.WriteLine("🔹 Números de línea actualizados");
        }

        // 🔹 SESIÓN PARA LA VENTA TEMPORAL
        private VentaWS.venta VentaTemporal
        {
            get
            {
                if (Session["VentaTemporalRegistro"] == null)
                {
                    Session["VentaTemporalRegistro"] = new VentaWS.venta
                    {
                        fecha = DateTime.Now,
                        activo = true,
                        productos = new VentaWS.itemVenta[0] // Inicializar array vacío
                    };
                }
                return (VentaWS.venta)Session["VentaTemporalRegistro"];
            }
            set { Session["VentaTemporalRegistro"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine($"=== PAGE_LOAD RegistarVentas ===");
            System.Diagnostics.Debug.WriteLine($"IsPostBack: {IsPostBack}");
            System.Diagnostics.Debug.WriteLine($"Líneas en sesión: {LineasVenta.Count}");

            VerificarSesionLineasVenta();


            // 🔹 VERIFICAR SI ESTAMOS EN MODO VISUALIZACIÓN
            string modo = Request.QueryString["modo"];
            string idVenta = Request.QueryString["id"];

            bool modoVisualizacion = (modo == "ver");
            Session["ModoVisualizacion"] = modoVisualizacion;

            if (!IsPostBack)
            {
                if (modoVisualizacion && !string.IsNullOrEmpty(idVenta))
                {
                    // 🔹 CARGAR VENTA EXISTENTE EN MODO SOLO LECTURA
                    CargarVentaExistenteParaVisualizacion(Convert.ToInt32(idVenta));
                    System.Diagnostics.Debug.WriteLine($"🔍 Modo VISUALIZACIÓN activado - ID Venta: {idVenta}");
                }
                else
                {
                    // 🔹 VERIFICAR SI HAY VENTA COMPLETA EN SESIÓN (VENIMOS DEL RESUMEN)
                    bool vieneDeResumen = Session["VentaCompleta"] != null;
                    bool vieneDeAnadirProducto = Session["VieneDeAnadirProducto"] != null && (bool)Session["VieneDeAnadirProducto"];
                    bool vieneDeModificarProducto = Session["VieneDeModificarProducto"] != null && (bool)Session["VieneDeModificarProducto"];

                    System.Diagnostics.Debug.WriteLine($"Modo: {modo}, ID: {idVenta}, VieneDeAnadir: {vieneDeAnadirProducto}, VieneDeModificar: {vieneDeModificarProducto}, VieneDeResumen: {vieneDeResumen}");

                    if (vieneDeResumen)
                    {
                        // 🔹 CORRECCIÓN: RECUPERAR LÍNEAS DESDE LA VENTA COMPLETA
                        RecuperarLineasDesdeVentaCompleta();
                        System.Diagnostics.Debug.WriteLine("🔄 Líneas recuperadas desde venta completa (viene de resumen)");
                    }
                    else if (modo == "editar" && !string.IsNullOrEmpty(idVenta))
                    {
                        CargarVentaExistente(modo, Convert.ToInt32(idVenta));
                        System.Diagnostics.Debug.WriteLine($"✏️ Modo EDICIÓN activado - ID Venta: {idVenta}");
                    }
                    else if (!vieneDeAnadirProducto && !vieneDeModificarProducto && !vieneDeResumen)
                    {
                        // Solo limpiar si NO venimos de añadir, modificar producto o del resumen
                        LimpiarVentaTemporal();
                        System.Diagnostics.Debug.WriteLine("🔄 Venta temporal limpiada (nueva venta)");
                    }
                    else if (vieneDeModificarProducto)
                    {
                        // Venimos de modificar producto, mantener todo
                        Session.Remove("VieneDeModificarProducto");
                        System.Diagnostics.Debug.WriteLine("🔄 Manteniendo líneas existentes (viene de modificar producto)");
                    }
                    else if (vieneDeAnadirProducto)
                    {
                        // Venimos de añadir producto, mantener todo
                        Session.Remove("VieneDeAnadirProducto");
                        System.Diagnostics.Debug.WriteLine("🔄 Manteniendo líneas existentes (viene de añadir producto)");
                    }
                }

                // 🔹 CARGAR LÍNEAS Y CONFIGURAR INTERFAZ
                CargarLineasVenta();
                ActualizarTotal();
                ConfigurarInterfazPorModo(modo);

                // 🔹 APLICAR CONFIGURACIÓN ESPECÍFICA PARA MODO VISUALIZACIÓN
                if (modoVisualizacion)
                {
                    OcultarColumnaAcciones();
                    System.Diagnostics.Debug.WriteLine("✅ Columna de acciones ocultada en modo visualización");
                }

                MostrarEstadoSesiones();

                System.Diagnostics.Debug.WriteLine($"✅ Page_Load completado - Modo: {modo}, Líneas: {LineasVenta.Count}");
            }
            else
            {
                // 🔹 EN POSTBACK, VERIFICAR SI NECESITAMOS RECONFIGURAR MODO VISUALIZACIÓN
                if (modoVisualizacion)
                {
                    OcultarColumnaAcciones();
                    System.Diagnostics.Debug.WriteLine("🔄 Reconfigurando modo visualización en PostBack");
                }
            }
        }

        // 🔹 NUEVO MÉTODO: Cargar venta para visualización
        private void CargarVentaExistenteParaVisualizacion(int idVenta)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Cargando venta para visualización - ID: {idVenta}");

                var ventaCompleta = ObtenerVentaPorId(idVenta);

                if (ventaCompleta != null && ventaCompleta.productos != null)
                {
                    // 🔹 CARGAR LÍNEAS DESDE LA BD
                    LineasVenta = ventaCompleta.productos.ToList();

                    // 🔹 GUARDAR VENTA COMPLETA EN SESIÓN
                    Session["VentaCompleta"] = ventaCompleta;
                    Session["VentaAVisualizar"] = idVenta;

                    System.Diagnostics.Debug.WriteLine($"✅ Venta cargada para visualización:");
                    System.Diagnostics.Debug.WriteLine($"   - Total líneas: {LineasVenta.Count}");
                    System.Diagnostics.Debug.WriteLine($"   - ID Venta: {ventaCompleta.idVenta}");
                    System.Diagnostics.Debug.WriteLine($"   - Total: {ventaCompleta.total}");
                    System.Diagnostics.Debug.WriteLine($"   - Cliente ID: {ventaCompleta.cliente?.idCliente}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("❌ No se pudo cargar la venta para visualización");
                    MostrarMensaje("No se pudo cargar la venta para visualización.", "error");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar venta para visualización: {ex.Message}");
                MostrarMensaje($"Error al cargar venta: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO EXISTENTE: Recuperar líneas desde la venta completa
        private void RecuperarLineasDesdeVentaCompleta()
        {
            try
            {
                var ventaCompleta = Session["VentaCompleta"] as VentaWS.venta;

                if (ventaCompleta != null && ventaCompleta.productos != null && ventaCompleta.productos.Length > 0)
                {
                    // 🔹 ACTUALIZAR LA LISTA DE LÍNEAS DESDE LA VENTA COMPLETA
                    LineasVenta = ventaCompleta.productos.ToList();

                    System.Diagnostics.Debug.WriteLine($"✅ Líneas recuperadas desde venta completa:");
                    System.Diagnostics.Debug.WriteLine($"   - Total líneas: {LineasVenta.Count}");
                    System.Diagnostics.Debug.WriteLine($"   - Total venta: {ventaCompleta.total}");

                    // 🔹 ACTUALIZAR TAMBIÉN LA VENTA TEMPORAL
                    VentaTemporal = ventaCompleta;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ Venta completa no tiene líneas para recuperar");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al recuperar líneas desde venta completa: {ex.Message}");
            }
        }



        // 🔹 MÉTODO MEJORADO: Limpiar venta temporal
        private void LimpiarVentaTemporal()
        {
            Session.Remove("LineasVenta");
            Session.Remove("VentaTemporalRegistro");
            Session.Remove("ProductoSeleccionadoModificar");
            Session.Remove("IndiceProductoModificar");
            Session.Remove("VentaCompleta"); // 🔹 LIMPIAR TAMBIÉN LA VENTA COMPLETA
            System.Diagnostics.Debug.WriteLine("🔄 Venta temporal y completa limpiadas");
        }
        // 🔹 MÉTODO CORREGIDO: Cargar venta existente para modificar
        // 🔹 MODIFICAR EL MÉTODO Page_Load EN RegistarVentas.aspx.cs (en la parte de carga de venta existente)
        private void CargarVentaExistente(string modo, int idVenta)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔧 Cargando venta existente para {modo} - ID: {idVenta}");

                // 🔹 SOLO CARGAR DESDE LA BD SI NO HAY VENTA EN SESIÓN
                if (Session["VentaCompleta"] == null)
                {
                    var ventaCompleta = ObtenerVentaPorId(idVenta);

                    if (ventaCompleta != null && ventaCompleta.productos != null)
                    {
                        // 🔹 CARGAR LÍNEAS DESDE LA BD
                        LineasVenta = ventaCompleta.productos.ToList();
                        System.Diagnostics.Debug.WriteLine($"✅ Cargadas {LineasVenta.Count} líneas desde BD");

                        // 🔹 GUARDAR VENTA COMPLETA EN SESIÓN
                        Session["VentaCompleta"] = ventaCompleta;

                        // 🔹 GUARDAR CLIENTE EN SESIÓN SI EXISTE
                        if (ventaCompleta.cliente != null)
                        {
                            Session["ClienteSeleccionado"] = ventaCompleta.cliente;
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("ℹ️ No se pudo cargar la venta completa o no tiene productos");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("✅ Usando venta existente en sesión");
                }

                // 🔹 CONFIGURAR INTERFAZ SEGÚN MODO
                ConfigurarInterfazPorModo(modo);
                ActualizarTotal();

                System.Diagnostics.Debug.WriteLine($"✅ Venta cargada en modo {modo}. Líneas en sesión: {LineasVenta?.Count ?? 0}");

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar venta existente: {ex.Message}", "error");
            }
        }








        // 🔹 MÉTODO ACTUALIZADO: Configurar interfaz por modo
        // 🔹 MÉTODO ACTUALIZADO: Configurar interfaz por modo
        private void ConfigurarInterfazPorModo(string modo)
        {
            if (modo == "editar")
            {
                lblTitulo.InnerText = "Modificar Venta";
                tituloPagina.InnerText = "Modificar Venta";
                btnIniciarRegistroVenta.Text = "Actualizar Venta";
                System.Diagnostics.Debug.WriteLine("✅ Interfaz configurada para MODO EDICIÓN");
            }
            else if (modo == "ver")
            {
                lblTitulo.InnerText = "Visualizar Venta - Líneas";
                tituloPagina.InnerText = "Visualizar Venta";
                btnIniciarRegistroVenta.Text = "Ver Resumen de Venta";

                // 🔹 OCULTAR COMPLETAMENTE BOTÓN AÑADIR PRODUCTOS EN MODO VISUALIZACIÓN
                btnIrAnnadirProductos.Visible = false;

                // 🔹 OCULTAR COLUMNA DE ACCIONES EN EL GRIDVIEW
                OcultarColumnaAcciones();

                System.Diagnostics.Debug.WriteLine("✅ Interfaz configurada para MODO VISUALIZACIÓN (solo ver líneas)");
            }
            else
            {
                lblTitulo.InnerText = "Registrar Venta";
                tituloPagina.InnerText = "Registrar Venta";
                btnIniciarRegistroVenta.Text = "Iniciar Registro";
                System.Diagnostics.Debug.WriteLine("✅ Interfaz configurada para MODO REGISTRO");
            }
        }

        // 🔹 NUEVO MÉTODO: Ocultar columna de acciones en modo visualización
        private void OcultarColumnaAcciones()
        {
            try
            {
                if (dgvProductosVenta.Columns.Count > 0)
                {
                    // 🔹 BUSCAR LA COLUMNA DE ACCIONES (última columna)
                    for (int i = 0; i < dgvProductosVenta.Columns.Count; i++)
                    {
                        if (dgvProductosVenta.Columns[i] is TemplateField templateField)
                        {
                            // Verificar si es la columna de acciones por el HeaderText
                            if (templateField.HeaderText == "Acciones")
                            {
                                dgvProductosVenta.Columns[i].Visible = false;
                                System.Diagnostics.Debug.WriteLine("✅ Columna de acciones ocultada en modo visualización");
                                break;
                            }
                        }
                        else if (dgvProductosVenta.Columns[i].HeaderText == "Acciones")
                        {
                            // Para BoundField u otros tipos de columna
                            dgvProductosVenta.Columns[i].Visible = false;
                            System.Diagnostics.Debug.WriteLine("✅ Columna de acciones (BoundField) ocultada en modo visualización");
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al ocultar columna de acciones: {ex.Message}");
            }
        }

     
        // 🔹 MÉTODO PARA OBTENER VENTA POR ID DESDE EL SERVICIO WEB
        private VentaWS.venta ObtenerVentaPorId(int idVenta)
        {
            try
            {
                VentaWSClient client = new VentaWSClient();
                var venta = client.obtenerVentaPorId(idVenta);

                if (venta != null)
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Venta obtenida por ID: {idVenta}");
                    return venta;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ No se pudo obtener venta por ID: {idVenta}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al obtener venta por ID {idVenta}: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO ACTUALIZADO: Cargar líneas con datos reales
        private void CargarLineasVenta()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"=== CARGAR LÍNEAS VENTA ===");
                System.Diagnostics.Debug.WriteLine($"Líneas a cargar: {LineasVenta.Count}");

                if (LineasVenta.Count == 0)
                {
                    // Mostrar grid vacío
                    var emptyList = new List<object> { new {
                        Nº = 0,
                        Prenda = "No hay productos agregados",
                        Talla = "",
                        Cantidad = 0,
                        Subtotal = 0.0
                    }};
                    dgvProductosVenta.DataSource = emptyList;
                    dgvProductosVenta.EmptyDataText = "No hay productos de venta agregados";
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay líneas para mostrar");
                }
                else
                {
                    // 🔹 CARGAR DATOS REALES DESDE LA SESIÓN
                    var datosParaMostrar = LineasVenta.Select((linea, index) => new
                    {
                        Nº = index + 1, // 🔹 Número de línea actualizado
                        Prenda = ObtenerNombrePrenda(linea.idPrenda),
                        Talla = linea.talla.ToString(),
                        Cantidad = linea.cantidad,
                        Subtotal = linea.subtotal
                    }).ToList();

                    dgvProductosVenta.DataSource = datosParaMostrar;
                    System.Diagnostics.Debug.WriteLine($"✅ Grid cargado con {datosParaMostrar.Count} líneas");
                }

                dgvProductosVenta.DataBind();
                ActualizarTotal();

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarLineasVenta: {ex.Message}");
            }
        }

        // 🔹 MÉTODO PARA ACTUALIZAR EL TOTAL
        private void ActualizarTotal()
        {
            double total = LineasVenta.Sum(linea => linea.subtotal);
            txtTotalPagado.Text = total.ToString("N2");
            txtTotalPagado.CssClass = "form-control total-field"; // 🔹 APLICAR ESTILO ESPECIAL

            // 🔹 ACTUALIZAR TAMBIÉN LA VENTA EN SESIÓN SI EXISTE
            if (Session["VentaCompleta"] != null)
            {
                var venta = (VentaWS.venta)Session["VentaCompleta"];
                venta.total = total;
                Session["VentaCompleta"] = venta;
            }

            System.Diagnostics.Debug.WriteLine($"💰 Total actualizado: S/ {total:N2}");
        }

        // 🔹 MÉTODO PARA OBTENER NOMBRE DE PRENDA POR ID
        private string ObtenerNombrePrenda(int idPrenda)
        {
            return $"Prenda #{idPrenda}";
        }

        protected void btnRegresarVentaProducto_Click(object sender, EventArgs e)
        {
            // 🔹 VERIFICAR MODO VISUALIZACIÓN
            string modo = Request.QueryString["modo"];
            
            if (modo == "ver")
            {
                // 🔹 EN MODO VISUALIZACIÓN, REGRESAR A GESTIONAR VENTAS
                Response.Redirect("~/GestionarVentas.aspx");
                return;
            }

            // 🔹 LIMPIAR SESIONES AL REGRESAR (solo en modos normales)
            Session.Remove("LineasVenta");
            Session.Remove("VentaTemporalRegistro");
            Session.Remove("ProductoSeleccionadoModificar");
            Session.Remove("IndiceProductoModificar");
            Response.Redirect("~/GestionarVentas.aspx");
        }

        protected void dgvProductosVenta_PreRender(object sender, EventArgs e)
        {
            if (dgvProductosVenta.Rows.Count > 0)
            {
                dgvProductosVenta.UseAccessibleHeader = true;
                dgvProductosVenta.HeaderRow.TableSection = TableRowSection.TableHeader;

                if (dgvProductosVenta.FooterRow != null)
                {
                    dgvProductosVenta.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
        }

        protected void btnIrAnnadirProductos_Click(object sender, EventArgs e)
        {
            // 🔹 VERIFICAR SI ESTAMOS EN MODO VISUALIZACIÓN
            string modo = Request.QueryString["modo"];
            if (modo == "ver")
            {
                System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite añadir productos");
                return;
            }

            Session["ModoProducto"] = "nuevo";
            Session["ProductoSeleccionado"] = null;
            Session["IndiceProductoEditar"] = null;
            Response.Redirect("~/AnnadirProductoVenta.aspx");
        }

        protected void btnIniciarRegistroVenta_Click(object sender, EventArgs e)
        {
            string modo = Request.QueryString["modo"];
            
            if (modo == "ver")
            {
                // 🔹 EN MODO VISUALIZACIÓN, REDIRIGIR AL RESUMEN EN MODO VER
                Response.Redirect($"~/RegistroVentaResumenVenta.aspx?modo=ver&id={Request.QueryString["id"]}");
                return;
            }

            // Validar que hay productos agregados
            if (LineasVenta.Count == 0)
            {
                MostrarMensaje("Debe agregar al menos un producto a la venta.", "error");
                return;
            }

            try
            {
                // 🔹 CREAR O ACTUALIZAR EL OBJETO VENTA COMPLETO
                VentaWS.venta ventaCompleta = PrepararVentaCompleta();

                // 🔹 GUARDAR EN SESIÓN
                Session["VentaCompleta"] = ventaCompleta;

                System.Diagnostics.Debug.WriteLine($"✅ Venta preparada para resumen:");
                System.Diagnostics.Debug.WriteLine($"   - ID Venta: {ventaCompleta.idVenta}");
                System.Diagnostics.Debug.WriteLine($"   - Total: {ventaCompleta.total}");
                System.Diagnostics.Debug.WriteLine($"   - Líneas: {ventaCompleta.productos.Length}");
                System.Diagnostics.Debug.WriteLine($"   - Cliente: {ventaCompleta.cliente?.idCliente}");
                System.Diagnostics.Debug.WriteLine($"   - Empleado: {ventaCompleta.empleado?.idEmpleado}");

                // 🔹 DETECTAR MODO
                string idVenta = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(modo) && modo == "editar" && !string.IsNullOrEmpty(idVenta))
                {
                    Response.Redirect($"~/RegistroVentaResumenVenta.aspx?modo=editar&id={idVenta}");
                }
                else
                {
                    Response.Redirect("~/RegistroVentaResumenVenta.aspx?modo=registrar");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al preparar venta: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO MEJORADO: Preparar venta completa con todos los datos
        private VentaWS.venta PrepararVentaCompleta()
        {
            VentaWS.venta venta;

            // 🔹 VERIFICAR SI YA EXISTE UNA VENTA COMPLETA EN SESIÓN
            if (Session["VentaCompleta"] != null)
            {
                venta = (VentaWS.venta)Session["VentaCompleta"];
                System.Diagnostics.Debug.WriteLine("✅ Reutilizando venta completa existente");
            }
            else
            {
                venta = new VentaWS.venta();
                System.Diagnostics.Debug.WriteLine("✅ Creando nueva venta completa");
            }

            // 🔹 DATOS BÁSICOS DE LA VENTA
            venta.idVenta = venta.idVenta; // Mantener el ID existente si hay
            venta.fecha = DateTime.Now;
            venta.total = LineasVenta.Sum(linea => linea.subtotal);
            venta.activo = true;

            // 🔹 ASIGNAR LÍNEAS DE VENTA (SIEMPRE ACTUALIZAR)
            venta.productos = LineasVenta.ToArray();

            // 🔹 INICIALIZAR CLIENTE Y EMPLEADO SI NO EXISTEN
            if (venta.cliente == null)
            {
                venta.cliente = new VentaWS.cliente();
            }

            if (venta.empleado == null)
            {
                venta.empleado = new VentaWS.empleado();
            }

            // 🔹 SI ESTAMOS EN MODO EDICIÓN, MANTENER EL ID ORIGINAL
            string modo = Request.QueryString["modo"];
            string idVenta = Request.QueryString["id"];

            if (modo == "editar" && !string.IsNullOrEmpty(idVenta) && venta.idVenta == 0)
            {
                venta.idVenta = Convert.ToInt32(idVenta);
            }

            System.Diagnostics.Debug.WriteLine($"✅ Venta preparada:");
            System.Diagnostics.Debug.WriteLine($"   - ID: {venta.idVenta}");
            System.Diagnostics.Debug.WriteLine($"   - Total: {venta.total}");
            System.Diagnostics.Debug.WriteLine($"   - Líneas: {venta.productos.Length}");
            System.Diagnostics.Debug.WriteLine($"   - Cliente: {venta.cliente.idCliente}");
            System.Diagnostics.Debug.WriteLine($"   - Empleado: {venta.empleado.idEmpleado}");

            return venta;
        }







        // 🔹 MÉTODO PARA DEBUG: Mostrar estado de las sesiones
        private void MostrarEstadoSesiones()
        {
            System.Diagnostics.Debug.WriteLine("=== ESTADO DE SESIONES ===");
            System.Diagnostics.Debug.WriteLine($"LineasVenta: {LineasVenta.Count} items");
            System.Diagnostics.Debug.WriteLine($"VentaCompleta: {(Session["VentaCompleta"] != null ? "EXISTE" : "NO EXISTE")}");
            System.Diagnostics.Debug.WriteLine($"ModoVisualizacion: {(Session["ModoVisualizacion"] != null ? "ACTIVO" : "INACTIVO")}");

            if (Session["VentaCompleta"] != null)
            {
                var venta = (VentaWS.venta)Session["VentaCompleta"];
                System.Diagnostics.Debug.WriteLine($"   - ID: {venta.idVenta}");
                System.Diagnostics.Debug.WriteLine($"   - Total: {venta.total}");
                System.Diagnostics.Debug.WriteLine($"   - Líneas: {venta.productos?.Length ?? 0}");
            }
            System.Diagnostics.Debug.WriteLine("=== FIN ESTADO ===");
        }

        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }
    }
}