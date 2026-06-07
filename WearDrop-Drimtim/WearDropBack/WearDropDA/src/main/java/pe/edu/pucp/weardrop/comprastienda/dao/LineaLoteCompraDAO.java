/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.LineaLoteCompra;

/**
 *
 * @author matia
 */
public interface LineaLoteCompraDAO {
    
    ArrayList<LineaLoteCompra>
         listarPorIdOrdenCompra(int idOrdenCompra);
         
     ArrayList<LineaLoteCompra>
         listarPorIdOrdenCompra_Activo(int idOrdenCompra);  
    
    
}
