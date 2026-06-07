/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.comprastienda.LineaLoteCompra;
import pe.edu.pucp.weardrop.comprastienda.dao.LineaLoteCompraDAO;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Talla;

/**
 *
 * @author matia
 */
public class LineaLoteCompraImpl  implements 
        LineaLoteCompraDAO{
    
    private ResultSet rs;
    
    
    @Override
    public ArrayList<LineaLoteCompra> listarPorIdOrdenCompra(int idOrdenCompra) {
        
        ArrayList<LineaLoteCompra> listaDeLineasCompra = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idOrdenCompra);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_Lineas_Lote_compra_X_ID_compra", 
                parametrosEntrada);
        
        System.out.println("Lectura de lineas de una orden de "
                + "compra por id de compra venta...");
        
        try{
            while(rs.next()){
                if(listaDeLineasCompra == null) 
                    listaDeLineasCompra = new ArrayList<>();
                
                LineaLoteCompra linealoteCompra =
                        new LineaLoteCompra();
                
                linealoteCompra.setIdPrenda(
                    rs.getInt("id_Prenda_linlote") );
                linealoteCompra.setNumLinea(
                    rs.getInt("num_linea_linlote"));
                linealoteCompra.setCantidad(
                    rs.getInt("cantidad_linlote"));
                String tallastr = rs.getString("talla_linlote");
                linealoteCompra.setTalla(Talla.valueOf(tallastr));
                
                Lote loteLinLot = new Lote();
                
                loteLinLot.setIdLote(
                    rs.getInt("id_lote_linlote"));
                loteLinLot.setActivo(
                    rs.getBoolean("activo_lote"));
                
                Almacen alma = new Almacen();
                
                alma.setId(
                     rs.getInt("almacen_id"));
                
                loteLinLot.setDatAlmacen(alma);
                
                linealoteCompra.setLote(loteLinLot);
                
                linealoteCompra.setPrecioLote(
                    rs.getDouble("precio_lote_linlote"));
                linealoteCompra.setActivo(
                    rs.getBoolean("activo_linlote"));
                

                listaDeLineasCompra.add(linealoteCompra);
            }
            System.out.println("Se listaron todas las "
                    + "lineas de la orden de compra"
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDeLineasCompra;
        

    }

    
    
    
    
    
    @Override
    public ArrayList<LineaLoteCompra> listarPorIdOrdenCompra_Activo(int idOrdenCompra) {
        
        
                ArrayList<LineaLoteCompra> listaDeLineasCompra = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idOrdenCompra);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_Lineas_Lote_compra_X_ID_compra_activos", 
                parametrosEntrada);
        
        System.out.println("Lectura de lineas  de una orden de "
                + "compra activas por id de compra venta...");
        
        try{
            while(rs.next()){
                if(listaDeLineasCompra == null) 
                    listaDeLineasCompra = new ArrayList<>();
                
                LineaLoteCompra linealoteCompra =
                        new LineaLoteCompra();
                
                linealoteCompra.setIdPrenda(
                    rs.getInt("id_Prenda_linlote") );
                linealoteCompra.setNumLinea(
                    rs.getInt("num_linea_linlote"));
                linealoteCompra.setCantidad(
                    rs.getInt("cantidad_linlote"));
                String tallastr = rs.getString("talla_linlote");
                linealoteCompra.setTalla(Talla.valueOf(tallastr));
                
                Lote loteLinLot = new Lote();
                
                loteLinLot.setIdLote(
                    rs.getInt("id_lote_linlote"));
                loteLinLot.setActivo(
                    rs.getBoolean("activo_lote"));
                
                Almacen alma = new Almacen();
                
                alma.setId(
                     rs.getInt("almacen_id"));
                
                loteLinLot.setDatAlmacen(alma);
                
                linealoteCompra.setLote(loteLinLot);
                
                linealoteCompra.setPrecioLote(
                    rs.getDouble("precio_lote_linlote"));
                linealoteCompra.setActivo(
                    rs.getBoolean("activo_linlote"));
                

                listaDeLineasCompra.add(linealoteCompra);
            }
            System.out.println("Se listaron todas las "
                    + "lineas de la orden de compra activas "
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDeLineasCompra;
        


    }
    
}