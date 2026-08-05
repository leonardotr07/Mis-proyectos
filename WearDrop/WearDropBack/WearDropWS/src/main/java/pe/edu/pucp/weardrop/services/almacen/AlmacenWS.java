/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.almacen;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.bo.AlmacenBOImpl;
import pe.edu.pucp.weardrop.almacen.boi.AlmacenBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "AlmacenWS")
public class AlmacenWS {
    private final AlmacenBOI boAlmacen=new AlmacenBOImpl();
    
    
    
    //Util para las grillas
    @WebMethod(operationName = "listarAlmacenesActivos")
    public List<Almacen> listarAlmacenesActivos(){
        List<Almacen> listaAlmacen=null;
        try{
            listaAlmacen=boAlmacen.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarAlmacen")
    public int insertarAlmacen(@WebParam(name="datAlmacen") Almacen datAlmacen){
        int resultado=0;
        try{
            resultado=boAlmacen.insertar(datAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarAlmacen")
    public int modificarAlmacen(@WebParam(name="datAlmacen") Almacen datAlmacen){
        int resultado=0;
        try{
            resultado=boAlmacen.modificar(datAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Eliminar el Almacen
    @WebMethod(operationName = "eliminarAlmacen")
    public int eliminarAlmacen(@WebParam(name="idAlmacen") int idAlmacen){
        int resultado=0;
        try{
            resultado=boAlmacen.eliminar(idAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerPorId")
    public Almacen obtenerPorId(@WebParam(name="idAlmacen") int idAlmacen){
        Almacen datAlmacen=null;
        try{
            datAlmacen=boAlmacen.obtenerXId(idAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datAlmacen;
    }
    
    //Agregar un método que ayude a buscar Movimientos Según el ID de un Almacen
}
