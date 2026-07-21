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
import com.tienda.app.puerto.entrada.ObtenerProductosCriticosUseCase;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.web.bind.annotation.ResponseStatus;

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
    private final ObtenerProductosCriticosUseCase obtenerProductosCriticos;
    
    //Constructor
    public ProductoController(RegistrarProductoUseCase registrarProducto,
            ListarProductosUseCase listarProductos, ObtenerProductoIdUseCase obtenerProducto,
            ActualizarProductoUseCase actualizarProducto, EliminarProductoUseCase eliminarProducto,
            ObtenerProductosCriticosUseCase obtenerProductosCriticos) {
        this.registrarProducto=registrarProducto;
        this.listarProductos=listarProductos;
        this.obtenerProducto=obtenerProducto;
        this.actualizarProducto=actualizarProducto;
        this.eliminarProducto=eliminarProducto;
        this.obtenerProductosCriticos=obtenerProductosCriticos;
    }
    
    //EndPoint para RegistrarProducto
    @PostMapping //Métodos POST de la ruta /api/productos
    @Operation(summary = "Registrar Producto")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "201", description = "Producto creado exitosamente"),
        @ApiResponse(responseCode = "400", description = "Datos inválidos")
    })
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
    @Operation(summary = "Listar Productos")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Producto encontrado"),
        @ApiResponse(responseCode = "404", description = "Producto no encontrado")
    })
    public ResponseEntity<List<Producto>> listarProductos() {
        List<Producto> productos = listarProductos.ejecutar();
        return ResponseEntity.ok(productos);
    }
    
    //ObtenerProducto
    @GetMapping("/{id}")
    @Operation(summary = "Obtener producto por ID")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Producto encontrado"),
        @ApiResponse(responseCode = "404", description = "Producto no encontrado")
    })
    public ResponseEntity<Producto> obtenerProductoPorId(@PathVariable Long id){
        return obtenerProducto.ejecutar(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
    
    //Actualizar o modificar producto
    @PutMapping("/{id}")
    @Operation(summary = "Actualizar producto por ID")
    @ApiResponse(responseCode = "200", description = "Producto actualizado")
    public ResponseEntity<Producto> actualizarProducto(
            @PathVariable Long id,
            @Valid @RequestBody ActualizarProductoComando comando) {
        return actualizarProducto.ejecutar(id, comando)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @Operation(summary = "Eliminar producto por ID")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Producto encontrado"),
        @ApiResponse(responseCode = "404", description = "Producto no encontrado")
    })
    public ResponseEntity<Void> eliminarProducto(@PathVariable Long id) {
        boolean eliminado = eliminarProducto.ejecutar(id);
        if (eliminado) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    
    @GetMapping("/criticos")
    @Operation(summary = "Obtener productos con Stock Crítico")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Productos encontrados"),
        @ApiResponse(responseCode = "404", description = "Productos no encontrados")
    })
    public ResponseEntity<List<Producto>> obtenerProductosCriticos(){
        //Donde Stock Minimo > Stock Actual
        return ResponseEntity.ok(obtenerProductosCriticos.ejecutar());
    }
}
