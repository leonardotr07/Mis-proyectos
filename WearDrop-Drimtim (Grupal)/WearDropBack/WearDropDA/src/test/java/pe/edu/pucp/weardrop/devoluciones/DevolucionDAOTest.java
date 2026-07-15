/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.devoluciones;

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

import pe.edu.pucp.weardrop.prendas.Talla;
import pe.edu.pucp.weardrop.devoluciones.dao.DevolucionDAO;
import pe.edu.pucp.weardrop.devoluciones.mysql.DevolucionImpl;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class DevolucionDAOTest {

    private static DevolucionDAO daoDevolucion;
    private static ArrayList<Devolucion> devoluciones;

    // AJUSTA ESTOS VALORES A REGISTROS EXISTENTES EN TU BD
    private static final int ID_EMPLEADO_EXISTENTE = 1;
    private static final int ID_PROVEEDOR_EXISTENTE = 1;
    private static final int ID_PRENDA_EXISTENTE = 21;

    public DevolucionDAOTest() {
    }

    @BeforeAll
    public static void setUpClass() throws Exception {
        daoDevolucion = new DevolucionImpl();
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
/*
    @Test
    @Order(1)
    public void verificarRegistro() {
        Devolucion d = new Devolucion();
        d.setDescripcion("Devolución de prueba");
        d.setIdEmpleado(ID_EMPLEADO_EXISTENTE);
        d.setIdProveedor(ID_PROVEEDOR_EXISTENTE);
        d.setMonto(150.50);
        d.setCantidad(3);
        d.setIdPrenda(ID_PRENDA_EXISTENTE);
        d.setTalla(Talla.S);

        int idGenerado = daoDevolucion.insertar(d);
        assertTrue(idGenerado != 0, "El insert debe devolver un id > 0");
    }

    @Test
    @Order(2)
    public void verificarListarTodas() {
        devoluciones = daoDevolucion.listarTodos();
        if (devoluciones != null) {
            for (Devolucion d : devoluciones) {
                System.out.println(
                        "DEVOLUCION -> id:" + d.getId()
                        + ", desc:" + d.getDescripcion()
                        + ", idEmpleado:" + d.getIdEmpleado()
                        + ", idProveedor:" + d.getIdProveedor()
                        + ", idPrenda:" + d.getIdPrenda()
                        + ", talla:" + d.getTalla()
                        + ", cantidad:" + d.getCantidad()
                        + ", monto:" + d.getMonto()
                        + ", fecha:" + d.getFecha()
                        + ", activo:" + d.isActivo()
                );
            }
        }
        assertNotNull(devoluciones, "La lista de devoluciones no debe ser nula");
        assertFalse(devoluciones.isEmpty(), "La lista de devoluciones no debe estar vacía");
    }

    @Test
    @Order(3)
    public void verificarObtenerPorId() {
        assertNotNull(devoluciones, "Primero ejecuta verificarListarTodas");
        assertFalse(devoluciones.isEmpty(), "La lista de devoluciones no debe estar vacía");

        Devolucion ultima = devoluciones.get(devoluciones.size() - 1);
        Devolucion d = daoDevolucion.obtenerPorId(ultima.getId());
        assertNotNull(d, "Debe obtener una devolución por ID");
    }

    @Test
    @Order(4)
    public void verificarModificacion() {
        assertNotNull(devoluciones, "Primero ejecuta verificarListarTodas");
        assertFalse(devoluciones.isEmpty(), "La lista de devoluciones no debe estar vacía");

        Devolucion ultima = devoluciones.get(devoluciones.size() - 1);
        ultima.setDescripcion("Devolución modificada");
        ultima.setMonto(200.00);
        ultima.setCantidad(5);
        ultima.setTalla(Talla.M);

        int resultado = daoDevolucion.modificar(ultima);
        assertTrue(resultado != 0, "La modificación debe afectar al menos una fila");
    }

   
    @Test
    @Order(5)
    public void verificarEliminacion() {
        assertNotNull(devoluciones, "Primero ejecuta verificarListarTodas");
        assertFalse(devoluciones.isEmpty(), "La lista de devoluciones no debe estar vacía");

        Devolucion ultima = devoluciones.get(devoluciones.size() - 1);
        int resultado = daoDevolucion.eliminar(ultima.getId());
        assertTrue(resultado != 0, "La eliminación debe afectar al menos una fila");
 

}

*/
}

