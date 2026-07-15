/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.clasificacionropa;

import java.util.Date;
/**
 *
 * @author leona
 */
public class Vigencia {

    /**
     * @return the idVigencia
     */
    public int getIdVigencia() {
        return idVigencia;
    }

    /**
     * @param idVigencia the idVigencia to set
     */
    public void setIdVigencia(int idVigencia) {
        this.idVigencia = idVigencia;
    }

    /**
     * @return the FechaInicio
     */
    public Date getFechaInicio() {
        return FechaInicio;
    }

    /**
     * @param FechaInicio the FechaInicio to set
     */
    public void setFechaInicio(Date FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    /**
     * @return the FechaFin
     */
    public Date getFechaFin() {
        return FechaFin;
    }

    /**
     * @param FechaFin the FechaFin to set
     */
    public void setFechaFin(Date FechaFin) {
        this.FechaFin = FechaFin;
    }
        private int idVigencia;
        private Date FechaInicio;
        private Date FechaFin;
        private boolean activo;
        public Vigencia(){};
        public Vigencia(int id,Date FechaInicio,Date FechaFin){
         this.idVigencia=id;
         this.FechaInicio=FechaInicio;
         this.FechaFin=FechaFin;
     }
     public Vigencia(Vigencia vigencia){
         this.idVigencia=vigencia.idVigencia;
         this.FechaFin=new Date();
         this.FechaFin=vigencia.FechaFin;
         this.FechaInicio=new Date();
         this.FechaInicio=vigencia.FechaInicio;
     }

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
    public void mostrar(){
        System.out.println("IdVigencia: "+idVigencia);
        System.out.println("FechaInicio: "+FechaInicio);
        System.out.println("FechaFin: "+FechaFin);
    }
}
