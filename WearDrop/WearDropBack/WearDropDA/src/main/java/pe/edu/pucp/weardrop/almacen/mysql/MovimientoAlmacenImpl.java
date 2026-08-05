/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.TipoMovimiento;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacenImpl implements MovimientoAlmacenDAO {
    //Atributos
    private ResultSet rs;
    
    //Métodos de Interfaz
    @Override
    public int insertar(MovimientoAlmacen datMov) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        
        // Orden del Procedure: (OUT id, IN almacen, IN cuenta, IN fecha, IN destino, IN origen, IN tipo)
        
        // 1. idMovAlmacen (OUT)
        parametrosSalida.put(1, Types.INTEGER);
        
        // 2. Almacen_idAlmacen
        parametrosEntrada.put(2, datMov.getDatAlmacen().getId());
        
        // 3. CuentaUsuario_idCuenta
        parametrosEntrada.put(3, datMov.getDatUsuario().getIdCuenta());
        
        // 4. fecha y Hora
        java.sql.Timestamp timestamp = new java.sql.Timestamp(datMov.getFecha().getTime());
        
        parametrosEntrada.put(4, timestamp);
        
        // 5. lugarDestino
        parametrosEntrada.put(5, datMov.getLugarDestino());
        
        // 6. lugarOrigen
        parametrosEntrada.put(6, datMov.getLugarOrigen());
        
        // 7. tipo
        parametrosEntrada.put(7, datMov.getTipo().toString());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_mov_almacen", parametrosEntrada, parametrosSalida);
        
        datMov.setIdMovimiento((int)parametrosSalida.get(1)); 
        
        if(datMov.getIdMovimiento() <= 0) System.out.println("Ocurrio un error en la inserción del movimiento");
        
        return datMov.getIdMovimiento();
    }

    @Override
    public int modificar(MovimientoAlmacen datMov) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        
        // Orden del Procedure: (IN id, IN almacen, IN cuenta, IN fecha, IN destino, IN origen, IN tipo, IN activo)
        
        // 1. idMovAlmacen
        parametrosEntrada.put(1, datMov.getIdMovimiento());
        
        // 2. Almacen_idAlmacen
        parametrosEntrada.put(2, datMov.getDatAlmacen().getId());
        
        // 3. CuentaUsuario_idCuenta
        parametrosEntrada.put(3, datMov.getDatUsuario().getIdCuenta());
        
        // 4. fecha y Hora
        parametrosEntrada.put(4, new java.sql.Timestamp(datMov.getFecha().getTime()));
        
        // 5. lugarDestino
        parametrosEntrada.put(5, datMov.getLugarDestino());
        
        // 6. lugarOrigen
        parametrosEntrada.put(6, datMov.getLugarOrigen());
        
        // 7. tipo
        parametrosEntrada.put(7, datMov.getTipo().toString());
        
        // 8. activo
        parametrosEntrada.put(8, datMov.isActivo() ? 1 : 0);
        
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_mov_almacen", parametrosEntrada, null);
        
        if(resultado <= 0) System.out.println("Ocurrio un error en la modificacion de un movimiento.");
        return resultado;
    }

    @Override
    public int eliminar(int idMov) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idMov);
        
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_mov_almacen", parametrosEntrada, null);
        
        if(resultado <= 0) System.out.println("Ocurrio un error en la eliminación de un movimiento.");
        return resultado;
    }

    @Override
    public MovimientoAlmacen obtenerPorId(int idMov) {
        MovimientoAlmacen datMovAlmacen = null;
        Almacen datAlmacen = null;
        CuentaUsuario datUsuario = null;
        
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idMov);
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_mov_X_id", parametrosEntrada);
        
        try {
            if(rs.next()){
                datMovAlmacen = new MovimientoAlmacen();
                datAlmacen = new Almacen();
                datUsuario = new CuentaUsuario();
                
                // Asignación ordenada según el SELECT
                
                // 1. idMovAlmacen
                datMovAlmacen.setIdMovimiento(rs.getInt("idMovAlmacen"));
                
                // 2. Almacen_idAlmacen
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen"));
                datMovAlmacen.setDatAlmacen(datAlmacen);
                
                // 3. CuentaUsuario_idCuenta
                datUsuario.setIdCuenta(rs.getInt("CuentaUsuario_idCuenta"));
                datMovAlmacen.setDatUsuario(datUsuario);
                
                // 4. fecha y Hora
                datMovAlmacen.setFecha(rs.getTimestamp("fecha"));
                
                // 5. lugarDestino
                datMovAlmacen.setLugarDestino(rs.getString("lugarDestino"));
                
                // 6. lugarOrigen
                datMovAlmacen.setLugarOrigen(rs.getString("lugarOrigen"));
                
                // 7. tipo
                datMovAlmacen.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                
                // 8. activo
                datMovAlmacen.setActivo(rs.getBoolean("activo"));
                
//                System.out.println("SE OBTUVO EL MOVIMIENTO CORRECTAMENTE.");
            }
        } catch(SQLException ex) {
            System.out.println("ERROR al obtener por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return datMovAlmacen;
    }

    @Override
    public ArrayList<MovimientoAlmacen> listarTodos() {
        ArrayList<MovimientoAlmacen> listaMovimientos = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_almacenes", null);
        try {
            while(rs.next()){
                if(listaMovimientos == null){
                    listaMovimientos = new ArrayList<>();
                }
                MovimientoAlmacen datMov = new MovimientoAlmacen();
                Almacen datAlmacen = new Almacen();
                CuentaUsuario datUsuario = new CuentaUsuario();
                
                // Asignación ordenada según el SELECT
                
                // 1. idMovAlmacen
                datMov.setIdMovimiento(rs.getInt("idMovAlmacen"));
                
                // 2. Almacen_idAlmacen
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen"));
                datMov.setDatAlmacen(datAlmacen);
                
                // 3. CuentaUsuario_idCuenta
                datUsuario.setIdCuenta(rs.getInt("CuentaUsuario_idCuenta"));
                datMov.setDatUsuario(datUsuario);
                
                // 4. fecha y Hora
                datMov.setFecha(rs.getTimestamp("fecha"));
                
                // 5. lugarDestino
                datMov.setLugarDestino(rs.getString("lugarDestino"));
                
                // 6. lugarOrigen
                datMov.setLugarOrigen(rs.getString("lugarOrigen"));
                
                // 7. tipo
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                
                // 8. activo
                datMov.setActivo(rs.getBoolean("activo"));
                
                listaMovimientos.add(datMov);
            }
//            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS CORRECTAMENTE.");
        } catch(SQLException ex) {
            System.out.println("ERROR al listar todos los movimientos: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos;
    }
    
    @Override
    public ArrayList<MovimientoAlmacen> listarActivos() {
        ArrayList<MovimientoAlmacen> listaMovimientos = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_almacenes_activos", null);
        try {
            while(rs.next()){
                if(listaMovimientos == null){
                    listaMovimientos = new ArrayList<>();
                }
                MovimientoAlmacen datMov = new MovimientoAlmacen();
                Almacen datAlmacen = new Almacen();
                CuentaUsuario datUsuario = new CuentaUsuario();
                
                // Asignación ordenada según el SELECT
                
                // 1. idMovAlmacen
                datMov.setIdMovimiento(rs.getInt("idMovAlmacen"));
                
                // 2. Almacen_idAlmacen
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen")); 
                datMov.setDatAlmacen(datAlmacen);
                
                // 3. CuentaUsuario_idCuenta
                datUsuario.setIdCuenta(rs.getInt("CuentaUsuario_idCuenta"));
                datMov.setDatUsuario(datUsuario);
                
                // 4. fecha y Hora
                datMov.setFecha(rs.getTimestamp("fecha"));
                
                // 5. lugarDestino
                datMov.setLugarDestino(rs.getString("lugarDestino"));
                
                // 6. lugarOrigen
                datMov.setLugarOrigen(rs.getString("lugarOrigen"));
                
                // 7. tipo
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                
                // 8. activo
                datMov.setActivo(rs.getBoolean("activo"));
                
                listaMovimientos.add(datMov);
            }
//            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS ACTIVOS CORRECTAMENTE.");
        } catch(SQLException ex) {
            System.out.println("ERROR al listar todos los movimientos activos: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos;
    }
    @Override
    public ArrayList<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen) {
        ArrayList<MovimientoAlmacen> listaMovimientos = null;

        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idAlmacen);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_activo_por_almacen", parametrosEntrada);
        try {
            while(rs.next()){
                if(listaMovimientos == null){
                    listaMovimientos = new ArrayList<>();
                }
                MovimientoAlmacen datMov = new MovimientoAlmacen();
                Almacen datAlmacen = new Almacen();
                CuentaUsuario datUsuario = new CuentaUsuario();

                // 1. idMovAlmacen
                datMov.setIdMovimiento(rs.getInt("idMovAlmacen"));

                // 2. Almacen_idAlmacen y idAlmacen (del JOIN)
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen"));
                datAlmacen.setId(rs.getInt("idAlmacen")); // Nuevo campo del JOIN
                datMov.setDatAlmacen(datAlmacen);

                // 3. CuentaUsuario_idCuenta y username (del JOIN)
                datUsuario.setIdCuenta(rs.getInt("CuentaUsuario_idCuenta"));
                datUsuario.setUsername(rs.getString("username")); // Nuevo campo del JOIN
                datMov.setDatUsuario(datUsuario);

                // 4. fecha y Hora
                datMov.setFecha(rs.getTimestamp("fecha"));

                // 5. lugarDestino
                datMov.setLugarDestino(rs.getString("lugarDestino"));

                // 6. lugarOrigen
                datMov.setLugarOrigen(rs.getString("lugarOrigen"));

                // 7. tipo
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));

                // 8. activo
                datMov.setActivo(rs.getBoolean("activo"));

                listaMovimientos.add(datMov);
            }
    //            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS ACTIVOS POR ALMACEN CORRECTAMENTE.");
        } catch(SQLException ex) {
            System.out.println("ERROR al listar todos los movimientos activos por almacen: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos;
    }

}