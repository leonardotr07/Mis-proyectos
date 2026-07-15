package pe.edu.pucp.weardrop.comprobantes;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author JAFETH
 */
public class Factura extends ComprobanteDePago{
//    private int idFactura;
    private String RUC;  // Cambié a long
    private String razonSocial;
    
    // Constructor por defecto
    public Factura() {
        super();  // Llamada al constructor por defecto de la superclase
        this.razonSocial = "";
        this.RUC = " ";  
    }
    
    // Constructor con parámetros
    public Factura(int idComprobante, Date fecha, double total, double IGV, String metodoDePago, String correlativo, 
            ArrayList<String> arregloCorrelativo,
                   String RUC, String razonSocial) {  // Cambié a long
        super(idComprobante, fecha, total, IGV, metodoDePago, correlativo, arregloCorrelativo);
//        this.idFactura = idFactura;
        this.RUC = RUC;  // Asignar el valor del parámetro RUC a la variable de instancia
        this.razonSocial = razonSocial;  // Asignar el valor del parámetro razonSocial a la variable de instancia
    }
    
    // Constructor copia
    public Factura(Factura factura) {
        super(factura);  // Llamada al constructor de la clase base
//        this.idFactura = factura.idFactura;
        this.RUC = factura.RUC;
        this.razonSocial = factura.razonSocial;
    }
    
    @Override
    public void imprimirDetallesComprobante() {
        System.out.println("Factura - RUC: " + RUC + ", Razon Social: " + razonSocial);
//        super.imprimirDetallesComprobante(); // Imprimir detalles del comprobante
    }




    /**
     * @return the razonSocial
     */
    public String getRazonSocial() {
        return razonSocial;
    }

    /**
     * @param razonSocial the razonSocial to set
     */
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getRUC() {
        return RUC;
    }

    public void setRUC(String RUC) {
        this.RUC = RUC;
    }

//    public int getIdFactura() {
//        return idFactura;
//    }
//
//    public void setIdFactura(int idFactura) {
//        this.idFactura = idFactura;
//    }
}
