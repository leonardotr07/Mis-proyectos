/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.personal;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import pe.edu.pucp.weardrop.personal.dao.EmpleadoDAO;
import pe.edu.pucp.weardrop.personal.mysql.EmpleadoImpl;

/**
 *
 * @author HP
 */
public class EmpleadoDAOTest {
    
    private static EmpleadoDAO daoEmpleado;
    
    public EmpleadoDAOTest() {
        daoEmpleado = new EmpleadoImpl();
    }
    
    @BeforeAll
    public static void setUpClass() {
    }
    
    @AfterAll
    public static void tearDownClass() {
    }
    
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }

    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    // @Test
    // public void hello() {}
    
//    @Test
//    public void verificarInsert(){
//        Empleado emp = new Empleado();
//        emp.setNombre("CRISTIANO");
//        emp.setPrimerApellido("RONALDO");
//        emp.setSegundoApellido("DOSSANTOSAVEIRO");
//        emp.setDni(73024255);
//        emp.setTelefono(998866717);
//        emp.setGenero('M');
//        emp.setSueldo(707000.00);
//        
//        Cargo c = new Cargo();
//        c.setIdCargo(6);
//        
//        emp.setCargoAsignado(c);
//        
//        int resultado = daoEmpleado.insertar(emp);
//        assertTrue(resultado!=0);
//    }
    
//    @Test
//    public void verificarModificar(){
//        Empleado emp = new Empleado();
//        emp.setIdPersona(16);
//        emp.setNombre("LIONEL");
//        emp.setPrimerApellido("MESSI");
//        emp.setSegundoApellido("CUCHITINI");
//        emp.setDni(73024255);
//        emp.setTelefono(998866717);
//        emp.setGenero('M');
//        emp.setSueldo(101000.00);
//        
//        Cargo c = new Cargo();
//        c.setIdCargo(5);
//        
//        emp.setCargoAsignado(c);
//        
//        int resultado = daoEmpleado.modificar(emp);
//        assertTrue(resultado!=0);       
//    }
    
//    @Test
//    public void verificarListar(){
//        ArrayList<Empleado> emps = new ArrayList<>();
//        emps=null;
//        emps = daoEmpleado.listarTodos();
//        assertTrue(emps!=null);
//    }
    
//    @Test
//    public void verificarObtenerxid(){
//        Empleado emp = new Empleado();
//        emp=null;
//        emp = daoEmpleado.obtenerPorId(14);
//        assertTrue(emp!=null);
//    }
    
//    @Test
//    public void verificarEliminar(){
//        int resultado = daoEmpleado.eliminar(15);
//        assertTrue(resultado!=0);
//    }
}
