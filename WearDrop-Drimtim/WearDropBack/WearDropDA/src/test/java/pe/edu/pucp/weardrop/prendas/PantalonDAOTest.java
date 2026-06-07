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

import pe.edu.pucp.weardrop.prendas.dao.PantalonDAO;
import pe.edu.pucp.weardrop.prendas.mysql.PantalonImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoPantalon;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PantalonDAOTest {

    private static PantalonDAO daoPantalon;
    private static ArrayList<Pantalon> pantalones;

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoPantalon = new PantalonImpl();
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
        Pantalon p = new Pantalon();
        p.setNombre("Pantalón Jeans");
        p.setPrecioUnidad(119.90);
        p.setPrecioMayor(105.00);
        p.setPrecioDocena(1180.00);
        p.setAlertaMinStock(12);
        p.setColor("Azul");

        // ¡OJO! Estos deben existir tal cual en tus enums Java/BD:
        p.setMaterial(Material.Denim);          // o Material.Algodon, etc.
        p.setTipoPantalon(TipoPantalon.Jean);   // Jean, Jogger, Chino, ...

        p.setLargoPierna(104.0);
        p.setCintura(82.0);
        p.setElasticidad(true);

        int idGen = daoPantalon.insertar(p);
        assertTrue(idGen != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        pantalones = daoPantalon.listarTodos();
        if (pantalones != null) {
            for (Pantalon p : pantalones) {
                System.out.println(
                    "PANTALON -> id:" + p.getIdPrenda()
                    + ", nombre:" + p.getNombre()
                    + ", color:" + p.getColor()
                    + ", material:" + p.getMaterial()
                    + ", tipo:" + p.getTipoPantalon()
                    + ", largoPierna:" + p.getLargoPierna()
                    + ", cintura:" + p.getCintura()
                    + ", elasticidad:" + p.isElasticidad()
                    + ", stock:" + p.getStockPrenda()
                    + ", alertaMinStock:" + p.getAlertaMinStock()
                    + ", activo:" + p.isActivo()
                );
            }
        }
        assertNotNull(pantalones, "La lista de pantalones no debe ser nula");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(pantalones, "Primero ejecuta verificarListarTodas");
        assertFalse(pantalones.isEmpty(), "La lista no debe estar vacía");

        Pantalon ultimo = pantalones.get(pantalones.size() - 1);
        Pantalon p = daoPantalon.obtenerPorId(ultimo.getIdPrenda());
        assertNotNull(p, "Debe obtener un pantalón por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(pantalones, "Primero ejecuta verificarListarTodas");
        assertFalse(pantalones.isEmpty(), "La lista no debe estar vacía");

        Pantalon ultimo = pantalones.get(pantalones.size() - 1);

        // Cambios
        ultimo.setNombre("Pantalón Chino Premium");
        ultimo.setPrecioUnidad(129.90);
        ultimo.setPrecioMayor(115.00);
        ultimo.setPrecioDocena(1260.00);
        ultimo.setAlertaMinStock(15);
        ultimo.setColor("Beige");
        ultimo.setMaterial(Material.Algodon);
        ultimo.setTipoPantalon(TipoPantalon.Chino);
        ultimo.setLargoPierna(102.0);
        ultimo.setCintura(84.0);
        ultimo.setElasticidad(false);

        int res = daoPantalon.modificar(ultimo);
        assertTrue(res != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(pantalones, "Primero ejecuta verificarListarTodas");
        assertFalse(pantalones.isEmpty(), "La lista no debe estar vacía");

        Pantalon ultimo = pantalones.get(pantalones.size() - 1);
        int res = daoPantalon.eliminar(ultimo.getIdPrenda());
        assertTrue(res != 0, "La eliminación (baja lógica) debe afectar al menos una fila");
    }
}

