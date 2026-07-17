/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.modelo;

import com.tienda.dominio.valor.CantidadStock;
import com.tienda.dominio.valor.Dinero;

/**
 *
 * @author Leonardo
 */
public class Producto {

    private Long id;  
    private String nombre;
    private String descripcion;
    private Dinero precio;
    private CantidadStock stock;
    private CantidadStock stockMinimo;
    private CategoriaProducto categoria;
    
    public Producto() {}

    // Constructor para CREAR (sin ID)
    public Producto(String nombre, String descripcion, Dinero precio, 
                    CantidadStock stock, CantidadStock stockMinimo, CategoriaProducto categoria) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.stockMinimo = stockMinimo;
        this.categoria=categoria;
    }

    // Constructor (con ID)
    public Producto(Long id, String nombre, String descripcion, Dinero precio,
                    CantidadStock stock, CantidadStock stockMinimo, CategoriaProducto categoria) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.stockMinimo = stockMinimo;
        this.categoria= categoria;
    }

    // Métodos de negocio 
    public void reducirStock(int cantidad) {
        CantidadStock nuevoStock = this.stock.reducir(cantidad);
        this.stock = nuevoStock;
        if (this.stock.esMenorQue(this.stockMinimo)) {
            System.out.println("ALERTA: Stock crítico para " + this.nombre);
        }
    }

    public void aumentarStock(int cantidad) {
        this.stock = this.stock.aumentar(cantidad);
    }

    public void actualizarPrecio(Dinero nuevoPrecio) {
        if (nuevoPrecio == null) {
            throw new IllegalArgumentException("El nuevo precio no puede ser nulo");
        }
        this.precio = nuevoPrecio;
    }

    // Getters y Setters (para que MapStruct pueda escribir)

    public CategoriaProducto getCategoria() {
        return categoria;
    }

    public void setCategoria(CategoriaProducto categoria) {
        this.categoria = categoria;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Dinero getPrecio() {
        return precio;
    }

    public void setPrecio(Dinero precio) {
        this.precio = precio;
    }

    public CantidadStock getStock() {
        return stock;
    }

    public void setStock(CantidadStock stock) {
        this.stock = stock;
    }

    public CantidadStock getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(CantidadStock stockMinimo) {
        this.stockMinimo = stockMinimo;
    }
    
}