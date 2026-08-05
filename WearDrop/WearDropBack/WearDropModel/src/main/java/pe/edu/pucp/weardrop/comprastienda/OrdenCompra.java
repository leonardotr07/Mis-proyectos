/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.weardrop.personal.Empleado;

/**
 *
 * @author matia
 */
public class OrdenCompra {
    private int idCompra;
    private Date fechaLlegada;
    private Date fechaEmision;
    private ArrayList<LineaLoteCompra> items;
    private double deudaPendiente;
    private Proveedor proveedor;
    private double montoTotal;
    private boolean activo;
    private Empleado empleado; 
    
    //construtor por defecto
    public OrdenCompra(){
        this.items = new ArrayList<>();
        this.proveedor = new Proveedor();
    }
    
    //constructor con parametros
    public OrdenCompra(int idCompra, Date fechaLlegada, 
            Date fechaEmision,
            ArrayList<LineaLoteCompra> items
            ,double deudaPendiente,
            Proveedor proveedor,double montoTotal,
            boolean  activo, Empleado empleado) {
        this.idCompra = idCompra;
        this.fechaLlegada = fechaLlegada;
        this.fechaEmision = fechaEmision;
        this.items = new ArrayList<>(items);
        this.deudaPendiente = deudaPendiente;
        this.proveedor = new Proveedor(proveedor);
        this.montoTotal = montoTotal;
        this.activo = activo;
        this.empleado = empleado;
    }
    
    //constructor copia
    public OrdenCompra(OrdenCompra ordenCompra){
        this.idCompra = ordenCompra.getIdCompra();
        this.fechaLlegada = ordenCompra.getFechaLlegada();
        this.fechaEmision = ordenCompra.getFechaEmision();
        this.items = new ArrayList<>(ordenCompra.getItems());
        this.deudaPendiente = ordenCompra.getDeudaPendiente();
        this.proveedor = 
                new Proveedor (ordenCompra.getProveedor());
        this.montoTotal = ordenCompra.getMontoTotal();
        this.activo = ordenCompra.isActivo();
        this.empleado = ordenCompra.getEmpleado();
        
    }
    
    
    //Getters

    public int getIdCompra() {
        return idCompra;
    }

    public Date getFechaLlegada() {
        return fechaLlegada;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public ArrayList<LineaLoteCompra> getItems() {
        return items;
    }
    
    public double getDeudaPendiente() {
        return deudaPendiente;
    }

    public double getMontoTotal() {
        return montoTotal;
    }

    public Proveedor getProveedor() {
        return new Proveedor(proveedor);
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public Empleado getEmpleado() {
        return empleado;
    }

    
    //Setters

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public void setFechaLlegada(Date fechaLlegada) {
        this.fechaLlegada = fechaLlegada;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public void setItems(ArrayList<LineaLoteCompra> items) {
        this.items = new ArrayList<>(items);
    }

    public void setDeudaPendiente(double deudaPendiente) {
        this.deudaPendiente = deudaPendiente;
    }

    public void setMontoTotal(double montoTotal) {
        this.montoTotal = montoTotal;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = new Proveedor(proveedor);
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    public void setEmpleado(Empleado empleado) {
        this.empleado = empleado;
    }
    
    
}
