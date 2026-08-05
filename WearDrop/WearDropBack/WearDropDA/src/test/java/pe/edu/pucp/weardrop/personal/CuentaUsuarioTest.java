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
import pe.edu.pucp.weardrop.personal.dao.CuentaUsuarioDAO;
import pe.edu.pucp.weardrop.personal.mysql.CuentaUsuarioImpl;

/**
 *
 * @author HP
 */
public class CuentaUsuarioTest {
    
    private static CuentaUsuarioDAO daoCuentaUsuario;
    
    public CuentaUsuarioTest() {
        daoCuentaUsuario = new CuentaUsuarioImpl();
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
//        CuentaUsuario cu = new CuentaUsuario();
//        cu.setUsername("TIOBIGOTE");
//        cu.setContrasenha("Tipo123");
//        cu.setEmail("tio@gmail.com");
//        
//        TipoCuenta tc = new TipoCuenta();
//        tc.setIdTipoCuenta(1);
//        
//        cu.setTipo(tc);
//        int resultado = daoCuentaUsuario.insertar(cu);
//        assertTrue(resultado!=0);
//    }
//    
//    @Test
//    public void verificarModificar(){
//        CuentaUsuario cu = new CuentaUsuario();
//        cu.setIdCuenta(2);
//        cu.setUsername("Pato");
//        cu.setContrasenha("ASej1j12jl");
//        cu.setEmail("paitito@gmail.com");
//        
//        TipoCuenta tc = new TipoCuenta();
//        tc.setIdTipoCuenta(2);
//        
//        cu.setTipo(tc);
//        int resultado = daoCuentaUsuario.modificar(cu);
//        assertTrue(resultado!=0);     
//    }
//    
//    @Test
//    public void verificarListar(){
//        ArrayList<CuentaUsuario> cus = new ArrayList<>();
//        cus=null;
//        cus = daoCuentaUsuario.listarTodos();
//        assertTrue(cus!=null);
//    }
//    
//    @Test
//    public void verificarObtenerxid(){
//        CuentaUsuario cu = new CuentaUsuario();
//        cu=null;
//        cu = daoCuentaUsuario.obtenerPorId(5);
//        assertTrue(cu!=null);
//    }
//    
//    @Test
//    public void verificarEliminar(){
//        int resultado = daoCuentaUsuario.eliminar(5);
//        assertTrue(resultado!=0);
//    }
}
