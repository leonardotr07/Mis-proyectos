/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.personal;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.bo.CargoBOImpl;
import pe.edu.pucp.weardrop.personal.boi.CargoBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "CargoWS")
public class CargoWS {

    private final CargoBOI boCargo = new CargoBOImpl();
    
    // Listar todos los cargos
    @WebMethod(operationName = "listarCargos")
    public ArrayList<Cargo> listarCargos() {
        ArrayList<Cargo> listaCargos = null;
        try {
            listaCargos = boCargo.listarTodos();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return listaCargos;
    }
    
    // Insertar un nuevo cargo
    @WebMethod(operationName = "insertarCargo")
    public int insertarCargo(@WebParam(name = "cargo") Cargo cargo) {
        int resultado = 0;
        try {
            resultado = boCargo.insertar(cargo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Modificar un cargo existente
    @WebMethod(operationName = "modificarCargo")
    public int modificarCargo(@WebParam(name = "cargo") Cargo cargo) {
        int resultado = 0;
        try {
            resultado = boCargo.modificar(cargo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Eliminar un cargo por su ID
    @WebMethod(operationName = "eliminarCargo")
    public int eliminarCargo(@WebParam(name = "idCargo") int idCargo) {
        int resultado = 0;
        try {
            resultado = boCargo.eliminar(idCargo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Obtener un cargo por su ID
    @WebMethod(operationName = "obtenerCargoPorId")
    public Cargo obtenerCargoPorId(@WebParam(name = "idCargo") int idCargo) {
        Cargo cargo = null;
        try {
            cargo = boCargo.obtenerXId(idCargo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return cargo;
    }
}
