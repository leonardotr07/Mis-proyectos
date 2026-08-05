/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.rest;

import com.tienda.app.puerto.entrada.proveedor.ListarProveedoresUseCase;
import com.tienda.dominio.modelo.provider.Proveedor;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Leonardo
 */

@RestController
@RequestMapping("/api/proveedores")
public class ProveedorController {
    private final ListarProveedoresUseCase listarProveedoresUseCase;

    public ProveedorController(ListarProveedoresUseCase listarProveedoresUseCase) {
        this.listarProveedoresUseCase = listarProveedoresUseCase;
    }
    
    @GetMapping
    public ResponseEntity<List<Proveedor>> listarProveedores() {
        return ResponseEntity.ok(listarProveedoresUseCase.ejecutar());
    }
}
