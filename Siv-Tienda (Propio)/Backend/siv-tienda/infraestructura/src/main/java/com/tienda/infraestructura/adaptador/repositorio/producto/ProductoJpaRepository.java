/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio.producto;

import com.tienda.infraestructura.entidad.producto.EntidadProducto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Leonardo
 */
@Repository
public interface ProductoJpaRepository extends JpaRepository<EntidadProducto, Long> {
    /*Generará automaticamente los métodos de:
        -guardar() 
        -encontrarPorId() 
        -listarTodos() 
        -eliminarPorId() 
    */
}
