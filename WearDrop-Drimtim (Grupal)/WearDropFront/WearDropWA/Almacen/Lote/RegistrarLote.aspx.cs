using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackageAlmacen;

namespace WearDropWA
{
    public partial class RegistrarLote : System.Web.UI.Page
    {
        private int idAlmacen;
        private MovimientoAlmacenWSClient boMov;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovXLote;
        private AlmacenWSClient boAlmacen;

        private BindingList<movimientoAlmacen> ListaMovimientos
        {
            get { return ViewState["ListaMovimientos"] as BindingList<movimientoAlmacen>; }
            set { ViewState["ListaMovimientos"] = value; }
        }

        // Cachear datos del almacén
        private almacen DatosAlmacen
        {
            get { return ViewState["DatosAlmacen"] as almacen; }
            set { ViewState["DatosAlmacen"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boMov = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovXLote = new MovimientoAlmacenXLoteWSClient();
            boAlmacen = new AlmacenWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    ViewState["IdAlmacen"] = idAlmacen;

                    // Cargar datos una sola vez
                    CargarDatosIniciales();

                    // Preseleccionar movimiento si viene del query string
                    if (Request.QueryString["idMovimiento"] != null)
                    {
                        int idMovimiento = Convert.ToInt32(Request.QueryString["idMovimiento"]);
                        ddlIdMovimiento.SelectedValue = idMovimiento.ToString();
                        ActualizarDatosMovimiento(idMovimiento);
                    }
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

        // NUEVO MÉTODO: Cargar todos los datos iniciales de una vez
        private void CargarDatosIniciales()
        {
            try
            {
                // Cargar datos del almacén
                DatosAlmacen = boAlmacen.obtenerPorId(idAlmacen);

                if (DatosAlmacen != null)
                {
                    lblNombreAlmacen.Text = DatosAlmacen.nombre ?? "Almacén no encontrado";
                }
                else
                {
                    lblNombreAlmacen.Text = "Almacén no encontrado";
                }

                // Cargar movimientos del almacén
                CargarMovimientos();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos iniciales: {ex.Message}');", true);
                lblNombreAlmacen.Text = "Error al cargar";
            }
        }

        private void CargarMovimientos()
        {
            try
            {
                // Verificar si ya están cargados
                if (ListaMovimientos != null && ListaMovimientos.Count > 0)
                {
                    EnlazarDropdownMovimientos();
                    return;
                }

                // Cargar desde el servicio
                ListaMovimientos = new BindingList<movimientoAlmacen>(
                    boMov.listarMovimientosPorAlmacen(idAlmacen)
                );

                EnlazarDropdownMovimientos();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar movimientos: {ex.Message}');", true);
            }
        }

        // NUEVO MÉTODO: Separar lógica de enlace
        private void EnlazarDropdownMovimientos()
        {
            var movimientosFormateados = ListaMovimientos.Select(m => new
            {
                IdMovimiento = m.idMovimiento,
                DescripcionCompleta = $"Mov {m.idMovimiento} - {m.tipo} - {m.lugarOrigen} a {m.lugarDestino}"
            }).ToList();

            ddlIdMovimiento.DataSource = movimientosFormateados;
            ddlIdMovimiento.DataTextField = "DescripcionCompleta";
            ddlIdMovimiento.DataValueField = "IdMovimiento";
            ddlIdMovimiento.DataBind();

            ddlIdMovimiento.Items.Insert(0, new ListItem("--Seleccione un movimiento--", "0"));
        }

        protected void ddlIdMovimiento_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlIdMovimiento.SelectedValue);

            if (idMovimiento > 0)
            {
                ActualizarDatosMovimiento(idMovimiento);
            }
            else
            {
                lblLugarOrigen.Text = "-";
                lblLugarDestino.Text = "-";
            }
        }

        private void ActualizarDatosMovimiento(int idMovimiento)
        {
            try
            {
                movimientoAlmacen movimientoSeleccionado = null;

                // Buscar primero en la lista cacheada
                if (ListaMovimientos != null)
                {
                    movimientoSeleccionado = ListaMovimientos.FirstOrDefault(m => m.idMovimiento == idMovimiento);
                }

                // Si no está en caché, buscar en el servicio
                if (movimientoSeleccionado == null)
                {
                    movimientoSeleccionado = boMov.obtenerMovimientoPorId(idMovimiento);
                }

                if (movimientoSeleccionado != null)
                {
                    lblLugarOrigen.Text = movimientoSeleccionado.lugarOrigen ?? "-";
                    lblLugarDestino.Text = movimientoSeleccionado.lugarDestino ?? "-";
                }
                else
                {
                    lblLugarOrigen.Text = "-";
                    lblLugarDestino.Text = "-";
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos del movimiento: {ex.Message}');", true);
                lblLugarOrigen.Text = "-";
                lblLugarDestino.Text = "-";
            }
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                int idMovimiento = Convert.ToInt32(ddlIdMovimiento.SelectedValue);

                if (idMovimiento == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Debe seleccionar un movimiento');", true);
                    return;
                }

                string descripcion = txtDescripcionLote.Text.Trim();

                if (string.IsNullOrEmpty(descripcion))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Debe ingresar una descripción para el lote');", true);
                    return;
                }

                // 1. Crear el lote
                lote nuevoLote = new lote();
                nuevoLote.datAlmacen = new almacen();
                nuevoLote.datAlmacen.id = idAlmacen;
                nuevoLote.descripcion = descripcion;
                nuevoLote.activo = true;

                int idLote = boLote.insertarLote(nuevoLote);

                if (idLote <= 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error al crear el lote');", true);
                    return;
                }

                // 2. Buscar el movimiento en la lista cacheada
                movimientoAlmacen movimientoSeleccionado = ListaMovimientos
                    .FirstOrDefault(m => m.idMovimiento == idMovimiento);

                if (movimientoSeleccionado == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error: No se pudo obtener el movimiento seleccionado');", true);
                    return;
                }

                // 3. Crear la relación MovimientoXLote
                movimientoAlmacenXLote nuevaRelacion = new movimientoAlmacenXLote();
                nuevaRelacion.idMov_X_Lote = 0;
                nuevaRelacion.activo = true;

                // Asignar el movimiento completo
                nuevaRelacion.datMov = new movimientoAlmacen();
                nuevaRelacion.datMov.idMovimiento = movimientoSeleccionado.idMovimiento;
                nuevaRelacion.datMov.lugarOrigen = movimientoSeleccionado.lugarOrigen;
                nuevaRelacion.datMov.lugarDestino = movimientoSeleccionado.lugarDestino;
                nuevaRelacion.datMov.datAlmacen = new almacen();
                nuevaRelacion.datMov.datAlmacen.id = idAlmacen;

                // Asignar el lote
                nuevaRelacion.datLote = new lote();
                nuevaRelacion.datLote.idLote = idLote;

                int resultadoRelacion = boMovXLote.insertarMovXLote(nuevaRelacion);

                if (resultadoRelacion > 0)
                {
                    // Establecer la última pestaña visitada
                    Session["UltimaPagina"] = "Lotes";

                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=loteRegistrado");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error al registrar la relación Movimiento-Lote.');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error crítico: {ex.Message}');", true);
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            // ✅ No cambiar la pestaña activa al cancelar
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
        }

        protected override void OnUnload(EventArgs e)
        {
            // Cerrar conexiones de servicios
            if (boMov != null)
            {
                try { boMov.Close(); } catch { }
            }
            if (boLote != null)
            {
                try { boLote.Close(); } catch { }
            }
            if (boMovXLote != null)
            {
                try { boMovXLote.Close(); } catch { }
            }
            if (boAlmacen != null)
            {
                try { boAlmacen.Close(); } catch { }
            }
            base.OnUnload(e);
        }
    }
}
