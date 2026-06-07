/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprastienda.LineaLoteCompra;
import pe.edu.pucp.weardrop.comprastienda.OrdenCompra;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.comprastienda.dao.OrdenCompraDAO;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.personal.Cargo;
import pe.edu.pucp.weardrop.personal.Empleado;

/**
 *
 * @author matia
 */
public class OrdenCompraImpl implements OrdenCompraDAO {

    private ResultSet rs;

    @Override
    public int insertar(OrdenCompra objeto) {

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
        try {
            DBManager.getInstance().iniciarTransaccion();
            Map<Integer, Object> parametrosSalida = new HashMap<>();
            Map<Integer, Object> parametrosEntrada = new HashMap<>();

            //id_compra 
            parametrosSalida.put(1, Types.INTEGER);
            parametrosEntrada.put(2,
                    new Date(objeto.getFechaLlegada().getTime()));
            parametrosEntrada.put(3,
                    new Date(objeto.getFechaEmision().getTime()));
            parametrosEntrada.put(4,
                    objeto.getDeudaPendiente());
            parametrosEntrada.put(5,
                    objeto.getMontoTotal());
            parametrosEntrada.put(6,
                    objeto.getProveedor().getIdProveedor());
            parametrosEntrada.put(7,
                    objeto.getEmpleado().getIdEmpleado());
            parametrosEntrada.put(8,
                    objeto.isActivo());

            DBManager.getInstance().ejecutarProcedimientoTransaccion(
                    "insertar_orden_compra",
                    parametrosEntrada, parametrosSalida);

            objeto.setIdCompra((int) parametrosSalida.get(1));
            System.out.println("Se ha realizado "
                    + "el registro de la orden de compra");

            for (LineaLoteCompra itemCompra
                    : objeto.getItems()) {
                parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();

                /*
                LineaLoteCompra {
    
    private int idPrenda;
    private int numLinea;
    private int cantidad;
    private Talla talla;
    private Lote lote;
    private double precioLote;
    private boolean activo;
                 */
                parametrosSalida.put(1,
                        Types.INTEGER);
                parametrosEntrada.put(2,
                        itemCompra.getIdPrenda());
                parametrosEntrada.put(3,
                        itemCompra.getCantidad());
                parametrosEntrada.put(4,
                        itemCompra.getTalla().name());
                parametrosEntrada.put(5,
                        itemCompra.getLote().getIdLote());
                parametrosEntrada.put(6,
                        itemCompra.getPrecioLote());
                parametrosEntrada.put(7,
                        objeto.getIdCompra());
                parametrosEntrada.put(8,
                        itemCompra.isActivo());

                DBManager.getInstance()
                        .ejecutarProcedimientoTransaccion(
                                "insertar_Item__orden_Compra",
                                parametrosEntrada, parametrosSalida);

                itemCompra.setNumLinea((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el "
                        + "registro del item de la orden de compra.");
            }
            DBManager.getInstance().confirmarTransaccion();

        } catch (SQLException ex) {
            try {
                DBManager.getInstance().cancelarTransaccion();
            } catch (Exception  ex1) {
                System.getLogger(OrdenCompraImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex1);
            }
        }
        return objeto.getIdCompra();
    }

    @Override
    public int modificar(OrdenCompra objeto) {

        try {

            DBManager.getInstance().iniciarTransaccion();
            Map<Integer, Object> parametrosEntrada = new HashMap<>();

            parametrosEntrada.put(1, 
                    objeto.getIdCompra());
            parametrosEntrada.put(2,
                    new Date(objeto.getFechaLlegada().getTime()));
            parametrosEntrada.put(3,
                    new Date(objeto.getFechaEmision().getTime()));
            parametrosEntrada.put(4,
                    objeto.getDeudaPendiente());
            parametrosEntrada.put(5,
                    objeto.getMontoTotal());
            parametrosEntrada.put(6,
                    objeto.getProveedor().getIdProveedor());
            parametrosEntrada.put(7,
                    objeto.getEmpleado().getIdEmpleado());
            parametrosEntrada.put(8,
                    objeto.isActivo());

            DBManager.getInstance()
                    .ejecutarProcedimientoTransaccion(
                            "modificar_orden_compra", parametrosEntrada, null);

            System.out.println("Se ha realizado el modificacion de la orden"
                    + " de compra");
            if(objeto.getItems() != null){
            for (LineaLoteCompra itemCompra
                    : objeto.getItems()) {
                
                Map<Integer, Object> parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();
                
              parametrosSalida.put(1,
                        Types.INTEGER);
                parametrosEntrada.put(2,
                        itemCompra.getIdPrenda());
                parametrosEntrada.put(3,
                        itemCompra.getCantidad());
                parametrosEntrada.put(4,
                        itemCompra.getTalla().name());
                parametrosEntrada.put(5,
                        itemCompra.getLote().getIdLote());
                parametrosEntrada.put(6,
                        itemCompra.getPrecioLote());
                parametrosEntrada.put(7,
                        objeto.getIdCompra());
                parametrosEntrada.put(8,
                        itemCompra.isActivo());

                DBManager.getInstance()
                        .ejecutarProcedimientoTransaccion(
                                "insertar_Item__orden_Compra",
                                parametrosEntrada, parametrosSalida);

                itemCompra.setNumLinea((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el "
                        + "registro del item de compra de Lote.");
            }
            }
            DBManager.getInstance().confirmarTransaccion();

        } catch (SQLException ex) {
            try {
                DBManager.getInstance().cancelarTransaccion();
            } catch (Exception  ex1) {
                System.getLogger(OrdenCompraImpl.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex1);
            }

        }
        return objeto.getIdCompra();


    }
    
    
    
    
    
    

    @Override
    public int eliminar(int idObjeto) {
        
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance()
                .ejecutarProcedimiento(
                        "eliminar_orden_compra", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado la orden"
                + " de compra.");
        else System.out.println("Ocurrio un error al "
                + "eliminar la orden de compra.");
        
        
        return resultado;
    }
    
    
    
    
    

    @Override
    public OrdenCompra obtenerPorId(int idObjeto) {
        
        OrdenCompra ordenCompra = ordenCompra = new OrdenCompra();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "obtener_orden_de_compra_X_id", parametrosEntrada);
        
        System.out.println("Lectura de una orden de compra...");
        try{
            if(rs.next()){

                
                ordenCompra.setIdCompra(
                        rs.getInt("id_orden_compra"));
                ordenCompra.setFechaLlegada(
                        rs.getDate("fecha_llegada_orden_compra"));
                ordenCompra.setFechaEmision(
                       rs.getDate("fecha_emision_orden_compra"));
                ordenCompra.setDeudaPendiente(
                        rs.getDouble("deuda_pendiente_orden_compra"));
                ordenCompra.setMontoTotal(
                        rs.getDouble("monto_total_orden_compra"));
                ordenCompra.setActivo(
                        rs.getBoolean("activo_orden_compra"));
                
                
                
                Empleado empleado = new Empleado();
                
                empleado.setIdEmpleado(
                        rs.getInt("id_empleado"));
                empleado.setSueldo(
                        rs.getDouble("sueldo_empleado"));
                empleado.setActivo(
                        rs.getBoolean("activo_empleado"));
                
                
                Cargo cargoEmple = new Cargo();
                cargoEmple.setIdCargo(
                    rs.getInt("empleado_cargoId"));
                cargoEmple.setAbreviatura(
                   rs.getString("empleado_abreviatura").charAt(0) );
                cargoEmple.setDescripcion(
                    rs.getString("empleado_descripcion"));
                cargoEmple.setActivo(
                    rs.getBoolean("cargo_activo"));
                
                empleado.setIdPersona(
                    rs.getInt("id_empleado"));
                empleado.setNombre(
                    rs.getString("nombre_empleado"));
                empleado.setPrimerApellido(
                    rs.getString("primer_ape_empleado"));
                empleado.setSegundoApellido(
                    rs.getString("segun_ape_empleado"));
                
                empleado.setDni(
                     rs.getInt("dni_empleado"));
                empleado.setTelefono(
                     rs.getInt("telefono_empleado"));
                empleado.setGenero(
                    rs.getString("genero_empleado").charAt(0));
                
                
                ordenCompra.setEmpleado(empleado);
                
                Proveedor proveedorOrden = new Proveedor();
                
                proveedorOrden.setIdProveedor(
                     rs.getInt("id_proveedor"));
                proveedorOrden.setRUC(
                    rs.getLong("ruc_proveedor"));
                proveedorOrden.setNombre(
                     rs.getString("nombre_proveedor"));
                proveedorOrden.setTelefono(
                     rs.getInt("telefono_proveedor"));
                proveedorOrden.setDireccion(
                    rs.getString("direccion_proveedor"));
                proveedorOrden.setActivo(
                    rs.getBoolean("activo_prooveedor"));
                
                ordenCompra.setProveedor(proveedorOrden);
                
                ArrayList<LineaLoteCompra> arregloLinLote = new ArrayList<>();
                
                ordenCompra.setItems(arregloLinLote);

                System.out.println("Se obtuvo la"
                        + " orden de compra correctamente.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener la orden de compra"
                    + " por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return ordenCompra;
        
    }
    
    
    
    
    
    

    @Override
    public ArrayList<OrdenCompra> listarTodos() {
           
        
        ArrayList<OrdenCompra> listaOrdenCompra  = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_ordenes_de_compra", null);
        
        System.out.println("Lectura ventas...");
        try{
            while(rs.next()){
                if(listaOrdenCompra == null) 
                    listaOrdenCompra = new ArrayList<>();
                
                OrdenCompra ordenCompra = new OrdenCompra();
                

                ordenCompra.setIdCompra(
                        rs.getInt("id_orden_compra"));
                ordenCompra.setFechaLlegada(
                        rs.getDate("fecha_llegada_orden_compra"));
                ordenCompra.setFechaEmision(
                       rs.getDate("fecha_emision_orden_compra"));
                ordenCompra.setDeudaPendiente(
                        rs.getDouble("deuda_pendiente_orden_compra"));
                ordenCompra.setMontoTotal(
                        rs.getDouble("monto_total_orden_compra"));
                ordenCompra.setActivo(
                        rs.getBoolean("activo_orden_compra"));
                
                
                
                Empleado empleado = new Empleado();
                
                empleado.setIdEmpleado(
                        rs.getInt("id_empleado"));
                empleado.setSueldo(
                        rs.getDouble("sueldo_empleado"));
                empleado.setActivo(
                        rs.getBoolean("activo_empleado"));
                
                
                Cargo cargoEmple = new Cargo();
                cargoEmple.setIdCargo(
                    rs.getInt("empleado_cargoId"));
                cargoEmple.setAbreviatura(
                   rs.getString("empleado_abreviatura").charAt(0) );
                cargoEmple.setDescripcion(
                    rs.getString("empleado_descripcion"));
                cargoEmple.setActivo(
                    rs.getBoolean("cargo_activo"));
                
                empleado.setIdPersona(
                    rs.getInt("id_empleado"));
                empleado.setNombre(
                    rs.getString("nombre_empleado"));
                empleado.setPrimerApellido(
                    rs.getString("primer_ape_empleado"));
                empleado.setSegundoApellido(
                    rs.getString("segun_ape_empleado"));
                
                empleado.setDni(
                     rs.getInt("dni_empleado"));
                empleado.setTelefono(
                     rs.getInt("telefono_empleado"));
                empleado.setGenero(
                    rs.getString("genero_empleado").charAt(0));
                
                
                ordenCompra.setEmpleado(empleado);
                
                Proveedor proveedorOrden = new Proveedor();
                
                proveedorOrden.setIdProveedor(
                     rs.getInt("id_proveedor"));
                proveedorOrden.setRUC(
                    rs.getLong("ruc_proveedor"));
                proveedorOrden.setNombre(
                     rs.getString("nombre_proveedor"));
                proveedorOrden.setTelefono(
                     rs.getInt("telefono_proveedor"));
                proveedorOrden.setDireccion(
                    rs.getString("direccion_proveedor"));
                proveedorOrden.setActivo(
                    rs.getBoolean("activo_prooveedor"));
                
                ordenCompra.setProveedor(proveedorOrden);
                
                ArrayList<LineaLoteCompra> arregloLinLote = new ArrayList<>();
                
                ordenCompra.setItems(arregloLinLote);
                
                
                
                
                
                listaOrdenCompra.add(ordenCompra);
               
            }
            
            System.out.println("Se listaron "
                    + "las ordenes de compra correctamente.");
            
        }catch(SQLException ex){
            System.out.println(
                    "ERROR al listar todas"
                            + " las ordenes de compra: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaOrdenCompra; 
        
    }

    @Override
    public ArrayList<OrdenCompra> listarActivos() {
        
        ArrayList<OrdenCompra> listaOrdenCompra  = null;
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_ordenes_de_compra_activo", null);
        
        System.out.println("Lectura ventas...");
        try{
            while(rs.next()){
                if(listaOrdenCompra == null) 
                    listaOrdenCompra = new ArrayList<>();
                
                OrdenCompra ordenCompra = new OrdenCompra();
                

                ordenCompra.setIdCompra(
                        rs.getInt("id_orden_compra"));
                ordenCompra.setFechaLlegada(
                        rs.getDate("fecha_llegada_orden_compra"));
                ordenCompra.setFechaEmision(
                       rs.getDate("fecha_emision_orden_compra"));
                ordenCompra.setDeudaPendiente(
                        rs.getDouble("deuda_pendiente_orden_compra"));
                ordenCompra.setMontoTotal(
                        rs.getDouble("monto_total_orden_compra"));
                ordenCompra.setActivo(
                        rs.getBoolean("activo_orden_compra"));
                
                
                
                Empleado empleado = new Empleado();
                
                empleado.setIdEmpleado(
                        rs.getInt("id_empleado"));
                empleado.setSueldo(
                        rs.getDouble("sueldo_empleado"));
                empleado.setActivo(
                        rs.getBoolean("activo_empleado"));
                
                
                Cargo cargoEmple = new Cargo();
                cargoEmple.setIdCargo(
                    rs.getInt("empleado_cargoId"));
                cargoEmple.setAbreviatura(
                   rs.getString("empleado_abreviatura").charAt(0) );
                cargoEmple.setDescripcion(
                    rs.getString("empleado_descripcion"));
                cargoEmple.setActivo(
                    rs.getBoolean("cargo_activo"));
                
                empleado.setIdPersona(
                    rs.getInt("id_empleado"));
                empleado.setNombre(
                    rs.getString("nombre_empleado"));
                empleado.setPrimerApellido(
                    rs.getString("primer_ape_empleado"));
                empleado.setSegundoApellido(
                    rs.getString("segun_ape_empleado"));
                
                empleado.setDni(
                     rs.getInt("dni_empleado"));
                empleado.setTelefono(
                     rs.getInt("telefono_empleado"));
                empleado.setGenero(
                    rs.getString("genero_empleado").charAt(0));
                
                
                ordenCompra.setEmpleado(empleado);
                
                Proveedor proveedorOrden = new Proveedor();
                
                proveedorOrden.setIdProveedor(
                     rs.getInt("id_proveedor"));
                proveedorOrden.setRUC(
                    rs.getLong("ruc_proveedor"));
                proveedorOrden.setNombre(
                     rs.getString("nombre_proveedor"));
                proveedorOrden.setTelefono(
                     rs.getInt("telefono_proveedor"));
                proveedorOrden.setDireccion(
                    rs.getString("direccion_proveedor"));
                proveedorOrden.setActivo(
                    rs.getBoolean("activo_prooveedor"));
                
                ordenCompra.setProveedor(proveedorOrden);
                
                ArrayList<LineaLoteCompra> arregloLinLote = new ArrayList<>();
                
                
                
                ordenCompra.setItems(arregloLinLote);
                
                
                
                
                
                listaOrdenCompra.add(ordenCompra);
               
            }
            
            System.out.println("Se listaron "
                    + "las ordenes de compra correctamente.");
            
        }catch(SQLException ex){
            System.out.println(
                    "ERROR al listar todas"
                            + " las ordenes de compra: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaOrdenCompra; 
    }
    
    
    
    
    
    
    

}
 