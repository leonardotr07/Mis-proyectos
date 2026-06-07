/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.dao;

import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Blusa;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface BlusaDAO extends IDAO<Blusa> {
     ArrayList<Blusa> filtrarBlusas(

    );
}
