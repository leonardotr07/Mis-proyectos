/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.bo;

import java.util.ArrayList;

import pe.edu.pucp.weardrop.prendas.Falda;
import pe.edu.pucp.weardrop.prendas.boi.FaldaBOI;
import pe.edu.pucp.weardrop.prendas.dao.FaldaDAO;
import pe.edu.pucp.weardrop.prendas.mysql.FaldaImpl;

public class FaldaBOImpl implements FaldaBOI {

    private final FaldaDAO daoFalda;

    public FaldaBOImpl() {
        this.daoFalda = new FaldaImpl();
    }

    // --- CRUD ---

    @Override
    public int insertar(Falda objeto) throws Exception {
        validar(objeto);
        return daoFalda.insertar(objeto);
    }

    @Override
    public int modificar(Falda objeto) throws Exception {
        if (objeto == null || objeto.getIdPrenda() <= 0)
            throw new Exception("En Falda: El idPrenda es inválido para modificar.");
        validar(objeto);
        return daoFalda.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Falda: El idPrenda es inválido para eliminar.");
        return daoFalda.eliminar(idObjeto);
    }

    @Override
    public Falda obtenerXId(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Falda: El idPrenda es inválido para buscar.");
        return daoFalda.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Falda> listarTodos() throws Exception {
        return daoFalda.listarTodos();
    }

    // --- Validaciones de negocio ---

    @Override
    public void validar(Falda f) throws Exception {
        if (f == null) throw new Exception("En Falda: El objeto es nulo.");

        // nombre requerido (≤ 100)
        if (f.getNombre() == null || f.getNombre().isEmpty())
            throw new Exception("En Falda: El nombre es obligatorio.");
        if (f.getNombre().length() > 100)
            throw new Exception("En Falda: El nombre supera los 100 caracteres.");

        // color requerido (≤ 30) — en Prenda suele ser NOT NULL
        if (f.getColor() == null || f.getColor().isEmpty())
            throw new Exception("En Falda: El color es obligatorio.");
        if (f.getColor().length() > 30)
            throw new Exception("En Falda: El color supera los 30 caracteres.");

        // precios ≥ 0
        if (f.getPrecioUnidad() < 0)
            throw new Exception("En Falda: El precio por unidad debe ser ≥ 0.");
        if (f.getPrecioMayor() < 0)
            throw new Exception("En Falda: El precio mayorista debe ser ≥ 0.");
        if (f.getPrecioDocena() < 0)
            throw new Exception("En Falda: El precio por docena (por unidad) debe ser ≥ 0.");

        // coherencia de descuentos por cantidad:
        //  precioDocena ≤ precioMayor ≤ precioUnidad
        if (f.getPrecioMayor() > f.getPrecioUnidad())
            throw new Exception("En Falda: El precio mayorista no puede ser mayor que el precio unitario.");
        if (f.getPrecioDocena() > f.getPrecioUnidad())
            throw new Exception("En Falda: El precio por docena (por unidad) no puede ser mayor que el precio unitario.");
        if (f.getPrecioDocena() > f.getPrecioMayor())
            throw new Exception("En Falda: El precio por docena (por unidad) no puede ser mayor que el precio mayorista.");

        // alertaMinStock ≥ 0
        if (f.getAlertaMinStock() < 0)
            throw new Exception("En Falda: La alerta de stock debe ser ≥ 0.");

        // enums obligatorios
        if (f.getMaterial() == null)
            throw new Exception("En Falda: El material es obligatorio.");
        if (f.getTipoFalda() == null)
            throw new Exception("En Falda: El tipo de falda es obligatorio.");

        // largo > 0 (sea int o double según tu modelo)
        if (f.getLargo() <= 0)
            throw new Exception("En Falda: El largo debe ser mayor que 0.");

        // conForro / conVolantes: booleans, sin validación adicional necesaria
    }
    
     @Override
    public ArrayList<Falda> filtrarFaldas() {
        return daoFalda.filtrarFaldas();
    }
    
}
