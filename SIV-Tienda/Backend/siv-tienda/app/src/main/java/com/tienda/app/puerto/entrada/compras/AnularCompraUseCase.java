/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.puerto.entrada.compras;

import com.tienda.dominio.modelo.purchase.Compra;

/**
 *
 * @author Leonardo
 */
public interface AnularCompraUseCase {
    Compra ejecutar(Long id);
}
