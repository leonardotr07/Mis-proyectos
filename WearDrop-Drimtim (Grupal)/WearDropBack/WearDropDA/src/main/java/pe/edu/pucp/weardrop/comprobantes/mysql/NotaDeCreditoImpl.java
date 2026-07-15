/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprobantes.NotaDeCredito;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeCreditoDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 * Implementación del CRUD para NotaDeCredito
 */
public class NotaDeCreditoImpl implements NotaDeCreditoDAO {
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertar(NotaDeCredito notaDeCredito) {
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, new Date(notaDeCredito.getFecha().getTime()));
        parametrosEntrada.put(3, notaDeCredito.getTotal());
        parametrosEntrada.put(4, notaDeCredito.getIGV());
        parametrosEntrada.put(5, notaDeCredito.getMetodoDePago());
        parametrosEntrada.put(6, notaDeCredito.getCorrelativo());
        parametrosEntrada.put(7, notaDeCredito.getDetalleModificacion());
        parametrosEntrada.put(8, notaDeCredito.getRUC());
        parametrosEntrada.put(9, notaDeCredito.getRazonSocial());
        parametrosEntrada.put(10, notaDeCredito.getDNI());
        parametrosEntrada.put(11, notaDeCredito.getMotivoEspecifico());
        parametrosEntrada.put(12, notaDeCredito.getNuevoMonto());
        parametrosEntrada.put(13, notaDeCredito.getValorAumentar());    
        DBManager.getInstance().ejecutarProcedimiento("insertar_nota_de_credito", 
                parametrosEntrada, parametrosSalida);
        notaDeCredito.setIdComprobante((int) parametrosSalida.get(1));
//        System.out.println("Se ha registrado la nota de credito");
        return notaDeCredito.getIdComprobante();

    }

    @Override
    public int modificar(NotaDeCredito notaDeCredito) {
          Map<Integer,Object> parametrosEntrada = new HashMap<>();
          parametrosEntrada.put(1, notaDeCredito.getIdComprobante());
          parametrosEntrada.put(2, new Date(notaDeCredito.getFecha().getTime()));
          parametrosEntrada.put(3, notaDeCredito.getTotal());
          parametrosEntrada.put(4, notaDeCredito.getIGV());
          parametrosEntrada.put(5, notaDeCredito.getMetodoDePago());
          parametrosEntrada.put(6, notaDeCredito.getCorrelativo());
          parametrosEntrada.put(7, notaDeCredito.getDetalleModificacion());
          parametrosEntrada.put(8, notaDeCredito.getRUC());
          parametrosEntrada.put(9, notaDeCredito.getRazonSocial());
          parametrosEntrada.put(10, notaDeCredito.getDNI());
          parametrosEntrada.put(11, notaDeCredito.getMotivoEspecifico());
          parametrosEntrada.put(12, notaDeCredito.getNuevoMonto());
          parametrosEntrada.put(13, notaDeCredito.getValorAumentar());    
          int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_nota_de_credito",parametrosEntrada, null);
//          System.out.println("Se ha realizado la modificacion de la notaDeCredito");
          return resultado;
    }

    @Override
    public int eliminar(int idNotaDeCredito) {
        try {
            con = DBManager.getInstance().getConnexion();
            cs = con.prepareCall("call eliminar_nota_de_credito(?)");
            cs.setInt(1, idNotaDeCredito);
            int resultado = cs.executeUpdate();
            return resultado;
        } catch (SQLException ex) {
            System.out.println("ERROR al eliminar: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return 0;
    }

    @Override
    public NotaDeCredito obtenerPorId(int idNotaDeCredito) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idNotaDeCredito);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_nota_de_credito_x_id", parametrosEntrada);
//        System.out.println("Lectura de la Nota de Credito");
        NotaDeCredito notaDeCredito = null;
        try{
            while(rs.next()){
                if(notaDeCredito==null) notaDeCredito = new NotaDeCredito();
                notaDeCredito.setIdComprobante(rs.getInt("idComprobante"));
                notaDeCredito.setFecha(rs.getDate("fecha"));
                notaDeCredito.setTotal(rs.getDouble("total"));
                notaDeCredito.setIGV(rs.getDouble("IGV"));
                notaDeCredito.setMetodoDePago(rs.getString("metodoDePago"));
                notaDeCredito.setCorrelativo(rs.getString("correlativo"));
                notaDeCredito.setDetalleModificacion(rs.getString("detalleModificacion"));
                notaDeCredito.setRUC(rs.getString("RUC"));
                notaDeCredito.setRazonSocial(rs.getString("razonSocial"));
                notaDeCredito.setDNI(rs.getString("DNI"));
                notaDeCredito.setMotivoEspecifico(rs.getString("motivoEspecifico"));
                notaDeCredito.setNuevoMonto(rs.getDouble("nuevoMonto"));
                notaDeCredito.setValorAumentar(rs.getDouble("valorAumentar"));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();;
        }
        return notaDeCredito;

    }

    @Override
    public ArrayList<NotaDeCredito> listarTodos() {
        ArrayList<NotaDeCredito> notasDeCredito = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_notas_de_credito_todas", null);
//        System.out.println("Lectura de Notas de Credito");
        try {
            while (rs.next()) {
                if(notasDeCredito==null) notasDeCredito = new ArrayList<>();
                NotaDeCredito notaDeCredito = new NotaDeCredito();
                notaDeCredito.setIdComprobante(rs.getInt("idComprobante"));
                notaDeCredito.setFecha(rs.getDate("fecha"));
                notaDeCredito.setTotal(rs.getDouble("total"));
                notaDeCredito.setTotal(rs.getDouble("IGV"));
                notaDeCredito.setMetodoDePago(rs.getString("metodoDePago"));
                notaDeCredito.setCorrelativo(rs.getString("correlativo"));
                notaDeCredito.setDetalleModificacion(rs.getString("detalleModificacion"));
                notaDeCredito.setRUC(rs.getString("RUC"));
                notaDeCredito.setRazonSocial(rs.getString("razonSocial"));
                notaDeCredito.setDNI(rs.getString("DNI"));
                notaDeCredito.setMotivoEspecifico(rs.getString("motivoEspecifico"));
                notaDeCredito.setNuevoMonto(rs.getDouble("nuevoMonto"));
                notaDeCredito.setValorAumentar(rs.getDouble("valorAumentar"));
                notasDeCredito.add(notaDeCredito);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return notasDeCredito;
    }
}