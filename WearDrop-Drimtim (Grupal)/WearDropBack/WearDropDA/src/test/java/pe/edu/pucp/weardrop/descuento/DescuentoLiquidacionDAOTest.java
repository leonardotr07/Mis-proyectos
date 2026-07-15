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
import pe.edu.pucp.weardrop.descuento.dao.DescuentoLiquidacionDAO;
import pe.edu.pucp.weardrop.descuento.mysql.DescuentoLiquidacionImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class DescuentoLiquidacionDAOTest {
    private static DescuentoLiquidacionDAO daoDesc;
    private static ArrayList<DescuentoLiquidacion> listDesc;
    public DescuentoLiquidacionDAOTest(){
        
    }
    @BeforeAll
    public static void setUpClass() {
        daoDesc=new DescuentoLiquidacionImpl();
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
        DescuentoLiquidacion  desc=daoDesc.obtenerPorId(1);
        if(desc!=null){
            System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getCondicionStockMin()+" "+desc.getPorcentajeLiquidacion());
        }
        assertNotNull(desc); //Verificamos si el puntero no es NULO
    }
    
    @Test
    @Order(1)
    public void verificarRegistro(){
        //Me he inventado datos
        DescuentoLiquidacion desc=new DescuentoLiquidacion();
        desc.setActivo(true);
        desc.setCondicionStockMin(11);
        desc.setNombre("DESCUENTO 3 ");
        desc.setPorcentajeLiquidacion(10.6);
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
        for (DescuentoLiquidacion desc: listDesc) {
           System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getCondicionStockMin()+" "+desc.getPorcentajeLiquidacion());
            System.out.println();
        }
        assertNotNull(listDesc);
    }
    @Test
    @Order(5)
    public void verificarListarActivos(){
        listDesc=daoDesc.listarActivos();
        for (DescuentoLiquidacion desc: listDesc) {
           System.out.println(desc.getIdDescuento()+" "+desc.getNombre());
            System.out.println(desc.getCondicionStockMin()+" "+desc.getPorcentajeLiquidacion());
            System.out.println();
        }
        assertNotNull(listDesc);
    }
    
    @Test
    @Order(3)
    public void verificarModificar(){
        DescuentoLiquidacion desc=new DescuentoLiquidacion();
        DescuentoLiquidacionDAO dao2;
        dao2=new DescuentoLiquidacionImpl();
        desc=dao2.obtenerPorId(1);
        desc.setCondicionStockMin(30);
        desc.setNombre("DESCUENTO 2 ");
        desc.setPorcentajeLiquidacion(40.6);
       int resultado=daoDesc.modificar(desc);
        assertTrue(resultado!=0);
    }
    
    @Test
    @Order(6)
    public void verificarEliminar(){
        int idProm=2;
        int resultado=daoDesc.eliminar(idProm);
        
        assertTrue(resultado!=0);
    }
}
