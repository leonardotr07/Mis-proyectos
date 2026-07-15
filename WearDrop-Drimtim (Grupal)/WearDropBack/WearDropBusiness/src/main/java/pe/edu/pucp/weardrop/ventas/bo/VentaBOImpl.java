/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.ventas.ItemVenta;
import pe.edu.pucp.weardrop.ventas.Venta;
import pe.edu.pucp.weardrop.ventas.boi.VentaBOI;
import pe.edu.pucp.weardrop.ventas.dao.ItemVentaDAO;
import pe.edu.pucp.weardrop.ventas.dao.VentaDAO;
import pe.edu.pucp.weardrop.ventas.mysql.ItemVentaImpl;
import pe.edu.pucp.weardrop.ventas.mysql.VentaImpl;

/**
 *
 * @author matia
 */
public class VentaBOImpl implements VentaBOI{
    
    private final VentaDAO daoVenta;
    private final ItemVentaDAO daoitemVenta;
    
    public VentaBOImpl(){
        
        daoVenta = new VentaImpl();
        daoitemVenta = new ItemVentaImpl();

    }
    
    
    

    @Override
    public int insertar(Venta objeto) throws Exception {
        
        //nos aseguuramos que  al insertar siempre se tenga un activo
        objeto.setActivo(true);
        ArrayList<ItemVenta> listaItemsVenta = objeto.getProductos();
        for( ItemVenta itemVent : listaItemsVenta  ){
            itemVent.setActivo(true);
        }
        
        validar(objeto);
        
        //implementar un método para obtener los  subtotales de la venta 
        return daoVenta.insertar(objeto);   
    }
    
    
    
    
    

    @Override
    public int modificar(Venta objeto) throws Exception {
        
        //nos aseguuramos que  al insertar siempre se tenga un activo
        objeto.setActivo(true);
        ArrayList<ItemVenta> listaItemsVenta = new ArrayList<>();
        
        if(objeto.getProductos() != null   ){
            listaItemsVenta = objeto.getProductos();
            for( ItemVenta itemVent : listaItemsVenta  ){
            itemVent.setActivo(true);
            }
            
        }
        objeto.setProductos(listaItemsVenta);
                
        
        validar_modificar(objeto);
        
        //implementar un método para obtener los  subtotales de la venta 
        return daoVenta.modificar(objeto);  
    }
    
    
    
    
    
    
    
    

    @Override
    public int eliminar(int idObjeto) throws Exception {
        
        return daoVenta.eliminar(idObjeto);
    }
    
    
    
    
    
    
    
    
    
//obtener ID 
    @Override
    public Venta obtenerXId(int idObjeto) throws Exception {
 
        Venta ventaBuscada = daoVenta.obtenerPorId(idObjeto);
        ArrayList<ItemVenta> listaItems =  daoitemVenta.listarPorIdVenta_Activo(idObjeto);
        
        if(listaItems != null){
            ventaBuscada.setProductos(listaItems);
        }
        else{
            ventaBuscada.setProductos(new ArrayList<>());
        }
        
        
        return ventaBuscada;
    }
    
    
    public Venta obtenerXId_conItemsInactivos(int idObjeto) throws Exception{
        
        Venta ventaBuscada = daoVenta.obtenerPorId(idObjeto);
        ventaBuscada.setProductos(daoitemVenta.listarPorIdVenta(idObjeto));
        
        return ventaBuscada;
    }
    
    
    
    

    @Override
    public ArrayList<Venta> listarTodos() throws Exception {
        
        ArrayList<Venta>listaVentas  = daoVenta.listarTodos();
        for(Venta vent : listaVentas){
            vent.setProductos(daoitemVenta.listarPorIdVenta(vent.getIdVenta()));
        }
        
        return listaVentas;
        
    }

    
    public ArrayList<Venta> listarTodos_Activo_conItemActivo() throws Exception{

        ArrayList<Venta>listaVentas  = daoVenta.lista_ventas_activas();
        for(Venta vent : listaVentas){
            
            
            ArrayList<ItemVenta> items = daoitemVenta.listarPorIdVenta_Activo(vent.getIdVenta());
            if(items == null){
                items = new ArrayList<>();
            }
            
            vent.setProductos(items);
            
        }
        
        return listaVentas;
        
        
    }
    
    
    
    
    
    
    
    @Override
    public void validar(Venta objeto) throws Exception {
        
        if(objeto.getFecha() == null){
            throw new Exception("En la venta: El campo de fecha esta vacío");
        }
        
        Double total = objeto.getTotal();
        
        if(total == null){
            throw new Exception("En la venta: El campo del total esta vacío");
        }
        if(objeto.getTotal()<0){
            throw new Exception("En la venta: El campo del"
                    + " total esta es menor que 0.00");
        }
        
        Integer idComprobante = objeto.getIdComprobante();
        if(idComprobante == null){
            throw new Exception("En la venta: El campo del id comprobante es nulo");
        }
        
        Boolean activoVenta = objeto.isActivo();
        if(activoVenta == null){
            throw new Exception("En la venta: El campo del activo es nulo");
        }
        
        Integer idCliente = objeto.getCliente().getIdCliente();
        if( idCliente == null){
            throw new Exception("En la venta: El campo del id del cliente es nulo");
        }
        
        Integer idempleado = objeto.getEmpleado().getIdEmpleado();
        
        if(idempleado == null){
            throw new Exception("En la venta: El campo del id del empleado es nulo");
        }
        
        ArrayList<ItemVenta> listaItemsVenta = objeto.getProductos();
        
        //validamos cada uno de los items
        int i = 1;
        Integer idPrendaItem;
        Integer cantidadItem;
        Double subtotalItem;
        Boolean activoItem;
        
        for( ItemVenta itemVent : listaItemsVenta  ){
            idPrendaItem = itemVent.getIdPrenda();
            if(idPrendaItem == null){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo del id de la prenda es nulo");
            }
            
            cantidadItem = itemVent.getCantidad();
            if(idPrendaItem == null){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo de la cantidad de prendas es nulo");
            }
            if(itemVent.getCantidad() <= 0){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo de la cantidad de prendas es menor igual a 0");
            }
            
            subtotalItem = itemVent.getSubtotal();
            if(subtotalItem == null){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo del subtotal es nulo");
            }
            if(itemVent.getSubtotal()<0){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo del subtotal es menor que  0");
            }
            
            activoItem = itemVent.isActivo();
            
            if(activoItem == null){
                throw new Exception("En el item ingresado número "+i
                        + " : El campo que indica el activo es nulo");
            }
            
            i++;
   
        }

    }
    
    
    
    public void validar_modificar (Venta objeto) throws Exception{
        
        Integer idVenta = objeto.getIdVenta();
        if(idVenta == null){
            throw new Exception("En la venta: El campo de idVenta esta vacío");
        }
       
        validar(objeto);        
                
    }
    
    
    
    
    
    
    
    
}
