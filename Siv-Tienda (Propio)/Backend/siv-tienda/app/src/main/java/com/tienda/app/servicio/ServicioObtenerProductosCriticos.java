/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.puerto.entrada.ObtenerProductosCriticosUseCase;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */
@Service
public class ServicioObtenerProductosCriticos implements ObtenerProductosCriticosUseCase{
    private final RepositorioProducto repProducto;

    public ServicioObtenerProductosCriticos(RepositorioProducto repProducto) {
        this.repProducto = repProducto;
    }
    
    @Override
    public List<Producto> ejecutar() {
        return repProducto.listarCriticos();
    }
}
