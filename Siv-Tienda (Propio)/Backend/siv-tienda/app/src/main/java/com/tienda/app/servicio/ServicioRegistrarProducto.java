/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.app.servicio;

import com.tienda.app.comando.RegistrarProductoComando;
import com.tienda.app.puerto.entrada.RegistrarProductoUseCase;
import com.tienda.app.puerto.salida.RepositorioProducto;
import com.tienda.dominio.modelo.Producto;
import com.tienda.dominio.valor.CantidadStock;
import com.tienda.dominio.valor.Dinero;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Leonardo
 */
@Service //Clase Servicio


public class ServicioRegistrarProducto implements RegistrarProductoUseCase{

    //Interfaz de puerto de salida inyectado
    private final RepositorioProducto repositorioProducto;
    
    public ServicioRegistrarProducto(RepositorioProducto repPro){
        this.repositorioProducto=repPro;
    }
    
    @Override
    @Transactional //Para la BD... Si algo falla, todo se deshace con rollback
    public Producto ejecutar(RegistrarProductoComando comando) {
        
        //Convertimos los datos de planos a Objetos del dominio
        Dinero precio=Dinero.of(comando.precio());
        CantidadStock stockIni=new CantidadStock(comando.stockInicial());
        CantidadStock stockMin=new CantidadStock(comando.stockMinimo());
        
        //Creamos el objeto
        Producto nuevoProducto=new Producto(comando.nombre(), comando.descripcion(),
                precio, stockIni, stockMin);
        //Lo guardamos por el puerto de salida
        return repositorioProducto.guardar(nuevoProducto);
    }
    
}
