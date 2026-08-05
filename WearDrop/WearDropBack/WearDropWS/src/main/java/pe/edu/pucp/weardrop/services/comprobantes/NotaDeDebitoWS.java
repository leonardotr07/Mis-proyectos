package pe.edu.pucp.weardrop.services.comprobantes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.NotaDeDebito;
import pe.edu.pucp.weardrop.comprobantes.bo.NotaDeDebitoBOImpl;
import pe.edu.pucp.weardrop.comprobantes.boi.NotaDeDebitoBOI;


@WebService(serviceName = "NotaDeDebitoWS")
public class NotaDeDebitoWS {
    private final NotaDeDebitoBOI boNotaDeDebito = new NotaDeDebitoBOImpl();
    
    @WebMethod(operationName = "listarTodasNotasDebito")
    public ArrayList<NotaDeDebito> listarTodasNotasDebito() { 
            ArrayList<NotaDeDebito> listaNotaDeDebito = null;
        try {
            listaNotaDeDebito = boNotaDeDebito.listarTodos();
        } catch (Exception ex) {
            System.out.println("Error al listar NotaDeDebito: " + ex.getMessage());
        }
        return listaNotaDeDebito;
    }
    
    @WebMethod(operationName = "insertarNotaDebito")
    public int insertarNotaDebito(@WebParam(name = "datNotaDebito") NotaDeDebito datNotaDebito) { 
        int resultado = 0;
        try {
            resultado = boNotaDeDebito.insertar(datNotaDebito);
        } catch (Exception ex) {
            System.out.println("Error al insertar NotaDeDebito: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarNotaDebito")
    public int modificarNotaDebito(@WebParam(name = "datNotaDebito") NotaDeDebito datNotaDebito) { 
        int resultado = 0;
        try {
            resultado = boNotaDeDebito.modificar(datNotaDebito);
        } catch (Exception ex) {
            System.out.println("Error al modificar NotaDeDebito: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarNotaDebito")
    public int eliminarNotaDebito(@WebParam(name = "idNotaDebito") int idNotaDebito) { 
        int resultado = 0;
        try {
            resultado = boNotaDeDebito.eliminar(idNotaDebito);
        } catch (Exception ex) {
            System.out.println("Error al eliminar NotaDeDebito: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerNotaDebitoPorId")
    public NotaDeDebito obtenerNotaDebitoPorId(@WebParam(name = "idNotaDebito") int idNotaDebito) {
        NotaDeDebito datNotaDeDebito = null;
        try {
            datNotaDeDebito = boNotaDeDebito.obtenerXId(idNotaDebito);
        } catch (Exception ex) {
            System.out.println("Error al obtener boleta: " + ex.getMessage());
        }
        return datNotaDeDebito;
    }
}