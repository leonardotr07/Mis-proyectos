/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Order;
import pe.edu.pucp.weardrop.comprastienda.dao.CondicionPagoDAO;
import pe.edu.pucp.weardrop.comprastienda.dao.ProveedorDAO;
import pe.edu.pucp.weardrop.comprastienda.mysql.CondicionPagoImpl;
import pe.edu.pucp.weardrop.comprastienda.mysql.ProveedorImpl;

/**
 *
 * @author matia
 */
public class ProveedorDAOTest {
    
    private static ProveedorDAO daoProveedor;
    private static CondicionPagoDAO daoCondicionPago;
    
    
    public ProveedorDAOTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
        
        daoCondicionPago = new CondicionPagoImpl();
        daoProveedor = new ProveedorImpl();
        
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
    
    
    @Test
    @Order(1)
    public void verificarRegistro() {
        
        Proveedor prove = new Proveedor();
        
        long ruc_test = 12345678910L;
        prove.setRUC(ruc_test);
        prove.setNombre("TextilesCO");
        prove.setTelefono(987655788);
        prove.setDireccion("Camino, sector 7");
        prove.setActivo(true);
        
        CondicionPago cond1 = new CondicionPago();
        cond1.setDescripcion("mitad del pago Adelantado");
        cond1.setNumDias(90);
        cond1.setVigente(true);
        
        CondicionPago cond2 = new CondicionPago();
        cond2.setDescripcion("interes del 3% por cada mes");
        cond2.setNumDias(90);
        cond2.setVigente(true);
        
        prove.getCondiciones().add(cond1);
        prove.getCondiciones().add(cond2);
        
        int resultado = daoProveedor.insertar(prove);
        assertTrue(resultado>0);
    }
    
    
    
    @Test
    @Order(2)
    public void verificarModificar(){
        
        Proveedor prove = new Proveedor();
        prove.setIdProveedor(2);
        long ruc_test = 12345678910L;
        prove.setRUC(ruc_test);
        prove.setNombre("TextilesCOMPANY");
        prove.setTelefono(987655788);
        prove.setDireccion("Alderán , sector 7");
        prove.setActivo(true);
        
        CondicionPago cond1 = new CondicionPago();
        cond1.setDescripcion("mitad del pago Adelantado");
        cond1.setNumDias(120);
        cond1.setVigente(true);
        
        CondicionPago cond2 = new CondicionPago();
        cond2.setDescripcion("interes del 3% por cada mes");
        cond2.setNumDias(120);
        cond2.setVigente(true);
        
        prove.getCondiciones().add(cond1);
        prove.getCondiciones().add(cond2);
        
        int resultado = daoProveedor.modificar(prove);
        assertTrue(resultado>0);
        
      

    }
    
    
    
    @Test
    @Order(3)
    public void verificarEliminar(){
        int idProveedor = 1 ;
        int resultado=daoProveedor.eliminar(idProveedor);
        
        assertTrue(resultado!=0);
    }
    
    
    
    
      
    @Test
    @Order(4)
    public void verificarObtenerXId(){
        
        Proveedor prove = daoProveedor.obtenerPorId(2);
        
   
        if(prove   != null){
            
            prove.setCondiciones(daoCondicionPago.listarPorIdProveedor_Activo(prove.getIdProveedor()));
            
            System.out.println( prove.getIdProveedor() + " ");
            System.out.println( prove.getRUC() + " ");
            System.out.println( prove.getNombre() + " ");
            System.out.println( prove.getTelefono()+ " ");
            System.out.println( prove.getDireccion()+ " ");
            System.out.println( prove.isActivo()+ " ");
            
            ArrayList<CondicionPago> listCondi = prove.getCondiciones();
            
            for(CondicionPago condicion : listCondi){
                System.out.println(condicion.getIdCondicion());
                System.out.println(condicion.getDescripcion() + " ");
                System.out.println(condicion.getNumDias());
                System.out.println(condicion.isVigente());
            
            }
            
        }
        assertNotNull(prove);
        
    }
    
    
    
    
    
    
    @Test
    @Order(5)
    public void verificarListar(){
        
        ArrayList<Proveedor> listarProve = daoProveedor.listarTodos();

        if(listarProve   != null){
            
            for(Proveedor prove : listarProve){
                prove.setCondiciones(daoCondicionPago
                        .listarPorIdProveedor(prove.getIdProveedor()));
            }
            
            for( Proveedor prove : listarProve){
                
             System.out.println( prove.getIdProveedor() + " ");
            System.out.println( prove.getRUC() + " ");
            System.out.println( prove.getNombre() + " ");
            System.out.println( prove.getTelefono()+ " ");
            System.out.println( prove.getDireccion()+ " ");
            System.out.println( prove.isActivo()+ " ");
            
            ArrayList<CondicionPago> listCondi = prove.getCondiciones();
            
            for(CondicionPago condicion : listCondi){
                System.out.println(condicion.getIdCondicion());
                System.out.println(condicion.getDescripcion() + " ");
                System.out.println(condicion.getNumDias());
                System.out.println(condicion.isVigente());
            
            }
            
                System.out.println(" ");
                
            }
            
          
           
        }
        assertNotNull(listarProve);
        
    }
    
    
    
    
    
    
    
    
    
}
