/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.puerto.salida;

import com.tienda.dominio.modelo.Producto;
import java.util.Optional;

/**
 *
 * @author Leonardo
 */
public interface RepositorioProducto {
    //Se crea esto para guardar y recuperar productos. Aqui no importa como se guardan
    
    //Guarda un producto (nuevo o actualizado) y lo devuelve con su ID asignado  
    Producto guardar(Producto producto);
    
    // Busca un producto por su ID. Devuelve Optional xq puede que no exista.
    Optional<Producto> buscarPorId(Long id);
}
