package com.tienda.infraestructura.mapper;

import com.tienda.dominio.modelo.mercaderia.Producto;
import com.tienda.dominio.modelo.provider.Proveedor;
import com.tienda.dominio.modelo.purchase.Compra;
import com.tienda.dominio.modelo.purchase.LineaCompra;
import com.tienda.dominio.valor.CantidadStock;
import com.tienda.dominio.valor.Dinero;
import com.tienda.dominio.valor.EstadoCompra;
import com.tienda.infraestructura.entidad.compras.EntidadCompra;
import com.tienda.infraestructura.entidad.compras.EntidadEstadoCompra;
import com.tienda.infraestructura.entidad.compras.EntidadLineaCompra;
import com.tienda.infraestructura.entidad.proveedor.EntidadProveedor;
import com.tienda.infraestructura.entidad.producto.EntidadProducto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.tomcat.util.http.parser.EntityTag;

@Mapper(componentModel = "spring")
public interface CompraMapper {

    // Dinero <-> BigDecimal
    @Named("dineroToBigDecimal")
    default BigDecimal dineroToBigDecimal(Dinero dinero) {
        return dinero != null ? dinero.monto() : null;
    }

    @Named("bigDecimalToDinero")
    default Dinero bigDecimalToDinero(BigDecimal value) {
        return value != null ? new Dinero(value) : null;
    }

    // EstadoCompra <-> EntidadEstadoCompra
    @Named("estadoToEntity")
    default EntidadEstadoCompra estadoToEntity(EstadoCompra estado) {
        if (estado == null) return null;
        switch (estado) {
            case PENDIENTE: return EntidadEstadoCompra.PENDIENTE;
            case RECIBIDA: return EntidadEstadoCompra.RECIBIDA;
            case ANULADA: return EntidadEstadoCompra.ANULADA;
            case COMPLETADA: return EntidadEstadoCompra.COMPLETADA;
            default: throw new IllegalArgumentException("Estado no soportado: " + estado);
        }
    }

    @Named("estadoToDomain")
    default EstadoCompra estadoToDomain(EntidadEstadoCompra estado) {
        if (estado == null) return null;
        switch (estado) {
            case PENDIENTE: return EstadoCompra.PENDIENTE;
            case RECIBIDA: return EstadoCompra.RECIBIDA;
            case ANULADA: return EstadoCompra.ANULADA;
            case COMPLETADA: return EstadoCompra.COMPLETADA;
            default: throw new IllegalArgumentException("Estado no soportado: " + estado);
        }
    }

    // Proveedor <-> EntidadProveedor
    @Named("proveedorToEntity")
    default EntidadProveedor proveedorToEntity(Proveedor proveedor) {
        if (proveedor == null) return null;
        EntidadProveedor entity = new EntidadProveedor();
        entity.setId(proveedor.getId());
        entity.setNombre(proveedor.getNombre());
        entity.setRuc(proveedor.getRuc());
        entity.setTelefono(proveedor.getTelefono());
        entity.setEmail(proveedor.getEmail());
        entity.setDireccion(proveedor.getDireccion());
        return entity;
    }

    @Named("proveedorToDomain")
    default Proveedor proveedorToDomain(EntidadProveedor entity) {
        if (entity == null) return null;
        return new Proveedor(
                entity.getId(),
                entity.getNombre(),
                entity.getRuc(),
                entity.getTelefono(),
                entity.getEmail(),
                entity.getDireccion()
        );
    }

    // Producto <-> EntidadProducto (usando ProductoMapper)
    @Autowired
    default ProductoMapper getProductoMapper() { return null; } // Será inyectado por Spring

    @Named("productoToEntity")
    default EntidadProducto productoToEntity(Producto producto) {
        // Delegar al ProductoMapper existente si está disponible
        ProductoMapper mapper = getProductoMapper();
        if (mapper != null) {
            return mapper.toEntity(producto);
        }
        // Fallback manual si el mapper no está disponible
        if (producto == null) return null;
        EntidadProducto entity = new EntidadProducto();
        entity.setId(producto.getId());
        entity.setNombre(producto.getNombre());
        entity.setDescripcion(producto.getDescripcion());
        entity.setCategoria(producto.getCategoria());
        entity.setPrecio(dineroToBigDecimal(producto.getPrecio()));
        entity.setStock(producto.getStock().valor());
        entity.setStockMinimo(producto.getStockMinimo().valor());
        return entity;
    }

    @Named("productoToDomain")
    default Producto productoToDomain(EntidadProducto entity) {
        // Delegar al ProductoMapper existente si está disponible
        ProductoMapper mapper = getProductoMapper();
        if (mapper != null) {
            return mapper.toDominio(entity);
        }
        // Fallback manual
        if (entity == null) return null;
        return new Producto(
                entity.getId(),
                entity.getNombre(),
                entity.getDescripcion(),
                bigDecimalToDinero(entity.getPrecio()),
                new CantidadStock(entity.getStock()),
                new CantidadStock(entity.getStockMinimo()),
                entity.getCategoria()
        );
    }

    //Conversion de Lineas

    @Named("lineaToEntity")
    default EntidadLineaCompra lineaToEntity(LineaCompra dominio) {
        if (dominio == null) return null;
        EntidadLineaCompra entity = new EntidadLineaCompra();
        entity.setId(dominio.getId());
        entity.setProducto(productoToEntity(dominio.getDatProducto())); // ← getDatProducto()
        entity.setCantidad(dominio.getCantidad());
        entity.setPrecioUnitario(dineroToBigDecimal(dominio.getPrecioUnitario()));
        entity.setSubtotal(dineroToBigDecimal(dominio.getSubTotal())); // ← getSubTotal()
        // La relación con la compra se establece desde el padre (CompraEntity)
        return entity;
    }

    @Named("lineaToDomain")
    default LineaCompra lineaToDomain(EntidadLineaCompra entity) {
        if (entity == null) return null;
        Producto producto = productoToDomain(entity.getProducto());
        return new LineaCompra(
                entity.getId(),
                producto,
                entity.getCantidad(),
                bigDecimalToDinero(entity.getPrecioUnitario())
        );
    }

    @Named("lineasToEntities")
    default List<EntidadLineaCompra> lineasToEntities(List<LineaCompra> lineas) {
        if (lineas == null) return null;
        return lineas.stream()
                .map(this::lineaToEntity)
                .collect(Collectors.toList());
    }

    @Named("lineasToDomain")
    default List<LineaCompra> lineasToDomain(List<EntidadLineaCompra> entities) {
        if (entities == null) return null;
        return entities.stream()
                .map(this::lineaToDomain)
                .collect(Collectors.toList());
    }

    //MapStruct

    
    @Mapping(target = "proveedor", source = "proveedor", qualifiedByName = "proveedorToEntity")
    @Mapping(target = "lineas", source = "lineas", qualifiedByName = "lineasToEntities")
    @Mapping(target = "total", source = "total", qualifiedByName = "dineroToBigDecimal")
    @Mapping(target = "fechaCompra", source = "fechaCompra")
    @Mapping(target = "estado", source = "estado")
    EntidadCompra toEntity(Compra compra);

    // EntidadCompra -> Compra
    default Compra toDomain(EntidadCompra entity) {
        if (entity == null) return null;
        Proveedor proveedor = proveedorToDomain(entity.getProveedor());
        List<LineaCompra> lineas = lineasToDomain(entity.getLineas());
        return new Compra(
            entity.getId(),          
            proveedor,
            lineas,
            entity.getFechaCompra(),
            estadoToDomain(entity.getEstado())
        );
    }
}
