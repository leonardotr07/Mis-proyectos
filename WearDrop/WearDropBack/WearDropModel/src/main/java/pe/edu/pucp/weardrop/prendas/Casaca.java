/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;
/**
 *
 * @author valer
 */
public class Casaca extends Prenda {

    // Tipo de casaca (ej. Deportiva, Formal, Casual, etc.)
    private TipoCasaca tipoCasaca;

    // Indica si la casaca tiene capucha o no
    private boolean conCapucha;

    // Constructor vacío
    public Casaca() {}

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Casaca(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                  double precioMayor, double precioDocena, int alertaMinStock,
                  TipoCasaca tipoCasaca, boolean conCapucha, String color,
                  Material material,boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material,activo);
        this.tipoCasaca = tipoCasaca;
        this.conCapucha = conCapucha;
    }

    // Getter: devuelve el tipo de casaca, útil en la lectura desde BD
    public TipoCasaca getTipoCasaca() {
        return tipoCasaca;
    }

    // Setter: asigna el tipo de casaca, usado al registrar o actualizar en BD
    public void setTipoCasaca(TipoCasaca tipoCasaca) {
        this.tipoCasaca = tipoCasaca;
    }

    // Getter: indica si la casaca tiene capucha, usado en consultas de persistencia
    public boolean isConCapucha() {
        return conCapucha;
    }

    // Setter: define si la casaca tiene capucha, permite guardar el valor en BD
    public void setConCapucha(boolean conCapucha) {
        this.conCapucha = conCapucha;
    }
}
