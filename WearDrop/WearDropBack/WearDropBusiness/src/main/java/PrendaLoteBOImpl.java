package pe.edu.pucp.weardrop.prendas.bo.impl;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.PrendaLote;
import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.prendas.bo.PrendaLoteBO;
import pe.edu.pucp.weardrop.prendas.dao.PrendaLoteDAO;
import pe.edu.pucp.weardrop.prendas.mysql.PrendaLoteImpl;

public class PrendaLoteBOImpl implements PrendaLoteBO {

    private PrendaLoteDAO prendaLoteDAO;
    
    public PrendaLoteBOImpl() {
        this.prendaLoteDAO = new PrendaLoteImpl();
    }

    // ========================================
    // MÉTODOS CRUD CON VALIDACIÓN
    // ========================================
    
    @Override
    public int insertar(PrendaLote objeto) throws Exception {
        // 1. Validar el objeto
        validar(objeto);
        
        // 2. Validar reglas de negocio específicas
        validarReglasPrendaLote(objeto);
        
        // 3. Insertar en BD
        int resultado = prendaLoteDAO.insertar(objeto);
        
        if (resultado <= 0) {
            throw new Exception("No se pudo registrar la PrendaLote en el sistema");
        }
        
        return resultado;
    }

    @Override
    public int modificar(PrendaLote objeto) throws Exception {
        // 1. Validar que existe
        PrendaLote existente = prendaLoteDAO.obtenerPorId(objeto.getIdPrendaLote());
        if (existente == null) {
            throw new Exception("La PrendaLote con ID " + objeto.getIdPrendaLote() + " no existe");
        }
        
        // 2. Validar el objeto
        validar(objeto);
        
        // 3. Modificar en BD
        int resultado = prendaLoteDAO.modificar(objeto);
        
        if (resultado <= 0) {
            throw new Exception("No se pudo modificar la PrendaLote");
        }
        
        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        // 1. Validar que existe
        PrendaLote existente = prendaLoteDAO.obtenerPorId(idObjeto);
        if (existente == null) {
            throw new Exception("La PrendaLote con ID " + idObjeto + " no existe");
        }
        
        // 2. Validar si se puede eliminar (reglas de negocio)
        // Por ejemplo: verificar si no está en pedidos activos
        
        // 3. Eliminar (baja lógica)
        int resultado = prendaLoteDAO.eliminar(idObjeto);
        
        if (resultado <= 0) {
            throw new Exception("No se pudo eliminar la PrendaLote");
        }
        
        return resultado;
    }

    @Override
    public PrendaLote obtenerXId(int idObjeto) throws Exception {
        if (idObjeto <= 0) {
            throw new Exception("El ID debe ser mayor a 0");
        }
        
        PrendaLote prendaLote = prendaLoteDAO.obtenerPorId(idObjeto);
        
        if (prendaLote == null) {
            throw new Exception("No se encontró PrendaLote con ID " + idObjeto);
        }
        
        return prendaLote;
    }

    @Override
    public ArrayList<PrendaLote> listarTodos() throws Exception {
        ArrayList<PrendaLote> lista = prendaLoteDAO.listarTodos();
        
        if (lista == null) {
            lista = new ArrayList<>(); // Retornar lista vacía en lugar de null
        }
        
        return lista;
    }

    @Override
    public void validar(PrendaLote objeto) throws Exception {
        if (objeto == null) {
            throw new Exception("El objeto PrendaLote no puede ser null");
        }
        
        // Validar ID de Prenda
        if (objeto.getIdPrenda() <= 0) {
            throw new Exception("Debe seleccionar una prenda válida");
        }
        
        // Validar ID de Lote
        if (objeto.getIdLote() <= 0) {
            throw new Exception("Debe especificar un lote válido");
        }
        
        // Validar talla
        if (objeto.getTalla() == null) {
            throw new Exception("Debe seleccionar una talla");
        }
        
        // Validar stock
        if (objeto.getStock() <= 0) {
            throw new Exception("El stock debe ser mayor a 0");
        }
        
        if (objeto.getStock() > 10000) {
            throw new Exception("El stock no puede ser mayor a 10,000 unidades");
        }
    }
    
    /**
     * Validaciones específicas de reglas de negocio de PrendaLote
     */
    private void validarReglasPrendaLote(PrendaLote objeto) throws Exception {
        // 1. Verificar que no exista ya la misma prenda-talla en el lote
        boolean existe = prendaLoteDAO.existePrendaTallaEnLote(
            objeto.getIdPrenda(), 
            objeto.getTalla(), 
            objeto.getIdLote()
        );
        
        if (existe) {
            throw new Exception("Esta prenda con la talla " + objeto.getTalla() + 
                              " ya existe en el lote. No se pueden agregar duplicados.");
        }
        
        // 2. Validar que la prenda existe y está activa
        Prenda prenda = PrendaLoteImpl.buscarPrendaPorId(objeto.getIdPrenda());
        if (prenda == null) {
            throw new Exception("La prenda con ID " + objeto.getIdPrenda() + " no existe");
        }
        
        if (!prenda.isActivo()) {
            throw new Exception("No se puede agregar una prenda inactiva al lote");
        }
        
        // 3. Otras validaciones de negocio que necesites
        // Por ejemplo: validar stock mínimo, máximo, etc.
    }

