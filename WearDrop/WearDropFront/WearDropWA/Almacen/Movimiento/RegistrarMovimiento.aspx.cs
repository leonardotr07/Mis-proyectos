using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackageAlmacen;
using WearDropWA.ProveedorWS;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    [Serializable]
    public class LugarItem
    {
        public string Id { get; set; }
        public string NombreCompleto { get; set; }
    }

    public partial class RegistrarMovimiento : System.Web.UI.Page
    {
        private int idAlmacen;
        private MovimientoAlmacenWSClient boMovimiento;
        private AlmacenWSClient boAlmacen;
        private ProveedorWSClient boProveedor;
        private PackageAlmacen.cuentaUsuario cuentaUsuarioLogueada;

        // Usar List<LugarItem> en lugar de List<object>
        private List<LugarItem> ListaCompletaLugares
        {
            get { return ViewState["ListaCompletaLugares"] as List<LugarItem>; }
            set { ViewState["ListaCompletaLugares"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimiento = new MovimientoAlmacenWSClient();
            boAlmacen = new AlmacenWSClient();
            boProveedor = new ProveedorWSClient();

            if (Session["cuentaUsuario"] != null)
            {
                CuentaUsuarioWS.cuentaUsuario auxcuentaUsuarioLogueada = (CuentaUsuarioWS.cuentaUsuario)Session["cuentaUsuario"];
                cuentaUsuarioLogueada = new PackageAlmacen.cuentaUsuario
                {
                    idCuenta = auxcuentaUsuarioLogueada.idCuenta,
                    username = auxcuentaUsuarioLogueada.username,
                    contrasenha = auxcuentaUsuarioLogueada.contrasenha,
                    activo = auxcuentaUsuarioLogueada.activo,
                };
            }
            else
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    ViewState["IdAlmacen"] = idAlmacen;

                    CargarAlmacenesYProveedores();

                    txtHoraTraslado.Text = DateTime.Now.ToString("HH:mm");
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
            }
        }

        private void CargarAlmacenesYProveedores()
        {
            try
            {
                // Verificar si ya están cargados en ViewState
                if (ListaCompletaLugares != null && ListaCompletaLugares.Count > 0)
                {
                    EnlazarDropdowns(ListaCompletaLugares);
                    return;
                }

                // Obtener lista de almacenes del backend
                BindingList<almacen> listaAlmacenes = new BindingList<almacen>(boAlmacen.listarAlmacenesActivos());

                // Obtener lista de proveedores del backend
                BindingList<proveedor> listaProveedores = new BindingList<proveedor>(boProveedor.listarActivosSinCondiciones());

                // Crear lista con clase serializable
                var listaCompleta = new List<LugarItem>();

                // Agregar almacenes con prefijo
                foreach (var a in listaAlmacenes)
                {
                    listaCompleta.Add(new LugarItem
                    {
                        Id = "A-" + a.id,
                        NombreCompleto = $"[ALMACÉN] {a.nombre}"
                    });
                }

                // Agregar proveedores con prefijo
                foreach (var p in listaProveedores)
                {
                    listaCompleta.Add(new LugarItem
                    {
                        Id = "P-" + p.idProveedor,
                        NombreCompleto = $"[PROVEEDOR] {p.nombre}"
                    });
                }

                // Guardar en ViewState
                ListaCompletaLugares = listaCompleta;

                // Enlazar dropdowns
                EnlazarDropdowns(listaCompleta);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar almacenes y proveedores: {ex.Message}');", true);
            }
        }

        // Cambiar parámetro a List<LugarItem>
        private void EnlazarDropdowns(List<LugarItem> listaCompleta)
        {
            // Cargar dropdown de Lugar de Destino
            ddlLugarDestino.DataSource = listaCompleta;
            ddlLugarDestino.DataTextField = "NombreCompleto";
            ddlLugarDestino.DataValueField = "Id";
            ddlLugarDestino.DataBind();
            ddlLugarDestino.Items.Insert(0, new ListItem("-- Seleccione lugar de destino --", "0"));

            // Cargar dropdown de Lugar de Origen
            ddlLugarOrigen.DataSource = listaCompleta;
            ddlLugarOrigen.DataTextField = "NombreCompleto";
            ddlLugarOrigen.DataValueField = "Id";
            ddlLugarOrigen.DataBind();
            ddlLugarOrigen.Items.Insert(0, new ListItem("-- Seleccione lugar de origen --", "0"));

            ddlLugarOrigen.AutoPostBack = false;
            ddlLugarDestino.AutoPostBack = false;
        }

        private string DeterminarTipoMovimiento(string idLugarOrigen, string idLugarDestino)
        {
            bool origenEsProveedor = idLugarOrigen.StartsWith("P-");
            bool destinoEsProveedor = idLugarDestino.StartsWith("P-");

            if (origenEsProveedor)
            {
                return "Entrada";
            }
            else if (destinoEsProveedor)
            {
                return "Salida";
            }
            else
            {
                return "Mov_Interno";
            }
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    if (cuentaUsuarioLogueada == null)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Sesión expirada. Por favor, inicie sesión nuevamente.');", true);
                        Response.Redirect("~/InicioSesion.aspx");
                        return;
                    }

                    string idLugarDestino = ddlLugarDestino.SelectedValue;
                    string idLugarOrigen = ddlLugarOrigen.SelectedValue;

                    if (idLugarDestino == "0")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de destino');", true);
                        return;
                    }

                    if (idLugarOrigen == "0")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de origen');", true);
                        return;
                    }

                    if (idLugarDestino == idLugarOrigen)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('El lugar de origen y destino no pueden ser el mismo');", true);
                        return;
                    }

                    if (string.IsNullOrEmpty(txtFechaTraslado.Text))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar una fecha de traslado');", true);
                        return;
                    }

                    if (string.IsNullOrEmpty(txtHoraTraslado.Text))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar una hora de traslado');", true);
                        return;
                    }

                    string[] partesFecha = txtFechaTraslado.Text.Split('-');
                    int anio = int.Parse(partesFecha[0]);
                    int mes = int.Parse(partesFecha[1]);
                    int dia = int.Parse(partesFecha[2]);

                    string[] partesHora = txtHoraTraslado.Text.Split(':');
                    int horas = int.Parse(partesHora[0]);
                    int minutos = int.Parse(partesHora[1]);

                    DateTime fechaHoraCompleta = new DateTime(anio, mes, dia, horas, minutos, 0);
                    fechaHoraCompleta = DateTime.SpecifyKind(fechaHoraCompleta, DateTimeKind.Unspecified);

                    string lugarOrigen = ddlLugarOrigen.SelectedItem.Text;
                    string lugarDestino = ddlLugarDestino.SelectedItem.Text;

                    string nombreOrigen = ExtraerNombreLugar(lugarOrigen);
                    string nombreDestino = ExtraerNombreLugar(lugarDestino);

                    almacen almacenActual = boAlmacen.obtenerPorId(idAlmacen);
                    string nombreAlmacenActual = almacenActual.nombre;

                    bool origenEsAlmacenActual = idLugarOrigen.StartsWith("A-") &&
                                                  idLugarOrigen == "A-" + idAlmacen;
                    bool destinoEsAlmacenActual = idLugarDestino.StartsWith("A-") &&
                                                   idLugarDestino == "A-" + idAlmacen;

                    if (!origenEsAlmacenActual && !destinoEsAlmacenActual)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            $"alert('Al menos uno de los lugares (origen o destino) debe ser el almacén actual: {nombreAlmacenActual}');", true);
                        return;
                    }

                    string tipo = DeterminarTipoMovimiento(idLugarOrigen, idLugarDestino);

                    movimientoAlmacen nuevoMovimiento = new movimientoAlmacen();
                    nuevoMovimiento.lugarOrigen = nombreOrigen;
                    nuevoMovimiento.lugarDestino = nombreDestino;
                    nuevoMovimiento.fecha = fechaHoraCompleta;
                    nuevoMovimiento.fechaSpecified = true;

                    try
                    {
                        nuevoMovimiento.tipo = (tipoMovimiento)Enum.Parse(typeof(tipoMovimiento), tipo);
                        nuevoMovimiento.tipoSpecified = true;
                    }
                    catch (Exception exEnum)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            $"alert('Error al asignar tipo de movimiento: {tipo}. Error: {exEnum.Message}');", true);
                        return;
                    }

                    nuevoMovimiento.datAlmacen = new almacen();
                    nuevoMovimiento.datAlmacen.id = idAlmacen;

                    nuevoMovimiento.datUsuario = new WearDropWA.PackageAlmacen.cuentaUsuario();
                    nuevoMovimiento.datUsuario.idCuenta = cuentaUsuarioLogueada.idCuenta;

                    int resultado = boMovimiento.insertarMovAlmacen(nuevoMovimiento);

                    if (resultado > 0)
                    {
                        Session["UltimaPagina"] = "Movimientos";
                        Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=movimientoRegistrado");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al registrar el movimiento. Intente nuevamente.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error: {ex.Message}');", true);
                }
            }
        }

        private string ExtraerNombreLugar(string textoCompleto)
        {
            if (textoCompleto.StartsWith("[ALMACÉN] "))
            {
                return textoCompleto.Replace("[ALMACÉN] ", "").Trim();
            }
            else if (textoCompleto.StartsWith("[PROVEEDOR] "))
            {
                return textoCompleto.Replace("[PROVEEDOR] ", "").Trim();
            }
            return textoCompleto.Trim();
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
        }

        protected override void OnUnload(EventArgs e)
        {
            if (boMovimiento != null)
            {
                try { boMovimiento.Close(); } catch { }
            }
            if (boAlmacen != null)
            {
                try { boAlmacen.Close(); } catch { }
            }
            if (boProveedor != null)
            {
                try { boProveedor.Close(); } catch { }
            }
            base.OnUnload(e);
        }
    }
}
