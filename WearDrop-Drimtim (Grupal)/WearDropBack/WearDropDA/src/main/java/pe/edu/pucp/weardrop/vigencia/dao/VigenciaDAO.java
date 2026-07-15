/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.vigencia.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author leona
 */
public interface VigenciaDAO extends IDAO<Vigencia>{
        public ArrayList<Vigencia> listarActivos();

}
