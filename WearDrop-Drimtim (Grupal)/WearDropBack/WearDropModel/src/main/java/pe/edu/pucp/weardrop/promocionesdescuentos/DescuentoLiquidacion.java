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
public class DescuentoLiquidacion extends Descuento{

    /**
     * @return the porcentajeLiquidacion
     */
    public double getPorcentajeLiquidacion() {
        return porcentajeLiquidacion;
    }

    /**
     * @param porcentajeLiquidacion the porcentajeLiquidacion to set
     */
    public void setPorcentajeLiquidacion(double porcentajeLiquidacion) {
        this.porcentajeLiquidacion = porcentajeLiquidacion;
    }

    /**
     * @return the condicionStockMin
     */
    public int getCondicionStockMin() {
        return condicionStockMin;
    }

    /**
     * @param condicionStockMin the condicionStockMin to set
     */
    public void setCondicionStockMin(int condicionStockMin) {
        this.condicionStockMin = condicionStockMin;
    }
    private double porcentajeLiquidacion;
    private int condicionStockMin;

    public DescuentoLiquidacion(){}
    
    public DescuentoLiquidacion(int id,String nombre, boolean esAutomatico,boolean activo,double porcentajeLiquidacion,Vigencia vigencia,int condicion) {
        super(id,   nombre, esAutomatico,activo,vigencia);
        this.porcentajeLiquidacion=porcentajeLiquidacion;
        this.condicionStockMin=condicion;
    }
    
 
}
