/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.devoluciones.Devolucion;


public interface DevolucionDAO extends IDAO<Devolucion> {
    ArrayList<Devolucion> listarPorIdProveedor(int idProveedor);
}


