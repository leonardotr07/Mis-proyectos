/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeDebitoDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.NotaDeDebitoImpl;

import java.util.ArrayList;
import java.util.Date;

public class NotaDeDebitoDAOTest {

    private static NotaDeDebitoDAO daoNotaDeDebito;
    private static ArrayList<NotaDeDebito> listaNotasDeDebito;

    @BeforeAll
    public static void setUpClass() {
        daoNotaDeDebito = new NotaDeDebitoImpl();
    }

    @Test
    @Order(1)
    public void verificarObtenerXId() {
        NotaDeDebito notaDeDebito = daoNotaDeDebito.obtenerPorId(1);
        if (notaDeDebito != null) notaDeDebito.imprimirDetallesComprobante();
        assertNotNull(notaDeDebito);
    }

    @Test
    @Order(2)
    public void verificarRegistro() {
        NotaDeDebito notaDeDebito = new NotaDeDebito();
        notaDeDebito.setFecha(new Date());
        notaDeDebito.setTotal(250.0);
        notaDeDebito.setIGV(45.0);
        notaDeDebito.setMetodoDePago("Cheque");
        notaDeDebito.setCorrelativo("ND-12345");
        notaDeDebito.setDetalleModificacion("Ajuste de monto");
        notaDeDebito.setRUC("98765432101");
        notaDeDebito.setRazonSocial("Comercio ABC");

        int resultado = daoNotaDeDebito.insertar(notaDeDebito);

        assertTrue(resultado > 0);
    }

    @Test
    @Order(3)
    public void verificarListar() {
        listaNotasDeDebito = daoNotaDeDebito.listarTodos();
        for (NotaDeDebito notaDeDebito : listaNotasDeDebito) {
            notaDeDebito.imprimirDetallesComprobante();
        }
        assertNotNull(listaNotasDeDebito);
    }

    @Test
    @Order(4)
    public void verificarListarActivos() {
        listaNotasDeDebito = daoNotaDeDebito.listarTodos();
        for (NotaDeDebito notaDeDebito : listaNotasDeDebito) {
            notaDeDebito.imprimirDetallesComprobante();
        }
        assertNotNull(listaNotasDeDebito);
    }

    @Test
    @Order(5)
    public void verificarModificar() {
        NotaDeDebito notaDeDebito = new NotaDeDebito();
        notaDeDebito.setIdComprobante(1);
        notaDeDebito.setFecha(new Date());
        notaDeDebito.setTotal(300.0);
        notaDeDebito.setIGV(54.0);
        notaDeDebito.setMetodoDePago("Tarjeta");
        notaDeDebito.setCorrelativo("ND-54321");
        notaDeDebito.setDetalleModificacion("Reajuste de precio");
        notaDeDebito.setRUC("12345678901");
        notaDeDebito.setRazonSocial("Tienda XYZ");

        int resultado = daoNotaDeDebito.modificar(notaDeDebito);

        assertTrue(resultado != 0);
    }

    @Test
    @Order(6)
    public void verificarEliminar() {
        int idNotaDeDebito = 1;
        int resultado = daoNotaDeDebito.eliminar(idNotaDeDebito);

        assertTrue(resultado != 0);
    }
}