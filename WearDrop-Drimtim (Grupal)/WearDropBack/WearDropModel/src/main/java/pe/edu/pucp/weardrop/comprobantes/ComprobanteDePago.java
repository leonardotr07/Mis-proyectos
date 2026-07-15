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
public abstract class ComprobanteDePago {

    private int idComprobante;
    private Date fecha;
    private double total;
    private double IGV;
    private String metodoDePago;
    private String correlativo;
    private boolean activa;
    private ArrayList<String> arregloCorrelativo;
    
    // Constructor por defecto
    public ComprobanteDePago() {
        this.idComprobante = 0;
        this.fecha = new Date();  // Fecha actual
        this.total = 0.0;
        this.IGV = 0.0;
        this.metodoDePago = "";
        this.correlativo = "";
        this.arregloCorrelativo = new ArrayList<>();
//        this.activa = true;
    }
    
    // Constructor Con parametros
    public ComprobanteDePago(int idVenta, Date fecha, double total, double IGV,
            String metodoDePago, String correlativo, ArrayList<String> arregloDatosDelCorrelativo) {
        this.idComprobante = idVenta;
        this.fecha = fecha;
        this.total = total;
        this.IGV = IGV;
        this.metodoDePago = metodoDePago;
        this.correlativo = correlativo;
        this.arregloCorrelativo = arregloDatosDelCorrelativo;
//        this.activa = activa;
    }

    // Constructor copia
    public ComprobanteDePago(ComprobanteDePago comprobanteDePago) {
        this.idComprobante = comprobanteDePago.idComprobante;
        this.fecha = comprobanteDePago.fecha;
        this.total = comprobanteDePago.total;
        this.IGV = comprobanteDePago.IGV;
        this.metodoDePago = comprobanteDePago.metodoDePago;
        this.correlativo = comprobanteDePago.correlativo;
        this.arregloCorrelativo = comprobanteDePago.arregloCorrelativo;
//        this.activa = comprobanteDePago.activa;
    }
    
    
    public abstract void imprimirDetallesComprobante();

    public void asignarCorrelativo(String correlativo) {
        this.correlativo = correlativo;
    }
    
        public int getIdComprobante() {
        return idComprobante;
    }

    public void setIdComprobante(int idComprobante) {
        this.idComprobante = idComprobante;
    }

    public Date getFecha() {
        return fecha;
    }

    public double getTotal() {
        return total;
    }

    public double getIGV() {
        return IGV;
    }

    public String getMetodoDePago() {
        return metodoDePago;
    }

    public String getCorrelativo() {
        return correlativo;
    }



    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setIGV(double IGV) {
        this.IGV = IGV;
    }

    public void setMetodoDePago(String metodoDePago) {
        this.metodoDePago = metodoDePago;
    }

    public void setCorrelativo(String correlativo) {
        this.correlativo = correlativo;
    }

    public ArrayList<String> getArregloCorrelativo() {
        return arregloCorrelativo;
    }

    public void setArregloCorrelativo(ArrayList<String> arregloCorrelativo) {
        this.arregloCorrelativo = arregloCorrelativo;
    }

    public boolean isActiva() {
        return activa;
    }

    public void setActiva(boolean activa) {
        this.activa = activa;
    }
}
