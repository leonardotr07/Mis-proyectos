/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas;

import java.util.ArrayList;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.TestMethodOrder;

import pe.edu.pucp.weardrop.prendas.dao.PoloDAO;
import pe.edu.pucp.weardrop.prendas.mysql.PoloImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.TipoCuello;
import pe.edu.pucp.weardrop.prendas.Polo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PoloDAOTest {

    private static PoloDAO daoPolo;
    private static ArrayList<Polo> polos;

    public PoloDAOTest() {}

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoPolo = new PoloImpl();
    }

    @AfterAll
    public static void tearDownClass() throws Exception {
    }

    @BeforeEach
    public void setUp() throws Exception {
    }

    @AfterEach
    public void tearDown() throws Exception {
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        Polo ultima = polos.get(polos.size() - 1);
        Polo p = daoPolo.obtenerPorId(ultima.getIdPrenda());
        assertNotNull(p);
    }

    @Test
    @Order(1)
    public void verificarRegistro() {
        Polo p = new Polo();
        p.setNombre("Polo Básico");
        p.setPrecioUnidad(29.90);
        p.setPrecioMayor(25.00);
        p.setPrecioDocena(260.00);
        p.setAlertaMinStock(10);
        p.setColor("Blanco");

        // ¡OJO! Deben coincidir exactamente con los ENUMs de tu modelo/BD
        p.setMaterial(Material.Acrilico);
        p.setTipoManga(TipoManga.MangaCorta);
        p.setEstampado("Logo");
        p.setTipoCuello(TipoCuello.Redondo);

        int resultado = daoPolo.insertar(p);
        assertTrue(resultado != 0);
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        polos = daoPolo.listarTodos();
        if (polos != null) {
            for (Polo po : polos) {
                System.out.println(
                    "POLO -> id:" + po.getIdPrenda()
                    + ", nombre:" + po.getNombre()
                    + ", color:" + po.getColor()
                    + ", material:" + po.getMaterial()
                    + ", tipoManga:" + po.getTipoManga()
                    + ", tipoCuello:" + po.getTipoCuello()
                    + ", estampado:" + po.getEstampado()
                    + ", activo:" + po.isActivo()
                );
            }
        }
        assertNotNull(polos);
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(polos);
        assertFalse(polos.isEmpty(), "La lista de polos no debe estar vacía");

        Polo ultimo = polos.get(polos.size() - 1);
        // Cambiamos algunos campos:
        ultimo.setNombre("Polo Premium");
        ultimo.setPrecioUnidad(39.90);
        ultimo.setPrecioMayor(33.00);
        ultimo.setPrecioDocena(330.00);
        ultimo.setAlertaMinStock(15);
        ultimo.setColor("Negro");
        ultimo.setMaterial(Material.Algodon);
        ultimo.setTipoManga(TipoManga.MangaCorta);
        ultimo.setEstampado("Sin estampado");
        ultimo.setTipoCuello(TipoCuello.Redondo);
        // Si usas baja lógica, puedes dejar activo como está o setearlo a true:
        ultimo.setActivo(true);

        int resultado = daoPolo.modificar(ultimo);
        assertTrue(resultado != 0);
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(polos);
        assertFalse(polos.isEmpty(), "La lista de polos no debe estar vacía");

        Polo ultimo = polos.get(polos.size() - 1);
        int resultado = daoPolo.eliminar(ultimo.getIdPrenda());
        assertTrue(resultado != 0);
    }
}


