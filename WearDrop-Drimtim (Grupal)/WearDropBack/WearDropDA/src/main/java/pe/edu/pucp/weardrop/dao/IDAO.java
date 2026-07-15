/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.dao;

import java.util.ArrayList;

/**
 *
 * @author Leonardo
 */
//<T> funciona como un parametro
public interface IDAO<T> { //Interfaz Generica (CRUD)
    int insertar(T objeto);
    int modificar(T objeto);
    int eliminar(int idObjeto);
    T obtenerPorId(int idObjeto);
    ArrayList<T>listarTodos();
}
