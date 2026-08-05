/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.tienda;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.clasificacionropa.Catalogo;
/*@author Leonardo.T*/
public class Tienda {
    //Atributos
    private int id;
    private String nombre;
    private String ubicacion; //Dirección?
    
    //Relaciones (Almacen y Catalogo)
    private final ArrayList<Almacen>almacenes;
    private Catalogo catalogo;
    
    
    
    //Constructor con parametros
    public Tienda(int id, String nombre, String ubicacion) {
        this.id = id;
        this.nombre = nombre;
        this.ubicacion = ubicacion;
        this.catalogo=null; //El catalogo lo asignará por separado... (Igual no estoy seguro, pero creeria q si)
        this.almacenes=new ArrayList<>(); //Declara el espacio del Catalogo, asi esta disponible para agregar...
    }
    
    //Capaz se cambia esto... por una clase Catalogo
    public void asignarCatalogo(int idCat, String nombreCat){
        this.catalogo=new Catalogo(idCat, nombre);
    }
    
    public void mostrarCatalogo(){
        if(this.catalogo==null)
            System.out.println("No se ha asignado un catalogo a la tienda.\n");
        else{
            //Método de mostrarCatalogo en la clase Catalogo.
            System.out.println("Existe un catalogo registrados.\n");
        }
    }
    
    //Almacen ya creado? Puede ser..., Lo digo para no tener que asignar Almacen con lote y crear varios metodos
    //Igual esto puede ser modificado, pero capaz hay q discutirlo
    public void agregarAlmacen(Almacen datAlmacen){
        this.almacenes.add(datAlmacen);
    }
    
    public void mostrarAlmacenes(){
        boolean listaVacia=true;
        for(Almacen datAlmacen: almacenes){
            //datAlmacen.mostrarAlmacen(); Aun no existe
            System.out.println("Almacen almacenado con exito.\n");
            listaVacia=false;
        }
        if(listaVacia) System.out.println("No existen almacenes asignados a la tienda.\n");
    }

    //Getter y Setter de Catalogo.
    public Catalogo getCatalogo() {
        return catalogo;
    }

    public void setCatalogo(Catalogo catalogo) {
        this.catalogo = catalogo;
    }
    
    
    //Getters y Setters de int y String
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }
    
    
}
