/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.dao;
import pe.edu.pucp.weardrop.prendas.Gorro;
import pe.edu.pucp.weardrop.dao.IDAO;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface GorroDAO extends IDAO<Gorro>{
    ArrayList<Gorro> filtrarGorros();
}
