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
public class NotaDeCredito extends ComprobanteDePago {
//    private int idNotaDeCredito;
    private String detalleModificacion;
    private String RUC;  // Cambié a String
    private String razonSocial;
    private String DNI;
    private String motivoEspecifico;
    private double nuevoMonto;
    private double valorAumentar;
    
    // Constructor por defecto
    public NotaDeCredito() {
        super();  // Llamada al constructor por defecto de la superclase
//        this.idNotaDeCredito = 0;
        this.detalleModificacion = "";
        this.RUC = "";  // Inicialización a 0L (long)
        this.razonSocial = "";
        this.DNI = "";
        this.motivoEspecifico = "";
        this.nuevoMonto = 0.0;
        this.valorAumentar = 0.0;
    }
    
    // Constructor con parámetros
    public NotaDeCredito(String detalleModificacion, String RUC, String razonSocial, 
            String DNI, String motivoEspecifico, double nuevoMonto, double valorAumentar, 
            int idComprobante, Date fecha, double total, double IGV, String metodoDePago,
            String correlativo, ArrayList<String> arregloCorrelativo) {
        
        super(idComprobante, fecha, total, IGV, metodoDePago, correlativo, arregloCorrelativo);
        this.detalleModificacion = detalleModificacion;
        this.RUC = RUC;  // Asignar el valor del parámetro RUC a la variable de instancia
        this.razonSocial = razonSocial;
        this.DNI = DNI;
        this.motivoEspecifico = motivoEspecifico;
        this.nuevoMonto = nuevoMonto;
        this.valorAumentar = valorAumentar;
//        this.idNotaDeCredito = idNotaDeCredito;
    }
    
    // Constructor copia
    public NotaDeCredito(NotaDeCredito notaDeCredito) {
        super(notaDeCredito);  // Llamada al constructor de la clase base
        this.detalleModificacion = notaDeCredito.detalleModificacion;
        this.RUC = notaDeCredito.RUC;
        this.razonSocial = notaDeCredito.razonSocial;
        this.DNI = notaDeCredito.DNI;
        this.motivoEspecifico = notaDeCredito.motivoEspecifico;
        this.nuevoMonto = notaDeCredito.nuevoMonto;
        this.valorAumentar = notaDeCredito.valorAumentar;
//        this.idNotaDeCredito = notaDeCredito.idNotaDeCredito;
    }

    @Override
    public void imprimirDetallesComprobante() {
        System.out.println("Nota de Crédito - RUC: " + RUC + ", Razon Social: " + razonSocial);
//        super.imprimirDetallesComprobante(); // Imprimir detalles del comprobante
    }

    public String getDetalleModificacion() {
        return detalleModificacion;
    }

    public void setDetalleModificacion(String detalleModificacion) {
        this.detalleModificacion = detalleModificacion;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getMotivoEspecifico() {
        return motivoEspecifico;
    }

    public void setMotivoEspecifico(String motivoEspecifico) {
        this.motivoEspecifico = motivoEspecifico;
    }

    public double getNuevoMonto() {
        return nuevoMonto;
    }

    public void setNuevoMonto(double nuevoMonto) {
        this.nuevoMonto = nuevoMonto;
    }

    public double getValorAumentar() {
        return valorAumentar;
    }

    public void setValorAumentar(double valorAumentar) {
        this.valorAumentar = valorAumentar;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public String getRUC() {
        return RUC;
    }

    public void setRUC(String RUC) {
        this.RUC = RUC;
    }

//    public int getIdNotaDeCredito() {
//        return idNotaDeCredito;
//    }
//
//    public void setIdNotaDeCredito(int idNotaDeCredito) {
//        this.idNotaDeCredito = idNotaDeCredito;
//    }
}