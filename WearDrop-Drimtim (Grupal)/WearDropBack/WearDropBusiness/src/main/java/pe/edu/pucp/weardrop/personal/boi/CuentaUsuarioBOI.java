/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.boi;

import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;

/**
 *
 * @author HP
 */
public interface CuentaUsuarioBOI extends BusinessObject<CuentaUsuario>{
    
    int verficarCuentaUsuario(CuentaUsuario cuentaUsuario);
    int modificarEspecial(CuentaUsuario objeto, String modo);
    
    CuentaUsuario obtenerPorEmail(String email);
    String generarTokenRecuperacion(String email);
    CuentaUsuario obtenerPorToken(String token);
    boolean cambiarContrasenaConToken(String token, String nuevaContrasena);
    boolean limpiarToken(String email);
    
}
