/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.ventas.Venta;

/**
 *
 * @author matia
 */
public interface VentaDAO extends 
        IDAO<Venta>{
    
        ArrayList<Venta> lista_ventas_activas();
    
}
