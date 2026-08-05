/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author JAFETH
 */
public class Boleta extends ComprobanteDePago {
//    private int idNotaDeDebito;
    private String DNI;
    
    //Constructor por defecto
    public Boleta() {
        this.DNI = "";
    }

    // Constructor con parámetros
    public Boleta(int idComprobante, Date fecha, double total, double IGV, String metodoDePago, 
            String correlativo, ArrayList<String> arregloCorrelativo, String DNI) {
        super(idComprobante, fecha, total, IGV, metodoDePago, correlativo, arregloCorrelativo);
//        this.idNotaDeDebito = idNotaDeDebito;
        this.DNI = DNI;  // Asignar el valor de DNI correctamente
    }
    //Constructor copia
    public Boleta(Boleta boleta) {
        super(boleta);  // Llamada al constructor de la clase base
        this.DNI = boleta.DNI;
    }

    @Override
    public void imprimirDetallesComprobante() {
        System.out.println("Boleta - DNI: " + DNI);
        System.out.println(" ");
        System.out.println("Comprobante de Pago - ID Venta: " + getIdComprobante() +
                ", Fecha: " + getFecha() + ", Total: " + getTotal() + ", IGV: " + getIGV() +
                ", Método de pago: " + getMetodoDePago() + ", Correlativo: " + getCorrelativo());
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }
    
    
}
