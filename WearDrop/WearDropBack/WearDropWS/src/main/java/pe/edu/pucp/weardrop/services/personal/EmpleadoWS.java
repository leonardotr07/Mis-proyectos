/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.personal;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.personal.bo.EmpleadoBOImpl;
import pe.edu.pucp.weardrop.personal.boi.EmpleadoBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "EmpleadoWS")
public class EmpleadoWS {
    
    private final EmpleadoBOI boEmpleado = new EmpleadoBOImpl();
    
    // Listar todos los empleados
    @WebMethod(operationName = "listarEmpleados")
    public ArrayList<Empleado> listarEmpleados() {
        ArrayList<Empleado> listaEmpleados = null;
        try {
            listaEmpleados = boEmpleado.listarTodos();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return listaEmpleados;
    }
    
    // Insertar un nuevo empleado
    @WebMethod(operationName = "insertarEmpleado")
    public int insertarEmpleado(@WebParam(name = "empleado") Empleado empleado) {
        int resultado = 0;
        try {
            resultado = boEmpleado.insertar(empleado);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Modificar un empleado existente
    @WebMethod(operationName = "modificarEmpleado")
    public int modificarEmpleado(@WebParam(name = "empleado") Empleado empleado) {
        int resultado = 0;
        try {
            resultado = boEmpleado.modificar(empleado);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Eliminar un empleado por su ID
    @WebMethod(operationName = "eliminarEmpleado")
    public int eliminarEmpleado(@WebParam(name = "idEmpleado") int idEmpleado) {
        int resultado = 0;
        try {
            resultado = boEmpleado.eliminar(idEmpleado);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Obtener un empleado por su ID
    @WebMethod(operationName = "obtenerEmpleadoPorId")
    public Empleado obtenerEmpleadoPorId(@WebParam(name = "idEmpleado") int idEmpleado) {
        Empleado empleado = null;
        try {
            empleado = boEmpleado.obtenerXId(idEmpleado);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return empleado;
    }
}
