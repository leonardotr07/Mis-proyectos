using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.OrdenCompraWS;

namespace WearDropWA
{
    public partial class RegistrarDetalleOrdenCompra : System.Web.UI.Page
    {
        // 🔹 ACCESO A LAS SESIONES
        private List<OrdenCompraWS.lineaLoteCompra> LineasOrden
        {
            get { return (List<OrdenCompraWS.lineaLoteCompra>)Session["LineasOrdenCompra"]; }
        }

        private OrdenCompraWS.ordenCompra OrdenTemporal
        {
            get { return (OrdenCompraWS.ordenCompra)Session["OrdenTemporalRegistro"]; }
            set { Session["OrdenTemporalRegistro"] = value; }
        }

        // 🔹 ACTUALIZAR EL MÉTODO Page_Load para llamar a ConfigurarInterfazPorModo
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                System.Diagnostics.Debug.WriteLine("=== INICIANDO REGISTRAR DETALLE ORDEN ===");

                // 🔹 VERIFICAR MODO
                string modo = Session["ModoOrden"] as string;
                lblTitulo.InnerText = modo == "ver" ? "Ver Orden de Compra" :
                                    modo == "modificar" ? "Modificar Orden de Compra" :
                                    "Registrar Orden de Compra";

                System.Diagnostics.Debug.WriteLine($"Modo: {modo}");

                if (LineasOrden != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Líneas en orden: {LineasOrden.Count}");
                }

                CargarDatosOrden();

                // 🔹 CONFIGURAR INTERFAZ SEGÚN MODO
                ConfigurarInterfazPorModo(modo);

                System.Diagnostics.Debug.WriteLine("=== CARGA INICIAL COMPLETADA ===");
            }

