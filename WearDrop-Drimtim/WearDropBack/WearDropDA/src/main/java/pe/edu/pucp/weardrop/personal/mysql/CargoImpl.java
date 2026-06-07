/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.dao.CargoDAO;

/**
 *
 * @author HP
 */
public class CargoImpl implements CargoDAO{
    
    private ResultSet rs;
    
    @Override
    public int insertar(Cargo cargo) {
        Map<Integer,Object> parametrosSalida = new HashMap<>();   
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, String.valueOf(cargo.getAbreviatura()));
        parametrosEntrada.put(3, cargo.getDescripcion());
        DBManager.getInstance().ejecutarProcedimiento("insertar_cargo",
	         parametrosEntrada, parametrosSalida);
        cargo.setIdCargo((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro del cargo");
        return cargo.getIdCargo();
    }

    @Override
    public int modificar(Cargo cargo) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1,cargo.getIdCargo());
        parametrosEntrada.put(2, String.valueOf(cargo.getAbreviatura()));
        parametrosEntrada.put(3, cargo.getDescripcion());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_cargo", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion del cargo");
        return resultado;
    }

    @Override
    public int eliminar(int idCargo) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCargo);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_cargo", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion del cargo");
        return resultado;
    }

    @Override
    public Cargo obtenerPorId(int idCargo) {
        Cargo cargo= null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCargo);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_cargo_X_id", parametrosEntrada);
        System.out.println("Lectura de cargo...");
        try{
            while(rs.next()){
                if(cargo == null) cargo = new Cargo();
                cargo.setIdCargo(rs.getInt("idCargo"));
                cargo.setAbreviatura(rs.getString("abreviatura").charAt(0));
                cargo.setDescripcion(rs.getString("descripcion"));
                cargo.setActivo(rs.getBoolean("activo"));
            }
        }catch(SQLException ex){
            System.out.println("Error en obtener x id en Cargo"+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return cargo;
    }

    @Override
    public ArrayList<Cargo> listarTodos() {
        ArrayList<Cargo> cargos = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_cargos", null);
        System.out.println("Lectura de todas los cargos...");
        try{
            while(rs.next()){
                if(cargos == null) cargos = new ArrayList<Cargo>();
                Cargo cargo = new Cargo();
                cargo.setIdCargo(rs.getInt("idCargo"));
                cargo.setAbreviatura(rs.getString("abreviatura").charAt(0));
                cargo.setDescripcion(rs.getString("descripcion"));
                cargo.setActivo(true);
                cargos.add(cargo);
            }
        }catch(SQLException ex){
            System.out.println("ERROR listando los cargos: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return cargos;
    }
    
}
