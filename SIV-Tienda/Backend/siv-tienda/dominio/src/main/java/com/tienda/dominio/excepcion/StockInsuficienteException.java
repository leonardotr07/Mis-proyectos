/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.excepcion;

/**
 *
 * @author Leonardo
 */
public class StockInsuficienteException extends RuntimeException{
    
    public StockInsuficienteException(String mensaje){
        super(mensaje);
    }
}
