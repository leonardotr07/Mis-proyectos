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
import pe.edu.pucp.weardrop.comprobantes.Factura;
import pe.edu.pucp.weardrop.comprobantes.dao.FacturaDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 * Implementación del CRUD para Factura
 */
public class FacturaImpl implements FacturaDAO {

    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertar(Factura factura) {
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, new Date(factura.getFecha().getTime()));
        parametrosEntrada.put(3, factura.getTotal());
        parametrosEntrada.put(4, factura.getIGV());
        parametrosEntrada.put(5, factura.getMetodoDePago());
        parametrosEntrada.put(6, factura.getCorrelativo());
        parametrosEntrada.put(7, factura.getRUC());
        parametrosEntrada.put(8, factura.getRazonSocial());
        DBManager.getInstance().ejecutarProcedimiento("insertar_factura", parametrosEntrada, parametrosSalida);
        factura.setIdComprobante((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la factura");
        return factura.getIdComprobante();
    }

    @Override
    public int modificar(Factura factura) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, factura.getIdComprobante());
        parametrosEntrada.put(2, new Date(factura.getFecha().getTime()));
        parametrosEntrada.put(3, factura.getTotal());
        parametrosEntrada.put(4, factura.getIGV());
        parametrosEntrada.put(5, factura.getMetodoDePago());
        parametrosEntrada.put(6, factura.getCorrelativo());
        parametrosEntrada.put(7, factura.getRUC());
        parametrosEntrada.put(8, factura.getRazonSocial());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_factura", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la factura");
        return resultado;
    }

    @Override
    public int eliminar(int idFactura) {
        try {
            con = DBManager.getInstance().getConnexion();
            cs = con.prepareCall("call eliminar_factura(?)");
            cs.setInt(1, idFactura);
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
    public Factura obtenerPorId(int idFactura) {
        Factura factura = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idFactura);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_factura_x_id", parametrosEntrada);
        System.out.println("Lectura de la Factura");
        try {
            while (rs.next()) {
                if (factura == null) {
                    factura = new Factura();
                }
                factura.setIdComprobante(rs.getInt("idComprobante"));
                factura.setFecha(rs.getDate("fecha"));
                factura.setTotal(rs.getDouble("total"));  
                factura.setIGV(rs.getDouble("IGV"));  
                factura.setMetodoDePago(rs.getString("metodoDePago"));
                factura.setCorrelativo(rs.getString("correlativo"));
                factura.setRUC(rs.getString("RUC"));
                factura.setRazonSocial(rs.getString("razonSocial"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return factura;
    }

    @Override
    public ArrayList<Factura> listarTodos() {
        ArrayList<Factura> facturas = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_facturas_todas", null);
        System.out.println("Lectura de Facturas...");
        try {
            while (rs.next()) {
                if (facturas == null) {
                    facturas = new ArrayList<>();
                }
                Factura f = new Factura();
                f.setIdComprobante(rs.getInt("idComprobante"));
                f.setFecha(rs.getDate("fecha"));
                f.setTotal(rs.getDouble("total"));
                f.setIGV(rs.getDouble("IGV"));
                f.setMetodoDePago(rs.getString("metodoDePago"));
                f.setCorrelativo(rs.getString("correlativo"));
                f.setRUC(rs.getString("RUC"));
                f.setRazonSocial(rs.getString("razonSocial"));

                facturas.add(f);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return facturas;
    }
}
