/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Order;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;

/**
 *
 * @author Leonardo
 */
public class AlmacenDAOTest {

    //Atributos
    private static AlmacenDAO daoAlmacen;
    
    //No estoy seguro del xq del static. Pero ahi esta :b (Borrenlo el comentario para el entregable :D)
    private static ArrayList<Almacen> listaAlmacenes;
    
    public AlmacenDAOTest() {
    }
    
    //Antes o Despues de todos los métodos
    @BeforeAll
    public static void setUpClass() {
        //Como en todos los métodos voy a tener que declara daoAlmacen, es preferible que se coloque aqui.
        daoAlmacen=new AlmacenImpl();
    }
    
    @AfterAll
    public static void tearDownClass() {
    }
    
    //Antes o Despues de cada método
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }
    
    //Aqui empieza la implementación del TEST
    //DA debe tener el Driver también. Para que pueda realizar los test.
    
    //OJO los registros si se siguen realizando...
    //INCLUSO EN LA COMPILACION
    @Test
    @Order(1)
    public void verificarObtenerXId(){
        Almacen datAlmacen=daoAlmacen.obtenerPorId(1);
        if(datAlmacen!=null) datAlmacen.mostrarAlmacen();
        assertNotNull(datAlmacen); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(2)
    public void verificarRegistro(){
        //Me he inventado datos
        Almacen datAlmacen=new Almacen();
        
        datAlmacen.setNombre("Principal");
        datAlmacen.setIdTienda(1);
        datAlmacen.setStock(50);
        datAlmacen.setUbicacion("Piso 2");
        
        int resultado=daoAlmacen.insertar(datAlmacen);
        
        assertTrue(resultado>0); //Si se comprueba esta condición pasa la prueba.
    }
    
    @Test
    @Order(3)
    public void verificarListar(){
        listaAlmacenes=daoAlmacen.listarTodos();
        for (Almacen datAlmacen: listaAlmacenes) {
            datAlmacen.mostrarAlmacen();
            System.out.println();
        }
        assertNotNull(listaAlmacenes);
    }
    @Test
    @Order(4)
    public void verificarListarActivos(){
        listaAlmacenes=daoAlmacen.listarActivos();
        for (Almacen datAlmacen: listaAlmacenes) {
            datAlmacen.mostrarAlmacen();
            System.out.println();
        }
        assertNotNull(listaAlmacenes);
    }
    
    @Test
    @Order(5)
    public void verificarModificar(){
        Almacen datAlmacen=new Almacen();
        
        datAlmacen.setId(1);
        datAlmacen.setNombre("Secundario"); //Esto también
        datAlmacen.setIdTienda(1);
        datAlmacen.setActivo(false);
        datAlmacen.setStock(40); //Esto cambia
        datAlmacen.setUbicacion("Piso 9"); //Esto cambia

        int resultado=daoAlmacen.modificar(datAlmacen);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idAlmacen=1;
        int resultado=daoAlmacen.eliminar(idAlmacen);
        
        assertTrue(resultado!=0);
    }

}
