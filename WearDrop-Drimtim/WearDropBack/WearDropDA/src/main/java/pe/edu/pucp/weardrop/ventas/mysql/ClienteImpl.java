/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.ventas.Cliente;
import pe.edu.pucp.weardrop.ventas.TipoDeCliente;
import pe.edu.pucp.weardrop.ventas.dao.ClienteDAO;

/**
 *
 * @author matia
 */
public class ClienteImpl implements ClienteDAO{
    
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    
    //boi  cliente se colcoar en true el activo
    @Override
    public int insertar(Cliente objeto) {
            
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, objeto.getNombre());
        parametrosEntrada.put(3, objeto.getPrimerApellido());
        parametrosEntrada.put(4, objeto.getSegundoApellido());
        parametrosEntrada.put(5, objeto.getDni());
        parametrosEntrada.put(6, objeto.getTelefono());
        parametrosEntrada.put(7, String.valueOf(objeto.getGenero() ));
        
        TipoDeCliente tipoclie = new TipoDeCliente(objeto.getTipo());
        
        parametrosEntrada.put(8, String.valueOf( tipoclie.getAbreviatura()) );
        parametrosEntrada.put(9, tipoclie.getDescripcion());
        parametrosEntrada.put(10, tipoclie.getTipoCliente());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_cliente",
                 parametrosEntrada, parametrosSalida);
         
        objeto.setIdPersona((int) parametrosSalida.get(1));
        objeto.setIdCliente((int) parametrosSalida.get(1));
        
        if(objeto.getIdCliente()>0) System.out.println(
                "Se inserto el Cliente de forma correcta");
        else System.out.println("Ocurrio un error en el registro del Cliente.");
        
        return objeto.getIdCliente();
    }

    
    
    //boi  cliente se colcoar en true el activo
    
    @Override
    public int modificar(Cliente objeto) {
        
       Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(  1  , objeto.getIdCliente() );
        parametrosEntrada.put(  2  , objeto.getNombre() );
        parametrosEntrada.put(  3  , objeto.getPrimerApellido() );
        parametrosEntrada.put(  4  , objeto.getSegundoApellido() );
        parametrosEntrada.put(  5  , objeto.getDni() );
        parametrosEntrada.put(  6  , objeto.getTelefono() );
        parametrosEntrada.put(  7  , String.valueOf(objeto.getGenero() ) );
        
        TipoDeCliente tipoclie = new TipoDeCliente(objeto.getTipo());
        
        
        parametrosEntrada.put(  8  , String.valueOf( tipoclie.getAbreviatura()) );
        parametrosEntrada.put(  9  , tipoclie.getDescripcion() );
        parametrosEntrada.put(  10  , tipoclie.getTipoCliente() );
        
        int resultado = DBManager.getInstance().
                ejecutarProcedimiento(
                        "modificar_cliente",
                        parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha modificado el cliente.");
        else System.out.println("Ocurrio un error en la "
                + "modificacion del cliente.");
        return resultado;
    }
    
    
    
   
    
    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance()
                .ejecutarProcedimiento(
                        "eliminar_cliente", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado el cliente.");
        else System.out.println("Ocurrio un error al eliminar el cliente.");
        
        return resultado;
    }
    


    @Override
    public Cliente obtenerPorId(int idObjeto) {
        
        Cliente cliente = null;
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura(
                "obtenerId_cliente", parametrosEntrada);
        try{
            if(rs.next()){
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setActivo(rs.getBoolean("activo"));
                cliente.setIdPersona(rs.getInt("idCliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setPrimerApellido(rs.getString("primerApellido"));
                cliente.setSegundoApellido(rs.getString("segundoApellido"));
                cliente.setDni(rs.getInt("dni"));
                cliente.setTelefono(rs.getInt("telefono"));
                cliente.setGenero(rs.getString("genero").charAt(0));
                TipoDeCliente tipoClieGuardar = new TipoDeCliente();
                tipoClieGuardar.setTipoCliente(rs.getInt("tipoCliente"));
                tipoClieGuardar.setAbreviatura(rs.getString("abreviatura").charAt(0));
                tipoClieGuardar.setDescripcion(rs.getString("descripcion"));
                cliente.setTipo(tipoClieGuardar);
                System.out.println("Se obtuvo un resultado en la busqueda del Cliente");
            }
            else{
                System.out.println("No se obtuvo ningun resultado en la busqueda del Cliente");
            }
            
            
        }
        catch(SQLException ex){
             System.out.println("ERROR al buscar por ID a un Cliente: "+
                    ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        
        return cliente;
        
    }
    
    
    
    
    
    
    

    @Override
    public ArrayList<Cliente> listarTodos() {
        
        ArrayList<Cliente> listaClientes = null;
        rs=DBManager.getInstance().
                ejecutarProcedimientoLectura("mostrar_clientes", null);
        System.out.println("Lectura de Clientes...");
        int i = 0;
         try{
            while(rs.next()){
                if(listaClientes==null) listaClientes=new ArrayList<>();
                Cliente datCliente = new Cliente();
                datCliente.setIdCliente(rs.getInt("idCliente"));
                datCliente.setActivo(rs.getBoolean("activo"));
                datCliente.setIdPersona(rs.getInt("idCliente"));
                datCliente.setNombre(rs.getString("nombre"));
                datCliente.setPrimerApellido(rs.getString("primerApellido"));
                datCliente.setSegundoApellido(rs.getString("segundoApellido"));
                datCliente.setDni(rs.getInt("dni"));
                datCliente.setTelefono(rs.getInt("telefono"));
                datCliente.setGenero(rs.getString("genero").charAt(0));
                TipoDeCliente tipoClieGuardar = new TipoDeCliente();
                tipoClieGuardar.setTipoCliente(rs.getInt("tipoCliente"));
                tipoClieGuardar.setAbreviatura(rs.getString("abreviatura").charAt(0));
                tipoClieGuardar.setDescripcion(rs.getString("descripcion"));
                datCliente.setTipo(tipoClieGuardar);
                listaClientes.add(new Cliente(datCliente));
                i++;
            }
            if(i>0){
                System.out.println("Se obtuvo por lo menos un resultado en la busqueda de Clientes");
            }
            else{
                System.out.println("No se obtuvo ningun resultado en la busqueda de Clientes");
            } 
            System.out.println("Se listaron los Clientes"
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println("ERROR "
                    + "al listar todos los Clientes: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        
        
        return listaClientes;
        
       
    }
    
    
}
