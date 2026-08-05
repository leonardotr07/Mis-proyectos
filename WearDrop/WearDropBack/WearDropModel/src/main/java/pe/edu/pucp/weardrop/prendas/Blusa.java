/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 * Clase Blusa que extiende de Prenda.
 * Representa una prenda de tipo blusa con atributos adicionales.
 * 
 * @author valer
 */
public class Blusa extends Prenda {

    // Estilo o diseño de la blusa (ej. Camisera, CropTop, etc.)
    private TipoBlusa tipoBlusa;

    // Tipo de manga de la blusa (ej. Corta, Larga, 3/4, etc.)
    private TipoManga tipoManga;

    // Constructor vacío
    public Blusa() {}

    // Constructor con parámetros (incluye atributos heredados y propios)
    public Blusa(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                 double precioMayor, double precioDocena, int alertaMinStock,
                 TipoBlusa tipoBlusa, TipoManga tipoManga,String color,
                  Material material,boolean activo) {
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material,activo);
        this.tipoBlusa = tipoBlusa;
        this.tipoManga = tipoManga;
    }

    
    // Getter: devuelve el tipo de blusa, útil para consultas en persistencia
    public TipoBlusa getTipoBlusa() {
        return tipoBlusa;
    }

    // Setter: asigna un tipo de blusa, usado al registrar o actualizar datos en BD
    public void setTipoBlusa(TipoBlusa tipoBlusa) {
        this.tipoBlusa = tipoBlusa;
    }

    // Getter: devuelve el tipo de manga, necesario al recuperar la información almacenada
    public TipoManga getTipoManga() {
        return tipoManga;
    }

    // Setter: asigna el tipo de manga, permite guardar o modificar el valor en la BD
    public void setTipoManga(TipoManga tipoManga) {
        this.tipoManga = tipoManga;
    }
}