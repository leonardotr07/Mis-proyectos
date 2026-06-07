/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Order;
import pe.edu.pucp.weardrop.ventas.dao.ClienteDAO;
import pe.edu.pucp.weardrop.ventas.mysql.ClienteImpl;

/**
 *
 * @author matia
 */
public class ClienteDAOTest {
    
    private static ClienteDAO daoClien;
    
    public ClienteDAOTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
        daoClien = new ClienteImpl();
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
    
    /*
 
    @Test
    @Order(1)
    public void verificarRegistro() {
        
        Cliente clie = new Cliente();
        
        clie.setNombre("Luis");
        clie.setPrimerApellido("Alvarez");
        clie.setSegundoApellido("Marquez");
        clie.setDni(78798765);
        clie.setTelefono(999768555);
        clie.setGenero('M');
        
        TipoDeCliente tipclie = new TipoDeCliente();
        
        tipclie.setTipoCliente(2);
        tipclie.setAbreviatura('V');
        tipclie.setDescripcion("VIP");
        
        clie.setTipo(tipclie);
        
        int resultado = daoClien.insertar(clie);
        
        
        assertTrue(resultado>0);
        
    }
    
    @Test
    @Order(2)
    public void verificarModificar(){
        
        Cliente clie = new Cliente();
        
        clie.setIdCliente(16);
        clie.setNombre("LUIS");
        clie.setPrimerApellido("LEON");
        clie.setSegundoApellido("MARQUEZ");
        clie.setDni(78798765);
        clie.setTelefono(999000555);
        clie.setGenero('M');
        
        TipoDeCliente tipclie = new TipoDeCliente();
        
        tipclie.setTipoCliente(1);
        tipclie.setAbreviatura('V');
        tipclie.setDescripcion("VIP");
        
        clie.setTipo(tipclie);
        
        int resultado = daoClien.modificar(clie);
        
        
        assertTrue(resultado>0);
        
       
    }
    
    
    @Test
    @Order(3)
    public void verificarEliminar(){
        int idCliente =18;
        int resultado=daoClien.eliminar(idCliente);
        
        assertTrue(resultado!=0);
    }
    
    
    
    
     @Test
    @Order(4)
    public void verificarObtenerXId(){
        Cliente clie =daoClien.obtenerPorId(16);
        if(clie!=null){
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());

        };
        assertNotNull(clie); //Verificamos si el puntero no es NULO
    }
    
    
    
    @Test
    @Order(5)
    public void verificarListar(){
        
        ArrayList<Cliente> listaClientes;
        
        listaClientes = daoClien.listarTodos();
        
        if(listaClientes  !=  null){
        for ( Cliente clie : listaClientes){
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());
        }
        }
        
        assertNotNull(listaClientes);

    }
    
    
    */
    
    
}
