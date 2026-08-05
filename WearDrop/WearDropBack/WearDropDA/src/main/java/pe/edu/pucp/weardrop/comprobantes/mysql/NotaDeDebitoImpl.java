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
import pe.edu.pucp.weardrop.comprobantes.NotaDeDebito;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeDebitoDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 * Implementación del CRUD para NotaDeDebito
 */
public class NotaDeDebitoImpl implements NotaDeDebitoDAO {
    private Connection con;// Ya no son necesarios por que solo usaré rs
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertar(NotaDeDebito notaDeDebito) {
        Map<Integer,Object> ParametrosSalida = new HashMap<>();
        Map<Integer,Object> ParametrosEntrada = new HashMap<>();
        ParametrosSalida.put(1, Types.INTEGER);
        ParametrosEntrada.put(2, new Date(notaDeDebito.getFecha().getTime()));
        ParametrosEntrada.put(3, notaDeDebito.getTotal());
        ParametrosEntrada.put(4, notaDeDebito.getIGV());
        ParametrosEntrada.put(5, notaDeDebito.getMetodoDePago());
        ParametrosEntrada.put(6, notaDeDebito.getCorrelativo());
        ParametrosEntrada.put(7, notaDeDebito.getDetalleModificacion());
        ParametrosEntrada.put(8, notaDeDebito.getRUC());
        ParametrosEntrada.put(9, notaDeDebito.getRazonSocial());
        ParametrosEntrada.put(10, notaDeDebito.getMotivoEspecifico());
        ParametrosEntrada.put(11, notaDeDebito.getNuevoMonto());
        ParametrosEntrada.put(12, notaDeDebito.getValorAumentar());
        ParametrosEntrada.put(13, notaDeDebito.getIdPrenda());
        DBManager.getInstance().ejecutarProcedimiento("insertar_nota_de_debito", ParametrosEntrada, ParametrosSalida);
        notaDeDebito.setIdComprobante((int)ParametrosSalida.get(1));
        System.out.println("Se ha realizado la inserción de la nota de debito");
        return notaDeDebito.getIdComprobante();
    }

    @Override
    public int modificar(NotaDeDebito notaDeDebito) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, notaDeDebito.getIdComprobante());
        parametrosEntrada.put(2, new Date(notaDeDebito.getFecha().getTime()));
        parametrosEntrada.put(3, notaDeDebito.getTotal());
        parametrosEntrada.put(4, notaDeDebito.getIGV());
        parametrosEntrada.put(5, notaDeDebito.getMetodoDePago());
        parametrosEntrada.put(6, notaDeDebito.getCorrelativo());
        parametrosEntrada.put(7, notaDeDebito.getDetalleModificacion());
        parametrosEntrada.put(8, notaDeDebito.getRUC());
        parametrosEntrada.put(9, notaDeDebito.getRazonSocial());
        parametrosEntrada.put(10, notaDeDebito.getMotivoEspecifico());
        parametrosEntrada.put(11, notaDeDebito.getNuevoMonto());
        parametrosEntrada.put(12, notaDeDebito.getValorAumentar());
        parametrosEntrada.put(13, notaDeDebito.getIdPrenda());
        int resultado = DBManager.getInstance().ejecutarProcedimiento
        ("modificar_nota_de_debito", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la nota de debito");
        return resultado;
    }

    @Override
    public int eliminar(int idNotaDeDebito) {
        try {
            con = DBManager.getInstance().getConnexion();
            cs = con.prepareCall("call eliminar_nota_de_debito(?)");
            cs.setInt(1, idNotaDeDebito);
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
    public NotaDeDebito obtenerPorId(int idNotaDeDebito) {
        NotaDeDebito notaDeDebito = null;
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idNotaDeDebito);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_nota_de_debito_x_id", parametrosEntrada);
        System.out.println("Lectura de Nota de debito");
        try {
            while(rs.next()){
                if(notaDeDebito == null) notaDeDebito = new NotaDeDebito();
                notaDeDebito.setIdComprobante(rs.getInt("idComprobante"));
                notaDeDebito.setFecha(rs.getDate("fecha"));
                notaDeDebito.setTotal(rs.getDouble("total"));
                notaDeDebito.setIGV(rs.getDouble("IGV"));
                notaDeDebito.setMetodoDePago(rs.getString("metodoDePago"));
                notaDeDebito.setCorrelativo(rs.getString("correlativo"));
                notaDeDebito.setDetalleModificacion(rs.getString("detalleModificacion"));
                notaDeDebito.setRUC(rs.getString("RUC"));
                notaDeDebito.setRazonSocial(rs.getString("razonSocial"));
                notaDeDebito.setMotivoEspecifico(rs.getString("motivoEspecifico"));
                notaDeDebito.setNuevoMonto(rs.getDouble("nuevoMonto"));
                notaDeDebito.setValorAumentar(rs.getDouble("valorAumentar"));
                notaDeDebito.setIdPrenda(rs.getInt("idPrenda"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return notaDeDebito;
    }

    @Override
    public ArrayList<NotaDeDebito> listarTodos() {
        ArrayList<NotaDeDebito> notasDeDebito = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_notas_de_debito_todas", null);
        System.out.println("Lectura de las notas de debito");
        try {
            while (rs.next()) {
                if(notasDeDebito == null) notasDeDebito = new ArrayList<>();
                NotaDeDebito n = new NotaDeDebito();
                n.setIdComprobante(rs.getInt("idComprobante"));
                n.setFecha(rs.getDate("fecha"));
                n.setTotal(rs.getDouble("total"));
                n.setIGV(rs.getDouble("IGV"));
                n.setMetodoDePago(rs.getString("metodoDePago"));
                n.setCorrelativo(rs.getString("correlativo"));
                n.setDetalleModificacion(rs.getString("detalleModificacion"));
                n.setRUC(rs.getString("RUC"));
                n.setRazonSocial(rs.getString("razonSocial"));
                n.setMotivoEspecifico(rs.getString("motivoEspecifico"));
                n.setNuevoMonto(rs.getDouble("nuevoMonto"));
                n.setValorAumentar(rs.getDouble("valorAumentar"));
                n.setIdPrenda(rs.getInt("idPrenda"));
                
                notasDeDebito.add(n);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return notasDeDebito;
    }
}
