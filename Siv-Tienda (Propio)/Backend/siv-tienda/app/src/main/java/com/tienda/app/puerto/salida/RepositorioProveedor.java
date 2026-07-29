/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.salida;

import com.tienda.dominio.modelo.provider.Proveedor;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author Leonardo
 */
public interface RepositorioProveedor {
    Optional <Proveedor> buscarPorId(Long id);
    
    List<Proveedor> listarTodos();
}
