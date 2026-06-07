/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes;


import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeCreditoDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.NotaDeCreditoImpl;

import java.util.ArrayList;
import java.util.Date;

public class NotaDeCreditoDAOTest {

    private static NotaDeCreditoDAO daoNotaDeCredito;
    private static ArrayList<NotaDeCredito> listaNotasDeCredito;

    @BeforeAll
    public static void setUpClass() {
        daoNotaDeCredito = new NotaDeCreditoImpl();
    }

    @Test
    @Order(1)
    public void verificarObtenerXId() {
        NotaDeCredito notaDeCredito = daoNotaDeCredito.obtenerPorId(1);
        if (notaDeCredito != null) notaDeCredito.imprimirDetallesComprobante();
        assertNotNull(notaDeCredito);
    }

    @Test
    @Order(2)
    public void verificarRegistro() {
        NotaDeCredito notaDeCredito = new NotaDeCredito();
        notaDeCredito.setFecha(new Date());
        notaDeCredito.setTotal(400.0);
        notaDeCredito.setIGV(72.0);
        notaDeCredito.setMetodoDePago("Transferencia");
        notaDeCredito.setCorrelativo("NC-12345");
        notaDeCredito.setDetalleModificacion("Descuento aplicado");
        notaDeCredito.setRUC("12345678901");
        notaDeCredito.setRazonSocial("Tienda ABC");
        notaDeCredito.setDNI("87654321");
        notaDeCredito.setMotivoEspecifico("Error en monto");

        int resultado = daoNotaDeCredito.insertar(notaDeCredito);

        assertTrue(resultado > 0);
    }

    @Test
    @Order(3)
    public void verificarListar() {
        listaNotasDeCredito = daoNotaDeCredito.listarTodos();
        for (NotaDeCredito notaDeCredito : listaNotasDeCredito) {
            notaDeCredito.imprimirDetallesComprobante();
        }
        assertNotNull(listaNotasDeCredito);
    }

    @Test
    @Order(4)
    public void verificarListarActivos() {
        listaNotasDeCredito = daoNotaDeCredito.listarTodos();
        for (NotaDeCredito notaDeCredito : listaNotasDeCredito) {
            notaDeCredito.imprimirDetallesComprobante();
        }
        assertNotNull(listaNotasDeCredito);
    }

    @Test
    @Order(5)
    public void verificarModificar() {
        NotaDeCredito notaDeCredito = new NotaDeCredito();
        notaDeCredito.setIdComprobante(1);
        notaDeCredito.setFecha(new Date());
        notaDeCredito.setTotal(500.0);
        notaDeCredito.setIGV(90.0);
        notaDeCredito.setMetodoDePago("Cheque");
        notaDeCredito.setCorrelativo("NC-54321");
        notaDeCredito.setDetalleModificacion("Reajuste de monto");
        notaDeCredito.setRUC("23456789012");
        notaDeCredito.setRazonSocial("Comercio XYZ");

        int resultado = daoNotaDeCredito.modificar(notaDeCredito);

        assertTrue(resultado != 0);
    }

    @Test
    @Order(6)
    public void verificarEliminar() {
        int idNotaDeCredito = 1;
        int resultado = daoNotaDeCredito.eliminar(idNotaDeCredito);

        assertTrue(resultado != 0);
    }
}