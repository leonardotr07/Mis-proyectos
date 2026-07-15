/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.boi;

import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.ventas.Cliente;

/**
 *
 * @author matia
 */
public interface ClienteBOI extends  BusinessObject<Cliente>{
    
    void validar_modificar (Cliente objeto) throws Exception;
    
    
    
    
    
}
