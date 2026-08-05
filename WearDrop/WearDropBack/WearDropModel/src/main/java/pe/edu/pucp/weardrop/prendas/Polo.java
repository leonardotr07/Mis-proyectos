/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 *
 * @author valer
 */
public class Polo extends Prenda {
    
    // Tipo de manga del polo (ej. Corta, Larga, 3/4, etc.)
    private TipoManga tipoManga;
    
    // Estampado que puede llevar el polo (ej. Liso, Rayas, Gráfico, etc.)
    private String estampado;
    
    // Tipo de cuello del polo (ej. Redondo, V, Polo, etc.)
    private TipoCuello tipoCuello;

    // Constructor vacío
    public Polo() {}

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Polo(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                double precioMayor, double precioDocena,
                int alertaMinStock, TipoManga tipoManga, String estampado, TipoCuello tipoCuello, String color,
                  Material material,boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad,
              precioMayor, precioDocena, alertaMinStock, color, material, activo);     
        this.estampado = estampado;
        this.tipoCuello = tipoCuello;
        this.tipoManga = tipoManga;     
    }

    // Getter: devuelve el tipo de manga, útil al consultar datos en la BD
    public TipoManga getTipoManga() {
        return tipoManga;
    }

    // Setter: asigna el tipo de manga, usado al registrar o actualizar en la BD
    public void setTipoManga(TipoManga tipoManga) {
        this.tipoManga = tipoManga;
    }

    // Getter: devuelve el estampado del polo, útil en operaciones de lectura
    public String getEstampado() {
        return estampado;
    }

    // Setter: asigna el estampado del polo, permite guardar el valor en la BD
    public void setEstampado(String estampado) {
        this.estampado = estampado;
    }

    // Getter: devuelve el tipo de cuello, necesario en consultas de persistencia
    public TipoCuello getTipoCuello() {
        return tipoCuello;
    }

    // Setter: asigna el tipo de cuello, usado al registrar o modificar en la BD
    public void setTipoCuello(TipoCuello tipoCuello) {
        this.tipoCuello = tipoCuello;
    }
}

