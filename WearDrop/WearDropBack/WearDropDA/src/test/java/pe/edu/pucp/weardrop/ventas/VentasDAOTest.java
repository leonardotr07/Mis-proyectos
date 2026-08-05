/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 *
/*/
package pe.edu.pucp.weardrop.ventas;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Order;
import pe.edu.pucp.weardrop.comprobantes.Boleta;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.ventas.dao.ItemVentaDAO;
import pe.edu.pucp.weardrop.ventas.dao.VentaDAO;
import pe.edu.pucp.weardrop.ventas.mysql.ItemVentaImpl;
import pe.edu.pucp.weardrop.ventas.mysql.VentaImpl;

/**
 *
 * @author matia
 */
public class VentasDAOTest {
    
    private static VentaDAO daoVenta;
    private static ItemVentaDAO daoItemVent;
    
    private static ArrayList<Venta> listaVentas;
    
    public VentasDAOTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
        
        daoVenta = new VentaImpl();
        daoItemVent = new ItemVentaImpl();
        
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
    public void verificarRegistro() throws ParseException{
        
        Venta venta = new Venta();
        
        SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
        venta.setFecha(sdf.parse("01-10-2025"));
        
        venta.setTotal(900.0);
        
        Boleta boleta = new Boleta();
        boleta.setIdComprobante(2);
        venta.setComprabante(boleta);
        
        Cliente clie = new Cliente();
        clie.setIdCliente(16);
        
        venta.setCliente(clie);
        
        Empleado emple = new Empleado();
        emple.setIdEmpleado(11);
        
        venta.setEmpleado(emple);
        
        
        ItemVenta item1 = new ItemVenta();
        
        item1.setIdPrenda(5);
        item1.setCantidad(20);
        item1.setSubtotal(300.0);
        

        ItemVenta item2 = new ItemVenta();
        
        item2.setIdPrenda(7);
        item2.setCantidad(50);
        item2.setSubtotal(600.0);
        
        venta.getProductos().add(item1);
        venta.getProductos().add(item2);
        
        int resultado = daoVenta.insertar(venta);
        
        
        assertTrue(resultado>0);
    }
    
    
    @Test
    @Order(2)
    public void verificarModificar() throws ParseException{
        
        Venta venta = new Venta();
        
        SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
        venta.setFecha(sdf.parse("01-09-2025"));
        
        venta.setTotal(1000.0);
        
        Boleta boleta = new Boleta();
        boleta.setIdComprobante(2);
        venta.setComprabante(boleta);
        
        Cliente clie = new Cliente();
        clie.setIdCliente(16);
        
        venta.setCliente(clie);
        
        Empleado emple = new Empleado();
        emple.setIdEmpleado(11);
        
        venta.setEmpleado(emple);
        
        
        ItemVenta item1 = new ItemVenta();
        
        item1.setIdPrenda(5);
        item1.setCantidad(30);
        item1.setSubtotal(400.0);
        

        ItemVenta item2 = new ItemVenta();
        
        item2.setIdPrenda(7);
        item2.setCantidad(50);
        item2.setSubtotal(600.0);
        
        venta.getProductos().add(item1);
        venta.getProductos().add(item2);
        
        venta.setIdVenta(5);
        
        int resultado = daoVenta.modificar(venta);
        
        
        assertTrue(resultado>0);

    }
    
    
    @Test
    @Order(3)
    public void verificarEliminar(){
        int idVenta =5;
        int resultado=daoVenta.eliminar(idVenta);
        
        assertTrue(resultado!=0);
    }
    


    
    @Test
    @Order(4)
    public void verificarObtenerXId(){
        
        Venta venta = daoVenta.obtenerPorId(7);
        
   
        if(venta   != null){
            
            venta.setProductos(daoItemVent.listarPorIdVenta_Activo(7));
            
            System.out.println( venta.getIdVenta());
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(venta.getFecha()) + " "  );
            System.out.println( venta.getTotal()  );
            System.out.println( venta.isActivo());
            Cliente clie = venta.getCliente();
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());
            
            Empleado emple = venta.getEmpleado();
            
            System.out.println( emple.getIdEmpleado() +  "  " + 
                    emple.getNombre() + "  " + emple.getPrimerApellido() +
                    "  " + emple.getSegundoApellido() + "  "+ 
                    emple.getCargoAsignado().getDescripcion() + " " + 
                    emple.getDni());
            
