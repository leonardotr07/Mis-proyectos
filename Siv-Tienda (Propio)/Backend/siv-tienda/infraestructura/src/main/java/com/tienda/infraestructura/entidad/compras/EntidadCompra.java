/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tienda.infraestructura.entidad.compras;

import com.tienda.infraestructura.entidad.proveedor.EntidadProveedor;
import com.tienda.dominio.valor.EstadoCompra;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Leonardo
 */

@Entity
@Table(name="compras")
public class EntidadCompra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    //Si 2 transacciones son ejecutadas a la vez. Lanza OptimisticLockException (Concurrencia)
    @Version
    @Column(nullable=false, columnDefinition = "BIGINT DEFAULT 0")
    private Long version;

    // Relación ManyToOne con ProveedorEntity. Lazy loading para evitar traer proveedores innecesariamente.
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proveedor_id", nullable = false)
    private EntidadProveedor proveedor;

    @Column(name = "fecha_compra", nullable = false)
    private LocalDateTime fechaCompra;

    @Enumerated(EnumType.STRING) // Guarda el nombre del enum (PENDIENTE, RECIBIDA, etc.)
    @Column(nullable = false)
    private EntidadEstadoCompra estado;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal total;
    
    // Cascade ALL: todas las operaciones (persist, merge, remove) se propagan a las líneas.
    /*
    - Persist: Guarda la entidad principal en la BD
    - Merge: Actualiza los datos de una entidad modificada, que estaba desconectada del sistema
    - Remove: Borra la entidad principal de la BD y ejecuta la eliminación de los registros hijos
    */
    
    // orphanRemoval = true: si se elimina una línea de la lista, también se elimina de la BD.
    @OneToMany(mappedBy = "compra", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<EntidadLineaCompra> lineas = new ArrayList<>();

    // Método auxiliar para agregar una línea y establecer la relación bidireccional
    public void agregarLinea(EntidadLineaCompra linea) {
        lineas.add(linea);
        linea.setCompra(this);
    }

    //Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public EntidadProveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(EntidadProveedor proveedor) {
        this.proveedor = proveedor;
    }

    public LocalDateTime getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(LocalDateTime fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public EntidadEstadoCompra getEstado() {
        return estado;
    }

    public void setEstado(EntidadEstadoCompra estado) {
        this.estado = estado;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public List<EntidadLineaCompra> getLineas() {
        return lineas;
    }

    public void setLineas(List<EntidadLineaCompra> lineas) {
        this.lineas = lineas;
    }
    
    
}
