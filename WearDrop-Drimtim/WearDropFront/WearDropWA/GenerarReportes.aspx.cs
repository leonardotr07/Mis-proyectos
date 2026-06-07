using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ReporteDeInventarioWS;
using WearDropWA.ReporteVentaWS;
using WearDropWA.VentaWS;
using WearDropWA.ReporteMarWS;

namespace WearDropWA
{
    public partial class GenerarReportes : System.Web.UI.Page
    {
        private ReporteDeInventarioWSClient boReporte;
        private ReporteVentaWSClient boReporteVenta;

        protected void Page_Load(object sender, EventArgs e)
        {
            boReporte = new ReporteDeInventarioWSClient();
            boReporteVenta = new ReporteVentaWSClient();

            if (!IsPostBack)
            {
                var empObj = Session["empleadoLog"];
                if (empObj != null)
                    lblEmpleadoVP.Text = ((dynamic)empObj).nombre + " " + ((dynamic)empObj).primerApellido;
                else
                    lblEmpleadoVP.Text = "Empleado no identificado";

                txtAnioVP.Text = DateTime.Now.Year.ToString();
                
                
            }
        }

        protected void btnGenerarMargenPDF_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Preparar fechas (tu lógica de validación)
                string fechaIniEnvio = "";
                if (DateTime.TryParse(txtFechaInicio.Text, out DateTime dtIni))
                    fechaIniEnvio = dtIni.ToString("yyyy-MM-dd");

                string fechaFinEnvio = "";
                if (DateTime.TryParse(txtFechaFin.Text, out DateTime dtFin))
                    fechaFinEnvio = dtFin.ToString("yyyy-MM-dd");

                string producto = txtFiltroProducto.Text.Trim();
                string linea = txtFiltroLinea.Text.Trim();

                // ---------------------------------------------------------
                // 2. CORRECCIÓN DEL ERROR SOAP (Usar BasicHttpBinding)
                // ---------------------------------------------------------

                // A) Definimos el Binding como BasicHttpBinding (SOAP 1.1)
                var binding = new System.ServiceModel.BasicHttpBinding();

                // Aumentamos el tamaño máximo del mensaje por si el PDF es grande
                binding.MaxReceivedMessageSize = 20 * 1024 * 1024; // 20 MB

                // B) Definimos la dirección exacta (URL) del servicio
                // Asegúrate de que esta URL sea idéntica a la que sale en tu log de GlassFish
                var endpoint = new System.ServiceModel.EndpointAddress("http://localhost:8080/WearDropWS/ReporteMarWS");

                // C) Instanciamos el cliente pasando el binding y el endpoint
                ReporteMarWSClient clienteMargen = new ReporteMarWSClient(binding, endpoint);

                // ---------------------------------------------------------

                // 3. Llamar al servicio
                byte[] reporteBytes = clienteMargen.generarReporteMargenGanancia(
                    producto,
                    fechaIniEnvio,
                    fechaFinEnvio,
                    linea
                );

