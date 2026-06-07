/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento;

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
import pe.edu.pucp.weardrop.descuento.dao.DescuentoMontoDAO;
import pe.edu.pucp.weardrop.descuento.mysql.DescuentoMontoImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoMonto;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class DescuentoMontoDAOTest {
    private static DescuentoMontoDAO daoDesc;
    private static ArrayList<DescuentoMonto> listDesc;
    public DescuentoMontoDAOTest(){
        
    }
    @BeforeAll
    public static void setUpClass() {
        daoDesc=new DescuentoMontoImpl();
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
        DescuentoMonto  desc=daoDesc.obtenerPorId(4);
        if(desc!=null){
            System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getMontoEditable()+" "+desc.getMontoMaximo());
        }
        assertNotNull(desc); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(1)
    public void verificarRegistro(){
        //Me he inventado datos
        DescuentoMonto desc=new DescuentoMonto();
        desc.setActivo(true);
        desc.setMontoEditable(9.7);
        desc.setNombre("DESCUENTO 3 ");
        desc.setMontoMaximo(20.6);
        Vigencia vig=new Vigencia();
        VigenciaDAO daoVig;
        daoVig=new VigenciaImpl();
        vig=daoVig.obtenerPorId(1);
       desc.setVigencia(vig);
       desc.setEsAutomatico(true);
        int resultado=daoDesc.insertar(desc);
        
        assertTrue(resultado>0); //Si se comprueba esta condición pasa la prueba.
    }
    @Test
    @Order(4)
    public void verificarListar(){
        listDesc=daoDesc.listarTodos();
        for (DescuentoMonto desc: listDesc) {
         System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getMontoEditable()+" "+desc.getMontoMaximo());
            System.out.println();
        }
        assertNotNull(listDesc);
    }
    @Test
    @Order(5)
    public void verificarListarActivos(){
        listDesc=daoDesc.listarActivos();
        for (DescuentoMonto desc: listDesc) {
           System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getMontoEditable()+" "+desc.getMontoMaximo());
            System.out.println();
        }
        assertNotNull(listDesc);
    }
    
    @Test
    @Order(3)
    public void verificarModificar(){
        DescuentoMonto desc=new DescuentoMonto();
        DescuentoMontoDAO dao2;
        dao2=new DescuentoMontoImpl();
        desc=dao2.obtenerPorId(5);
        desc.setMontoEditable(30);
        desc.setNombre("DESCUENTO 2 ");
        desc.setMontoMaximo(40.6);
       int resultado=daoDesc.modificar(desc);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idProm=5;
        int resultado=daoDesc.eliminar(idProm);
        
        assertTrue(resultado!=0);
    }
}
