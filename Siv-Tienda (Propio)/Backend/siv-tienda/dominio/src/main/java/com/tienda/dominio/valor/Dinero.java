/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.valor;

import java.math.BigDecimal;


/**
 *
 * @author Leonardo
 */
public record Dinero (BigDecimal monto){
    
    //Constructor
    public Dinero{
        //Realizamos verificaciones a la hora de crear el registro de Dinero
        if(monto==null){
            throw new IllegalArgumentException("El monto no puede ser nulo");
        }else if (monto.compareTo(BigDecimal.ZERO) < 0){ //Si es menor que 0 (Es menor que el número 0)
            throw new IllegalArgumentException("El monto no puede ser negativo");
        }
    }
    
    //Método sin instanciar para crear una clase Dinero desde un double
    public static Dinero of(double valor){
        //BigDecimal.valueOf hace lo mismo pero con esa clase.
        return new Dinero(BigDecimal.valueOf(valor));
    }
    
    //Sumar 2 registros dineros
    public Dinero sumar(Dinero otro){
        return new Dinero(this.monto.add(otro.monto));
    }
    
    public Dinero multiplicarXCantidad(int cantidad){
        return new Dinero(this.monto.multiply(BigDecimal.valueOf(cantidad)));
    }
    
    @Override
    public String toString(){
        //Retornar el monto como String.
        return "S/ "+monto.toPlainString();
    }
}
