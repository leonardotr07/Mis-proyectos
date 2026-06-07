using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.BoletaService;
using WearDropWA.FacturaService;
using WearDropWA.VentaWS;

namespace WearDropWA
{
    public partial class RegistrarVentaBoleta : System.Web.UI.Page
    {
        private const double IGV_PORCENTAJE = 18;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔹 VERIFICAR MODO VISUALIZACIÓN
            string modo = Request.QueryString["modo"];
            bool modoVisualizacion = (modo == "ver");

            if (modoVisualizacion)
            {
                Session["ModoVisualizacion"] = true;
                // 🔹 CARGAR DATOS DE BOLETA SI ESTAMOS EN MODO VISUALIZACIÓN
                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    CargarBoletaParaVisualizacion(Convert.ToInt32(Request.QueryString["id"]));
                }
            }

            // 🔹 SIEMPRE CARGAR DATOS, INCLUSO EN POSTBACK
            CargarDatosVentaDesdeSesion();

            if (!IsPostBack)
            {
                // 🔹 Si venimos en modo "modificar", cambia el título
                if (!string.IsNullOrEmpty(modo) && modo.Equals("modificar", StringComparison.OrdinalIgnoreCase))
                {
                    lblTitulo.InnerText = "Modificar Boleta";
                    tituloPagina.InnerText = "Modificar Boleta";
                }

                // 🔹 CONFIGURAR INTERFAZ EN MODO VISUALIZACIÓN
                if (modoVisualizacion)
                {
                    ConfigurarModoVisualizacion();
                }
            }
        }

        // 🔹 NUEVO MÉTODO: Cargar boleta para visualización
        private void CargarBoletaParaVisualizacion(int idVenta)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔍 Cargando boleta para visualización - ID Venta: {idVenta}");

                // 🔹 OBTENER VENTA COMPLETA
                var ventaCompleta = ObtenerVentaPorId(idVenta);
                if (ventaCompleta != null && ventaCompleta.idComprobante > 0)
                {
                    // 🔹 OBTENER BOLETA DESDE EL SERVICIO
                    var boletaClient = new BoletaWSClient();
                    var boleta = boletaClient.obtenerBoletaPorId(ventaCompleta.idComprobante);

                    if (boleta != null)
                    {
                        // 🔹 CARGAR DATOS DE LA BOLETA
                        CargarDatosBoleta(boleta, ventaCompleta);
                        System.Diagnostics.Debug.WriteLine($"✅ Boleta cargada para visualización - ID: {boleta.idComprobante}");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("❌ No se pudo cargar la boleta para visualización");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ La venta no tiene comprobante asociado");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar boleta para visualización: {ex.Message}");
            }
        }

        // 🔹 NUEVO MÉTODO: Cargar datos de boleta
        private void CargarDatosBoleta(BoletaService.boleta boleta, VentaWS.venta venta)
        {
            try
            {
                // 🔹 CARGAR DATOS DE LA BOLETA
                txtDNI.Text = boleta.DNI;
                txtIGV.Text = IGV_PORCENTAJE.ToString();

                // 🔹 CARGAR NOMBRES Y APELLIDOS DESDE EL CLIENTE DE LA VENTA
                if (venta.cliente != null)
                {
                    txtNombresApellidos.Text = $"{venta.cliente.nombre} {venta.cliente.primerApellido} {venta.cliente.segundoApellido}";
                }

                // 🔹 MOSTRAR TOTALES
                MostrarTotalesDirectos(venta.total);

                System.Diagnostics.Debug.WriteLine($"✅ Datos de boleta cargados - DNI: {boleta.DNI}, Total: {venta.total}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar datos de boleta: {ex.Message}");
            }
        }

        // 🔹 NUEVO MÉTODO: Configurar modo visualización en boleta
        private void ConfigurarModoVisualizacion()
        {
            try
            {
                // 🔹 HACER TODOS LOS CAMPOS DE SOLO LECTURA
                foreach (Control control in this.Controls)
                {
                    if (control is TextBox textBox)
                    {
                        textBox.Enabled = false;
                        textBox.CssClass = "form-control bg-light";
                    }
                }

                // 🔹 OCULTAR BOTÓN REGISTRAR
                btnRegistrarVenta.Visible = false;

                // 🔹 CAMBIAR TÍTULO
                lblTitulo.InnerText = "Visualizar Boleta";
                tituloPagina.InnerText = "Visualizar Boleta";

                System.Diagnostics.Debug.WriteLine("✅ Boleta configurada en modo visualización");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al configurar modo visualización: {ex.Message}");
            }
        }

        private void CargarDatosVentaDesdeSesion()
        {
            try
            {
                var ventaCompleta = Session["VentaCompleta"] as VentaWS.venta;
                var clienteSeleccionado = Session["ClienteSeleccionado"] as VentaWS.cliente;

                // 🔹 VERIFICAR MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                bool modoVisualizacion = (modo == "ver");

                if (ventaCompleta != null && !modoVisualizacion)
                {
                    // 🔹 CARGAR DATOS EN LOS CAMPOS DE BOLETA (solo si no estamos en modo visualización)
                    if (clienteSeleccionado != null)
                    {
                        txtDNI.Text = clienteSeleccionado.dni.ToString();
                        txtNombresApellidos.Text = $"{clienteSeleccionado.nombre} {clienteSeleccionado.primerApellido} {clienteSeleccionado.segundoApellido}";
                    }

                    // 🔹 ESTABLECER IGV CONSTANTE
                    txtIGV.Text = IGV_PORCENTAJE.ToString();

                    // 🔹 MOSTRAR TOTALES DIRECTAMENTE (YA INCLUYEN IGV)
                    MostrarTotalesDirectos(ventaCompleta.total);

                    System.Diagnostics.Debug.WriteLine($"✅ Datos de venta cargados en boleta - Total: {ventaCompleta.total}");
                }
                else if (modoVisualizacion)
                {
                    // 🔹 EN MODO VISUALIZACIÓN, LOS DATOS SE CARGAN DESDE LA BD
                    System.Diagnostics.Debug.WriteLine("🔍 Modo visualización - Datos cargados desde BD");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay datos de venta en sesión");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al cargar datos desde sesión: {ex.Message}");
            }
        }

        private void MostrarTotalesDirectos(double totalVenta)
        {
            // 🔹 EL TOTAL VIENE DIRECTAMENTE DE LA VENTA (YA INCLUYE IGV)
            double subtotal = totalVenta / (1 + (IGV_PORCENTAJE / 100));
            double igvMonto = totalVenta - subtotal;

            lblSubtotal.Text = subtotal.ToString("N2");
            lblIGV.Text = igvMonto.ToString("N2");
            lblTotal.Text = totalVenta.ToString("N2");

            System.Diagnostics.Debug.WriteLine($"💰 Totales Boleta - Subtotal: {subtotal:N2}, IGV: {igvMonto:N2}, Total: {totalVenta:N2}");
        }

        private void CalcularYMostrarTotales(double totalVenta)
        {
            double igvPorcentaje = 18; // 18%
            double subtotal = totalVenta / (1 + (igvPorcentaje / 100));
            double igvMonto = totalVenta - subtotal;

            lblSubtotal.Text = subtotal.ToString("N2");
            lblIGV.Text = igvMonto.ToString("N2");
            lblTotal.Text = totalVenta.ToString("N2");
        }

        // 🔹 Botón "Regresar"
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            try
            {
                string modo = Request.QueryString["modo"];
                string idVenta = Request.QueryString["id"];

                if (modo == "ver")
                {
                    // 🔹 EN MODO VISUALIZACIÓN, REGRESAR AL RESUMEN EN MODO VER
                    string urlRetorno = $"~/RegistroVentaResumenVenta.aspx?modo=ver&id={idVenta}";
                    System.Diagnostics.Debug.WriteLine($"🔄 Regresando al resumen en modo visualización: {urlRetorno}");
                    Response.Redirect(urlRetorno);
                    return;
                }

                // 🔹 INDICAR QUE VENIMOS DE COMPROBANTE PARA MANTENER DATOS
                Session["VieneDeComprobante"] = true;

                string urlRetornoNormal = "~/RegistroVentaResumenVenta.aspx";
                if (!string.IsNullOrEmpty(modo))
                {
                    urlRetornoNormal += $"?modo={modo}";
                    if (!string.IsNullOrEmpty(idVenta))
                    {
                        urlRetornoNormal += $"&id={idVenta}";
                    }
                }

                System.Diagnostics.Debug.WriteLine($"🔄 Regresando a resumen: {urlRetornoNormal}");
                Response.Redirect(urlRetornoNormal);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al regresar: {ex.Message}");
                MostrarMensaje($"Error al regresar: {ex.Message}");
            }
        }

        // 🔹 MODIFICAR EL MÉTODO btnRegistrarVenta_Click EN RegistrarVentaBoleta.aspx.cs
        protected void btnRegistrarVenta_Click(object sender, EventArgs e)
        {
            try
            {
                // 🔹 VERIFICAR MODO VISUALIZACIÓN
                string modo = Request.QueryString["modo"];
                if (modo == "ver")
                {
                    System.Diagnostics.Debug.WriteLine("⚠️ Modo visualización - No se permite registrar");
                    return;
                }

                // Validaciones básicas
                if (string.IsNullOrWhiteSpace(txtDNI.Text) ||
                    string.IsNullOrWhiteSpace(txtNombresApellidos.Text))
                {
                    MostrarMensaje("Por favor, completa los campos obligatorios antes de continuar.");
                    return;
                }

                // 🔹 OBTENER DATOS DE LA VENTA DESDE SESIÓN
                var ventaCompleta = Session["VentaCompleta"] as VentaWS.venta;
                if (ventaCompleta == null)
                {
                    MostrarMensaje("Error: No se encontraron datos de la venta en sesión.");
                    return;
                }

                // 🔹 CORRECCIÓN CRÍTICA: ASIGNAR FECHA Y MARCAR fechaSpecified COMO TRUE
                if (ventaCompleta.fecha == DateTime.MinValue)
                {
                    ventaCompleta.fecha = DateTime.Now;
                }
                ventaCompleta.fechaSpecified = true; // 🔹 ESTA LÍNEA ES CLAVE

                // 🔹 ASIGNAR EMPLEADO DESDE SESIÓN
                var empleadoSesion = Session["empleadoLog"];
                if (empleadoSesion == null)
                {
                    MostrarMensaje("Error: No se encontró información del empleado en sesión.");
                    return;
                }

                // 🔹 ASIGNAR ID EMPLEADO DESDE SESIÓN
                ventaCompleta.empleado.idEmpleado = ((dynamic)empleadoSesion).idEmpleado;

                // 🔹 1. ELIMINAR COMPROBANTE ANTERIOR SI EXISTE (EN MODO MODIFICACIÓN)
                if (modo == "editar" && ventaCompleta.idComprobante > 0)
                {
                    EliminarComprobanteAnterior(ventaCompleta.idComprobante, "Boleta");
                    System.Diagnostics.Debug.WriteLine($"🗑️ Comprobante anterior eliminado - ID: {ventaCompleta.idComprobante}");
                }

                // 🔹 2. INSERTAR NUEVA BOLETA
                int idComprobante = InsertarBoleta(ventaCompleta.total);

                if (idComprobante > 0)
                {
                    // 🔹 3. ACTUALIZAR VENTA CON EL NUEVO ID COMPROBANTE
                    ventaCompleta.idComprobante = idComprobante;

                    // 🔹 DEBUG: VERIFICAR DATOS ANTES DE INSERTAR
                    System.Diagnostics.Debug.WriteLine($"🔍 DATOS VENTA ANTES DE INSERTAR:");
                    System.Diagnostics.Debug.WriteLine($"   - ID Venta: {ventaCompleta.idVenta}");
                    System.Diagnostics.Debug.WriteLine($"   - Fecha: {ventaCompleta.fecha}");
                    System.Diagnostics.Debug.WriteLine($"   - fechaSpecified: {ventaCompleta.fechaSpecified}");
                    System.Diagnostics.Debug.WriteLine($"   - Total: {ventaCompleta.total}");
                    System.Diagnostics.Debug.WriteLine($"   - Cliente ID: {ventaCompleta.cliente?.idCliente}");
                    System.Diagnostics.Debug.WriteLine($"   - Empleado ID: {ventaCompleta.empleado?.idEmpleado}");
                    System.Diagnostics.Debug.WriteLine($"   - Comprobante ID: {ventaCompleta.idComprobante}");

                    // 🔹 4. INSERTAR O ACTUALIZAR VENTA
                    int resultadoVenta = 0;
                    var client = new VentaWSClient();

                    if (modo == "editar" && ventaCompleta.idVenta > 0)
                    {
                        resultadoVenta = client.modificarVenta(ventaCompleta);
                        System.Diagnostics.Debug.WriteLine($"✅ Venta MODIFICADA - ID: {ventaCompleta.idVenta}");
                    }
                    else
                    {
                        resultadoVenta = client.insertarVenta(ventaCompleta);
                        System.Diagnostics.Debug.WriteLine($"✅ Venta INSERTADA - Nuevo ID: {resultadoVenta}");
                    }

                    if (resultadoVenta > 0)
                    {
                        // 🔹 5. LIMPIAR SESIONES Y REDIRIGIR
                        LimpiarSesiones();
                        MostrarMensajeExito("✅ Venta " + (modo == "editar" ? "actualizada" : "registrada") + " correctamente con boleta.");
                        Response.Redirect("~/GestionarVentas.aspx");
                    }
                    else
                    {
                        MostrarMensajeError("❌ Error al " + (modo == "editar" ? "actualizar" : "registrar") + " la venta.");
                    }
                }
                else
                {
                    MostrarMensajeError("❌ Error al registrar la boleta.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al registrar venta con boleta: {ex.Message}");
                MostrarMensajeError("❌ Error al registrar la venta: " + ex.Message);
            }
        }


        // 🔹 MÉTODO PARA LIMPIAR SESIONES
        private void LimpiarSesiones()
        {
            Session.Remove("VentaCompleta");
            Session.Remove("ClienteSeleccionado");
            Session.Remove("LineasVenta");
            Session.Remove("VentaTemporalRegistro");
            System.Diagnostics.Debug.WriteLine("🧹 Sesiones de venta limpiadas");
        }

        private int InsertarVenta(VentaWS.venta venta)
        {
            try
            {
                var client = new VentaWSClient();
                string modo = Request.QueryString["modo"];

                int resultado = 0;

                if (modo == "editar")
                {
                    resultado = client.modificarVenta(venta);
                    System.Diagnostics.Debug.WriteLine($"✅ Venta actualizada - ID: {venta.idVenta}");
                }
                else
                {
                    resultado = client.insertarVenta(venta);
                    System.Diagnostics.Debug.WriteLine($"✅ Venta insertada - Nuevo ID: {resultado}");
                }

                return resultado;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al insertar venta: {ex.Message}");
                return 0;
            }
        }

        // 🔹 AGREGAR ESTE MÉTODO PARA ELIMINAR COMPROBANTE ANTERIOR
        private void EliminarComprobanteAnterior(int idComprobante, string tipoComprobante)
        {
            try
            {
                if (idComprobante <= 0) return;

                System.Diagnostics.Debug.WriteLine($"🔍 Intentando eliminar comprobante anterior - Tipo: {tipoComprobante}, ID: {idComprobante}");

                bool eliminado = false;

                if (tipoComprobante == "Boleta")
                {
                    try
                    {
                        var boletaClient = new BoletaWSClient();
                        int resultado = boletaClient.eliminarBoleta(idComprobante);
                        eliminado = (resultado > 0);
                        System.Diagnostics.Debug.WriteLine($"✅ Boleta anterior eliminada - ID: {idComprobante}, Resultado: {resultado}");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"⚠️ Error al eliminar boleta anterior: {ex.Message}");
                    }
                }
                else if (tipoComprobante == "Factura")
                {
                    try
                    {
                        var facturaClient = new FacturaWSClient();
                        int resultado = facturaClient.eliminarFactura(idComprobante);
                        eliminado = (resultado > 0);
                        System.Diagnostics.Debug.WriteLine($"✅ Factura anterior eliminada - ID: {idComprobante}, Resultado: {resultado}");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"⚠️ Error al eliminar factura anterior: {ex.Message}");
                    }
                }

                if (!eliminado)
                {
                    System.Diagnostics.Debug.WriteLine($"ℹ️ No se pudo eliminar comprobante anterior, pero se continúa con el proceso");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR CRÍTICO al eliminar comprobante anterior: {ex.Message}");
                // No lanzamos excepción para permitir continuar con el nuevo registro
            }
        }


        // 🔹 MÉTODOS AUXILIARES PARA MENSAJES (agregar en ambas clases)
        private void MostrarMensajeExito(string mensaje)
        {
            string script = $@"
        Swal.fire({{
            icon: 'success',
            title: '¡Éxito!',
            text: '{mensaje.Replace("'", "\\'")}',
            confirmButtonColor: '#A86E75',
            confirmButtonText: 'Aceptar'
        }});
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "successAlert", script, true);
        }

        private void MostrarMensajeError(string mensaje)
        {
            string script = $@"
        Swal.fire({{
            icon: 'error',
            title: 'Error',
            text: '{mensaje.Replace("'", "\\'")}',
            confirmButtonColor: '#A86E75',
            confirmButtonText: 'Aceptar'
        }});
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "errorAlert", script, true);
        }



        //🔹 MÉTODO PARA INSERTAR BOLETA
        private int InsertarBoleta(double totalVenta)
        {
            try
            {
                var boleta = new BoletaService.boleta();

                // 🔹 DATOS DE LA BOLETA
                boleta.fecha = DateTime.Now;
                boleta.total = totalVenta;
                boleta.IGV = totalVenta * 0.18; // 18% del total
                boleta.metodoDePago = "Efectivo"; // Puedes hacerlo configurable
                boleta.correlativo = GenerarCorrelativoBoleta();
                boleta.DNI = txtDNI.Text;

                // 🔹 LLAMAR AL SERVICIO WEB
                var client = new BoletaWSClient();
                int idComprobante = client.insertarBoleta(boleta);

                System.Diagnostics.Debug.WriteLine($"✅ Boleta insertada - ID: {idComprobante}");
                return idComprobante;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al insertar boleta: {ex.Message}");
                return 0;
            }
        }

        // 🔹 MÉTODO PARA GENERAR CORRELATIVO DE BOLETA
        private string GenerarCorrelativoBoleta()
        {
            // Ejemplo: B001-0000001 (puedes implementar tu lógica de numeración)
            Random rnd = new Random();
            return $"B{rnd.Next(1000, 9999)}-{rnd.Next(1000000, 9999999)}";
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

        // 🔹 Calcula el total considerando el IGV
        private decimal CalcularTotalConIGV(decimal igv)
        {
            // Supongamos un subtotal fijo solo para ejemplo:
            decimal subtotal = 100; // <-- este valor vendría de tus productos o lógica real
            decimal total = subtotal + (subtotal * (igv / 100));
            return total;
        }

        // 🔹 Limpia los campos después de guardar
        private void LimpiarCampos()
        {
            txtDNI.Text = string.Empty;
            txtNombresApellidos.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtIGV.Text = string.Empty;
        }

        // 🔹 Método para mostrar mensajes en el navegador
        private void MostrarMensaje(string mensaje)
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", script, true);
        }
    }
}