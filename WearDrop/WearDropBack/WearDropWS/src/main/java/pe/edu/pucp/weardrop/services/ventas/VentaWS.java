/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.ventas;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.ventas.Venta;
import pe.edu.pucp.weardrop.ventas.bo.VentaBOImpl;
import pe.edu.pucp.weardrop.ventas.boi.VentaBOI;

/**
 * Servicio Web para gestión de Ventas
 * Sigue el patrón de los servicios previos y retorna ArrayList en listados.
 * El método obtenerVentaPorId() devuelve la venta con items ACTIVOS (según tu BO).
 */
@WebService(serviceName = "VentaWS")
public class VentaWS {

    private final VentaBOI boVenta = new VentaBOImpl();

    // Listar todas las ventas (cada venta con sus items - según tu BO)
    @WebMethod(operationName = "listarVentas")
    public ArrayList<Venta> listarVentas() {
        ArrayList<Venta> lista = null;
        try {
            lista = boVenta.listarTodos_Activo_conItemActivo();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return lista;
    }

    // Insertar una nueva venta (el BO marca activo la venta y los items, y valida)
    @WebMethod(operationName = "insertarVenta")
    public int insertarVenta(@WebParam(name = "venta") Venta venta) {
        int resultado = 0;
        try {
            resultado = boVenta.insertar(venta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Modificar una venta existente (el BO valida y recalca activos)
    @WebMethod(operationName = "modificarVenta")
    public int modificarVenta(@WebParam(name = "venta") Venta venta) {
        int resultado = 0;
        try {
            resultado = boVenta.modificar(venta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Eliminar una venta por su ID
    @WebMethod(operationName = "eliminarVenta")
    public int eliminarVenta(@WebParam(name = "idVenta") int idVenta) {
        int resultado = 0;
        try {
            resultado = boVenta.eliminar(idVenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Obtener una venta por su ID (incluye items ACTIVOS, según implementación del BO)
    @WebMethod(operationName = "obtenerVentaPorId")
    public Venta obtenerVentaPorId(@WebParam(name = "idVenta") int idVenta) {
        Venta venta = null;
        try {
            venta = boVenta.obtenerXId(idVenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return venta;
    }
}
