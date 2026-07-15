/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio;

import com.tienda.infraestructura.entidad.EntidadProducto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Leonardo
 */
@Repository
public interface ProductoJpaRepository extends JpaRepository<EntidadProducto, Long> {
    /*Generará automaticamente los métodos de:
        -save() Registrar
        -findById() EncontrarPorID
        -findAll() Encontrar todos
        -deleteById() Eliminar por ID
    */
}
