
package pe.edu.pucp.weardrop.personal;

//@author Eyttel
public abstract class Persona {
    //Atributos
    private int idPersona;
    private String nombre;
    private String primerApellido;
    private String segundoApellido;
    private int dni;
    private int telefono;
    private char genero;
    
    //Constructor Por Defecto
    public Persona(){}
    
    //Constructor con parámetros
    public Persona(int idPersona, String nombre, String primerApellido, 
                String segundoApellido, int dni, int telefono, char genero) {
        this.idPersona = idPersona;
        this.nombre = nombre;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.dni = dni;
        this.telefono = telefono;
        this.genero = genero;
    }
    
    //Constructor Copia
    public Persona(Persona datperson) {
        this.idPersona = datperson.idPersona;
        this.nombre = datperson.nombre;
        this.primerApellido = datperson.primerApellido;
        this.segundoApellido = datperson.segundoApellido;
        this.dni = datperson.dni;
        this.telefono = datperson.telefono;
        this.genero = datperson.genero;
    }
    
    
    //Setters y Getters
    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public char getGenero() {
        return genero;
    }

    public void setGenero(char genero) {
        this.genero = genero;
    }
    
    
    
}
