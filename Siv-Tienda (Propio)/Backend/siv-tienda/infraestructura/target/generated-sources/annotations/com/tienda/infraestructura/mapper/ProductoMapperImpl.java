package com.tienda.infraestructura.mapper;

import com.tienda.dominio.modelo.Producto;
import com.tienda.infraestructura.entidad.EntidadProducto;
import java.math.BigDecimal;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-07-14T15:24:40-0500",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 26.0.1 (Eclipse Adoptium)"
)
@Component
public class ProductoMapperImpl implements ProductoMapper {

    @Override
    public Producto toDominio(EntidadProducto entidad) {
        if ( entidad == null ) {
            return null;
        }

        Producto producto = new Producto();

        producto.setDescripcion( entidad.getDescripcion() );
        producto.setNombre( entidad.getNombre() );
        producto.setPrecio( dineroFromBigDecimal( entidad.getPrecio() ) );
        producto.setStock( stockFromInteger( entidad.getStock() ) );
        producto.setStockMinimo( stockFromInteger( entidad.getStockMinimo() ) );
        producto.setId( entidad.getId() );

        return producto;
    }

    @Override
    public EntidadProducto toEntity(Producto dominio) {
        if ( dominio == null ) {
            return null;
        }

        String descripcion = null;
        Long id = null;
        String nombre = null;
        BigDecimal precio = null;
        Integer stock = null;
        Integer stockMinimo = null;

        descripcion = dominio.getDescripcion();
        id = dominio.getId();
        nombre = dominio.getNombre();
        precio = bigDecimalFromDinero( dominio.getPrecio() );
        stock = integerFromStock( dominio.getStock() );
        stockMinimo = integerFromStock( dominio.getStockMinimo() );

        EntidadProducto entidadProducto = new EntidadProducto( id, nombre, descripcion, precio, stock, stockMinimo );

        return entidadProducto;
    }
}
