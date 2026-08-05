/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.bo;

import java.util.ArrayList;

import pe.edu.pucp.weardrop.prendas.Vestido;
import pe.edu.pucp.weardrop.prendas.boi.VestidoBOI;
import pe.edu.pucp.weardrop.prendas.dao.VestidoDAO;
import pe.edu.pucp.weardrop.prendas.mysql.VestidoImpl;

public class VestidoBOImpl implements VestidoBOI {

    private final VestidoDAO daoVestido;

    public VestidoBOImpl() {
        this.daoVestido = new VestidoImpl();
    }

    // --- CRUD ---

    @Override
    public int insertar(Vestido objeto) throws Exception {
        validar(objeto);
        return daoVestido.insertar(objeto);
    }

    @Override
    public int modificar(Vestido objeto) throws Exception {
        if (objeto == null || objeto.getIdPrenda() <= 0)
            throw new Exception("En Vestido: El idPrenda es inválido para modificar.");
        validar(objeto);
        return daoVestido.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Vestido: El idPrenda es inválido para eliminar.");
        return daoVestido.eliminar(idObjeto);
    }

    @Override
    public Vestido obtenerXId(int idObjeto) throws Exception {
        if (idObjeto <= 0)
            throw new Exception("En Vestido: El idPrenda es inválido para buscar.");
        return daoVestido.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Vestido> listarTodos() throws Exception {
        return daoVestido.listarTodos();
    }

    // --- Validaciones de negocio ---

    @Override
    public void validar(Vestido v) throws Exception {
        if (v == null) throw new Exception("En Vestido: El objeto es nulo.");

        // nombre requerido (≤ 100)
        if (v.getNombre() == null || v.getNombre().isEmpty())
            throw new Exception("En Vestido: El nombre es obligatorio.");
        if (v.getNombre().length() > 100)
            throw new Exception("En Vestido: El nombre supera los 100 caracteres.");

        // color requerido (≤ 30) — en Prenda suele ser NOT NULL
        if (v.getColor() == null || v.getColor().isEmpty())
            throw new Exception("En Vestido: El color es obligatorio.");
        if (v.getColor().length() > 30)
            throw new Exception("En Vestido: El color supera los 30 caracteres.");

        // precios ≥ 0
        if (v.getPrecioUnidad() < 0)
            throw new Exception("En Vestido: El precio por unidad debe ser ≥ 0.");
        if (v.getPrecioMayor() < 0)
            throw new Exception("En Vestido: El precio mayorista debe ser ≥ 0.");
        if (v.getPrecioDocena() < 0)
            throw new Exception("En Vestido: El precio por docena (por unidad) debe ser ≥ 0.");

        // coherencia de descuentos por cantidad:
        //  precioDocena ≤ precioMayor ≤ precioUnidad
        if (v.getPrecioMayor() > v.getPrecioUnidad())
            throw new Exception("En Vestido: El precio mayorista no puede ser mayor que el precio unitario.");
        if (v.getPrecioDocena() > v.getPrecioUnidad())
            throw new Exception("En Vestido: El precio por docena (por unidad) no puede ser mayor que el precio unitario.");
        if (v.getPrecioDocena() > v.getPrecioMayor())
            throw new Exception("En Vestido: El precio por docena (por unidad) no puede ser mayor que el precio mayorista.");

        // alertaMinStock ≥ 0
        if (v.getAlertaMinStock() < 0)
            throw new Exception("En Vestido: La alerta de stock debe ser ≥ 0.");

        // enums obligatorios
        if (v.getMaterial() == null)
            throw new Exception("En Vestido: El material es obligatorio.");
        if (v.getTipoVestido() == null)
            throw new Exception("En Vestido: El tipo de vestido es obligatorio.");
        if (v.getTipoManga() == null)
            throw new Exception("En Vestido: El tipo de manga es obligatorio.");

        // largo > 0
        if (v.getLargo() <= 0)
            throw new Exception("En Vestido: El largo debe ser mayor que 0.");
    }
    
    @Override
    public ArrayList<Vestido> filtrarVestidos(
    ) {
        // Pasamos tal cual al DAO (sin normalizar valores)
        return daoVestido.filtrarVestidos();
    }
    
}

