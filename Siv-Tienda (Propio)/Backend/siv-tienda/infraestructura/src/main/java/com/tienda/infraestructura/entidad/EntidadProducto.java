/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.entidad;

import jakarta.persistence.*;

import java.math.BigDecimal;

/**
 *
 * @author Leonardo
 */
//Representará la tabla productos de la BD
@Entity
@Table(name="productos")
public class EntidadProducto {
    //Declaramos los campos de la tabla
    
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable=false, length=100)
    private String nombre;
    
    @Column(length=500)
    private String descripcion;
    
    @Column(nullable=false, precision=10, scale=2)
    private BigDecimal precio;
    
    @Column(nullable=false)
    private Integer stock;
    
    @Column(name="stock_minimo", nullable=false)
    private Integer stockMinimo;

    //Constructor con parametros
    public EntidadProducto(Long id, String nombre, String descripcion, BigDecimal precio, Integer stock, Integer stockMinimo) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.stockMinimo = stockMinimo;
    }

    
    //Getters y Setters
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

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(Integer stockMinimo) {
        this.stockMinimo = stockMinimo;
    }
    
    
}
