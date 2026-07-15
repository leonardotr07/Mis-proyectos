/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.promocionesdescuentos.Descuento;
import pe.edu.pucp.weardrop.promocionesdescuentos.Promocion;

/**
 *
 * @author matia
 */
public class ItemVenta {
    private int numLinea;
    private int idPrenda;
    private int cantidad;
    //list descuentos
    private ArrayList<Descuento> descuentos;
    //list promocion
    private ArrayList<Promocion> promociones;
    private double subtotal;
    private boolean activo;
    private Talla talla;
    
    //Constructores
    public ItemVenta(){
        this.descuentos = new ArrayList<>();
        this.promociones = new ArrayList<>();
    }

    public ItemVenta(int numLinea, int idPrenda,
            int cantidad, ArrayList<Descuento> descuentos,
            ArrayList<Promocion> promociones, double subtotal,
            boolean activo) {
        this.numLinea = numLinea;
        this.idPrenda = idPrenda;
        this.cantidad = cantidad;
        this.descuentos = new ArrayList<>(descuentos);
        this.promociones = new ArrayList<>(promociones);
        this.subtotal = subtotal;
        this.activo = true;
    }
    
    public ItemVenta(ItemVenta itemVenta){
        this.numLinea = itemVenta.getNumLinea();
        this.idPrenda = itemVenta.getIdPrenda();
        this.cantidad = itemVenta.getCantidad();
        this.descuentos = new ArrayList<>(itemVenta.getDescuentos());
        this.promociones = new ArrayList<>(itemVenta.getPromociones());
        this.subtotal = itemVenta.getSubtotal();
        this.activo = itemVenta.isActivo();
        this.talla = itemVenta.talla;
    }
    
    
    //Getters

    public int getNumLinea() {
        return numLinea;
    }

    public int getIdPrenda() {
        return idPrenda;
    }

    public int getCantidad() {
        return cantidad;
    }

    public ArrayList<Descuento> getDescuentos() {
        //ArrayList<Descuento> descuentos = new ArrayList<>();
        //falta hacer la copia profunda
        //for(Descuento desc: this.descuentos ){
        //    descuentos.add(new Descuento(desc));
        //}
        return descuentos;
    }

    public ArrayList<Promocion> getPromociones() {
        
        return promociones;
    }

    public double getSubtotal() {
        return subtotal;
    }
    public boolean isActivo() {
        return activo;
    }
    
    //Setters

    public void setNumLinea(int numLinea) {
        this.numLinea = numLinea;
    }

    public void setIdPrenda(int idPrenda) {
        this.idPrenda = idPrenda;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public void setDescuentos(ArrayList<Descuento> descuentos) {
        this.descuentos = new ArrayList<>(descuentos);
    }

    public void setPromociones(ArrayList<Promocion> promociones) {
        this.promociones = new ArrayList<> (promociones);
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public Talla getTalla() {
        return talla;
    }

    public void setTalla(Talla talla) {
        this.talla = talla;
    }
    
    
}
