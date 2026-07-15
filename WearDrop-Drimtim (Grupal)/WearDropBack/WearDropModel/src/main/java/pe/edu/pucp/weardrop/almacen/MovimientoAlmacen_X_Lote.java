/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacen_X_Lote {
    //Atributos
    private int idMov_X_Lote;
    private Lote datLote;
    private MovimientoAlmacen datMov;
    private boolean activo;

    //Constructor
    public MovimientoAlmacen_X_Lote(){}
    
    //Constructor Copia
    
    public MovimientoAlmacen_X_Lote(MovimientoAlmacen_X_Lote datMovAlmacen_X_Lote){
        this.activo=datMovAlmacen_X_Lote.isActivo();
        this.idMov_X_Lote=datMovAlmacen_X_Lote.getIdMov_X_Lote();
        this.datLote=new Lote(datMovAlmacen_X_Lote.getDatLote());
        this.datMov=new MovimientoAlmacen(datMovAlmacen_X_Lote.getDatMov());
    }
    
    
    //Método
    
    public void mostrarDatos(){
        System.out.println("Id: "+ idMov_X_Lote);
        System.out.println("IdLote: "+ datLote.getIdLote());
        System.out.println("IdMovimiento: "+ datMov.getIdMovimiento());
        System.out.println("IdAlmacen del Movimiento: "+ datMov.getDatAlmacen().getId());
        
        System.out.println("Activo: "+ activo);
    }
    
    //Getters y Setters
    
    public int getIdMov_X_Lote() {
        return idMov_X_Lote;
    }
    
    public void setIdMov_X_Lote(int idMov_X_Lote) {
        this.idMov_X_Lote = idMov_X_Lote;
    }

    public Lote getDatLote() {
        return datLote;
    }

    public void setDatLote(Lote datLote) {
        this.datLote = datLote;
    }

    public MovimientoAlmacen getDatMov() {
        return datMov;
    }

    public void setDatMov(MovimientoAlmacen datMov) {
        this.datMov = datMov;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
