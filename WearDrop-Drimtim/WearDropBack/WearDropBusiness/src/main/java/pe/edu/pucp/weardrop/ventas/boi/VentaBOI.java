/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.ventas.Venta;

/**
 *
 * @author matia
 */
public interface VentaBOI  extends BusinessObject<Venta>{
    
    void validar_modificar (Venta objeto) throws Exception;
    Venta obtenerXId_conItemsInactivos(int idObjeto) throws Exception;
    ArrayList<Venta> listarTodos_Activo_conItemActivo() throws Exception;
}
