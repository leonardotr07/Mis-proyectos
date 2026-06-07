/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

/**
 *
 * @author matia
 */
public class CondicionPago {
    
    private int idCondicion;
    private String descripcion;
    private int numDias;
    private boolean vigente;
    
    //Constructor por defecto
    public CondicionPago(){
        
    }
    
    //Constructor con parametros

    public CondicionPago(int idCondicion, String descripcion, int numDias, boolean vigente) {
        this.idCondicion = idCondicion;
        this.descripcion = descripcion;
        this.numDias = numDias;
        this.vigente = vigente;
    }
    
    //Constructor Copia
    
    public CondicionPago(CondicionPago condicionPago){
        this.idCondicion = condicionPago.getIdCondicion();
        this.descripcion = condicionPago.getDescripcion();
        this.numDias = condicionPago.getNumDias();
        this.vigente = condicionPago.isVigente();
        
    }
    
    
    
    //Getters

    public int getIdCondicion() {
        return idCondicion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getNumDias() {
        return numDias;
    }

    public boolean isVigente() {
        return vigente;
    }
    
    
    //Setters

    public void setIdCondicion(int idCondicion) {
        this.idCondicion = idCondicion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setNumDias(int numDias) {
        this.numDias = numDias;
    }

    public void setVigente(boolean vigente) {
        this.vigente = vigente;
    }
    
    
    
    
    
}