    // ========================================
    // MÉTODOS ESPECÍFICOS DE PRENDALOTE
    // ========================================
    
    @Override
    public ArrayList<PrendaLote> listarPorLote(int idLote) throws Exception {
        if (idLote <= 0) {
            throw new Exception("El ID de lote debe ser mayor a 0");
        }
        
        ArrayList<PrendaLote> lista = prendaLoteDAO.listarPorLote(idLote);
        
        if (lista == null) {
            lista = new ArrayList<>();
        }
        
        return lista;
    }

    @Override
    public boolean existePrendaTallaEnLote(int idPrenda, Talla talla, int idLote) throws Exception {
        if (idPrenda <= 0) {
            throw new Exception("El ID de prenda debe ser mayor a 0");
        }
        
        if (talla == null) {
            throw new Exception("La talla no puede ser null");
        }
        
        if (idLote <= 0) {
            throw new Exception("El ID de lote debe ser mayor a 0");
        }
        
        return prendaLoteDAO.existePrendaTallaEnLote(idPrenda, talla, idLote);
    }

    @Override
    public int obtenerStockPorTalla(int idPrenda, Talla talla) throws Exception {
        if (idPrenda <= 0) {
            throw new Exception("El ID de prenda debe ser mayor a 0");
        }
        
        if (talla == null) {
            throw new Exception("La talla no puede ser null");
        }
        
        return prendaLoteDAO.getStockPorTalla(idPrenda, talla);
    }

    // ========================================
    // MÉTODOS AUXILIARES PARA BÚSQUEDA DE PRENDAS
    // (Delegados a métodos estáticos del DAO)
    // ========================================
    
    @Override
    public Prenda buscarPrendaPorId(int idPrenda) throws Exception {
        if (idPrenda <= 0) {
            throw new Exception("El ID de prenda debe ser mayor a 0");
        }
        
        Prenda prenda = PrendaLoteImpl.buscarPrendaPorId(idPrenda);
        
        if (prenda == null) {
            throw new Exception("No se encontró ninguna prenda con ID " + idPrenda);
        }
        
        return prenda;
    }

    @Override
    public Prenda buscarPrendaPorAtributos(String nombre, String color, String material) throws Exception {
        // Validar que los parámetros no estén vacíos
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new Exception("El nombre de la prenda no puede estar vacío");
        }
        
        if (color == null || color.trim().isEmpty()) {
            throw new Exception("El color de la prenda no puede estar vacío");
        }
        
        if (material == null || material.trim().isEmpty()) {
            throw new Exception("El material de la prenda no puede estar vacío");
        }
        
        Prenda prenda = PrendaLoteImpl.buscarPrendaPorAtributos(nombre, color, material);
        
        if (prenda == null) {
            throw new Exception("No se encontró ninguna prenda con los atributos especificados: " +
                              "Nombre=" + nombre + ", Color=" + color + ", Material=" + material);
        }
        
        return prenda;
    }

    @Override
    public ArrayList<String> listarNombresDistintos() throws Exception {
        ArrayList<String> nombres = PrendaLoteImpl.listarNombresDistintos();
        
        if (nombres == null) {
            nombres = new ArrayList<>();
        }
        
        if (nombres.isEmpty()) {
            throw new Exception("No hay prendas registradas en el sistema");
        }
        
        return nombres;
    }

    @Override
    public ArrayList<String> listarColoresDistintos() throws Exception {
        ArrayList<String> colores = PrendaLoteImpl.listarColoresDistintos();
        
        if (colores == null) {
            colores = new ArrayList<>();
        }
        
        if (colores.isEmpty()) {
            throw new Exception("No hay colores registrados en el sistema");
        }
        
        return colores;
    }

    @Override
    public ArrayList<String> listarMaterialesDistintos() throws Exception {
        ArrayList<String> materiales = PrendaLoteImpl.listarMaterialesDistintos();
        
        if (materiales == null) {
            materiales = new ArrayList<>();
        }
        
        if (materiales.isEmpty()) {
            throw new Exception("No hay materiales registrados en el sistema");
        }
        
        return materiales;
    }
    @Override
    public ArrayList<PrendaLote> listarPorIDPrenda(int idPrenda) {
        
        ArrayList<PrendaLote> lista = prendaLoteDAO.listarPorIDPrenda(idPrenda);
        
        if (lista == null) {
            lista = new ArrayList<>();
        }
        
        return lista;
    }
}
