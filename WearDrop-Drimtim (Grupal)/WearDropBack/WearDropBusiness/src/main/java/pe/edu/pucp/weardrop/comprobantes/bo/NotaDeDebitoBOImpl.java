/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprobantes.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprobantes.NotaDeDebito;
import pe.edu.pucp.weardrop.comprobantes.boi.NotaDeDebitoBOI;
import pe.edu.pucp.weardrop.comprobantes.dao.NotaDeDebitoDAO;
import pe.edu.pucp.weardrop.comprobantes.mysql.NotaDeDebitoImpl;

/**
 * Implementación de la capa de negocio para Nota de Débito
 */
public class NotaDeDebitoBOImpl implements NotaDeDebitoBOI {
    
    private final NotaDeDebitoDAO daoNotaDeDebito;

    public NotaDeDebitoBOImpl() {
        daoNotaDeDebito = new NotaDeDebitoImpl();
    }

    @Override
    public int insertar(NotaDeDebito datNotaDeDebito) throws Exception {
        validar(datNotaDeDebito);
        return daoNotaDeDebito.insertar(datNotaDeDebito);
    }

    @Override
    public int modificar(NotaDeDebito datNotaDeDebito) throws Exception {
        validar(datNotaDeDebito);
        return daoNotaDeDebito.modificar(datNotaDeDebito);
    }

    @Override
    public int eliminar(int idNotaDeDebito) throws Exception {
        return daoNotaDeDebito.eliminar(idNotaDeDebito);
    }

    @Override
    public NotaDeDebito obtenerXId(int idNotaDeDebito) throws Exception {
        return daoNotaDeDebito.obtenerPorId(idNotaDeDebito);
    }

    @Override
    public ArrayList<NotaDeDebito> listarTodos() throws Exception {
        return daoNotaDeDebito.listarTodos();
    }


    @Override
    public void validar(NotaDeDebito datNotaDeDebito) throws Exception {
        if (datNotaDeDebito.getNuevoMonto() < datNotaDeDebito.getTotal()) {
            throw new Exception("En Nota de Débito: El nuevo monto no puede ser menor al total.");
        }
        if (datNotaDeDebito.getMotivoEspecifico() == null || datNotaDeDebito.getMotivoEspecifico().isEmpty()) {
            throw new Exception("En Nota de Débito: El motivo de la modificación debe estar especificado.");
        }
    }
}