/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.vigencia;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
/**
 *
 * @author leona
 */
@WebService(serviceName = "VigenciaWS")
public class VigenciaWS {
    private final VigenciaDAO boProm=new VigenciaImpl();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    //Util para las grillas
    @WebMethod(operationName = "mostrar_vigencia")
    public List<Vigencia> mostrar_vigencia(){
        List<Vigencia> listaAlmacen=null;
        try{
            listaAlmacen=boProm.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
    
     //Util para las grillas
    @WebMethod(operationName = "mostrar_vigenciasActivas")
    public List<Vigencia> mostrar_vigenciasActivas(){
        List<Vigencia> listaAlmacen=null;
        try{
            listaAlmacen=boProm.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarVigencia")
    public int insertarVigencia(@WebParam(name="datProm") Vigencia datProm){
        int resultado=0;
        try{
            resultado=boProm.insertar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarVigencia")
    public int modificarVigencia(@WebParam(name="datProm") Vigencia datProm){
        int resultado=0;
        try{
            resultado=boProm.modificar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarVigencia")
    public int eliminarVigencia(@WebParam(name="idProm") int idProm){
        int resultado=0;
        try{
            resultado=boProm.eliminar(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerVigenciaPorId")
    public Vigencia obtenerVigenciaPorId(@WebParam(name="idProm") int idProm){
        Vigencia datProm=null;
        try{
            datProm=boProm.obtenerPorId(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProm;
    }
}
