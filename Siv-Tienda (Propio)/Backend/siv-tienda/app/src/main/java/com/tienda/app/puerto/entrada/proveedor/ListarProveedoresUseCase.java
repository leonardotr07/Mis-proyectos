/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.tienda.app.puerto.entrada.proveedor;

import com.tienda.dominio.modelo.provider.Proveedor;
import java.util.List;

/**
 *
 * @author Leonardo
 */
public interface ListarProveedoresUseCase {
    List<Proveedor> ejecutar();
}
