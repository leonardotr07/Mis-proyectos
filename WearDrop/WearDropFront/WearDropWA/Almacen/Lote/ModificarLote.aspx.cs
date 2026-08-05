using System;
using System.Web.UI;
using WearDropWA.PackageAlmacen;

namespace WearDropWA
{
    public partial class ModificarLote : System.Web.UI.Page
    {
        private int idAlmacen;
        private int idLote;
        private LoteWSClient boLote;
        private AlmacenWSClient boAlmacen;
        private lote datLote;
        private almacen datAlmacen;

        // OPTIMIZACIÓN: Cachear datos en ViewState
        private almacen DatosAlmacen
        {
            get { return ViewState["DatosAlmacen"] as almacen; }
            set { ViewState["DatosAlmacen"] = value; }
        }

        private lote DatosLote
        {
            get { return ViewState["DatosLote"] as lote; }
            set { ViewState["DatosLote"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boLote = new LoteWSClient();
            boAlmacen = new AlmacenWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null && Request.QueryString["idAlmacen"] != null)
                {
                    idLote = Convert.ToInt32(Request.QueryString["id"]);
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);

                    ViewState["IdLote"] = idLote;
                    ViewState["IdAlmacen"] = idAlmacen;

                    // Cargar todos los datos una sola vez
                    CargarDatosIniciales();
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idLote = (int)ViewState["IdLote"];
                idAlmacen = (int)ViewState["IdAlmacen"];
            }
        }

        private void CargarDatosIniciales()
        {
            try
            {
                // Cargar datos del almacén
                DatosAlmacen = boAlmacen.obtenerPorId(idAlmacen);

                if (DatosAlmacen != null)
                {
                    txtIdAlmacen.Text = DatosAlmacen.id.ToString();
                    txtNombreAlmacen.Text = DatosAlmacen.nombre ?? "-";
                    txtUbicacion.Text = DatosAlmacen.ubicacion ?? "-";
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Almacén no encontrado');", true);
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                    return;
                }

                // Cargar datos del lote
                DatosLote = boLote.obtenerLotePorID(idLote);

                if (DatosLote != null)
                {
                    txtIdLote.Text = DatosLote.idLote.ToString();
                    txtDescripcionLote.Text = DatosLote.descripcion ?? "";
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Lote no encontrado');", true);
                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos: {ex.Message}');", true);
            }
        }

        protected void lkGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string descripcion = txtDescripcionLote.Text.Trim();

                if (string.IsNullOrEmpty(descripcion))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('La descripción del lote es obligatoria');", true);
                    return;
                }

                // Recuperar lote desde ViewState
                datLote = DatosLote;

                if (datLote == null)
                {
                    datLote = new lote();
                    datLote.datAlmacen = new almacen();
                    datLote.datAlmacen.id = idAlmacen;
                }

                datLote.idLote = idLote;
                datLote.descripcion = descripcion;

                int resultado = boLote.modificarLote(datLote);

                if (resultado > 0)
                {
                    // Establecer la última pestaña visitada
                    Session["UltimaPagina"] = "Lotes";

                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=loteModificado");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error al modificar el lote. Intente nuevamente.');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            // No cambiar la pestaña activa al cancelar
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
        }

        protected override void OnUnload(EventArgs e)
        {
            // Cerrar conexiones
            if (boLote != null)
            {
                try { boLote.Close(); } catch { }
            }
            if (boAlmacen != null)
            {
                try { boAlmacen.Close(); } catch { }
            }
            base.OnUnload(e);
        }
    }
}
