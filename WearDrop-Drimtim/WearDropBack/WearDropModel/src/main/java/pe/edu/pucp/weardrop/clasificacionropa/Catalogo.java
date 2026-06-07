/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.clasificacionropa;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.LineaDeRopa;

/**
 *
 * @author Leonardo
 */
public class Catalogo {
    //Atributos
    private int idCatalogo;
    private String nombre;
    
    //Relaciones (Linea de Ropa)
    private final ArrayList<LineaDeRopa>lineasDeRopa;

    //Constructor con parametros solo Atributos
    public Catalogo(int idCatalogo, String nombre) {
        this.idCatalogo = idCatalogo;
        this.nombre = nombre;
        this.lineasDeRopa=new ArrayList<>();
    }
    
    //Getters y Setters de todos los atributos
    public int getIdCatalogo() {
        return idCatalogo;
    }

    public void setIdCatalogo(int idCatalogo) {
        this.idCatalogo = idCatalogo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
}
