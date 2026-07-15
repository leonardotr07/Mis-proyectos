/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocionesdescuentos;

import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;

/**
 *
 * @author leona
 */
public  class DescuentoMonto extends Descuento{

    /**
     * @return the montoEditable
     */
    public double getMontoEditable() {
        return montoEditable;
    }

    /**
     * @param montoEditable the montoEditable to set
     */
    public void setMontoEditable(double montoEditable) {
        this.montoEditable = montoEditable;
    }

    /**
     * @return the montoMaximo
     */
    public double getMontoMaximo() {
        return montoMaximo;
    }

    /**
     * @param montoMaximo the montoMaximo to set
     */
    public void setMontoMaximo(double montoMaximo) {
        this.montoMaximo = montoMaximo;
    }
   
    private double montoEditable;
    private double montoMaximo;
    
    public DescuentoMonto(){}
    public DescuentoMonto(int id,String nombre, boolean esAutomatico,boolean activo,double montoEditable,double montoMaximo,Vigencia vigencia) {
        super(id,nombre,esAutomatico,activo,vigencia);
        this.montoEditable=montoEditable;
        this.montoMaximo=montoMaximo;
    }
    
    
    
    
}
