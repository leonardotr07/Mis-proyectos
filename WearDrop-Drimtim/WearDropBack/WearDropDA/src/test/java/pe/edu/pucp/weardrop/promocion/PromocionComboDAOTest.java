/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion;

import java.util.ArrayList;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.promocion.dao.PromocionComboDAO;
import pe.edu.pucp.weardrop.promocion.mysql.PromocionComboImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class PromocionComboDAOTest {
    private static PromocionComboDAO daoProm;
    private static ArrayList<PromocionCombo> listProm;
    
    public PromocionComboDAOTest(){
      
    }
    
    @BeforeAll
    public static void setUpClass() {
        daoProm=new PromocionComboImpl();
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
        PromocionCombo datProm=daoProm.obtenerPorId(1);
        if(datProm!=null){
            System.out.println(datProm.getIdPromocion()+" "+datProm.getNombre());
            System.out.println(datProm.getCantidadGratis()+" "+datProm.getCantidadRequerida());
        }
        assertNotNull(datProm); //Verificamos si el puntero no es NULO
    }
    @Test
    @Order(2)
    public void verificarRegistro(){
        //Me he inventado datos
        PromocionCombo prom=new PromocionCombo();
        prom.setActivo(true);
        prom.setEsAutomatico(true);
        prom.setCantidadGratis(10);
        prom.setCantidadRequerida(10);
        prom.setNombre("HOLA");
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
        for (PromocionCombo prom: listProm) {
            System.out.println(prom.getIdPromocion()+" "+prom.getNombre());
            System.out.println(prom.getCantidadGratis()+" "+prom.getCantidadRequerida());
            System.out.println();
        }
        assertNotNull(listProm);
    }
    @Test
    @Order(4)
    public void verificarListarActivos(){
       listProm=daoProm.listarActivos();
        for (PromocionCombo prom: listProm) {
            System.out.println(prom.getIdPromocion()+" "+prom.getNombre());
            System.out.println(prom.getCantidadGratis()+" "+prom.getCantidadRequerida());
            System.out.println();
        }
        assertNotNull(listProm);
    }
    @Test
    @Order(5)
    public void verificarModificar(){
        PromocionCombo prom=new PromocionCombo();
        PromocionComboDAO daoProm;
        daoProm=new PromocionComboImpl();
        prom=daoProm.obtenerPorId(2);
        prom.setCantidadGratis(15);
        prom.setCantidadRequerida(15);
        prom.setNombre("HOLA2");
        int resultado=daoProm.modificar(prom);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idProm=2;
        int resultado=daoProm.eliminar(idProm);
        
        assertTrue(resultado!=0);
    }
}
