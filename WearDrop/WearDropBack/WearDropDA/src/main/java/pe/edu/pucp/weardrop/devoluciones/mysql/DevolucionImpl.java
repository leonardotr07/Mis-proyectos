/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.devoluciones.Devolucion;
import pe.edu.pucp.weardrop.devoluciones.dao.DevolucionDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;


public class DevolucionImpl implements DevolucionDAO {

    private ResultSet rs;

    @Override
    public int insertar(Devolucion objeto) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida = new HashMap<>();

        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, objeto.getDescripcion());
        parametrosEntrada.put(3, objeto.getIdEmpleado());
        parametrosEntrada.put(4, objeto.getIdProveedor());
        parametrosEntrada.put(5, objeto.getMonto());
        parametrosEntrada.put(6, objeto.getCantidad());
        parametrosEntrada.put(7, objeto.getIdPrenda());
        parametrosEntrada.put(8, objeto.getTalla() != null ? objeto.getTalla().name() : null);

        DBManager.getInstance().ejecutarProcedimiento(
                "insertar_devolucion",
                parametrosEntrada,
                parametrosSalida
        );

        objeto.setId((int) parametrosSalida.get(1));
        objeto.setActivo(true);

        if (objeto.getId() > 0) {
            System.out.println("Se insertó la devolución de forma correcta.");
        } else {
            System.out.println("Ocurrió un error en el registro de la devolución.");
        }

        return objeto.getId();
    }

    @Override
    public int modificar(Devolucion objeto) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, objeto.getId());
        parametrosEntrada.put(2, objeto.getDescripcion());
        parametrosEntrada.put(3, objeto.getIdEmpleado());
        parametrosEntrada.put(4, objeto.getIdProveedor());
        parametrosEntrada.put(5, objeto.getMonto());
        parametrosEntrada.put(6, objeto.getCantidad());
        parametrosEntrada.put(7, objeto.getIdPrenda());
        parametrosEntrada.put(8, objeto.getTalla() != null ? objeto.getTalla().name() : null);

        int resultado = DBManager.getInstance().ejecutarProcedimiento(
                "modificar_devolucion",
                parametrosEntrada,
                null
        );

        if (resultado > 0) {
            System.out.println("Se ha modificado la devolución.");
        } else {
            System.out.println("Ocurrió un error en la modificación de la devolución.");
        }

        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idObjeto);

        int resultado = DBManager.getInstance().ejecutarProcedimiento(
                "eliminar_devolucion",
                parametrosEntrada,
                null
        );

        if (resultado > 0) {
            System.out.println("Se ha eliminado la devolución (borrado lógico).");
        } else {
            System.out.println("Ocurrió un error al eliminar la devolución.");
        }

        return resultado;
    }

    @Override
    public Devolucion obtenerPorId(int idObjeto) {
        Devolucion devolucion = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idObjeto);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "obtenerdevolucion_X_id",
                parametrosEntrada
        );

        try {
            if (rs.next()) {
                devolucion = new Devolucion();
                devolucion.setId(rs.getInt("idDevolucion"));
                devolucion.setDescripcion(rs.getString("descripcion"));
                devolucion.setIdEmpleado(rs.getInt("idEmpleado"));
                devolucion.setIdProveedor(rs.getInt("idProveedor"));
                devolucion.setMonto(rs.getDouble("monto"));
                devolucion.setCantidad(rs.getInt("cantidad"));
                devolucion.setIdPrenda(rs.getInt("idPrenda"));
                String tallaStr = rs.getString("talla");
                
                Proveedor prov = new Proveedor();
                prov.setIdProveedor(devolucion.getIdProveedor());
                prov.setNombre(rs.getString("nombreProveedor"));
                devolucion.setProveedor(prov);

            
                devolucion.setNombrePrenda(rs.getString("nombrePrenda"));
                
                
                if (tallaStr != null) {
                    devolucion.setTalla(Talla.valueOf(tallaStr));
                }
                devolucion.setFecha(rs.getDate("fecha"));
                devolucion.setActivo(rs.getBoolean("activo"));
                System.out.println("Se obtuvo un resultado en la búsqueda de la devolución.");
            } else {
                System.out.println("No se obtuvo ningún resultado en la búsqueda de la devolución.");
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al buscar por ID una Devolución: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return devolucion;
    }

    @Override
    
public ArrayList<Devolucion> listarTodos() {
    ArrayList<Devolucion> listaDevoluciones = null;
    rs = DBManager.getInstance().ejecutarProcedimientoLectura(
            "mostrar_devoluciones",
            null
    );
    System.out.println("Lectura de devoluciones activas...");
    int i = 0;

    try {
        while (rs.next()) {
            if (listaDevoluciones == null) listaDevoluciones = new ArrayList<>();
            Devolucion dev = new Devolucion();

            dev.setId(rs.getInt("idDevolucion"));
            dev.setDescripcion(rs.getString("descripcion"));
            dev.setIdEmpleado(rs.getInt("idEmpleado"));
            dev.setIdProveedor(rs.getInt("idProveedor"));
            dev.setIdPrenda(rs.getInt("idPrenda"));
            dev.setMonto(rs.getDouble("monto"));
            dev.setCantidad(rs.getInt("cantidad"));

            String tallaStr = rs.getString("talla");
            if (tallaStr != null) dev.setTalla(Talla.valueOf(tallaStr));

            dev.setFecha(rs.getDate("fecha"));
            dev.setActivo(rs.getBoolean("activo"));

            Proveedor prov = new Proveedor();
            prov.setIdProveedor(dev.getIdProveedor());
            prov.setNombre(rs.getString("nombreProveedor"));
            dev.setProveedor(prov);

            
            dev.setNombrePrenda(rs.getString("nombrePrenda"));

            listaDevoluciones.add(dev);
            i++;
        }
        if (i > 0) {
            System.out.println("Se obtuvo por lo menos un resultado en la búsqueda de devoluciones activas.");
        } else {
            System.out.println("No se obtuvo ningún resultado en la búsqueda de devoluciones activas.");
        }
        System.out.println("Se listaron las devoluciones activas correctamente.");
    } catch (SQLException ex) {
        System.out.println("ERROR al listar todas las devoluciones activas: " + ex.getMessage());
    } finally {
        DBManager.getInstance().cerrarConexion();
    }

    return listaDevoluciones;
}


    @Override
    public ArrayList<Devolucion> listarPorIdProveedor(int idProveedor) {
        ArrayList<Devolucion> listaDevoluciones = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idProveedor);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "listar_devoluciones_x_id_proveedor",
                parametrosEntrada
        );

        System.out.println("Lectura de devoluciones activas por proveedor...");

        try {
            while (rs.next()) {
                if (listaDevoluciones == null) listaDevoluciones = new ArrayList<>();
                Devolucion dev = new Devolucion();
                dev.setId(rs.getInt("idDevolucion"));
                dev.setDescripcion(rs.getString("descripcion"));
                dev.setIdEmpleado(rs.getInt("idEmpleado"));
                dev.setIdProveedor(rs.getInt("idProveedor"));
                dev.setMonto(rs.getDouble("monto"));
                dev.setCantidad(rs.getInt("cantidad"));
                dev.setIdPrenda(rs.getInt("idPrenda"));
                String tallaStr = rs.getString("talla");
                if (tallaStr != null) {
                    dev.setTalla(Talla.valueOf(tallaStr));
                }
                dev.setFecha(rs.getDate("fecha"));
                dev.setActivo(rs.getBoolean("activo"));
                listaDevoluciones.add(dev);
            }
            System.out.println("Se listaron todas las devoluciones activas por proveedor correctamente.");
        } catch (SQLException ex) {
            System.out.println("ERROR al listar devoluciones activas por proveedor: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return listaDevoluciones;
    }
}
