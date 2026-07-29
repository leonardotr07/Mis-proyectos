/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.excepcion;

/**
 *
 * @author Leonardo
 */
public class CompraNoEncontradaException extends RuntimeException{
    public CompraNoEncontradaException(Long id) {
        // Mensaje descriptivo que incluye el id buscado, util para logs y respuesta HTTP
        super("No se encontro la compra con id: " + id);
    }
}
