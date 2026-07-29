/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.modelo.purchase;

import com.tienda.dominio.modelo.mercaderia.Producto;
import com.tienda.dominio.valor.Dinero;

/**
 *
 * @author Leonardo
 */
public class LineaCompra {
    private final Long id;
    private final Producto datProducto;
    private int cantidad;
    private Dinero precioUnitario;
    private Dinero subTotal;
    
    //Constructores
    public LineaCompra(Producto producto, int cantidad, Dinero precioUnitario){
        this(null, producto, cantidad, precioUnitario);
    }

    public LineaCompra(Long id, Producto datProducto, int cantidad, Dinero precioUnitario) {
        this.id = id;
        this.datProducto = datProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subTotal=precioUnitario.multiplicarXCantidad(cantidad);
    }

    public Long getId() {
        return id;
    }

    public Producto getDatProducto() {
        return datProducto;
    }
    
    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Dinero getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(Dinero precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public Dinero getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Dinero subTotal) {
        this.subTotal = subTotal;
    }
    
    
}
