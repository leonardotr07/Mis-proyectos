/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.mysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;
import pe.edu.pucp.weardrop.personal.TipoCuenta;
import pe.edu.pucp.weardrop.personal.dao.CuentaUsuarioDAO;
import pe.edu.pucp.weardrop.personal.dao.TipoCuentaDAO;

import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import pe.edu.pucp.weardrop.personal.Empleado;

/**
 *
 * @author HP
 */
public class CuentaUsuarioImpl implements CuentaUsuarioDAO {

    private ResultSet rs;

    @Override
    public int insertar(CuentaUsuario cuentaUsuario) {
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, cuentaUsuario.getUsername());
        
        String passCifrada = cifrarContrasena(cuentaUsuario.getContrasenha());
        parametrosEntrada.put(3, passCifrada);
        
//        parametrosEntrada.put(3, cuentaUsuario.getContrasenha());
        parametrosEntrada.put(4, cuentaUsuario.getEmail());
        parametrosEntrada.put(5, cuentaUsuario.getTipo().getIdTipoCuenta());
        parametrosEntrada.put(6, cuentaUsuario.getEmpleado().getIdPersona());
        DBManager.getInstance().ejecutarProcedimiento("insertar_cuentaUsuario",
                parametrosEntrada, parametrosSalida);
        cuentaUsuario.setIdCuenta((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la cuenta usuario");
        return cuentaUsuario.getIdCuenta();
    }

    @Override
    public int modificarEspecial(CuentaUsuario cuentaUsuario, String modo) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, cuentaUsuario.getIdCuenta());
        parametrosEntrada.put(2, cuentaUsuario.getUsername());
        
        if(modo.equals("usuario")){
            parametrosEntrada.put(3, cuentaUsuario.getContrasenha());
        }
        else{
            String passCifrada = cifrarContrasena(cuentaUsuario.getContrasenha());
            parametrosEntrada.put(3, passCifrada);
        }
        
