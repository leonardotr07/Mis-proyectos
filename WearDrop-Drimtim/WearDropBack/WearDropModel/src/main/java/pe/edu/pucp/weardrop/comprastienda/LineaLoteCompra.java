/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.prendas.Talla;

/**
 *
 * @author matia
 */
public class LineaLoteCompra {
    
    private int idPrenda;
    private int numLinea;
    private int cantidad;
    private Talla talla;
    private Lote lote;
    private double precioLote;
    private boolean activo;
    
    //Constructor por defecto
    public LineaLoteCompra(){
        this.lote = new Lote();
    }
    
    
    //Constructor con parametros

    public LineaLoteCompra(int idPrenda, int numLinea,
            int cantidad, Talla talla,
            Lote lote, double precioLote,
            boolean  activo ) {
        this.idPrenda = idPrenda;
        this.numLinea = numLinea;
        this.cantidad = cantidad;
        this.talla = talla;
        this.lote = new Lote(lote);
        this.precioLote = precioLote;
        this.activo = activo;
    }
    
    
    //Constructor copia
    
    public LineaLoteCompra(LineaLoteCompra lineaLoteCompra){
        this.idPrenda = lineaLoteCompra.getIdPrenda();
        this.numLinea = lineaLoteCompra.getNumLinea();
        this.cantidad = lineaLoteCompra.getCantidad();
        this.talla = lineaLoteCompra.getTalla();
        this.lote = new Lote(lineaLoteCompra.getLote());
        this.precioLote = lineaLoteCompra.getPrecioLote();
        this.activo = lineaLoteCompra.isActivo();
    }
    
    
    
    
    //Getters

    public int getIdPrenda() {
        return idPrenda;
    }

    public int getNumLinea() {
        return numLinea;
    }
    
    

    public int getCantidad() {
        return cantidad;
    }

    public Talla getTalla() {
        return talla;
    }

    public Lote getLote() {
        return new Lote(lote);
    }

    public double getPrecioLote() {
        return precioLote;
    }
    public boolean isActivo() {
        return activo;
    }

    
    
    //Setters

    public void setIdPrenda(int idPrenda) {
        this.idPrenda = idPrenda;
    }

    public void setNumLinea(int numLinea) {
        this.numLinea = numLinea;
    }
    
    

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public void setTalla(Talla talla) {
        this.talla = talla;
    }

    public void setLote(Lote lote) {
        this.lote = new Lote(lote);
    }

    public void setPrecioLote(double precioLote) {
        this.precioLote = precioLote;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
