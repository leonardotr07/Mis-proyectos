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
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.TipoVestido;
import pe.edu.pucp.weardrop.prendas.Vestido;
import pe.edu.pucp.weardrop.prendas.dao.VestidoDAO;

public class VestidoImpl implements VestidoDAO {

    private ResultSet rs; // Para SELECTs (cursor)

    @Override
    public int insertar(Vestido datVestido) {
        Map<Integer, Object> in  = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();

        // salida (id)
        out.put(1, Types.INTEGER);

        // entrada (respetar orden del SP)
        in.put(2,  datVestido.getNombre());
        in.put(3,  datVestido.getPrecioUnidad());
        in.put(4,  datVestido.getPrecioMayor());
        in.put(5,  datVestido.getPrecioDocena());
        in.put(6,  datVestido.getAlertaMinStock());
        in.put(7,  datVestido.getColor());
        in.put(8,  datVestido.getMaterial().name());      // enum Material
        in.put(9,  datVestido.getTipoVestido().name());   // enum TipoVestido
        in.put(10, datVestido.getTipoManga().name());     // enum TipoManga
        in.put(11, datVestido.getLargo());         // int

        DBManager.getInstance().ejecutarProcedimiento("insertar_vestido", in, out);

        datVestido.setIdPrenda((int) out.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Vestido");
        return datVestido.getIdPrenda();
    }

    @Override
    public int modificar(Vestido datVestido) {
        Map<Integer, Object> in = new HashMap<>();

        in.put(1,  datVestido.getIdPrenda());
        in.put(2,  datVestido.getNombre());
        in.put(3,  datVestido.getPrecioUnidad());
        in.put(4,  datVestido.getPrecioMayor());
        in.put(5,  datVestido.getPrecioDocena());
        in.put(6,  datVestido.getAlertaMinStock());
        in.put(7,  datVestido.getColor());
        in.put(8,  datVestido.getMaterial().name());
        in.put(9,  datVestido.getTipoVestido().name());
        in.put(10, datVestido.getTipoManga().name());
        in.put(11, datVestido.getLargo());

        int res = DBManager.getInstance().ejecutarProcedimiento("modificar_vestido", in, null);
        System.out.println("Se ha realizado la modificación de la Prenda Vestido");
        return res;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        int res = DBManager.getInstance().ejecutarProcedimiento("eliminar_vestido", in, null);
        System.out.println("Se ha desvinculado o eliminado el vestido.");
        return res;
    }

    @Override
    public Vestido obtenerPorId(int idPrenda) {
        Vestido datVestido = null;

        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_vestido_X_id", in);
        System.out.println("Lectura de Prenda Vestido...");

        try {
            if (rs.next()) {
                datVestido = new Vestido();

                datVestido.setIdPrenda(rs.getInt("idPrenda"));
                datVestido.setNombre(rs.getString("nombre"));
                datVestido.setStockPrenda(rs.getInt("stockPrenda"));
                datVestido.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datVestido.setColor(rs.getString("color"));
                datVestido.setMaterial(Material.valueOf(rs.getString("material")));
                datVestido.setTipoVestido(TipoVestido.valueOf(rs.getString("tipo_vestido")));
                datVestido.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                datVestido.setLargo(rs.getInt("largo"));
          
                datVestido.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datVestido.setPrecioMayor(rs.getDouble("precioMayor"));
                datVestido.setPrecioDocena(rs.getDouble("precioDocena"));

                System.out.println("SE OBTUVO LA PRENDA VESTIDO CORRECTAMENTE.");
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return datVestido;
    }

    @Override
    public ArrayList<Vestido> listarTodos() {
        ArrayList<Vestido> lista = null;

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_vestidos", null);
        System.out.println("Lectura de prendas vestido...");

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                Vestido v = new Vestido();

                v.setIdPrenda(rs.getInt("idPrenda"));
                v.setNombre(rs.getString("nombre"));
                v.setStockPrenda(rs.getInt("stockPrenda"));
                v.setAlertaMinStock(rs.getInt("alertaMinStock"));
                v.setColor(rs.getString("color"));
                v.setMaterial(Material.valueOf(rs.getString("material")));
                v.setTipoVestido(TipoVestido.valueOf(rs.getString("tipo_vestido")));
                v.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                v.setLargo(rs.getInt("largo"));
                v.setActivo(rs.getBoolean("activo"));
                v.setPrecioUnidad(rs.getDouble("precioUnidad"));
                v.setPrecioMayor(rs.getDouble("precioMayor"));
                v.setPrecioDocena(rs.getDouble("precioDocena"));
                v.setStockPrenda(rs.getInt("total_vendida"));
                lista.add(v);
            }
            System.out.println("SE LISTÓ TODAS LAS PRENDAS VESTIDO CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al listar todas las prendas vestido: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return lista;
    }
    
    @Override
public ArrayList<Vestido> filtrarVestidos() {
    ArrayList<Vestido> listaVestido = null;
    rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_vestido", null);
    System.out.println("Lectura de prendas vestido (filtrar_vestido)...");

    try {
        while (rs.next()) {
            if (listaVestido == null) listaVestido = new ArrayList<>();
            Vestido datVestido = new Vestido();

            datVestido.setIdPrenda(rs.getInt("idPrenda"));
            datVestido.setNombre(rs.getString("nombre"));
            datVestido.setStockPrenda(rs.getInt("total_vendida"));
            datVestido.setAlertaMinStock(rs.getInt("alertaMinStock"));
            datVestido.setColor(rs.getString("color"));

            datVestido.setMaterial(Material.valueOf(rs.getString("material")));
            datVestido.setTipoVestido(TipoVestido.valueOf(rs.getString("tipo_vestido")));
            datVestido.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
            datVestido.setLargo(rs.getInt("largo"));

            datVestido.setActivo(rs.getBoolean("activo"));
            datVestido.setPrecioUnidad(rs.getDouble("precioUnidad"));
            datVestido.setPrecioMayor(rs.getDouble("precioMayor"));
            datVestido.setPrecioDocena(rs.getDouble("precioDocena"));

            listaVestido.add(datVestido);
        }
        System.out.println("SE LISTARON LOS VESTIDOS ORDENADOS CORRECTAMENTE.");
    } catch (SQLException ex) {
        System.out.println("ERROR al filtrar prendas vestido: " + ex.getMessage());
    } finally {
        DBManager.getInstance().cerrarConexion();
    }
    return listaVestido;
}


}

