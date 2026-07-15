/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import pe.edu.pucp.weardrop.comprobantes.dao.BoletaDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.BoletaImpl;

import java.util.ArrayList;
import java.util.Date;

public class BoletaDAOTest {

    private static BoletaDAO daoBoleta;
    private static ArrayList<Boleta> listaBoletas;

    @BeforeAll
    public static void setUpClass() {
        daoBoleta = new BoletaImpl();
    }

    @Test
    @Order(1)
    public void verificarObtenerXId() {
        Boleta boleta = daoBoleta.obtenerPorId(1);
        if (boleta != null) boleta.imprimirDetallesComprobante();
        assertNotNull(boleta); // Verificamos si el puntero no es NULO
    }

    @Test
    @Order(2)
    public void verificarRegistro() {
        Boleta boleta = new Boleta();
        boleta.setFecha(new Date());
        boleta.setTotal(150.0);
        boleta.setIGV(27.0);
        boleta.setMetodoDePago("Efectivo");
        boleta.setCorrelativo("BOLETA-12345");
        boleta.setDNI("12345678");

        int resultado = daoBoleta.insertar(boleta);

        assertTrue(resultado > 0); // Si se inserta correctamente
    }

    @Test
    @Order(3)
    public void verificarListar() {
        listaBoletas = daoBoleta.listarTodos();
        for (Boleta boleta : listaBoletas) {
            boleta.imprimirDetallesComprobante();
        }
        assertNotNull(listaBoletas);
    }

    @Test
    @Order(4)
    public void verificarListarActivos() {
        listaBoletas = daoBoleta.listarTodos();
        for (Boleta boleta : listaBoletas) {
            boleta.imprimirDetallesComprobante();
        }
        assertNotNull(listaBoletas);
    }

    @Test
    @Order(5)
    public void verificarModificar() {
        Boleta boleta = new Boleta();
        boleta.setIdComprobante(1);
        boleta.setFecha(new Date());
        boleta.setTotal(200.0);
        boleta.setIGV(36.0);
        boleta.setMetodoDePago("Tarjeta");
        boleta.setCorrelativo("BOLETA-54321");
        boleta.setDNI("87654321");

        int resultado = daoBoleta.modificar(boleta);

        assertTrue(resultado != 0);
    }

    @Test
    @Order(6)
    public void verificarEliminar() {
        int idBoleta = 1;
        int resultado = daoBoleta.eliminar(idBoleta);

        assertTrue(resultado != 0);
    }
}