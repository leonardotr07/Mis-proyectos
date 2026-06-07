/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.dao;

import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;

/**
 *
 * @author leona
 */
public interface DescuentoLiquidacionDAO extends IDAO<DescuentoLiquidacion>{
    public ArrayList<DescuentoLiquidacion> listarActivos();
    public void insertar_PrendaDescuento(int idDesc, List<Integer> idPrendas);
    public ArrayList<DescuentoLiquidacion> listarPorPrenda(int idPrenda);

}
