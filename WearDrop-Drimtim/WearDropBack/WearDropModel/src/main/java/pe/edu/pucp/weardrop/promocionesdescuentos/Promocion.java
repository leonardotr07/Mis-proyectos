/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocionesdescuentos;

import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;

/**
 *
 * @author leona
 */
public abstract class Promocion {

    /**
     * @return the activo
     */
    public boolean isActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    /**
     * @return the vigencia
     */
    public Vigencia getVigencia() {
        return vigencia;
    }

    /**
     * @param vigencia the vigencia to set
     */
    public void setVigencia(Vigencia vigencia) {
        this.vigencia = vigencia;
    }

    /**
     * @return the idPromocion
     */
    public int getIdPromocion() {
        return idPromocion;
    }

    /**
     * @param idPromocion the idPromocion to set
     */
    public void setIdPromocion(int idPromocion) {
        this.idPromocion = idPromocion;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the esAutomatico
     */
    public boolean isEsAutomatico() {
        return esAutomatico;
    }
    public Promocion(){}
    /**
     * @param esAutomatico the esAutomatico to set
     */
    public void setEsAutomatico(boolean esAutomatico) {
        this.esAutomatico = esAutomatico;
    }
    private int idPromocion;
    private String nombre;
    private boolean esAutomatico;
    private boolean activo;
    private Vigencia vigencia;
    public Promocion(int id,String nombre,boolean automatico,boolean activo,Vigencia vigencia){
        this.idPromocion=id;
        this.nombre=nombre;
        this.esAutomatico=automatico;
        this.activo=activo;
        this.vigencia=new Vigencia(vigencia);
        
    }
    public Promocion(Promocion promocion){
        this.nombre=promocion.getNombre();
        this.esAutomatico=promocion.esAutomatico;
        this.activo=activo;
    }
    
}
