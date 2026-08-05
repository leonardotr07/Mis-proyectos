/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.ventas;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.ventas.Cliente;
import pe.edu.pucp.weardrop.ventas.bo.ClienteBOImpl;
import pe.edu.pucp.weardrop.ventas.boi.ClienteBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "ClienteWS")
public class ClienteWS {

    private final ClienteBOI boCliente = new ClienteBOImpl();

    // Listar todos los clientes
    @WebMethod(operationName = "listarClientes")
    public ArrayList<Cliente> listarClientes() {
        ArrayList<Cliente> lista = null;
        try {
            lista = boCliente.listarTodos();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return lista;
    }

    // Insertar un nuevo cliente
    @WebMethod(operationName = "insertarCliente")
    public int insertarCliente(@WebParam(name = "cliente") Cliente cliente) {
        int resultado = 0;
        try {
            resultado = boCliente.insertar(cliente);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Modificar un cliente existente
    @WebMethod(operationName = "modificarCliente")
    public int modificarCliente(@WebParam(name = "cliente") Cliente cliente) {
        int resultado = 0;
        try {
            resultado = boCliente.modificar(cliente);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Eliminar un cliente por su ID
    @WebMethod(operationName = "eliminarCliente")
    public int eliminarCliente(@WebParam(name = "idCliente") int idCliente) {
        int resultado = 0;
        try {
            resultado = boCliente.eliminar(idCliente);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    // Obtener un cliente por su ID
    @WebMethod(operationName = "obtenerClientePorId")
    public Cliente obtenerClientePorId(@WebParam(name = "idCliente") int idCliente) {
        Cliente cliente = null;
        try {
            cliente = boCliente.obtenerXId(idCliente);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return cliente;
    }
}
