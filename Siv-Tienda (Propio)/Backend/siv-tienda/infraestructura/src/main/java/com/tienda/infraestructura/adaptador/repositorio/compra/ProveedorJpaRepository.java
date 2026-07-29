/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.infraestructura.adaptador.repositorio.compra;

import com.tienda.infraestructura.entidad.proveedor.EntidadProveedor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Leonardo
 */
@Repository
public interface ProveedorJpaRepository extends JpaRepository<EntidadProveedor, Long>{
    
}
