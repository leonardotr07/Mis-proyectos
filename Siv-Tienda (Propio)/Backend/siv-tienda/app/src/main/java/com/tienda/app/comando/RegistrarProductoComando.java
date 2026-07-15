/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.tienda.app.comando;

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

    @NotNull(message = "El stock inicial es obligatorio")
    @Positive(message = "El stock debe ser mayor a 0")
    Integer stockInicial,

    @NotNull(message = "El stock mínimo es obligatorio")
    @Positive(message = "El stock mínimo debe ser mayor a 0")
    Integer stockMinimo)
{}

