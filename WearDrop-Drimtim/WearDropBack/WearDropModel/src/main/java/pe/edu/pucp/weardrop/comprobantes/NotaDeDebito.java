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
public class NotaDeDebito extends ComprobanteDePago {
//    private int idNotaDeDebito;
    private String detalleModificacion;
    private String RUC;  // Cambié a RUC
    private String razonSocial;
    private String motivoEspecifico;
    private double nuevoMonto;
    private double valorAumentar;
    private int idPrenda;
    
    // Constructor por defecto
    public NotaDeDebito() {
        super();  // Llamada al constructor por defecto de la superclase (ComprobanteDePago)
//        this.idNotaDeDebito = 0;
        this.detalleModificacion = " ";
        this.RUC = " ";  // Inicialización a 0L (long)
        this.razonSocial = "";
        this.motivoEspecifico = "";
        this.nuevoMonto = 0.0;
        this.valorAumentar = 0.0;
        this.idPrenda = 0;
    }
    
    // Constructor con parámetros
    public NotaDeDebito(int idComprobante, Date fecha, double total, double IGV,
            String metodoDePago, String correlativo, ArrayList<String> arregloCorrelativo, 
                        String detalleModificacion, String RUC, String razonSocial, String motivoEspecifico, double nuevoMonto,
                        double  montoAjuste, int idPrenda) {  // Cambié a long
        super(idComprobante, fecha, total, IGV, metodoDePago, correlativo, arregloCorrelativo);
//        this.idNotaDeDebito = idNotaDeDebito;
        this.detalleModificacion = detalleModificacion;
        this.RUC = RUC;
        this.razonSocial = razonSocial;
        this.motivoEspecifico = motivoEspecifico;
        this.nuevoMonto = nuevoMonto;
        this.valorAumentar = montoAjuste;
        this.idPrenda = idPrenda;
    }

    // Constructor copia
    public NotaDeDebito(NotaDeDebito notaDeDebito) {
        super(notaDeDebito);  // Llamada al constructor de la clase base
//        this.idNotaDeDebito = notaDeDebito.idNotaDeDebito;
        this.detalleModificacion = notaDeDebito.detalleModificacion;
        this.RUC = notaDeDebito.RUC;
        this.razonSocial = notaDeDebito.razonSocial;
        this.motivoEspecifico = notaDeDebito.motivoEspecifico;
        this.nuevoMonto = notaDeDebito.nuevoMonto;
        this.valorAumentar = notaDeDebito.valorAumentar;
        this.idPrenda = notaDeDebito.idPrenda;
    }
    
    @Override
    public void imprimirDetallesComprobante() {
        System.out.println("Nota de Débito - RUC: " + RUC + ", Razon Social: " + razonSocial);
        System.out.println("Detalle Ajuste: " + detalleModificacion + ", Monto Ajuste: " + nuevoMonto);
//        super.imprimirDetallesComprobante(); // Imprimir detalles del comprobante
    }



//    public int getIdNotaDeDebito() {
//        return idNotaDeDebito;
//    }
//
//    public void setIdNotaDeDebito(int idNotaDeDebito) {
//        this.idNotaDeDebito = idNotaDeDebito;
//    }

    public String getDetalleModificacion() {
        return detalleModificacion;
    }

    public void setDetalleModificacion(String detalleModificacion) {
        this.detalleModificacion = detalleModificacion;
    }

    public String getRUC() {
        return RUC;
    }

    public void setRUC(String RUC) {
        this.RUC = RUC;
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

    public int getIdPrenda() {
        return idPrenda;
    }

    public void setIdPrenda(int idPrenda) {
        this.idPrenda = idPrenda;
    }

}