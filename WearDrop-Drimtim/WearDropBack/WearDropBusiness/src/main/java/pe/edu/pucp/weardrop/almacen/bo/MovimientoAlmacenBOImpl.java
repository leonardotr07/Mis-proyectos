/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.bo;

import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.boi.MovimientoAlmacenBOI;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;
import pe.edu.pucp.weardrop.personal.CuentaUsuario;
import pe.edu.pucp.weardrop.personal.dao.CuentaUsuarioDAO;
import pe.edu.pucp.weardrop.personal.mysql.CuentaUsuarioImpl;


/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacenBOImpl implements MovimientoAlmacenBOI {
    private final MovimientoAlmacenDAO daoMov;
    private final AlmacenDAO daoAlmacen;
    private final CuentaUsuarioDAO daoUsuario; 

    public MovimientoAlmacenBOImpl() {
        daoMov = new MovimientoAlmacenImpl();
        daoAlmacen = new AlmacenImpl();
        daoUsuario = new CuentaUsuarioImpl(); 
    }
    
    @Override
    public ArrayList<MovimientoAlmacen> listarActivos() {
        Almacen auxAlmacen = null;
        CuentaUsuario auxUsuario = null;
        
        ArrayList<MovimientoAlmacen> listaMov = daoMov.listarActivos();
        
        // Es buena práctica rellenar los objetos relacionados aquí
        for(MovimientoAlmacen datMov : listaMov){
            // Cargar datos completos del Almacen
            if(datMov.getDatAlmacen() != null) {
                auxAlmacen = daoAlmacen.obtenerPorId(datMov.getDatAlmacen().getId());
                datMov.setDatAlmacen(auxAlmacen);
            }
            
            
            if(datMov.getDatUsuario() != null) {
                auxUsuario = daoUsuario.obtenerPorId(datMov.getDatUsuario().getIdCuenta());
                datMov.setDatUsuario(auxUsuario);
            }
        }
        return listaMov;
    }

    @Override
    public int insertar(MovimientoAlmacen objeto) throws Exception {
        validar(objeto);
        return daoMov.insertar(objeto);
    }

    @Override
    public int modificar(MovimientoAlmacen objeto) throws Exception {
        validar(objeto);
        return daoMov.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoMov.eliminar(idObjeto);
    }

    @Override
    public MovimientoAlmacen obtenerXId(int idMovimiento) throws Exception {
        MovimientoAlmacen mov = daoMov.obtenerPorId(idMovimiento);
        
        if (mov != null) {
            // Cargar Almacen
            if (mov.getDatAlmacen() != null) {
                Almacen datAlmacen = daoAlmacen.obtenerPorId(mov.getDatAlmacen().getId());
                mov.setDatAlmacen(datAlmacen);
            }
            
            //Cargar Usuario
            if (mov.getDatUsuario() != null) {
                CuentaUsuario datUsuario = daoUsuario.obtenerPorId(mov.getDatUsuario().getIdCuenta());
                mov.setDatUsuario(datUsuario);
            }
        }
        return mov;
    }

    @Override
    public ArrayList<MovimientoAlmacen> listarTodos() throws Exception {
        Almacen datAlmacen;
        CuentaUsuario datUsuario;
        ArrayList<MovimientoAlmacen> listaMov = daoMov.listarTodos();
        
        for(MovimientoAlmacen datMov : listaMov){
            // Cargar Almacen
            if (datMov.getDatAlmacen() != null) {
                datAlmacen = daoAlmacen.obtenerPorId(datMov.getDatAlmacen().getId());
                datMov.setDatAlmacen(datAlmacen);
            }
            
            // Cargar Usuario
            if (datMov.getDatUsuario() != null) {
                datUsuario = daoUsuario.obtenerPorId(datMov.getDatUsuario().getIdCuenta());
                datMov.setDatUsuario(datUsuario);
            }
        }
        return listaMov;
    }
    
    @Override
    public List<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen) {
        // Obtener el almacén base para asignarlo a todos
        Almacen datAlmacen = daoAlmacen.obtenerPorId(idAlmacen);
        ArrayList<MovimientoAlmacen> listaMov = daoMov.listarMovimientosActivosPorAlmacen(idAlmacen);
        
        for(MovimientoAlmacen datMov : listaMov){
            // Asignar Almacen (Usando copia para respetar encapsulamiento)
            if (datAlmacen != null) {
                Almacen auxAlmacen = new Almacen(datAlmacen);
                datMov.setDatAlmacen(auxAlmacen);
            }
        }
        return listaMov;
    }

    @Override
    public void validar(MovimientoAlmacen objeto) throws Exception {
        // Validaciones de Almacen
        if(objeto.getDatAlmacen() == null)
            throw new Exception("En Movimiento Almacen: No existe un Almacen Vinculado...");
        if(objeto.getDatAlmacen().getId() <= 0)
            throw new Exception("En Movimiento Almacen: La FK de Almacen es inválida");
        
        // Validaciones de Usuario 
        if(objeto.getDatUsuario() == null)
            throw new Exception("En Movimiento Almacen: No se ha identificado al Usuario responsable.");
        if(objeto.getDatUsuario().getIdCuenta() <= 0)
            throw new Exception("En Movimiento Almacen: ID de Usuario no válido.");

        // Validaciones de Datos propios del movimiento
        if(objeto.getFecha() == null)
            throw new Exception("En Movimiento Almacen: El campo Fecha es nulo");
        
        if(objeto.getTipo() == null)
            throw new Exception("En Movimiento Almacen: El campo Tipo es nulo.");
        if(objeto.getTipo().toString().length() > 50)
            throw new Exception("En Movimiento Almacen: El campo Tipo supera los 50 caracteres");
        
        if(objeto.getLugarDestino() == null)
            throw new Exception("En Movimiento Almacen: El campo LugarDestino es nulo.");
        if(objeto.getLugarDestino().length() > 100)
            throw new Exception("En Movimiento Almacen: El campo LugarDestino supera los 100 caracteres");
        
        if(objeto.getLugarOrigen() == null)
            throw new Exception("En Movimiento Almacen: El campo LugarOrigen es nulo.");
        if(objeto.getLugarOrigen().length() > 100)
            throw new Exception("En Movimiento Almacen: El campo LugarOrigen supera los 100 caracteres");
    }
}