/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.personal;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.TipoCuenta;
import pe.edu.pucp.weardrop.personal.bo.TipoCuentaBOImpl;
import pe.edu.pucp.weardrop.personal.boi.TipoCuentaBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "TipoCuentaWS")
public class TipoCuentaWS {
    
    private final TipoCuentaBOI boTipoCuenta = new TipoCuentaBOImpl();
    
    // Listar todos los tipos de cuenta
    @WebMethod(operationName = "listarTiposCuenta")
    public ArrayList<TipoCuenta> listarTiposCuenta() {
        ArrayList<TipoCuenta> listaTipos = null;
        try {
            listaTipos = boTipoCuenta.listarTodos();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return listaTipos;
    }
    
    // Insertar un nuevo tipo de cuenta
    @WebMethod(operationName = "insertarTipoCuenta")
    public int insertarTipoCuenta(@WebParam(name = "tipoCuenta") TipoCuenta tipoCuenta) {
        int resultado = 0;
        try {
            resultado = boTipoCuenta.insertar(tipoCuenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Modificar un tipo de cuenta existente
    @WebMethod(operationName = "modificarTipoCuenta")
    public int modificarTipoCuenta(@WebParam(name = "tipoCuenta") TipoCuenta tipoCuenta) {
        int resultado = 0;
        try {
            resultado = boTipoCuenta.modificar(tipoCuenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Eliminar un tipo de cuenta por su ID
    @WebMethod(operationName = "eliminarTipoCuenta")
    public int eliminarTipoCuenta(@WebParam(name = "idTipoCuenta") int idTipoCuenta) {
        int resultado = 0;
        try {
            resultado = boTipoCuenta.eliminar(idTipoCuenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Obtener un tipo de cuenta por su ID
    @WebMethod(operationName = "obtenerTipoCuentaPorId")
    public TipoCuenta obtenerTipoCuentaPorId(@WebParam(name = "idTipoCuenta") int idTipoCuenta) {
        TipoCuenta tipoCuenta = null;
        try {
            tipoCuenta = boTipoCuenta.obtenerXId(idTipoCuenta);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return tipoCuenta;
    }
}
