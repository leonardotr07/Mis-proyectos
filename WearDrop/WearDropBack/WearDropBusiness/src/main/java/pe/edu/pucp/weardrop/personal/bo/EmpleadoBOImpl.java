/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.personal.boi.EmpleadoBOI;
import pe.edu.pucp.weardrop.personal.dao.EmpleadoDAO;
import pe.edu.pucp.weardrop.personal.mysql.EmpleadoImpl;

/**
 *
 * @author HP
 */
public class EmpleadoBOImpl implements EmpleadoBOI{
    
    private EmpleadoDAO daoEmpleado;
    
    public EmpleadoBOImpl(){
        daoEmpleado = new EmpleadoImpl();
    }
    
    @Override
    public int insertar(Empleado emp) throws Exception {
        validar(emp);
        return daoEmpleado.insertar(emp);
    }

    @Override
    public int modificar(Empleado emp) throws Exception {
        validar(emp);
        return daoEmpleado.modificar(emp);    
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoEmpleado.eliminar(idObjeto);
    }

    @Override
    public Empleado obtenerXId(int idObjeto) throws Exception {
        return daoEmpleado.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Empleado> listarTodos() throws Exception {
        return daoEmpleado.listarTodos();
    }

    @Override
    public void validar(Empleado emp) throws Exception {
        if(emp.getNombre().trim().length()>75)
            throw new RuntimeException("El nombre a registrar excede los 75 caracteres.");
        if(emp.getPrimerApellido().trim().length()>75)
            throw new RuntimeException("El primer apellido a registrar excede los 75 caracteres.");
        if(emp.getSegundoApellido().trim().length()>75)
            throw new RuntimeException("El segundo apellido a registrar excede los 75 caracteres.");
        if(!(String.valueOf(emp.getDni()).length()==8))
            throw new RuntimeException("El dni no tiene los 8 digitos");
        if(!(String.valueOf((emp.getTelefono())).length()==9))
            throw new RuntimeException("El telefono no tiene lo 9 digitos");
        if (emp.getCargoAsignado() == null)
            throw new Exception("El cargo asignado no puede ser nulo.");
        if (emp.getNombre() == null || emp.getNombre().trim().isEmpty()) 
            throw new Exception("El nombre no puede ser nulo ni vacío.");
        if (emp.getPrimerApellido() == null || emp.getPrimerApellido().trim().isEmpty())
            throw new Exception("El primer apellido no puede ser nulo ni vacío.");
        if (emp.getSegundoApellido() == null || emp.getSegundoApellido().trim().isEmpty())
            throw new Exception("El segundo apellido no puede ser nulo ni vacío.");
        if (emp.getDni() == 0) 
            throw new Exception("El DNI no puede ser nulo o 0.");
        if (emp.getTelefono() == 0) 
            throw new Exception("El teléfono no puede ser nulo o 0.");
        if (emp.getGenero() == '\0') 
            throw new Exception("El género no puede ser nulo.");
        if (emp.getSueldo() <= 0) 
            throw new Exception("El sueldo debe ser mayor a 0.");


    }
    
}
