/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.entrada.productos;

import com.tienda.dominio.modelo.mercaderia.Producto;
import java.util.Optional;

/**
 *
 * @author Leonardo
 */
public interface ObtenerProductoIdUseCase {
    Optional<Producto> ejecutar(Long id);
}
