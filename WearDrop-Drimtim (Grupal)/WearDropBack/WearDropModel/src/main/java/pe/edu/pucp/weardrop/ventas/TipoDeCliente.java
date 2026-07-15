/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas;

/**
 *
 * @author matia
 */
public class TipoDeCliente {
    private int tipoCliente;
    private char abreviatura;
    private String descripcion;
    
    //Constructores
    
    public TipoDeCliente(){
        
    }

    public TipoDeCliente(int tipoCliente, char abreviatura, String descripcion) {
        this.tipoCliente = tipoCliente;
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
    }
    
    public TipoDeCliente(TipoDeCliente tipoCliente){
        this.abreviatura = tipoCliente.getAbreviatura();
        this.descripcion = tipoCliente.getDescripcion();
        this.tipoCliente = tipoCliente.getTipoCliente();
    }
    
    
    //Getters

    public int getTipoCliente() {
        return tipoCliente;
    }

    public char getAbreviatura() {
        return abreviatura;
    }

    public String getDescripcion() {
        return descripcion;
    }
    
    
    //Setters
    
    public void setTipoCliente(int tipoCliente) {
        this.tipoCliente = tipoCliente;
    }

    public void setAbreviatura(char abreviatura) {
        this.abreviatura = abreviatura;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
    
}
