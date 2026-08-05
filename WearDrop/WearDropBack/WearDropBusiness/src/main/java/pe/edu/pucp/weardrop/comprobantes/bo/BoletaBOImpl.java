/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes.bo;


import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.Boleta;
import pe.edu.pucp.weardrop.comprobantes.boi.BoletaBOI;
import pe.edu.pucp.weardrop.comprobantes.dao.BoletaDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.BoletaImpl;

/**
 * Implementación de la capa de negocio para Boleta
 */
public class BoletaBOImpl implements BoletaBOI {
    
    private final BoletaDAO daoBoleta;

    public BoletaBOImpl() {
        daoBoleta = new BoletaImpl();
    }

    @Override
    public int insertar(Boleta datBoleta) throws Exception {
        validar(datBoleta);
        return daoBoleta.insertar(datBoleta);
    }

    @Override
    public int modificar(Boleta datBoleta) throws Exception {
        validar(datBoleta);
        return daoBoleta.modificar(datBoleta);
    }

    @Override
    public int eliminar(int idBoleta) throws Exception {
        return daoBoleta.eliminar(idBoleta);
    }

    @Override
    public Boleta obtenerXId(int idBoleta) throws Exception {
        return daoBoleta.obtenerPorId(idBoleta);
    }

    @Override
    public ArrayList<Boleta> listarTodos() throws Exception {
        return daoBoleta.listarTodos();
    }


    @Override
    public void validar(Boleta datBoleta) throws Exception {
        if (datBoleta.getTotal() < 0) {
            throw new Exception("En Boleta: El total no puede ser negativo.");
        }
        if (datBoleta.getDNI() == null || datBoleta.getDNI().isEmpty()) {
            throw new Exception("En Boleta: El DNI no puede estar vacío.");
        }
        if (datBoleta.getMetodoDePago() == null || datBoleta.getMetodoDePago().isEmpty()) {
            throw new Exception("En Boleta: El método de pago no puede estar vacío.");
        }
    }
}
