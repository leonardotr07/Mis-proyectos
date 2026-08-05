/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.comprastienda;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.comprastienda.bo.ProveedorBOImpl;
import pe.edu.pucp.weardrop.comprastienda.boi.ProveedorBOI;

/**
 *
 * @author matia
 */
@WebService(serviceName = "ProveedorWS")
public class ProveedorWS {

    private final ProveedorBOI boProveedor =new ProveedorBOImpl();
    
    
   
    @WebMethod(operationName = "listarTodosLosProveedores")
    public List<Proveedor> listarTodosLosProveedores(){
        List<Proveedor> listProveedor = null;
        try{
            listProveedor=boProveedor.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listProveedor;
    }
    
    @WebMethod(operationName = "insertarProveedore")
    public int insertarProveedore(
            @WebParam(name="datProveedor") Proveedor datProveedor){
        int resultado=0;
        try{
            resultado=boProveedor.insertar(datProveedor);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
        
        
    }
    
    @WebMethod(operationName = "modificarProveedor")
    public int modificarProveedor(@WebParam(name="datProveedor") Proveedor datProveedor){
        int resultado=0;
        try{
            resultado=boProveedor.modificar(datProveedor);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarProveedor")
    public int eliminarProveedor(@WebParam(name="idProveedor") int idProveedor){
        int resultado=0;
        try{
            resultado=boProveedor.eliminar(idProveedor);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerProveedorPorID")
    public Proveedor obtenerProveedorPorID(@WebParam(name="idProveedor") int idProveedor){
        Proveedor datProvee =null;
        try{
            datProvee=boProveedor.obtenerXId(idProveedor);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProvee;
    }
    
    @WebMethod(operationName = "listarActivosSinCondiciones")
    public List<Proveedor> listarActivosSinCondiciones(){
        List<Proveedor> listProveedor = null;
        try{
            listProveedor=boProveedor.listarActivosSinCondiciones();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listProveedor;
    }
    
}
