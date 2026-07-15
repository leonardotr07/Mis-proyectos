/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones;

import java.util.Date;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.Talla;


public class Devolucion {
    private int id;
    private String descripcion;
    private int idEmpleado;
    private int idProveedor;
    private int idPrenda;
    private Talla talla;
    private int cantidad;
    private double monto;
    private Date fecha;
    private boolean activo;

    private Proveedor proveedor;
    private String Nombreprenda;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public int getIdEmpleado() { return idEmpleado; }
    public void setIdEmpleado(int idEmpleado) { this.idEmpleado = idEmpleado; }

    public int getIdProveedor() { return idProveedor; }
    public void setIdProveedor(int idProveedor) { this.idProveedor = idProveedor; }

    public int getIdPrenda() { return idPrenda; }
    public void setIdPrenda(int idPrenda) { this.idPrenda = idPrenda; }

    public Talla getTalla() { return talla; }
    public void setTalla(Talla talla) { this.talla = talla; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public double getMonto() { return monto; }
    public void setMonto(double monto) { this.monto = monto; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    public Proveedor getProveedor() { return proveedor; }
    public void setProveedor(Proveedor proveedor) { this.proveedor = proveedor; }

    public String getNombrePrenda() { return Nombreprenda; }
    public void setNombrePrenda(String prenda) { this.Nombreprenda = prenda; }
}

