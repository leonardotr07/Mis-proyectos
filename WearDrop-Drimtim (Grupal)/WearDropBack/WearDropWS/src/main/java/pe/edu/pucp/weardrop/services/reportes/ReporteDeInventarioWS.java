/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;

import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;


import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "ReporteDeInventarioWS")
public class ReporteDeInventarioWS {
    
    private Connection con;
    public ReporteDeInventarioWS(){
        //Inicializamos el SO para un lenguaje español, Perú , zona horaria
        System.setProperty("user.language", "es");
        System.setProperty("user.country", "PE");
        System.setProperty("user.timezone", "GMT-5");
    }
    //Aqui recibe los parametros que se extraen del frontEnd
    @WebMethod(operationName = "generarReporteDeInventario")
    public byte[] generarReporteDeInventario(@WebParam(name = "fecha") Date fechaInicio) {
        byte[] reporte=null;
        try{
            con=DBManager.getInstance().getConnexion();
            //CAMBIAR ESTE LINK por el ARCHIVO JASPER
            JasperReport jr=(JasperReport)JRLoader.loadObject(getClass().getResourceAsStream("/pe/edu/pucp/weardrop/reports/.jasper"));
            
            //Parametros:
            HashMap parametrosEntrada=new HashMap();
            //1. Nombre del parametro, 2. valor del parametro
            
            //Imprimir el Reporte (SEGUNDO PARAMETRO = PARAMETROS, CONEXION A LA BASE DE DATOS O ARCHIVOS)
            JasperPrint jp = JasperFillManager.fillReport(jr, null, con);
            reporte=JasperExportManager.exportReportToPdf(jp);
        }catch(Exception ex){
            System.out.println("ERROR AL GENERAR REPORTE DE INVENTARIO: "+ex.getMessage());
        }
        return reporte;
    }
}
