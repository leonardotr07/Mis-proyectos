/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 *
 * @author valer
 */
public class PrendaLote {

    /**
     * @return the idPrendaLote
     */
    public int getIdPrendaLote() {
        return idPrendaLote;
    }

    /**
     * @param idPrendaLote the idPrendaLote to set
     */
    public void setIdPrendaLote(int idPrendaLote) {
        this.idPrendaLote = idPrendaLote;
    }


    //Atributos
    private int idPrendaLote;
    private int idPrenda;
    private int idLote;
    private int stock;
    private Talla talla;
    private boolean activo;

    public PrendaLote() {
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
    //Constructor Con parametros, Solo Atributos. Esto es el añadirPrenda.
    public PrendaLote(int idPrenda, int idLote, int stock, Talla talla) {
    if (stock < 0) {
        throw new IllegalArgumentException("El stock no puede ser negativo");
    }
    this.idPrenda = idPrenda;
    this.idLote = idLote;
    this.stock = stock;
    this.talla = talla;
}
    /**
     * @return the talla
     */
    public Talla getTalla() {
        return talla;
    }

    /**
     * @param talla the talla to set
     */
    public void setTalla(Talla talla) {
        this.talla = talla;
    }
    
    //Setters y Getters
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
     * @return the idLote
     */
    public int getIdLote() {
        return idLote;
    }

    /**
     * @param idLote the idLote to set
     */
    public void setIdLote(int idLote) {
        this.idLote = idLote;
    }

    /**
     * @return the stock
     */
    public int getStock() {
        return stock;
    }

    /**
     * @param stock the stock to set
     */
    public void setStock(int stock) {
    if (stock < 0) {
        throw new IllegalArgumentException("El stock no puede ser negativo");
    }
    this.stock = stock;
}

    
}
