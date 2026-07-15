/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.puerto.entrada;

import com.tienda.app.comando.RegistrarProductoComando;
import com.tienda.dominio.modelo.Producto;

/**
 *
 * @author Leonardo
 */
//Este es el Puerto de Entrada
public interface RegistrarProductoUseCase {
    //Casos de uso. Lo que se va a realizar
    //Declara la funcion de registrar un producto.
    //El método que ejecuta el caso de uso. Recibirá el comando y devolverá el producto creado.
    Producto ejecutar(RegistrarProductoComando comando);
}
