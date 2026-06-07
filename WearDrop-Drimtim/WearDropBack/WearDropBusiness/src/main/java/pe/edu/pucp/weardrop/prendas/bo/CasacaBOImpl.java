/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.bo;

import java.util.ArrayList;

import pe.edu.pucp.weardrop.prendas.Casaca;
import pe.edu.pucp.weardrop.prendas.boi.CasacaBOI;
import pe.edu.pucp.weardrop.prendas.dao.CasacaDAO;
import pe.edu.pucp.weardrop.prendas.mysql.CasacaImpl;

public class CasacaBOImpl implements CasacaBOI {

    private final CasacaDAO daoCasaca;

    public CasacaBOImpl() {
        this.daoCasaca = new CasacaImpl();
    }

    // --- CRUD ---

    @Override
    public int insertar(Casaca objeto) throws Exception {
        validar(objeto);
        return daoCasaca.insertar(objeto);
    }

    @Override
    public int modificar(Casaca objeto) throws Exception {
        if (objeto == null || objeto.getIdPrenda() <= 0)
            throw new Exception("En Casaca: El idPrenda es inválido para modificar.");
        validar(objeto);
        return daoCasaca.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Casaca: El idPrenda es inválido para eliminar.");
        return daoCasaca.eliminar(idObjeto);
    }

    @Override
    public Casaca obtenerXId(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Casaca: El idPrenda es inválido para buscar.");
        return daoCasaca.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Casaca> listarTodos() throws Exception {
        return daoCasaca.listarTodos();
    }

    // --- Validaciones de negocio ---

    @Override
    public void validar(Casaca c) throws Exception {
        if (c == null) throw new Exception("En Casaca: El objeto es nulo.");

        // nombre requerido (≤ 100)
        if (c.getNombre() == null || c.getNombre().isEmpty())
            throw new Exception("En Casaca: El nombre es obligatorio.");
        if (c.getNombre().length() > 100)
            throw new Exception("En Casaca: El nombre supera los 100 caracteres.");

        // color requerido (≤ 30) — siguiendo tu esquema general de Prenda
        if (c.getColor() == null || c.getColor().isEmpty())
            throw new Exception("En Casaca: El color es obligatorio.");
        if (c.getColor().length() > 30)
            throw new Exception("En Casaca: El color supera los 30 caracteres.");

        // precios ≥ 0
        if (c.getPrecioUnidad() < 0)
            throw new Exception("En Casaca: El precio por unidad debe ser ≥ 0.");
        if (c.getPrecioMayor() < 0)
            throw new Exception("En Casaca: El precio mayorista debe ser ≥ 0.");
        if (c.getPrecioDocena() < 0)
            throw new Exception("En Casaca: El precio por docena (por unidad) debe ser ≥ 0.");

        // coherencia de descuentos por cantidad:
        //  precioDocena ≤ precioMayor ≤ precioUnidad
        if (c.getPrecioMayor() > c.getPrecioUnidad())
            throw new Exception("En Casaca: El precio mayorista no puede ser mayor que el precio unitario.");
        if (c.getPrecioDocena() > c.getPrecioUnidad())
            throw new Exception("En Casaca: El precio por docena (por unidad) no puede ser mayor que el precio unitario.");
        if (c.getPrecioDocena() > c.getPrecioMayor())
            throw new Exception("En Casaca: El precio por docena (por unidad) no puede ser mayor que el precio mayorista.");

        // alertaMinStock ≥ 0
        if (c.getAlertaMinStock() < 0)
            throw new Exception("En Casaca: La alerta de stock debe ser ≥ 0.");

        // enums obligatorios
        if (c.getMaterial() == null)
            throw new Exception("En Casaca: El material es obligatorio.");
        if (c.getTipoCasaca() == null)
            throw new Exception("En Casaca: El tipo de casaca es obligatorio.");

        // conCapucha: boolean, sin validación adicional necesaria
    }
    
    @Override
    public ArrayList<Casaca> filtrarCasacas() {
       
        return daoCasaca.filtrarCasacas();
    }
}

