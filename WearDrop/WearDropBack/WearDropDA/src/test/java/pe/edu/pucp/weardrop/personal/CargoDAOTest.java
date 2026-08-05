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
import pe.edu.pucp.weardrop.personal.dao.CargoDAO;
import pe.edu.pucp.weardrop.personal.mysql.CargoImpl;

/**
 *
 * @author HP
 */
public class CargoDAOTest {
    
    private static CargoDAO daoCargo;
    
    public CargoDAOTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
        daoCargo = new CargoImpl();
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
//        Cargo cargo = new Cargo();
//        cargo.setAbreviatura('R');
//        cargo.setDescripcion("REPARTIDOR");
//        int resultado = daoCargo.insertar(cargo);
//        assertTrue(resultado!=0);
//    }
    
//    @Test
//    public void verificarModificar(){
//        Cargo cargo = new Cargo();
//        cargo.setIdCargo(7);
//        cargo.setAbreviatura('S');
//        cargo.setDescripcion("SALTADOR");
//        int resultado = daoCargo.modificar(cargo);
//        assertTrue(resultado!=0);        
//    }
    
//    @Test
//    public void verificarListar(){
//        ArrayList<Cargo> cargos = new ArrayList<Cargo>();
//        cargos=null;
//        cargos = daoCargo.listarTodos();
//        assertTrue(cargos!=null);
//    }
    
//    @Test
//    public void verificarObtenerxid(){
//        Cargo cargo = new Cargo();
//        cargo=null;
//        cargo = daoCargo.obtenerPorId(6);
//        assertTrue(cargo!=null);
//    }
    
//    @Test
//    public void verificarEliminar(){
//        int resultado = daoCargo.eliminar(7);
//        assertTrue(resultado!=0);
//    }
}
