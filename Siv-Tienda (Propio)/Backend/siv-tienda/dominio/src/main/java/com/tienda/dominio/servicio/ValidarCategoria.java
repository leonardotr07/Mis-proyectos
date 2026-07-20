/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.dominio.servicio;

import com.tienda.dominio.modelo.CategoriaProducto;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Leonardo
 */
public class ValidarCategoria {
    public static final Map<CategoriaProducto, List<String>> MAPA_PALABRAS=Map.of(
            CategoriaProducto.POLOS, Arrays.asList("polo", "camisa", "blusa", "t-shirt", "tshirt", "top"),
            CategoriaProducto.JEANS, Arrays.asList("jeans", "pantalón", "vaquero", "denim", "levis", "pantalon", "jean"),
            CategoriaProducto.CASACAS, Arrays.asList("casaca", "chaqueta", "impermeable", "rompevientos", "chamarra"),
            CategoriaProducto.ZAPATILLAS, Arrays.asList("zapatilla", "tenis", "zapato", "deportiva", "calzado"),
            CategoriaProducto.ACCESORIOS, Arrays.asList("gorra", "bufanda", "guante", "cinturón", "accesorio"),
            CategoriaProducto.VESTIDOS, Arrays.asList("vestido", "falda", "blusa", "short", "buzo", "pantaloneta"),
            CategoriaProducto.OTROS, Collections.emptyList()
        );
    
    public static boolean esCoherente(String nombre, String descripcion, CategoriaProducto categoria) {
        if (descripcion == null || categoria == null) return false;
        String descLower = descripcion.toLowerCase();

        // Si la categoría es OTROS, es valido... retornamos que si es coherente
        if (categoria == CategoriaProducto.OTROS) return true;

        String textoCompleto=(nombre!=null ? nombre.toLowerCase() : "")+ " "
                +(descripcion!=null ? descripcion.toLowerCase() : "");
        
        //Si el texto de nombre y descripcion esta vacio. No es coherente.
        if(textoCompleto.trim().isEmpty()) return false;
        
        List<String> palabras = MAPA_PALABRAS.get(categoria);
        return palabras.stream().anyMatch(descLower::contains);
    }
}
