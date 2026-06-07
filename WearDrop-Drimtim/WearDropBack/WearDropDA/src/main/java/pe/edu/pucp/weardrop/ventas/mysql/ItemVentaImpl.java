/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.ventas.ItemVenta;
import pe.edu.pucp.weardrop.ventas.dao.ItemVentaDAO;

/**
 *
 * @author matia
 */
public class ItemVentaImpl implements ItemVentaDAO{
   
    /*
    item venta
    private int numLinea;
    private int idPrenda;
    private int cantidad;
    //list descuentos
    private ArrayList<Descuento> descuentos;
    //list promocion
    private ArrayList<Promocion> promociones;
    private double subtotal;
    private boolean activo;
    
    */
    
    private ResultSet rs;

    @Override
    public ArrayList<ItemVenta> listarPorIdVenta(int idVenta) {
       
        ArrayList<ItemVenta> listaDeItemsVenta = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idVenta);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_items_venta_X_ID_venta", parametrosEntrada);
        
        System.out.println("Lectura de items de una venta "
                + "por id orden de venta...");
        
        try{
            while(rs.next()){
                if(listaDeItemsVenta == null) listaDeItemsVenta = new ArrayList<>();
                ItemVenta itemVent = new ItemVenta();
                
               
                itemVent.setNumLinea( rs.getInt("numero_linea"));
                
                //aca necesito cambiar el int por un objeto prenda
                itemVent.setIdPrenda(rs.getInt("prendaID"));
                
                //Falta como vas a manejr las promociones
                
                
                itemVent.setCantidad(rs.getInt("cantidad_item"));
                itemVent.setSubtotal(rs.getDouble("subtotal_item"));
                itemVent.setActivo(rs.getBoolean("estado_Item"));
                
                
                String tallastr = rs.getString("talla_Item");
                itemVent.setTalla(Talla.valueOf(tallastr));
                
                listaDeItemsVenta.add(itemVent);
            }
            System.out.println("Se listaron todas los "
                    + "items de venta correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDeItemsVenta;
        
    }

    @Override
    public ArrayList<ItemVenta> listarPorIdVenta_Activo(int idVenta) {
        
        ArrayList<ItemVenta> listaDeItemsVenta = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idVenta);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_items_venta_X_ID_venta_activos", parametrosEntrada);
        
        System.out.println("Lectura de items activos de una venta "
                + "por id orden de venta ...");
        
        try{
            while(rs.next()){
                if(listaDeItemsVenta == null) listaDeItemsVenta = new ArrayList<>();
                ItemVenta itemVent = new ItemVenta();
                
                //falta agregar lo correspondiente a la venta
                
                itemVent.setNumLinea( rs.getInt("numero_linea"));
                
                //aca necesito cambiar el int por un objeto prenda
               itemVent.setIdPrenda(rs.getInt("prendaID"));
                
                //Falta como vas a manejr las promociones
                
                
                itemVent.setCantidad(rs.getInt("cantidad_item"));
                itemVent.setSubtotal(rs.getDouble("subtotal_item"));
                itemVent.setActivo(rs.getBoolean("estado_Item"));
                String tallastr = rs.getString("talla_Item");
                itemVent.setTalla(Talla.valueOf(tallastr));
                
                listaDeItemsVenta.add(itemVent);
            }
            System.out.println("Se listaron todas los "
                    + "items de venta activos correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDeItemsVenta;
        

    }
    
    
    
    
    
    
}