/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.compra;

import com.tienda.app.puerto.entrada.compras.ListarComprasUseCase;
import com.tienda.app.puerto.salida.RepositorioCompra;
import com.tienda.dominio.modelo.purchase.Compra;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */

@Service
public class ServicioListarCompras implements ListarComprasUseCase {
    private final RepositorioCompra repositorioCompra;

    public ServicioListarCompras(RepositorioCompra repositorioCompra) {
        this.repositorioCompra = repositorioCompra;
    }
    
    @Override
    public List<Compra> ejecutar() {
        return repositorioCompra.listarTodos();
    }
}
