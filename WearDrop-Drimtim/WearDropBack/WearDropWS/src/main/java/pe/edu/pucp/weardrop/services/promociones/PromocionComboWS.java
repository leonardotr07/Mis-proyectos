/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.promociones;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.promocion.bo.PromocionComboBOImpl;
import pe.edu.pucp.weardrop.promocion.boi.PromocionComboBOI;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;

/**
 *
 * @author leona
 */
@WebService(serviceName = "PromocionComboWS")
public class PromocionComboWS {
    private final PromocionComboBOI boProm=new PromocionComboBOImpl();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    //Util para las grillas
    @WebMethod(operationName = "mostrar_promocionescombo")
    public List<PromocionCombo> mostrar_promocionescombo(){
        List<PromocionCombo> listaAlmacen=null;
        try{
            listaAlmacen=boProm.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
    
     //Util para las grillas
    @WebMethod(operationName = "mostrar_promocionescomboactivo")
    public List<PromocionCombo> mostrar_promocionescomboactivo(){
        List<PromocionCombo> listaAlmacen=null;
        try{
            listaAlmacen=boProm.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarPromocionCombo")
    public int insertarPromocionCombo(@WebParam(name="datProm") PromocionCombo datProm){
        int resultado=0;
        try{
            resultado=boProm.insertar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarPromocionCombo")
    public int modificarPromocionCombo(@WebParam(name="datProm") PromocionCombo datProm){
        int resultado=0;
        try{
            resultado=boProm.modificar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPromocionCombo")
    public int eliminarPromocionCombo(@WebParam(name="idProm") int idProm){
        int resultado=0;
        try{
            resultado=boProm.eliminar(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerPorIdCombo")
    public PromocionCombo obtenerPorIdCombo(@WebParam(name="idProm") int idProm){
        PromocionCombo datProm=null;
        try{
            datProm=boProm.obtenerXId(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProm;
    }
    @WebMethod(operationName = "mostrarComboXPrenda")
    public List<PromocionCombo> mostrarComboXPrenda(@WebParam(name="idPrenda") int idPrenda){
        List<PromocionCombo> listaProm=null;
        try{
            listaProm=boProm.listarComboXPrenda(idPrenda);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaProm;
    }
    @WebMethod(operationName = "insertarPrendaCombo")
    public void insertarPrendaCombo(@WebParam(name="idDesc") int idDesc, @WebParam(name="idPrendas") List<Integer> idPrendas){
        int resultado=0;
        try{
            boProm.insertarPrendaYCombo(idDesc, idPrendas);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return;
    }
}
