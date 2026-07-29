/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

import com.tienda.app.puerto.entrada.compras.AnularCompraUseCase;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.dominio.excepcion.CompraNoEncontradaException;
import com.tienda.dominio.modelo.purchase.Compra;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */
@Service
public class ServicioAnularCompra implements AnularCompraUseCase{
    //Puerto de Salida para acceder a la persistencia de compras.
    private final RepositorioCompra repositorioCompra;
    
    public ServicioAnularCompra(RepositorioCompra repositorioCompra){
        this.repositorioCompra=repositorioCompra;
    }
    
    @Override
    public Compra ejecutar(Long id) {
        // Se busca la compra por id, si no existe se lanza excepcion controlada
        Compra compra = repositorioCompra.buscarPorId(id)
                .orElseThrow(() -> new CompraNoEncontradaException(id));

        // Se delega la validacion de negocio (no permite anular RECIBIDA o COMPLETADA)
        // al metodo anular() de la entidad de dominio Compra
        compra.anular();

        // Se persiste el nuevo estado de la compra y se retorna el objeto actualizado
        return repositorioCompra.guardar(compra);
    }
}
