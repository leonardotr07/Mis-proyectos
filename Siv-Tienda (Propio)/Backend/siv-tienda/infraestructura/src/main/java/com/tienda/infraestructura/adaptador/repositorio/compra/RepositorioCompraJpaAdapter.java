/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio.compra;

import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.dominio.modelo.purchase.Compra;
import com.tienda.infraestructura.entidad.compras.EntidadCompra;
import com.tienda.infraestructura.mapper.CompraMapper;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.stereotype.Component;

/**
 *
 * @author Leonardo
 */
@Component
public class RepositorioCompraJpaAdapter implements RepositorioCompra{
    private final CompraJpaRepository jpaRepository;
    private final CompraMapper mapper;

    public RepositorioCompraJpaAdapter(CompraJpaRepository jpaRepository, CompraMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }

    @Override
    public Compra guardar(Compra compra) {
        // Convertir de dominio a entidad JPA
        EntidadCompra entity = mapper.toEntity(compra);

        //Establecer la relación bidireccional (la entidad CompraEntity tiene la lista de líneas)
        entity.getLineas().forEach(linea -> linea.setCompra(entity));

        // Guardar en la base de datos (Spring Data JPA)
        EntidadCompra guardado = jpaRepository.save(entity);

        // Convertir de vuelta a dominio (para devolver el objeto con el ID generado)
        return mapper.toDomain(guardado);
    }

    @Override
    public Optional<Compra> buscarPorId(Long id) {
        return jpaRepository.findById(id)
                .map(mapper::toDomain);
    }

    @Override
    public List<Compra> listarTodos() {
        return jpaRepository.findAll().stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }
}
