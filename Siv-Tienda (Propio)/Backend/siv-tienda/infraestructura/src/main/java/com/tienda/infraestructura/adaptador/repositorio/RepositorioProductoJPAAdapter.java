/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio;

import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import com.tienda.infraestructura.adaptador.repositorio.ProductoJpaRepository;
import com.tienda.infraestructura.entidad.EntidadProducto;
import com.tienda.infraestructura.mapper.ProductoMapper;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.stereotype.Component;

/**
 *
 * @author Leonardo
 */

@Component
public class RepositorioProductoJPAAdapter implements RepositorioProducto{

    private final ProductoJpaRepository jpaRepository; // Repositorio que se encarga de las operaciones CRUD
    private final ProductoMapper mapper; //MapStruct que convierte EntidadProducto -> Producto

    //Constructor
    public RepositorioProductoJPAAdapter(ProductoJpaRepository jpaRepository, ProductoMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }
    
    //Implemento las funciones de la clase RepositorioProducto en el proyecto de app
    //Esta clase interactua con la BD
    @Override
    public Producto guardar(Producto producto) {
        //Convertimos la entidad de dominio a entidad BD
        EntidadProducto entidad=mapper.toEntity(producto);
        
        //Lo guardamos en la BD
        EntidadProducto guardado=jpaRepository.save(entidad);
        
        //Devolvemos el producto guardado como entidad de Dominio.
        return mapper.toDominio(guardado);
    }
    
    //Buscar Producto por Id
    @Override
    public Optional<Producto> buscarPorId(Long id) {
        return jpaRepository.findById(id).map(mapper::toDominio);
    }
    
    //Listar Productos, la que interactua con la BD
    @Override
    public List<Producto> listarTodos() {
        return jpaRepository.findAll().stream()
                .map(mapper::toDominio)
                .collect(Collectors.toList());
    }

    @Override
    public void eliminarPorId(Long id) {
        jpaRepository.deleteById(id);
    }
    
    @Override
    public List<Producto> listarCriticos(){
        return jpaRepository.findAll().stream().map(mapper::toDominio)
                .filter(p -> p.getStock().valor() < p.getStockMinimo().valor()).collect(Collectors.toList());
    }
    
}
