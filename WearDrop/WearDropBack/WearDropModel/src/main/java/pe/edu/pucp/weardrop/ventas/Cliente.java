/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.Persona;

/**
 *
 * @author matia
 */
public class Cliente extends Persona {
    //Atributos
    private int idCliente;
    private TipoDeCliente tipo;
    private boolean activo;
    private ArrayList<Venta> historialCompras;
    
    
    //Constructores
    
    public Cliente() {
        super();
        //creando instancia para el atributo
        this.tipo = new TipoDeCliente();
        this.historialCompras = new ArrayList<>();
    }
    
    //Constructor con parametros

    public Cliente(int idPersona, String nombre, 
            String primerApellido, 
                String segundoApellido, 
                int dni, int telefono,
                char genero
            ,int idCliente, TipoDeCliente tipo,
            ArrayList<Venta> historialCompras, boolean activo ) {
        
        super(idPersona, nombre, primerApellido, segundoApellido, dni, 
                    telefono, genero);
        
        this.idCliente = idCliente;
        this.tipo = new TipoDeCliente(tipo);
        this.historialCompras = 
                new ArrayList<>(historialCompras);
        this.activo = activo;
    }
    
    //Contructor copia
    
    public Cliente(Cliente cliente){
        
        super(cliente);
        
        this.idCliente = cliente.getIdCliente();
        //construcctor para clases creando una nueva instancia
        this.tipo = new TipoDeCliente(cliente.getTipo());
        this.historialCompras =
                new ArrayList<>(cliente.getHistorialCompras());
        this.activo = cliente.isActivo();
        
    }
    
    
    //Getters 

    public int getIdCliente() {
        return idCliente;
    }

    public TipoDeCliente getTipo() {
        return new TipoDeCliente(tipo);
    }

    public ArrayList<Venta> getHistorialCompras() {
        return historialCompras;
    }
    
    public boolean isActivo() {
        return activo;
    }
    

    //Setters
    
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public void setTipo(TipoDeCliente tipo) {
        this.tipo = new TipoDeCliente(tipo);
    }

    public void setHistorialCompras(ArrayList<Venta> historialCompras) {
        this.historialCompras = 
                new ArrayList<>(historialCompras);
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
    
    
}
