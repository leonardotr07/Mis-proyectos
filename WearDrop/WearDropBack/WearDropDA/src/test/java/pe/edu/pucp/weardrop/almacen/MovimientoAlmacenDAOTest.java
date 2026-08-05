/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;

/**
 *
 * @author Leonardo
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MovimientoAlmacenDAOTest {
    private static MovimientoAlmacenDAO daoMovAlmacen;
    private static AlmacenDAO daoAlmacen;
    private static ArrayList<MovimientoAlmacen> listaMovimientos;
    private static Almacen datAlmacenTest;
    private static MovimientoAlmacen datMov;
    public MovimientoAlmacenDAOTest() {   
        daoAlmacen=new AlmacenImpl();
        datAlmacenTest=new Almacen();
        
        daoMovAlmacen=new MovimientoAlmacenImpl();
        datMov=new MovimientoAlmacen();
    }
    @BeforeAll
    public static void inicializar() throws ParseException{
        //Este almacen servirá para probar las relacion (Almacen - MovimientoAlmacen).
        //Solo para los métodos de REGISTRAR Y MODIFICAR
        //Creamos el almacen de prueba        
        datAlmacenTest.setNombre("Almacen de Prueba");
        datAlmacenTest.setStock(100);
        datAlmacenTest.setUbicacion("Piso X");
        datAlmacenTest.setIdTienda(1);
        datAlmacenTest.setActivo(true);
        
        daoAlmacen.insertar(datAlmacenTest);
        
        //Colocamos los datos a insertar del Movimiento.
        datMov.setDatAlmacen(datAlmacenTest);
        SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
        datMov.setFecha(sdf.parse("19-05-2011"));
        datMov.setTipo(TipoMovimiento.Entrada);
        datMov.setLugarOrigen("K9");
        datMov.setLugarDestino("K1");
        datMov.setActivo(true);
        
    }
    
    @AfterAll
    public static void limpiar(){
        //Desvinculamos el almacen de prueba...
        daoAlmacen.eliminar(datAlmacenTest.getId());
    }
    
    @Test
    @Order(1)
    public void verificarObtenerXId(){
        MovimientoAlmacen datMovimiento;
        datMovimiento=daoMovAlmacen.obtenerPorId(1);
        if(datMovimiento!=null) datMovimiento.mostrarMovAlmacen();
        assertNotNull(datMovimiento); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(2)
    public void verificarRegistro(){
        int resultado=daoMovAlmacen.insertar(datMov);
        assertTrue(resultado>0); //Si se comprueba esta condición pasa la prueba.
    }

    @Test
    @Order(3)
    public void verificarListar(){
        listaMovimientos=daoMovAlmacen.listarTodos();
        for (MovimientoAlmacen datMovimiento: listaMovimientos) {
            datMovimiento.mostrarMovAlmacen();
            System.out.println();
        }
        assertNotNull(listaMovimientos);
    }
    
    @Test
    @Order(4)
    public void verificarListarActivos(){
        listaMovimientos=daoMovAlmacen.listarActivos();
        for (MovimientoAlmacen datMovimiento: listaMovimientos) {
            datMovimiento.mostrarMovAlmacen();
            System.out.println();
        }
        assertNotNull(listaMovimientos);
        //En la BD no se va a ver ningun activo xq el eliminar se ejecuta después...
    }
    
    @Test
    @Order(5)
    public void verificarModificar() throws ParseException{
        //Datos a modificar...
        datMov.setTipo(TipoMovimiento.Mov_Interno); 
        datMov.setActivo(true);
        
        int resultado=daoMovAlmacen.modificar(datMov);
        assertTrue(resultado>0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        //Eliminamos el movimiento recien ingresado.
        int resultado=daoMovAlmacen.eliminar(datMov.getIdMovimiento());        
        assertTrue(resultado!=0);
    }
}
