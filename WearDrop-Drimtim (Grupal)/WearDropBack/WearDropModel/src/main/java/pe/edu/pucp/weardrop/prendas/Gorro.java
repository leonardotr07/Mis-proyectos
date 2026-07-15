/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;
/**
 *
 * @author valer
 */
public class Gorro extends Prenda {

    // Tipo de gorra (ej. Beisbolera, Visera, Bucket, etc.)
    private TipoGorra tipoGorra;

    // Indica si la gorra tiene sistema de ajuste de talla
    private boolean tallaAjustable;

    // Indica si la gorra es impermeable
    private boolean impermeable;

    // Constructor vacío
    public Gorro() {}

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Gorro(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                 double precioMayor, double precioDocena, int alertaMinStock,
                 TipoGorra tipoGorra, boolean tallaAjustable, boolean impermeable, String color,
                  Material material, boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material,activo);
        this.impermeable = impermeable;
        this.tallaAjustable = tallaAjustable;
        this.tipoGorra = tipoGorra;
    }

    // Getter: devuelve el tipo de gorra, útil para consultas desde la BD
    public TipoGorra getTipoGorra() {
        return tipoGorra;
    }

    // Setter: asigna el tipo de gorra, usado al registrar o actualizar en BD
    public void setTipoGorra(TipoGorra tipoGorra) {
        this.tipoGorra = tipoGorra;
    }

    // Getter: indica si la gorra es ajustable, necesario en operaciones de lectura
    public boolean isTallaAjustable() {
        return tallaAjustable;
    }

    // Setter: define si la gorra es ajustable, permite guardar el valor en BD
    public void setTallaAjustable(boolean tallaAjustable) {
        this.tallaAjustable = tallaAjustable;
    }

    // Getter: indica si la gorra es impermeable, útil en consultas de persistencia
    public boolean isImpermeable() {
        return impermeable;
    }

    // Setter: define si la gorra es impermeable, usado al guardar en BD
    public void setImpermeable(boolean impermeable) {
        this.impermeable = impermeable;
    }
}
