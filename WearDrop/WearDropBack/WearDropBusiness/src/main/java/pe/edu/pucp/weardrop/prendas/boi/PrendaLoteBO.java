package pe.edu.pucp.weardrop.prendas.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.PrendaLote;
import pe.edu.pucp.weardrop.prendas.Talla;

public interface PrendaLoteBO extends BusinessObject<PrendaLote> {
    
    /**
     * Listar todas las prendas de un lote específico
     */
    ArrayList<PrendaLote> listarPorLote(int idLote) throws Exception;
    ArrayList<PrendaLote> listarPorIDPrenda(int idPrenda);
    
    /**
     * Verificar si existe una prenda con una talla en un lote
     */
    boolean existePrendaTallaEnLote(int idPrenda, Talla talla, int idLote) throws Exception;
    
    /**
     * Obtener stock total de una prenda por talla (suma de todos los lotes)
     */
    int obtenerStockPorTalla(int idPrenda, Talla talla) throws Exception;
    
    // ========================================
    // MÉTODOS AUXILIARES PARA BÚSQUEDA DE PRENDAS
    // (Para el flujo del Front de registro de lotes)
    // ========================================
    
    /**
     * Buscar prenda por ID
     */
    Prenda buscarPrendaPorId(int idPrenda) throws Exception;
    
    /**
     * Buscar prenda por atributos (nombre, color, material)
     */
    Prenda buscarPrendaPorAtributos(String nombre, String color, String material) throws Exception;
    
    /**
     * Listar nombres distintos de prendas
     */
    ArrayList<String> listarNombresDistintos() throws Exception;
    
    /**
     * Listar colores distintos de prendas
     */
    ArrayList<String> listarColoresDistintos() throws Exception;
    
    /**
     * Listar materiales distintos de prendas
     */
    ArrayList<String> listarMaterialesDistintos() throws Exception;
}
