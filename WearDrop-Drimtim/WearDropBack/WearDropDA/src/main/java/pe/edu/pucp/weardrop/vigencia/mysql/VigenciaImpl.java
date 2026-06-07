/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
    package pe.edu.pucp.weardrop.vigencia.mysql;

    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Types;
    import java.util.ArrayList;
    import java.util.HashMap;
    import java.util.Map;
    import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
    import pe.edu.pucp.weardrop.config.DBManager;
    import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;
    import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;

    /**
     *
     * @author leona
     */
    public class VigenciaImpl implements VigenciaDAO{
        private ResultSet rs;

        @Override
        public int insertar(Vigencia objeto) {
            Map<Integer, Object> parametrosEntrada=new HashMap<>();
            Map<Integer, Object> parametrosSalida=new HashMap<>();
//            java.sql.Date sqlInicio = new java.sql.Date(objeto.getFechaInicio().getTime());
//            java.sql.Date sqlFin = new java.sql.Date(objeto.getFechaFin().getTime());
            parametrosSalida.put(1, Types.INTEGER);
            parametrosEntrada.put(2, objeto.getFechaInicio());
            parametrosEntrada.put(3, objeto.getFechaFin());


            DBManager.getInstance().ejecutarProcedimiento("insertar_vigencia", parametrosEntrada, parametrosSalida);

            //Retornamos el parametro de salida
            objeto.setIdVigencia((int)parametrosSalida.get(1));

            if(objeto.getIdVigencia()>0) System.out.println("Se ha registrado la vigencia.");
            else System.out.println("Ocurrio un error en el registro de la vigencia.");

            return objeto.getIdVigencia();     
        }

        @Override
        public int modificar(Vigencia objeto) {
            Map<Integer,Object> parametrosEntrada = new HashMap<>();

            parametrosEntrada.put(1, objeto.getIdVigencia());
            parametrosEntrada.put(2,objeto.getFechaInicio());
            parametrosEntrada.put(3,objeto.getFechaFin());

            int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_vigencia", parametrosEntrada, null);
            if(resultado>0) System.out.println("Se ha modificado la vigencia.");
            else System.out.println("Ocurrio un error en la modificacion de la  vigencia.");
            return resultado;        }

        @Override
        public int eliminar(int idObjeto) {
            Map<Integer, Object> parametrosEntrada=new HashMap<>();

            parametrosEntrada.put(1, idObjeto);

            int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_vigencia", parametrosEntrada, null);

            if(resultado>0) System.out.println("Se ha eliminado la vigencia.");
            else System.out.println("Ocurrio un error al eliminar la vigencia.");

            return resultado;         }

        @Override
        public Vigencia obtenerPorId(int idObjeto) {
            Vigencia datVig = null; //No se pudo obtener por ID

            Map<Integer, Object> parametrosEntrada=new HashMap<>();
            parametrosEntrada.put(1, idObjeto);
            rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_vigencia_X_id", parametrosEntrada);

            try{
                if(rs.next()){
                    datVig=new Vigencia();
                    datVig.setIdVigencia(rs.getInt("idVigencia"));
                    datVig.setFechaInicio(rs.getDate("fechaInicio"));
                    datVig.setFechaFin(rs.getDate("fechaFin"));
                    datVig.setActivo(rs.getBoolean("activo"));
                    System.out.println("SE OBTUVO LA VIGENCIA CORRECTAMENTE.");
                }
            }catch(SQLException ex){
                System.out.println("ERROR al obtener por ID: "+ex.getMessage());
            }finally{
                DBManager.getInstance().cerrarConexion();
            }
            return datVig;   
        }

        @Override
        public ArrayList<Vigencia> listarTodos() {
            ArrayList<Vigencia> listaVig=null;
            rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_vigencia", null);
            System.out.println("Lectura de vigencia...");
                try{
                while(rs.next()){
                    if(listaVig==null) listaVig=new ArrayList<>();
                    Vigencia vig=new Vigencia();
                    vig.setIdVigencia(rs.getInt("idVigencia"));
                    vig.setFechaFin(rs.getDate("fechaFin"));
                    vig.setFechaInicio(rs.getDate("fechaInicio"));
                    vig.setActivo(rs.getBoolean("activo"));
                    listaVig.add(vig);
                }
                System.out.println("SE LISTO TODAS LAS VIGENCIAS CORRECTAMENTE.");
            }catch(SQLException ex){
                System.out.println("ERROR al listar todas las vigencias: "+ex.getMessage());
            }finally{
                DBManager.getInstance().cerrarConexion();
            }
            return listaVig;    
        }

        @Override
        public ArrayList<Vigencia> listarActivos() {
            ArrayList<Vigencia> listaVig=null;
            rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_vigencia_activos", null);
            System.out.println("Lectura de vigencia...");
                try{
                while(rs.next()){
                    if(listaVig==null) listaVig=new ArrayList<>();
                    Vigencia vig=new Vigencia();
                    vig.setIdVigencia(rs.getInt("idVigencia"));
                    vig.setFechaFin(rs.getDate("fechaFin"));
                    vig.setFechaInicio(rs.getDate("fechaInicio"));
                    vig.setActivo(rs.getBoolean("activo"));
                    listaVig.add(vig);
                }
                System.out.println("SE LISTO TODAS LAS VIGENCIAS ACTIVAS CORRECTAMENTE.");
            }catch(SQLException ex){
                System.out.println("ERROR al listar todas las vigencias activas: "+ex.getMessage());
            }finally{
                DBManager.getInstance().cerrarConexion();
            }
            return listaVig;    
        }

    }
