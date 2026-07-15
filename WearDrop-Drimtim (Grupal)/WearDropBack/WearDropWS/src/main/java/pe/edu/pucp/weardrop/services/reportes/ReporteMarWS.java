/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.services.reportes;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.awt.Image;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author USUARIO
 */

@WebService(serviceName = "ReporteMarWS")
public class ReporteMarWS {

    public ReporteMarWS() {
        // Configuración regional para asegurar formato correcto de fechas y monedas
        System.setProperty("user.language", "es");
        System.setProperty("user.country", "PE");
        System.setProperty("user.timezone", "GMT-5");
    }

    @WebMethod(operationName = "generarReporteMargenGanancia")
    public byte[] generarReporteMargenGanancia(
            @WebParam(name = "filtroProducto") String filtroProducto,
            @WebParam(name = "fechaDesde") String fechaDesdeStr,
            @WebParam(name = "fechaHasta") String fechaHastaStr,
            @WebParam(name = "filtroLinea") String filtroLinea) {

        byte[] reporte = null;
        Connection con = null;

        try {
            // 1. Cargar el reporte compilado (.jasper)
            // Asegúrate de compilar tu .jrxml a .jasper y ponerlo en esta ruta
            JasperReport jr = (JasperReport) JRLoader.loadObject(
                    getClass().getResourceAsStream(
                            "/pe/edu/pucp/weardrop/reports/ReporteMar.jasper"));

            // 2. Cargar el Logo (opcional, pero buena práctica si tu reporte lo usa o quieres pasarlo)
            // Nota: En tu JRXML no vi un parámetro $P{logo}, pero lo dejo por si decides agregarlo.
            URL rutaURLImagen = getClass().getResource(
                    "/pe/edu/pucp/weardrop/images/logo.png");
            Image imagen = null;
            if (rutaURLImagen != null) {
                String rutaImagen = URLDecoder.decode(rutaURLImagen.getPath(), "UTF-8");
                imagen = (new ImageIcon(rutaImagen)).getImage();
            }

            // 3. Procesar Fechas (De String a java.sql.Date)
            java.sql.Date fechaDesde = null;
            java.sql.Date fechaHasta = null;

            if (fechaDesdeStr != null && !fechaDesdeStr.isEmpty()) {
                try {
                    fechaDesde = java.sql.Date.valueOf(fechaDesdeStr); // Formato esperado: yyyy-MM-dd
                } catch (IllegalArgumentException e) {
                    System.err.println("Error al parsear fechaDesde: " + e.getMessage());
                }
            }

            if (fechaHastaStr != null && !fechaHastaStr.isEmpty()) {
                try {
                    fechaHasta = java.sql.Date.valueOf(fechaHastaStr); // Formato esperado: yyyy-MM-dd
                } catch (IllegalArgumentException e) {
                    System.err.println("Error al parsear fechaHasta: " + e.getMessage());
                }
            }

            // 4. Mapear Parámetros (Claves deben ser IDÉNTICAS al JRXML)
            HashMap<String, Object> hm = new HashMap<>();

            // Parámetros definidos en tu XML:
            hm.put("filtroProducto", filtroProducto != null ? filtroProducto : "");
            hm.put("fechaDesde", fechaDesde);
            hm.put("fechaHasta", fechaHasta);
            hm.put("filtroLinea", filtroLinea != null ? filtroLinea : "");

            // Estos parámetros existen en tu XML pero son calculados/outputs.
            // Generalmente no es necesario pasarlos desde Java si solo sirven para mostrar
            // totales calculados en el reporte, pero los inicializamos vacíos por seguridad.
            hm.put("totalIngresos", "");
            hm.put("totalCostos", "");
            hm.put("totalGanancias", "");
            hm.put("margenGeneral", "");

            // 5. Conexión a Base de Datos
            con = DBManager.getInstance().getConnexion();

            // 6. Llenado del Reporte
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);

            // 7. Exportación a PDF (bytes)
            reporte = JasperExportManager.exportReportToPdf(jp);

        } catch (UnsupportedEncodingException | JRException ex) {
            System.err.println("ERROR AL GENERAR EL REPORTE MARGEN: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            // 8. Cerrar conexión
            DBManager.getInstance().cerrarConexion();
        }

        return reporte;
    }
}
