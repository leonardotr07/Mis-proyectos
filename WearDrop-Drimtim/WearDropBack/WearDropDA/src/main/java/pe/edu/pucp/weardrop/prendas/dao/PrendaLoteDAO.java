/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.PrendaLote;
import pe.edu.pucp.weardrop.prendas.Talla;

/**
 *
 * @author valer
 */
public interface PrendaLoteDAO extends IDAO<PrendaLote> {
    
    // Consultas
    PrendaLote obtenerPorId(int idPrendaLote);
    ArrayList<PrendaLote> listarTodos();
    
    /**
     * Obtener stock total de una prenda por talla (suma de todos los lotes)
     */
    int getStockPorTalla(int idPrenda, Talla talla);
    
    /**
     * Listar todas las PrendaLote de un lote específico
     */
    ArrayList<PrendaLote> listarPorLote(int idLote);
    
   ArrayList<PrendaLote> listarPorIDPrenda(int idPrenda);
    
    
    /**
     * Verificar si ya existe una prenda con esa talla en un lote específico
     */
    boolean existePrendaTallaEnLote(int idPrenda, Talla talla, int idLote);
}
