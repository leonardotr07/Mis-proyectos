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
import pe.edu.pucp.weardrop.personal.dao.TipoCuentaDAO;
import pe.edu.pucp.weardrop.personal.mysql.TipoCuentaImpl;

/**
 *
 * @author HP
 */
public class TipoCuentaDAOTest {
    
    private static TipoCuentaDAO daoTipoCuenta;
    
    public TipoCuentaDAOTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
        daoTipoCuenta = new TipoCuentaImpl();
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
//        TipoCuenta tipoCuenta = new TipoCuenta();
//        tipoCuenta.setDescripcion("HACKER");
//        int resultado = daoTipoCuenta.insertar(tipoCuenta);
//        assertTrue(resultado!=0);
//    }
//    
//    @Test
//    public void verificarModificar(){
//        TipoCuenta tipoCuenta = new TipoCuenta();
//        tipoCuenta.setIdTipoCuenta(2);
//        tipoCuenta.setDescripcion("EMPLOYEE");
//        int resultado = daoTipoCuenta.modificar(tipoCuenta);
//        assertTrue(resultado!=0);        
//    }
//    
//    @Test
//    public void verificarListar(){
//        ArrayList<TipoCuenta> tipoCuentas = new ArrayList<>();
//        tipoCuentas=null;
//        tipoCuentas = daoTipoCuenta.listarTodos();
//        assertTrue(tipoCuentas!=null);
//    }
//    
//    @Test
//    public void verificarObtenerxid(){
//        TipoCuenta tipoCuenta = new TipoCuenta();
//        tipoCuenta=null;
//        tipoCuenta = daoTipoCuenta.obtenerPorId(1);
//        assertTrue(tipoCuenta!=null);
//    }
//    
//    @Test
//    public void verificarEliminar(){
//        int resultado = daoTipoCuenta.eliminar(3);
//        assertTrue(resultado!=0);
//    }
    
}
