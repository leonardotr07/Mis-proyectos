/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.boi.AlmacenBOI;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;

/**
 *
 * @author Leonardo
 */
public class AlmacenBOImpl implements AlmacenBOI{
    private final AlmacenDAO daoAlmacen;
    public AlmacenBOImpl(){
        daoAlmacen=new AlmacenImpl();
    }
    
    //Hay que validar los parámetros...
    //Por lo general hay que apoyarnos de las retricciones colocadas en la BD
    @Override
    public int insertar(Almacen datAlmacen) throws Exception{
        validar(datAlmacen);
        return daoAlmacen.insertar(datAlmacen);
    }
    
    
    @Override
    public int modificar(Almacen datAlmacen) throws Exception{
        validar(datAlmacen);
        return daoAlmacen.modificar(datAlmacen);
    }
    
    @Override
    public int eliminar(int idAlmacen) throws Exception{
        return daoAlmacen.eliminar(idAlmacen);
    }
    
    @Override
    public Almacen obtenerXId(int idAlmacen) throws Exception{
        return daoAlmacen.obtenerPorId(idAlmacen);
    }
    
    @Override
    public ArrayList<Almacen> listarTodos() throws Exception{
        return daoAlmacen.listarTodos();
    }
    
    @Override
    public ArrayList<Almacen> listarActivos() throws Exception{
        return daoAlmacen.listarActivos();
    }
    
    
    @Override
    public void validar(Almacen datAlmacen) throws Exception{
        //En nuestro contexto si la Tienda no es la primer asignada (Ya que no hay más tiendas) Entonces salta error.
        if(datAlmacen.getIdTienda()!=1)
            throw new Exception("En Almacen: El campo de idTienda debe ser 1.");
        
        if(datAlmacen.getNombre().length()>70)
            throw new Exception("En Almacen: El nombre supera los 70 caracteres permitidos");
        if(datAlmacen.getUbicacion().length()>70)
            throw new Exception("En Almacen: La ubicacion supera los 70 caracteres permitidos");
    }
}
