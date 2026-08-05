/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.LineaLoteCompra;
import pe.edu.pucp.weardrop.comprastienda.OrdenCompra;
import pe.edu.pucp.weardrop.comprastienda.boi.OrdenCompraBOI;
import pe.edu.pucp.weardrop.comprastienda.dao.LineaLoteCompraDAO;
import pe.edu.pucp.weardrop.comprastienda.dao.OrdenCompraDAO;
import pe.edu.pucp.weardrop.comprastienda.mysql.LineaLoteCompraImpl;
import pe.edu.pucp.weardrop.comprastienda.mysql.OrdenCompraImpl;

/**
 *
 * @author matia
 */
public class OrdenCompraBOImpl 
    implements OrdenCompraBOI{
    
    
    private final LineaLoteCompraDAO daoLineaLoteCompra;
    private final OrdenCompraDAO daoOrdenComp;
    
    
    public OrdenCompraBOImpl(){
        
        daoLineaLoteCompra = new LineaLoteCompraImpl();
        daoOrdenComp = new OrdenCompraImpl();

    }
    

    @Override
    public int insertar(OrdenCompra objeto) throws Exception {
        
        //nos aseguramos que  al insertar siempre este activo todo
        objeto.setActivo(true);
        ArrayList<LineaLoteCompra>
                listaLineaLotes = objeto.getItems();
        for( LineaLoteCompra condicion : listaLineaLotes  ){
            condicion.setActivo(true);
        }
        
        validar(objeto);
        
        //implementar un método para obtener los  subtotales de la venta 
        return daoOrdenComp.insertar(objeto);  
    }
    
    
    

    @Override
    public int modificar(OrdenCompra objeto) throws Exception {
        
        //nos aseguramos que  al insertar siempre este activo todo
        objeto.setActivo(true);
        ArrayList<LineaLoteCompra>
                listaLineaLotes = objeto.getItems();
        for( LineaLoteCompra condicion : listaLineaLotes  ){
            condicion.setActivo(true);
        }
        
        validar_modificar(objeto);
        
        //implementar un método para obtener los  subtotales de la venta 
        return daoOrdenComp.insertar(objeto);
        
        
    }
    
    

    @Override
    public int eliminar(int idObjeto) throws Exception {
        
        return daoOrdenComp.eliminar(idObjeto);
    }
    
    
    
    

    @Override
    public OrdenCompra obtenerXId(int idObjeto) throws Exception {
        
        
        OrdenCompra ordenCompraBuscado = 
                daoOrdenComp.obtenerPorId(idObjeto);
        
        ordenCompraBuscado.setItems(
        daoLineaLoteCompra.listarPorIdOrdenCompra_Activo(idObjeto));
        
 
        return ordenCompraBuscado;
        
        
    }

    @Override
    public ArrayList<OrdenCompra> listarTodos() throws Exception {
       
        ArrayList<OrdenCompra>listaOrdenCompra
                = daoOrdenComp.listarTodos();
        
        for(OrdenCompra ordComp : listaOrdenCompra){
            
            ordComp.setItems(
                daoLineaLoteCompra.listarPorIdOrdenCompra(
                ordComp.getIdCompra()));
            

        }
        
        return listaOrdenCompra;
    }

    
    
    
    
    @Override
    public void validar(OrdenCompra objeto) throws Exception {
        
        
        if(objeto.getFechaLlegada() == null){
            throw new Exception("En la orden de compra:"
                    + " El campo de fecha llegada"
                    + " esta vacío");
        }
        if(objeto.getFechaEmision()== null){
            throw new Exception("En la orden de compra:"
                    + " El campo de fecha emision"
                    + " esta vacío");
        }
        
        Double deudaPendi_val = objeto.getDeudaPendiente();
        if(deudaPendi_val == null){
            throw new Exception("En la orden de compra:"
                    + " El campo de deuda pendiente"
                    + " esta vacío");
        }
        Double montoTotal_val = objeto.getMontoTotal();
        if(montoTotal_val == null){
            throw new Exception("En la orden de compra:"
                    + " El campo de monto toal"
                    + " esta vacío");
        }
        
        Integer proveedor_ID_val = 
                objeto.getProveedor().getIdProveedor();
        if(proveedor_ID_val == null){
            throw new Exception("En la orden de compra:"
                    + " El campo de id del proveedor"
                    + " esta vacío");
        }
        
        
        Integer empleado_id_val = 
                objeto.getEmpleado().getIdEmpleado();
        if(empleado_id_val == null){
            throw new Exception("En la orden de compra:"
                    + " El campo de id del empleado"
                    + " esta vacío");
        }
        
         
        int i = 1;
        
        Integer id_prenda_val;
        Integer cant_lineaOrden_val;
        Integer id_lote_val;
        Double precioLote_val;
        
        /*
        for (LineaLoteCompra linCompra : 
                objeto.getItems()){
            
            
            id_prenda_val = linCompra.getIdPrenda();
            
            if(id_prenda_val == null){
                throw new Exception("En la linea de la orden "
                        + "de compra "
                        + "ingresada número "+i
                        + " : El id de prenda"
                                + " es nulo");
            }
            
            cant_lineaOrden_val = linCompra.getCantidad();
            
            if(cant_lineaOrden_val == null){
                throw new Exception("En la linea de la orden "
                        + "de compra "
                        + "ingresada número "+i
                        + " : El campo de cantidad"
                                + " es nulo");
            }
            
            id_lote_val = linCompra.getLote().getIdLote();
            
            if(id_lote_val == null){
                throw new Exception("En la linea de la orden "
                        + "de compra "
                        + "ingresada número "+i
                        + " : El id del lote"
                                + " es nulo");
            }
            
            precioLote_val =  linCompra.getPrecioLote();
            if(precioLote_val == null){
                throw new Exception("En la linea de la orden "
                        + "de compra "
                        + "ingresada número "+i
                        + " : El precio del lote"
                                + " es nulo");
            }
            
            i++;
        }
        */
        
        
    }

    @Override
    public void validar_modificar(OrdenCompra objeto) 
            throws Exception {
        
        Integer idOrdenCompra = objeto.getIdCompra();
        if(idOrdenCompra == null){
            throw new Exception("El orden de compra: "
                    + "El campo del idOrdenCompra esta vacío");
        }
       
        validar(objeto);        
        

    }

    @Override
    public ArrayList<OrdenCompra> listarActivos() {
        ArrayList<OrdenCompra>listaOrdenCompra
                = daoOrdenComp.listarActivos();
        
        for(OrdenCompra ordComp : listaOrdenCompra){
            
            ordComp.setItems(
                daoLineaLoteCompra.listarPorIdOrdenCompra(
                ordComp.getIdCompra()));
            

        }
        
        return listaOrdenCompra;
    }
    
   
    
}
