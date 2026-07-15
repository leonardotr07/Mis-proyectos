using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackageAlmacen;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    // CLASE SERIALIZABLE (igual que en RegistrarMovimiento)
    [Serializable]
    public class LugarItemModificar
    {
        public string Id { get; set; }
        public string NombreCompleto { get; set; }
        public string NombreLimpio { get; set; }
    }

    public partial class ModificarMovimiento : System.Web.UI.Page
    {
        private int idAlmacen;
        private int idMovimiento;
        private MovimientoAlmacenWSClient boMovimiento;
        private AlmacenWSClient boAlmacen;
        private ProveedorWSClient boProveedor;
        private movimientoAlmacen datMov;

        // OPTIMIZACIÓN: Almacenar listas en ViewState
        private List<LugarItemModificar> ListaCompletaLugares
        {
            get { return ViewState["ListaCompletaLugares"] as List<LugarItemModificar>; }
            set { ViewState["ListaCompletaLugares"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimiento = new MovimientoAlmacenWSClient();
            boAlmacen = new AlmacenWSClient();
            boProveedor = new ProveedorWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null && Request.QueryString["id"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    idMovimiento = Convert.ToInt32(Request.QueryString["id"]);

                    ViewState["IdAlmacen"] = idAlmacen;
                    ViewState["IdMovimiento"] = idMovimiento;

                    // Cargar almacenes y proveedores primero
                    CargarAlmacenesYProveedores();

                    // Luego cargar los datos del movimiento
                    CargarDatosMovimiento();
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
                idMovimiento = (int)ViewState["IdMovimiento"];
            }
        }

        private void CargarAlmacenesYProveedores()
        {
            try
            {
                // ✅ Verificar si ya están cargados en ViewState
                if (ListaCompletaLugares != null && ListaCompletaLugares.Count > 0)
                {
                    EnlazarDropdowns(ListaCompletaLugares);
                    return;
                }

                // Obtener lista de almacenes del backend
                BindingList<almacen> listaAlmacenes = new BindingList<almacen>(boAlmacen.listarAlmacenesActivos());

                // Obtener lista de proveedores del backend
                BindingList<proveedor> listaProveedores = new BindingList<proveedor>(boProveedor.listarActivosSinCondiciones());

                // ✅ Crear lista con clase serializable
                var listaCompleta = new List<LugarItemModificar>();

                // Agregar almacenes con prefijo
                foreach (var a in listaAlmacenes)
                {
                    listaCompleta.Add(new LugarItemModificar
                    {
                        Id = "A-" + a.id,
                        NombreCompleto = $"[ALMACÉN] {a.nombre}",
                        NombreLimpio = a.nombre
                    });
                }

                // Agregar proveedores con prefijo
                foreach (var p in listaProveedores)
                {
                    listaCompleta.Add(new LugarItemModificar
                    {
                        Id = "P-" + p.idProveedor,
                        NombreCompleto = $"[PROVEEDOR] {p.nombre}",
                        NombreLimpio = p.nombre
                    });
                }

                // ✅ Guardar en ViewState
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

        // NUEVO MÉTODO: Enlazar dropdowns con la lista
        private void EnlazarDropdowns(List<LugarItemModificar> listaCompleta)
        {
            // Cargar dropdown de Lugar de Origen
            ddlLugarOrigen.DataSource = listaCompleta;
            ddlLugarOrigen.DataTextField = "NombreCompleto";
            ddlLugarOrigen.DataValueField = "Id";
            ddlLugarOrigen.DataBind();
            ddlLugarOrigen.Items.Insert(0, new ListItem("-- Seleccione lugar de origen --", "0"));

            // Cargar dropdown de Lugar de Destino
            ddlLugarDestino.DataSource = listaCompleta;
            ddlLugarDestino.DataTextField = "NombreCompleto";
            ddlLugarDestino.DataValueField = "Id";
            ddlLugarDestino.DataBind();
            ddlLugarDestino.Items.Insert(0, new ListItem("-- Seleccione lugar de destino --", "0"));

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

        private void CargarDatosMovimiento()
        {
            try
            {
                datMov = boMovimiento.obtenerMovimientoPorId(idMovimiento);

                if (datMov != null)
                {
                    // Cargar la fecha y hora por separado
                    txtFechaTraslado.Text = datMov.fecha.ToString("yyyy-MM-dd");
                    txtHoraTraslado.Text = datMov.fecha.ToString("HH:mm");

                    // BUSCAR Y SELECCIONAR LUGAR DE ORIGEN
                    string idOrigenSeleccionado = "0";
                    foreach (ListItem item in ddlLugarOrigen.Items)
                    {
                        string nombreItem = ExtraerNombreLugar(item.Text);

                        if (nombreItem.Equals(datMov.lugarOrigen, StringComparison.OrdinalIgnoreCase))
                        {
                            idOrigenSeleccionado = item.Value;
                            ddlLugarOrigen.SelectedValue = item.Value;
                            break;
                        }
                    }

                    // BUSCAR Y SELECCIONAR LUGAR DE DESTINO
                    string idDestinoSeleccionado = "0";
                    foreach (ListItem item in ddlLugarDestino.Items)
                    {
                        string nombreItem = ExtraerNombreLugar(item.Text);

                        if (nombreItem.Equals(datMov.lugarDestino, StringComparison.OrdinalIgnoreCase))
                        {
                            idDestinoSeleccionado = item.Value;
                            ddlLugarDestino.SelectedValue = item.Value;
                            break;
                        }
                    }

                    string script = $@"
                <script type='text/javascript'>
                    $(document).ready(function() {{
                        setTimeout(function() {{
                            $('#{ddlLugarOrigen.ClientID}').val('{idOrigenSeleccionado}').trigger('change');
                            $('#{ddlLugarDestino.ClientID}').val('{idDestinoSeleccionado}').trigger('change');
                        }}, 100);
                    }});
                </script>
            ";
                    ClientScript.RegisterStartupScript(this.GetType(), "setSelect2Values", script);

                    // Guardar el movimiento completo en ViewState
                    ViewState["DatMovimiento"] = datMov;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Movimiento no encontrado');", true);
                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos del movimiento: {ex.Message}');", true);
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

        protected void lkModificar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string idLugarOrigen = ddlLugarOrigen.SelectedValue;
                    string idLugarDestino = ddlLugarDestino.SelectedValue;

                    if (idLugarOrigen == "0")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de origen');", true);
                        return;
                    }

                    if (idLugarDestino == "0")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de destino');", true);
                        return;
                    }

                    if (idLugarOrigen == idLugarDestino)
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

                    datMov = (movimientoAlmacen)ViewState["DatMovimiento"];

                    if (datMov == null)
                    {
                        datMov = new movimientoAlmacen();
                        datMov.datAlmacen = new almacen { id = idAlmacen };
                    }

                    datMov.idMovimiento = idMovimiento;
                    datMov.lugarOrigen = nombreOrigen;
                    datMov.lugarDestino = nombreDestino;
                    datMov.fecha = fechaHoraCompleta;
                    datMov.fechaSpecified = true;

                    try
                    {
                        datMov.tipo = (tipoMovimiento)Enum.Parse(typeof(tipoMovimiento), tipo);
                        datMov.tipoSpecified = true;
                    }
                    catch (Exception exEnum)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            $"alert('Error al asignar tipo de movimiento: {tipo}. Error: {exEnum.Message}');", true);
                        return;
                    }

                    int resultado = boMovimiento.modificarMovimientoAlmacen(datMov);

                    if (resultado > 0)
                    {
                        // Establecer la última pestaña visitada
                        Session["UltimaPagina"] = "Movimientos";

                        Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=movimientoModificado");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al modificar el movimiento. Intente nuevamente.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error: {ex.Message}');", true);
                }
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            // No cambiar la pestaña al cancelar
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
