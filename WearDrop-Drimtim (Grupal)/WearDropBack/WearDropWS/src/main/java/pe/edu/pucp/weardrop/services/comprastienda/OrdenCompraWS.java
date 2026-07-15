/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.comprastienda;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.OrdenCompra;
import pe.edu.pucp.weardrop.comprastienda.bo.OrdenCompraBOImpl;
import pe.edu.pucp.weardrop.comprastienda.boi.OrdenCompraBOI;

/**
 *
 * @author matia
 */
@WebService(serviceName = "OrdenCompraWS")
public class OrdenCompraWS {
    
    private final OrdenCompraBOI boOrdenCompra =new OrdenCompraBOImpl();
    
    @WebMethod(operationName = "listarTodasLasOrdenesDeCompra")
    public ArrayList<OrdenCompra> listarTodasLasOrdenesDeCompra(){
        ArrayList<OrdenCompra> listOrdenCompra = null;
        try{
            listOrdenCompra=boOrdenCompra.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listOrdenCompra;
    }
    
    
    @WebMethod(operationName = "insertarOrdenDeCompra")
    public int insertarOrdenDeCompra(
            @WebParam(name="datOrdenCompra") OrdenCompra datOrdenCompra){
        int resultado=0;
        try{
            resultado=boOrdenCompra.insertar(datOrdenCompra);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
        
        
    }
    
    @WebMethod(operationName = "modificarOrdeneDeCompra")
    public int modificarOrdeneDeCompra(@WebParam(name="datOrdenCompra") OrdenCompra datOrdenCompra){
        int resultado=0;
        try{
            resultado=boOrdenCompra.modificar(datOrdenCompra);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarOrdenDeCompra")
    public int eliminarOrdenDeCompra(@WebParam(name="idOrdenCompra") int idOrdenCompra){
        int resultado=0;
        try{
            resultado=boOrdenCompra.eliminar(idOrdenCompra);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerOrdenDeCompraPorID")
    public OrdenCompra obtenerOrdenDeCompraPorID(@WebParam(name="idOrdenCompra") int idOrdenCompra){
        OrdenCompra datProvee =null;
        try{
            datProvee=boOrdenCompra.obtenerXId(idOrdenCompra);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProvee;
    }
    
    
    
    
}
