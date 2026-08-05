/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.promocion.dao.PromocionConjuntoDAO;
import pe.edu.pucp.weardrop.promocion.mysql.PromocionConjuntoImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class PromocionConjuntoDAOTest {
    private static PromocionConjuntoDAO daoProm;
    private static ArrayList<PromocionConjunto> listProm;
    
    public PromocionConjuntoDAOTest(){
      
    }
    
    @BeforeAll
    public static void setUpClass() {
        daoProm=new PromocionConjuntoImpl();
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
    @Test
    @Order(1)
    public void verificarObtenerXId(){
        PromocionConjunto datProm=daoProm.obtenerPorId(5);
        if(datProm!=null){
            System.out.println(datProm.getIdPromocion()+" "+datProm.getNombre());
            System.out.println(datProm.getPorcentajePromocion());
        }
        assertNotNull(datProm); //Verificamos si el puntero no es NULO
    }
    @Test
    @Order(2)
    public void verificarRegistro(){
        //Me he inventado datos
        PromocionConjunto prom=new PromocionConjunto();
        prom.setActivo(true);
        prom.setEsAutomatico(true);
        prom.setPorcentajePromocion(10);
        prom.setNombre("HOLACON");
        Vigencia vig=new Vigencia();
        VigenciaDAO daoVig;
        daoVig=new VigenciaImpl();
        vig=daoVig.obtenerPorId(1);
        prom.setVigencia(vig);
         int resultado=daoProm.insertar(prom);
        
        assertTrue(resultado>0); 
    }
    @Test
    @Order(3)
    public void verificarListar(){
        listProm=daoProm.listarTodos();
        for (PromocionConjunto prom: listProm) {
            System.out.println(prom.getIdPromocion()+" "+prom.getNombre());
            System.out.println(prom.getPorcentajePromocion());
            System.out.println();
        }
        assertNotNull(listProm);
    }
    @Test
    @Order(4)
    public void verificarListarActivos(){
       listProm=daoProm.listarActivos();
        for (PromocionConjunto prom: listProm) {
            System.out.println(prom.getIdPromocion()+" "+prom.getNombre());
            System.out.println(prom.getPorcentajePromocion());
            System.out.println();
        }
        assertNotNull(listProm);
    }
    @Test
    @Order(5)
    public void verificarModificar(){
        PromocionConjunto prom=new PromocionConjunto();
        PromocionConjuntoDAO daoProm;
        daoProm=new PromocionConjuntoImpl();
        prom=daoProm.obtenerPorId(5);
        prom.setPorcentajePromocion(15);
        prom.setNombre("HOLA2CON");
        int resultado=daoProm.modificar(prom);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idProm=5;
        int resultado=daoProm.eliminar(idProm);
        
        assertTrue(resultado!=0);
    }

    
}
