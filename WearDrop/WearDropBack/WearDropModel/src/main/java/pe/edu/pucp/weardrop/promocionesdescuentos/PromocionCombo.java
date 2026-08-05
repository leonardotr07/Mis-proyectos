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
public class PromocionCombo extends Promocion{

    public PromocionCombo(int id,String nombre, boolean automatico,boolean activo,int cantidadRequerida,int cantidadGratis,Vigencia vigencia) {
        super(id,nombre, automatico,activo,vigencia);
        this.cantidadRequerida=cantidadRequerida;
        this.cantidadGratis=cantidadGratis;
    }
    public PromocionCombo(){}
    /**
     * @return the cantidadRequerida
     */
    public int getCantidadRequerida() {
        return cantidadRequerida;
    }

    /**
     * @param cantidadRequerida the cantidadRequerida to set
     */
    public void setCantidadRequerida(int cantidadRequerida) {
        this.cantidadRequerida = cantidadRequerida;
    }

    /**
     * @return the cantidadGratis
     */
    public int getCantidadGratis() {
        return cantidadGratis;
    }

    /**
     * @param cantidadGratis the cantidadGratis to set
     */
    public void setCantidadGratis(int cantidadGratis) {
        this.cantidadGratis = cantidadGratis;
    }
    private int cantidadRequerida;
    private int cantidadGratis;
    
}
