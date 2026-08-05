
package pe.edu.pucp.weardrop.personal;


// @author Eyttel
public class Empleado extends Persona{
    //Atributos
    private int idEmpleado;
    private Cargo cargoAsignado;
    private double sueldo;
    private boolean activo;
    
    //Constructor por defecto
    public Empleado(){
        super();
        this.cargoAsignado = new Cargo();
    }
        
    //Constructor con parametros
    public Empleado(int idEmpleado, Cargo cargoAsignado, double sueldo, 
                boolean activo, int idPersona, String nombre, 
                String primerApellido, String segundoApellido, int dni, 
                int telefono, char genero) {
        
        //Llama al constructor del padre
        super(idPersona, nombre, primerApellido, segundoApellido, dni, 
                    telefono, genero);
        
        this.idEmpleado = idEmpleado;
        this.cargoAsignado = cargoAsignado;
        this.sueldo = sueldo;
        this.activo = activo;
    }
    
    //Constructor copia
    public Empleado(Empleado datempleado) {
        
        //Llama al constructor copia del padre
        super(datempleado);
        
        this.idEmpleado = datempleado.idEmpleado;
        this.cargoAsignado = datempleado.cargoAsignado;
        this.sueldo = datempleado.sueldo;
        this.activo = datempleado.activo;
    }
    
    //Setters y Getters
    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public Cargo getCargoAsignado() {
        return cargoAsignado;
    }

    public void setCargoAsignado(Cargo cargoAsignado) {
        this.cargoAsignado = cargoAsignado;
    }

    public double getSueldo() {
        return sueldo;
    }

    public void setSueldo(double sueldo) {
        this.sueldo = sueldo;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
    
    
}
