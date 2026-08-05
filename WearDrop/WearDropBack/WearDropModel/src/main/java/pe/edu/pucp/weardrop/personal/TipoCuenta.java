
package pe.edu.pucp.weardrop.personal;

//@author Eyttel
public class TipoCuenta {
    //Atributos
    private int idTipoCuenta;
    private String descripcion;
    private boolean activo;
    
    //Constructor por defecto
    public TipoCuenta(){}
    
    //Constructor con Parametros
    public TipoCuenta(int idTipoCliente, String descripcion,
            boolean activo) {
        this.idTipoCuenta = idTipoCliente;
        this.descripcion = descripcion;
        this.activo = activo;
    }
    
    //Constructor Copia
    public TipoCuenta(TipoCuenta datTipoCuenta) {
        this.idTipoCuenta = datTipoCuenta.idTipoCuenta;
        this.descripcion = datTipoCuenta.descripcion;
    }

    //Setters y Getters
    public int getIdTipoCuenta() {
        return idTipoCuenta;
    }

    public void setIdTipoCuenta(int idTipoCuenta) {
        this.idTipoCuenta = idTipoCuenta;
    }
    
    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
}
