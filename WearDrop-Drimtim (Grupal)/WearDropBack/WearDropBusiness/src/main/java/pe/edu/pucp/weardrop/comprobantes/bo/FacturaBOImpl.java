/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes.bo;


import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.Factura;
import pe.edu.pucp.weardrop.comprobantes.boi.FacturaBOI;
import pe.edu.pucp.weardrop.comprobantes.dao.FacturaDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.FacturaImpl;

/**
 * Implementación de la capa de negocio para Factura
 */
public class FacturaBOImpl implements FacturaBOI {
    
    private final FacturaDAO daoFactura;

    public FacturaBOImpl() {
        daoFactura = new FacturaImpl();
    }

    @Override
    public int insertar(Factura datFactura) throws Exception {
        validar(datFactura);
        return daoFactura.insertar(datFactura);
    }

    @Override
    public int modificar(Factura datFactura) throws Exception {
        validar(datFactura);
        return daoFactura.modificar(datFactura);
    }

    @Override
    public int eliminar(int idFactura) throws Exception {
        return daoFactura.eliminar(idFactura);
    }

    @Override
    public Factura obtenerXId(int idFactura) throws Exception {
        return daoFactura.obtenerPorId(idFactura);
    }

    @Override
    public ArrayList<Factura> listarTodos() throws Exception {
        return daoFactura.listarTodos();
    }

    @Override
    public void validar(Factura datFactura) throws Exception {
        if (datFactura.getTotal() < 0) {
            throw new Exception("En Factura: El total no puede ser negativo.");
        }
        if (datFactura.getRUC() == null || datFactura.getRUC().length() != 11) {
            throw new Exception("En Factura: El RUC debe tener 11 caracteres.");
        }
        if (datFactura.getRazonSocial() == null || datFactura.getRazonSocial().isEmpty()) {
            throw new Exception("En Factura: La razón social no puede estar vacía.");
        }
    }
}