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
    public partial class RegistrarVentaFactura : System.Web.UI.Page
    {


        private const double IGV_PORCENTAJE = 18;
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarDatosVentaDesdeSesion();

        }


        // 🔹 MÉTODO CORREGIDO: Cargar datos de venta desde sesión
        private void CargarDatosVentaDesdeSesion()
        {
            try
            {
                var ventaCompleta = Session["VentaCompleta"] as VentaWS.venta;
                var clienteSeleccionado = Session["ClienteSeleccionado"] as VentaWS.cliente;

                if (ventaCompleta != null && clienteSeleccionado != null)
                {
                    // 🔹 SOLO CARGAR DATOS QUE NO DEBEN SER LLENADOS POR EL USUARIO

                    // 🔹 RAZÓN SOCIAL: NO SE LLENA AUTOMÁTICAMENTE - EL USUARIO LA COMPLETA
                    // txtRazonSocial.Text se deja vacío para que el usuario lo complete

                    // 🔹 NOMBRES Y APELLIDOS: Podemos sugerirlo pero el usuario puede cambiarlo
                    if (string.IsNullOrEmpty(txtNombresApellidos.Text))
                    {
                        txtNombresApellidos.Text = $"{clienteSeleccionado.nombre} {clienteSeleccionado.primerApellido} {clienteSeleccionado.segundoApellido}";
                    }

                    // 🔹 ESTABLECER IGV CONSTANTE
                    txtIGV.Text = IGV_PORCENTAJE.ToString();

                    // 🔹 MOSTRAR TOTALES DIRECTAMENTE (YA INCLUYEN IGV)
                    MostrarTotalesDirectos(ventaCompleta.total);

                    System.Diagnostics.Debug.WriteLine($"✅ Datos de factura cargados - Total: {ventaCompleta.total}");
                    System.Diagnostics.Debug.WriteLine($"ℹ️ Razón Social: Campo libre para que el usuario complete");
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

            System.Diagnostics.Debug.WriteLine($"💰 Totales Factura - Subtotal: {subtotal:N2}, IGV: {igvMonto:N2}, Total: {totalVenta:N2}");
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




        // 🔹 BOTÓN "REGRESAR" MODIFICADO (igual que en Boleta)
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            try
            {
                // 🔹 INDICAR QUE VENIMOS DE COMPROBANTE PARA MANTENER DATOS
                Session["VieneDeComprobante"] = true;

                string modo = Request.QueryString["modo"];
                string idVenta = Request.QueryString["id"];

                string urlRetorno = "~/RegistroVentaResumenVenta.aspx";
                if (!string.IsNullOrEmpty(modo))
                {
                    urlRetorno += $"?modo={modo}";
                    if (!string.IsNullOrEmpty(idVenta))
                    {
                        urlRetorno += $"&id={idVenta}";
                    }
                }

                System.Diagnostics.Debug.WriteLine($"🔄 Regresando a resumen: {urlRetorno}");
                Response.Redirect(urlRetorno);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al regresar: {ex.Message}");
                MostrarMensaje($"Error al regresar: {ex.Message}");
            }
        }


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
                if (string.IsNullOrWhiteSpace(txtRUC.Text) ||
                    string.IsNullOrWhiteSpace(txtRazonSocial.Text) ||
                    string.IsNullOrWhiteSpace(ddlMetodoPago.SelectedValue))
                {
                    MostrarMensaje("Por favor, complete los campos obligatorios antes de continuar.");
                    return;
                }

                // Validar formato de RUC
                if (txtRUC.Text.Length != 11 || !long.TryParse(txtRUC.Text, out _))
                {
                    MostrarMensaje("El RUC debe contener 11 dígitos numéricos.");
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
                    EliminarComprobanteAnterior(ventaCompleta.idComprobante, "Factura");
                    System.Diagnostics.Debug.WriteLine($"🗑️ Comprobante anterior eliminado - ID: {ventaCompleta.idComprobante}");
                }

                // 🔹 2. INSERTAR FACTURA
                int idComprobante = InsertarFactura(ventaCompleta.total);

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
                        MostrarMensajeExito("✅ Venta " + (modo == "editar" ? "actualizada" : "registrada") + " correctamente con factura.");
                        Response.Redirect("~/GestionarVentas.aspx");
                    }
                    else
                    {
                        MostrarMensajeError("❌ Error al " + (modo == "editar" ? "actualizar" : "registrar") + " la venta.");
                    }
                }
                else
                {
                    MostrarMensajeError("❌ Error al registrar la factura.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al registrar venta con factura: {ex.Message}");
                MostrarMensajeError("❌ Error al registrar la venta: " + ex.Message);
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


    
// 🔹 MÉTODO MEJORADO PARA ELIMINAR COMPROBANTE ANTERIOR
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


        // 🔹 MÉTODO PARA INSERTAR FACTURA
        private int InsertarFactura(double totalVenta)
        {
            try
            {
                var factura = new FacturaService.factura();

                // 🔹 DATOS DE LA FACTURA
                factura.fecha = DateTime.Now;
                factura.total = totalVenta;
                factura.IGV = totalVenta * 0.18; // 18% del total
                factura.metodoDePago = ddlMetodoPago.SelectedValue;
                factura.correlativo = GenerarCorrelativoFactura();
                factura.RUC = txtRUC.Text;
                factura.razonSocial = txtRazonSocial.Text;

                // 🔹 LLAMAR AL SERVICIO WEB
                var client = new FacturaWSClient();
                int idComprobante = client.insertarFactura(factura);

                System.Diagnostics.Debug.WriteLine($"✅ Factura insertada - ID: {idComprobante}");
                return idComprobante;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al insertar factura: {ex.Message}");
                return 0;
            }
        }


        // 🔹 MÉTODO PARA GENERAR CORRELATIVO DE FACTURA
        private string GenerarCorrelativoFactura()
        {
            // Ejemplo: F001-0000001 (puedes implementar tu lógica de numeración)
            Random rnd = new Random();
            return $"F{rnd.Next(1000, 9999)}-{rnd.Next(1000000, 9999999)}";
        }

        // 🔹 MÉTODO PARA INSERTAR VENTA (igual que en Boleta)
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


        // 🔹 MÉTODO PARA LIMPIAR SESIONES (igual que en Boleta)
        private void LimpiarSesiones()
        {
            Session.Remove("VentaCompleta");
            Session.Remove("ClienteSeleccionado");
            Session.Remove("LineasVenta");
            Session.Remove("VentaTemporalRegistro");
            System.Diagnostics.Debug.WriteLine("🧹 Sesiones de venta limpiadas");
        }




        private decimal CalcularTotalConIGV(decimal igv)
        {
            decimal subtotal = 100; // ejemplo
            return subtotal + (subtotal * (igv / 100));
        }

        private void LimpiarCampos()
        {
            txtRUC.Text = string.Empty;
            txtRazonSocial.Text = string.Empty;
            ddlMetodoPago.SelectedIndex = 0;
            txtDireccion.Text = string.Empty;
            txtNombresApellidos.Text = string.Empty;
            txtIGV.Text = "18";
        }

        private void MostrarMensaje(string mensaje)
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", script, true);
        }
    }
}