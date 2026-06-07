/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.clasificacionropa;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class VigenciaDAOTest {
    
    private static VigenciaDAO daoVig;
    private static ArrayList<Vigencia> listVig;
    
    public VigenciaDAOTest(){
        
    }
    @BeforeAll
    public static void setUpClass() {
        daoVig=new VigenciaImpl();
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
    @Order(2)
    public void verificarObtenerXId(){
        Vigencia vig=daoVig.obtenerPorId(1);
        if(vig!=null) vig.mostrar();
        assertNotNull(vig); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(1)
    public void verificarRegistro() throws ParseException{
        //Me he inventado datos
        Vigencia vig=new Vigencia();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        vig.setFechaInicio(sdf.parse("1999-12-01"));
        vig.setFechaFin(sdf.parse("2019-12-01"));
        vig.setActivo(true);

       
        int resultado=daoVig.insertar(vig);
        
        assertTrue(resultado>0); //Si se comprueba esta condición pasa la prueba.
    }
    @Test
    @Order(4)
    public void verificarListar(){
        listVig=daoVig.listarTodos();
        for (Vigencia vig: listVig) {
            vig.mostrar();
            System.out.println();
        }
        assertNotNull(listVig);
    }
    @Test
    @Order(5)
    public void verificarListarActivos(){
        listVig=daoVig.listarActivos();
        for (Vigencia vig: listVig) {
            vig.mostrar();
            System.out.println();
        }
        assertNotNull(listVig);
    }
    
    @Test
    @Order(3)
    public void verificarModificar() throws ParseException{
        Vigencia vig=new Vigencia();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        vig.setIdVigencia(1);
        vig.setFechaInicio(sdf.parse("2000-12-01"));
        vig.setFechaFin(sdf.parse("2020-12-01"));
        vig.setActivo(true);

        int resultado=daoVig.modificar(vig);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idVig=2;
        int resultado=daoVig.eliminar(idVig);
        
        assertTrue(resultado!=0);
    }
}
