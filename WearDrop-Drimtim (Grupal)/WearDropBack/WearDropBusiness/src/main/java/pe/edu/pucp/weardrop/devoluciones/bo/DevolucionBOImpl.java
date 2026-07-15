/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones.bo;


import java.util.ArrayList;
import pe.edu.pucp.weardrop.devoluciones.Devolucion;
import pe.edu.pucp.weardrop.devoluciones.boi.DevolucionBOI;
import pe.edu.pucp.weardrop.devoluciones.dao.DevolucionDAO;
import pe.edu.pucp.weardrop.devoluciones.mysql.DevolucionImpl;

public class DevolucionBOImpl implements DevolucionBOI {

    private final DevolucionDAO daoDev;

    public DevolucionBOImpl() {
        daoDev = new DevolucionImpl();
    }

    @Override
    public int insertar(Devolucion objeto) throws Exception {
        objeto.setActivo(true);
        validar(objeto);
        return daoDev.insertar(objeto);
    }

    @Override
    public int modificar(Devolucion objeto) throws Exception {
        if (objeto.getId() <= 0) {
            throw new Exception("El idDevolucion debe ser mayor que 0 para modificar.");
        }
        objeto.setActivo(true);
        validar(objeto);
        return daoDev.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoDev.eliminar(idObjeto);
    }

    @Override
    public Devolucion obtenerXId(int idObjeto) throws Exception {
        return daoDev.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Devolucion> listarTodos() throws Exception {
        return daoDev.listarTodos(); 
    }

    @Override
    public ArrayList<Devolucion> listarPorProveedor(int idProveedor) throws Exception {
        if (idProveedor <= 0) {
            throw new Exception("El idProveedor debe ser mayor que 0.");
        }
        return daoDev.listarPorIdProveedor(idProveedor); // también solo activos
    }

    @Override
    public void validar(Devolucion objeto) throws Exception {
        if (objeto.getDescripcion() == null || objeto.getDescripcion().trim().isEmpty()) {
            throw new Exception("La descripción no puede ser nula ni vacía.");
        }
        if (objeto.getDescripcion().trim().length() > 200) {
            throw new RuntimeException("La descripción excede los 200 caracteres.");
        }
        if (objeto.getIdEmpleado() <= 0) {
            throw new Exception("El idEmpleado debe ser mayor que 0.");
        }
        if (objeto.getIdProveedor() <= 0) {
            throw new Exception("El idProveedor debe ser mayor que 0.");
        }
        if (objeto.getIdPrenda() <= 0) {
            throw new Exception("El idPrenda debe ser mayor que 0.");
        }
        if (objeto.getCantidad() <= 0) {
            throw new Exception("La cantidad debe ser mayor que 0.");
        }
        if (objeto.getMonto() < 0) {
            throw new Exception("El monto no puede ser negativo.");
        }
        if (objeto.getTalla() == null) {
            throw new Exception("La talla no puede ser nula.");
        }
    }
}

