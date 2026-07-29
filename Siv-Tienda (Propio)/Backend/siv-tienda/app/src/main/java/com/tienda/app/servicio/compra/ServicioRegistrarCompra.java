/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

/**
 *
 * @author Leonardo
 */

import com.tienda.app.comando.compras.LineaCompraRequest;
import com.tienda.app.comando.compras.RegistrarCompraComando;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.app.puerto.salida.RepositorioProveedor;
import com.tienda.dominio.modelo.mercaderia.Producto;
import com.tienda.dominio.modelo.provider.Proveedor;
import com.tienda.dominio.modelo.purchase.Compra;
import com.tienda.dominio.modelo.purchase.LineaCompra;
import com.tienda.dominio.valor.Dinero;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ServicioRegistrarCompra {
    private static final Logger log = LoggerFactory.getLogger(ServicioRegistrarCompra.class);

    private final RepositorioProveedor repositorioProveedor;
    private final RepositorioProducto repositorioProducto;
    private final RepositorioCompra repositorioCompra;

    // Inyección por constructor 
    public ServicioRegistrarCompra(RepositorioProveedor repositorioProveedor,
                                   RepositorioProducto repositorioProducto,
                                   RepositorioCompra repositorioCompra) {
        this.repositorioProveedor = repositorioProveedor;
        this.repositorioProducto = repositorioProducto;
        this.repositorioCompra = repositorioCompra;
    }

    @Transactional // Todo se ejecuta en una sola transacción
    public Compra ejecutar(RegistrarCompraComando comando) {

        log.info("Registrando nueva compra para proveedor ID: {}", comando.proveedorId());

        // Validar y obtener el proveedor
        Proveedor proveedor = repositorioProveedor.buscarPorId(comando.proveedorId())
                .orElseThrow(() -> new RuntimeException("Proveedor no encontrado con ID: " + comando.proveedorId()));

        // Construir las líneas de compra (validando productos)
        List<LineaCompra> lineas = new ArrayList<>();
        for (LineaCompraRequest lineaReq : comando.lineas()) {
            // Obtener el producto del repositorio
            Producto producto = repositorioProducto.buscarPorId(lineaReq.productoId())
                    .orElseThrow(() -> new RuntimeException("Producto no encontrado con ID: " + lineaReq.productoId()));

            // Crear la línea de compra (el constructor del dominio valida cantidad > 0, precio > 0, etc.)
            LineaCompra linea = new LineaCompra(
                    producto,
                    lineaReq.cantidad(),
                    Dinero.of(lineaReq.precioUnitario())
            );
            lineas.add(linea);
        }

        // Crear la compra (el constructor del dominio valida que tenga líneas y proveedor)
        Compra nuevaCompra = new Compra(proveedor, lineas);

        // Guardar la compra en la base de datos
        Compra compraGuardada = repositorioCompra.guardar(nuevaCompra);
        log.info("Compra registrada con ID: {}", compraGuardada.getId());

        // Actualizar el stock de cada producto (efecto secundario en el mismo contexto transaccional)
        for (LineaCompra linea : lineas) {
            // Incrementar el stock del producto con la cantidad comprada
            repositorioProducto.actualizarStock(
                    linea.getDatProducto().getId(),
                    linea.getCantidad()
            );
            log.debug("Stock actualizado para producto ID: {} (+{})", linea.getDatProducto().getId(), linea.getCantidad());
        }

        // Aqui se podria registrar la deuda con el proveedor
        // dependerá de como se decida manejar las deudas o cuentas por pagar. (Aun no decidido)
        return compraGuardada;
    }
}
