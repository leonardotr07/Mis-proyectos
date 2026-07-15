/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.weardrop.comprobantes.ComprobanteDePago;
import pe.edu.pucp.weardrop.personal.Empleado;

public class Venta {
    private int idVenta;
    private Date fecha;
    private ArrayList<ItemVenta> productos;
    private double total;
    private int idComprobante;
    private boolean activo;
    private Cliente cliente;
    private Empleado empleado;
    
    
    //Constructores
    
    public Venta(){
        this.productos = new ArrayList<>();
        this.cliente = new Cliente();
        this.empleado = new Empleado();
    }

    public Venta(int idVenta, Date fecha, double total,
            ArrayList<ItemVenta> productos,ComprobanteDePago
                    comprabante , boolean activo,
                    Cliente cliente , Empleado empleado) {
        this.idVenta = idVenta;
        this.fecha = fecha;
        this.productos = new ArrayList<>(productos);
        this.total = total;
        this.activo = activo;
        this.cliente = new Cliente(cliente);
        this.empleado = new Empleado(empleado);
    }
    
    public Venta(Venta venta){
        this.idVenta = venta.getIdVenta();
        this.total = venta.getTotal();
        this.productos = new ArrayList<>(venta.getProductos());
        this.fecha = venta.getFecha();
        this.idComprobante = venta.getIdComprobante();
        this.activo = venta.isActivo();
        this.cliente = new Cliente (venta.getCliente());
        this.empleado = new Empleado (venta.getEmpleado());
    }

    //Getters

    public ArrayList<ItemVenta> getProductos() {
        return productos;
    }
    
    public int getIdVenta() {
        return idVenta;
    }

    public Date getFecha() {
        return fecha;
    }

    public double getTotal() {
        return total;
    }

    
    
    public boolean isActivo() {
        return activo;
    }
    
    public Cliente getCliente() {
        return new Cliente(cliente);
    }
    
    public Empleado getEmpleado() {
        return new Empleado(empleado);
    }
    
    // Setters

    public void setProductos(ArrayList<ItemVenta> productos) {
        this.productos = new ArrayList<>(productos);
    }
    

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    public void setCliente(Cliente cliente) {
        this.cliente = new Cliente(cliente);
    }
    public void setEmpleado(Empleado empleado) {
        this.empleado = new Empleado(empleado);
    }

    public int getIdComprobante() {
        return idComprobante;
    }

    public void setIdComprobante(int idComprabante) {
        this.idComprobante = idComprabante;
    }
    
    
}
