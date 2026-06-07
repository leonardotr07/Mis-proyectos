package pe.edu.pucp.weardrop.services.comprobantes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.Boleta;
import pe.edu.pucp.weardrop.comprobantes.bo.BoletaBOImpl;
import pe.edu.pucp.weardrop.comprobantes.boi.BoletaBOI;

/**
 * Servicio Web SOAP para gestión de Boletas Jafeth
 */
@WebService(serviceName = "BoletaWS")
public class BoletaWS {
    private final BoletaBOI boBoleta = new BoletaBOImpl();
    
    /**
     * Lista todas las boletas del sistema
     * @return Lista de boletas
     */
    
    @WebMethod(operationName = "listarTodasBoletas")
    public ArrayList<Boleta> listarTodasBoletas() {
        ArrayList<Boleta> listaBoletas = null;
        try {
            listaBoletas = boBoleta.listarTodos();
        } catch (Exception ex) {
            System.out.println("Error al listar boletas: " + ex.getMessage());
        }
        return listaBoletas;
    }
    
    /**
     * Genera una nueva boleta en el sistema
     * @param datBoleta Objeto Boleta con los datos a insertar
     * @return ID de la boleta generada, 0 si hubo error
     */
    
    @WebMethod(operationName = "insertarBoleta")
    public int insertarBoleta(@WebParam(name = "datBoleta") Boleta datBoleta) {
        int resultado = 0;
        try {
            resultado = boBoleta.insertar(datBoleta);
        } catch (Exception ex) {
            System.out.println("Error al insertar boleta: " + ex.getMessage());
        }
        return resultado;
    }
    
    /**
     * Modifica los datos de una boleta existente
     * @param datBoleta Objeto Boleta con los datos actualizados
     * @return Número de filas afectadas, 0 si hubo error
     */
    @WebMethod(operationName = "modificarBoleta")
    public int modificarBoleta(@WebParam(name = "datBoleta") Boleta datBoleta) {
        int resultado = 0;
        try {
            resultado = boBoleta.modificar(datBoleta);
        } catch (Exception ex) {
            System.out.println("Error al modificar boleta: " + ex.getMessage());
        }
        return resultado;
    }
    
    /**
     * Elimina (inactiva) una boleta del sistema
     * @param idBoleta ID de la boleta a eliminar
     * @return Número de filas afectadas, 0 si hubo error
     */
    @WebMethod(operationName = "eliminarBoleta")
    public int eliminarBoleta(@WebParam(name = "idBoleta") int idBoleta) {
        int resultado = 0;
        try {
            resultado = boBoleta.eliminar(idBoleta);
        } catch (Exception ex) {
            System.out.println("Error al eliminar boleta: " + ex.getMessage());
        }
        return resultado;
    }
    
    /**
     * Obtiene una boleta específica por su ID
     * @param idBoleta ID de la boleta a buscar
     * @return Objeto Boleta encontrado, null si no existe o hubo error
     */
    @WebMethod(operationName = "obtenerBoletaPorId")
    public Boleta obtenerBoletaPorId(@WebParam(name = "idBoleta") int idBoleta) {
        Boleta datBoleta = null;
        try {
            datBoleta = boBoleta.obtenerXId(idBoleta);
        } catch (Exception ex) {
            System.out.println("Error al obtener boleta: " + ex.getMessage());
        }
        return datBoleta;
    }
}