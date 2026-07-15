using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DevolucionWS;
using WearDropWA.PackagePrendas;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class RegistrarDevolucion : System.Web.UI.Page
    {
        private string Modo => Session["ModoDevolucion"]?.ToString() ?? "nuevo";
        private DevolucionWS.devolucion DevolucionSeleccionada =>
            Session["DevolucionSeleccionada"] as DevolucionWS.devolucion;

        // 🔹 Propiedades para mantener estado
        private int IdProveedorSeleccionado
        {
            get { return Convert.ToInt32(Session["IdProveedorSeleccionado"] ?? "0"); }
            set { Session["IdProveedorSeleccionado"] = value; }
        }

        private string NombreProveedorSeleccionado
        {
            get { return Session["NombreProveedorSeleccionado"]?.ToString() ?? ""; }
            set { Session["NombreProveedorSeleccionado"] = value; }
        }

        private int IdPrendaSeleccionada
        {
            get { return Convert.ToInt32(Session["IdPrendaSeleccionada"] ?? "0"); }
            set { Session["IdPrendaSeleccionada"] = value; }
        }

        private string NombrePrendaSeleccionada
        {
            get { return Session["NombrePrendaSeleccionada"]?.ToString() ?? ""; }
            set { Session["NombrePrendaSeleccionada"] = value; }
        }

        private string TipoPrendaSeleccionada
        {
            get { return Session["TipoPrendaSeleccionada"]?.ToString() ?? ""; }
            set { Session["TipoPrendaSeleccionada"] = value; }
        }

        // 🔹 NUEVA PROPIEDAD PARA PRECIO UNITARIO
        private decimal PrecioUnitario
        {
            get { return Convert.ToDecimal(Session["PrecioUnitario"] ?? "0"); }
            set { Session["PrecioUnitario"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarModo();
                CargarTiposDePrenda();

                if (Modo != "nuevo" && DevolucionSeleccionada != null)
                {
                    CargarDatosDevolucionExistente();
                }
                else
                {
                    // Inicializar para modo nuevo
                    txtFechaDevolucion.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    btnSeleccionarPrenda.Enabled = false;
                }
            }
        }

        private void ConfigurarModo()
        {
            switch (Modo)
            {
                case "ver":
                    Page.Title = "Ver Devolución";
                    lblTitulo.Text = "Ver Devolución";
                    btnGuardar.Visible = false;
                    btnCancelar.Text = "Regresar";
                    DeshabilitarControles();
                    break;

                case "modificar":
                    Page.Title = "Modificar Devolución";
                    lblTitulo.Text = "Modificar Devolución";
                    btnGuardar.Text = "Actualizar Devolución";
                    break;

                case "nuevo":
                default:
                    Page.Title = "Registrar Devolución";
                    lblTitulo.Text = "Registrar Devolución";
                    btnGuardar.Text = "Guardar Devolución";
                    break;
            }
        }

        private void DeshabilitarControles()
        {
            txtFechaDevolucion.Enabled = false;
            txtMotivo.Enabled = false;
            btnSeleccionarProveedor.Enabled = false;
            ddlTipoPrenda.Enabled = false;
            btnSeleccionarPrenda.Enabled = false;
            txtCantidad.Enabled = false;
            ddlTalla.Enabled = false;
            txtPrecioUnitario.Enabled = false;
            txtMontoTotal.Enabled = false;
        }

        private void CargarDatosDevolucionExistente()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🚀 CARGANDO DEVOLUCIÓN EXISTENTE - ID: {DevolucionSeleccionada.id}");

                // 🔹 CARGAR DATOS BÁSICOS
                txtFechaDevolucion.Text = DevolucionSeleccionada.fecha.ToString("yyyy-MM-dd");
                txtMotivo.Text = DevolucionSeleccionada.descripcion;

                // 🔹 CARGAR PROVEEDOR
                if (DevolucionSeleccionada.proveedor != null)
                {
                    IdProveedorSeleccionado = DevolucionSeleccionada.proveedor.idProveedor;
                    NombreProveedorSeleccionado = DevolucionSeleccionada.proveedor.nombre;
                    txtProveedor.Text = NombreProveedorSeleccionado;
                    hdnIdProveedor.Value = IdProveedorSeleccionado.ToString();
                }

                // 🔹 CARGAR PRENDA
                if (DevolucionSeleccionada.idPrenda > 0)
                {
                    IdPrendaSeleccionada = DevolucionSeleccionada.idPrenda;
                    NombrePrendaSeleccionada = DevolucionSeleccionada.nombrePrenda;
                    txtNombrePrenda.Text = NombrePrendaSeleccionada;
                    hdnIdPrenda.Value = IdPrendaSeleccionada.ToString();


                    // 🔹 BUSCAR Y CARGAR EL TIPO DE PRENDA
                    var tipoPrenda = BuscarTipoPrenda(IdPrendaSeleccionada);
                    if (!string.IsNullOrEmpty(tipoPrenda))
                    {
                        ddlTipoPrenda.SelectedValue = tipoPrenda;
                        TipoPrendaSeleccionada = tipoPrenda;
                    }
                }

                // 🔹 CARGAR TALLA
                if (!string.IsNullOrEmpty(DevolucionSeleccionada.talla.ToString()))
                {
                    ddlTalla.SelectedValue = DevolucionSeleccionada.talla.ToString();
                }

                // 🔹 CARGAR CANTIDAD Y MONTO
                txtCantidad.Text = DevolucionSeleccionada.cantidad.ToString();
                txtMontoTotal.Text = DevolucionSeleccionada.monto.ToString("F2");

                System.Diagnostics.Debug.WriteLine($"🏁 CARGA COMPLETADA - Modo: {Modo}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR CRÍTICO: {ex.Message}");
                MostrarMensaje($"Error al cargar los datos: {ex.Message}", "error");
            }
        }

        private string BuscarTipoPrenda(int idPrenda)
        {
            try
            {
                string[] tipos = { "Blusa", "Casaca", "Falda", "Gorro", "Pantalon", "Polo", "Vestido" };

                foreach (string tipo in tipos)
                {
                    try
                    {
                        var prenda = BuscarPrendaPorId(idPrenda, tipo);
                        if (prenda != null)
                        {
                            return tipo;
                        }
                    }
                    catch
                    {
                        continue;
                    }
                }
                return "";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error buscando tipo de prenda: {ex.Message}");
                return "";
            }
        }

        private PrendaViewModel BuscarPrendaPorId(int idPrenda, string tipoPrenda)
        {
            try
            {
                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new BlusaWSClient();
                        var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                        return (blusa != null && blusa.idPrenda > 0) ?
                            new PrendaViewModel { Id = blusa.idPrenda, Nombre = blusa.nombre } : null;

                    case "Casaca":
                        var casacaWS = new CasacaWSClient();
                        var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                        return (casaca != null && casaca.idPrenda > 0) ?
                            new PrendaViewModel { Id = casaca.idPrenda, Nombre = casaca.nombre } : null;

                    case "Falda":
                        var faldaWS = new FaldaWSClient();
                        var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                        return (falda != null && falda.idPrenda > 0) ?
                            new PrendaViewModel { Id = falda.idPrenda, Nombre = falda.nombre } : null;

                    case "Gorro":
                        var gorroWS = new GorroWSClient();
                        var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                        return (gorro != null && gorro.idPrenda > 0) ?
                            new PrendaViewModel { Id = gorro.idPrenda, Nombre = gorro.nombre } : null;

                    case "Pantalon":
                        var pantalonWS = new PantalonWSClient();
                        var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                        return (pantalon != null && pantalon.idPrenda > 0) ?
                            new PrendaViewModel { Id = pantalon.idPrenda, Nombre = pantalon.nombre } : null;

                    case "Polo":
                        var poloWS = new PoloWSClient();
                        var polo = poloWS.obtenerPoloPorId(idPrenda);
                        return (polo != null && polo.idPrenda > 0) ?
                            new PrendaViewModel { Id = polo.idPrenda, Nombre = polo.nombre } : null;

                    case "Vestido":
                        var vestidoWS = new VestidoWSClient();
                        var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                        return (vestido != null && vestido.idPrenda > 0) ?
                            new PrendaViewModel { Id = vestido.idPrenda, Nombre = vestido.nombre } : null;

                    default:
                        return null;
                }
            }
            catch
            {
                return null;
            }
        }

        // 🔹 VALIDACIÓN DE CAMPOS MEJORADA
        private bool ValidarCampos()
        {
            if (string.IsNullOrEmpty(txtFechaDevolucion.Text))
            {
                MostrarMensaje("La fecha de devolución es obligatoria.", "error");
                return false;
            }

            if (string.IsNullOrEmpty(txtMotivo.Text))
            {
                MostrarMensaje("El motivo de devolución es obligatorio.", "error");
                return false;
            }

            if (IdProveedorSeleccionado == 0)
            {
                MostrarMensaje("Debe seleccionar un proveedor.", "error");
                return false;
            }

            if (IdPrendaSeleccionada == 0)
            {
                MostrarMensaje("Debe seleccionar una prenda.", "error");
                return false;
            }

            if (string.IsNullOrEmpty(ddlTalla.SelectedValue))
            {
                MostrarMensaje("Debe seleccionar una talla.", "error");
                return false;
            }

            if (!int.TryParse(txtCantidad.Text, out int cantidad) || cantidad <= 0)
            {
                MostrarMensaje("La cantidad debe ser un número válido mayor a cero.", "error");
                return false;
            }

            if (PrecioUnitario <= 0)
            {
                MostrarMensaje("El precio unitario debe ser mayor a cero.", "error");
                return false;
            }

            return true;
        }

        // 🔹 EVENTO PARA CALCULAR MONTO
        protected void txtCantidad_TextChanged(object sender, EventArgs e)
        {
            CalcularMontoTotal();
        }

        private void CalcularMontoTotal()
        {
            if (int.TryParse(txtCantidad.Text, out int cantidad) && cantidad > 0 && PrecioUnitario > 0)
            {
                decimal montoTotal = cantidad * PrecioUnitario;
                txtMontoTotal.Text = montoTotal.ToString("F2");
            }
            else
            {
                txtMontoTotal.Text = "0.00";
            }
        }

        private string ObtenerStringTalla(DevolucionWS.talla tallaEnum)
        {
            switch (tallaEnum)
            {
                case DevolucionWS.talla.XS: return "XS";
                case DevolucionWS.talla.S: return "S";
                case DevolucionWS.talla.M: return "M";
                case DevolucionWS.talla.L: return "L";
                case DevolucionWS.talla.XL: return "XL";
                case DevolucionWS.talla.XXL: return "XXL";
                default: return "M";
            }
        }
        // 🔹 GUARDAR DEVOLUCIÓN MEJORADO
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
                return;

            try
            {
                System.Diagnostics.Debug.WriteLine("🎯 INICIANDO GUARDADO DE DEVOLUCIÓN");

                // 🔹 OBTENER EMPLEADO DE SESIÓN
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion == null)
                {
                    MostrarMensaje("Error: No se encontró información del empleado en sesión.", "error");
                    return;
                }
                

                // 🔹 CREAR OBJETO DEVOLUCIÓN
                var devolucion = new devolucion();


                devolucion.fecha = DateTime.Parse(txtFechaDevolucion.Text);
                devolucion.descripcion = txtMotivo.Text.Trim();
                devolucion.cantidad = int.Parse(txtCantidad.Text);
                if (Enum.TryParse(ddlTalla.SelectedValue, out DevolucionWS.talla tallaEnum))
                {
                    devolucion.talla = tallaEnum;
                    devolucion.tallaSpecified = true;
                }
                else
                {
                    // Manejar el caso cuando la conversión falla
                    // Puedes asignar un valor por defecto o mostrar un error
                    devolucion.talla = DevolucionWS.talla.S; // Valor por defecto
                }
                devolucion.monto = (double)decimal.Parse(txtMontoTotal.Text);
                devolucion.idPrenda = IdPrendaSeleccionada;
                devolucion.idProveedor = IdProveedorSeleccionado;
                devolucion.nombrePrenda = NombrePrendaSeleccionada;
                devolucion.idEmpleado = ((dynamic)empleadoSesion).idEmpleado;
                devolucion.activo = true;


                var devolucionWS = new DevolucionWSClient();
                int resultado;

                if (Modo == "modificar" && DevolucionSeleccionada != null)
                {
                    // 🔹 ACTUALIZAR DEVOLUCIÓN EXISTENTE
                    devolucion.id = DevolucionSeleccionada.id;
                    resultado = devolucionWS.modificarDevolucion(devolucion);
                }
                else
                {
                    // 🔹 INSERTAR NUEVA DEVOLUCIÓN
                    resultado = devolucionWS.insertarDevolucion(devolucion);
                }

                if (resultado != 0)
                {
                    MostrarMensaje(Modo == "modificar" ? "Devolución actualizada correctamente." : "Devolución registrada correctamente.", "exito");

                    // 🔹 LIMPIAR Y REDIRIGIR DESPUÉS DE GUARDAR
                    LimpiarSesionesTemporales();
                    ScriptManager.RegisterStartupScript(this, GetType(), "redirigir",
                        "setTimeout(function() { window.location.href = 'ListarDevoluciones.aspx'; }, 1500);", true);
                }
                else
                {
                    MostrarMensaje("Error al guardar la devolución.", "error");
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en btnGuardar_Click: {ex.Message}");
                MostrarMensaje($"Error al guardar devolución: {ex.Message}", "error");
            }
        }

        // 🔹 CANCELAR/REGRESAR
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarSesionesTemporales();
            Response.Redirect("~/ListarDevoluciones.aspx");
        }

        private void LimpiarSesionesTemporales()
        {
            Session.Remove("DevolucionSeleccionada");
            Session.Remove("ModoDevolucion");
            Session.Remove("IdProveedorSeleccionado");
            Session.Remove("NombreProveedorSeleccionado");
            Session.Remove("IdPrendaSeleccionada");
            Session.Remove("NombrePrendaSeleccionada");
            Session.Remove("TipoPrendaSeleccionada");
            Session.Remove("PrecioUnitario");
        }

        // 🔹 MOSTRAR MENSAJES
        // 🔹 MOSTRAR MENSAJES - CORREGIDO
        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            if (lblMensaje != null)
            {
                lblMensaje.Text = mensaje;
                lblMensaje.CssClass = $"mensaje-alerta mensaje-{tipo}";
                lblMensaje.Visible = true;

                // 🔹 CORRECCIÓN: Solo registrar el script si el mensaje está visible
                if (lblMensaje.Visible)
                {
                    string script = $@"
                setTimeout(function() {{
                    var mensajeElement = document.getElementById('{lblMensaje.ClientID}');
                    if (mensajeElement) {{
                        mensajeElement.style.display = 'none';
                    }}
                }}, 5000);";

                    ScriptManager.RegisterStartupScript(this, GetType(), "ocultarMensaje", script, true);
                }
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

        // 🔹 EVENTO CAMBIO EN DROPDOWN DE TIPO DE PRENDA
        protected void ddlTipoPrenda_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlTipoPrenda.SelectedValue;
            bool tieneValorValido = !string.IsNullOrEmpty(selectedValue) && selectedValue != "";

            btnSeleccionarPrenda.Enabled = tieneValorValido;

            // 🔹 LIMPIAR SELECCIÓN ANTERIOR
            if (tieneValorValido)
            {
                txtNombrePrenda.Text = "";
                hdnIdPrenda.Value = "";
                IdPrendaSeleccionada = 0;
                NombrePrendaSeleccionada = "";
                TipoPrendaSeleccionada = selectedValue;
                PrecioUnitario = 0;
                txtPrecioUnitario.Text = "0.00";
                txtMontoTotal.Text = "0.00";
            }
        }

        // 🔹 ABRIR MODAL PARA SELECCIONAR PROVEEDOR - CORREGIDO
        protected void btnSeleccionarProveedor_Click(object sender, EventArgs e)
        {
            try
            {
                CargarProveedoresEnModal();

                // Actualizar el UpdatePanel
                UpdatePanel1.Update();

                // ✅ CORREGIDO - Usar el mismo patrón que en AnnadirLineaDeLaCompra
                string script = @"
            console.log('Mostrando modal de proveedor...');
            var modal = new bootstrap.Modal(document.getElementById('modalSeleccionarProveedor'));
            modal.show();
        ";
                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalProveedor", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al abrir selector de proveedores: {ex.Message}", "error");
            }
        }

        // 🔹 CARGAR PROVEEDORES EN MODAL - CORREGIDO
        private void CargarProveedoresEnModal()
        {
            try
            {
                var proveedorWS = new ProveedorWSClient();
                var proveedores = proveedorWS.listarActivosSinCondiciones();

                var proveedoresList = new List<ProveedorViewModel>();

                if (proveedores != null)
                {
                    foreach (var prov in proveedores)
                    {
                        if (prov != null && prov.activo)
                        {
                            proveedoresList.Add(new ProveedorViewModel
                            {
                                Id = prov.idProveedor,
                                Nombre = prov.nombre ?? "Sin nombre",
                                RUC = prov.RUC.ToString() ?? "Sin RUC",
                                Telefono = prov.telefono.ToString() 
                            });
                        }
                    }
                }

                if (proveedoresList.Count == 0)
                {
                    MostrarMensaje("No se encontraron proveedores activos.", "info");
                }

                gvProveedores.DataSource = proveedoresList;
                gvProveedores.DataBind();

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar proveedores: {ex.Message}", "error");
                System.Diagnostics.Debug.WriteLine($"ERROR Proveedores: {ex.Message}");
            }
        }

        // 🔹 SELECCIONAR PROVEEDOR DESDE GRIDVIEW - CORREGIDO
        protected void gvProveedores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarProveedor")
            {
                string[] argumentos = e.CommandArgument.ToString().Split('|');
                if (argumentos.Length >= 2)
                {
                    IdProveedorSeleccionado = int.Parse(argumentos[0]);
                    NombreProveedorSeleccionado = argumentos[1];

                    txtProveedor.Text = NombreProveedorSeleccionado;
                    hdnIdProveedor.Value = IdProveedorSeleccionado.ToString();

                    System.Diagnostics.Debug.WriteLine($"✅ Proveedor seleccionado - ID: {IdProveedorSeleccionado}, Nombre: {NombreProveedorSeleccionado}");

                    // Cerrar el modal usando el mismo patrón
                    string cerrarScript = @"
                console.log('Cerrando modal de proveedor...');
                var modalElement = document.getElementById('modalSeleccionarProveedor');
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

                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalProveedor", cerrarScript, true);

                    MostrarMensaje($"Proveedor seleccionado: {NombreProveedorSeleccionado}", "exito");
                    UpdatePanel1.Update();
                }
            }
        }

        // 🔹 ABRIR MODAL PARA SELECCIONAR PRENDA - CORREGIDO
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
                // 1. Cargar datos en el GridView
                CargarPrendasEnModal(tipoPrenda);
                lblTipoPrendaModal.Text = tipoPrenda;

                // 2. Actualizar el UpdatePanel para reflejar los cambios
                UpdatePanel1.Update();

                // 3. Mostrar el modal DESPUÉS de actualizar el UpdatePanel
                string script = @"
            console.log('Mostrando modal después de actualizar UpdatePanel');
            var modal = new bootstrap.Modal(document.getElementById('modalSeleccionarPrenda'));
            modal.show();
        ";

                ScriptManager.RegisterStartupScript(this, GetType(), "mostrarModalPrenda", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al abrir selector de prendas: {ex.Message}", "error");
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
                        prendas = ObtenerBlusas();
                        break;
                    case "Casaca":
                        prendas = ObtenerCasacas();
                        break;
                    case "Falda":
                        prendas = ObtenerFaldas();
                        break;
                    case "Gorro":
                        prendas = ObtenerGorros();
                        break;
                    case "Pantalon":
                        prendas = ObtenerPantalones();
                        break;
                    case "Polo":
                        prendas = ObtenerPolos();
                        break;
                    case "Vestido":
                        prendas = ObtenerVestidos();
                        break;
                    default:
                        MostrarMensaje("Tipo de prenda no válido.", "error");
                        return;
                }

                if (prendas.Count == 0)
                {
                    MostrarMensaje($"No se encontraron prendas de tipo {tipoPrenda} activas.", "info");
                }

                gvPrendas.DataSource = prendas;
                gvPrendas.DataBind();

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar prendas: {ex.Message}", "error");
            }
        }

        // 🔹 SELECCIONAR PRENDA DESDE GRIDVIEW - MEJORADO Y CORREGIDO
        protected void gvPrendas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarPrenda")
            {
                string[] argumentos = e.CommandArgument.ToString().Split('|');
                if (argumentos.Length >= 2)
                {
                    IdPrendaSeleccionada = int.Parse(argumentos[0]);
                    NombrePrendaSeleccionada = argumentos[1];
                    TipoPrendaSeleccionada = ddlTipoPrenda.SelectedValue;

                    // 🔹 OBTENER PRECIO DE LA PRENDA
                    PrecioUnitario = ObtenerPrecioPrenda(IdPrendaSeleccionada, TipoPrendaSeleccionada);

                    txtNombrePrenda.Text = NombrePrendaSeleccionada;
                    hdnIdPrenda.Value = IdPrendaSeleccionada.ToString();
                    txtPrecioUnitario.Text = PrecioUnitario.ToString("F2");

                    // 🔹 CALCULAR MONTO SI HAY CANTIDAD
                    CalcularMontoTotal();

                    System.Diagnostics.Debug.WriteLine($"✅ Prenda seleccionada - ID: {IdPrendaSeleccionada}, Nombre: {NombrePrendaSeleccionada}, Tipo: {TipoPrendaSeleccionada}, Precio: {PrecioUnitario}");

                    // Cerrar el modal usando el mismo patrón
                    string cerrarScript = @"
                console.log('Cerrando modal de prenda...');
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

                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalPrenda", cerrarScript, true);

                    MostrarMensaje($"Prenda seleccionada: {NombrePrendaSeleccionada}", "exito");
                    UpdatePanel1.Update();
                }
            }
        }

        // 🔹 MÉTODO PARA OBTENER PRECIO DE LA PRENDA
        private decimal ObtenerPrecioPrenda(int idPrenda, string tipoPrenda)
        {
            try
            {
                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new BlusaWSClient();
                        var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                        return blusa != null ? (decimal)blusa.precioMayor : 0;

                    case "Casaca":
                        var casacaWS = new CasacaWSClient();
                        var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                        return casaca != null ? (decimal)casaca.precioMayor : 0;

                    case "Falda":
                        var faldaWS = new FaldaWSClient();
                        var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                        return falda != null ? (decimal)falda.precioMayor : 0;

                    case "Gorro":
                        var gorroWS = new GorroWSClient();
                        var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                        return gorro != null ? (decimal)gorro.precioMayor : 0;

                    case "Pantalon":
                        var pantalonWS = new PantalonWSClient();
                        var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                        return pantalon != null ? (decimal)pantalon.precioMayor : 0;

                    case "Polo":
                        var poloWS = new PoloWSClient();
                        var polo = poloWS.obtenerPoloPorId(idPrenda);
                        return polo != null ? (decimal)polo.precioMayor : 0;

                    case "Vestido":
                        var vestidoWS = new VestidoWSClient();
                        var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                        return vestido != null ? (decimal)vestido.precioMayor : 0;

                    default:
                        return 0;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error obteniendo precio: {ex.Message}");
                return 0;
            }
        }

        #region MÉTODOS PARA OBTENER PRENDAS

        private List<PrendaViewModel> ObtenerBlusas()
        {
            try
            {
                var blusaWS = new BlusaWSClient();
                var blusas = blusaWS.listarBlusas();

                return blusas.Where(b => b != null && b.activo)
                             .Select(b => new PrendaViewModel
                             {
                                 Id = b.idPrenda,
                                 Nombre = b.nombre,
                                 Color = b.color ?? "",
                                 Material = b.material.ToString() ?? "",
                                 PrecioMayor = b.precioMayor
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar blusas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerCasacas()
        {
            try
            {
                var casacaWS = new CasacaWSClient();
                var casacas = casacaWS.listarCasacas();

                return casacas.Where(c => c != null && c.activo)
                             .Select(c => new PrendaViewModel
                             {
                                 Id = c.idPrenda,
                                 Nombre = c.nombre,
                                 Color = c.color ?? "",
                                 Material = c.material.ToString() ?? "",
                                 PrecioMayor = c.precioMayor
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar casacas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerFaldas()
        {
            try
            {
                var faldaWS = new FaldaWSClient();
                var faldas = faldaWS.listarFaldas();

                return faldas.Where(f => f != null && f.activo)
                             .Select(f => new PrendaViewModel
                             {
                                 Id = f.idPrenda,
                                 Nombre = f.nombre,
                                 Color = f.color ?? "",
                                 Material = f.material.ToString() ?? "",
                                 PrecioMayor = f.precioMayor
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar faldas: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerGorros()
        {
            try
            {
                var gorroWS = new GorroWSClient();
                var gorros = gorroWS.listarGorros();

                return gorros.Where(g => g != null && g.activo)
                             .Select(g => new PrendaViewModel
                             {
                                 Id = g.idPrenda,
                                 Nombre = g.nombre,
                                 Color = g.color ?? "",
                                 Material = g.material.ToString() ?? "",
                                 PrecioMayor = g.precioMayor
                             }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar gorros: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPantalones()
        {
            try
            {
                var pantalonWS = new PantalonWSClient();
                var pantalones = pantalonWS.listarPantalones();

                return pantalones.Where(p => p != null && p.activo)
                                 .Select(p => new PrendaViewModel
                                 {
                                     Id = p.idPrenda,
                                     Nombre = p.nombre,
                                     Color = p.color ?? "",
                                     Material = p.material.ToString() ?? "",
                                     PrecioMayor = p.precioMayor
                                 }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar pantalones: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerPolos()
        {
            try
            {
                var poloWS = new PoloWSClient();
                var polos = poloWS.listarPolos();

                return polos.Where(p => p != null && p.activo)
                            .Select(p => new PrendaViewModel
                            {
                                Id = p.idPrenda,
                                Nombre = p.nombre,
                                Color = p.color ?? "",
                                Material = p.material.ToString() ?? "",
                                PrecioMayor = p.precioMayor
                            }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar polos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        private List<PrendaViewModel> ObtenerVestidos()
        {
            try
            {
                var vestidoWS = new VestidoWSClient();
                var vestidos = vestidoWS.listarVestidos();

                return vestidos.Where(v => v != null && v.activo)
                               .Select(v => new PrendaViewModel
                               {
                                   Id = v.idPrenda,
                                   Nombre = v.nombre,
                                   Color = v.color ?? "",
                                   Material = v.material.ToString() ?? "",
                                   PrecioMayor = v.precioMayor
                               }).ToList();
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar vestidos: {ex.Message}", "error");
                return new List<PrendaViewModel>();
            }
        }

        #endregion
    }
}