/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.CondicionPago;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author matia
 */
public interface CondicionPagoDAO {
    
    
    ArrayList<CondicionPago>
         listarPorIdProveedor(int idProveedor);
         
     ArrayList<CondicionPago>
         listarPorIdProveedor_Activo(int idProveedor);  
    
    
}
