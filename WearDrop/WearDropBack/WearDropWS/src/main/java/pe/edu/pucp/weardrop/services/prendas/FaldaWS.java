package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Falda;
import pe.edu.pucp.weardrop.prendas.boi.FaldaBOI;
import pe.edu.pucp.weardrop.prendas.bo.FaldaBOImpl;

@WebService(serviceName = "FaldaWS")
public class FaldaWS {
    private final FaldaBOI bo = new FaldaBOImpl();

    @WebMethod(operationName = "insertarFalda")
    public int insertarFalda(@WebParam(name="falda") Falda falda){
        try { return bo.insertar(falda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarFalda")
    public int modificarFalda(@WebParam(name="falda") Falda falda){
        try { return bo.modificar(falda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarFalda")
    public int eliminarFalda(@WebParam(name="idFalda") int idFalda){
        try { return bo.eliminar(idFalda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerFaldaPorId")
    public Falda obtenerFaldaPorId(@WebParam(name="idFalda") int idFalda){
        try { return bo.obtenerXId(idFalda); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarFaldas")
    public List<Falda> listarFaldas(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarFaldas")
    public List<Falda> filtrarFaldas(){
        try { return bo.filtrarFaldas(); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

