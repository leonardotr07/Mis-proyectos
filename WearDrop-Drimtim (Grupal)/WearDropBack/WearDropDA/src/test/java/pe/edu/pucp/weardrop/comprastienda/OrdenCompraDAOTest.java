/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda;

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
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.comprastienda.dao.LineaLoteCompraDAO;
import pe.edu.pucp.weardrop.comprastienda.dao.OrdenCompraDAO;
import pe.edu.pucp.weardrop.comprastienda.mysql.LineaLoteCompraImpl;
import pe.edu.pucp.weardrop.comprastienda.mysql.OrdenCompraImpl;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.prendas.Talla;

/**
 *
 * @author matia
 */
public class OrdenCompraDAOTest {

    private static OrdenCompraDAO daoOrdenCompra;
    private static LineaLoteCompraDAO daoLineaLoteCompra;

    public OrdenCompraDAOTest() {
    }

    @BeforeAll
    public static void setUpClass() {

        daoLineaLoteCompra = new LineaLoteCompraImpl();
        daoOrdenCompra = new OrdenCompraImpl();
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
    // public void hello() {
    
    
    
    
    @Test
    @Order(1)
    public void verificarRegistro()
            throws ParseException {

        OrdenCompra ordenCompra = new OrdenCompra();

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        ordenCompra.setFechaLlegada(sdf.parse("12-10-2025"));

        ordenCompra.setFechaEmision(sdf.parse("08-10-2025"));

        ordenCompra.setDeudaPendiente(999.0);

        Proveedor prove = new Proveedor();

        prove.setIdProveedor(2);

        ordenCompra.setProveedor(prove);

        ordenCompra.setMontoTotal(10000.0);

        ordenCompra.setActivo(true);

        Empleado emple = new Empleado();

        emple.setIdEmpleado(11);

        ordenCompra.setEmpleado(emple);

        LineaLoteCompra linea1 = new LineaLoteCompra();

        linea1.setIdPrenda(18);
        linea1.setCantidad(10);
        linea1.setTalla(Talla.L);

        Lote lote1 = new Lote();

        lote1.setIdLote(30);
        lote1.setDatAlmacen(new Almacen());

        linea1.setLote(lote1);

        linea1.setPrecioLote(770.0);

        linea1.setActivo(true);

        ordenCompra.getItems().add(linea1);

        LineaLoteCompra linea2 = new LineaLoteCompra();

        linea2.setIdPrenda(17);
        linea2.setCantidad(30);
        linea2.setTalla(Talla.S);

        Lote lote2 = new Lote();

        lote2.setIdLote(17);
        lote2.setDatAlmacen(new Almacen());

        linea2.setLote(lote2);

        linea2.setPrecioLote(880.0);

        linea2.setActivo(true);
        ordenCompra.getItems().add(linea2);

        int resultado = daoOrdenCompra.insertar(ordenCompra);

        assertTrue(resultado > 0);

    }
    
    
    
    
    
    
    
    @Test
    @Order(2)
    public void verificarModificar() throws ParseException{
        
        
        OrdenCompra ordenCompra = new OrdenCompra();
        
        ordenCompra.setIdCompra(3);

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        ordenCompra.setFechaLlegada(sdf.parse("20-10-2025"));

        ordenCompra.setFechaEmision(sdf.parse("08-10-2025"));

        ordenCompra.setDeudaPendiente(1500.0);

        Proveedor prove = new Proveedor();

        prove.setIdProveedor(2);

        ordenCompra.setProveedor(prove);

        ordenCompra.setMontoTotal(9000.0);

        ordenCompra.setActivo(true);

        Empleado emple = new Empleado();

        emple.setIdEmpleado(11);

        ordenCompra.setEmpleado(emple);

        LineaLoteCompra linea1 = new LineaLoteCompra();

        linea1.setIdPrenda(18);
        linea1.setCantidad(10);
        linea1.setTalla(Talla.L);

        Lote lote1 = new Lote();

        lote1.setIdLote(30);
        lote1.setDatAlmacen(new Almacen());

        linea1.setLote(lote1);

        linea1.setPrecioLote(666.0);

        linea1.setActivo(true);

        ordenCompra.getItems().add(linea1);

        LineaLoteCompra linea2 = new LineaLoteCompra();

        linea2.setIdPrenda(17);
        linea2.setCantidad(30);
        linea2.setTalla(Talla.S);

        Lote lote2 = new Lote();

        lote2.setIdLote(17);
        lote2.setDatAlmacen(new Almacen());

        linea2.setLote(lote2);

        linea2.setPrecioLote(555.0);

        linea2.setActivo(true);
        ordenCompra.getItems().add(linea2);

        int resultado = daoOrdenCompra.modificar(ordenCompra);

        assertTrue(resultado > 0);

    }
    
    
    
    
    
    @Test
    @Order(3)
    public void verificarEliminar(){
        int idCompra =3;
        int resultado=daoOrdenCompra.eliminar(idCompra);
        
        assertTrue(resultado!=0);
    }
    


    
    @Test
    @Order(4)
    public void verificarObtenerXId(){
        
        OrdenCompra ordComp = daoOrdenCompra.obtenerPorId(4);
        
        if(ordComp != null){
            
            ordComp.setItems(
                    daoLineaLoteCompra.listarPorIdOrdenCompra_Activo(ordComp.getIdCompra())); 
            
            System.out.println(ordComp.getIdCompra());
            
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(ordComp.getFechaEmision()) + " ");
            System.out.println(formato.format(ordComp.getFechaLlegada()) + " ");
            System.out.println(ordComp.getDeudaPendiente());
            System.out.println(ordComp.getProveedor().getIdProveedor() + "  " + 
                    ordComp.getProveedor().getNombre());
            System.out.println(ordComp.getMontoTotal());
            System.out.println(ordComp.isActivo());
            System.out.println(ordComp.getEmpleado().getIdEmpleado() + "  " + 
                    ordComp.getEmpleado().getNombre());
            System.out.println("");
            ArrayList<LineaLoteCompra> listaLinea  = ordComp.getItems();
            
            for(LineaLoteCompra linea: listaLinea){
                
                System.out.println(linea.getNumLinea());
                System.out.println(linea.getIdPrenda());
                System.out.println(linea.getTalla().name());
                System.out.println(linea.getLote().getIdLote());
                System.out.println(linea.getPrecioLote());
                System.out.println(linea.isActivo());
                System.out.println(" ");

            }

        }
        
        assertNotNull(ordComp);

        
    }
    
    
  
    
     @Test
    @Order(5)
    public void verificarListar(){
        
        ArrayList<OrdenCompra> listaOrdenCompra = daoOrdenCompra.listarTodos();

        if(listaOrdenCompra   != null){
            
            for(OrdenCompra ordComp : listaOrdenCompra){
                ArrayList<LineaLoteCompra> lineaAux = daoLineaLoteCompra.listarPorIdOrdenCompra(
                        ordComp.getIdCompra());
                if(lineaAux != null){
                     ordComp.setItems(lineaAux);
                }
            }
            
            for( OrdenCompra ordComp : listaOrdenCompra){
                
                System.out.println(ordComp.getIdCompra());
            
            SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
            System.out.println(formato.format(ordComp.getFechaEmision()) + " ");
            System.out.println(formato.format(ordComp.getFechaLlegada()) + " ");
            System.out.println(ordComp.getDeudaPendiente());
            System.out.println(ordComp.getProveedor().getIdProveedor() + "  " + 
                    ordComp.getProveedor().getNombre());
            System.out.println(ordComp.getMontoTotal());
            System.out.println(ordComp.isActivo());
            System.out.println(ordComp.getEmpleado().getIdEmpleado() + "  " + 
                    ordComp.getEmpleado().getNombre());
            System.out.println("");
            ArrayList<LineaLoteCompra> listaLinea  = ordComp.getItems();
            
            if(listaLinea != null ){
                for(LineaLoteCompra linea: listaLinea){
                
                System.out.println(linea.getNumLinea());
                System.out.println(linea.getIdPrenda());
                System.out.println(linea.getTalla().name());
                System.out.println(linea.getLote().getIdLote());
                System.out.println(linea.getPrecioLote());
                System.out.println(linea.isActivo());
                System.out.println(" ");

            }
                
                
            }
            
                
            }
            
          
           
        }
        assertNotNull(listaOrdenCompra);
        
    }
    
    
    
    
    
    
    
}
