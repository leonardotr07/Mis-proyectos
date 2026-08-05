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

import pe.edu.pucp.weardrop.prendas.dao.CasacaDAO;
import pe.edu.pucp.weardrop.prendas.mysql.CasacaImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoCasaca;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CasacaDAOTest {

    private static CasacaDAO daoCasaca;
    private static ArrayList<Casaca> casacas;

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoCasaca = new CasacaImpl();
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
        Casaca c = new Casaca();
        c.setNombre("Casaca Bomber");
        c.setPrecioUnidad(149.90);
        c.setPrecioMayor(130.00);
        c.setPrecioDocena(1500.00);
        c.setAlertaMinStock(8);
        c.setColor("Negro");

        // ¡Ajusta estos literales a tus enums reales!
        c.setMaterial(Material.Algodon);      // o Poliester, Denim, etc., según tu ENUM
        c.setTipoCasaca(TipoCasaca.Bomber);   // ej. Bomber, Parka, Biker, Rompevientos...
        c.setConCapucha(true);

        int idGen = daoCasaca.insertar(c);
        assertTrue(idGen != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        casacas = daoCasaca.listarTodos();
        if (casacas != null) {
            for (Casaca c : casacas) {
                System.out.println(
                    "CASACA -> id:" + c.getIdPrenda()
                    + ", nombre:" + c.getNombre()
                    + ", color:" + c.getColor()
                    + ", material:" + c.getMaterial()
                    + ", tipoCasaca:" + c.getTipoCasaca()
                    + ", conCapucha:" + c.isConCapucha()
                    + ", stock:" + c.getStockPrenda()
                    + ", alertaMinStock:" + c.getAlertaMinStock()
                    + ", activo:" + c.isActivo()
                );
            }
        }
        assertNotNull(casacas, "La lista de casacas no debe ser nula");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(casacas, "Primero ejecuta verificarListarTodas");
        assertFalse(casacas.isEmpty(), "La lista no debe estar vacía");

        Casaca ultima = casacas.get(casacas.size() - 1);
        Casaca c = daoCasaca.obtenerPorId(ultima.getIdPrenda());
        assertNotNull(c, "Debe obtener una casaca por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(casacas, "Primero ejecuta verificarListarTodas");
        assertFalse(casacas.isEmpty(), "La lista no debe estar vacía");

        Casaca ultima = casacas.get(casacas.size() - 1);

        // Cambios
        ultima.setNombre("Casaca Bomber Premium");
        ultima.setPrecioUnidad(169.90);
        ultima.setPrecioMayor(150.00);
        ultima.setPrecioDocena(1680.00);
        ultima.setAlertaMinStock(12);
        ultima.setColor("Azul");
        ultima.setMaterial(Material.Poliester);     // ajusta a tu ENUM
        ultima.setTipoCasaca(TipoCasaca.Bomber);     // ajusta a tu ENUM
        ultima.setConCapucha(false);
        ultima.setActivo(true);

        int res = daoCasaca.modificar(ultima);
        assertTrue(res != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(casacas, "Primero ejecuta verificarListarTodas");
        assertFalse(casacas.isEmpty(), "La lista no debe estar vacía");

        Casaca ultima = casacas.get(casacas.size() - 1);
        int res = daoCasaca.eliminar(ultima.getIdPrenda());
        assertTrue(res != 0, "La eliminación (baja lógica) debe afectar al menos una fila");
    }
}

