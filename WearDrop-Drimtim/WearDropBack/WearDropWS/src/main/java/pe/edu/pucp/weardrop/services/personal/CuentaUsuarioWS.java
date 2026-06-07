/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.personal;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;
import pe.edu.pucp.weardrop.personal.bo.CuentaUsuarioBOImpl;
import pe.edu.pucp.weardrop.personal.bo.EnviarCorreo;
import pe.edu.pucp.weardrop.personal.boi.CuentaUsuarioBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "CuentaUsuarioWS")
public class CuentaUsuarioWS {
    
    private final CuentaUsuarioBOI boCuentaUsuario = new CuentaUsuarioBOImpl();
    
    // Listar todos los usuarios
    @WebMethod(operationName = "listarCuentasUsuario")
    public ArrayList<CuentaUsuario> listarCuentasUsuario() {
        ArrayList<CuentaUsuario> listaCuentas = null;
        try {
            listaCuentas = boCuentaUsuario.listarTodos();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return listaCuentas;
    }
    
    // Insertar una nueva cuenta de usuario
    @WebMethod(operationName = "insertarCuentaUsuario")
    public int insertarCuentaUsuario(@WebParam(name = "cuentaUsuario") CuentaUsuario cuentaUsuario) {
        int resultado = 0;
        try {
            resultado = boCuentaUsuario.insertar(cuentaUsuario);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Modificar una cuenta existente
    @WebMethod(operationName = "modificarCuentaUsuario")
    public int modificarCuentaUsuario(@WebParam(name = "cuentaUsuario") CuentaUsuario cuentaUsuario,
            @WebParam(name = "modo") String modo) {
        int resultado = 0;
        try {
            resultado = boCuentaUsuario.modificarEspecial(cuentaUsuario,modo);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Eliminar una cuenta por su ID
    @WebMethod(operationName = "eliminarCuentaUsuario")
    public int eliminarCuentaUsuario(@WebParam(name = "idCuentaUsuario") int idCuentaUsuario) {
        int resultado = 0;
        try {
            resultado = boCuentaUsuario.eliminar(idCuentaUsuario);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    // Obtener una cuenta por su ID
    @WebMethod(operationName = "obtenerCuentaUsuarioPorId")
    public CuentaUsuario obtenerCuentaUsuarioPorId(@WebParam(name = "idCuentaUsuario") int idCuentaUsuario) {
        CuentaUsuario cuentaUsuario = null;
        try {
            cuentaUsuario = boCuentaUsuario.obtenerXId(idCuentaUsuario);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return cuentaUsuario;
    }
    
    @WebMethod(operationName = "verificarCuentaUsuario")
    public int verificarCuentaUsuario(
            @WebParam(name = "CuentaUsuario") CuentaUsuario cu) {
        int resultado = 0;
        try{
            resultado = boCuentaUsuario.verficarCuentaUsuario(cu);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //WEB SERVICE NUEVO PARA LOS TOKENS
    
    @WebMethod(operationName = "solicitarRecuperacionContrasena")
    public boolean solicitarRecuperacionContrasena(@WebParam(name = "email") String email) {
            try {
                // 1. Verificar si existe la cuenta
                CuentaUsuario cuenta = boCuentaUsuario.obtenerPorEmail(email);

                if (cuenta == null) {
                    System.out.println("No existe cuenta con email: " + email);
                    return false;
                }

                // 2. Generar token en base de datos
                String token = boCuentaUsuario.generarTokenRecuperacion(email);

                if (token == null) {
                    System.err.println("Error al generar token en BD");
                    return false;
                }

                // 3. Enviar correo usando tu clase EnviarCorreo
                // CORRECCIÓN: Usamos getInstance() y el método correcto enviarCorreoRecuperacion
                // No construimos el HTML aquí, tu clase EnviarCorreo ya lo hace internamente.

                EnviarCorreo servicioCorreo = EnviarCorreo.getInstance();
                boolean enviado = servicioCorreo.enviarCorreoRecuperacion(email, token, cuenta.getUsername());

                if (enviado) {
                    System.out.println("Correo enviado a: " + email);
                    return true;
                } else {
                    System.err.println("Fallo al enviar el correo desde JavaMail");
                    return false;
                }

            } catch (Exception e) {
                System.err.println("Error en WS solicitarRecuperacion: " + e.getMessage());
                e.printStackTrace();
                return false;
            }
        }

    @WebMethod(operationName = "validarTokenRecuperacion")
    public CuentaUsuario validarTokenRecuperacion(@WebParam(name = "token") String token) {
        return boCuentaUsuario.obtenerPorToken(token);
    }

    @WebMethod(operationName = "cambiarContrasenaConToken")
    public boolean cambiarContrasenaConToken(
            @WebParam(name = "token") String token, 
            @WebParam(name = "nuevaContrasena") String nuevaContrasena) {
        return boCuentaUsuario.cambiarContrasenaConToken(token, nuevaContrasena);
    }
}

