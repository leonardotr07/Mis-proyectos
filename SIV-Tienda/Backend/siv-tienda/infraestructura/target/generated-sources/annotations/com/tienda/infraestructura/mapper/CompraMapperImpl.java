package com.tienda.infraestructura.mapper;

import com.tienda.dominio.modelo.purchase.Compra;
import com.tienda.dominio.valor.EstadoCompra;
import com.tienda.infraestructura.entidad.compras.EntidadCompra;
import com.tienda.infraestructura.entidad.compras.EntidadEstadoCompra;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-08-04T12:16:47-0500",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 26.0.1 (Eclipse Adoptium)"
)
@Component
public class CompraMapperImpl implements CompraMapper {

    @Override
    public EntidadCompra toEntity(Compra compra) {
        if ( compra == null ) {
            return null;
        }

        EntidadCompra entidadCompra = new EntidadCompra();

        entidadCompra.setProveedor( proveedorToEntity( compra.getProveedor() ) );
        entidadCompra.setLineas( lineasToEntities( compra.getLineas() ) );
        entidadCompra.setTotal( dineroToBigDecimal( compra.getTotal() ) );
        entidadCompra.setFechaCompra( compra.getFechaCompra() );
        entidadCompra.setEstado( estadoCompraToEntidadEstadoCompra( compra.getEstado() ) );
        entidadCompra.setId( compra.getId() );

        return entidadCompra;
    }

    protected EntidadEstadoCompra estadoCompraToEntidadEstadoCompra(EstadoCompra estadoCompra) {
        if ( estadoCompra == null ) {
            return null;
        }

        EntidadEstadoCompra entidadEstadoCompra;

        switch ( estadoCompra ) {
            case PENDIENTE: entidadEstadoCompra = EntidadEstadoCompra.PENDIENTE;
            break;
            case RECIBIDA: entidadEstadoCompra = EntidadEstadoCompra.RECIBIDA;
            break;
            case ANULADA: entidadEstadoCompra = EntidadEstadoCompra.ANULADA;
            break;
            case COMPLETADA: entidadEstadoCompra = EntidadEstadoCompra.COMPLETADA;
            break;
            default: throw new IllegalArgumentException( "Unexpected enum constant: " + estadoCompra );
        }

        return entidadEstadoCompra;
    }
}
