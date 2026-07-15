/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.bo;

import java.util.ArrayList;

import pe.edu.pucp.weardrop.prendas.Polo;
import pe.edu.pucp.weardrop.prendas.boi.PoloBOI;
import pe.edu.pucp.weardrop.prendas.dao.PoloDAO;
import pe.edu.pucp.weardrop.prendas.mysql.PoloImpl;

public class PoloBOImpl implements PoloBOI {

    private final PoloDAO daoPolo;

    public PoloBOImpl() {
        this.daoPolo = new PoloImpl();
    }

    @Override
    public int insertar(Polo objeto) throws Exception {
        validar(objeto);
        return daoPolo.insertar(objeto);
    }

    @Override
    public int modificar(Polo objeto) throws Exception {
        if (objeto == null || objeto.getIdPrenda() <= 0) {
            throw new Exception("En Polo: El idPrenda es inválido para modificar.");
        }
        validar(objeto);
        return daoPolo.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        if (idObjeto <= 0) {
            throw new Exception("En Polo: El idPrenda es inválido para eliminar.");
        }
        return daoPolo.eliminar(idObjeto);
    }

    @Override
    public Polo obtenerXId(int idObjeto) throws Exception {
        if (idObjeto <= 0) {
            throw new Exception("En Polo: El idPrenda es inválido para buscar.");
        }
        return daoPolo.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Polo> listarTodos() throws Exception {
        return daoPolo.listarTodos();
    }

    @Override
    public void validar(Polo p) throws Exception {
        if (p == null) throw new Exception("En Polo: El objeto es nulo.");

        // nombre: requerido, ≤ 100
        if (p.getNombre() == null || p.getNombre().isEmpty())
            throw new Exception("En Polo: El nombre es obligatorio.");
        if (p.getNombre().length() > 100)
            throw new Exception("En Polo: El nombre supera los 100 caracteres.");

        // color: OPCIONAL; si no es null, ≤ 30
        if (p.getColor() != null && p.getColor().length() > 30)
            throw new Exception("En Polo: El color supera los 30 caracteres.");

        // estampado: OPCIONAL; si no es null, ≤ 80
        if (p.getEstampado() != null && p.getEstampado().length() > 80)
            throw new Exception("En Polo: El estampado supera los 80 caracteres.");

        // precios ≥ 0
        if (p.getPrecioUnidad() < 0)
            throw new Exception("En Polo: El precio por unidad debe ser ≥ 0.");
        if (p.getPrecioMayor() < 0)
            throw new Exception("En Polo: El precio mayorista debe ser ≥ 0.");
        if (p.getPrecioDocena() < 0)
            throw new Exception("En Polo: El precio por docena (por unidad) debe ser ≥ 0.");

        // reglas de coherencia (docena es precio por unidad si llevan 12):
        //  precioDocena ≤ precioMayor ≤ precioUnidad
        if (p.getPrecioMayor() > p.getPrecioUnidad())
            throw new Exception("En Polo: El precio mayorista no puede ser mayor que el precio unitario.");
        if (p.getPrecioDocena() > p.getPrecioUnidad())
            throw new Exception("En Polo: El precio por docena (por unidad) no puede ser mayor que el precio unitario.");
        if (p.getPrecioDocena() > p.getPrecioMayor())
            throw new Exception("En Polo: El precio por docena (por unidad) no puede ser mayor que el precio mayorista.");

        // alerta de stock ≥ 0
        if (p.getAlertaMinStock() < 0)
            throw new Exception("En Polo: La alerta de stock debe ser ≥ 0.");

        // enums obligatorios
        if (p.getMaterial() == null)
            throw new Exception("En Polo: El material es obligatorio.");
        if (p.getTipoManga() == null)
            throw new Exception("En Polo: El tipo de manga es obligatorio.");
        if (p.getTipoCuello() == null)
            throw new Exception("En Polo: El tipo de cuello es obligatorio.");
    }
    
    @Override
    public ArrayList<Polo> filtrarPolos() {
       

        // Sin normalizar: se pasan los valores tal cual al DAO
        return daoPolo.filtrarPolos();
    }
    
    
}

