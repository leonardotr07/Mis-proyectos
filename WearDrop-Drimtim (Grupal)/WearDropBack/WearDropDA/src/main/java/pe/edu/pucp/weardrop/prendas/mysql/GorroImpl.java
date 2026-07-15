/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Gorro;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoGorra;
import pe.edu.pucp.weardrop.prendas.dao.GorroDAO;

public class GorroImpl implements GorroDAO {

    private ResultSet rs; // Para SELECTs (Cursor)

    @Override
    public int insertar(Gorro datGorro) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida  = new HashMap<>();

        // salida
        parametrosSalida.put(1, Types.INTEGER);

        // entrada (mismo orden que el SP)
        parametrosEntrada.put(2,  datGorro.getNombre());
        parametrosEntrada.put(3,  datGorro.getPrecioUnidad());
        parametrosEntrada.put(4,  datGorro.getPrecioMayor());
        parametrosEntrada.put(5,  datGorro.getPrecioDocena());
        parametrosEntrada.put(6,  datGorro.getAlertaMinStock());
        parametrosEntrada.put(7,  datGorro.getColor());
        parametrosEntrada.put(8,  datGorro.getMaterial().name());         // enum Material
        parametrosEntrada.put(9,  datGorro.getTipoGorra().name());        // enum TipoGorra
        parametrosEntrada.put(10, datGorro.isTallaAjustable());    // boolean
        parametrosEntrada.put(11, datGorro.isImpermeable());       // boolean

        DBManager.getInstance().ejecutarProcedimiento("insertar_gorro", parametrosEntrada, parametrosSalida);

        datGorro.setIdPrenda((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Gorro");
        return datGorro.getIdPrenda();
    }

    @Override
    public int modificar(Gorro datGorro) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1,  datGorro.getIdPrenda());
        parametrosEntrada.put(2,  datGorro.getNombre());
        parametrosEntrada.put(3,  datGorro.getPrecioUnidad());
        parametrosEntrada.put(4,  datGorro.getPrecioMayor());
        parametrosEntrada.put(5,  datGorro.getPrecioDocena());
        parametrosEntrada.put(6,  datGorro.getAlertaMinStock());
        parametrosEntrada.put(7,  datGorro.getColor());
        parametrosEntrada.put(8,  datGorro.getMaterial().name());
        parametrosEntrada.put(9,  datGorro.getTipoGorra().name());
        parametrosEntrada.put(10, datGorro.isTallaAjustable());
        parametrosEntrada.put(11, datGorro.isImpermeable());

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_gorro", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la Prenda Gorro");
        return resultado;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idPrenda);

        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_gorro", parametrosEntrada, null);
        System.out.println("Se ha desvinculado o eliminado el gorro.");
        return resultado;
    }

    @Override
    public Gorro obtenerPorId(int idPrenda) {
        Gorro datGorro = null;

        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idPrenda);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_gorro_X_id", parametrosEntrada);
        System.out.println("Lectura de Prenda Gorro...");

        try {
            if (rs.next()) {
                datGorro = new Gorro();

                datGorro.setIdPrenda(rs.getInt("idPrenda"));
                datGorro.setNombre(rs.getString("nombre"));
                datGorro.setStockPrenda(rs.getInt("stockPrenda"));
                datGorro.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datGorro.setColor(rs.getString("color"));
                datGorro.setMaterial(Material.valueOf(rs.getString("material")));
                datGorro.setTipoGorra(TipoGorra.valueOf(rs.getString("tipo_gorra")));
                datGorro.setTallaAjustable(rs.getBoolean("talla_ajustable"));
                datGorro.setImpermeable(rs.getBoolean("impermeable"));
     
                datGorro.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datGorro.setPrecioMayor(rs.getDouble("precioMayor"));
                datGorro.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA GORRO CORRECTAMENTE.");
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return datGorro;
    }

    @Override
    public ArrayList<Gorro> listarTodos() {
        ArrayList<Gorro> listaGorro = null;

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_gorros", null);
        System.out.println("Lectura de prendas gorro...");

        try {
            while (rs.next()) {
                if (listaGorro == null) listaGorro = new ArrayList<>();
                Gorro datGorro = new Gorro();

                datGorro.setIdPrenda(rs.getInt("idPrenda"));
                datGorro.setNombre(rs.getString("nombre"));
                datGorro.setStockPrenda(rs.getInt("stockPrenda"));
                datGorro.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datGorro.setColor(rs.getString("color"));
                datGorro.setMaterial(Material.valueOf(rs.getString("material")));
                datGorro.setTipoGorra(TipoGorra.valueOf(rs.getString("tipo_gorra")));
                datGorro.setTallaAjustable(rs.getBoolean("talla_ajustable"));
                datGorro.setImpermeable(rs.getBoolean("impermeable"));
                datGorro.setActivo(rs.getBoolean("activo"));
                datGorro.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datGorro.setPrecioMayor(rs.getDouble("precioMayor"));
                datGorro.setPrecioDocena(rs.getDouble("precioDocena"));
                datGorro.setStockPrenda(rs.getInt("total_vendida"));
                listaGorro.add(datGorro);
            }
            System.out.println("SE LISTÓ TODAS LAS PRENDAS GORRO CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al listar todas las prendas gorro: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return listaGorro;
    }
    
    @Override
    public ArrayList<Gorro> filtrarGorros() {
        ArrayList<Gorro> listaGorro = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_gorro", null);
        System.out.println("Lectura de prendas gorro (filtrar_gorro)...");

        try {
            while (rs.next()) {
                if (listaGorro == null) {
                    listaGorro = new ArrayList<>();
                }
                Gorro datGorro = new Gorro();

                datGorro.setIdPrenda(rs.getInt("idPrenda"));
                datGorro.setNombre(rs.getString("nombre"));
                datGorro.setStockPrenda(rs.getInt("total_vendida"));
                datGorro.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datGorro.setColor(rs.getString("color"));

                datGorro.setMaterial(Material.valueOf(rs.getString("material")));
                datGorro.setTipoGorra(TipoGorra.valueOf(rs.getString("tipo_gorra")));
                datGorro.setTallaAjustable(rs.getBoolean("tallaAjustable"));
                datGorro.setImpermeable(rs.getBoolean("impermeable"));

                datGorro.setActivo(rs.getBoolean("activo"));
                datGorro.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datGorro.setPrecioMayor(rs.getDouble("precioMayor"));
                datGorro.setPrecioDocena(rs.getDouble("precioDocena"));

                listaGorro.add(datGorro);
            }
            System.out.println("SE LISTARON LOS GORROS ORDENADOS CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al filtrar prendas gorro: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return listaGorro;
    }


    
    
    
}

