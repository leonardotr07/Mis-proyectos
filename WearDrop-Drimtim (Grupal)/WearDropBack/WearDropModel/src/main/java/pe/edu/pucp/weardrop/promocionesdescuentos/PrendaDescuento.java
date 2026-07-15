/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocionesdescuentos;

/**
 *
 * @author leona
 */
public class PrendaDescuento {

    /**
     * @return the idPrenda
     */
    public int getIdPrenda() {
        return idPrenda;
    }

    /**
     * @param idPrenda the idPrenda to set
     */
    public void setIdPrenda(int idPrenda) {
        this.idPrenda = idPrenda;
    }

    /**
     * @return the idDescuento
     */
    public int getIdDescuento() {
        return idDescuento;
    }

    /**
     * @param idDescuento the idDescuento to set
     */
    public void setIdDescuento(int idDescuento) {
        this.idDescuento = idDescuento;
    }

    /**
     * @return the activo
     */
    public boolean isActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    private int idPrenda;
    private int idDescuento;
    private boolean activo;
    
    
    
}
