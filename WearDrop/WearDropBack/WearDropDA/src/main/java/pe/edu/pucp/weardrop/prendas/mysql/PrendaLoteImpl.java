package pe.edu.pucp.weardrop.prendas.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.*;
import pe.edu.pucp.weardrop.prendas.dao.PrendaLoteDAO;

public class PrendaLoteImpl implements PrendaLoteDAO {

    private ResultSet rs;

   
    @Override
    public int insertar(PrendaLote dat) {
        Map<Integer, Object> out = new HashMap<>();
        Map<Integer, Object> in  = new HashMap<>();
        
        out.put(1, Types.INTEGER);
        in.put(2, dat.getIdPrenda());
        in.put(3, dat.getIdLote());
        in.put(4, dat.getTalla().name());
        in.put(5, dat.getStock());

        DBManager.getInstance().ejecutarProcedimiento("insertar_prenda_lote", in, out);

        int idGen = (int) out.get(1);
        dat.setIdPrendaLote(idGen);
        System.out.println("Se ha registrado PrendaLote id=" + idGen);
        return idGen;
    }

    @Override
    public int modificar(PrendaLote dat) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, dat.getIdPrendaLote());
        in.put(2, dat.getStock());
        in.put(3, dat.isActivo() ? 1 : 0);
        String tallaString = dat.getTalla() != null ? dat.getTalla().toString() : null;
        in.put(4, tallaString);

        int res = DBManager.getInstance().ejecutarProcedimiento("modificar_prenda_lote", in, null);
        System.out.println("Se ha modificado PrendaLote id=" + dat.getIdPrendaLote());
        return res;
    }

    @Override
    public int eliminar(int idPrendaLote) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrendaLote);

        int res = DBManager.getInstance().ejecutarProcedimiento("eliminar_prenda_lote", in, null);
        System.out.println("Baja lógica PrendaLote id=" + idPrendaLote);
        return res;
    }

    @Override
    public PrendaLote obtenerPorId(int idPrendaLote) {
        PrendaLote pl = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrendaLote);

        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("obtener_prenda_lote_X_id", in);

        try {
            if (rs.next()) {
                pl = new PrendaLote();
                pl.setIdPrendaLote(rs.getInt("idPrendaLote"));
                pl.setIdPrenda(rs.getInt("idPrenda"));
                pl.setIdLote(rs.getInt("idLote"));
                pl.setTalla(Talla.valueOf(rs.getString("talla")));
                pl.setStock(rs.getInt("stock"));
                pl.setActivo(rs.getBoolean("activo"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener PrendaLote: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return pl;
    }

    @Override
    public ArrayList<PrendaLote> listarTodos() {
        ArrayList<PrendaLote> lista = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_prenda_lote", null);

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                PrendaLote pl = new PrendaLote();

                pl.setIdPrendaLote(rs.getInt("idPrendaLote"));
                pl.setIdPrenda(rs.getInt("idPrenda"));
                pl.setIdLote(rs.getInt("idLote"));
                pl.setTalla(Talla.valueOf(rs.getString("talla")));
                pl.setStock(rs.getInt("stock"));
                pl.setActivo(rs.getBoolean("activo"));

                lista.add(pl);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar PrendaLote: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return lista;
    }

    @Override
    public int getStockPorTalla(int idPrenda, Talla talla) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);
        in.put(2, talla.name());

        int total = 0;
        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("obtener_stock_prenda_talla", in);
        
        try {
            if (rs.next()) total = rs.getInt("stock_total");
        } catch (SQLException e) {
            System.out.println("ERROR stock por talla: " + e.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return total;
    }
    
    @Override
    public ArrayList<PrendaLote> listarPorLote(int idLote) {
        ArrayList<PrendaLote> lista = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idLote);
        
        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("listar_prendas_X_lote", in);

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                PrendaLote pl = new PrendaLote();

                pl.setIdPrendaLote(rs.getInt("idPrendaLote"));
                pl.setIdPrenda(rs.getInt("idPrenda"));
                pl.setIdLote(rs.getInt("idLote"));
                pl.setTalla(Talla.valueOf(rs.getString("talla")));
                pl.setStock(rs.getInt("stock"));
                pl.setActivo(rs.getBoolean("activo"));

                lista.add(pl);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar por lote: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return lista;
    }

    @Override
    public boolean existePrendaTallaEnLote(int idPrenda, Talla talla, int idLote) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);
        in.put(2, talla.name());
        in.put(3, idLote);
        
        boolean existe = false;
        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("existe_prenda_talla_en_lote", in);
        
        try {
            if (rs.next()) existe = rs.getInt("cantidad") > 0;
        } catch (SQLException ex) {
            System.out.println("ERROR al verificar existencia: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return existe;
    }

    // ========================================
    // MÉTODOS AUXILIARES PARA BÚSQUEDA DE PRENDAS
    // Usando Polo como "contenedor genérico"
    // ========================================
    
    /**
     * Buscar prenda por ID
     * NOTA: Retorna Polo como contenedor genérico, independiente del tipo real
     */
    public static Prenda buscarPrendaPorId(int idPrenda) {
    Prenda prenda = null;
    Map<Integer, Object> in = new HashMap<>();
    in.put(1, idPrenda);
    
    System.out.println("Buscando prenda por ID: " + idPrenda);

    ResultSet rs = null;
    try {
        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("obtener_prenda_X_id", in);
        
        
        if (rs != null && rs.next()) {
            prenda = new Polo();
            
            
            prenda.setIdPrenda(rs.getInt("idPrenda"));
            prenda.setNombre(rs.getString("nombre"));
            prenda.setColor(rs.getString("color"));   
            prenda.setMaterial(Material.valueOf(rs.getString("material")));
            prenda.setPrecioUnidad(rs.getDouble("precioUnidad"));
            prenda.setPrecioMayor(rs.getDouble("precioMayor"));
            prenda.setPrecioDocena(rs.getDouble("precioDocena"));
            prenda.setStockPrenda(rs.getInt("stockPrenda"));
            prenda.setAlertaMinStock(rs.getInt("alertaMinStock"));
            prenda.setActivo(rs.getBoolean("activo"));
            
            System.out.println("Prenda encontrada: " + prenda.getNombre());
        } else {
            System.out.println("No se encontró prenda con ID: " + idPrenda);
        }
    } catch (SQLException ex) {
        System.out.println("ERROR al buscar prenda por ID: " + ex.getMessage());
        ex.printStackTrace();
    } finally {
        // ✅ CERRAR DESPUÉS DE PROCESAR
        DBManager.getInstance().cerrarConexion();
    }
    
    return prenda;
}
    /**
     * Buscar prenda por atributos
     */
    public static Prenda buscarPrendaPorAtributos(String nombre, String color, String material) {
        Prenda prenda = null;
        Map<Integer, Object> in = new HashMap<>();
        
        in.put(1, nombre);
        in.put(2, color);
        in.put(3, material);

        ResultSet rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("buscar_prenda_por_atributos", in);
        
        System.out.println("Buscando prenda por: " + nombre + ", " + color + ", " + material);

        try {
            if (rs.next()) {
                prenda = new Polo(); // Contenedor genérico
                
                prenda.setIdPrenda(rs.getInt("idPrenda"));
                prenda.setNombre(rs.getString("nombre"));
                prenda.setColor(rs.getString("color"));
                prenda.setMaterial(Material.valueOf(rs.getString("material")));
                prenda.setPrecioUnidad(rs.getDouble("precioUnidad"));
                prenda.setPrecioMayor(rs.getDouble("precioMayor"));
                prenda.setPrecioDocena(rs.getDouble("precioDocena"));
                prenda.setStockPrenda(rs.getInt("stockPrenda"));
                prenda.setAlertaMinStock(rs.getInt("alertaMinStock"));
                prenda.setActivo(rs.getBoolean("activo"));
                
                System.out.println("Prenda encontrada: ID " + prenda.getIdPrenda());
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al buscar prenda: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return prenda;
    }

    public static ArrayList<String> listarNombresDistintos() {
        ArrayList<String> nombres = new ArrayList<>();
        ResultSet rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("listar_nombres_prendas_distintos", null);

        try {
            while (rs.next()) {
                nombres.add(rs.getString("nombre"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar nombres: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return nombres;
    }

    public static ArrayList<String> listarColoresDistintos() {
        ArrayList<String> colores = new ArrayList<>();
        ResultSet rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("listar_colores_prendas_distintos", null);

        try {
            while (rs.next()) {
                colores.add(rs.getString("color"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar colores: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return colores;
    }

    public static ArrayList<String> listarMaterialesDistintos() {
        ArrayList<String> materiales = new ArrayList<>();
        ResultSet rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("listar_materiales_prendas_distintos", null);

        try {
            while (rs.next()) {
                materiales.add(rs.getString("material"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar materiales: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return materiales;
    }

    @Override
    public ArrayList<PrendaLote> listarPorIDPrenda(int idPrenda) {
        ArrayList<PrendaLote> lista = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);
        
        rs = DBManager.getInstance()
                .ejecutarProcedimientoLectura("listar_prendas_X_idPrenda", in);

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                PrendaLote pl = new PrendaLote();

                pl.setIdPrendaLote(rs.getInt("idPrendaLote"));
                pl.setIdPrenda(rs.getInt("idPrenda"));
                pl.setIdLote(rs.getInt("idLote"));
                pl.setTalla(Talla.valueOf(rs.getString("talla")));
                pl.setStock(rs.getInt("stock"));
                pl.setActivo(rs.getBoolean("activo"));

                lista.add(pl);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar por idPrenda: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return lista;
        
        
        
        
        
    }
}