                // 4. Mostrar PDF
                if (reporteBytes != null && reporteBytes.Length > 0)
                {
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "inline;filename=ReporteMargen.pdf");
                    Response.BinaryWrite(reporteBytes);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    MostrarAlerta("El reporte no arrojó datos.");
                }
            }
            catch (Exception ex)
            {
                if (!(ex is System.Threading.ThreadAbortException))
                {
                    // Muestra el error técnico si vuelve a fallar
                    MostrarAlerta("Error: " + ex.Message);
                    System.Diagnostics.Debug.WriteLine(ex.ToString());
                }
            }
        }

        // 2) VENTAS POR PRENDA
        protected void btnGenerarVentasPrendaPDF_Click(object sender, EventArgs e)
        {
            try
            {
                string tipoPeriodo = ddlTipoPeriodoVP.SelectedValue;
                string empleadoNombre = lblEmpleadoVP.Text.Trim();

                if (string.IsNullOrEmpty(tipoPeriodo))
                {
                    MostrarAlerta("Debe seleccionar un tipo de período.");
                    return;
                }

                DateTime fechaDesde;
                DateTime fechaHasta;

                if (tipoPeriodo == "MENSUAL")
                {
                    if (string.IsNullOrWhiteSpace(txtAnioVP.Text))
                    {
                        MostrarAlerta("Debe ingresar el año para el período mensual.");
                        return;
                    }

                    int mes;
                    int anio;
                    if (!int.TryParse(ddlMesVP.SelectedValue, out mes) ||
                        !int.TryParse(txtAnioVP.Text.Trim(), out anio))
                    {
                        MostrarAlerta("Mes o año inválidos para el período mensual.");
                        return;
                    }

                    fechaDesde = new DateTime(anio, mes, 1);
                    fechaHasta = fechaDesde.AddMonths(1).AddDays(-1);
                }
                else if (tipoPeriodo == "DIARIO")
                {
                    if (string.IsNullOrWhiteSpace(txtFechaDiaVP.Text))
                    {
                        MostrarAlerta("Debe seleccionar una fecha para el período diario.");
                        return;
                    }

                    DateTime fechaDia = DateTime.Parse(txtFechaDiaVP.Text, CultureInfo.InvariantCulture);
                    fechaDesde = fechaDia;
                    fechaHasta = fechaDia;
                }
                else if (tipoPeriodo == "SEMANAL")
                {
                    if (string.IsNullOrWhiteSpace(txtFechaDiaVP.Text))
                    {
                        MostrarAlerta("Debe seleccionar una fecha base para el período semanal.");
                        return;
                    }

                    DateTime fechaBase = DateTime.Parse(txtFechaDiaVP.Text, CultureInfo.InvariantCulture);

                    fechaDesde = fechaBase;
                    while (fechaDesde.DayOfWeek != DayOfWeek.Monday)
                        fechaDesde = fechaDesde.AddDays(-1);

                    fechaHasta = fechaDesde.AddDays(6);
                }
                else
                {
                    MostrarAlerta("Tipo de período no válido.");
                    return;
                }

                string pFechaDesde = fechaDesde.ToString("yyyy-MM-dd");
                string pFechaHasta = fechaHasta.ToString("yyyy-MM-dd");

                byte[] reporte = boReporteVenta.generarReporteVentasPorPrenda(
                    pFechaDesde,
                    pFechaHasta,
                    tipoPeriodo,
                    empleadoNombre
                );

                if (reporte == null || reporte.Length == 0)
                {
                    MostrarAlerta("No se encontraron ventas en el período seleccionado.");
                    return;
                }

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "inline;filename=ReporteVentasPorPrenda.pdf");
                Response.BinaryWrite(reporte);
                Response.End(); // corta el request, que es lo esperado para una sola descarga [web:16]
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error generando reporte de ventas por prenda: " + ex.Message);
                MostrarAlerta("Ocurrió un error al generar el reporte. Intente nuevamente.");
            }
        }

        // 3) INVENTARIO EN RANGO (usando ambas fechas)
        //protected void btnGenerarReporteInventarioPDF_Click(object sender, EventArgs e)
        //{
        //    if (!Page.IsValid)
        //        return;

        //    try
        //    {
                
                

               

        //        if (fechaFin > DateTime.Now)
        //        {
        //            MostrarAlerta("La fecha de fin no puede ser futura.");
        //            return;
        //        }

        //        if (fechaInicio > fechaFin)
        //        {
        //            MostrarAlerta("La fecha de inicio no puede ser mayor que la fecha de fin.");
        //            return;
        //        }

        //        // Ajusta la firma del servicio Java si necesita ambos parámetros
        //        byte[] reporte = boReporte.generarReporteDeInventario(fechaInicio);

        //        if (reporte == null || reporte.Length == 0)
        //        {
        //            MostrarAlerta("No se encontraron datos de inventario en el rango seleccionado.");
        //            return;
        //        }

        //        Response.Clear();
        //        Response.ContentType = "application/pdf";
        //        Response.AddHeader("Content-Disposition", "inline; filename=ReporteInventarioWearDrop.pdf");
        //        Response.BinaryWrite(reporte);
        //        Response.End();
        //    }
        //    catch (Exception ex)
        //    {
        //        MostrarAlerta("Error al generar reporte: " + ex.Message);
        //    }
        //}

        private void MostrarAlerta(string mensaje)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "alertReportes",
                $"alert('{mensaje.Replace("'", "\\'")}');",
                true
            );
        }
    }

}