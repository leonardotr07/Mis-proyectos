package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.PrendaLote;
import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.prendas.bo.PrendaLoteBO;
import pe.edu.pucp.weardrop.prendas.bo.impl.PrendaLoteBOImpl;

@WebService(serviceName = "PrendaLoteWS")
public class PrendaLoteWS {
    
    private PrendaLoteBO prendaLoteBO;
    
    public PrendaLoteWS() {
        this.prendaLoteBO = new PrendaLoteBOImpl();
    }
    
    // ========================================
    // MÉTODOS CRUD
    // ========================================
    
    @WebMethod(operationName = "insertarPrendaLote")
public int insertarPrendaLote(@WebParam(name = "prendaLote") PrendaLote prendaLote) {
    try {
        // ✅ VERIFICAR QUÉ LLEGA
        System.out.println("=== INSERTANDO PRENDA LOTE ===");
        System.out.println("ID Prenda: " + prendaLote.getIdPrenda());
        System.out.println("ID Lote: " + prendaLote.getIdLote());
        System.out.println("Talla: " + prendaLote.getTalla()); // <-- VER QUÉ SALE AQUÍ
        System.out.println("Stock: " + prendaLote.getStock());
        
        if (prendaLote.getTalla() == null) {
            System.out.println("❌ TALLA ES NULL");
            throw new Exception("Debe seleccionar una talla");
        }
        
        return prendaLoteBO.insertar(prendaLote);
    } catch (Exception ex) {
        System.out.println("ERROR en WS insertarPrendaLote: " + ex.getMessage());
        throw new RuntimeException(ex.getMessage());
    }
}

    
    @WebMethod(operationName = "modificarPrendaLote")
    public int modificarPrendaLote(@WebParam(name = "prendaLote") PrendaLote prendaLote) {
        try {
            return prendaLoteBO.modificar(prendaLote);
        } catch (Exception ex) {
            System.out.println("ERROR en WS modificarPrendaLote: " + ex.getMessage());
            ex.printStackTrace();
            return -1;
        }
    }
    
    @WebMethod(operationName = "listarPorIDPrenda")
public ArrayList<PrendaLote> listarPorIDPrenda(@WebParam(name = "idPrenda") int idPrenda) {
    try {
        System.out.println("=== WS: listarPorIDPrenda - idPrenda: " + idPrenda + " ===");
        
        ArrayList<PrendaLote> lista = prendaLoteBO.listarPorIDPrenda(idPrenda);
        
        if (lista != null) {
            System.out.println("WS retornando " + lista.size() + " prendas");
        } else {
            System.out.println(" WS retornando null");
        }
        
        return lista;
    } catch (Exception ex) {
        System.out.println("ERROR en WS listarPrendasPorLote: " + ex.getMessage());
        ex.printStackTrace();
        return new ArrayList<>();
    }
}
    
    @WebMethod(operationName = "eliminarPrendaLote")
    public int eliminarPrendaLote(@WebParam(name = "idPrendaLote") int idPrendaLote) {
        try {
            return prendaLoteBO.eliminar(idPrendaLote);
        } catch (Exception ex) {
            System.out.println("ERROR en WS eliminarPrendaLote: " + ex.getMessage());
            ex.printStackTrace();
            return -1;
        }
    }
    
    @WebMethod(operationName = "obtenerPrendaLotePorId")
    public PrendaLote obtenerPrendaLotePorId(@WebParam(name = "idPrendaLote") int idPrendaLote) {
        try {
            return prendaLoteBO.obtenerXId(idPrendaLote);
        } catch (Exception ex) {
            System.out.println("ERROR en WS obtenerPrendaLotePorId: " + ex.getMessage());
            ex.printStackTrace();
            return null;
        }
    }
    
