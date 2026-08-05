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

import pe.edu.pucp.weardrop.prendas.dao.FaldaDAO;
import pe.edu.pucp.weardrop.prendas.mysql.FaldaImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoFalda;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class FaldaDAOTest {

    private static FaldaDAO daoFalda;
    private static ArrayList<Falda> faldas;

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoFalda = new FaldaImpl();
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
        Falda f = new Falda();
        f.setNombre("Falda Midi Básica");
        f.setPrecioUnidad(79.90);
        f.setPrecioMayor(69.00);
        f.setPrecioDocena(780.00);
        f.setAlertaMinStock(6);
        f.setColor("Negro");

        // ¡OJO! Deben coincidir EXACTO con los ENUMs de tu modelo/BD
        f.setMaterial(Material.Algodon);
        f.setTipoFalda(TipoFalda.Midi);
        f.setLargo(70);            // usa el tipo que maneje tu modelo (int/double)
        f.setConForro(true);
        f.setConVolantes(false);

        int idGen = daoFalda.insertar(f);
        assertTrue(idGen != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        faldas = daoFalda.listarTodos();
        if (faldas != null) {
            for (Falda f : faldas) {
                System.out.println(
                    "FALDA -> id:" + f.getIdPrenda()
                    + ", nombre:" + f.getNombre()
                    + ", color:" + f.getColor()
                    + ", material:" + f.getMaterial()
                    + ", tipoFalda:" + f.getTipoFalda()
                    + ", largo:" + f.getLargo()
                    + ", conForro:" + f.isConForro()
                    + ", conVolantes:" + f.isConVolantes()
                    + ", stock:" + f.getStockPrenda()
                    + ", alertaMinStock:" + f.getAlertaMinStock()
                    + ", activo:" + f.isActivo()
                );
            }
        }
        assertNotNull(faldas, "La lista de faldas no debe ser nula");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(faldas, "Primero ejecuta verificarListarTodas");
        assertFalse(faldas.isEmpty(), "La lista no debe estar vacía");

        Falda ultima = faldas.get(faldas.size() - 1);
        Falda f = daoFalda.obtenerPorId(ultima.getIdPrenda());
        assertNotNull(f, "Debe obtener una falda por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(faldas, "Primero ejecuta verificarListarTodas");
        assertFalse(faldas.isEmpty(), "La lista no debe estar vacía");

        Falda ultima = faldas.get(faldas.size() - 1);
        // Cambios
        ultima.setNombre("Falda Tubo Elegante");
        ultima.setPrecioUnidad(89.90);
        ultima.setPrecioMayor(78.00);
        ultima.setPrecioDocena(880.00);
        ultima.setAlertaMinStock(10);
        ultima.setColor("Beige");
        ultima.setMaterial(Material.Algodon);
        ultima.setTipoFalda(TipoFalda.Tubo);
        ultima.setLargo(65);
        ultima.setConForro(false);
        ultima.setConVolantes(false);
        ultima.setActivo(true); // si tu SP modificar_falda recibe activo

        int res = daoFalda.modificar(ultima);
        assertTrue(res != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(faldas, "Primero ejecuta verificarListarTodas");
        assertFalse(faldas.isEmpty(), "La lista no debe estar vacía");

        Falda ultima = faldas.get(faldas.size() - 1);
        int res = daoFalda.eliminar(ultima.getIdPrenda());
        assertTrue(res != 0, "La eliminación (baja lógica) debe afectar al menos una fila");
    }
}

