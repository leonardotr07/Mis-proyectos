/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

import java.util.ArrayList;

/**
 *
 * @author matia
 */
public class Proveedor {
    
    private int idProveedor;
    private long RUC;
    private String nombre;
    private int telefono;
    private String direccion;
    private boolean activo;
    private ArrayList<CondicionPago> condiciones; 
    
    //Contructor por defecto
    public Proveedor(){
        this.condiciones = new ArrayList<>();
    }
    
    
    //Constructor con parametros

    public Proveedor(int idProveedor, long RUC,
            String nombre, int telefono, 
            String direccion, boolean activo,
            ArrayList<CondicionPago> condiciones) {
        this.idProveedor = idProveedor;
        this.RUC = RUC;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
        this.activo = activo;
        this.condiciones = 
                new ArrayList<>(condiciones);
    }
     
    //Contructor copia
    
    public Proveedor(Proveedor proveedor){
        this.idProveedor = proveedor.getIdProveedor();
        this.RUC = proveedor.getRUC();
        this.nombre = proveedor.getNombre();
        this.telefono = proveedor.getTelefono();
        this.direccion = proveedor.getDireccion();
        this.activo = proveedor.isActivo();
        this.condiciones = 
                new ArrayList<>(proveedor.getCondiciones());
        
    }
    
    
    //Getters

    public int getIdProveedor() {
        return idProveedor;
    }

    public long getRUC() {
        return RUC;
    }

    public String getNombre() {
        return nombre;
    }

    public int getTelefono() {
        return telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public boolean isActivo() {
        return activo;
    }

    public ArrayList<CondicionPago> getCondiciones() {
        return condiciones;
    }
    
    
    
    
    
    
    //Setters

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public void setRUC(long RUC) {
        this.RUC = RUC;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public void setCondiciones(ArrayList<CondicionPago> condiciones) {
        this.condiciones = new ArrayList<>(condiciones);
    }
    
    
    
    
    
    
    
}
