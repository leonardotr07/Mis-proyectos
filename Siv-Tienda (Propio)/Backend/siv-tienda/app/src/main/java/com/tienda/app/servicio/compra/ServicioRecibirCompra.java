/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

import com.tienda.app.puerto.entrada.compras.RecibirCompraUseCase;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.dominio.excepcion.CompraNoEncontradaException;
import com.tienda.dominio.modelo.purchase.Compra;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */
@Service
public class ServicioRecibirCompra implements RecibirCompraUseCase{

    private final RepositorioCompra repositorioCompra;
    
    public ServicioRecibirCompra(RepositorioCompra repCompra){
        this.repositorioCompra=repCompra;
    }
    
    @Override
    public Compra ejecutar(Long id) {
        Compra compra=repositorioCompra.buscarPorId(id).orElseThrow(() -> new CompraNoEncontradaException(id));
        
        compra.marcarComoRecibida();
        
        return repositorioCompra.actualizarEstado(compra);
    }
    
}
