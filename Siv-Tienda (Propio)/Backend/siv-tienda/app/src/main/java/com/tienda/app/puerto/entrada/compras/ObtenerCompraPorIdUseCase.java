/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.entrada.compras;

import com.tienda.dominio.modelo.purchase.Compra;
import java.util.Optional;

/**
 *
 * @author Leonardo
 */
public interface ObtenerCompraPorIdUseCase {
    Optional<Compra> ejecutar(Long id);
}
