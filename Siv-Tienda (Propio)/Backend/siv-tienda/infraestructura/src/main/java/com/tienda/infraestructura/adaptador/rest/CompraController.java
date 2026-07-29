/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.adaptador.rest;

import com.tienda.app.comando.compras.RegistrarCompraComando;
import com.tienda.app.puerto.entrada.compras.ObtenerCompraPorIdUseCase;
import com.tienda.app.puerto.entrada.compras.ListarComprasUseCase;
import com.tienda.app.puerto.entrada.compras.AnularCompraUseCase;
import com.tienda.app.puerto.entrada.compras.PagarCompraUseCase;
import com.tienda.app.servicio.compra.ServicioRegistrarCompra;
import com.tienda.dominio.excepcion.CompraNoEncontradaException;
import com.tienda.dominio.modelo.purchase.Compra;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import jakarta.validation.Valid;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 *
 * @author Leonardo
 */

@RestController
@RequestMapping("/api/compras")
public class CompraController {
    private static final Logger log = LoggerFactory.getLogger(CompraController.class);

    private final ServicioRegistrarCompra servicioRegistrarCompra;
    private final ListarComprasUseCase listarComprasUseCase;
    private final ObtenerCompraPorIdUseCase obtenerCompraPorIdUseCase;
    private final AnularCompraUseCase anularCompraUseCase;
    private final PagarCompraUseCase pagarCompraUseCase;

    // Inyección por constructor

    public CompraController(ServicioRegistrarCompra servicioRegistrarCompra,
            ListarComprasUseCase listarComprasUseCase, ObtenerCompraPorIdUseCase obtenerCompraPorIdUseCase,
            AnularCompraUseCase anularCompraUseCase, PagarCompraUseCase pagarCompraUseCase) {
        this.servicioRegistrarCompra = servicioRegistrarCompra;
        this.listarComprasUseCase = listarComprasUseCase;
        this.obtenerCompraPorIdUseCase = obtenerCompraPorIdUseCase;
        this.anularCompraUseCase = anularCompraUseCase;
        this.pagarCompraUseCase = pagarCompraUseCase;
    }
    

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED) 
    @ApiResponse(responseCode = "201", description="Compra creada")
    public ResponseEntity<Compra> registrarCompra(
            @Valid @RequestBody RegistrarCompraComando comando) {

        log.info("Petición para registrar compra recibida. Proveedor ID: {}", comando.proveedorId());

        Compra nuevaCompra = servicioRegistrarCompra.ejecutar(comando);

        // Devolver 201 Created con el objeto creado
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevaCompra);
    }
    
    @GetMapping
    public ResponseEntity<List<Compra>> listarCompras() {
        List<Compra> compras = listarComprasUseCase.ejecutar();
        return ResponseEntity.ok(compras);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Compra> obtenerCompra(@PathVariable Long id) {
        return obtenerCompraPorIdUseCase.ejecutar(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    // El operationId explicito asegura que NSwag genere en C# el metodo AnularCompraAsync
    @PutMapping("/{id}/anular")
    @Operation(operationId = "anularCompra", summary = "Anula una compra pendiente o rechazada")
    @ApiResponse(responseCode = "200", description = "Compra anulada correctamente")
    public ResponseEntity<Compra> anularCompra(@PathVariable Long id) {
        log.info("Petición para anular compra recibida. Compra ID: {}", id);
        // Se delega toda la logica de negocio y persistencia al caso de uso
        Compra compraAnulada = anularCompraUseCase.ejecutar(id);
        return ResponseEntity.ok(compraAnulada);
    }
    
    @PutMapping("/{id}/pagar")
    @Operation(operationId = "pagarCompra", summary = "Registra el pago total de una compra al proveedor")
    @ApiResponse(responseCode = "200", description = "Compra pagada correctamente")
    public ResponseEntity<Compra> pagarCompra(@PathVariable Long id) {
        log.info("Petición para pagar compra recibida. Compra ID: {}", id);
        // Se delega toda la logica de negocio y persistencia al caso de uso
        Compra compraPagada = pagarCompraUseCase.ejecutar(id);
        return ResponseEntity.ok(compraPagada);
    }
    
    // Traducen los errores de dominio/aplicacion en respuestas HTTP correctas

    // Se lanza cuando el id de la compra no existe en el repositorio
    @ExceptionHandler(CompraNoEncontradaException.class)
    public ResponseEntity<String> manejarCompraNoEncontrada(CompraNoEncontradaException ex) {
        log.warn("Compra no encontrada: {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
    }

    // Se lanza desde el dominio (Compra.anular() / marcarComoCompletada())
    // cuando se intenta un cambio de estado invalido, ej. anular una compra ya completada
    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity<String> manejarEstadoInvalido(IllegalStateException ex) {
        log.warn("Transicion de estado invalida: {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(ex.getMessage());
    }
}
