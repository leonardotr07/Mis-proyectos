/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.modelo.purchase;

import com.tienda.dominio.modelo.provider.Proveedor;
import com.tienda.dominio.valor.Dinero;
import com.tienda.dominio.valor.EstadoCompra;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Leonardo
 */
public class Compra {
    private final Long id;
    private final Proveedor proveedor;
    private final List<LineaCompra> lineas;
    private LocalDateTime fechaCompra;
    private EstadoCompra estado;
    private Dinero total;

    public Compra(Proveedor proveedor, List<LineaCompra> lineas) {
        this(null, proveedor, lineas, LocalDateTime.now(), EstadoCompra.PENDIENTE);
    }

    public Compra(Long id, Proveedor proveedor, List<LineaCompra> lineas, LocalDateTime fechaCompra, EstadoCompra estado) {
        this.id = id;
        this.proveedor = proveedor;
        this.lineas = lineas;
        this.fechaCompra = fechaCompra;
        this.estado = estado;
        this.total=this.calcularTotal();
    }
    
    private Dinero calcularTotal(){
        Dinero total = Dinero.of(0);
        for(LineaCompra linea: lineas){
            total=total.sumar(linea.getSubTotal());
        }
        return total;
    }

    //Métodos de Negocio.
    // Métodos de negocio
    public void marcarComoRecibida() {
        if (this.estado == EstadoCompra.ANULADA) {
            throw new IllegalStateException("No se puede recibir una compra anulada");
        }
        this.estado = EstadoCompra.RECIBIDA;
    }

    public void marcarComoCompletada() {
        if (this.estado == EstadoCompra.ANULADA) {
            throw new IllegalStateException("No se puede completar una compra anulada");
        }
        this.estado = EstadoCompra.COMPLETADA;
    }

    public void anular() {
        if (this.estado == EstadoCompra.COMPLETADA || this.estado == EstadoCompra.RECIBIDA) {
            throw new IllegalStateException("No se puede anular una compra ya recibida o completada");
        }
        this.estado = EstadoCompra.ANULADA;
    }
    
    //Getters y Setters
    public Long getId(){
        return id;
    }
    
    public LocalDateTime getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(LocalDateTime fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public EstadoCompra getEstado() {
        return estado;
    }

    public void setEstado(EstadoCompra estado) {
        this.estado = estado;
    }

    public Dinero getTotal() {
        return total;
    }

    public void setTotal(Dinero total) {
        this.total = total;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public List<LineaCompra> getLineas() {
        return lineas;
    }
    
    
}