            ConfigurarCampoEmpleado();
        }

        // 🔹 NUEVO MÉTODO: Configurar campo empleado automáticamente desde sesión
        private void ConfigurarCampoEmpleado()
        {
            try
            {
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion == null)
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ No se encontró información del empleado en sesión");
                    return;
                }

                // 🔹 OBTENER ID EMPLEADO DESDE SESIÓN
                int idEmpleado = ((dynamic)empleadoSesion).idEmpleado;

                // 🔹 ASIGNAR AL CAMPO DE TEXTO
                txtIDEmpleado.Text = idEmpleado.ToString();

                // 🔹 HACER EL CAMPO READONLY Y APLICAR ESTILO
                txtIDEmpleado.ReadOnly = true;
                txtIDEmpleado.CssClass = "form-control bg-light";

                // 🔹 ACTUALIZAR LA ORDEN TEMPORAL CON EL EMPLEADO
                if (OrdenTemporal != null)
                {
                    if (OrdenTemporal.empleado == null)
                        OrdenTemporal.empleado = new OrdenCompraWS.empleado();

                    OrdenTemporal.empleado.idEmpleado = idEmpleado;
                    Session["OrdenTemporalRegistro"] = OrdenTemporal;
                }

                System.Diagnostics.Debug.WriteLine($"✅ Empleado asignado automáticamente - ID: {idEmpleado}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al configurar campo empleado: {ex.Message}");
            }
        }



        // 🔹 MÉTODO MEJORADO: Configurar interfaz según modo
        private void ConfigurarInterfazPorModo(string modo)
        {
            if (modo == "ver")
            {
                // 🔹 OCULTAR BOTÓN REGISTRAR/ACTUALIZAR
                btnRegistrarOrden.Visible = false;

                // 🔹 CAMBIAR TEXTO DEL BOTÓN REGRESAR A "CERRAR"
                btnRegresar.Text = "Cerrar";

                // 🔹 DESHABILITAR TODOS LOS CAMPOS DE EDICIÓN
                txtIDEmpleado.Enabled = false;
                txtFechaEmision.Enabled = false;
                txtFechaLlegada.Enabled = false;
                txtDeudaPendiente.Enabled = false;
                btnAbrirModalProveedor.Enabled = false;

                // 🔹 CAMBIAR EL TÍTULO PARA INDICAR MODO VISUALIZACIÓN
                lblTitulo.InnerText = "Ver Detalles de Orden de Compra";

                // 🔹 AGREGAR CLASE CSS PARA MODO VISUALIZACIÓN (gris)
                ScriptManager.RegisterStartupScript(this, GetType(), "modoVisualizacion",
                    "document.body.classList.add('modo-ver-detalle');", true);
            }
            else if (modo == "modificar")
            {
                btnRegistrarOrden.Text = "Actualizar Orden";
                btnRegistrarOrden.Visible = true;
                btnRegresar.Text = "Regresar";
                lblTitulo.InnerText = "Modificar Orden de Compra";

                // 🔹 CORRECCIÓN: NO aplicar clases CSS especiales para modo modificar
                // Se mantendrán los colores azules por defecto
                // ScriptManager.RegisterStartupScript(this, GetType(), "modoModificacion",
                //     "document.body.classList.add('modo-modificar-detalle');", true);
            }
            else
            {
                // Modo nuevo - mantener configuración normal
                btnRegresar.Text = "Regresar";
                lblTitulo.InnerText = "Registrar Orden de Compra";
            }
        }

        private void CargarDatosOrden()
        {
            try
            {
                if (OrdenTemporal == null || LineasOrden == null || LineasOrden.Count == 0)
                {
                    MostrarMensaje("No hay datos de orden para registrar. Regrese y agregue líneas primero.");
                    Response.Redirect("~/RegistrarOrdenCompra.aspx");
                    return;
                }

                string modo = Session["ModoOrden"] as string;

                // 🔹 CORRECCIÓN MEJORADA: CARGAR ID DE LA ORDEN EN TODOS LOS MODOS
                if (Session["IdOrdenmodificar"] != null)
                {
                    int idOrden = (int)Session["IdOrdenmodificar"];
                    txtIDOrden.Text = idOrden.ToString();
                    System.Diagnostics.Debug.WriteLine($"✅ ID Orden cargado: {idOrden} (Modo: {modo})");
                }
                else if (OrdenTemporal.idCompra > 0)
                {
                    // 🔹 TAMBIÉN INTENTAR CARGAR DESDE LA ORDEN TEMPORAL
                    txtIDOrden.Text = OrdenTemporal.idCompra.ToString();
                    System.Diagnostics.Debug.WriteLine($"✅ ID Orden cargado desde temporal: {OrdenTemporal.idCompra} (Modo: {modo})");
                }
                else
                {
                    txtIDOrden.Text = "0"; // Nuevo registro
                    System.Diagnostics.Debug.WriteLine($"ℹ️ ID Orden: 0 (Nuevo registro)");
                }

                // 🔹 CORRECCIÓN: PRIORIZAR EMPLEADO DE SESIÓN SOBRE EL DE LA ORDEN TEMPORAL
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion != null)
                {
                    int idEmpleadoSesion = ((dynamic)empleadoSesion).idEmpleado;
                    txtIDEmpleado.Text = idEmpleadoSesion.ToString();

                    // 🔹 ACTUALIZAR ORDEN TEMPORAL CON EMPLEADO DE SESIÓN
                    if (OrdenTemporal.empleado == null)
                        OrdenTemporal.empleado = new OrdenCompraWS.empleado();

                    OrdenTemporal.empleado.idEmpleado = idEmpleadoSesion;

                    System.Diagnostics.Debug.WriteLine($"✅ ID Empleado desde sesión: {idEmpleadoSesion}");
                }
                else if (OrdenTemporal.empleado != null && OrdenTemporal.empleado.idEmpleado > 0)
                {
                    // 🔹 FALLBACK: USAR EMPLEADO DE LA ORDEN TEMPORAL SI NO HAY SESIÓN
                    txtIDEmpleado.Text = OrdenTemporal.empleado.idEmpleado.ToString();
                    System.Diagnostics.Debug.WriteLine($"✅ ID Empleado desde orden temporal: {OrdenTemporal.empleado.idEmpleado}");
                }

                // 🔹 MANTENER TODOS LOS DATOS EXISTENTES SIN CAMBIOS
                txtMontoTotal.Text = OrdenTemporal.montoTotal.ToString("F2");

                // 🔹 CARGAR DEUDA PENDIENTE
                if (OrdenTemporal.deudaPendiente > 0)
                {
                    txtDeudaPendiente.Text = OrdenTemporal.deudaPendiente.ToString("F2");
                }
                else
                {
                    txtDeudaPendiente.Text = OrdenTemporal.montoTotal.ToString("F2");
                    OrdenTemporal.deudaPendiente = OrdenTemporal.montoTotal;
                }

                // 🔹 CARGAR FECHAS TEMPORALES
                if (OrdenTemporal.fechaEmision != default(DateTime))
                {
                    txtFechaEmision.Text = OrdenTemporal.fechaEmision.ToString("yyyy-MM-dd");
                }

                if (OrdenTemporal.fechaLlegada != default(DateTime))
                {
                    txtFechaLlegada.Text = OrdenTemporal.fechaLlegada.ToString("yyyy-MM-dd");
                }

                // 🔹 CARGAR PROVEEDOR SI EXISTE
                if (OrdenTemporal.proveedor != null && OrdenTemporal.proveedor.idProveedor > 0)
                {
                    txtProveedor.Text = OrdenTemporal.proveedor.nombre;
                    hdnIdProveedor.Value = OrdenTemporal.proveedor.idProveedor.ToString();
                }

                System.Diagnostics.Debug.WriteLine($"✅ Datos cargados - ID: {txtIDOrden.Text}, Empleado: {txtIDEmpleado.Text}, Modo: {modo}");

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar datos: {ex.Message}");
            }
        }

        // 🔹 CAMBIO: Nuevo nombre del método para coincidir con el ID único del botón
        protected void btnAbrirModalProveedor_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🎯 INICIANDO btnAbrirModalProveedor_Click");

                // 1. Cargar datos en el GridView
                CargarProveedoresEnModal();

                // 2. Verificar si el GridView tiene datos
                if (gvProveedores.Rows.Count == 0)
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ GridView de proveedores está vacío");
                    MostrarMensaje("No hay proveedores disponibles para seleccionar.", "info");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"✅ GridView tiene {gvProveedores.Rows.Count} filas");

                // 3. Actualizar el UpdatePanel
                UpdatePanel1.Update();
                System.Diagnostics.Debug.WriteLine("✅ UpdatePanel actualizado");

                // 🔹 SCRIPT SIMPLIFICADO Y MEJORADO
                string script = @"
                    console.log('🎯 EJECUTANDO SCRIPT PARA MODAL...');
                    
                    // Método principal: usar función global
                    if (typeof mostrarModalProveedor === 'function') {
                        console.log('✅ Usando función global mostrarModalProveedor');
                        mostrarModalProveedor();
                    } else {
                        console.error('❌ Función mostrarModalProveedor no encontrada');
                        alert('Error: No se puede abrir el selector de proveedores.');
                    }
                ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalProveedor", script, true);
                System.Diagnostics.Debug.WriteLine("✅ Script para mostrar modal registrado");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en btnAbrirModalProveedor_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"💥 StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al abrir selector de proveedores: {ex.Message}", "error");
            }
        }

        // 🔹 CARGAR PROVEEDORES EN EL MODAL - VERSIÓN CORREGIDA
        private void CargarProveedoresEnModal()
        {
            try
            {
                // 🔹 USAR EL MISMO SERVICIO QUE EN GESTIONARPROVEEDORES
                var proveedorWS = new ProveedorWS.ProveedorWSClient();
                var proveedores = proveedorWS.listarActivosSinCondiciones();

                if (proveedores == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ La lista de proveedores es NULL");
                    MostrarMensaje("Error: No se pudieron cargar los proveedores.", "error");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"✅ Se encontraron {proveedores.Length} proveedores");

                var proveedoresList = proveedores.Where(p => p != null && p.activo)
                    .Select(p => new ProveedorViewModel
                    {
                        Id = p.idProveedor,
                        Nombre = p.nombre ?? "Sin nombre",
                        RUC = p.RUC.ToString(),
                        Telefono = p.telefono.ToString(),
                        Direccion = p.direccion ?? "Sin dirección"
                    }).ToList();

                System.Diagnostics.Debug.WriteLine($"✅ {proveedoresList.Count} proveedores activos después del filtro");

                if (proveedoresList.Count == 0)
                {
                    MostrarMensaje("No se encontraron proveedores activos.", "info");
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay proveedores activos para mostrar");
                }

                gvProveedores.DataSource = proveedoresList;
                gvProveedores.DataBind();

                System.Diagnostics.Debug.WriteLine($"✅ GridView de proveedores cargado con {proveedoresList.Count} registros");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarProveedoresEnModal: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"💥 StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al cargar proveedores: {ex.Message}", "error");
            }
        }

        // 🔹 SELECCIONAR PROVEEDOR DESDE EL MODAL - VERSIÓN CORREGIDA
        protected void gvProveedores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarProveedor")
            {
                string[] argumentos = e.CommandArgument.ToString().Split('|');
                if (argumentos.Length >= 2)
                {
                    int idProveedor = int.Parse(argumentos[0]);
                    string nombreProveedor = argumentos[1];

                    // 🔹 ACTUALIZAR INTERFAZ
                    txtProveedor.Text = nombreProveedor;
                    hdnIdProveedor.Value = idProveedor.ToString();

                    // 🔹 ACTUALIZAR ORDEN TEMPORAL
                    if (OrdenTemporal.proveedor == null)
                        OrdenTemporal.proveedor = new OrdenCompraWS.proveedor();

                    OrdenTemporal.proveedor.idProveedor = idProveedor;
                    OrdenTemporal.proveedor.nombre = nombreProveedor;

                    // 🔹 CERRAR MODAL - SCRIPT MEJORADO
                    string cerrarScript = @"
                console.log('🔴 Iniciando cierre del modal desde code-behind...');
                if (typeof cerrarModalProveedor === 'function') {
                    cerrarModalProveedor();
                } else {
                    console.error('❌ Función cerrarModalProveedor no encontrada');
                    // Fallback manual
                    var modalElement = document.getElementById('modalSeleccionarProveedor');
                    if (modalElement) {
                        // Ocultar modal
                        modalElement.style.display = 'none';
                        modalElement.classList.remove('show');
                        
                        // Remover backdrop
                        var backdrops = document.querySelectorAll('.modal-backdrop');
                        backdrops.forEach(function(backdrop) {
                            backdrop.remove();
                        });
                        
                        // Restaurar body
                        document.body.classList.remove('modal-open');
                        document.body.style.paddingRight = '';
                        
                        console.log('✅ Modal cerrado manualmente');
                    }
                }
            ";

                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalProveedor", cerrarScript, true);

                    // 🔹 ACTUALIZAR UPDATE PANEL
                    UpdatePanel1.Update();

                    MostrarMensaje($"Proveedor seleccionado: {nombreProveedor}", "exito");
                }
            }
        }

        // 🔹 ACTUALIZAR EL BOTÓN REGISTRAR PARA MANEJAR MODIFICACIÓN
        protected void btnRegistrarOrden_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
                return;

            try
            {
                string modo = Session["ModoOrden"] as string;

                // 🔹 PREPARAR ORDEN PARA ENVÍO
                var ordenParaEnviar = PrepararOrdenParaEnvio();

                // 🔹 LLAMAR AL SERVICIO CORRESPONDIENTE
                var ordenCompraWS = new OrdenCompraWS.OrdenCompraWSClient();
                int resultado = 0;

                if (modo == "modificar")
                {
                    // 🔹 USAR SERVICIO DE MODIFICACIÓN
                    resultado = ordenCompraWS.modificarOrdeneDeCompra(ordenParaEnviar);
                    System.Diagnostics.Debug.WriteLine($"📞 MODIFICACIÓN - Resultado: {resultado}");
                }
                else
                {
                    // 🔹 USAR SERVICIO DE INSERCIÓN (modo nuevo)
                    resultado = ordenCompraWS.insertarOrdenDeCompra(ordenParaEnviar);
                    System.Diagnostics.Debug.WriteLine($"📞 INSERCIÓN - Resultado: {resultado}");
                }

                if (resultado > 0)
                {
                    string mensaje = modo == "modificar" ?
                        $"✅ Orden actualizada con ID: {resultado}" :
                        $"✅ Orden registrada con ID: {resultado}";

                    MostrarMensaje(mensaje);
                    LimpiarSesiones();
                    Response.Redirect("~/GestionarOrdenesDeCompra.aspx");
                }
                else
                {
                    MostrarMensaje("❌ Error al procesar la orden. El servicio no pudo completar la operación.");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"💥 Error al procesar orden: {ex.Message}");
            }
        }

        // 🔹 MÉTODO NUEVO: Preparar orden para envío (común para insertar y modificar)
        private OrdenCompraWS.ordenCompra PrepararOrdenParaEnvio()
        {
            DateTime fechaEmision = DateTime.Parse(txtFechaEmision.Text);
            DateTime fechaLlegada = DateTime.Parse(txtFechaLlegada.Text);
            double montoTotal = double.Parse(txtMontoTotal.Text);
            double deudaPendiente = double.Parse(txtDeudaPendiente.Text);
            int idEmpleado = int.Parse(txtIDEmpleado.Text);
            int idProveedor = int.Parse(hdnIdProveedor.Value);

            var ordenParaEnviar = new OrdenCompraWS.ordenCompra
            {
                fechaEmision = fechaEmision,
                fechaLlegada = fechaLlegada,
                montoTotal = montoTotal,
                deudaPendiente = deudaPendiente,
                activo = true,
                empleado = new OrdenCompraWS.empleado { idEmpleado = idEmpleado },
                proveedor = new OrdenCompraWS.proveedor { idProveedor = idProveedor }
            };

            ordenParaEnviar.fechaEmisionSpecified = true;
            ordenParaEnviar.fechaLlegadaSpecified = true;

            // 🔹 SI ES MODIFICACIÓN, INCLUIR EL ID
            string modo = Session["ModoOrden"] as string;
            if (modo == "modificar" && Session["IdOrdenmodificar"] != null)
            {
                ordenParaEnviar.idCompra = (int)Session["IdOrdenmodificar"];
            }

            // 🔹 CORRECCIÓN CRÍTICA: USAR EL ID DE LOTE REAL DE CADA LÍNEA
            var lineasPreparadas = new List<OrdenCompraWS.lineaLoteCompra>();

            System.Diagnostics.Debug.WriteLine($"=== PREPARANDO {LineasOrden.Count} LÍNEAS PARA ENVÍO ===");

            foreach (var lineaOriginal in LineasOrden)
            {
                // 🔹 VERIFICAR QUE EL LOTE TIENE EL ID CORRECTO
                int idLoteReal = lineaOriginal.lote?.idLote ?? 0;
                System.Diagnostics.Debug.WriteLine($"Línea - Prenda: {lineaOriginal.idPrenda}, Lote ID: {idLoteReal}");

                var lineaLote = new OrdenCompraWS.lineaLoteCompra
                {
                    idPrenda = lineaOriginal.idPrenda,
                    cantidad = lineaOriginal.cantidad,
                    talla = lineaOriginal.talla,
                    precioLote = lineaOriginal.precioLote,
                    numLinea = lineaOriginal.numLinea,
                    activo = true,
                    lote = new OrdenCompraWS.lote
                    {
                        idLote = idLoteReal, // 🔹 CORRECCIÓN: Usar el ID real, no hardcodeado
                        activo = true,
                        datAlmacen = new OrdenCompraWS.almacen()
                    }
                };
                lineaLote.tallaSpecified = true;
                lineasPreparadas.Add(lineaLote);

                System.Diagnostics.Debug.WriteLine($"✅ Línea preparada - Lote ID: {lineaLote.lote.idLote}");
            }

            ordenParaEnviar.items = lineasPreparadas.ToArray();

            // 🔹 VERIFICACIÓN FINAL
            System.Diagnostics.Debug.WriteLine($"=== VERIFICACIÓN FINAL - {lineasPreparadas.Count} LÍNEAS PREPARADAS ===");
            for (int i = 0; i < lineasPreparadas.Count; i++)
            {
                var linea = lineasPreparadas[i];
                System.Diagnostics.Debug.WriteLine($"Línea {i + 1}: Prenda={linea.idPrenda}, Lote={linea.lote.idLote}");
            }

            return ordenParaEnviar;
        }

        private bool ValidarCampos()
        {
            List<string> errores = new List<string>();

            // 🔹 VALIDAR FECHAS
            if (string.IsNullOrWhiteSpace(txtFechaEmision.Text))
                errores.Add("La fecha de emisión es obligatoria.");

            if (string.IsNullOrWhiteSpace(txtFechaLlegada.Text))
                errores.Add("La fecha de llegada es obligatoria.");

            if (errores.Count == 0) // Solo validar si las fechas existen
            {
                try
                {
                    DateTime fechaEmision = DateTime.Parse(txtFechaEmision.Text);
                    DateTime fechaLlegada = DateTime.Parse(txtFechaLlegada.Text);

                    if (fechaLlegada <= fechaEmision)
                        errores.Add("La fecha de llegada debe ser posterior a la fecha de emisión.");
                }
                catch
                {
                    errores.Add("Formato de fecha inválido.");
                }
            }

            // 🔹 VALIDAR EMPLEADO (SIMPLIFICADO - YA VIENE DE SESIÓN)
            if (string.IsNullOrWhiteSpace(txtIDEmpleado.Text) || !int.TryParse(txtIDEmpleado.Text, out int idEmpleado) || idEmpleado <= 0)
            {
                errores.Add("Error: No se pudo obtener el ID del empleado. Por favor, inicie sesión nuevamente.");
            }

            // 🔹 VALIDAR PROVEEDOR
            if (string.IsNullOrWhiteSpace(hdnIdProveedor.Value))
                errores.Add("Debe seleccionar un proveedor.");
            else if (!int.TryParse(hdnIdProveedor.Value, out int idProveedor) || idProveedor <= 0)
                errores.Add("El ID del proveedor debe ser un número válido mayor a cero.");

            // 🔹 VALIDAR LÍNEAS
            if (LineasOrden == null || LineasOrden.Count == 0)
                errores.Add("Debe agregar al menos una línea a la orden.");

            // 🔹 MOSTRAR ERRORES
            if (errores.Count > 0)
            {
                MostrarMensaje("❌ " + string.Join("<br/>• ", errores));
                return false;
            }

            return true;
        }

        // 🔹 NUEVO MÉTODO: Verificar sesión del empleado
        private void VerificarSesionEmpleado()
        {
            try
            {
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion != null)
                {
                    int idEmpleadoSesion = ((dynamic)empleadoSesion).idEmpleado;
                    System.Diagnostics.Debug.WriteLine($"🔍 SESIÓN EMPLEADO VERIFICADA - ID: {idEmpleadoSesion}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("❌ SESIÓN EMPLEADO: NO HAY DATOS");
                    MostrarMensaje("Error: No se encontró información del empleado en sesión.", "error");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al verificar sesión empleado: {ex.Message}");
            }
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            GuardarDatosTemporales();

            // 🔹 CORRECCIÓN: Marcar que venimos de detalle para no perder las líneas
            Session["VieneDeDetalle"] = true;

            Response.Redirect("~/RegistrarOrdenCompra.aspx");
        }

        private void GuardarDatosTemporales()
        {
            try
            {
                // 🔹 GUARDAR FECHAS
                if (DateTime.TryParse(txtFechaEmision.Text, out DateTime fechaEmision))
                {
                    OrdenTemporal.fechaEmision = fechaEmision;
                }

                if (DateTime.TryParse(txtFechaLlegada.Text, out DateTime fechaLlegada))
                {
                    OrdenTemporal.fechaLlegada = fechaLlegada;
                }

                // 🔹 GUARDAR DEUDA PENDIENTE
                if (double.TryParse(txtDeudaPendiente.Text, out double deuda))
                {
                    OrdenTemporal.deudaPendiente = deuda;
                }

                // 🔹 GUARDAR EMPLEADO
                if (int.TryParse(txtIDEmpleado.Text, out int idEmpleado))
                {
                    if (OrdenTemporal.empleado == null)
                        OrdenTemporal.empleado = new OrdenCompraWS.empleado();

                    OrdenTemporal.empleado.idEmpleado = idEmpleado;
                }

                // 🔹 GUARDAR PROVEEDOR
                if (int.TryParse(hdnIdProveedor.Value, out int idProveedor))
                {
                    if (OrdenTemporal.proveedor == null)
                        OrdenTemporal.proveedor = new OrdenCompraWS.proveedor();

                    OrdenTemporal.proveedor.idProveedor = idProveedor;
                    OrdenTemporal.proveedor.nombre = txtProveedor.Text;
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al guardar datos temporales: {ex.Message}");
            }
        }

        private void LimpiarSesiones()
        {
            Session.Remove("LineasOrdenCompra");
            Session.Remove("OrdenTemporalRegistro");
            Session.Remove("OrdenParamodificar");
            Session.Remove("OrdenParaver");
            Session.Remove("ModoOrden");
            Session.Remove("IdOrdenmodificar");
        }

        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }


        private void ProbarServicioWeb()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🔍 PROBANDO CONEXIÓN CON SERVICIO WEB...");

                var servicio = new OrdenCompraWS.OrdenCompraWSClient();

                // Probar si el servicio responde
                var ordenes = servicio.listarTodasLasOrdenesDeCompra();
                System.Diagnostics.Debug.WriteLine($"✅ Servicio web conectado. Órdenes existentes: {ordenes?.Length}");

                // Probar obtener una orden por ID (si existe alguna)
                if (ordenes != null && ordenes.Length > 0)
                {
                    var primeraOrden = servicio.obtenerOrdenDeCompraPorID(ordenes[0].idCompra);
                    System.Diagnostics.Debug.WriteLine($"✅ Puede obtener órdenes por ID: {primeraOrden != null}");
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ ERROR EN PRUEBA DE SERVICIO: {ex.Message}");
            }
        }


        private void VerificarOrdenCompleta(OrdenCompraWS.ordenCompra orden)
        {
            System.Diagnostics.Debug.WriteLine("=== VERIFICACIÓN COMPLETA DE ORDEN ===");

            // Verificar datos básicos
            System.Diagnostics.Debug.WriteLine($"📦 ORDEN:");
            System.Diagnostics.Debug.WriteLine($"   ID: {orden.idCompra}");
            System.Diagnostics.Debug.WriteLine($"   Fecha Emisión: {orden.fechaEmision}");
            System.Diagnostics.Debug.WriteLine($"   Fecha Llegada: {orden.fechaLlegada}");
            System.Diagnostics.Debug.WriteLine($"   Monto Total: {orden.montoTotal}");
            System.Diagnostics.Debug.WriteLine($"   Deuda Pendiente: {orden.deudaPendiente}");
            System.Diagnostics.Debug.WriteLine($"   Activo: {orden.activo}");

            // Verificar empleado
            if (orden.empleado != null)
            {
                System.Diagnostics.Debug.WriteLine($"👤 EMPLEADO: ID={orden.empleado.idEmpleado}");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("❌ EMPLEADO: NULL - ESTO PUEDE SER EL PROBLEMA");
            }

            // Verificar proveedor
            if (orden.proveedor != null)
            {
                System.Diagnostics.Debug.WriteLine($"🏢 PROVEEDOR: ID={orden.proveedor.idProveedor}");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("❌ PROVEEDOR: NULL - ESTO PUEDE SER EL PROBLEMA");
            }

            // Verificar líneas
            if (orden.items != null && orden.items.Length > 0)
            {
                System.Diagnostics.Debug.WriteLine($"📋 LÍNEAS: {orden.items.Length}");

                for (int i = 0; i < orden.items.Length; i++)
                {
                    var linea = orden.items[i];
                    System.Diagnostics.Debug.WriteLine($"   📍 LÍNEA {i + 1}:");
                    System.Diagnostics.Debug.WriteLine($"      Prenda ID: {linea.idPrenda}");
                    System.Diagnostics.Debug.WriteLine($"      Cantidad: {linea.cantidad}");
                    System.Diagnostics.Debug.WriteLine($"      Talla: {linea.talla}");
                    System.Diagnostics.Debug.WriteLine($"      Precio: {linea.precioLote}");
                    System.Diagnostics.Debug.WriteLine($"      Número Línea: {linea.numLinea}");
                    System.Diagnostics.Debug.WriteLine($"      Activo: {linea.activo}");

                    // Verificar lote
                    if (linea.lote != null)
                    {
                        System.Diagnostics.Debug.WriteLine($"      📦 LOTE: ID={linea.lote.idLote}, Activo={linea.lote.activo}");

                        // Verificar almacén
                        if (linea.lote.datAlmacen != null)
                        {
                            System.Diagnostics.Debug.WriteLine($"      🏭 ALMACÉN: ID={linea.lote.datAlmacen.id}, Activo={linea.lote.datAlmacen.activo}");
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("      ❌ ALMACÉN: NULL");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("      ❌ LOTE: NULL");
                    }
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("❌ LÍNEAS: NULL O VACÍO - ESTO ES EL PROBLEMA");
            }
        }
    }

    // 🔹 CLASE VIEWMODEL PARA PROVEEDORES
    public class ProveedorViewModel
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string RUC { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
    }
}