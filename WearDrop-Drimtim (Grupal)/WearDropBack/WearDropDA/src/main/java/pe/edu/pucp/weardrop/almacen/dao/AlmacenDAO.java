/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author Leonardo
 */
//Métodos del CRUD siguiendo el patrón DAO: DATA ACCESS OBJECT
public interface AlmacenDAO extends IDAO<Almacen> {
    //Interfaz que extiende de otra interfaz
    //Aqui se puede colocar los métodos adicionales al CRUD
    //Como por ejemplo obtenerPorNombre o algo asi.
    ArrayList<Almacen> listarActivos();
}
