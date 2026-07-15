using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ClienteWS;
using WearDropWA.VentaWS;

namespace WearDropWA
{
    public partial class RegistroVentaResumenVenta : System.Web.UI.Page
    {
        // 🔹 CLASE ADAPTADORA PARA CONVERTIR ENTRE ClienteWS.cliente Y VentaWS.cliente
        public static class ClienteAdapter
        {
            public static VentaWS.cliente ConvertToVentaCliente(ClienteWS.cliente clienteWS)
            {
                if (clienteWS == null) return null;

                var ventaCliente = new VentaWS.cliente();

                // Mapear propiedades básicas
                ventaCliente.idCliente = clienteWS.idCliente;
                ventaCliente.nombre = clienteWS.nombre;
                ventaCliente.primerApellido = clienteWS.primerApellido;
                ventaCliente.segundoApellido = clienteWS.segundoApellido;
                ventaCliente.dni = clienteWS.dni;
                ventaCliente.telefono = clienteWS.telefono;
                ventaCliente.genero = clienteWS.genero;
                ventaCliente.activo = clienteWS.activo;

                // Mapear tipo de cliente si existe
                if (clienteWS.tipo != null)
                {
                    ventaCliente.tipo = new VentaWS.tipoDeCliente();
                    ventaCliente.tipo.tipoCliente = clienteWS.tipo.tipoCliente;
                    ventaCliente.tipo.abreviatura = clienteWS.tipo.abreviatura;
                    ventaCliente.tipo.descripcion = clienteWS.tipo.descripcion;
                }

                return ventaCliente;
            }
        }

        // 🔹 CORREGIDO: Usar VentaWS.cliente para consistencia
        private VentaWS.cliente ClienteSeleccionado
        {
            get { return Session["ClienteSeleccionado"] as VentaWS.cliente; }
            set { Session["ClienteSeleccionado"] = value; }
        }

        private VentaWS.venta VentaCompleta
        {
            get { return Session["VentaCompleta"] as VentaWS.venta; }
            set { Session["VentaCompleta"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine($"=== PAGE_LOAD RegistroVentaResumenVenta ===");
            System.Diagnostics.Debug.WriteLine($"IsPostBack: {IsPostBack}");

            // 🔹 VERIFICAR SESIÓN DEL EMPLEADO
            VerificarSesionEmpleado();

            // 🔹 VERIFICAR MODO VISUALIZACIÓN
            string modo = Request.QueryString["modo"];
            bool modoVisualizacion = (modo == "ver");

            if (modoVisualizacion)
            {
                Session["ModoVisualizacion"] = true;
                // 🔹 CARGAR VENTA COMPLETA SI ESTAMOS EN MODO VISUALIZACIÓN
                if (VentaCompleta == null && !string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    CargarVentaParaVisualizacion(Convert.ToInt32(Request.QueryString["id"]));
                }
            }

            // 🔹 SIEMPRE CARGAR DATOS, INCLUSO EN POSTBACK
            CargarDatosVenta();

            // 🔹 VERIFICAR ESTADO DE LA VENTA
            VerificarEstadoVenta();

            // 🔹 GARANTIZAR QUE EL CAMPO EMPLEADO SIEMPRE SEA READONLY (INCLUSO EN POSTBACK)
            txtIDEmpleado.ReadOnly = true;
            txtIDEmpleado.CssClass = "form-control bg-light";

            if (!IsPostBack)
            {
                ConfigurarInterfazPorModo(modo);

                // 🔹 CONFIGURAR INTERFAZ EN MODO VISUALIZACIÓN
                if (modoVisualizacion)
                {
                    ConfigurarModoVisualizacion();
                }
            }

            // 🔹 SIEMPRE CARGAR INFORMACIÓN DEL CLIENTE SI EXISTE
            if (ClienteSeleccionado != null)
            {
                MostrarInformacionCliente();
            }
        }

        // 🔹 NUEVO MÉTODO: Cargar venta para visualización
        private void CargarVentaParaVisualizacion(int idVenta)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Cargando venta para visualización - ID: {idVenta}");

                var ventaCompleta = ObtenerVentaPorId(idVenta);

                if (ventaCompleta != null)
                {
                    VentaCompleta = ventaCompleta;

                    // 🔹 CARGAR CLIENTE SI EXISTE
                    if (ventaCompleta.cliente != null && ventaCompleta.cliente.idCliente > 0)
                    {
                        ClienteSeleccionado = ventaCompleta.cliente;
                    }

                    System.Diagnostics.Debug.WriteLine($"✅ Venta cargada para visualización - ID: {ventaCompleta.idVenta}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("❌ No se pudo cargar la venta para visualización");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar venta para visualización: {ex.Message}");
            }
        }

        // 🔹 EVENTO PARA RESALTAR FILA SELECCIONADA
        protected void gvClientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // 🔹 VERIFICAR MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    // 🔹 EN MODO VISUALIZACIÓN, DESHABILITAR BOTÓN SELECCIONAR
                    var btnSeleccionar = e.Row.FindControl("btnSeleccionarCliente") as LinkButton;
                    if (btnSeleccionar != null)
                    {
                        btnSeleccionar.Enabled = false;
                        btnSeleccionar.CssClass = "btn btn-sm btn-secondary";
                        btnSeleccionar.Text = "Solo Lectura";
                    }
                }
                else
                {
                    // 🔹 AGREGAR EVENTO CLICK PARA SELECCIÓN VISUAL
                    e.Row.Attributes["onclick"] = "seleccionarFila(this)";
                    e.Row.Style["cursor"] = "pointer";
                }

