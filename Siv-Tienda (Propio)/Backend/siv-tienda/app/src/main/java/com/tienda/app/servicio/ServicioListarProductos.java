/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.puerto.entrada.ListarProductosUseCase;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */

@Service //Clase Servicio
public class ServicioListarProductos implements ListarProductosUseCase{
    
    private final RepositorioProducto repositorioProducto;

    public ServicioListarProductos(RepositorioProducto repositorioProducto) {
        this.repositorioProducto = repositorioProducto;
    }
    
    //Orquestará la operación
    @Override
    public List<Producto> ejecutar(){
        return repositorioProducto.listarTodos();
    }
    
}
