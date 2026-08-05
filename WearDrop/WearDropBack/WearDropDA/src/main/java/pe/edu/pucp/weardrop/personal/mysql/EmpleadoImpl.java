/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.personal.dao.EmpleadoDAO;

/**
 *
 * @author HP
 */
public class EmpleadoImpl implements EmpleadoDAO{
    
    private ResultSet rs;
    
    @Override
    public int insertar(Empleado empleado) {
        Map<Integer,Object> parametrosSalida = new HashMap<>();   
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, empleado.getNombre());
        parametrosEntrada.put(3, empleado.getPrimerApellido());
        parametrosEntrada.put(4, empleado.getSegundoApellido());
        parametrosEntrada.put(5, empleado.getDni());
        parametrosEntrada.put(6, empleado.getTelefono());
        parametrosEntrada.put(7, String.valueOf(empleado.getGenero()));
        parametrosEntrada.put(8, empleado.getCargoAsignado().getIdCargo());
        parametrosEntrada.put(9, empleado.getSueldo());
        DBManager.getInstance().ejecutarProcedimiento("insertar_empleado",
	         parametrosEntrada, parametrosSalida);
        empleado.setIdPersona((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro del empleado");
        return empleado.getIdPersona();    
    }

    @Override
    public int modificar(Empleado empleado) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, empleado.getIdPersona());
        parametrosEntrada.put(2, empleado.getNombre());
        parametrosEntrada.put(3, empleado.getPrimerApellido());
        parametrosEntrada.put(4, empleado.getSegundoApellido());
        parametrosEntrada.put(5, empleado.getDni());
        parametrosEntrada.put(6, empleado.getTelefono());
        parametrosEntrada.put(7, String.valueOf(empleado.getGenero()));
        parametrosEntrada.put(8, empleado.getCargoAsignado().getIdCargo());
        parametrosEntrada.put(9, empleado.getSueldo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_empleado", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion del empleado");
        return resultado;     
    }

    @Override
    public int eliminar(int idEmpleado) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idEmpleado);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_empleado", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion del empleado");
        return resultado;     
    }

    @Override
    public Empleado obtenerPorId(int idEmpleado) {
        Empleado e = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idEmpleado);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_empleado_X_id", parametrosEntrada);
        System.out.println("Lectura de empleado...");
        try{
            while(rs.next()){
                if(e == null) e = new Empleado();
                e.setIdPersona(rs.getInt("idPersona"));
                e.setNombre(rs.getString("nombre"));
                e.setPrimerApellido(rs.getString("primerApellido"));
                e.setSegundoApellido(rs.getString("segundoApellido"));
                e.setDni(rs.getInt("dni"));
                e.setTelefono(rs.getInt("telefono"));
                e.setGenero(rs.getString("genero").charAt(0));
                e.setActivo(rs.getBoolean("activo"));
                e.setSueldo(rs.getDouble("sueldo"));
                
                Cargo c = new Cargo();
                c.setIdCargo(rs.getInt("idCargo"));
                c.setAbreviatura(rs.getString("abreviatura").charAt(0));
                c.setDescripcion(rs.getString("descripcion"));
                
                e.setCargoAsignado(c);
            }
        }catch(SQLException ex){
            System.out.println("Error buscando x id empleado "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return e;    
    }

    @Override
    public ArrayList<Empleado> listarTodos() {
        ArrayList<Empleado> empleados = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_empleados", null);
        System.out.println("Lectura de empleados...");
        try{
            while(rs.next()){
                if(empleados == null) empleados = new ArrayList<>();
                Empleado e = new Empleado();
                e.setIdPersona(rs.getInt("idPersona"));
                e.setNombre(rs.getString("nombre"));
                e.setPrimerApellido(rs.getString("primerApellido"));
                e.setSegundoApellido(rs.getString("segundoApellido"));
                e.setDni(rs.getInt("dni"));
                e.setTelefono(rs.getInt("telefono"));
                e.setGenero(rs.getString("genero").charAt(0));
                e.setActivo(true);
                e.setSueldo(rs.getDouble("sueldo"));
                
                Cargo c = new Cargo();
                c.setIdCargo(rs.getInt("idCargo"));
                c.setAbreviatura(rs.getString("abreviatura").charAt(0));
                c.setDescripcion(rs.getString("descripcion"));
                
                e.setCargoAsignado(c);
                
                empleados.add(e);
            }
        }catch(SQLException ex){
            System.out.println("Error listanto empleados"+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return empleados;     
    }
    
}
