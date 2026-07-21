/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.entrada;

import com.tienda.dominio.modelo.Producto;
import java.util.List;

/**
 *
 * @author Leonardo
 */
public interface ObtenerProductosCriticosUseCase {
    List<Producto> ejecutar();
}
