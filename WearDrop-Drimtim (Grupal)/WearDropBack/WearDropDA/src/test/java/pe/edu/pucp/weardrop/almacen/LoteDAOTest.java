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
import pe.edu.pucp.weardrop.almacen.dao.LoteDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.LoteImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;

/**
 *
 * @author Leonardo
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class LoteDAOTest {
    
    private static AlmacenDAO daoAlmacen;
    private static Almacen datAlmacenTest;
    
    private static Lote datLote;
    private static LoteDAO daoLote;
    private static ArrayList<Lote> listaLotes;
    
    public LoteDAOTest() {
        daoAlmacen=new AlmacenImpl();
        datAlmacenTest=new Almacen();
        
        daoLote=new LoteImpl();
        datLote=new Lote();
    }
    @BeforeAll
    public static void inicializar() throws ParseException{
        //Estos datos serviran para probar la relacion entre (Almacen - MovimientoAlmacen - Lote).
        //Solo para los métodos de REGISTRAR Y MODIFICAR?
        //Creamos el almacen de prueba        
        datAlmacenTest.setNombre("Almacen de Prueba");
        datAlmacenTest.setStock(100);
        datAlmacenTest.setUbicacion("Piso X");
        datAlmacenTest.setIdTienda(1);
        datAlmacenTest.setActivo(true);
        
        daoAlmacen.insertar(datAlmacenTest);
        
        //Vinculamos los objetos previos con el de la clase a testear...
        datLote.setDatAlmacen(datAlmacenTest);
        datLote.setDescripcion("Esta es una prueba del atributo descripcion");
    }
    
    @AfterAll
    public static void limpiar(){
        //Hacemos no valido el registro de almacen y el movAlmacen ya que son de prueba
        daoAlmacen.eliminar(datAlmacenTest.getId());
        //El objeto de la clase Lote se elimina con el Test propio de eliminar
    }
    
    @Test
    @Order(1)
    public void verificarObtenerXId(){
        Lote lote; //No es el mismo que el de la clase de prueba
        lote=daoLote.obtenerPorId(1);
        if(lote!=null) lote.mostrarLote();
        assertNotNull(lote); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(2)
    public void verificarRegistro(){
        int resultado=daoLote.insertar(datLote);
        assertTrue(resultado!=0); //Si se comprueba esta condición pasa la prueba.
    }

    @Test
    @Order(3)
    public void verificarListar(){
        listaLotes=daoLote.listarTodos();
        if(listaLotes!=null)
            for (Lote lote: listaLotes) {
                lote.mostrarLote();
                System.out.println();
            }
        System.out.println();
        assertNotNull(listaLotes);
    }
    
    @Test
    @Order(4)
    public void verificarListarActivos(){
        //Listamos solo los activos
        listaLotes=daoLote.listarActivos();
        if(listaLotes!=null)
            for (Lote lote: listaLotes) {
                lote.mostrarLote();
                System.out.println();
            }
        System.out.println();
        assertNotNull(listaLotes);
    }
    @Test
    @Order(5)
    public void verificarModificar() throws ParseException{
        //Datos a modificar...
        
        datLote.setActivo(true);
        Almacen datAlmacen=datLote.getDatAlmacen();
        
        datAlmacen.setId(1);
        
        
        datLote.setDatAlmacen(datAlmacen);
        
        int resultado=daoLote.modificar(datLote);
        //Lo vuelvo a cambiar para no afectar otros registros...
        assertTrue(resultado>0);
        daoLote.modificar(datLote);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        //Eliminamos el movimiento recien ingresado.
        int resultado=daoLote.eliminar(datLote.getIdLote());        
        assertTrue(resultado!=0);
    }

}