        parametrosEntrada.put(4, cuentaUsuario.getEmail());
        parametrosEntrada.put(5, cuentaUsuario.getTipo().getIdTipoCuenta());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_cuentaUsuario", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la cuenta usuario");
        return resultado;
    }

    @Override
    public int eliminar(int idCuentaUsuario) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCuentaUsuario);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_cuentaUsuario", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion de la cuenta usuario");
        return resultado;
    }

    @Override
    public CuentaUsuario obtenerPorId(int idCuentaUsuario) {
        CuentaUsuario cu = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCuentaUsuario);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_cuentaUsuarios_X_id", parametrosEntrada);
        System.out.println("Lectura de cuentausuario...");
        try {
            while (rs.next()) {
                if (cu == null) {
                    cu = new CuentaUsuario();
                }
                cu.setIdCuenta(rs.getInt("idCuenta"));
                cu.setUsername(rs.getString("username"));
                cu.setContrasenha(rs.getString("contrasenha"));
                cu.setEmail(rs.getString("email"));
                cu.setActivo(rs.getBoolean("activo"));

                TipoCuenta tc = new TipoCuenta();
                tc.setIdTipoCuenta(rs.getInt("idTipoCuenta"));
                tc.setDescripcion(rs.getString("descripcion"));
                
                Empleado emp = new Empleado();
                emp.setIdPersona(rs.getInt("idPersona"));
                emp.setNombre(rs.getString("nombre"));
                emp.setDni(rs.getInt("dni"));
                
                cu.setEmpleado(emp);
                cu.setTipo(tc);

            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return cu;
    }

    @Override
    public ArrayList<CuentaUsuario> listarTodos() {
        ArrayList<CuentaUsuario> cuentaUsuarios = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_cuentaUsuarios", null);
        System.out.println("Lectura de cuenta usuarios...");
        try {
            while (rs.next()) {
                if (cuentaUsuarios == null) {
                    cuentaUsuarios = new ArrayList<>();
                }
                CuentaUsuario cu = new CuentaUsuario();
                cu.setIdCuenta(rs.getInt("idCuenta"));
                cu.setUsername(rs.getString("username"));
                cu.setContrasenha(rs.getString("contrasenha"));
                cu.setEmail(rs.getString("email"));
                cu.setActivo(true);

                TipoCuenta tc = new TipoCuenta();
                tc.setIdTipoCuenta(rs.getInt("idTipoCuenta"));
                tc.setDescripcion(rs.getString("descripcion"));
                
                Empleado emp = new Empleado();
                emp.setIdPersona(rs.getInt("idPersona"));
                emp.setNombre(rs.getString("nombre"));
                emp.setDni(rs.getInt("dni"));
                
                cu.setEmpleado(emp);
                cu.setTipo(tc);

                cuentaUsuarios.add(cu);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return cuentaUsuarios;
    }
    
    
    @Override
    public int verficarCuentaUsuario(CuentaUsuario cuentaUsuario) {
        int resultado = 0;
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, cuentaUsuario.getUsername());
        
        // 1. Encriptamos lo que llega del usuario
        String passEncriptadaParaLogin = cifrarContrasena(cuentaUsuario.getContrasenha());

        parametrosEntrada.put(2, passEncriptadaParaLogin);
        // ---------------------------------------------------------
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("verificar_cuenta_usuario", parametrosEntrada);
        
        try {
            if (rs.next()) {
                resultado = rs.getInt("idCuenta");
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        
        System.out.println("Verificando cuenta usuario...");
        System.out.println("El resultado es: "+resultado);
        
        return resultado;
    }
    
    
    //MÉTODOS NUEVOS PARA LA IMPLEMENTACIÓN DE LOS TOKEBNS
    @Override
    public CuentaUsuario obtenerPorEmail(String email) {
        CuentaUsuario cuenta = null;
        String sql = "SELECT * FROM CuentaUsuario WHERE email = ? AND activo = 1";

        try (Connection conn = DBManager.getInstance().getConnexion(); PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                cuenta = new CuentaUsuario();
                cuenta.setIdCuenta(rs.getInt("idCuenta"));
                cuenta.setUsername(rs.getString("username"));
                cuenta.setContrasenha(rs.getString("contrasenha"));
                cuenta.setEmail(rs.getString("email"));
                cuenta.setActivo(rs.getBoolean("activo"));
                cuenta.setTokenRecuperacion(rs.getString("tokenRecuperacion"));
                cuenta.setTokenExpiracion(rs.getTimestamp("tokenExpiracion"));
                // Cargar tipo de cuenta si es necesario
            }
        } catch (Exception e) {
            System.err.println("Error al buscar por email: " + e.getMessage());
        }

        return cuenta;
    }

    // NUEVO: Generar y guardar token de recuperación
    @Override
    public String generarTokenRecuperacion(String email) {
        // Generamos solo el string del token
        String token = UUID.randomUUID().toString().replace("-", "");
        
        // Usamos funciones de MySQL (DATE_ADD y NOW) para evitar problemas de zona horaria
        String sql = "UPDATE CuentaUsuario SET tokenRecuperacion = ?, "
                + "tokenExpiracion = DATE_ADD(NOW(), INTERVAL 1 HOUR) "
                + "WHERE email = ? AND activo = 1";

        try (Connection conn = DBManager.getInstance().getConnexion(); PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, token);
            // pst.setTimestamp(2, expiracion);  <-- ESTA LINEA SE BORRA, YA NO LA NECESITAMOS
            pst.setString(2, email); // El índice cambia a 2 porque quitamos un ?

            int filasAfectadas = pst.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Token generado exitosamente para: " + email);
                return token;
            }
        } catch (Exception e) {
            System.err.println("Error al generar token: " + e.getMessage());
        }

        return null;
    }

    // ⭐ NUEVO: Validar token
    @Override
    public CuentaUsuario obtenerPorToken(String token) {
        CuentaUsuario cuenta = null;
        String sql = "SELECT * FROM CuentaUsuario WHERE tokenRecuperacion = ? "
                + "AND tokenExpiracion > NOW() AND activo = 1";

        try (Connection conn = DBManager.getInstance().getConnexion(); PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, token);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                cuenta = new CuentaUsuario();
                cuenta.setIdCuenta(rs.getInt("idCuenta"));
                cuenta.setUsername(rs.getString("username"));
                cuenta.setEmail(rs.getString("email"));
                cuenta.setTokenRecuperacion(rs.getString("tokenRecuperacion"));
                cuenta.setTokenExpiracion(rs.getTimestamp("tokenExpiracion"));
            }
        } catch (Exception e) {
            System.err.println("Error al validar token: " + e.getMessage());
        }

        return cuenta;
    }

    // ⭐ NUEVO: Cambiar contraseña con token
    @Override
    public boolean cambiarContrasenaConToken(String token, String nuevaContrasena) {
        
        // 1. ENCRIPTAMOS LA CONTRASEÑA AQUÍ
        String contrasenhaCifrada = cifrarContrasena(nuevaContrasena);

        // 2. Enviamos la versión cifrada a la base de datos
        String sql = "UPDATE CuentaUsuario SET contrasenha = ?, " +
                     "tokenRecuperacion = NULL, tokenExpiracion = NULL " +
                     "WHERE tokenRecuperacion = ? AND tokenExpiracion > NOW() AND activo = 1";
        
        try (Connection conn = DBManager.getInstance().getConnexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            // Usamos la variable cifrada
            pst.setString(1, contrasenhaCifrada); 
            pst.setString(2, token);
            
            int filasAfectadas = pst.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (Exception e) {
            System.err.println("Error al cambiar contraseña: " + e.getMessage());
            return false;
        }
    }

    // ⭐ NUEVO: Limpiar token (cancelar recuperación)
    @Override
    public boolean limpiarToken(String email) {
        String sql = "UPDATE CuentaUsuario SET tokenRecuperacion = NULL, "
                + "tokenExpiracion = NULL WHERE email = ?";

        try (Connection conn = DBManager.getInstance().getConnexion(); PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, email);
            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error al limpiar token: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public String cifrarContrasena(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            
            // Convertir bytes a Hexadecimal
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception ex) {
            System.err.println("Error al cifrar contraseña: " + ex.getMessage());
            return password; // En caso de error, devuelve la original (fallback)
        }
    }

    @Override
    public int modificar(CuentaUsuario objeto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
