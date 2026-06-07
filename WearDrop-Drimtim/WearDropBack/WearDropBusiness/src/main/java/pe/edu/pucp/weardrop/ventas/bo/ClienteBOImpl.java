/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.ventas.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.ventas.Cliente;
import pe.edu.pucp.weardrop.ventas.boi.ClienteBOI;
import pe.edu.pucp.weardrop.ventas.dao.ClienteDAO;
import pe.edu.pucp.weardrop.ventas.mysql.ClienteImpl;

/**
 *
 * @author matia
 */
public class ClienteBOImpl implements ClienteBOI{
    
    private final ClienteDAO daoClie;
    
    public ClienteBOImpl(){
        
        daoClie = new ClienteImpl();

    }
    
    @Override
    public int insertar(Cliente objeto) throws Exception {
        
        //nos aseguuramos que  al insertar siempre se tenga un activo
        objeto.setActivo(true);
        
        
        validar(objeto);
        
        //implementar un método para obtener los  subtotales de la venta 
        return daoClie.insertar(objeto);   
        

    }

    @Override
    public int modificar(Cliente objeto) throws Exception {
        
         objeto.setActivo(true);
         validar_modificar(objeto);
        
         return daoClie.modificar(objeto);  
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        
        
        return daoClie.eliminar(idObjeto);
    }

    @Override
    public Cliente obtenerXId(int idObjeto) throws Exception {
        
        
        Cliente clieBuscado = daoClie.obtenerPorId(idObjeto);
        
        return clieBuscado;
        
        
    }

    @Override
    public ArrayList<Cliente> listarTodos() throws Exception {
        
        ArrayList<Cliente> listaClientes = daoClie.listarTodos();

        return listaClientes;
        
    }

    @Override
    public void validar(Cliente objeto) throws Exception {
        
        Integer tip_clie_val = objeto.getTipo().getTipoCliente();
        if(tip_clie_val == null ) {
            
            throw new Exception("En tipo de cliente: El campo de identificador esta vacío");
        }
        if(objeto.getNombre().trim().length()>75)
            throw new RuntimeException("El nombre a registrar excede los 75 caracteres.");
        if(objeto.getPrimerApellido().trim().length()>75)
            throw new RuntimeException("El primer apellido a registrar excede los 75 caracteres.");
        if(objeto.getSegundoApellido().trim().length()>75)
            throw new RuntimeException("El segundo apellido a registrar excede los 75 caracteres.");
        if(!(String.valueOf(objeto.getDni()).length()==8))
            throw new RuntimeException("El dni no tiene los 8 digitos");
        if(!(String.valueOf((objeto.getTelefono())).length()==9))
            throw new RuntimeException("El telefono no tiene lo 9 digitos");
        if (objeto.getPrimerApellido() == null || objeto.getPrimerApellido().trim().isEmpty())
            throw new Exception("El primer apellido no puede ser nulo ni vacío.");
        if (objeto.getSegundoApellido() == null || objeto.getSegundoApellido().trim().isEmpty())
            throw new Exception("El segundo apellido no puede ser nulo ni vacío.");
        if (objeto.getDni() == 0) 
            throw new Exception("El DNI no puede ser nulo o 0.");
        if (objeto.getTelefono() == 0)
            throw new Exception("El teléfono no puede ser nulo o 0.");
        if (objeto.getGenero() == '\0')
            throw new Exception("El género no puede ser nulo.");
        if (objeto.getTipo() == null)
            throw new Exception("El tipo de cliente no puede ser nulo.");
 
    }

    @Override
    public void validar_modificar(Cliente objeto) throws Exception {
        
        Integer idClie = objeto.getIdCliente();
        if(idClie == null){
            throw new Exception("El campo de idCLiente esta vacío");
        }
       
        validar(objeto);  
        
    }
    
    
    
}
