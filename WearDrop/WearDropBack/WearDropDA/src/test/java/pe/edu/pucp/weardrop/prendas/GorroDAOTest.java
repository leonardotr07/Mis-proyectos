/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

import java.util.ArrayList;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import static org.junit.jupiter.api.Assertions.*;

import pe.edu.pucp.weardrop.prendas.dao.GorroDAO;
import pe.edu.pucp.weardrop.prendas.mysql.GorroImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoGorra;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class GorroDAOTest {

    private static GorroDAO daoGorro;
    private static ArrayList<Gorro> gorros;

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoGorro = new GorroImpl();
    }

    @AfterAll
    public static void tearDownClass() throws Exception { }

    @BeforeEach
    public void setUp() throws Exception { }

    @AfterEach
    public void tearDown() throws Exception { }

    @Test
    @Order(1)
    public void verificarRegistro() {
        Gorro g = new Gorro();
        g.setNombre("Gorro Bucket");
        g.setPrecioUnidad(35.90);
        g.setPrecioMayor(30.00);
        g.setPrecioDocena(340.00);
        g.setAlertaMinStock(5);
        g.setColor("Beige");

        // ¡OJO! Deben coincidir EXACTO con los ENUMs de tu modelo/BD
        g.setMaterial(Material.Algodon);
        g.setTipoGorra(TipoGorra.Bucket);       // 'Bucket','Visera','Tejido','Beanie','Otro'
        g.setTallaAjustable(true);
        g.setImpermeable(false);

        int idGenerado = daoGorro.insertar(g);
        assertTrue(idGenerado != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        gorros = daoGorro.listarTodos();
        if (gorros != null) {
            for (Gorro g : gorros) {
                System.out.println(
                    "GORRO -> id:" + g.getIdPrenda()
                    + ", nombre:" + g.getNombre()
                    + ", color:" + g.getColor()
                    + ", material:" + g.getMaterial()
                    + ", tipoGorra:" + g.getTipoGorra()
                    + ", ajustable:" + g.isTallaAjustable()
                    + ", impermeable:" + g.isImpermeable()
                    + ", stock:" + g.getStockPrenda()
                    + ", alertaMinStock:" + g.getAlertaMinStock()
                    + ", activo:" + g.isActivo()
                );
            }
        }
        assertNotNull(gorros, "La lista de gorros no debe ser nula");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(gorros, "Primero ejecuta verificarListarTodas");
        assertFalse(gorros.isEmpty(), "La lista no debe estar vacía");

        Gorro ultimo = gorros.get(gorros.size() - 1);
        Gorro g = daoGorro.obtenerPorId(ultimo.getIdPrenda());
        assertNotNull(g, "Debe obtener un gorro por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(gorros, "Primero ejecuta verificarListarTodas");
        assertFalse(gorros.isEmpty(), "La lista no debe estar vacía");

        Gorro ultimo = gorros.get(gorros.size() - 1);
        // Cambios
        ultimo.setNombre("Gorro Beanie");
        ultimo.setPrecioUnidad(32.50);
        ultimo.setPrecioMayor(27.00);
        ultimo.setPrecioDocena(300.00);
        ultimo.setAlertaMinStock(7);
        ultimo.setColor("Negro");
        ultimo.setMaterial(Material.Acrilico);     // otro material válido del ENUM
        ultimo.setTipoGorra(TipoGorra.Beanie);     // otro tipo válido
        ultimo.setTallaAjustable(false);
        ultimo.setImpermeable(true);

        int res = daoGorro.modificar(ultimo);
        assertTrue(res != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(gorros, "Primero ejecuta verificarListarTodas");
        assertFalse(gorros.isEmpty(), "La lista no debe estar vacía");

        Gorro ultimo = gorros.get(gorros.size() - 1);
        int res = daoGorro.eliminar(ultimo.getIdPrenda());
        assertTrue(res != 0, "La eliminación (baja lógica o desvincular) debe afectar al menos una fila");
    }
}

