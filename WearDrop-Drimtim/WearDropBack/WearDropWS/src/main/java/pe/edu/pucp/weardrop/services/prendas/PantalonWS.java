package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Pantalon;
import pe.edu.pucp.weardrop.prendas.boi.PantalonBOI;
import pe.edu.pucp.weardrop.prendas.bo.PantalonBOImpl;

@WebService(serviceName = "PantalonWS")
public class PantalonWS {
    private final PantalonBOI bo = new PantalonBOImpl();

    @WebMethod(operationName = "insertarPantalon")
    public int insertarPantalon(@WebParam(name="pantalon") Pantalon pantalon){
        try { return bo.insertar(pantalon); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarPantalon")
    public int modificarPantalon(@WebParam(name="pantalon") Pantalon pantalon){
        try { return bo.modificar(pantalon); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarPantalon")
    public int eliminarPantalon(@WebParam(name="idPantalon") int idPantalon){
        try { return bo.eliminar(idPantalon); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerPantalonPorId")
    public Pantalon obtenerPantalonPorId(@WebParam(name="idPantalon") int idPantalon){
        try { return bo.obtenerXId(idPantalon); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarPantalones")
    public List<Pantalon> listarPantalones(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarPantalones")
    public List<Pantalon> filtrarPantalones(){
        try { return bo.filtrarPantalones(); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