                // 🔹 RESALTAR SI ES EL CLIENTE ACTUALMENTE SELECCIONADO
                if (ClienteSeleccionado != null)
                {
                    var idClienteFila = DataBinder.Eval(e.Row.DataItem, "Id").ToString();
                    if (idClienteFila == ClienteSeleccionado.idCliente.ToString())
                    {
                        e.Row.CssClass += " selected";
                    }
                }
            }
        }

        // 🔹 EVENTO PARA ABRIR MODAL DE CLIENTES (ACTUALIZADO)
        protected void btnSeleccionarCliente_Click(object sender, EventArgs e)
        {
            try
            {
                // 🔹 VERIFICAR MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite seleccionar cliente");
                    return;
                }

                CargarClientesEnModal();

                string script = @"
            console.log('Mostrando modal de clientes...');
            var modal = new bootstrap.Modal(document.getElementById('modalSeleccionarCliente'));
            modal.show();
            
            // Inicializar interacciones del modal
            setTimeout(function() {
                inicializarModalClientes();
            }, 300);
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalClientes", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar clientes: {ex.Message}", "error");
            }
        }

        // 🔹 CARGAR CLIENTES EN EL MODAL (CORREGIDO)
        private void CargarClientesEnModal()
        {
            try
            {
                var clienteWS = new ClienteWSClient();
                var clientes = clienteWS.listarClientes();

                // 🔹 CORRECCIÓN: Usar Count() en lugar de Count
                if (clientes != null && clientes.Count() > 0)
                {
                    var clientesViewModel = new List<ClienteViewModel>();

                    foreach (var cliente in clientes)
                    {
                        if (cliente != null && cliente.activo)
                        {
                            clientesViewModel.Add(new ClienteViewModel
                            {
                                Id = cliente.idCliente,
                                NombreCompleto = $"{cliente.nombre} {cliente.primerApellido} {cliente.segundoApellido}",
                                DNI = cliente.dni.ToString(),
                                Telefono = cliente.telefono.ToString(),
                                TipoCliente = ObtenerDescripcionTipoCliente(cliente.tipo)
                            });
                        }
                    }

                    gvClientes.DataSource = clientesViewModel;
                    gvClientes.DataBind();

                    System.Diagnostics.Debug.WriteLine($"✅ {clientesViewModel.Count} clientes cargados en el modal");
                }
                else
                {
                    gvClientes.DataSource = null;
                    gvClientes.DataBind();
                    System.Diagnostics.Debug.WriteLine("ℹ️ No se encontraron clientes activos");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar clientes: {ex.Message}");
                throw new Exception($"Error al cargar lista de clientes: {ex.Message}");
            }
        }

        // 🔹 OBTENER DESCRIPCIÓN DEL TIPO DE CLIENTE (CORREGIDO)
        private string ObtenerDescripcionTipoCliente(ClienteWS.tipoDeCliente tipo)
        {
            if (tipo == null) return "No especificado";

            // 🔹 CORRECCIÓN: Conversión explícita de ushort a char
            char abreviatura = (char)tipo.abreviatura;

            switch (abreviatura)
            {
                case 'N': return "Natural";
                case 'J': return "Jurídico";
                case 'E': return "Especial";
                default: return tipo.descripcion ?? "No especificado";
            }
        }

        // 🔹 EVENTO PARA SELECCIONAR CLIENTE DESDE EL GRIDVIEW (CORREGIDO)
        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                // 🔹 VERIFICAR MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite seleccionar cliente");
                    return;
                }

                int idCliente = Convert.ToInt32(e.CommandArgument);

                try
                {
                    var clienteWS = new ClienteWSClient();
                    var clienteCompletoWS = clienteWS.obtenerClientePorId(idCliente);

                    if (clienteCompletoWS != null)
                    {
                        // 🔹 CORRECCIÓN: Convertir a VentaWS.cliente usando el adaptador
                        var clienteCompletoVenta = ClienteAdapter.ConvertToVentaCliente(clienteCompletoWS);

                        // 🔹 GUARDAR CLIENTE EN SESIÓN
                        ClienteSeleccionado = clienteCompletoVenta;

                        // 🔹 ACTUALIZAR INTERFAZ
                        MostrarInformacionCliente();

                        // 🔹 ACTUALIZAR VENTA COMPLETA
                        if (VentaCompleta != null)
                        {
                            VentaCompleta.cliente = clienteCompletoVenta;
                            Session["VentaCompleta"] = VentaCompleta;
                        }

                        System.Diagnostics.Debug.WriteLine($"✅ Cliente seleccionado - ID: {clienteCompletoVenta.idCliente}, Nombre: {clienteCompletoVenta.nombre}");

                        // CERRAR MODAL
                        CerrarModalCliente();

                        MostrarMensaje($"Cliente seleccionado: {clienteCompletoVenta.nombre} {clienteCompletoVenta.primerApellido}", "exito");
                    }
                    else
                    {
                        MostrarMensaje("Error al cargar los detalles del cliente seleccionado.", "error");
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al seleccionar cliente: {ex.Message}", "error");
                }
            }
        }

        // 🔹 MOSTRAR INFORMACIÓN DEL CLIENTE SELECCIONADO (CORREGIDO)
        private void MostrarInformacionCliente()
        {
            if (ClienteSeleccionado != null)
            {
                txtIDCliente.Text = ClienteSeleccionado.idCliente.ToString();

                // ACTUALIZAR LABELS
                lblNombreCliente.InnerText = $"{ClienteSeleccionado.nombre} {ClienteSeleccionado.primerApellido} {ClienteSeleccionado.segundoApellido}";
                lblDNICliente.InnerText = $"DNI: {ClienteSeleccionado.dni}";
                lblTelefonoCliente.InnerText = $"Tel: {ClienteSeleccionado.telefono}";
                lblTipoCliente.InnerText = $"Tipo: {ObtenerDescripcionTipoClienteVenta(ClienteSeleccionado.tipo)}";

                pnlInfoCliente.Visible = true;

                System.Diagnostics.Debug.WriteLine($"✅ Información del cliente mostrada - ID: {ClienteSeleccionado.idCliente}");
            }
        }

        // 🔹 VERSIÓN PARA VentaWS.tipoDeCliente (CORREGIDA)
        private string ObtenerDescripcionTipoClienteVenta(VentaWS.tipoDeCliente tipo)
        {
            if (tipo == null) return "No especificado";

            // 🔹 CORRECCIÓN: Conversión explícita de ushort a char
            char abreviatura = (char)tipo.abreviatura;

            switch (abreviatura)
            {
                case 'N': return "Natural";
                case 'J': return "Jurídico";
                case 'E': return "Especial";
                default: return tipo.descripcion ?? "No especificado";
            }
        }

        // 🔹 CERRAR MODAL DE CLIENTE
        private void CerrarModalCliente()
        {
            string script = @"
                console.log('Cerrando modal de clientes...');
                var modalElement = document.getElementById('modalSeleccionarCliente');
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

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalCliente", script, true);
        }

        // 🔹 MODIFICAR EL MÉTODO CargarDatosVenta EN RegistroVentaResumenVenta.aspx.cs
        private void CargarDatosVenta()
        {
            try
            {
                if (VentaCompleta == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ No hay venta completa en sesión");
                    return;
                }

                // 🔹 CARGAR DATOS EN LOS CAMPOS (SIEMPRE)
                txtIDVenta.Text = VentaCompleta.idVenta.ToString();
                txtMontoTotal.Text = VentaCompleta.total.ToString("N2");

                // 🔹 ASIGNAR EMPLEADO AUTOMÁTICAMENTE DESDE SESIÓN
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion != null)
                {
                    int idEmpleadoSesion = ((dynamic)empleadoSesion).idEmpleado;

                    // 🔹 VERIFICAR MODO VISUALIZACIÓN
                    string modo = Request.QueryString["modo"];

                    if (modo == "ver")
                    {
                        // En modo visualización, mostrar el empleado de la venta
                        if (VentaCompleta.empleado != null && VentaCompleta.empleado.idEmpleado > 0)
                        {
                            txtIDEmpleado.Text = VentaCompleta.empleado.idEmpleado.ToString();
                        }
                        else
                        {
                            txtIDEmpleado.Text = idEmpleadoSesion.ToString();
                        }
                    }
                    else
                    {
                        // En modo registro/edición, asignar automáticamente el empleado de sesión
                        txtIDEmpleado.Text = idEmpleadoSesion.ToString();

                        // 🔹 ACTUALIZAR LA VENTA EN SESIÓN
                        if (VentaCompleta.empleado == null)
                        {
                            VentaCompleta.empleado = new VentaWS.empleado();
                        }
                        VentaCompleta.empleado.idEmpleado = idEmpleadoSesion;
                        Session["VentaCompleta"] = VentaCompleta;

                        System.Diagnostics.Debug.WriteLine($"✅ Empleado asignado automáticamente - ID: {idEmpleadoSesion}");
                    }

                    // 🔹 HACER EL CAMPO READONLY Y APLICAR ESTILO
                    txtIDEmpleado.ReadOnly = true;
                    txtIDEmpleado.CssClass = "form-control bg-light";
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ No se encontró empleado en sesión");
                    // 🔹 AUN ASÍ HACER EL CAMPO READONLY
                    txtIDEmpleado.ReadOnly = true;
                    txtIDEmpleado.CssClass = "form-control bg-light";
                }

                // 🔹 CARGAR FECHA
                if (VentaCompleta.fecha != DateTime.MinValue)
                {
                    txtFecha.Text = VentaCompleta.fecha.ToString("yyyy-MM-dd");
                }
                else
                {
                    txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }

                // 🔹 CARGAR TIPO DE COMPROBANTE SI EXISTE
                if (VentaCompleta.idComprobante > 0)
                {
                    string tipoComprobante = DeterminarTipoComprobante(VentaCompleta.idComprobante);
                    if (!string.IsNullOrEmpty(tipoComprobante))
                    {
                        ddlTipoComprobante.SelectedValue = tipoComprobante;
                    }
                }

                // 🔹 CARGAR CLIENTE AUTOMÁTICAMENTE SI EXISTE EN LA VENTA
                if (VentaCompleta.cliente != null && VentaCompleta.cliente.idCliente > 0)
                {
                    CargarClienteAutomaticamente(VentaCompleta.cliente.idCliente);
                }

                System.Diagnostics.Debug.WriteLine("✅ Datos de venta cargados en resumen");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarDatosVenta: {ex.Message}");
            }
        }




        private void CargarClienteAutomaticamente(int idCliente)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Cargando cliente automáticamente - ID: {idCliente}");

                // 🔹 VERIFICAR SI EL CLIENTE YA ESTÁ EN SESIÓN
                if (ClienteSeleccionado != null && ClienteSeleccionado.idCliente == idCliente)
                {
                    System.Diagnostics.Debug.WriteLine("✅ Cliente ya está en sesión, mostrando información");
                    MostrarInformacionCliente();
                    return;
                }

                // 🔹 OBTENER CLIENTE DESDE EL SERVICIO
                var clienteWS = new ClienteWSClient();
                var clienteCompletoWS = clienteWS.obtenerClientePorId(idCliente);

                if (clienteCompletoWS != null)
                {
                    // 🔹 CONVERTIR A VentaWS.cliente usando el adaptador
                    var clienteCompletoVenta = ClienteAdapter.ConvertToVentaCliente(clienteCompletoWS);

                    // 🔹 GUARDAR CLIENTE EN SESIÓN
                    ClienteSeleccionado = clienteCompletoVenta;

                    // 🔹 ACTUALIZAR INTERFAZ
                    MostrarInformacionCliente();

                    // 🔹 ACTUALIZAR VENTA COMPLETA
                    if (VentaCompleta != null)
                    {
                        VentaCompleta.cliente = clienteCompletoVenta;
                        Session["VentaCompleta"] = VentaCompleta;
                    }

                    System.Diagnostics.Debug.WriteLine($"✅ Cliente cargado automáticamente - ID: {clienteCompletoVenta.idCliente}, Nombre: {clienteCompletoVenta.nombre}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ No se pudo cargar el cliente con ID: {idCliente}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar cliente automáticamente: {ex.Message}");
            }
        }

        // 🔹 NUEVO MÉTODO: Determinar tipo de comprobante
        private string DeterminarTipoComprobante(int idComprobante)
        {
            try
            {
                // Intentar obtener boleta
                var boletaClient = new BoletaService.BoletaWSClient();
                var boleta = boletaClient.obtenerBoletaPorId(idComprobante);
                if (boleta != null && boleta.idComprobante > 0)
                {
                    return "Boleta";
                }
            }
            catch { }

            try
            {
                // Intentar obtener factura
                var facturaClient = new FacturaService.FacturaWSClient();
                var factura = facturaClient.obtenerFacturaPorId(idComprobante);
                if (factura != null && factura.idComprobante > 0)
                {
                    return "Factura";
                }
            }
            catch { }

            return "";
        }

        // 🔹 MÉTODO ACTUALIZADO: Configurar interfaz por modo
        private void ConfigurarInterfazPorModo(string modo)
        {
            if (modo == "editar")
            {
                lblTitulo.InnerText = "Modificar Venta - Resumen";
                tituloPagina.InnerText = "Modificar Venta";
                btnRegistrarComprobante.Text = " Actualizar Venta";
            }
            else if (modo == "ver")
            {
                lblTitulo.InnerText = "Visualizar Venta - Resumen";
                tituloPagina.InnerText = "Visualizar Venta";
                btnRegistrarComprobante.Text = " Ver Comprobante";
            }
            else
            {
                lblTitulo.InnerText = "Registrar Venta - Resumen";
                tituloPagina.InnerText = "Registrar Venta";
                btnRegistrarComprobante.Text = " Registrar Comprobante";
            }

            // 🔹 HACER READONLY LOS CAMPOS QUE NO SE DEBEN MODIFICAR
            txtIDVenta.ReadOnly = true;
            txtMontoTotal.ReadOnly = true;
            txtIDEmpleado.ReadOnly = true; // 🔹 NUEVO: EMPLEADO TAMBIÉN READONLY

            txtIDVenta.CssClass = "form-control bg-light";
            txtMontoTotal.CssClass = "form-control bg-light";
            txtIDEmpleado.CssClass = "form-control bg-light"; // 🔹 NUEVO: ESTILO CONSISTENTE
        }

        // 🔹 MÉTODO PARA VERIFICAR LA SESIÓN DEL EMPLEADO
        private void VerificarSesionEmpleado()
        {
            try
            {
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion != null)
                {
                    int idEmpleadoSesion = ((dynamic)empleadoSesion).idEmpleado;
                    System.Diagnostics.Debug.WriteLine($"🔍 SESIÓN EMPLEADO - ID: {idEmpleadoSesion}");

                    // 🔹 VERIFICAR SI EL OBJETO TIENE MÁS PROPIEDADES
                    var tipo = empleadoSesion.GetType();
                    System.Diagnostics.Debug.WriteLine($"🔍 TIPO DE OBJETO: {tipo}");

                    // 🔹 INTENTAR OBTENER MÁS PROPIEDADES SI ES POSIBLE
                    if (tipo.GetProperty("nombre") != null)
                    {
                        dynamic emp = empleadoSesion;
                        System.Diagnostics.Debug.WriteLine($"🔍 EMPLEADO: {emp.nombre} {emp.apellido}");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("❌ SESIÓN EMPLEADO: NO HAY DATOS");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al verificar sesión empleado: {ex.Message}");
            }
        }


        // 🔹 NUEVO MÉTODO: Configurar modo visualización en resumen
        private void ConfigurarModoVisualizacion()
        {
            try
            {
                // 🔹 HACER CAMPOS DE SOLO LECTURA
                txtIDCliente.Enabled = false;
                txtIDEmpleado.Enabled = false;
                txtFecha.Enabled = false;
                ddlTipoComprobante.Enabled = false;

                // 🔹 CAMBIAR ESTILOS PARA INDICAR SOLO LECTURA
                txtIDCliente.CssClass = "form-control bg-light";
                txtIDEmpleado.CssClass = "form-control bg-light";
                txtFecha.CssClass = "form-control bg-light";
                ddlTipoComprobante.CssClass = "form-select bg-light";

                // 🔹 DESHABILITAR BOTÓN SELECCIONAR CLIENTE
                btnSeleccionarCliente.Enabled = false;
                btnSeleccionarCliente.CssClass = "btn-seleccionar-cliente bg-secondary";

                System.Diagnostics.Debug.WriteLine("✅ Interfaz configurada en modo visualización (Resumen)");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al configurar modo visualización: {ex.Message}");
            }
        }

        private bool ValidarFormularioParaComprobante()
        {
            try
            {
                // 🔹 EN MODO VISUALIZACIÓN, NO VALIDAR CAMPOS OBLIGATORIOS
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    return true;
                }

                System.Diagnostics.Debug.WriteLine("🔍 VALIDANDO FORMULARIO PARA COMPROBANTE...");

                // Validar Cliente seleccionado
                if (ClienteSeleccionado == null || ClienteSeleccionado.idCliente == 0)
                {
                    MostrarMensaje("Por favor, seleccione un cliente.", "error");
                    System.Diagnostics.Debug.WriteLine("❌ Validación fallida: No hay cliente seleccionado");
                    return false;
                }
                System.Diagnostics.Debug.WriteLine($"✅ Cliente válido - ID: {ClienteSeleccionado.idCliente}");

                // Validar ID Empleado
                if (string.IsNullOrEmpty(txtIDEmpleado.Text) || !int.TryParse(txtIDEmpleado.Text, out int idEmpleado) || idEmpleado <= 0)
                {
                    MostrarMensaje("Por favor, ingrese un ID de empleado válido.", "error");
                    System.Diagnostics.Debug.WriteLine("❌ Validación fallida: ID Empleado inválido");
                    return false;
                }
                System.Diagnostics.Debug.WriteLine($"✅ Empleado válido - ID: {idEmpleado}");

                // Validar Fecha
                if (string.IsNullOrEmpty(txtFecha.Text))
                {
                    MostrarMensaje("Por favor, seleccione una fecha válida.", "error");
                    System.Diagnostics.Debug.WriteLine("❌ Validación fallida: Fecha vacía");
                    return false;
                }
                System.Diagnostics.Debug.WriteLine($"✅ Fecha válida: {txtFecha.Text}");

                // Validar Tipo de Comprobante
                if (string.IsNullOrEmpty(ddlTipoComprobante.SelectedValue))
                {
                    MostrarMensaje("Por favor, seleccione un tipo de comprobante.", "error");
                    System.Diagnostics.Debug.WriteLine("❌ Validación fallida: Tipo comprobante no seleccionado");
                    return false;
                }
                System.Diagnostics.Debug.WriteLine($"✅ Tipo comprobante válido: {ddlTipoComprobante.SelectedValue}");

                // Validar que hay productos en la venta
                if (VentaCompleta == null || VentaCompleta.productos == null || VentaCompleta.productos.Length == 0)
                {
                    MostrarMensaje("La venta debe tener al menos un producto.", "error");
                    System.Diagnostics.Debug.WriteLine("❌ Validación fallida: No hay productos en la venta");
                    return false;
                }
                System.Diagnostics.Debug.WriteLine($"✅ Productos válidos: {VentaCompleta.productos.Length} items");

                System.Diagnostics.Debug.WriteLine("✅ VALIDACIÓN COMPLETADA CORRECTAMENTE");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en ValidarFormularioParaComprobante: {ex.Message}");
                MostrarMensaje($"Error en validación: {ex.Message}", "error");
                return false;
            }
        }

        protected void btnRegistrarComprobante_Click(object sender, EventArgs e)
        {
            try
            {
                string modo = Request.QueryString["modo"];

                if (modo == "ver")
                {
                    // 🔹 EN MODO VISUALIZACIÓN, REDIRIGIR AL COMPROBANTE EN MODO VER
                    string tipoComprobante = ddlTipoComprobante.SelectedValue;
                    string paginaDestino = "";

                    switch (tipoComprobante)
                    {
                        case "Boleta":
                            paginaDestino = "~/RegistrarVentaBoleta.aspx";
                            break;
                        case "Factura":
                            paginaDestino = "~/RegistrarVentaFactura.aspx";
                            break;
                        default:
                            MostrarMensaje("No se pudo determinar el tipo de comprobante.", "error");
                            return;
                    }

                    Response.Redirect($"{paginaDestino}?modo=ver&id={Request.QueryString["id"]}");
                    return;
                }

                // 🔹 VALIDAR CAMPOS OBLIGATORIOS (sin guardar en BD todavía)
                if (!ValidarFormularioParaComprobante())
                {
                    return;
                }

                // 🔹 ACTUALIZAR VENTA EN SESIÓN CON DATOS ACTUALES DEL FORMULARIO
                ActualizarVentaDesdeFormulario();

                // 🔹 VERIFICAR QUE LA VENTA SE ACTUALIZÓ CORRECTAMENTE
                if (VentaCompleta == null)
                {
                    MostrarMensaje("Error: No se pudo actualizar la venta en sesión.", "error");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"✅ VENTA ACTUALIZADA PARA {modo.ToUpper()}:");
                System.Diagnostics.Debug.WriteLine($"   - ID Venta: {VentaCompleta.idVenta}");
                System.Diagnostics.Debug.WriteLine($"   - Cliente ID: {VentaCompleta.cliente?.idCliente}");
                System.Diagnostics.Debug.WriteLine($"   - Empleado ID: {VentaCompleta.empleado?.idEmpleado}");
                System.Diagnostics.Debug.WriteLine($"   - Fecha: {VentaCompleta.fecha}");
                System.Diagnostics.Debug.WriteLine($"   - Total: {VentaCompleta.total}");
                System.Diagnostics.Debug.WriteLine($"   - Comprobante ID: {VentaCompleta.idComprobante}");

                // 🔹 DETERMINAR A QUÉ PÁGINA REDIRIGIR SEGÚN EL TIPO DE COMPROBANTE
                string tipoComprobanteNormal = ddlTipoComprobante.SelectedValue;
                string paginaDestinoNormal = "";

                switch (tipoComprobanteNormal)
                {
                    case "Boleta":
                        paginaDestinoNormal = "~/RegistrarVentaBoleta.aspx";
                        break;
                    case "Factura":
                        paginaDestinoNormal = "~/RegistrarVentaFactura.aspx";
                        break;
                    default:
                        MostrarMensaje("Por favor, seleccione un tipo de comprobante válido.", "error");
                        return;
                }

                // 🔹 GUARDAR INFORMACIÓN DE NAVEGACIÓN PARA PODER REGRESAR
                Session["VieneDeResumenVenta"] = true;
                Session["PaginaOrigenResumen"] = "RegistroVentaResumenVenta.aspx";

                // 🔹 MANTENER EL MODO (editar/registrar) EN LA REDIRECCIÓN
                string idVenta = Request.QueryString["id"];

                string parametros = $"?modo={modo}";
                if (!string.IsNullOrEmpty(idVenta))
                {
                    parametros += $"&id={idVenta}";
                }

                System.Diagnostics.Debug.WriteLine($"🔄 Redirigiendo a: {paginaDestinoNormal}{parametros}");
                Response.Redirect($"{paginaDestinoNormal}{parametros}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al redirigir a comprobante: {ex.Message}");
                MostrarMensaje($"Error al preparar comprobante: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO PARA VALIDAR FORMULARIO (ACTUALIZADO)
        private bool ValidarFormulario()
        {
            // 🔹 EN MODO VISUALIZACIÓN, NO VALIDAR
            string modo = Request.QueryString["modo"];
            if (modo == "ver")
            {
                return true;
            }

            // Validar Cliente seleccionado
            if (ClienteSeleccionado == null || ClienteSeleccionado.idCliente == 0)
            {
                MostrarMensaje("Por favor, seleccione un cliente.", "error");
                return false;
            }

            // Validar ID Empleado
            if (string.IsNullOrEmpty(txtIDEmpleado.Text) || !int.TryParse(txtIDEmpleado.Text, out int idEmpleado) || idEmpleado <= 0)
            {
                MostrarMensaje("Por favor, ingrese un ID de empleado válido.", "error");
                return false;
            }

            // Validar Fecha
            if (string.IsNullOrEmpty(txtFecha.Text))
            {
                MostrarMensaje("Por favor, seleccione una fecha válida.", "error");
                return false;
            }

            // Validar Tipo de Comprobante
            if (string.IsNullOrEmpty(ddlTipoComprobante.SelectedValue))
            {
                MostrarMensaje("Por favor, seleccione un tipo de comprobante.", "error");
                return false;
            }

            return true;
        }

        // 🔹 MÉTODO MEJORADO: Actualizar venta desde formulario
        private void ActualizarVentaDesdeFormulario()
        {
            try
            {
                if (VentaCompleta == null)
                {
                    throw new Exception("No hay venta completa para actualizar.");
                }

                System.Diagnostics.Debug.WriteLine("🔄 ACTUALIZANDO VENTA DESDE FORMULARIO...");

                // 🔹 ACTUALIZAR CLIENTE (YA ESTÁ EN SESIÓN)
                if (ClienteSeleccionado != null)
                {
                    VentaCompleta.cliente = ClienteSeleccionado;
                    System.Diagnostics.Debug.WriteLine($"✅ Cliente actualizado - ID: {ClienteSeleccionado.idCliente}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ No hay cliente seleccionado");
                }

                // 🔹 ACTUALIZAR EMPLEADO DESDE SESIÓN
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion != null)
                {
                    if (VentaCompleta.empleado == null)
                    {
                        VentaCompleta.empleado = new VentaWS.empleado();
                    }

                    int idEmpleadoSesion = ((dynamic)empleadoSesion).idEmpleado;
                    VentaCompleta.empleado.idEmpleado = idEmpleadoSesion;
                    System.Diagnostics.Debug.WriteLine($"✅ Empleado actualizado - ID: {idEmpleadoSesion}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ No se encontró empleado en sesión");
                }

                // 🔹 CORRECCIÓN: Actualizar fecha asegurando formato correcto
                if (!string.IsNullOrEmpty(txtFecha.Text))
                {
                    try
                    {
                        VentaCompleta.fecha = DateTime.Parse(txtFecha.Text);
                        VentaCompleta.fechaSpecified = true; // 🔹 IMPORTANTE
                        System.Diagnostics.Debug.WriteLine($"✅ Fecha actualizada: {VentaCompleta.fecha:yyyy-MM-dd}");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"⚠️ Error al parsear fecha, usando fecha actual: {ex.Message}");
                        VentaCompleta.fecha = DateTime.Now;
                        VentaCompleta.fechaSpecified = true; // 🔹 IMPORTANTE
                    }
                }
                else
                {
                    // Si no hay fecha en el campo, usar fecha actual
                    VentaCompleta.fecha = DateTime.Now;
                    VentaCompleta.fechaSpecified = true; // 🔹 IMPORTANTE
                    System.Diagnostics.Debug.WriteLine("ℹ️ Usando fecha actual por defecto");
                }

                // 🔹 ACTUALIZAR TIPO DE COMPROBANTE (generar ID temporal si es necesario)
                if (!string.IsNullOrEmpty(ddlTipoComprobante.SelectedValue))
                {
                    // Solo generar ID temporal si no existe uno (para no sobreescribir en modificación)
                    if (VentaCompleta.idComprobante <= 0)
                    {
                        VentaCompleta.idComprobante = GenerarIdComprobanteTemporal();
                        System.Diagnostics.Debug.WriteLine($"✅ ID Comprobante temporal generado: {VentaCompleta.idComprobante}");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"ℹ️ ID Comprobante ya existe: {VentaCompleta.idComprobante} (no se genera temporal)");
                    }
                }

                // 🔹 MANTENER EL TOTAL DE LA VENTA (no se modifica en el resumen)
                System.Diagnostics.Debug.WriteLine($"💰 Total mantenido: {VentaCompleta.total}");

                // 🔹 MANTENER LOS PRODUCTOS SI EXISTEN
                if (VentaCompleta.productos != null && VentaCompleta.productos.Length > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"📦 Productos mantenidos: {VentaCompleta.productos.Length}");
                }

                // 🔹 GUARDAR VENTA ACTUALIZADA EN SESIÓN
                Session["VentaCompleta"] = VentaCompleta;

                System.Diagnostics.Debug.WriteLine("✅ VENTA ACTUALIZADA CORRECTAMENTE DESDE FORMULARIO");
                System.Diagnostics.Debug.WriteLine($"   - Cliente ID: {VentaCompleta.cliente?.idCliente}");
                System.Diagnostics.Debug.WriteLine($"   - Empleado ID: {VentaCompleta.empleado?.idEmpleado}");
                System.Diagnostics.Debug.WriteLine($"   - Fecha: {VentaCompleta.fecha:yyyy-MM-dd}");
                System.Diagnostics.Debug.WriteLine($"   - Total: {VentaCompleta.total}");
                System.Diagnostics.Debug.WriteLine($"   - Comprobante ID: {VentaCompleta.idComprobante}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en ActualizarVentaDesdeFormulario: {ex.Message}");
                throw;
            }
        }

        // 🔹 MÉTODO PARA VERIFICAR ESTADO DE LA VENTA
        private void VerificarEstadoVenta()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("=== VERIFICACIÓN ESTADO VENTA ===");

                if (VentaCompleta == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ VENTA COMPLETA: NULL");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"📋 DATOS ACTUALES DE LA VENTA:");
                System.Diagnostics.Debug.WriteLine($"   - ID Venta: {VentaCompleta.idVenta}");
                System.Diagnostics.Debug.WriteLine($"   - Fecha: {VentaCompleta.fecha}");
                System.Diagnostics.Debug.WriteLine($"   - Total: {VentaCompleta.total}");
                System.Diagnostics.Debug.WriteLine($"   - Comprobante ID: {VentaCompleta.idComprobante}");
                System.Diagnostics.Debug.WriteLine($"   - Activo: {VentaCompleta.activo}");

                if (VentaCompleta.cliente != null)
                {
                    System.Diagnostics.Debug.WriteLine($"   - Cliente ID: {VentaCompleta.cliente.idCliente}");
                    System.Diagnostics.Debug.WriteLine($"   - Cliente Nombre: {VentaCompleta.cliente.nombre} {VentaCompleta.cliente.primerApellido}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"   - Cliente: NULL");
                }

                if (VentaCompleta.empleado != null)
                {
                    System.Diagnostics.Debug.WriteLine($"   - Empleado ID: {VentaCompleta.empleado.idEmpleado}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"   - Empleado: NULL");
                }

                if (VentaCompleta.productos != null)
                {
                    System.Diagnostics.Debug.WriteLine($"   - Productos: {VentaCompleta.productos.Length} items");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"   - Productos: NULL");
                }

                System.Diagnostics.Debug.WriteLine("=== FIN VERIFICACIÓN ===");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en VerificarEstadoVenta: {ex.Message}");
            }
        }

        // 🔹 MÉTODO TEMPORAL PARA GENERAR ID DE COMPROBANTE
        private int GenerarIdComprobanteTemporal()
        {
            return new Random().Next(1000, 9999);
        }

        // 🔹 MÉTODO PARA OBTENER VENTA POR ID
        private VentaWS.venta ObtenerVentaPorId(int idVenta)
        {
            try
            {
                VentaWSClient client = new VentaWSClient();
                return client.obtenerVentaPorId(idVenta);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al obtener venta por ID: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO MEJORADO PARA REGRESAR DESDE COMPROBANTES
        protected void btnRegresarVenta_Click(object sender, EventArgs e)
        {
            try
            {
                string modo = Request.QueryString["modo"];
                string idVenta = Request.QueryString["id"];

                if (modo == "ver")
                {
                    // 🔹 EN MODO VISUALIZACIÓN, REGRESAR A REGISTRAR VENTAS EN MODO VER
                    string urlRetorno = $"~/RegistarVentas.aspx?modo=ver&id={idVenta}";
                    System.Diagnostics.Debug.WriteLine($"🔄 Regresando a líneas de venta en modo visualización: {urlRetorno}");
                    Response.Redirect(urlRetorno);
                    return;
                }

                // 🔹 ACTUALIZAR LA VENTA EN SESIÓN CON LOS CAMBIOS ACTUALES
                ActualizarVentaDesdeFormulario();

                System.Diagnostics.Debug.WriteLine("🔹 Regresando a RegistrarVentas manteniendo datos...");

                string urlRetornoNormal = "~/RegistarVentas.aspx";
                if (!string.IsNullOrEmpty(modo))
                {
                    urlRetornoNormal += $"?modo={modo}";
                    if (!string.IsNullOrEmpty(idVenta))
                    {
                        urlRetornoNormal += $"&id={idVenta}";
                    }
                }

                Response.Redirect(urlRetornoNormal);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al regresar: {ex.Message}");
                MostrarMensaje($"Error al regresar: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO PARA MOSTRAR MENSAJES
        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }
    }

    // 🔹 CLASE VIEWMODEL PARA CLIENTES
    public class ClienteViewModel
    {
        public int Id { get; set; }
        public string NombreCompleto { get; set; }
        public string DNI { get; set; }
        public string Telefono { get; set; }
        public string TipoCliente { get; set; }
    }
}