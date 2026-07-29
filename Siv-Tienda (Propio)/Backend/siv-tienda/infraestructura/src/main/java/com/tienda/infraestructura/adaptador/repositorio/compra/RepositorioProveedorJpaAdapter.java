/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio.compra;

import com.tienda.app.puerto.salida.RepositorioProveedor;
import com.tienda.dominio.modelo.provider.Proveedor;
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
public class RepositorioProveedorJpaAdapter implements RepositorioProveedor{
    private final ProveedorJpaRepository jpaRepository;
    private final CompraMapper mapper;

    public RepositorioProveedorJpaAdapter(ProveedorJpaRepository jpaRepository, CompraMapper mapper) {
        this.jpaRepository = jpaRepository;
        this.mapper = mapper;
    }
    
    @Override
    public Optional<Proveedor> buscarPorId(Long id) {
        return jpaRepository.findById(id)
                .map(mapper::proveedorToDomain);
    }
    
    @Override
    public List<Proveedor> listarTodos() {
        return jpaRepository.findAll().stream()
                .map(mapper::proveedorToDomain)
                .collect(Collectors.toList());
    }
}
