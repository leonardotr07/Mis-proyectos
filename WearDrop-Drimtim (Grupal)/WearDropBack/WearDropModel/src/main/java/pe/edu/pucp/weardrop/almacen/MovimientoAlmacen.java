/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacen {
    //Atributos
    private int idMovimiento;
    private Almacen datAlmacen;
    private Date fecha;
    private String lugarDestino;
    private String lugarOrigen;
    private TipoMovimiento tipo;
    private boolean activo; //Si se esta tomando en cuenta para la empresa, o si fue cancelada
    
    public CuentaUsuario getDatUsuario() {
        return datUsuario;
    }

    //Para marcar que usuario ha creado el movimiento
    public void setDatUsuario(CuentaUsuario datUsuario) {
        this.datUsuario = datUsuario;
    }
    private CuentaUsuario datUsuario;
    
    
    //Relaciones
    private final ArrayList<Lote>lotesMovidos;

    
    //Constructor Por defecto
    public MovimientoAlmacen() {    
        this.lotesMovidos=new ArrayList<>();
        this.datAlmacen=new Almacen();
    }

    //Constructor con parámetros
    public MovimientoAlmacen(int idAlmacen, Date fecha, String lugarDestino, String lugarOrigen, TipoMovimiento tipo) {
        this.fecha = fecha;
        this.lugarDestino = lugarDestino;
        this.lugarOrigen = lugarOrigen;
        this.tipo = tipo;
        this.lotesMovidos=new ArrayList<>();
        this.activo = true;
        this.datAlmacen=new Almacen();
    }
    
    //Constructor Copia para Almacen
    public MovimientoAlmacen(MovimientoAlmacen datMov){
        this.idMovimiento = datMov.idMovimiento;
        this.fecha = datMov.fecha;
        this.lugarDestino = datMov.lugarDestino;
        this.lugarOrigen = datMov.lugarOrigen;
        this.tipo = datMov.tipo;
        this.lotesMovidos=new ArrayList<>(datMov.lotesMovidos);
        this.activo=datMov.activo;
        this.datAlmacen=new Almacen(datMov.getDatAlmacen());
    }
    //Métodos
    public void mostrarMovAlmacen(){
        System.out.println("idMovimiento: "+idMovimiento);
        System.out.println("idAlmacen: "+datAlmacen.getId());
        System.out.println("fecha: "+fecha);
        System.out.println("lugarDestino: "+lugarDestino);
        System.out.println("lugarOrigen: "+lugarOrigen);
        System.out.println("tipo: "+tipo.toString());
        System.out.println("activo: "+activo);
    }
    //Getters y Setters
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {    
        this.activo = activo;
    }

    public int getIdMovimiento() {
        return idMovimiento;
    }

    public void setIdMovimiento(int idMovimiento) {
        this.idMovimiento = idMovimiento;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getLugarDestino() {
        return lugarDestino;
    }

    public void setLugarDestino(String lugarDestino) {
        this.lugarDestino = lugarDestino;
    }

    public String getLugarOrigen() {
        return lugarOrigen;
    }

    public void setLugarOrigen(String lugarOrigen) {
        this.lugarOrigen = lugarOrigen;
    }

    public TipoMovimiento getTipo() {
        return tipo;
    }

    public void setTipo(TipoMovimiento tipo) {
        this.tipo = tipo;
    }

    public Almacen getDatAlmacen() {
        return this.datAlmacen;
    }

    public void setDatAlmacen(Almacen datAlmacen) {
        this.datAlmacen=datAlmacen;
    }
    
    
}
