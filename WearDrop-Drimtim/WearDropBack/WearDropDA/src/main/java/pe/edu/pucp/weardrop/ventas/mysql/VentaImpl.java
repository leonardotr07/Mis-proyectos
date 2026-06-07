/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprobantes.ComprobanteDePago;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.Empleado;
import pe.edu.pucp.weardrop.personal.Persona;
import pe.edu.pucp.weardrop.prendas.TipoCasaca;
import pe.edu.pucp.weardrop.ventas.Cliente;
import pe.edu.pucp.weardrop.ventas.ItemVenta;
import pe.edu.pucp.weardrop.ventas.TipoDeCliente;
import pe.edu.pucp.weardrop.ventas.Venta;
import pe.edu.pucp.weardrop.ventas.dao.VentaDAO;

/**
 *
 * @author matia
 */
public class VentaImpl implements 
        VentaDAO {
    
    private ResultSet rs;


    @Override
    public int insertar(Venta objeto) {
        
        /*
         parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, empleado.getArea().getIdArea());
        parametrosEntrada.put(3, empleado.getDni());
        parametrosEntrada.put(4, empleado.getNombre());
        parametrosEntrada.put(5, empleado.getApellidoPaterno());
        parametrosEntrada.put(6, String.valueOf(empleado.getSexo()));
        parametrosEntrada.put(7, new Date(empleado.getFechaNacimiento().getTime()));
        parametrosEntrada.put(8, empleado.getCargo());
        parametrosEntrada.put(9, empleado.getSueldo());
        */
           
        try{
            DBManager.getInstance().iniciarTransaccion();
            Map<Integer,Object> parametrosSalida = new HashMap<>();
            Map<Integer,Object> parametrosEntrada = new HashMap<>();
            
            parametrosSalida.put(  1  , Types.INTEGER );
            //puede  que este  tambien sea  parametro de salida 
            parametrosEntrada.put(  2  , 
                    new Date(objeto.getFecha().getTime()));
            parametrosEntrada.put(  3  , 
                   objeto.getTotal());
            parametrosEntrada.put(  4  , 
                   objeto.getIdComprobante());
            parametrosEntrada.put(  5  , 
                   objeto.isActivo());
            parametrosEntrada.put(  6  , 
                   objeto.getCliente().getIdCliente());
            parametrosEntrada.put(  7  , 
                   objeto.getEmpleado().getIdEmpleado());
            
            DBManager.getInstance().ejecutarProcedimientoTransaccion(
                    "insertar_venta", parametrosEntrada, parametrosSalida);
            
            objeto.setIdVenta((int) parametrosSalida.get(1));
            System.out.println("Se ha realizado el registro de la Venta");
             for(ItemVenta itemVent : 
                objeto.getProductos()){
                parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();
                
                parametrosSalida.put(1, Types.INTEGER);
                parametrosEntrada.put(2, itemVent.getIdPrenda());
                parametrosEntrada.put(3, itemVent.getCantidad());
                //probablemente se necesite un método de DAO que calcule el subtotal
                parametrosEntrada.put(4, itemVent.getSubtotal());
                parametrosEntrada.put(5, objeto.getIdVenta());
                parametrosEntrada.put(6, itemVent.getTalla().name());
                DBManager.getInstance().ejecutarProcedimientoTransaccion(
                        "insertar_Item_Venta", parametrosEntrada, parametrosSalida);
                
                itemVent.setNumLinea((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el registro del item de la venta");
            }
            DBManager.getInstance().confirmarTransaccion();
            
        }catch(SQLException ex){
            try {
                DBManager.getInstance().cancelarTransaccion();
            } catch (Exception  ex1) {
                System.getLogger(VentaImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex1);
            }
            
        }
        return objeto.getIdVenta();
        
       }
    
    
    
    

    @Override
    public int modificar(Venta objeto) {
        
         try{
            DBManager.getInstance().iniciarTransaccion();
            Map<Integer,Object> parametrosEntrada = new HashMap<>();
            
            parametrosEntrada.put(1, objeto.getIdVenta());
            parametrosEntrada.put(2, objeto.getFecha());
            parametrosEntrada.put(3, objeto.getTotal());
            parametrosEntrada.put(4, objeto.getEmpleado().getIdEmpleado());
            parametrosEntrada.put(5, objeto.getCliente().getIdCliente());
            parametrosEntrada.put(6, objeto.getIdComprobante());
            //activo no va porque eso se hace con eliminar
            
            DBManager.getInstance()
                    .ejecutarProcedimientoTransaccion(
                            "modificar_venta", parametrosEntrada, null);
            
            System.out.println("Se ha realizado el modificacion de la venta");
            
            // se inserta todo de nuevo porque en el modificar venta se desactivan los itemsVenta
            for(ItemVenta itemVent : objeto.getProductos()){
                Map<Integer,Object> parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();
                
                parametrosSalida.put(1, Types.INTEGER);
                parametrosEntrada.put(2, itemVent.getIdPrenda());
                parametrosEntrada.put(3, itemVent.getCantidad());
                //probablemente se necesite un método de DAO que calcule el subtotal
                parametrosEntrada.put(4, itemVent.getSubtotal());
                parametrosEntrada.put(5, objeto.getIdVenta());
                parametrosEntrada.put(6, itemVent.getTalla().name());
                DBManager.getInstance().ejecutarProcedimientoTransaccion(
                        "insertar_Item_Venta", parametrosEntrada, parametrosSalida);
                
                itemVent.setNumLinea((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el registro del item de la venta");
                
            }
            DBManager.getInstance().confirmarTransaccion();
        }catch(SQLException ex){
             try {
                 DBManager.getInstance().cancelarTransaccion();
             } catch (Exception  ex1) {
                 System.getLogger(VentaImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex1);
             }
        }
        return objeto.getIdVenta();

    }
    
    
    
    
    
    

    @Override
    public int eliminar(int idObjeto) {
        
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance()
                .ejecutarProcedimiento(
                        "eliminar_venta", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado la venta.");
        else System.out.println("Ocurrio un error al eliminar la venta.");
        
        return resultado;

    }
    
    
    
    
    
    
    

    @Override
    public Venta obtenerPorId(int idObjeto) {
        
        
        Venta venta = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "obtener_venta_X_id", parametrosEntrada);
        
        System.out.println("Lectura de una venta...");
        try{
            if(rs.next()){
                if(venta == null)  venta = new Venta();
                
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setFecha(rs.getDate("fecha_venta"));
                venta.setTotal(rs.getDouble("total_venta"));
                venta.setActivo(rs.getBoolean("estado_venta"));
                venta.setIdComprobante(rs.getInt("idComprobante_venta"));
                ArrayList<ItemVenta>  productos = new ArrayList<>();
                
                venta.setProductos(productos);
                
                //ComprobanteDePago compPago = new ComprobanteDePago();
                
                Cliente cliente = new Cliente();
                
                cliente.setIdCliente(rs.getInt("id_cliente"));
                cliente.setActivo(rs.getBoolean("activo_clie"));
                TipoDeCliente tipClie = new TipoDeCliente();
                
                tipClie.setTipoCliente(rs.getInt("tipo_clie_id"));
                tipClie.setAbreviatura(rs.getString("abreviatura_clie").charAt(0));
                tipClie.setDescripcion(rs.getString("descripcion_clie"));
                
                cliente.setIdPersona(rs.getInt("id_cliente"));
                cliente.setDni(rs.getInt("dni_clie"));
                cliente.setGenero(rs.getString("genero_clie").charAt(0));
                cliente.setNombre(rs.getString("nombre_clie"));
                cliente.setPrimerApellido(rs.getString("primerApellido_clie"));
                cliente.setSegundoApellido(rs.getString("segundoApellido_clie"));
                cliente.setTelefono(rs.getInt("telefono_clie"));
                
                cliente.setTipo(tipClie);
                venta.setCliente(cliente);
                
                Empleado emple  = new Empleado();
                
                emple.setIdEmpleado(rs.getInt("id_empleado"));
                emple.setSueldo(rs.getDouble("sueldo_empleado"));
                emple.setActivo(rs.getBoolean("estado_empleado"));
                
                emple.setIdPersona(rs.getInt("id_empleado"));
                emple.setNombre(rs.getString("nombre_empleado"));
                emple.setPrimerApellido(rs.getString("primerApellido_empleado"));
                emple.setSegundoApellido(rs.getString("segundoApellido_empleado"));
                emple.setDni(rs.getInt("dni_empleado"));
                emple.setTelefono(rs.getInt("telefono_empleado"));
                emple.setGenero(rs.getString("genero_empleado").charAt(0));
                
                
                
                Cargo cargEmple = new Cargo();
                
                cargEmple.setIdCargo(rs.getInt("id_cargo_emple"));
                cargEmple.setAbreviatura(
                        rs.getString("abreviatura_cargo").charAt(0));
                cargEmple.setDescripcion(
                        rs.getString("descripcion_emplea"));
                cargEmple.setActivo(rs.getBoolean("activo_cargo_emple"));
                
                emple.setCargoAsignado(cargEmple);
                
                venta.setEmpleado(emple);
                
                System.out.println("Se obtuvo la venta correctamente.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener la venta"
                    + " por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return venta;
        
    }

    
    
    
    
    
    
    
    @Override
    public ArrayList<Venta> listarTodos() {
        
        ArrayList<Venta> listaVentas  = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_ventas", null);
        
        System.out.println("Lectura ventas...");
        try{
            while(rs.next()){
                if(listaVentas == null)  listaVentas = new ArrayList<>();
                Venta venta = new Venta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setFecha(rs.getDate("fecha_venta"));
                venta.setTotal(rs.getDouble("total_venta"));
                venta.setActivo(rs.getBoolean("estado_venta"));
                venta.setIdComprobante(rs.getInt("idComprobante_venta"));
                ArrayList<ItemVenta>  productos = new ArrayList<>();
                
                venta.setProductos(productos);
                
                //ComprobanteDePago compPago = new ComprobanteDePago();
                
                Cliente cliente = new Cliente();
                
                cliente.setIdCliente(rs.getInt("id_cliente"));
                cliente.setActivo(rs.getBoolean("activo_clie"));
                
                TipoDeCliente tipClie = new TipoDeCliente();
                
                tipClie.setTipoCliente(rs.getInt("tipo_clie_id"));
                tipClie.setAbreviatura(rs.getString("abreviatura_clie").charAt(0));
                tipClie.setDescripcion(rs.getString("descripcion_clie"));
                
                cliente.setIdPersona(rs.getInt("id_cliente"));
                cliente.setDni(rs.getInt("dni_clie"));
                cliente.setGenero(rs.getString("genero_clie").charAt(0));
                cliente.setNombre(rs.getString("nombre_clie"));
                cliente.setPrimerApellido(rs.getString("primerApellido_clie"));
                cliente.setSegundoApellido(rs.getString("segundoApellido_clie"));
                cliente.setTelefono(rs.getInt("telefono_clie"));
                
                cliente.setTipo(tipClie);
                venta.setCliente(cliente);
                
                Empleado emple  = new Empleado();
                
                emple.setIdEmpleado(rs.getInt("id_empleado"));
                emple.setSueldo(rs.getDouble("sueldo_empleado"));
                emple.setActivo(rs.getBoolean("estado_empleado"));
                
                emple.setIdPersona(rs.getInt("id_empleado"));
                emple.setNombre(rs.getString("nombre_empleado"));
                emple.setPrimerApellido(rs.getString("primerApellido_empleado"));
                emple.setSegundoApellido(rs.getString("segundoApellido_empleado"));
                emple.setDni(rs.getInt("dni_empleado"));
                emple.setTelefono(rs.getInt("telefono_empleado"));
                emple.setGenero(rs.getString("genero_empleado").charAt(0));
                
                
                
                Cargo cargEmple = new Cargo();
                
                cargEmple.setIdCargo(rs.getInt("id_cargo_emple"));
                cargEmple.setAbreviatura(
                        rs.getString("abreviatura_cargo").charAt(0));
                cargEmple.setDescripcion(
                        rs.getString("descripcion_emplea"));
                cargEmple.setActivo(rs.getBoolean("activo_cargo_emple"));
                
                emple.setCargoAsignado(cargEmple);
                
                venta.setEmpleado(emple);
                
                listaVentas.add(venta);
               
            }
            
            System.out.println("Se listaron las ventas correctamente.");
            
        }catch(SQLException ex){
            System.out.println(
                    "ERROR al listar todas las ventas: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaVentas; 
    }

    
    
    
    
    
    
    
    @Override
    public ArrayList<Venta> lista_ventas_activas() {
        
        ArrayList<Venta> listaVentas  = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_ventas_activas", null);
        
        System.out.println("Lectura ventas activas...");
        try{
            while(rs.next()){
                if(listaVentas == null)  listaVentas = new ArrayList<>();
                Venta venta = new Venta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setFecha(rs.getDate("fecha_venta"));
                venta.setTotal(rs.getDouble("total_venta"));
                venta.setActivo(rs.getBoolean("estado_venta"));
                venta.setIdComprobante(rs.getInt("idComprobante_venta"));
                ArrayList<ItemVenta>  productos = new ArrayList<>();
                
                venta.setProductos(productos);
                
                //ComprobanteDePago compPago = new ComprobanteDePago();
                
                Cliente cliente = new Cliente();
                
                cliente.setIdCliente(rs.getInt("id_cliente"));
                cliente.setActivo(rs.getBoolean("activo_clie"));
                
                TipoDeCliente tipClie = new TipoDeCliente();
                
                tipClie.setTipoCliente(rs.getInt("tipo_clie_id"));
                tipClie.setAbreviatura(rs.getString("abreviatura_clie").charAt(0));
                tipClie.setDescripcion(rs.getString("descripcion_clie"));
                
                
                cliente.setIdPersona(rs.getInt("id_cliente"));
                cliente.setDni(rs.getInt("dni_clie"));
                cliente.setGenero(rs.getString("genero_clie").charAt(0));
                cliente.setNombre(rs.getString("nombre_clie"));
                cliente.setPrimerApellido(rs.getString("primerApellido_clie"));
                cliente.setSegundoApellido(rs.getString("segundoApellido_clie"));
                cliente.setTelefono(rs.getInt("telefono_clie"));
                
                cliente.setTipo(tipClie);
                venta.setCliente(cliente);
                
                Empleado emple  = new Empleado();
                
                emple.setIdEmpleado(rs.getInt("id_empleado"));
                emple.setSueldo(rs.getDouble("sueldo_empleado"));
                emple.setActivo(rs.getBoolean("estado_empleado"));
                
                emple.setIdPersona(rs.getInt("id_empleado"));
                emple.setNombre(rs.getString("nombre_empleado"));
                emple.setPrimerApellido(rs.getString("primerApellido_empleado"));
                emple.setSegundoApellido(rs.getString("segundoApellido_empleado"));
                emple.setDni(rs.getInt("dni_empleado"));
                emple.setTelefono(rs.getInt("telefono_empleado"));
                emple.setGenero(rs.getString("genero_empleado").charAt(0));
                
                
                
                Cargo cargEmple = new Cargo();
                
                cargEmple.setIdCargo(rs.getInt("id_cargo_emple"));
                cargEmple.setAbreviatura(
                        rs.getString("abreviatura_cargo").charAt(0));
                cargEmple.setDescripcion(
                        rs.getString("descripcion_emplea"));
                cargEmple.setActivo(rs.getBoolean("activo_cargo_emple"));
                
                emple.setCargoAsignado(cargEmple);
                
                venta.setEmpleado(emple);
                
                listaVentas.add(venta);
               
            }
            
            System.out.println("Se listaron las ventas correctamente.");
            
        }catch(SQLException ex){
            System.out.println(
                    "ERROR al listar todas las ventas: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaVentas; 
        
        
        
        
        
        
    }
    
}
