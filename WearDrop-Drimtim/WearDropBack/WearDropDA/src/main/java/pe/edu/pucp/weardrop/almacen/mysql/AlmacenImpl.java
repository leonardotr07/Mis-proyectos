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
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;

/**
 *
 * @author Leonardo
 */
/*Comentario para repasar, no tiene que ver con la implementacion del CRUD de la clase:
        setChar no existe, para ello
        cs.setString(id, String.valueOf(cliente.getCampoChar()))
        
        Para Date
        cs.setDate(id, new java.sql.Date(cliente.getFecha()).getTime())
        
        Para Enums
        cs.setString(id, cliente.getCampoEnum().toString())
        */
        

public class AlmacenImpl implements AlmacenDAO {
    //Atributos
    private ResultSet rs; //Para los Selects (Cursor)
    
    
    //Nueva función en DBManager!
    @Override
    public int insertar(Almacen datAlmacen) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datAlmacen.getNombre());
        parametrosEntrada.put(3, datAlmacen.getUbicacion());
        parametrosEntrada.put(4, datAlmacen.getIdTienda());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_almacen", parametrosEntrada, parametrosSalida);
        
        //Retornamos el parametro de salida
        datAlmacen.setId((int)parametrosSalida.get(1));
        
        if(datAlmacen.getId()<=0) System.out.println("Ocurrio un error en el registro del almacen.");
        
        return datAlmacen.getId();
    }

    @Override
    public int modificar(Almacen datAlmacen) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, datAlmacen.getId());
        parametrosEntrada.put(2, datAlmacen.getNombre());
        parametrosEntrada.put(3, datAlmacen.getUbicacion());
        parametrosEntrada.put(4, datAlmacen.isActivo());
        parametrosEntrada.put(5, datAlmacen.getIdTienda());
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_almacen", parametrosEntrada, null);
        if(resultado<=0)System.out.println("Ocurrio un error en la modificacion del almacen.");
        return resultado;
    }

    @Override
    public int eliminar(int idAlmacen) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idAlmacen);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_almacen", parametrosEntrada, null);
        
        if(resultado<=0) System.out.println("Ocurrio un error al eliminar el almacen.");
        return resultado;
    }

    @Override
    public Almacen obtenerPorId(int idAlmacen) {
        Almacen datAlmacen = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idAlmacen);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_almacen_X_id", parametrosEntrada);
        
        try{
            //El profe habia puesto un while... Pero no lo veo necesario en este caso...
            //Pero es una opción también y funciona.
            if(rs.next()){
                datAlmacen=new Almacen();
                
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datAlmacen.setId(rs.getInt("idAlmacen"));
                datAlmacen.setNombre(rs.getString("nombre"));
                datAlmacen.setUbicacion(rs.getString("ubicacion"));
                datAlmacen.setIdTienda(rs.getInt("Tienda_idTienda"));
                datAlmacen.setActivo(rs.getBoolean("activo"));
                
//                System.out.println("SE OBTUVO EL ALMACEN CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR en almacen al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datAlmacen;
    }

    
    //Falta crear un método de listarTodosLosActivos
    @Override
    public ArrayList<Almacen> listarTodos() {
        ArrayList<Almacen> listaAlmacenes=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_almacenes", null);
        
        try{
            while(rs.next()){
                if(listaAlmacenes==null) listaAlmacenes=new ArrayList<>();
                Almacen datAlmacen = new Almacen();
                
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datAlmacen.setId(rs.getInt("idAlmacen"));
                datAlmacen.setNombre(rs.getString("nombre"));
                datAlmacen.setUbicacion(rs.getString("ubicacion"));
                datAlmacen.setIdTienda(rs.getInt("Tienda_idTienda"));
                datAlmacen.setActivo(rs.getBoolean("activo"));
                
                listaAlmacenes.add(datAlmacen);
            }
//            System.out.println("SE LISTO TODOS LOS ALMACENES CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todos los almacenes: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaAlmacenes;
    }    
    
    @Override
    public ArrayList<Almacen> listarActivos() {
        ArrayList<Almacen> listaAlmacenes=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_almacenes_activos", null);
        
        try{
            while(rs.next()){
                if(listaAlmacenes==null) listaAlmacenes=new ArrayList<>();
                Almacen datAlmacen = new Almacen();
                
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datAlmacen.setId(rs.getInt("idAlmacen"));
                datAlmacen.setNombre(rs.getString("nombre"));
                datAlmacen.setUbicacion(rs.getString("ubicacion"));
                datAlmacen.setIdTienda(rs.getInt("Tienda_idTienda"));
                datAlmacen.setActivo(rs.getBoolean("activo"));
                
                listaAlmacenes.add(datAlmacen);
            }
//            System.out.println("SE LISTO TODOS LOS ALMACENES ACTIVOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todos los almacenes activos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaAlmacenes;
    }    
}
