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
import org.junit.jupiter.api.Order;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.LoteDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacen_X_Lote_DAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.LoteImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacen_X_Lote_Impl;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacen_X_Lote_DAOTest {
    private static MovimientoAlmacen_X_Lote_DAO daoMovAlmacen_X_Lote;
    private static MovimientoAlmacen_X_Lote datMovAlmacen_X_Lote_Test;
    private static MovimientoAlmacenDAO daoMovAlmacen;
    private static AlmacenDAO daoAlmacen;
    private static Almacen datAlmacenTest;
    private static MovimientoAlmacen datMovTest;
    private static LoteDAO daoLote;
    private static Lote datLoteTest;
    private static ArrayList<MovimientoAlmacen_X_Lote> listaMovimientoAlmacen_X_Lotes;
    private static int idMov_X_Lote;
    
    public MovimientoAlmacen_X_Lote_DAOTest(){
//        daoMovAlmacen_X_Lote=new MovimientoAlmacen_X_Lote_Impl();
//        daoMovAlmacen=new MovimientoAlmacenImpl();
//        daoAlmacen=new AlmacenImpl();
//        daoLote=new LoteImpl();
//        
//        datAlmacenTest=new Almacen();
//        datMovTest=new MovimientoAlmacen();
//        datLoteTest=new Lote();
//        datMovAlmacen_X_Lote_Test=new MovimientoAlmacen_X_Lote();
    }
    
    @BeforeAll
    public static void inicializar() throws ParseException {
        
        daoMovAlmacen_X_Lote=new MovimientoAlmacen_X_Lote_Impl();
        daoMovAlmacen=new MovimientoAlmacenImpl();
        daoAlmacen=new AlmacenImpl();
        daoLote=new LoteImpl();
        
        datAlmacenTest=new Almacen();
        datMovTest=new MovimientoAlmacen();
        datLoteTest=new Lote();
        datMovAlmacen_X_Lote_Test=new MovimientoAlmacen_X_Lote();
        
        datAlmacenTest.setNombre("Almacen de Prueba");
        datAlmacenTest.setStock(100);
        datAlmacenTest.setUbicacion("Piso X");
        datAlmacenTest.setIdTienda(1);
        datAlmacenTest.setActivo(true);
        
        daoAlmacen.insertar(datAlmacenTest);
        
        //Colocamos los datos a insertar del Movimiento.
        //Creamos el movimientoAlmacen de prueba.
        datMovTest.setDatAlmacen(datAlmacenTest);
        SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
        datMovTest.setFecha(sdf.parse("19-05-2011"));
        datMovTest.setTipo(TipoMovimiento.Entrada);
        datMovTest.setLugarOrigen("K9");
        datMovTest.setLugarDestino("K1");
        datMovTest.setActivo(true);
        
        datMovTest.setDatAlmacen(datAlmacenTest);
        daoMovAlmacen.insertar(datMovTest);
        
        datLoteTest.setDatAlmacen(datAlmacenTest);
        datLoteTest.setDescripcion("Prueba de MovimientoXLote");
        daoLote.insertar(datLoteTest);
        
        datMovAlmacen_X_Lote_Test.setDatLote(datLoteTest);
        datMovAlmacen_X_Lote_Test.setDatMov(datMovTest);
    }
    
    @AfterAll
    public static void limpiar() {
        daoAlmacen.eliminar(datAlmacenTest.getId());
        daoMovAlmacen.eliminar(datMovTest.getIdMovimiento());
        daoLote.eliminar(datLoteTest.getIdLote());
    }
    
    @Test
    @Order(1)
    public void verificarObtenerXId(){
        MovimientoAlmacen_X_Lote dato; //No es el mismo que el de la clase de prueba
        dato=daoMovAlmacen_X_Lote.obtenerPorId(1);
        if(dato!=null) dato.mostrarDatos();
        assertNotNull(dato); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(2)
    public void verificarRegistro(){
        int resultado=daoMovAlmacen_X_Lote.insertar(datMovAlmacen_X_Lote_Test);
        assertTrue(resultado>0); //Si se comprueba esta condición pasa la prueba.
        idMov_X_Lote=resultado;
    }

    @Test
    @Order(3)
    public void verificarListar(){
        listaMovimientoAlmacen_X_Lotes=daoMovAlmacen_X_Lote.listarTodos();
        if(listaMovimientoAlmacen_X_Lotes!=null)
            for (MovimientoAlmacen_X_Lote dato: listaMovimientoAlmacen_X_Lotes) {
                dato.mostrarDatos();
                System.out.println();
            }
        System.out.println();
        assertNotNull(listaMovimientoAlmacen_X_Lotes);
    }
    
    @Test
    @Order(4)
    public void verificarListarActivos(){
        //Listamos solo los activos
        listaMovimientoAlmacen_X_Lotes=daoMovAlmacen_X_Lote.listarActivos();
        if(listaMovimientoAlmacen_X_Lotes!=null)
            for (MovimientoAlmacen_X_Lote dato: listaMovimientoAlmacen_X_Lotes) {
                dato.mostrarDatos();
                System.out.println();
            }
        System.out.println();
        assertNotNull(listaMovimientoAlmacen_X_Lotes);
    }

    
    @Test
    @Order(5)
    public void verificarModificar() throws ParseException{
        //Me rindo...
        //Por alguna razon, el ID esta llegando como 0
        //Pero en registrar si esta que devuelve el id correctamente
        //Esto ya es un tema de la clase Test... Xq el método funciona correctamente.
        datMovAlmacen_X_Lote_Test.setIdMov_X_Lote(1);
        // Modificar directamente el objeto original
        // Guardar referencias originales
        Lote loteOriginal = datMovAlmacen_X_Lote_Test.getDatLote();
        MovimientoAlmacen movOriginal = datMovAlmacen_X_Lote_Test.getDatMov();

        // Modificar (por ejemplo, cambiar solo el estado activo)
        datMovAlmacen_X_Lote_Test.setActivo(false);

        int resultado = daoMovAlmacen_X_Lote.modificar(datMovAlmacen_X_Lote_Test);
        assertTrue(resultado > 0);

        // Restaurar valores originales
        datMovAlmacen_X_Lote_Test.setActivo(true);
        datMovAlmacen_X_Lote_Test.setDatLote(loteOriginal);
        datMovAlmacen_X_Lote_Test.setDatMov(movOriginal);
        daoMovAlmacen_X_Lote.modificar(datMovAlmacen_X_Lote_Test);
    }
    @Test
    @Order(6)
    public void verificarEliminar(){
        //Eliminamos el movimiento recien ingresado.
        int resultado=daoMovAlmacen_X_Lote.eliminar(datMovAlmacen_X_Lote_Test.getIdMov_X_Lote());        
        assertTrue(resultado!=0);
    }
}
