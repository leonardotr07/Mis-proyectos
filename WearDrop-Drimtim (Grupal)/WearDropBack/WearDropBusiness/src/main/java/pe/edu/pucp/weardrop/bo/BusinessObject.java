/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.bo;

import java.util.ArrayList;

/**
 *
 * @author Leonardo
 */
public interface BusinessObject <T>{
    int insertar(T objeto) throws Exception;
    int modificar(T objeto) throws Exception;
    int eliminar(int idObjeto) throws Exception;
    T obtenerXId(int idObjeto) throws Exception;
    ArrayList<T> listarTodos() throws Exception;
    //ArrayList<T> listarActivos() throws Exception; Deberia ir esto tmb?
    void validar(T objeto) throws Exception;
}
