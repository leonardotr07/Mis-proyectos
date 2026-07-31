/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.configuracion;

import com.tienda.dominio.excepcion.CompraNoEncontradaException;
import com.tienda.dominio.excepcion.StockInsuficienteException;
import com.tienda.dominio.excepcion.TransicionEstadoInvalidaException;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 *
 * @author Leonardo
 */

//Se crea esta clase para enviar mensaje mas descriptivos.
@RestControllerAdvice //Indica a Spring que esta clase es el manejador global de excepciones.
public class ManejadorGlobalExcepciones {
    
    //Logger Propio para asegurar fiabilidad y que sea descriptivo.
    private static final Logger log = LoggerFactory.getLogger(ManejadorGlobalExcepciones.class);
    
    //Captura de errores de validación del comando @Valid
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );
        return ResponseEntity.badRequest().body(errors);
    }
    
    //Captura excepciones de lógica de negocio
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Map<String, String>> handleIllegalArgument(IllegalArgumentException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return ResponseEntity.badRequest().body(error);
    }
    
    //Captura la excepción de negocio creada en dominio (StockInsuficienteException)
    @ExceptionHandler(StockInsuficienteException.class)
    public ResponseEntity<Map<String, String>> handleStockInsuficiente(StockInsuficienteException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }
    
    //El manejo de la excepción cuando la compra no es encontrada.
    @ExceptionHandler(CompraNoEncontradaException.class)
    public ResponseEntity<Map<String, String>> handleCompraNoEncontrada(CompraNoEncontradaException ex) {
        log.warn("Compra no encontrada: {}", ex.getMessage());
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }
    
    //Cuando se realiza una transición invalida (respecto al dominio)
    @ExceptionHandler(TransicionEstadoInvalidaException.class)
    public ResponseEntity<Map<String, String>> handleTransicionInvalida(TransicionEstadoInvalidaException ex) {
        log.warn("Transición de estado inválida: {}", ex.getMessage());
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }
    
    //Cuando se detecta un error de concurrencia.
    @ExceptionHandler(ObjectOptimisticLockingFailureException.class)
    public ResponseEntity<Map<String, String>> handleConflictoConcurrencia(ObjectOptimisticLockingFailureException ex) {
        log.warn("Conflicto de concurrencia detectado: {}", ex.getMessage());
        Map<String, String> error = new HashMap<>();
        error.put("error", "Esta compra fue modificada por otra operación mientras la procesabas. Refresca la página e intenta nuevamente.");
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }
    
    //Capturas cualquier excepcion no controlada.
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleGenericException(Exception ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", "Ocurrió un error interno en el servidor");
        ex.printStackTrace();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
    
    @ExceptionHandler(org.springframework.dao.DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, String>> handleDataIntegrityViolation(
            org.springframework.dao.DataIntegrityViolationException ex) {

        log.warn("Violación de integridad de datos: {}", ex.getMessage());

        String mensaje = "No se puede eliminar el registro porque tiene dependencias asociadas.";

        
        Throwable cause = ex.getRootCause();
        
        //Marcamos la causa. Ya sea xq el producto no se puede eliminar a lineas de compra
        //O asociado con lineas de venta
        //U otra referencia
        if (cause != null) {
            String causaMsg = cause.getMessage();
            if (causaMsg != null && causaMsg.contains("lineas_compra")) {
                mensaje = "No se puede eliminar el producto porque tiene líneas de compra asociadas. ";
            } else if (causaMsg != null && causaMsg.contains("lineas_venta")) {
                mensaje = "No se puede eliminar el producto porque tiene líneas de venta asociadas. ";
            } else if (causaMsg != null && causaMsg.contains("foreign key constraint")) {
                mensaje = "No se puede eliminar el registro porque está siendo referenciado en otros registros.";
            }
        }

        Map<String, String> error = new HashMap<>();
        error.put("error", mensaje);

        // 409 Conflict es más apropiado que 400 o 500 para cubrir esta excepción
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }
}
