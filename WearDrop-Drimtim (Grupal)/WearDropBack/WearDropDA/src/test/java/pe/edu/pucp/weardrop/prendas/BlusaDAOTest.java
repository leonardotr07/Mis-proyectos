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

import pe.edu.pucp.weardrop.prendas.dao.BlusaDAO;
import pe.edu.pucp.weardrop.prendas.mysql.BlusaImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.TipoBlusa;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BlusaDAOTest {

    private static BlusaDAO daoBlusa;
    private static ArrayList<Blusa> blusas;

    public BlusaDAOTest() {
    }

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoBlusa = new BlusaImpl();
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
    @Order(1)
    public void verificarRegistro() {
        Blusa b = new Blusa();
        b.setNombre("Blusa Básica");
        b.setPrecioUnidad(49.90);
        b.setPrecioMayor(42.00);
        b.setPrecioDocena(480.00);
        b.setAlertaMinStock(8);
        b.setColor("Rojo");
        b.setMaterial(Material.Algodon);
        b.setTipoBlusa(TipoBlusa.Camisera);
        b.setTipoManga(TipoManga.MangaCorta);

        int idGenerado = daoBlusa.insertar(b);
        assertTrue(idGenerado != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        Blusa ultima = blusas.get(blusas.size() - 1);
        Blusa b = daoBlusa.obtenerPorId(ultima.getIdPrenda());
        assertNotNull(b, "Debe obtener una blusa por ID");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        blusas = daoBlusa.listarTodos();
        if (blusas != null) {
            for (Blusa b : blusas) {
                System.out.println(
                        "BLUSA -> id:" + b.getIdPrenda()
                        + ", nombre:" + b.getNombre()
                        + ", color:" + b.getColor()
                        + ", material:" + b.getMaterial()
                        + ", tipoBlusa:" + b.getTipoBlusa()
                        + ", tipoManga:" + b.getTipoManga()
                        + ", stock:" + b.getStockPrenda()
                        + ", alertaMinStock:" + b.getAlertaMinStock()
                        + ", activo:" + b.isActivo()
                );
            }
        }
        assertNotNull(blusas, "La lista de blusas no debe ser nula");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(blusas, "Primero ejecuta verificarListarTodas");
        assertFalse(blusas.isEmpty(), "La lista de blusas no debe estar vacía");

        Blusa ultima = blusas.get(blusas.size() - 1);
        // Cambiamos algunos campos
        ultima.setNombre("Blusa Premium");
        ultima.setPrecioUnidad(59.90);
        ultima.setPrecioMayor(50.00);
        ultima.setPrecioDocena(560.00);
        ultima.setAlertaMinStock(12);
        ultima.setColor("Negro");
        ultima.setMaterial(Material.Algodon);
        ultima.setTipoBlusa(TipoBlusa.Camisera);
        ultima.setTipoManga(TipoManga.MangaLarga);

        int resultado = daoBlusa.modificar(ultima);
        assertTrue(resultado != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(blusas, "Primero ejecuta verificarListarTodas");
        assertFalse(blusas.isEmpty(), "La lista de blusas no debe estar vacía");

        Blusa ultima = blusas.get(blusas.size() - 1);
        int resultado = daoBlusa.eliminar(ultima.getIdPrenda()); // baja lógica o desvincular
        assertTrue(resultado != 0, "La eliminación debe afectar al menos una fila");
    }
}
