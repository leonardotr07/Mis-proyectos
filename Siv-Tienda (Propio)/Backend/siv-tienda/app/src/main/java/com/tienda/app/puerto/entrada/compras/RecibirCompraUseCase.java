/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.entrada.compras;

import com.tienda.dominio.modelo.purchase.Compra;

/**
 *
 * @author Leonardo
 */
public interface RecibirCompraUseCase {
    Compra ejecutar(Long id);
}
