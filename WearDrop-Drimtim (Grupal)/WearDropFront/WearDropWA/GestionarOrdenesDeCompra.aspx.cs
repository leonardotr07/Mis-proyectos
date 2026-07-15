using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.OrdenCompraWS;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class GestionarOrdenesDeCompra : System.Web.UI.Page
    {


        private OrdenCompraWSClient boOrdenCompra;
        private BindingList<ordenCompra> ordenesDeCompra;



        protected void Page_Load(object sender, EventArgs e)
        {
            boOrdenCompra = new OrdenCompraWSClient();

            // 🔹 VERIFICAR SI ES UN POSTBACK DE ELIMINACIÓN
            if (IsPostBack)
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                System.Diagnostics.Debug.WriteLine($"🔍 POSTBACK - Target: {eventTarget}, Argument: {eventArgument}");

                if (eventTarget == "DeleteOrder" || eventTarget == "EliminarOrden")
                {
                    int idOrden = 0;
                    if (!string.IsNullOrEmpty(eventArgument) && int.TryParse(eventArgument, out idOrden))
                    {
                        System.Diagnostics.Debug.WriteLine($"🎯 ELIMINACIÓN DETECTADA - ID: {idOrden}");
                        EliminarOrden(idOrden);
                    }
                    else
                    {
                        // Intentar obtener del hidden field
                        idOrden = Convert.ToInt32(hdnOrdenIdToDelete.Value);
                        if (idOrden > 0)
                        {
                            System.Diagnostics.Debug.WriteLine($"🎯 ELIMINACIÓN DESDE HIDDEN FIELD - ID: {idOrden}");
                            EliminarOrden(idOrden);
                        }
                    }
                }
            }

            CargarOrdenesCompra();
        }

        private void CargarOrdenesCompra()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🔄 Cargando órdenes de compra...");

                var ordenes = boOrdenCompra.listarTodasLasOrdenesDeCompra();

                if (ordenes != null)
                {
                    ordenesDeCompra = new BindingList<ordenCompra>(ordenes);
                    System.Diagnostics.Debug.WriteLine($"✅ Se cargaron {ordenes.Length} órdenes");
                }
                else
                {
                    ordenesDeCompra = new BindingList<ordenCompra>();
                    System.Diagnostics.Debug.WriteLine("ℹ️ No se encontraron órdenes");
                }

                dgvOrdenesCompra.DataSource = ordenesDeCompra;
                dgvOrdenesCompra.DataBind();

                if (ordenesDeCompra.Count == 0)
                {
                    dgvOrdenesCompra.EmptyDataText = "No se encontraron órdenes de compra";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error al cargar órdenes: {ex.Message}");
                MostrarMensaje($"Error al cargar las órdenes: {ex.Message}", "error");
                ordenesDeCompra = new BindingList<ordenCompra>();
                dgvOrdenesCompra.DataSource = ordenesDeCompra;
                dgvOrdenesCompra.DataBind();
                dgvOrdenesCompra.EmptyDataText = "Error al cargar los datos";
            }
        }

        protected void dgvOrdenesCompra_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvOrdenesCompra.PageIndex = e.NewPageIndex;
            CargarOrdenesCompra();
        }

        // 🔹 MÉTODO SIMPLIFICADO - SOLO GUARDAR EL ID
        protected void dgvOrdenesCompra_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
                int idOrden = Convert.ToInt32(e.CommandArgument);
                CargarOrdenParaModificar(idOrden, "modificar");
            }
            else if (e.CommandName == "Eliminar")
            {
                int idOrden = Convert.ToInt32(e.CommandArgument);
                // Solo guardar el ID en el hidden field
                hdnOrdenIdToDelete.Value = idOrden.ToString();
                System.Diagnostics.Debug.WriteLine($"🔄 ID Guardado para eliminar: {idOrden}");

                // El modal se abre desde JavaScript
            }
            else if (e.CommandName == "Ver")
            {
                int idOrden = Convert.ToInt32(e.CommandArgument);
                CargarOrdenParaModificar(idOrden, "ver");
            }
        }


        // 🔹 MÉTODO NUEVO: Cargar orden completa para modificar/ver
        private void CargarOrdenParaModificar(int idOrden, string modo)
        {
            try
            {
                // 🔹 OBTENER ORDEN COMPLETA DEL SERVICIO WEB
                var ordenCompleta = boOrdenCompra.obtenerOrdenDeCompraPorID(idOrden);

                if (ordenCompleta != null)
                {
                    // 🔹 GUARDAR EN SESIÓN PARA USAR EN LAS SIGUIENTES PÁGINAS
                    Session["OrdenPara" + modo] = ordenCompleta;
                    Session["ModoOrden"] = modo;
                    Session["IdOrden" + modo] = idOrden;

                    // 🔹 REDIRIGIR A REGISTRAR ORDEN COMPRA
                    Response.Redirect("~/RegistrarOrdenCompra.aspx");
                }
                else
                {
                    MostrarMensaje("No se pudo cargar la orden seleccionada.");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar orden: {ex.Message}");
            }
        }

        protected void dgvOrdenesCompra_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // 🔹 ID de la orden
                e.Row.Cells[0].Text = DataBinder.Eval(e.Row.DataItem, "idCompra").ToString();

                // 🔹 Fecha Emisión (formato dd/MM/yyyy)
                DateTime fechaEmision = (DateTime)DataBinder.Eval(e.Row.DataItem, "fechaEmision");
                e.Row.Cells[1].Text = fechaEmision.ToString("dd/MM/yyyy");

                // 🔹 Fecha Llegada (formato dd/MM/yyyy)
                DateTime fechaLlegada = (DateTime)DataBinder.Eval(e.Row.DataItem, "fechaLlegada");
                e.Row.Cells[2].Text = fechaLlegada.ToString("dd/MM/yyyy");

                // 🔹 Deuda Pendiente (formato moneda)
                double deudaPendiente = (double)DataBinder.Eval(e.Row.DataItem, "deudaPendiente");
                e.Row.Cells[3].Text = deudaPendiente.ToString("C");

                // 🔹 Empleado (nombre completo)
                var empleado = DataBinder.Eval(e.Row.DataItem, "empleado");
                if (empleado != null)
                {
                    string nombreEmpleado = DataBinder.Eval(empleado, "nombre")?.ToString() ?? "";
                    string primerApellido = DataBinder.Eval(empleado, "primerApellido")?.ToString() ?? "";
                    string segundoApellido = DataBinder.Eval(empleado, "segundoApellido")?.ToString() ?? "";
                    e.Row.Cells[4].Text = $"{nombreEmpleado} {primerApellido} {segundoApellido}".Trim();
                }

                // 🔹 Proveedor (nombre)
                var proveedor = DataBinder.Eval(e.Row.DataItem, "proveedor");
                if (proveedor != null)
                {
                    e.Row.Cells[5].Text = DataBinder.Eval(proveedor, "nombre")?.ToString() ?? "";
                }

                // 🔹 Monto Total (formato moneda)
                double montoTotal = (double)DataBinder.Eval(e.Row.DataItem, "montoTotal");
                e.Row.Cells[6].Text = montoTotal.ToString("C");
            }
        }

        protected void btnRegistrarOrden_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegistrarOrdenCompra.aspx");
        }


        // 🔹 MÉTODO MEJORADO DE ELIMINACIÓN
        private void EliminarOrden(int idOrden)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"🔄 INICIANDO ELIMINACIÓN - ID: {idOrden}");

                if (idOrden <= 0)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ID inválido: {idOrden}");
                    MostrarMensaje("Error: ID de orden inválido.", "error");
                    return;
                }

                // 🔹 EJECUTAR ELIMINACIÓN DIRECTAMENTE
                int resultado = boOrdenCompra.eliminarOrdenDeCompra(idOrden);

                if (resultado > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"✅ ELIMINACIÓN EXITOSA - ID: {idOrden}");

                    // Recargar datos
                    CargarOrdenesCompra();

                    MostrarMensaje($"✅ Orden #{idOrden} eliminada correctamente.", "exito");

                    // Limpiar hidden field
                    hdnOrdenIdToDelete.Value = "0";
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"❌ ELIMINACIÓN FALLIDA - Resultado: {resultado}");
                    MostrarMensaje("Error: No se pudo eliminar la orden. Puede tener datos relacionados.", "error");
                }
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                System.Diagnostics.Debug.WriteLine($"💥 FAULT EXCEPTION: {faultEx.Message}");
                MostrarMensaje($"Error del servicio: {faultEx.Message}", "error");
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                System.Diagnostics.Debug.WriteLine($"💥 COMMUNICATION EXCEPTION: {commEx.Message}");
                MostrarMensaje("Error de conexión con el servicio web.", "error");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR GENERAL: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"💥 StackTrace: {ex.StackTrace}");
                MostrarMensaje($"Error al eliminar: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO MEJORADO: Mostrar mensajes
        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $@"
                console.log('📢 Mensaje del servidor ({tipo}): {mensaje}');
                alert('{mensaje.Replace("'", "\\'")}');
                {(tipo == "exito" ? "setTimeout(function() { location.reload(); }, 1000);" : "")}
            ";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }


        // 🔹 MÉTODO DE PRUEBA TEMPORAL - ELIMINAR DESPUÉS
        private void ProbarServicioEliminar()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("🔍 Probando servicio de eliminación...");

                // Probar con un ID que exista
                var ordenes = boOrdenCompra.listarTodasLasOrdenesDeCompra();
                if (ordenes != null && ordenes.Length > 0)
                {
                    int primerId = ordenes[0].idCompra;
                    System.Diagnostics.Debug.WriteLine($"✅ Servicio conectado. Primera orden ID: {primerId}");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay órdenes para probar");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 Error probando servicio: {ex.Message}");
            }
        }


        // 🔹 AGREGAR ESTE MÉTODO PARA MANEJAR EL POSTBACK DIRECT0
        protected override void RaisePostBackEvent(IPostBackEventHandler source, string eventArgument)
        {
            if (eventArgument == "DeleteOrder" || eventArgument.StartsWith("DeleteOrder"))
            {
                // El ID viene en el ViewState o podemos usar una variable de sesión
                if (_ordenIdToDelete > 0)
                {
                    EliminarOrden(_ordenIdToDelete);
                }
            }
            else
            {
                base.RaisePostBackEvent(source, eventArgument);
            }
        }

        // 🔹 VARIABLE PARA GUARDAR EL ID TEMPORAL
        private int _ordenIdToDelete = 0;

        




    }
}