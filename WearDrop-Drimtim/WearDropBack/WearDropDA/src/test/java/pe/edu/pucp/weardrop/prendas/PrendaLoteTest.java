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

import pe.edu.pucp.weardrop.prendas.dao.PrendaLoteDAO;
import pe.edu.pucp.weardrop.prendas.mysql.PrendaLoteImpl;
import pe.edu.pucp.weardrop.prendas.PrendaLote;
import pe.edu.pucp.weardrop.prendas.Talla;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)

public class PrendaLoteTest {

    private static PrendaLoteDAO dao;
    private static ArrayList<PrendaLote> registros;
    private static int lastInsertedId;

    // IDs fijos para la prueba (deben existir en la BD)
    private static final int TEST_ID_PRENDA = 1;
    private static final int TEST_ID_LOTE   = 1;

    @BeforeAll
    public static void setUpClass() throws Exception {
        dao = new PrendaLoteImpl();
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
        PrendaLote pl = new PrendaLote();
        pl.setIdPrenda(TEST_ID_PRENDA);
        pl.setIdLote(TEST_ID_LOTE);
        pl.setTalla(Talla.M);
        pl.setStock(10);
        pl.setActivo(true);

        int idGen = dao.insertar(pl);
        assertTrue(idGen > 0, "El id generado debe ser > 0");
        assertEquals(idGen, pl.getIdPrendaLote());
        lastInsertedId = idGen;
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        registros = dao.listarTodos();
        assertNotNull(registros, "La lista no debe ser null");
        assertFalse(registros.isEmpty(), "La lista no debe estar vacía");
        for (PrendaLote r : registros) {
            System.out.println(
                "PL -> id:" + r.getIdPrendaLote()
                + ", idPrenda:" + r.getIdPrenda()
                + ", idLote:" + r.getIdLote()
                + ", talla:" + r.getTalla()
                + ", stock:" + r.getStock()
                + ", activo:" + r.isActivo()
            );
        }
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertTrue(lastInsertedId > 0, "Debe existir un id insertado previamente");
        PrendaLote pl = dao.obtenerPorId(lastInsertedId);
        assertNotNull(pl, "No debe ser null");
        assertEquals(lastInsertedId, pl.getIdPrendaLote(), "Debe coincidir el id");
        assertEquals(TEST_ID_PRENDA, pl.getIdPrenda(), "idPrenda debe coincidir con el insert");
        assertEquals(TEST_ID_LOTE, pl.getIdLote(), "idLote debe coincidir con el insert");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertTrue(lastInsertedId > 0, "Debe existir un id insertado previamente");
        PrendaLote pl = dao.obtenerPorId(lastInsertedId);
        assertNotNull(pl, "Registro a modificar no encontrado");

        pl.setStock(pl.getStock() + 5);
        pl.setActivo(true);

        int res = dao.modificar(pl);
        assertTrue(res != 0, "La modificación debe devolver != 0");

        PrendaLote actualizado = dao.obtenerPorId(lastInsertedId);
        assertNotNull(actualizado);
        assertEquals(pl.getStock(), actualizado.getStock(), "El stock debe reflejar el cambio");
        assertTrue(actualizado.isActivo(), "Debe permanecer activo");
    }

    @Test
    @Order(5)
    public void verificarEliminarBajaLogica() {
        assertTrue(lastInsertedId > 0, "Debe existir un id insertado previamente");
        int res = dao.eliminar(lastInsertedId);
        assertTrue(res != 0, "La eliminación (baja lógica) debe devolver != 0");

        PrendaLote after = dao.obtenerPorId(lastInsertedId);
        assertNotNull(after, "Debe existir el registro");
        assertFalse(after.isActivo(), "Tras eliminar, activo debe ser false (baja lógica)");
    }

    @Test
    @Order(6)
    public void verificarGetStockPorTalla() {
        int total = dao.getStockPorTalla(TEST_ID_PRENDA, Talla.M);
        System.out.println("Stock total de prenda " + TEST_ID_PRENDA + " en talla M = " + total);
        assertTrue(total >= 0, "El stock total debe ser >= 0");
    }
}

