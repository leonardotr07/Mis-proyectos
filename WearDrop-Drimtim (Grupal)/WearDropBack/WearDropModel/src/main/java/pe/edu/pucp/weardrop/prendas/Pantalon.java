/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

/**
 *
 * @author valer
 */
public class Pantalon extends Prenda {
    
    // Tipo de pantalón (ej. Jeans, Jogger, Chino, etc.)
    private TipoPantalon tipoPantalon;
    
    // Largo de la pierna en centímetros
    private double largoPierna;
    
    // Medida de la cintura en centímetros
    private double cintura;
    
    // Indica si el material tiene elasticidad
    private boolean elasticidad;
    
    // Constructor vacío
    public Pantalon() {}
    
    // Constructor con parámetros
    public Pantalon(int idPrenda, String nombre, int stockPrenda, double precioUnidad,
                    double precioMayor, double precioDocena, int alertaMinStock,
                    TipoPantalon tipoPantalon, double largoPierna,  
                    double cintura, boolean elasticidad, String color,
                  Material material,boolean activo) {
        
        super(idPrenda, nombre, stockPrenda, precioUnidad, precioMayor, precioDocena, alertaMinStock, color, material,activo);
        
        if (largoPierna <= 0) {
            throw new IllegalArgumentException("El largo de la pierna debe ser mayor que cero");
        }
        if (cintura <= 0) {
            throw new IllegalArgumentException("La medida de la cintura debe ser mayor que cero");
        }
        
        this.tipoPantalon = tipoPantalon;
        this.largoPierna = largoPierna;
        this.cintura = cintura;
        this.elasticidad = elasticidad;
    }
    
    // Getters y Setters
    public TipoPantalon getTipoPantalon() {
        return tipoPantalon;
    }

    public void setTipoPantalon(TipoPantalon tipoPantalon) {
        this.tipoPantalon = tipoPantalon;
    }

    public double getLargoPierna() {
        return largoPierna;
    }

    public void setLargoPierna(double largoPierna) {
        if (largoPierna <= 0) {
            throw new IllegalArgumentException("El largo de la pierna debe ser mayor que cero");
        }
        this.largoPierna = largoPierna;
    }

    public double getCintura() {
        return cintura;
    }

    public void setCintura(double cintura) {
        if (cintura <= 0) {
            throw new IllegalArgumentException("La medida de la cintura debe ser mayor que cero");
        }
        this.cintura = cintura;
    }

    public boolean isElasticidad() {
        return elasticidad;
    }

    public void setElasticidad(boolean elasticidad) {
        this.elasticidad = elasticidad;
    }
}

