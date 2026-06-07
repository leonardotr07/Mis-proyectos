/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 *
 * @author valer
 */
public class Vestido extends Prenda {

    // Tipo de vestido (ej. Coctel, Gala, Casual, etc.)
    private TipoVestido tipoVestido;

    // Largo del vestido en centímetros
    private int largo;

    // Tipo de manga del vestido (ej. Corta, Larga, Sisa, etc.)
    private TipoManga tipoManga;

    // Constructor vacío
    public Vestido() {}

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Vestido(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                   double precioMayor, double precioDocena, int alertaMinStock,
                   TipoVestido tipoVestido, TipoManga tipoManga, int largo, String color,
                  Material material,boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material,activo);
        this.tipoManga = tipoManga;
        this.tipoVestido = tipoVestido;
        this.largo = largo;
    }

    // Getter: devuelve el tipo de vestido, útil para consultas en BD
    public TipoVestido getTipoVestido() {
        return tipoVestido;
    }

    // Setter: asigna el tipo de vestido, usado al registrar o actualizar en BD
    public void setTipoVestido(TipoVestido tipoVestido) {
        this.tipoVestido = tipoVestido;
    }

    // Getter: devuelve el largo del vestido, facilita la lectura desde persistencia
    public int getLargo() {
        return largo;
    }

    // Setter: asigna el largo del vestido, permite guardar o modificar el valor en BD
    public void setLargo(int largo) {
        this.largo = largo;
    }

    // Getter: devuelve el tipo de manga, necesario en operaciones de lectura
    public TipoManga getTipoManga() {
        return tipoManga;
    }

    // Setter: asigna el tipo de manga, usado al registrar o modificar en BD
    public void setTipoManga(TipoManga tipoManga) {
        this.tipoManga = tipoManga;
    }
}

