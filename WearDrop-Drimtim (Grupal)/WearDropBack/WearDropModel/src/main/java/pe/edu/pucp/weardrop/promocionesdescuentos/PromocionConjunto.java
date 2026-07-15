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
public class PromocionConjunto extends Promocion{

    public PromocionConjunto(int id,String nombre, boolean automatico,boolean activo,double porcentajePromocion,Vigencia vigencia) {
        super(id,nombre,automatico,activo,vigencia);
        this.porcentajePromocion=porcentajePromocion;
    }
    public PromocionConjunto(){
    }
    /**
     * @return the porcentajePromocion
     */
    public double getPorcentajePromocion() {
        return porcentajePromocion;
    }

    /**
     * @param porcentajePromocion the porcentajePromocion to set
     */
    public void setPorcentajePromocion(double porcentajePromocion) {
        this.porcentajePromocion = porcentajePromocion;
    }
    
    
    private double porcentajePromocion;
}
