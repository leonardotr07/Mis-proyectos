/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.boi;

import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.prendas.Blusa;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface BlusaBOI extends BusinessObject<Blusa>{
     ArrayList<Blusa> filtrarBlusas();
}
