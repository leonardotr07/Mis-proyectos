/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.puerto.entrada.ObtenerProductoIdUseCase;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import java.util.Optional;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */

@Service
public class ServicioObtenerProductoPorId implements ObtenerProductoIdUseCase{
    private final RepositorioProducto repositorioProducto;

    public ServicioObtenerProductoPorId(RepositorioProducto repositorioProducto) {
        this.repositorioProducto = repositorioProducto;
    }
    
    
    
    @Override
    public Optional<Producto> ejecutar(Long id){
        return repositorioProducto.buscarPorId(id);
    }
}
