/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;
import pe.edu.pucp.weardrop.promocionesdescuentos.*;
import pe.edu.pucp.weardrop.almacen.*;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author valer
 */
public abstract class Prenda {

    // Identificador único de la prenda
    private int idPrenda;

    // Nombre o descripción de la prenda
    private String nombre;

    // Lista de tallas disponibles para la prenda
    private List<Talla> talla;

    // Cantidad en stock
    private int stockPrenda;

    // Precio por unidad
    private double precioUnidad;

    // Precio por mayor
    private double precioMayor;

    // Precio por docena
    private double precioDocena;

    // Cantidad mínima que genera alerta de stock bajo
    private int alertaMinStock;
    
    private String color;
    
    private Material material;
    
    private boolean activo;

    // Relación con lotes (manejo de inventario)
    private List<Lote> lotes;

    // Posibles relaciones futuras con descuentos y promociones
    
     private List<Descuento> descuentos;
     
     private List<Promocion> promociones;

    // Constructor vacío
    public Prenda() {}

    // Constructor con parámetros (para añadir una prenda con sus datos básicos)
    public Prenda(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                  double precioMayor, double precioDocena, int alertaMinStock, String color,
                  Material material, boolean activo) {
        this.idPrenda = idPrenda;
        this.nombre = nombre;
        this.stockPrenda = stockPrenda;
        this.precioUnidad = precioUnidad;
        this.precioMayor = precioMayor;
        this.precioDocena = precioDocena;
        this.alertaMinStock = alertaMinStock;
        this.talla = new ArrayList<>();
        this.lotes = new ArrayList<>();
        this.descuentos = new ArrayList<>();
        this.promociones = new ArrayList<>();
        this.color = color;
        this.material = material;
        this.activo = activo;
    }

    // Constructor copia (usado al manejar colecciones como Ventas)
    public Prenda(Prenda datPrenda) {
        this.idPrenda = datPrenda.idPrenda;
        this.nombre = datPrenda.nombre;
        this.stockPrenda = datPrenda.stockPrenda;
        this.precioUnidad = datPrenda.precioUnidad;
        this.precioMayor = datPrenda.precioMayor;
        this.precioDocena = datPrenda.precioDocena;
        this.alertaMinStock = datPrenda.alertaMinStock;
        this.talla = new ArrayList<>(datPrenda.talla);
        this.lotes = new ArrayList<>(datPrenda.lotes);
        this.descuentos = new ArrayList<>(datPrenda.getDescuentos());
        this.promociones = new ArrayList<>(datPrenda.getPromociones());
        this.color = datPrenda.color;
        this.activo = datPrenda.activo;
    }
    
    public Prenda(int idPrenda, String nombre, String color, Material material, double precioMayor, double precioDocena) {
        this.idPrenda = idPrenda;
        this.nombre = nombre;
        this.color = color;
        this.material = material;
        this.precioMayor = precioMayor;
        this.precioDocena = precioDocena;
        this.activo = true;
    }
    // Getters y Setters
    // Cada uno es clave en la persistencia:
    // - Los getters permiten recuperar valores desde la BD
    // - Los setters permiten asignar o actualizar valores para guardarlos

    /**
     * @return the material
     */
    public Material getMaterial() {
        return material;
    }

    /**
     * @param material the material to set
     */
    public void setMaterial(Material material) {
        this.material = material;
    }

    /**
     * @return the color
     */
    public String getColor() {
        return color;
    }

    /**
     * @param color the color to set
     */
    public void setColor(String color) {
        this.color = color;
    }
    public int getIdPrenda() {
        return idPrenda;
    }

    public void setIdPrenda(int idPrenda) {
        this.idPrenda = idPrenda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public List<Talla> getTalla() {
        return talla;
    }

    public void setTalla(List<Talla> talla) {
        this.talla = talla;
    }

    public int getStockPrenda() {
        return stockPrenda;
    }

    public void setStockPrenda(int stockPrenda) {
        this.stockPrenda = stockPrenda;
    }

    public double getPrecioUnidad() {
        return precioUnidad;
    }

    public void setPrecioUnidad(double precioUnidad) {
        this.precioUnidad = precioUnidad;
    }

    public double getPrecioMayor() {
        return precioMayor;
    }

    public void setPrecioMayor(double precioMayor) {
        this.precioMayor = precioMayor;
    }

    public double getPrecioDocena() {
        return precioDocena;
    }

    public void setPrecioDocena(double precioDocena) {
        this.precioDocena = precioDocena;
    }

    public int getAlertaMinStock() {
        return alertaMinStock;
    }

    public void setAlertaMinStock(int alertaMinStock) {
        this.alertaMinStock = alertaMinStock;
    }

    public List<Lote> getLotes() {
        return lotes;
    }

    public void setLotes(List<Lote> lotes) {
        this.lotes = lotes;
    }

    /**
     * @return the descuentos
     */
    public List<Descuento> getDescuentos() {
        return descuentos;
    }

    /**
     * @param descuentos the descuentos to set
     */
    public void setDescuentos(List<Descuento> descuentos) {
        this.descuentos = descuentos;
    }

    /**
     * @return the promociones
     */
    public List<Promocion> getPromociones() {
        return promociones;
    }

    /**
     * @param promociones the promociones to set
     */
    public void setPromociones(List<Promocion> promociones) {
        this.promociones = promociones;
    }
    
    /**
     * @return the activo
     */
    public boolean isActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
