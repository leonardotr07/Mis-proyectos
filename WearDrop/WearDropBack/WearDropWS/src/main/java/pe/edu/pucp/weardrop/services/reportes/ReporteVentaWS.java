package pe.edu.pucp.weardrop.services.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;

import java.awt.Image;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import javax.swing.ImageIcon;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

import pe.edu.pucp.weardrop.config.DBManager;

@WebService(serviceName = "ReporteVentaWS",
        targetNamespace = "pe.edu.pucp.weardrop.services")
public class ReporteVentaWS {

    public ReporteVentaWS() {
        System.setProperty("user.language", "es");
        System.setProperty("user.country", "PE");
        System.setProperty("user.timezone", "GMT-5");
    }

    @WebMethod(operationName = "generarReporteVentasPorPrenda")
    public byte[] generarReporteVentasPorPrenda(
            @WebParam(name = "pFechaDesde") String fechaDesdeStr,
            @WebParam(name = "pFechaHasta") String fechaHastaStr,
            @WebParam(name = "tipoPeriodo") String tipoPeriodo,
            @WebParam(name = "Empleado") String empleado) {

        byte[] reporte = null;
        Connection con = null;

        try {
            // Reporte principal (.jasper compilado desde JasperSoft)
            JasperReport jr = (JasperReport) JRLoader.loadObject(
                    getClass().getResourceAsStream(
                            "/pe/edu/pucp/weardrop/reports/ReportedeVentas.jasper"));

            // Logo de WearDrop
            URL rutaURLImagen = getClass().getResource(
                    "/pe/edu/pucp/weardrop/images/logo.png");
            String rutaImagen = URLDecoder.decode(rutaURLImagen.getPath(), "UTF-8");
            Image imagen = (new ImageIcon(rutaImagen)).getImage();

            
            java.util.Date fechaDesde = null;
            java.util.Date fechaHasta = null;

            if (fechaDesdeStr != null && !fechaDesdeStr.isEmpty()) {
                // espera formato yyyy-MM-dd
                fechaDesde = java.sql.Date.valueOf(fechaDesdeStr);
            }

            if (fechaHastaStr != null && !fechaHastaStr.isEmpty()) {
                // espera formato yyyy-MM-dd
                fechaHasta = java.sql.Date.valueOf(fechaHastaStr);
            }

            // Parámetros para el reporte (deben coincidir con los nombres del .jrxml)
            HashMap<String, Object> hm = new HashMap<>();
            hm.put("pFechaDesde", fechaDesde);
            hm.put("pFechaHasta", fechaHasta);
            hm.put("tipoPeriodo", tipoPeriodo != null ? tipoPeriodo : "");
            hm.put("Empleado", empleado != null ? empleado : "");
            hm.put("logo", imagen);

            // Conexión a la BD
            con = DBManager.getInstance().getConnexion();

            // Llenar el reporte
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);

            // Convertir el reporte a PDF en un arreglo de bytes
            reporte = JasperExportManager.exportReportToPdf(jp);

        } catch (UnsupportedEncodingException | JRException ex) {
            System.out.println("ERROR AL GENERAR EL REPORTE: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return reporte;
    }
}


