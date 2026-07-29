package com.tienda.app.comando.compras;

import com.tienda.app.comando.compras.LineaCompraRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Leonardo
 */
public record RegistrarCompraComando (
    @NotNull(message = "El ID del proveedor es obligatorio")
    Long proveedorId,

    @Valid // Esto valida cada elemento de la lista
    @NotNull(message = "La compra debe tener al menos una línea")
    @Size(min = 1, message = "La compra debe tener al menos una línea")
    List<LineaCompraRequest> lineas
){}
