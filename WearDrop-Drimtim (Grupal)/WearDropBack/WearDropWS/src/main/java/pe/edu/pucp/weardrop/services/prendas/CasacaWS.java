package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Casaca;
import pe.edu.pucp.weardrop.prendas.boi.CasacaBOI;
import pe.edu.pucp.weardrop.prendas.bo.CasacaBOImpl;

@WebService(serviceName = "CasacaWS")
public class CasacaWS {
    private final CasacaBOI bo = new CasacaBOImpl();

    @WebMethod(operationName = "insertarCasaca")
    public int insertarCasaca(@WebParam(name="casaca") Casaca casaca){
        try { return bo.insertar(casaca); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarCasaca")
    public int modificarCasaca(@WebParam(name="casaca") Casaca casaca){
        try { return bo.modificar(casaca); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarCasaca")
    public int eliminarCasaca(@WebParam(name="idCasaca") int idCasaca){
        try { return bo.eliminar(idCasaca); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerCasacaPorId")
    public Casaca obtenerCasacaPorId(@WebParam(name="idCasaca") int idCasaca){
        try { return bo.obtenerXId(idCasaca); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarCasacas")
    public List<Casaca> listarCasacas(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarCasacas")
    public List<Casaca> filtrarCasacas(){
        try { return bo.filtrarCasacas(); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}
