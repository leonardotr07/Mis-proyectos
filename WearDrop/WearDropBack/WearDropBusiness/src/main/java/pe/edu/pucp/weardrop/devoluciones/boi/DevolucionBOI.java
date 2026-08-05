/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.devoluciones.Devolucion;

public interface DevolucionBOI extends BusinessObject<Devolucion> {
    ArrayList<Devolucion> listarPorProveedor(int idProveedor) throws Exception;
}
