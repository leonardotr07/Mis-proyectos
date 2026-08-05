/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.services.comprobantes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.Factura;
import pe.edu.pucp.weardrop.comprobantes.bo.FacturaBOImpl;
import pe.edu.pucp.weardrop.comprobantes.boi.FacturaBOI;

@WebService(serviceName = "FacturaWS")
public class FacturaWS {
    private final FacturaBOI boFactura = new FacturaBOImpl();
    
    @WebMethod(operationName = "listarTodasFacturas")
    public ArrayList<Factura> listarTodasFacturas() { 
        ArrayList<Factura> listaFacturas = null;
        try {
            listaFacturas = boFactura.listarTodos();
        } catch (Exception ex) {
            System.out.println("Error al listar Facturas: " + ex.getMessage());
        }
        return listaFacturas;
    }
    
    @WebMethod(operationName = "insertarFactura")
    public int insertarFactura(@WebParam(name = "datFactura") Factura datFactura) {
        // Para depurar
        System.out.println("=========================================");
        System.out.println("=== DATOS RECIBIDOS POR EL WEB SERVICE (BO) ===");
        try {
            // Imprimimos los datos que llegaron desde C#
            System.out.println("Fecha: " + datFactura.getFecha());
            System.out.println("Total: " + datFactura.getTotal());
            System.out.println("IGV: " + datFactura.getIGV());
            System.out.println("MetodoPago: " + datFactura.getMetodoDePago());
            System.out.println("Correlativo: " + datFactura.getCorrelativo());
            System.out.println("RUC: " + datFactura.getRUC());
            System.out.println("Razón Social: " + datFactura.getRazonSocial());
        } catch (Exception e) {
            System.out.println("¡ERROR! El objeto 'datFactura' llegó NULO o incompleto.");
            e.printStackTrace();
        }
        System.out.println("=========================================");
        

        int resultado = 0;
        try {
            // Aquí le pasamos el objeto (posiblemente vacío) a la capa de negocio
            resultado = boFactura.insertar(datFactura);
        } catch (Exception ex) {
            System.out.println("Error al insertar Factura: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarFactura")
    public int modificarFactura(@WebParam(name = "datFactura") Factura datFactura) { 
        int resultado = 0;
        try {
            resultado = boFactura.modificar(datFactura);
        } catch (Exception ex) {
            System.out.println("Error al modificar Factura: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarFactura")
    public int eliminarFactura(@WebParam(name = "idFactura") int idFactura) { 
        int resultado = 0;
        try {
            resultado = boFactura.eliminar(idFactura);
        } catch (Exception ex) {
            System.out.println("Error al eliminar Factura: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerFacturaPorId")
    public Factura obtenerFacturaPorId(@WebParam(name = "idFactura") int idFactura) { 
        Factura datFactura = null;
        try {
            datFactura = boFactura.obtenerXId(idFactura);
        } catch (Exception ex) {
            System.out.println("Error al obtener boleta: " + ex.getMessage());
        }
        return datFactura;
    }
}