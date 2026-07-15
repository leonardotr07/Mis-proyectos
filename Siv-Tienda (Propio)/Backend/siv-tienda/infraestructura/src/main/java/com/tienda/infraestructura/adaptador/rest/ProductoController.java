/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.rest;

import com.tienda.app.comando.RegistrarProductoComando;
import com.tienda.app.puerto.entrada.RegistrarProductoUseCase;
import com.tienda.dominio.modelo.Producto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author Leonardo
 */

@RestController //Maneja peticiones HTTP
@RequestMapping("/api/productos") //La ruta base para que sea invocado.

//Esta clase sirve como punto de entrada para peticiones HTTP
public class ProductoController {
    private final RegistrarProductoUseCase registrarProducto; //Puerto de Entrada

    //Constructor
    public ProductoController(RegistrarProductoUseCase registrarProducto) {
        this.registrarProducto = registrarProducto;
    }
    
    @PostMapping //Métodos POST de la ruta /api/productos
    public ResponseEntity<Producto> registrarProducto(@Valid @RequestBody RegistrarProductoComando comando){
        //Sobre @Valid y @RequestBody -> la petición http lo convierte a un RegistrarProductoComando y valid: valida
        //lo necesario sobre el comando (Not null o positive). De no ser así. Devuelve error 400 (Bad Request)

        Producto nuevoProducto=registrarProducto.ejecutar(comando); //Ejecuta el método.
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevoProducto); //Devuelve la respuesta del nuevoProducto creado.
    }
}
