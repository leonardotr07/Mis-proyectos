/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.clasificacionropa;

/**
 *
 * @author Leonardo
 */
public class LineaDeRopa {
    private int idLinea;
    private String nombreLinea;
    private String descripcion;
    
    //Relaciones Vigencia y Prenda
    
    //Constructor, si se necesitase otro 
    public LineaDeRopa(int idLinea, String nombreLinea, String descripcion) {
        this.idLinea = idLinea;
        this.nombreLinea = nombreLinea;
        this.descripcion = descripcion;
    }
    
    //Getters y Setters
    public int getIdLinea() {
        return idLinea;
    }

    public void setIdLinea(int idLinea) {
        this.idLinea = idLinea;
    }

    public String getNombreLinea() {
        return nombreLinea;
    }

    public void setNombreLinea(String nombreLinea) {
        this.nombreLinea = nombreLinea;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
}
