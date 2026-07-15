/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 *
 * @author valer
 */
public class Falda extends Prenda {
    
    // Tipo de falda (ej. Plisada, Tubo, Larga, etc.)
    private TipoFalda tipoFalda;

    // Largo de la falda en centímetros
    private double largo;

    // Indica si la falda tiene forro interno
    private boolean conForro;

    // Indica si la falda tiene volantes en su diseño
    private boolean conVolantes;

    // Constructor vacío
    public Falda() {
    }

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Falda(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
            double precioMayor, double precioDocena, int alertaMinStock,
            TipoFalda tipoFalda, double largo, boolean conForro, boolean conVolantes, String color,
                  Material material, boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material, activo);

        if (largo <= 0) {
            throw new IllegalArgumentException("El largo de la falda debe ser mayor que cero");
        }

        this.tipoFalda = tipoFalda;
        this.largo = largo;
        this.conForro = conForro;
        this.conVolantes = conVolantes;
    }

    // Getter: devuelve el tipo de falda, útil para leer desde la BD
    public TipoFalda getTipoFalda() {
        return tipoFalda;
    }

    // Setter: asigna el tipo de falda, usado al registrar o actualizar en BD
    public void setTipoFalda(TipoFalda tipoFalda) {
        this.tipoFalda = tipoFalda;
    }

    // Getter: devuelve el largo de la falda, facilita la consulta de datos
    public double getLargo() {
        return largo;
    }

    // Setter: asigna el largo de la falda, permite guardar cambios en la BD
    public void setLargo(double largo) {
        if (largo <= 0) {
            throw new IllegalArgumentException("El largo de la falda debe ser mayor que cero");
        }
        this.largo = largo;
    }

    // Getter: indica si la falda tiene forro, útil en consultas de persistencia
    public boolean isConForro() {
        return conForro;
    }

    // Setter: define si la falda tiene forro, permite registrar el valor en BD
    public void setConForro(boolean conForro) {
        this.conForro = conForro;
    }

    // Getter: indica si la falda tiene volantes, necesario en consultas de la BD
    public boolean isConVolantes() {
        return conVolantes;
    }

    // Setter: define si la falda tiene volantes, usado al guardar en la BD
    public void setConVolantes(boolean conVolantes) {
        this.conVolantes = conVolantes;
    }
    
    
}
