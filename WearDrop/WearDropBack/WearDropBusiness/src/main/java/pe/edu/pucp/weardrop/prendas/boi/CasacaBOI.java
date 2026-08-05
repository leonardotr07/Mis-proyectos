/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.boi;

import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.prendas.Casaca;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface CasacaBOI extends BusinessObject<Casaca>{
     ArrayList<Casaca> filtrarCasacas();
}
