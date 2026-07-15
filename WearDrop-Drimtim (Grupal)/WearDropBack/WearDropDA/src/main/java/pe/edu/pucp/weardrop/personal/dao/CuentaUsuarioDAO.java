/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.dao;

import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;

/**
 *
 * @author HP
 */
public interface CuentaUsuarioDAO extends IDAO<CuentaUsuario>{
    
    int verficarCuentaUsuario(CuentaUsuario cuentaUsuario);
    int modificarEspecial(CuentaUsuario cuentaUsuario, String modo);
    //Nuevos métodos
    CuentaUsuario obtenerPorEmail(String email);
    String generarTokenRecuperacion(String email);
    CuentaUsuario obtenerPorToken(String token);
    boolean cambiarContrasenaConToken(String token, String nuevaContrasena);
    boolean limpiarToken(String email);
    String cifrarContrasena(String password);
    
    
}
