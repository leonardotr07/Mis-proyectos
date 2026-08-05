/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.bo;

import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.descuento.boi.DescuentoLiquidacionBOI;
import pe.edu.pucp.weardrop.descuento.dao.DescuentoLiquidacionDAO;
import pe.edu.pucp.weardrop.descuento.mysql.DescuentoLiquidacionImpl;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;

/**
 *
 * @author leona
 */
public class DescuentoLiquidacionBOImpl implements DescuentoLiquidacionBOI{
    private final DescuentoLiquidacionDAO daoDesc;
    public DescuentoLiquidacionBOImpl(){
        daoDesc=new DescuentoLiquidacionImpl();
    }
    @Override
    public int insertar(DescuentoLiquidacion objeto) throws Exception {
        validar(objeto);
        return daoDesc.insertar(objeto);
    }

    @Override
    public int modificar(DescuentoLiquidacion objeto) throws Exception {
        validar(objeto);
        return daoDesc.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoDesc.eliminar(idObjeto);
    }

    @Override
    public DescuentoLiquidacion obtenerXId(int idObjeto) throws Exception {
        return daoDesc.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<DescuentoLiquidacion> listarTodos() throws Exception {
        return daoDesc.listarTodos();
    }
    @Override
    public ArrayList<DescuentoLiquidacion> listarActivos() {
        return daoDesc.listarActivos();
    }

    
    @Override
    public void validar(DescuentoLiquidacion objeto) throws Exception {
        Integer stock=objeto.getCondicionStockMin();
        
        Double porcen=objeto.getPorcentajeLiquidacion();
        
        if(stock==null){
            throw new Exception("El campo de condicionStockMin no puede ser nulo");
        }
        if(porcen==null){
            throw new Exception("El campo de porcentaje no puede ser nulo");
        }
        
        if(stock<0){
            throw new Exception("El campo de condicionStockMin no puede ser menor que 0");
        }
        if(porcen<0){
            throw new Exception("El campo de porcentaje no puede menor que 0");
        }
        if(objeto.getNombre().length()>75){
            throw new Exception("El campo del nombre no puede sobre pasar los 75 carácteres");
        }
    }
        public ArrayList<DescuentoLiquidacion> listarPorPrenda(int idPrenda) {
            return daoDesc.listarPorPrenda(idPrenda);
        }

    @Override
    public void insertar_PrendaDescuento(int idDesc, List<Integer> idPrendas) {
        daoDesc.insertar_PrendaDescuento(idDesc, idPrendas);
    }

    
}
