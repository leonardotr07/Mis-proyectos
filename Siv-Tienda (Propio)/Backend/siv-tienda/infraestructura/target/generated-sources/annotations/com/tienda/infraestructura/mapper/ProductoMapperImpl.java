package com.tienda.infraestructura.mapper;

import com.tienda.dominio.modelo.Producto;
import com.tienda.infraestructura.entidad.EntidadProducto;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-07-21T12:34:57-0500",
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
        producto.setCategoria( entidad.getCategoria() );

        return producto;
    }

    @Override
    public EntidadProducto toEntity(Producto dominio) {
        if ( dominio == null ) {
            return null;
        }

        EntidadProducto entidadProducto = new EntidadProducto();

        entidadProducto.setDescripcion( dominio.getDescripcion() );
        entidadProducto.setId( dominio.getId() );
        entidadProducto.setNombre( dominio.getNombre() );
        entidadProducto.setPrecio( bigDecimalFromDinero( dominio.getPrecio() ) );
        entidadProducto.setStock( integerFromStock( dominio.getStock() ) );
        entidadProducto.setStockMinimo( integerFromStock( dominio.getStockMinimo() ) );
        entidadProducto.setCategoria( dominio.getCategoria() );

        return entidadProducto;
    }
}