            ArrayList<ItemVenta> listaItems = venta.getProductos();
            
           
            for (ItemVenta  itemVent : listaItems ){
                  System.out.println( itemVent.getNumLinea()+ "  "
                          + itemVent.getIdPrenda()+ "  " + itemVent.getCantidad() +
                          "  " + itemVent.getSubtotal() + "   " +
                          itemVent.isActivo() ); 
            }
           
        }
        assertNotNull(venta);
        
    }
    
    
    
    
    @Test
    @Order(5)
    public void verificarObtenerXId_conItemsInactivos(){
        
        Venta venta = daoVenta.obtenerPorId(5);
        
        
        if(venta   != null){
            venta.setProductos(daoItemVent.listarPorIdVenta(5));
            System.out.println( venta.getIdVenta());
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(venta.getFecha()) + " "  );
            System.out.println( venta.getTotal()  );
            System.out.println( venta.isActivo());
            Cliente clie = venta.getCliente();
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());
            
            Empleado emple = venta.getEmpleado();
            
            System.out.println( emple.getIdEmpleado() +  "  " + 
                    emple.getNombre() + "  " + emple.getPrimerApellido() +
                    "  " + emple.getSegundoApellido() + "  "+ 
                    emple.getCargoAsignado().getDescripcion() + " " + 
                    emple.getDni());
            
            ArrayList<ItemVenta> listaItems = venta.getProductos();
            
           
            for (ItemVenta  itemVent : listaItems ){
                  System.out.println( itemVent.getNumLinea()+ "  "
                          + itemVent.getIdPrenda()+ "  " + itemVent.getCantidad() +
                          "  " + itemVent.getSubtotal() + "   " +
                          itemVent.isActivo() ); 
            }
           
        }
        assertNotNull(venta);
        
    }
    
    
    
    
    
    @Test
    @Order(6)
    public void verificarListar(){
        
        ArrayList<Venta> listaVentas = daoVenta.listarTodos();

        if(listaVentas   != null){
            
            for(Venta vent : listaVentas){
                vent.setProductos(daoItemVent.listarPorIdVenta(vent.getIdVenta()));
            }
            
            for( Venta vent : listaVentas){
                
                System.out.println( vent.getIdVenta());
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(vent.getFecha()) + " "  );
            System.out.println( vent.getTotal()  );
            System.out.println( vent.isActivo());
            Cliente clie = vent.getCliente();
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());
            
            Empleado emple = vent.getEmpleado();
            
            System.out.println( emple.getIdEmpleado() +  "  " + 
                    emple.getNombre() + "  " + emple.getPrimerApellido() +
                    "  " + emple.getSegundoApellido() + "  "+ 
                    emple.getCargoAsignado().getDescripcion() + " " + 
                    emple.getDni());
            
            ArrayList<ItemVenta> listaItems = vent.getProductos();
            
           
            for (ItemVenta  itemVent : listaItems ){
                  System.out.println( itemVent.getNumLinea()+ "  "
                          + itemVent.getIdPrenda()+ "  " + itemVent.getCantidad() +
                          "  " + itemVent.getSubtotal() + "   " +
                          itemVent.isActivo() ); 
            }
            
                System.out.println(" ");
                
            }
            
          
           
        }
        assertNotNull(listaVentas);
        
    }
    
    
    
       
    @Test
    @Order(7)
    public void verificarListar_Activo_conItemActivo(){
        
        ArrayList<Venta> listaVentas = daoVenta.lista_ventas_activas();

        if(listaVentas   != null){
            
            for(Venta vent : listaVentas){
                vent.setProductos(daoItemVent.listarPorIdVenta_Activo(vent.getIdVenta()));
            }
            
            for( Venta vent : listaVentas){
                
                System.out.println( vent.getIdVenta());
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(vent.getFecha()) + " "  );
            System.out.println( vent.getTotal()  );
            System.out.println( vent.isActivo());
            Cliente clie = vent.getCliente();
            System.out.println(clie.getIdCliente()+ "  " + clie.getTipo().getDescripcion() + "  " +
            clie.isActivo() + "  " + clie.getIdPersona() + "  "+clie.getNombre()+
                    "  " +clie.getPrimerApellido()+ "  "+ clie.getSegundoApellido() + " "
                     +  clie.getDni() + "  " + clie.getTelefono() +  "  "+ 
                            clie.getGenero());
            
            Empleado emple = vent.getEmpleado();
            
            System.out.println( emple.getIdEmpleado() +  "  " + 
                    emple.getNombre() + "  " + emple.getPrimerApellido() +
                    "  " + emple.getSegundoApellido() + "  "+ 
                    emple.getCargoAsignado().getDescripcion() + " " + 
                    emple.getDni());
            
            ArrayList<ItemVenta> listaItems = vent.getProductos();
            
           
            for (ItemVenta  itemVent : listaItems ){
                  System.out.println( itemVent.getNumLinea()+ "  "
                          + itemVent.getIdPrenda()+ "  " + itemVent.getCantidad() +
                          "  " + itemVent.getSubtotal() + "   " +
                          itemVent.isActivo() ); 
            }
            
                System.out.println(" ");
                
            }
            
          
           
        }
        assertNotNull(listaVentas);
        
    }
    
    
    
    
    
    
    
    
    
*/    
}
