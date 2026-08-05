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
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.Pantalon;
import pe.edu.pucp.weardrop.prendas.TipoPantalon;
import pe.edu.pucp.weardrop.prendas.dao.PantalonDAO;

public class PantalonImpl implements PantalonDAO {

    private ResultSet rs; // Para SELECTs (Cursor)

    @Override
    public int insertar(Pantalon datPantalon) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();

        // parámetro de salida (id)
        out.put(1, Types.INTEGER);

        // parámetros de entrada (respetar orden del SP)
        in.put(2,  datPantalon.getNombre());
        in.put(3,  datPantalon.getPrecioUnidad());
        in.put(4,  datPantalon.getPrecioMayor());
        in.put(5,  datPantalon.getPrecioDocena());
        in.put(6,  datPantalon.getAlertaMinStock());
        in.put(7,  datPantalon.getColor());
        in.put(8,  datPantalon.getMaterial().name());        // enum Material
        in.put(9,  datPantalon.getTipoPantalon().name());    // enum TipoPantalon
        in.put(10, datPantalon.getLargoPierna());     // double
        in.put(11, datPantalon.getCintura());         // double
        in.put(12, datPantalon.isElasticidad());      // boolean

        DBManager.getInstance().ejecutarProcedimiento("insertar_pantalon", in, out);

        datPantalon.setIdPrenda((int) out.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Pantalón");
        return datPantalon.getIdPrenda();
    }

    @Override
    public int modificar(Pantalon datPantalon) {
        Map<Integer, Object> in = new HashMap<>();

        in.put(1,  datPantalon.getIdPrenda());
        in.put(2,  datPantalon.getNombre());
        in.put(3,  datPantalon.getPrecioUnidad());
        in.put(4,  datPantalon.getPrecioMayor());
        in.put(5,  datPantalon.getPrecioDocena());
        in.put(6,  datPantalon.getAlertaMinStock());
        in.put(7,  datPantalon.getColor());
        in.put(8,  datPantalon.getMaterial().name());
        in.put(9,  datPantalon.getTipoPantalon().name());
        in.put(10, datPantalon.getLargoPierna());
        in.put(11, datPantalon.getCintura());
        in.put(12, datPantalon.isElasticidad());

        int res = DBManager.getInstance().ejecutarProcedimiento("modificar_pantalon", in, null);
        System.out.println("Se ha realizado la modificación de la Prenda Pantalón");
        return res;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        int res = DBManager.getInstance().ejecutarProcedimiento("eliminar_pantalon", in, null);
        System.out.println("Se ha desvinculado o eliminado el pantalón.");
        return res;
    }

    @Override
    public Pantalon obtenerPorId(int idPrenda) {
        Pantalon datPantalon = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_pantalon_X_id", in);
        System.out.println("Lectura de Prenda Pantalón...");

        try {
            if (rs.next()) {
                datPantalon = new Pantalon();

                datPantalon.setIdPrenda(rs.getInt("idPrenda"));
                datPantalon.setNombre(rs.getString("nombre"));
                datPantalon.setStockPrenda(rs.getInt("stockPrenda"));
                datPantalon.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datPantalon.setColor(rs.getString("color"));
                datPantalon.setMaterial(Material.valueOf(rs.getString("material")));
                datPantalon.setTipoPantalon(TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                datPantalon.setLargoPierna(rs.getDouble("largo_pierna"));
                datPantalon.setCintura(rs.getDouble("cintura"));
                datPantalon.setElasticidad(rs.getBoolean("elasticidad"));
                
                datPantalon.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datPantalon.setPrecioMayor(rs.getDouble("precioMayor"));
                datPantalon.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA PANTALÓN CORRECTAMENTE.");
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return datPantalon;
    }

    @Override
    public ArrayList<Pantalon> listarTodos() {
        ArrayList<Pantalon> lista = null;

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_pantalones", null);
        System.out.println("Lectura de prendas pantalón...");

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                Pantalon p = new Pantalon();

                p.setIdPrenda(rs.getInt("idPrenda"));
                p.setNombre(rs.getString("nombre"));
                p.setStockPrenda(rs.getInt("stockPrenda"));
                p.setAlertaMinStock(rs.getInt("alertaMinStock"));
                p.setColor(rs.getString("color"));
                p.setMaterial(Material.valueOf(rs.getString("material")));
                p.setTipoPantalon(TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                p.setLargoPierna(rs.getDouble("largo_pierna"));
                p.setCintura(rs.getDouble("cintura"));
                p.setElasticidad(rs.getBoolean("elasticidad"));
                p.setActivo(rs.getBoolean("activo"));
                p.setPrecioUnidad(rs.getDouble("precioUnidad"));
                p.setPrecioMayor(rs.getDouble("precioMayor"));
                p.setPrecioDocena(rs.getDouble("precioDocena"));
                p.setStockPrenda(rs.getInt("total_vendida"));
                lista.add(p);
            }
            System.out.println("SE LISTÓ TODAS LAS PRENDAS PANTALÓN CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al listar todas las prendas pantalón: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return lista;
    }
    
    @Override
    public ArrayList<Pantalon> filtrarPantalones() {
        ArrayList<Pantalon> listaPantalon = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_pantalon", null);
        System.out.println("Lectura de prendas pantalón (filtrar_pantalon)...");

        try {
            while (rs.next()) {
                if (listaPantalon == null) {
                    listaPantalon = new ArrayList<>();
                }
                Pantalon datPantalon = new Pantalon();

                datPantalon.setIdPrenda(rs.getInt("idPrenda"));
                datPantalon.setNombre(rs.getString("nombre"));
                datPantalon.setStockPrenda(rs.getInt("total_vendida"));
                datPantalon.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datPantalon.setColor(rs.getString("color"));

                datPantalon.setMaterial(Material.valueOf(rs.getString("material")));
                datPantalon.setTipoPantalon(TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                datPantalon.setLargoPierna(rs.getDouble("largoPierna"));
                datPantalon.setCintura(rs.getDouble("cintura"));

                datPantalon.setActivo(rs.getBoolean("activo"));
                datPantalon.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datPantalon.setPrecioMayor(rs.getDouble("precioMayor"));
                datPantalon.setPrecioDocena(rs.getDouble("precioDocena"));

                listaPantalon.add(datPantalon);
            }
            System.out.println("SE LISTARON LOS PANTALONES ORDENADOS CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al filtrar prendas pantalón: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return listaPantalon;
    }

    
}

