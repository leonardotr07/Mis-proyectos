/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.personal.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.boi.CargoBOI;
import pe.edu.pucp.weardrop.personal.dao.CargoDAO;
import pe.edu.pucp.weardrop.personal.mysql.CargoImpl;

/**
 *
 * @author HP
 */
public class CargoBOImpl implements CargoBOI{
    
    private CargoDAO daoCargo;
    
    public CargoBOImpl(){
        daoCargo = new CargoImpl();
    }
    
    @Override
    public int insertar(Cargo objeto) throws Exception {
        validar(objeto);
        return daoCargo.insertar(objeto);
    }

    @Override
    public int modificar(Cargo objeto) throws Exception {
        validar(objeto);
        return daoCargo.modificar(objeto);    
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoCargo.eliminar(idObjeto);      
    }

    @Override
    public Cargo obtenerXId(int idObjeto) throws Exception {
        return daoCargo.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<Cargo> listarTodos() throws Exception {
        return daoCargo.listarTodos();
    }

    @Override
    public void validar(Cargo objeto) throws Exception {
       if(objeto.getDescripcion().trim().length()>75)
            throw new RuntimeException("La descripcion a registrar excede los 75 caracteres.");
       if(String.valueOf(objeto.getAbreviatura()).trim().length()>1)
           throw new RuntimeException("La abreviatura a registrar tiene mas de 1 caracter");
    }
    
}
