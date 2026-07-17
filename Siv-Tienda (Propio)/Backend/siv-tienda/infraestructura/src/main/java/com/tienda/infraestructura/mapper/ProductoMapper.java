package com.tienda.infraestructura.mapper;



import com.tienda.dominio.modelo.Producto;
import com.tienda.dominio.valor.CantidadStock;
import com.tienda.dominio.valor.Dinero;
import com.tienda.infraestructura.entidad.EntidadProducto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.factory.Mappers;
import java.math.BigDecimal;

@Mapper(componentModel = "spring")
public interface ProductoMapper {

    /*
     * Convierte EntidadProducto a Producto 
     */
    // Mapea los atributos de la EntidadProducto a descripcion de la Producto
    @Mapping(source = "descripcion", target = "descripcion") 
    @Mapping(target = "nombre", source = "nombre")
    //qualifiedName convierte de BigDecimal a Dinero (clase de dominio)
    @Mapping(target = "precio", source = "precio", qualifiedByName = "dineroFromBigDecimal")
    @Mapping(target = "stock", source = "stock", qualifiedByName = "stockFromInteger")
    @Mapping(target = "stockMinimo", source = "stockMinimo", qualifiedByName = "stockFromInteger")
    @Mapping(target = "id", source = "id")  // El id se pasa como Long
    @Mapping(target = "categoria", source = "categoria")
    Producto toDominio(EntidadProducto entidad);

    
    @Mapping(source = "descripcion", target = "descripcion")  // Mapea desc → descripcion
    @Mapping(target = "id", source = "id")
    @Mapping(target = "nombre", source = "nombre")
    @Mapping(target = "precio", source = "precio", qualifiedByName = "bigDecimalFromDinero")
    @Mapping(target = "stock", source = "stock", qualifiedByName = "integerFromStock")
    @Mapping(target = "stockMinimo", source = "stockMinimo", qualifiedByName = "integerFromStock")
    @Mapping(target = "categoria", source = "categoria")
    EntidadProducto toEntity(Producto dominio);

    // Conversores 

    @Named("dineroFromBigDecimal")
    default Dinero dineroFromBigDecimal(BigDecimal valor) {
        //Si el valor es diferente de null. Entonces otorga la clase Dinero , sino retorna null
        //Recordar que Dinero es un record (registro), no una clase
        return valor != null ? new Dinero(valor) : null;
    }

    @Named("bigDecimalFromDinero")
    default BigDecimal bigDecimalFromDinero(Dinero dinero) {
        //Si dinero != null entonces retorna el bigDecimal de Dinero, sino, null
        return dinero != null ? dinero.monto() : null;
    }

    //Se igual manera con integer a Stock
    @Named("stockFromInteger")
    default CantidadStock stockFromInteger(Integer value) {
        return value != null ? new CantidadStock(value) : null;
    }

    @Named("integerFromStock")
    default Integer integerFromStock(CantidadStock stock) {
        return stock != null ? stock.valor() : null;
    }
}