
package pe.edu.pucp.weardrop.prendas.dao;
import pe.edu.pucp.weardrop.prendas.Polo;
import pe.edu.pucp.weardrop.dao.IDAO;
import java.util.ArrayList;
/**
 *
 * @author valer
 */
public interface PoloDAO extends IDAO<Polo>{
    ArrayList<Polo> filtrarPolos();
}

