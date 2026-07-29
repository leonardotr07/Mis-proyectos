/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio.proveedor;

import com.tienda.app.puerto.entrada.proveedor.ListarProveedoresUseCase;
import com.tienda.app.puerto.salida.RepositorioProveedor;
import com.tienda.dominio.modelo.provider.Proveedor;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leonardo
 */

@Service
public class ServicioListarProveedor implements ListarProveedoresUseCase {
    private final RepositorioProveedor repositorioProveedor;

    public ServicioListarProveedor(RepositorioProveedor repositorioProveedor) {
        this.repositorioProveedor = repositorioProveedor;
    }
    
    @Override
    public List<Proveedor> ejecutar() {
        return repositorioProveedor.listarTodos();
    }
}
