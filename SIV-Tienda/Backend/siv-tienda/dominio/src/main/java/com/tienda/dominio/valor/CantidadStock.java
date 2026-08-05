/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.valor;

/**
 *
 * @author Leonardo
 */
public record CantidadStock(int valor) {
    public CantidadStock{
        if(valor<0){
            throw new IllegalArgumentException("El stock no puede ser negativo");
        }
    }
    
    public CantidadStock aumentar(int cantAgregar){
        return new CantidadStock(this.valor + cantAgregar);
    }
    
    public CantidadStock reducir(int cantRestar){
        return new CantidadStock(this.valor - cantRestar);
    }
    
    public boolean esMenorQue(CantidadStock otro){
        return this.valor < otro.valor;
    }
}
