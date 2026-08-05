/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

import com.tienda.app.puerto.entrada.compras.ObtenerCompraPorIdUseCase;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.dominio.modelo.purchase.Compra;
import java.util.Optional;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */

@Service
public class ServicioObtenerCompraPorId implements ObtenerCompraPorIdUseCase{
    private final RepositorioCompra repositorioCompra;

    public ServicioObtenerCompraPorId(RepositorioCompra repositorioCompra) {
        this.repositorioCompra = repositorioCompra;
    }
    
    @Override
    public Optional<Compra> ejecutar(Long id) {
        return repositorioCompra.buscarPorId(id);
    }
}
