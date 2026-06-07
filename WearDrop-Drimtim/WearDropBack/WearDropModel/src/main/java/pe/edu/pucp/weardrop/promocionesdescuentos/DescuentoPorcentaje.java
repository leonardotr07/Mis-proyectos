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
public class DescuentoPorcentaje extends Descuento{

    /**
     * @return the porcentaje
     */
    public double getPorcentaje() {
        return porcentaje;
    }
    public DescuentoPorcentaje(){}

    /**
     * @param porcentaje the porcentaje to set
     */
    public void setPorcentaje(double porcentaje) {
        this.porcentaje = porcentaje;
    }
    private double porcentaje;

    public DescuentoPorcentaje(int id,String nombre, boolean esAutomatico,Vigencia vigencia,boolean activo,double porcentaje) {
        super(id,nombre, esAutomatico,activo,vigencia);
        this.porcentaje=porcentaje;
    }
}
