/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.puerto.entrada.EliminarProductoUseCase;
import com.tienda.app.puerto.salida.RepositorioProducto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Leonardo
 */

@Service
public class ServicioEliminarProducto implements EliminarProductoUseCase{
    private final RepositorioProducto repProducto;

    public ServicioEliminarProducto(RepositorioProducto repProducto) {
        this.repProducto = repProducto;
    }
    
    @Override
    @Transactional
    public boolean ejecutar(Long id){
        if(repProducto.buscarPorId(id).isEmpty()) return false;
        
        repProducto.eliminarPorId(id);
        return true;
    }
}
