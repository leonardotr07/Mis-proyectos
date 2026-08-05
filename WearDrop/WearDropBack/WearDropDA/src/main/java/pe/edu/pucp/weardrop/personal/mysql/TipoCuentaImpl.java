/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.TipoCuenta;
import pe.edu.pucp.weardrop.personal.dao.TipoCuentaDAO;

/**
 *
 * @author HP
 */
public class TipoCuentaImpl implements TipoCuentaDAO{
    
    private ResultSet rs;

    @Override
    public int insertar(TipoCuenta tipoCuenta) {
        Map<Integer,Object> parametrosSalida = new HashMap<>();
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, tipoCuenta.getDescripcion());
        DBManager.getInstance().ejecutarProcedimiento("insertar_tipoCuenta", parametrosEntrada, parametrosSalida);
        tipoCuenta.setIdTipoCuenta((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro del tipoCuenta");
        return tipoCuenta.getIdTipoCuenta();    
    }

    @Override
    public int modificar(TipoCuenta tipoCuenta) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, tipoCuenta.getIdTipoCuenta());
        parametrosEntrada.put(2, tipoCuenta.getDescripcion());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_tipoCuenta", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion el tipocuenta");
        return resultado;    }

    @Override
    public int eliminar(int idTipoCuenta) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idTipoCuenta);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_tipoCuenta", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion del tipo cuenta");
        return resultado;    }

    @Override
    public TipoCuenta obtenerPorId(int idTipoCuenta) {
        TipoCuenta tipoCuenta = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idTipoCuenta);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_tipoCuenta_X_id", parametrosEntrada);
        System.out.println("Lectura de tipocuenta...");
        try{
            if(rs.next()){
                tipoCuenta = new TipoCuenta();
                tipoCuenta.setIdTipoCuenta(rs.getInt("idTipoCuenta"));
                tipoCuenta.setDescripcion(rs.getString("descripcion"));
                tipoCuenta.setActivo(rs.getBoolean("activo"));
            }
        }catch(SQLException ex){
            System.out.println("ERROR tipocuenta: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return tipoCuenta;    
    }

    @Override
    public ArrayList<TipoCuenta> listarTodos() {
        ArrayList<TipoCuenta> tipoCuentas = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_tipoCuentas", null);
        System.out.println("Lectura de todas las tipocuentas...");
        try{
            while(rs.next()){
                if(tipoCuentas == null) tipoCuentas = new ArrayList<>();
                TipoCuenta tc = new TipoCuenta();
                tc.setIdTipoCuenta(rs.getInt("idTipoCuenta"));
                tc.setDescripcion(rs.getString("descripcion"));
                tc.setActivo(true);
                tipoCuentas.add(tc);
            }
        }catch(SQLException ex){
            System.out.println("ERROR listanto los tipocuentas: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return tipoCuentas;    
    }

}
