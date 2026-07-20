/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.tienda.app.comando;

import com.tienda.dominio.modelo.CategoriaProducto;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

/**
 *
 * @author Leonardo
 */

public record RegistrarProductoComando (

    //Colocamos la verificaciones necesarias para cada parametro de producto
    @NotBlank(message = "El nombre es obligatorio")
    String nombre,

    String descripcion, // Puede ser nulo o vacío, no tiene validación

    @NotNull(message = "El precio es obligatorio")
    @Positive(message = "El precio debe ser mayor a 0")
    Double precio,

    @NotNull(message = "El stock es obligatorio")
    @Positive(message = "El stock debe ser mayor a 0")
    Integer stock,

    @NotNull(message = "El stock mínimo es obligatorio")
    @Positive(message = "El stock mínimo debe ser mayor a 0")
    Integer stockMinimo,

    @NotNull(message = "La categoría es obligatoria")
    CategoriaProducto categoria)
{}

