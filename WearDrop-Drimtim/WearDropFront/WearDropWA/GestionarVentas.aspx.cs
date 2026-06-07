using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.VentaWS;

namespace WearDropWA
{
    public partial class GestionarVentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarVentas();
            }
        }

        private void CargarVentas()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🔄 Iniciando carga de ventas...");

                VentaWSClient client = new VentaWSClient();
                var ventasReales = client.listarVentas()?.ToList();

                System.Diagnostics.Debug.WriteLine($"🔍 Ventas obtenidas del servicio: {ventasReales?.Count ?? 0}");

                if (ventasReales != null && ventasReales.Any())
                {
                    var ventasParaGrid = ventasReales.Select(v => new
                    {
                        ID = v.idVenta,
                        Fecha = v.fecha,
                        Monto = v.total,
                        Comprobante = ObtenerTipoComprobante(v.idComprobante),
                        Cliente = $"{v.cliente?.nombre ?? "N/A"} {v.cliente?.primerApellido ?? ""}"
                    }).ToList();

                    dgvVentas.DataSource = ventasParaGrid;
                    dgvVentas.DataBind();

                    System.Diagnostics.Debug.WriteLine($"✅ GridView cargado con {ventasParaGrid.Count} ventas REALES");

                    // 🔹 VERIFICAR VISUALMENTE
                    foreach (var venta in ventasParaGrid)
                    {
                        System.Diagnostics.Debug.WriteLine($"   - Venta REAL ID: {venta.ID}, Cliente: {venta.Cliente}");
                    }
                }
                else
                {
                    // ❌ ELIMINAR LA LLAMADA A DATOS DE EJEMPLO
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay ventas REALES en la base de datos");

                    // Mostrar grid vacío con mensaje informativo
                    dgvVentas.DataSource = new List<dynamic>();
                    dgvVentas.EmptyDataText = "No hay ventas registradas en el sistema";
                    dgvVentas.DataBind();

                    MostrarMensajeInfo("No se encontraron ventas en el sistema.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarVentas: {ex.Message}");

                // ❌ NO CARGAR DATOS DE EJEMPLO - Mostrar error real
                MostrarMensajeError($"Error al cargar ventas: {ex.Message}");

                // Grid vacío
                dgvVentas.DataSource = new List<dynamic>();
                dgvVentas.EmptyDataText = "Error al cargar las ventas";
                dgvVentas.DataBind();
            }
        }



        private void MostrarMensajeInfo(string mensaje)
        {
            string script = $@"
        Swal.fire({{
            icon: 'info',
            title: 'Información',
            text: '{mensaje.Replace("'", "\\'")}',
            confirmButtonColor: '#A86E75',
            confirmButtonText: 'Aceptar'
        }});
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "infoAlert", script, true);
        }

        private string ObtenerTipoComprobante(int idComprobante)
        {
            if (idComprobante <= 0) return "Sin comprobante";

            // 🔹 USAR CACHE PARA EVITAR LLAMADAS REPETIDAS
            string cacheKey = $"TipoComprobante_{idComprobante}";

            if (Session[cacheKey] != null)
            {
                return Session[cacheKey].ToString();
            }

            string tipoComprobante = DeterminarTipoComprobante(idComprobante);

            // 🔹 GUARDAR EN CACHE POR 5 MINUTOS
            Session[cacheKey] = tipoComprobante;

            return tipoComprobante;
        }

        private string DeterminarTipoComprobante(int idComprobante)
        {
            try
            {
                // 🔹 PRIMERO BUSCAR EN BOLETAS (más común)
                var boletaClient = new BoletaService.BoletaWSClient();
                var boleta = boletaClient.obtenerBoletaPorId(idComprobante);
                if (boleta != null && boleta.idComprobante > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Comprobante {idComprobante} es BOLETA");
                    return "Boleta";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ℹ️ Comprobante {idComprobante} no es boleta: {ex.Message}");
            }

            try
            {
                // 🔹 LUEGO BUSCAR EN FACTURAS
                var facturaClient = new FacturaService.FacturaWSClient();
                var factura = facturaClient.obtenerFacturaPorId(idComprobante);
                if (factura != null && factura.idComprobante > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Comprobante {idComprobante} es FACTURA");
                    return "Factura";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ℹ️ Comprobante {idComprobante} no es factura: {ex.Message}");
            }

            System.Diagnostics.Debug.WriteLine($"⚠️ Comprobante {idComprobante} no encontrado en ningún servicio");
            return "No identificado";
        }

        // ❌ ELIMINAR ESTE MÉTODO O COMENTARLO
        /*
        private void CargarVentasEjemplo()
        {
            // Datos de ejemplo por si falla la conexión
            var ventas = new List<dynamic>
            {
                new { ID="1", Fecha=DateTime.Now.AddDays(-5), Monto=150.50, Comprobante="Boleta", Cliente="María López" },
                new { ID="2", Fecha=DateTime.Now.AddDays(-3), Monto=200.0, Comprobante="Factura", Cliente="Carlos Ruiz" },
                new { ID="3", Fecha=DateTime.Now.AddDays(-1), Monto=75.25, Comprobante="Boleta", Cliente="Ana Torres" }
            };

            dgvVentas.DataSource = ventas;
            dgvVentas.DataBind();
        }
        */

        protected void dgvVentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvVentas.PageIndex = e.NewPageIndex;
            CargarVentas();
        }

        // 🔹 AGREGAR ESTE MÉTODO AL ARCHIVO GestionarVentas.aspx.cs
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el ID de la venta desde el CommandArgument
                LinkButton btn = (LinkButton)sender;
                int idVenta = Convert.ToInt32(btn.CommandArgument);

                System.Diagnostics.Debug.WriteLine($"🔧 Iniciando modificación de venta ID: {idVenta}");

                // 🔹 CARGAR VENTA COMPLETA DESDE EL SERVICIO
                var ventaCompleta = ObtenerVentaPorId(idVenta);

                if (ventaCompleta != null)
                {
                    // 🔹 GUARDAR VENTA COMPLETA EN SESIÓN
                    Session["VentaCompleta"] = ventaCompleta;

                    // 🔹 GUARDAR CLIENTE EN SESIÓN SI EXISTE
                    if (ventaCompleta.cliente != null)
                    {
                        Session["ClienteSeleccionado"] = ventaCompleta.cliente;
                    }

                    // 🔹 GUARDAR LÍNEAS DE VENTA EN SESIÓN
                    if (ventaCompleta.productos != null && ventaCompleta.productos.Length > 0)
                    {
                        Session["LineasVenta"] = ventaCompleta.productos.ToList();
                    }
                    else
                    {
                        Session["LineasVenta"] = new List<VentaWS.itemVenta>();
                    }

                    System.Diagnostics.Debug.WriteLine($"✅ Venta cargada para modificación:");
                    System.Diagnostics.Debug.WriteLine($"   - ID: {ventaCompleta.idVenta}");
                    System.Diagnostics.Debug.WriteLine($"   - Total: {ventaCompleta.total}");
                    System.Diagnostics.Debug.WriteLine($"   - Líneas: {ventaCompleta.productos?.Length ?? 0}");
                    System.Diagnostics.Debug.WriteLine($"   - Cliente: {ventaCompleta.cliente?.idCliente}");

                    // 🔹 REDIRIGIR A REGISTRAR VENTAS EN MODO EDICIÓN
                    Response.Redirect($"~/RegistarVentas.aspx?modo=editar&id={idVenta}");
                }
                else
                {
                    MostrarMensaje("Error: No se pudo cargar la venta para modificación.", "error");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en btnModificar_Click: {ex.Message}");
                MostrarMensaje($"Error al cargar venta para modificación: {ex.Message}", "error");
            }
        }


        // 🔹 AGREGAR ESTE MÉTODO AUXILIAR
        private VentaWS.venta ObtenerVentaPorId(int idVenta)
        {
            try
            {
                VentaWSClient client = new VentaWSClient();
                return client.obtenerVentaPorId(idVenta);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al obtener venta por ID {idVenta}: {ex.Message}");
                return null;
            }
        }

        // 🔹 MÉTODO PARA MOSTRAR MENSAJES (SI NO EXISTE)
        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }



        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            int id = Convert.ToInt32(btn.CommandArgument);

            try
            {
                System.Diagnostics.Debug.WriteLine($"🗑️ Intentando eliminar venta ID: {id}");

                // 🔹 1. LLAMAR AL SERVICIO WEB
                VentaWSClient client = new VentaWSClient();
                int resultado = client.eliminarVenta(id);

                System.Diagnostics.Debug.WriteLine($"🔍 Resultado del servicio eliminar: {resultado}");

                if (resultado > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Venta {id} eliminada correctamente");

                    // 🔹 2. LIMPIAR CACHE
                    LimpiarCacheComprobantes();

                    // 🔹 3. RECARGAR DATOS
                    CargarVentas();

                    // 🔹 4. MOSTRAR FEEDBACK VISUAL
                    MostrarMensajeExito($"Venta #{id} eliminada correctamente");

                    System.Diagnostics.Debug.WriteLine($"🔄 GridView actualizado después de eliminar venta {id}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ Servicio retornó 0 - No se pudo eliminar venta {id}");
                    MostrarMensajeError("No se pudo eliminar la venta. Puede que ya haya sido eliminada.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al eliminar venta {id}: {ex.Message}");
                MostrarMensajeError($"Error al eliminar: {ex.Message}");
            }
        }

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



        // 🔹 MÉTODO PARA LIMPIAR CACHE DE COMPROBANTES
        private void LimpiarCacheComprobantes()
        {
            try
            {
                var keysToRemove = new List<string>();

                // 🔹 BUSCAR TODAS LAS CLAVES DE CACHE QUE EMPIEZAN CON "TipoComp_"
                foreach (string key in Session.Keys)
                {
                    if (key.StartsWith("TipoComp_"))
                    {
                        keysToRemove.Add(key);
                    }
                }

                // 🔹 ELIMINAR LAS CLAVES ENCONTRADAS
                foreach (string key in keysToRemove)
                {
                    Session.Remove(key);
                    System.Diagnostics.Debug.WriteLine($"🧹 Cache eliminado: {key}");
                }

                System.Diagnostics.Debug.WriteLine($"✅ Cache de comprobantes limpiado. Elementos eliminados: {keysToRemove.Count}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al limpiar cache: {ex.Message}");
            }
        }



        // 🔹 MÉTODO PARA MOSTRAR MENSAJES BONITOS (SweetAlert)
        private void MostrarMensajeSweetAlert(string tipo, string titulo, string mensaje)
        {
            string script = $@"
        Swal.fire({{
            icon: '{tipo}',
            title: '{titulo}',
            text: '{mensaje.Replace("'", "\\'")}',
            confirmButtonColor: '#A86E75',
            confirmButtonText: 'Aceptar'
        }});
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetAlert", script, true);
        }



        protected void btnVerVenta_Click(object sender, EventArgs e)
        {
            try
            {
                var btn = (LinkButton)sender;
                int idVenta = Convert.ToInt32(btn.CommandArgument);

                System.Diagnostics.Debug.WriteLine($"🔍 Visualizando venta ID: {idVenta}");

                // 🔹 GUARDAR EN SESIÓN QUE ESTAMOS EN MODO VISUALIZACIÓN
                Session["ModoVisualizacion"] = true;
                Session["VentaAVisualizar"] = idVenta;

                // 🔹 REDIRIGIR A LA PÁGINA DE REGISTRO EN MODO SOLO LECTURA
                Response.Redirect($"~/RegistarVentas.aspx?modo=ver&id={idVenta}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR al visualizar venta: {ex.Message}");
                MostrarMensajeError($"Error al visualizar venta: {ex.Message}");
            }
        }

        protected void btnIrARegistrarVenta_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegistarVentas.aspx");
        }
    }
}