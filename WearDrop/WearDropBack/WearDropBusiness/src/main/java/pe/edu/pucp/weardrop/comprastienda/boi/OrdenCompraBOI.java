/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.comprastienda.OrdenCompra;

/**
 *
 * @author matia
 */
public interface OrdenCompraBOI extends 
        BusinessObject<OrdenCompra>{
    
    void validar_modificar (OrdenCompra objeto) 
            throws Exception;
    ArrayList<OrdenCompra> listarActivos();
}
