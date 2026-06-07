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

import pe.edu.pucp.weardrop.prendas.dao.VestidoDAO;
import pe.edu.pucp.weardrop.prendas.mysql.VestidoImpl;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.TipoVestido;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class VestidoDAOTest {

    private static VestidoDAO daoVestido;
    private static ArrayList<Vestido> vestidos;

    public VestidoDAOTest() {}

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoVestido = new VestidoImpl();
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
        Vestido v = new Vestido();
        v.setNombre("Vestido Casual");
        v.setPrecioUnidad(89.90);
        v.setPrecioMayor(79.00);
        v.setPrecioDocena(900.00);
        v.setAlertaMinStock(6);
        v.setColor("Azul");
        v.setMaterial(Material.Algodon);
        v.setTipoVestido(TipoVestido.Casual);     // p.ej. 'Casual', 'Coctel', 'Gala', etc.
        v.setTipoManga(TipoManga.MangaCorta);     // 'MangaCorta', 'MangaLarga', ...
        v.setLargo(95);

        int idGen = daoVestido.insertar(v);
        assertTrue(idGen != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        vestidos = daoVestido.listarTodos();
        if (vestidos != null) {
            for (Vestido v : vestidos) {
                System.out.println(
                    "VESTIDO -> id:" + v.getIdPrenda()
                    + ", nombre:" + v.getNombre()
                    + ", color:" + v.getColor()
                    + ", material:" + v.getMaterial()
                    + ", tipoVestido:" + v.getTipoVestido()
                    + ", tipoManga:" + v.getTipoManga()
                    + ", largo:" + v.getLargo()
                    + ", stock:" + v.getStockPrenda()
                    + ", alertaMinStock:" + v.getAlertaMinStock()
                    + ", activo:" + v.isActivo()
                );
            }
        }
        assertNotNull(vestidos, "La lista de vestidos no debe ser nula");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(vestidos, "Primero ejecuta verificarListarTodas");
        assertFalse(vestidos.isEmpty(), "La lista no debe estar vacía");

        Vestido ultimo = vestidos.get(vestidos.size() - 1);
        Vestido v = daoVestido.obtenerPorId(ultimo.getIdPrenda());
        assertNotNull(v, "Debe obtener un vestido por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(vestidos, "Primero ejecuta verificarListarTodas");
        assertFalse(vestidos.isEmpty(), "La lista no debe estar vacía");

        Vestido ultimo = vestidos.get(vestidos.size() - 1);
        // Cambios
        ultimo.setNombre("Vestido Ejecutivo");
        ultimo.setPrecioUnidad(99.90);
        ultimo.setPrecioMayor(88.00);
        ultimo.setPrecioDocena(980.00);
        ultimo.setAlertaMinStock(8);
        ultimo.setColor("Negro");
        ultimo.setMaterial(Material.Algodon);
        ultimo.setTipoVestido(TipoVestido.Ejecutivo); // ajusta si tu enum lo tiene
        ultimo.setTipoManga(TipoManga.MangaLarga);
        ultimo.setLargo(100);

        int res = daoVestido.modificar(ultimo);
        assertTrue(res != 0, "La modificación debe afectar al menos una fila");
    }

    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(vestidos, "Primero ejecuta verificarListarTodas");
        assertFalse(vestidos.isEmpty(), "La lista no debe estar vacía");

        Vestido ultimo = vestidos.get(vestidos.size() - 1);
        int res = daoVestido.eliminar(ultimo.getIdPrenda());
        assertTrue(res != 0, "La eliminación (baja lógica) debe afectar al menos una fila");
    }
}

