/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.services.devoluciones;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.devoluciones.Devolucion;
import pe.edu.pucp.weardrop.devoluciones.bo.DevolucionBOImpl;
import pe.edu.pucp.weardrop.devoluciones.boi.DevolucionBOI;


@WebService(serviceName = "DevolucionWS")
public class DevolucionWS {

    private final DevolucionBOI bo = new DevolucionBOImpl();

    @WebMethod(operationName = "insertarDevolucion")
    public int insertarDevolucion(@WebParam(name = "devolucion") Devolucion devolucion) {
        try { return bo.insertar(devolucion); }
        catch (Exception e) { System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarDevolucion")
    public int modificarDevolucion(@WebParam(name = "devolucion") Devolucion devolucion) {
        try { return bo.modificar(devolucion); }
        catch (Exception e) { System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarDevolucion")
    public int eliminarDevolucion(@WebParam(name = "idDevolucion") int idDevolucion) {
        try { return bo.eliminar(idDevolucion); }
        catch (Exception e) { System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerDevolucionPorId")
    public Devolucion obtenerDevolucionPorId(@WebParam(name = "idDevolucion") int idDevolucion) {
        try { return bo.obtenerXId(idDevolucion); }
        catch (Exception e) { System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarDevoluciones")
    public List<Devolucion> listarDevoluciones() {
        try { return bo.listarTodos(); }
        catch (Exception e) { System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "listarDevolucionesPorProveedor")
    public List<Devolucion> listarDevolucionesPorProveedor(
            @WebParam(name = "idProveedor") int idProveedor) {
        try { return bo.listarPorProveedor(idProveedor); }
        catch (Exception e) { System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