    @WebMethod(operationName = "listarTodasPrendasLote")
    public ArrayList<PrendaLote> listarTodasPrendasLote() {
        try {
            return prendaLoteBO.listarTodos();
        } catch (Exception ex) {
            System.out.println("ERROR en WS listarTodasPrendasLote: " + ex.getMessage());
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @WebMethod(operationName = "listarPrendasPorLote")
public ArrayList<PrendaLote> listarPrendasPorLote(@WebParam(name = "idLote") int idLote) {
    try {
        System.out.println("=== WS: listarPrendasPorLote - idLote: " + idLote + " ===");
        
        ArrayList<PrendaLote> lista = prendaLoteBO.listarPorLote(idLote);
        
        if (lista != null) {
            System.out.println("WS retornando " + lista.size() + " prendas");
        } else {
            System.out.println(" WS retornando null");
        }
        
        return lista;
    } catch (Exception ex) {
        System.out.println("ERROR en WS listarPrendasPorLote: " + ex.getMessage());
        ex.printStackTrace();
        return new ArrayList<>();
    }
}

    
    @WebMethod(operationName = "existePrendaTallaEnLote")
    public boolean existePrendaTallaEnLote(
            @WebParam(name = "idPrenda") int idPrenda,
            @WebParam(name = "talla") String talla,
            @WebParam(name = "idLote") int idLote) {
        try {
            Talla tallEnum = Talla.valueOf(talla);
            return prendaLoteBO.existePrendaTallaEnLote(idPrenda, tallEnum, idLote);
        } catch (Exception ex) {
            System.out.println("ERROR en WS existePrendaTallaEnLote: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }
    
    @WebMethod(operationName = "obtenerStockPorTalla")
    public int obtenerStockPorTalla(
            @WebParam(name = "idPrenda") int idPrenda,
            @WebParam(name = "talla") String talla) {
        try {
            Talla tallEnum = Talla.valueOf(talla);
            return prendaLoteBO.obtenerStockPorTalla(idPrenda, tallEnum);
        } catch (Exception ex) {
            System.out.println("ERROR en WS obtenerStockPorTalla: " + ex.getMessage());
            ex.printStackTrace();
            return 0;
        }
    }
    
    // ========================================
    // MÉTODOS DE BÚSQUEDA DE PRENDAS
    // ========================================
    
    @WebMethod(operationName = "buscarPrendaPorId")
    public Prenda buscarPrendaPorId(@WebParam(name = "idPrenda") int idPrenda) {
        try {
            return prendaLoteBO.buscarPrendaPorId(idPrenda);
        } catch (Exception ex) {
            System.out.println("ERROR en WS buscarPrendaPorId: " + ex.getMessage());
            ex.printStackTrace();
            return null;
        }
    }
    
    @WebMethod(operationName = "buscarPrendaPorAtributos")
    public Prenda buscarPrendaPorAtributos(
            @WebParam(name = "nombre") String nombre,
            @WebParam(name = "color") String color,
            @WebParam(name = "material") String material) {
        try {
            return prendaLoteBO.buscarPrendaPorAtributos(nombre, color, material);
        } catch (Exception ex) {
            System.out.println("ERROR en WS buscarPrendaPorAtributos: " + ex.getMessage());
            ex.printStackTrace();
            return null;
        }
    }
    
    @WebMethod(operationName = "listarNombresDistintos")
    public ArrayList<String> listarNombresDistintos() {
        try {
            return prendaLoteBO.listarNombresDistintos();
        } catch (Exception ex) {
            System.out.println("ERROR en WS listarNombresDistintos: " + ex.getMessage());
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @WebMethod(operationName = "listarColoresDistintos")
    public ArrayList<String> listarColoresDistintos() {
        try {
            return prendaLoteBO.listarColoresDistintos();
        } catch (Exception ex) {
            System.out.println("ERROR en WS listarColoresDistintos: " + ex.getMessage());
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @WebMethod(operationName = "listarMaterialesDistintos")
    public ArrayList<String> listarMaterialesDistintos() {
        try {
            return prendaLoteBO.listarMaterialesDistintos();
        } catch (Exception ex) {
            System.out.println("ERROR en WS listarMaterialesDistintos: " + ex.getMessage());
            ex.printStackTrace();
            return new ArrayList<>();
        }
    }
}
