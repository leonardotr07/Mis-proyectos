/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes.bo;


import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.NotaDeCredito;
import pe.edu.pucp.weardrop.comprobantes.boi.NotaDeCreditoBOI;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeCreditoDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.NotaDeCreditoImpl;

/**
 * Implementación de la capa de negocio para Nota de Crédito
 */
public class NotaDeCreditoBOImpl implements NotaDeCreditoBOI {
    
    private final NotaDeCreditoDAO daoNotaDeCredito;

    public NotaDeCreditoBOImpl() {
        daoNotaDeCredito = new NotaDeCreditoImpl();
    }

    @Override
    public int insertar(NotaDeCredito datNotaDeCredito) throws Exception {
        validar(datNotaDeCredito);
        return daoNotaDeCredito.insertar(datNotaDeCredito);
    }

    @Override
    public int modificar(NotaDeCredito datNotaDeCredito) throws Exception {
        validar(datNotaDeCredito);
        return daoNotaDeCredito.modificar(datNotaDeCredito);
    }

    @Override
    public int eliminar(int idNotaDeCredito) throws Exception {
        return daoNotaDeCredito.eliminar(idNotaDeCredito);
    }

    @Override
    public NotaDeCredito obtenerXId(int idNotaDeCredito) throws Exception {
        return daoNotaDeCredito.obtenerPorId(idNotaDeCredito);
    }

    @Override
    public ArrayList<NotaDeCredito> listarTodos() throws Exception {
        return daoNotaDeCredito.listarTodos();
    }


    @Override
    public void validar(NotaDeCredito datNotaDeCredito) throws Exception {
        if (datNotaDeCredito.getNuevoMonto() > datNotaDeCredito.getTotal()) {
            throw new Exception("En Nota de Crédito: El nuevo monto no puede ser mayor al total.");
        }
        if (datNotaDeCredito.getMotivoEspecifico() == null || datNotaDeCredito.getMotivoEspecifico().isEmpty()) {
            throw new Exception("En Nota de Crédito: El motivo de la modificación debe estar especificado.");
        }
    }
}