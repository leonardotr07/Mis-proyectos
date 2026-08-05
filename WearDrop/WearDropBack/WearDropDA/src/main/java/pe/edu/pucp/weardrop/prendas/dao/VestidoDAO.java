/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.dao;

import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Vestido;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface VestidoDAO extends IDAO<Vestido> {
    ArrayList<Vestido> filtrarVestidos();
}
