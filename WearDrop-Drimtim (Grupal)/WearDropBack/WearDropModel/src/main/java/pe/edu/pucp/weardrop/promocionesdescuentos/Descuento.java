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
public abstract class Descuento {

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
     * @return the idDescuento
     */
    public int getIdDescuento() {
        return idDescuento;
    }

    /**
     * @param idDescuento the idDescuento to set
     */
    public void setIdDescuento(int idDescuento) {
        this.idDescuento = idDescuento;
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

    /**
     */
    public Descuento(){}
    public void setEsAutomatico(boolean esAutomatico) {
        this.esAutomatico = esAutomatico;
    }
     private int idDescuento;
     private String nombre;
     private boolean esAutomatico;
     private boolean activo;
     private Vigencia vigencia;
     
     public Descuento(int id,String nombre, boolean esAutomatico,boolean activo,Vigencia vigencia){
        this.idDescuento=id;
        this.nombre=nombre;
        this.esAutomatico=esAutomatico;
        this.activo=activo;
        this.vigencia=new Vigencia(vigencia);
     }
     public Descuento(Descuento descuento){
         this.idDescuento=descuento.idDescuento;
         this.nombre=descuento.getNombre();
         this.esAutomatico=descuento.esAutomatico;
         this.activo=descuento.activo;
         this.vigencia=new Vigencia(descuento.getVigencia());
     }
      @Override
    public String toString() {
        
        return this.nombre;
    }
    
    
    
}
