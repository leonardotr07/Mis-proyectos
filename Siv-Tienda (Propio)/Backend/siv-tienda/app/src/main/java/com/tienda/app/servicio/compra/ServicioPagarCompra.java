/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

import com.tienda.app.puerto.entrada.compras.PagarCompraUseCase;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.excepcion.CompraNoEncontradaException;
import com.tienda.dominio.modelo.mercaderia.Producto;
import com.tienda.dominio.modelo.purchase.Compra;
import com.tienda.dominio.modelo.purchase.LineaCompra;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Leonardo
 */
@Service
public class ServicioPagarCompra implements PagarCompraUseCase{

    private final RepositorioCompra repositorioCompra;
    private final RepositorioProducto repositorioProducto;
    
    
    public ServicioPagarCompra(RepositorioCompra repositorioCompra,
            RepositorioProducto repositorioProducto) {
        this.repositorioCompra = repositorioCompra;
        this.repositorioProducto = repositorioProducto;
    }
    
    @Override
    @Transactional
    public Compra ejecutar(Long id) {
        // Se busca la compra por id, si no existe se lanza excepcion controlada
        Compra compra = repositorioCompra.buscarPorId(id)
                .orElseThrow(() -> new CompraNoEncontradaException(id));

        // Se delega al dominio: marca la compra como COMPLETADA (pagada)
        // El propio metodo lanza IllegalStateException si la compra esta ANULADA
        compra.marcarComoCompletada();

        //La compra esta pagada
        //Se recorre por cada linea para aumentar el stock de producto.
        for(LineaCompra linea : compra.getLineas()){
            
            Long productoId=linea.getDatProducto().getId();
            Producto datProducto=repositorioProducto.buscarPorId(productoId)
                    .orElseThrow(() -> new IllegalStateException ("El producto con id " 
                            + productoId + " no existe, no se pudo actualizar el stock"));
            
            datProducto.aumentarStock(linea.getCantidad());
            repositorioProducto.guardar(datProducto);
        }
        
        // Se persiste el nuevo estado y se retorna la compra actualizada
        return repositorioCompra.guardar(compra);
    }
    
}
