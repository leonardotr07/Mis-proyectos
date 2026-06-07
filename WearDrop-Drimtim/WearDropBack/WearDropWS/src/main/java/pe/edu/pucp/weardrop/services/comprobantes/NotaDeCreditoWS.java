package pe.edu.pucp.weardrop.services.comprobantes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.NotaDeCredito;
import pe.edu.pucp.weardrop.comprobantes.bo.NotaDeCreditoBOImpl;
import pe.edu.pucp.weardrop.comprobantes.boi.NotaDeCreditoBOI;

@WebService(serviceName = "NotaDeCreditoWS")
public class NotaDeCreditoWS {
    private final NotaDeCreditoBOI boNotaCredito = new NotaDeCreditoBOImpl();
    
    @WebMethod(operationName = "listarTodasNotasCredito")
    public ArrayList<NotaDeCredito> listarTodasNotasCredito() { 
        ArrayList<NotaDeCredito> listaNotaDeCredito = null;
        try {
            listaNotaDeCredito = boNotaCredito.listarTodos();
        } catch (Exception ex) {
            System.out.println("Error al listar NotaDeCredito: " + ex.getMessage());
        }
        return listaNotaDeCredito;
    }
    
    @WebMethod(operationName = "insertarNotaCredito")
    public int insertarNotaCredito(@WebParam(name = "datNotaCredito") NotaDeCredito datNotaCredito) { 
        int resultado = 0;
        try {
            resultado = boNotaCredito.insertar(datNotaCredito);
        } catch (Exception ex) {
            System.out.println("Error al insertar NotaDeCredito: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarNotaCredito")
    public int modificarNotaCredito(@WebParam(name = "datNotaCredito") NotaDeCredito datNotaCredito) {
        int resultado = 0;
        try {
            resultado = boNotaCredito.modificar(datNotaCredito);
        } catch (Exception ex) {
            System.out.println("Error al modificar NotaDeCredito: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarNotaCredito")
    public int eliminarNotaCredito(@WebParam(name = "idNotaCredito") int idNotaCredito) { 
        int resultado = 0;
        try {
            resultado = boNotaCredito.eliminar(idNotaCredito);
        } catch (Exception ex) {
            System.out.println("Error al eliminar Factura: " + ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerNotaCreditoPorId")
    public NotaDeCredito obtenerNotaCreditoPorId(@WebParam(name = "idNotaCredito") int idNotaCredito) { 
        NotaDeCredito datFactura = null;
        try {
            datFactura = boNotaCredito.obtenerXId(idNotaCredito);
        } catch (Exception ex) {
            System.out.println("Error al obtener boleta: " + ex.getMessage());
        }
        return datFactura;
    }
}