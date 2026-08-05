/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.valor;

/**
 *
 * @author Leonardo
 */
public enum EstadoCompra {
    PENDIENTE, //Pedido realizado, pendiente de Entrega
    RECIBIDA, //Mercancía recibida parcial o totalmente
    ANULADA, //Compra Cancelada
    COMPLETADA //Pagada y recibida por el cliente
}
