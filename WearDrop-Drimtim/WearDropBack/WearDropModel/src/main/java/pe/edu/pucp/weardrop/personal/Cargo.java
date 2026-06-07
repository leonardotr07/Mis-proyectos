
package pe.edu.pucp.weardrop.personal;



//@author Eyttel
public class Cargo {
    //Atributos
    private int idCargo;
    private char abreviatura;
    private String descripcion;
    private boolean activo;

    //Constructor por defecto
    public Cargo(){}
    
    
    //Constructor con parametros
    public Cargo(int idCargo, char abreviatura, String descripcion) {
        this.idCargo = idCargo;
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
    }
    
    //Constructor copia
    public Cargo(Cargo datcargo) {
        this.idCargo = datcargo.idCargo;
        this.abreviatura = datcargo.abreviatura;
        this.descripcion = datcargo.descripcion;
    }    
    
    //Setters y Getters
    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    public int getIdCargo() {
        return idCargo;
    }

    public void setIdCargo(int idCargo) {
        this.idCargo = idCargo;
    }

    public char getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(char abreviatura) {
        this.abreviatura = abreviatura;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
}
