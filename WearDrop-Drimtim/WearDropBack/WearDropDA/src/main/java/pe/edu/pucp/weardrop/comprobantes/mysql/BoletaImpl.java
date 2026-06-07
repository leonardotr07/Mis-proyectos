package pe.edu.pucp.weardrop.comprobantes.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprobantes.Boleta;  // Cambié el paquete aquí
import pe.edu.pucp.weardrop.comprobantes.dao.BoletaDAO;  // Cambié el paquete aquí
import pe.edu.pucp.weardrop.config.DBManager;

public class BoletaImpl implements BoletaDAO {

    private Connection con;
//    private Statement st;
    private ResultSet rs;
    private CallableStatement cs; //Permite llamar a SProcedures

  @Override
  public int insertar(Boleta boleta) {
    Map<Integer, Object> parametrosSalida = new HashMap<>();
    Map<Integer, Object> parametrosEntrada = new HashMap<>();
    
    // 1. Registrar el parámetro OUT (Este es el parámetro 1)
    parametrosSalida.put(1, java.sql.Types.INTEGER); 
    
    // 2. Registrar los 6 parámetros IN (del 2 al 7)
    parametrosEntrada.put(2, new java.sql.Date(boleta.getFecha().getTime()));
    parametrosEntrada.put(3, boleta.getTotal());
    parametrosEntrada.put(4, boleta.getIGV());
    parametrosEntrada.put(5, boleta.getMetodoDePago());
    parametrosEntrada.put(6, boleta.getCorrelativo());
    parametrosEntrada.put(7, boleta.getDNI());

    // 3. Llamar al DBManager (que sí sabe manejar los 7 parámetros)
    try {
        DBManager.getInstance().ejecutarProcedimiento("insertar_boleta", parametrosEntrada, parametrosSalida);
        
        // 4. Recuperar el ID del parámetro OUT (el parámetro 1)
        int idGenerado = (int) parametrosSalida.get(1);
        boleta.setIdComprobante(idGenerado);
        
        System.out.println("Se ha realizado el registro de la BOLETA con ID: " + idGenerado);
        return idGenerado;
        
    } catch (Exception ex) {
        System.out.println("Error al insertar boleta (con DBManager): " + ex.getMessage());
        return 0; // Devuelve 0 en caso de error
    }
}

    @Override
    public int modificar(Boleta boleta) {
        // (Refactorizado con DBManager)
        int resultado = 0;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        try {
            parametrosEntrada.put(1, boleta.getIdComprobante());
            // Usamos Timestamp para asegurar que la hora se guarde en la columna DATETIME
            parametrosEntrada.put(2, new java.sql.Timestamp(boleta.getFecha().getTime()));
            parametrosEntrada.put(3, boleta.getTotal());
            parametrosEntrada.put(4, boleta.getIGV());
            parametrosEntrada.put(5, boleta.getMetodoDePago());
            parametrosEntrada.put(6, boleta.getCorrelativo());
            parametrosEntrada.put(7, boleta.getDNI());

            resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_boleta", parametrosEntrada, null);
            System.out.println("Se ha realizado la modificación de la boleta");

        } catch (Exception ex) {
            System.out.println("Error al modificar boleta: " + ex.getMessage());
        }
        // DBManager.ejecutarProcedimiento maneja su propia conexión
        return resultado;
    }

    @Override
    public int eliminar(int idBoleta) {
        // (Refactorizado con DBManager)
        int resultado = 0;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        try {
            parametrosEntrada.put(1, idBoleta);
            resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_boleta", parametrosEntrada, null);
            System.out.println("Se ha desactivado (baja lógica) la boleta ID: " + idBoleta);

        } catch (Exception ex) {
            System.out.println("Error al desactivar boleta: " + ex.getMessage());
        }
        return resultado;
    }

    @Override
    public Boleta obtenerPorId(int idBoleta) {
        // (Refactorizado con DBManager)
        Boleta boleta = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        try {
            parametrosEntrada.put(1, idBoleta);
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_boleta_x_id", parametrosEntrada);

            if (rs.next()) {
                boleta = new Boleta();
                boleta.setIdComprobante(rs.getInt("idComprobante"));
                boleta.setCorrelativo(rs.getString("Correlativo"));
                boleta.setFecha(rs.getDate("fecha"));
                boleta.setIGV(rs.getDouble("IGV"));
                boleta.setMetodoDePago(rs.getString("metodoDePago"));
                boleta.setTotal(rs.getDouble("total"));
                boleta.setDNI(rs.getString("DNI"));
            }
        } catch (Exception ex) {
            System.out.println("Error al obtener boleta por ID: " + ex.getMessage());
        } finally {
            // Los procedimientos de LECTURA (con ResultSet)
            // requieren cerrar la conexión manualmente.
            DBManager.getInstance().cerrarConexion();
        }
        return boleta;
    }

    @Override
    public ArrayList<Boleta> listarTodos() {
        // (Tu código original ya era correcto)
        ArrayList<Boleta> boletas = null;

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_boletas_todas", null);
            System.out.println("Lectura de todas las boletas");

            while (rs.next()) {
                if (boletas == null) {
                    boletas = new ArrayList<>();
                }
                Boleta boleta = new Boleta();
                boleta.setIdComprobante(rs.getInt("idComprobante"));
                boleta.setCorrelativo(rs.getString("Correlativo"));
                boleta.setFecha(rs.getDate("fecha"));
                boleta.setIGV(rs.getDouble("IGV"));
                boleta.setMetodoDePago(rs.getString("metodoDePago"));
                boleta.setTotal(rs.getDouble("total"));
                boleta.setDNI(rs.getString("DNI"));
                boletas.add(boleta);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al listar boletas: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return boletas;
    }

}
