/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.TipoCuenta;
import pe.edu.pucp.weardrop.personal.boi.TipoCuentaBOI;
import pe.edu.pucp.weardrop.personal.dao.TipoCuentaDAO;
import pe.edu.pucp.weardrop.personal.mysql.TipoCuentaImpl;

/**
 *
 * @author HP
 */
public class TipoCuentaBOImpl implements TipoCuentaBOI{
    
    private TipoCuentaDAO daoTipoCuenta;
    
    public TipoCuentaBOImpl(){
        daoTipoCuenta = new TipoCuentaImpl();
    }
    
    @Override
    public int insertar(TipoCuenta objeto) throws Exception {
        validar(objeto);
        return daoTipoCuenta.insertar(objeto);
    }

    @Override
    public int modificar(TipoCuenta objeto) throws Exception {
        validar(objeto);
        return daoTipoCuenta.modificar(objeto);    
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoTipoCuenta.eliminar(idObjeto);    
    }

    @Override
    public TipoCuenta obtenerXId(int idObjeto) throws Exception {
        return daoTipoCuenta.obtenerPorId(idObjeto);    
    }

    @Override
    public ArrayList<TipoCuenta> listarTodos() throws Exception {
        return daoTipoCuenta.listarTodos();    
    }

    @Override
    public void validar(TipoCuenta objeto) throws Exception {
        if(objeto.getDescripcion().trim().length()>75)
            throw new RuntimeException("La descripcion a registrar excede los 75 caracteres.");

    }
    
}
