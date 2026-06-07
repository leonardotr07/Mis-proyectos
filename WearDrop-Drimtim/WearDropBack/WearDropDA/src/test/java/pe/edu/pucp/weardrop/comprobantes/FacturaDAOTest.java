/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes;


import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import pe.edu.pucp.weardrop.comprobantes.dao.FacturaDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.FacturaImpl;

import java.util.ArrayList;
import java.util.Date;

public class FacturaDAOTest {

    private static FacturaDAO daoFactura;
    private static ArrayList<Factura> listaFacturas;

    @BeforeAll
    public static void setUpClass() {
        daoFactura = new FacturaImpl();
    }

    @Test
    @Order(1)
    public void verificarObtenerXId() {
        Factura factura = daoFactura.obtenerPorId(1);
        if (factura != null) factura.imprimirDetallesComprobante();
        assertNotNull(factura);
    }

    @Test
    @Order(2)
    public void verificarRegistro() {
        Factura factura = new Factura();
        factura.setFecha(new Date());
        factura.setTotal(200.0);
        factura.setIGV(36.0);
        factura.setMetodoDePago("Transferencia");
        factura.setCorrelativo("FAC-12345");
        factura.setRUC("12345678901");
        factura.setRazonSocial("Empresa XYZ");

        int resultado = daoFactura.insertar(factura);

        assertTrue(resultado > 0);
    }

    @Test
    @Order(3)
    public void verificarListar() {
        listaFacturas = daoFactura.listarTodos();
        for (Factura factura : listaFacturas) {
            factura.imprimirDetallesComprobante();
        }
        assertNotNull(listaFacturas);
    }

    @Test
    @Order(4)
    public void verificarListarActivos() {
        listaFacturas = daoFactura.listarTodos();
        for (Factura factura : listaFacturas) {
            factura.imprimirDetallesComprobante();
        }
        assertNotNull(listaFacturas);
    }

    @Test
    @Order(5)
    public void verificarModificar() {
        Factura factura = new Factura();
        factura.setIdComprobante(1);
        factura.setFecha(new Date());
        factura.setTotal(300.0);
        factura.setIGV(54.0);
        factura.setMetodoDePago("Tarjeta");
        factura.setCorrelativo("FAC-54321");
        factura.setRUC("98765432101");
        factura.setRazonSocial("Comercio ABC");

        int resultado = daoFactura.modificar(factura);

        assertTrue(resultado != 0);
    }

    @Test
    @Order(6)
    public void verificarEliminar() {
        int idFactura = 1;
        int resultado = daoFactura.eliminar(idFactura);

        assertTrue(resultado != 0);
    }
}