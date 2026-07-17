/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.comando.ActualizarProductoComando;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import com.tienda.dominio.valor.CantidadStock;
import com.tienda.dominio.valor.Dinero;
import java.util.Optional;
import org.springframework.transaction.annotation.Transactional;
import com.tienda.app.puerto.entrada.ActualizarProductoUseCase;
import com.tienda.dominio.servicio.ValidarCategoria;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */
@Service
public class ServicioActualizarProductos implements ActualizarProductoUseCase{
    
    private final RepositorioProducto repProducto;

    public ServicioActualizarProductos(RepositorioProducto repProducto) {
        this.repProducto = repProducto;
    }
    
    @Override
    @Transactional
    public Optional<Producto> ejecutar(Long id, ActualizarProductoComando comando){
        //Busca el producto para verificar si existe
        Optional<Producto> producto=repProducto.buscarPorId(id);
        
        //Si no existe... retorna vacio o null
        if(producto.isEmpty()){
            return Optional.empty();
        }
        
        if(!ValidarCategoria.esCoherente(comando.nombre(), comando.descripcion(), comando.categoria())){
            throw new IllegalArgumentException("La categoria no coincide con el nombre o descripcion del producto.");
        }
        
        //Reconstruimos el producto actualizado en un nuevo objeto. Conservando la ID
        Producto productoAct = new Producto(
            producto.get().getId(),
            comando.nombre(),
            comando.descripcion(),
            Dinero.of(comando.precio()),
            new CantidadStock(comando.stock()),
            new CantidadStock(comando.stockMinimo()),
            comando.categoria()
        );
        
        //Lo guardamos
        Producto guardado=repProducto.guardar(productoAct);
        return Optional.of(guardado);
    }
    
}
