/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.salida;

import com.tienda.dominio.modelo.purchase.Compra;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author Leonardo
 */
public interface RepositorioCompra {
    Compra guardar(Compra compra);
    
    Optional<Compra> buscarPorId(Long id);
    
    List<Compra> listarTodos();
}
