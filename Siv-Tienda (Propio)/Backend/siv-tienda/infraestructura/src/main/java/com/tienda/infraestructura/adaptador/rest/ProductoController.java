/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.rest;

import com.tienda.app.comando.ActualizarProductoComando;
import com.tienda.app.comando.RegistrarProductoComando;
import com.tienda.app.puerto.entrada.EliminarProductoUseCase;
import com.tienda.app.puerto.entrada.ListarProductosUseCase;
import com.tienda.app.puerto.entrada.ObtenerProductoIdUseCase;
import com.tienda.app.puerto.entrada.RegistrarProductoUseCase;
import com.tienda.dominio.modelo.Producto;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.tienda.app.puerto.entrada.ActualizarProductoUseCase;

/**
 *
 * @author Leonardo
 */

@RestController //Maneja peticiones HTTP
@RequestMapping("/api/productos") //La ruta base para que sea invocado.

//Esta clase sirve como punto de entrada para peticiones HTTP
public class ProductoController {
    private final RegistrarProductoUseCase registrarProducto; //Puerto de Entrada
    private final ListarProductosUseCase listarProductos;
    private final ObtenerProductoIdUseCase obtenerProducto;
    private final ActualizarProductoUseCase actualizarProducto;
    private final EliminarProductoUseCase eliminarProducto;
    
    //Constructor
    public ProductoController(RegistrarProductoUseCase registrarProducto,
            ListarProductosUseCase listarProductos, ObtenerProductoIdUseCase obtenerProducto,
            ActualizarProductoUseCase actualizarProducto, EliminarProductoUseCase eliminarProducto) {
        this.registrarProducto=registrarProducto;
        this.listarProductos=listarProductos;
        this.obtenerProducto=obtenerProducto;
        this.actualizarProducto=actualizarProducto;
        this.eliminarProducto=eliminarProducto;
    }
    
    //EndPoint para RegistrarProducto
    @PostMapping //Métodos POST de la ruta /api/productos
    public ResponseEntity<Producto> registrarProducto(@Valid @RequestBody RegistrarProductoComando comando){
        //Sobre @Valid y @RequestBody -> la petición http lo convierte a un RegistrarProductoComando y valid: valida
        //lo necesario sobre el comando (Not null o positive). De no ser así. Devuelve error 400 (Bad Request)

        //Ejecuta el método.
        Producto nuevoProducto=registrarProducto.ejecutar(comando);
        //Devuelve la respuesta del nuevoProducto creado.
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevoProducto);
    }
    
    //ListarProductos
    @GetMapping
    public ResponseEntity<List<Producto>> listarProductos() {
        List<Producto> productos = listarProductos.ejecutar();
        return ResponseEntity.ok(productos);
    }
    
    //ObtenerProducto
    @GetMapping("/{id}")
    public ResponseEntity<Producto> obtenerProductoPorId(@PathVariable Long id){
        return obtenerProducto.ejecutar(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
    
    //Actualizar o modificar producto
    @PutMapping("/{id}")
    public ResponseEntity<Producto> actualizarProducto(
            @PathVariable Long id,
            @Valid @RequestBody ActualizarProductoComando comando) {
        return actualizarProducto.ejecutar(id, comando)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(@PathVariable Long id) {
        boolean eliminado = eliminarProducto.ejecutar(id);
        if (eliminado) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
