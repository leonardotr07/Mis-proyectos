using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.OrdenCompraWS;
using WearDropWA.PackagePrendas;

namespace WearDropWA
{
    public partial class RegistrarOrdenCompra : System.Web.UI.Page
    {
        // 🔹 LISTA PRINCIPAL EN SESIÓN usando el servicio web real
        private List<OrdenCompraWS.lineaLoteCompra> LineasOrden
        {
            get
            {
                if (Session["LineasOrdenCompra"] == null)
                    Session["LineasOrdenCompra"] = new List<OrdenCompraWS.lineaLoteCompra>();
                return (List<OrdenCompraWS.lineaLoteCompra>)Session["LineasOrdenCompra"];
            }
            set { Session["LineasOrdenCompra"] = value; }
        }

        // 🔹 NUEVA SESIÓN PARA LA ORDEN TEMPORAL (no afecta a AnnadirLineaDeLaCompra)
        private OrdenCompraWS.ordenCompra OrdenTemporal
        {
            get
            {
                if (Session["OrdenTemporalRegistro"] == null)
                {
                    Session["OrdenTemporalRegistro"] = new OrdenCompraWS.ordenCompra
                    {
                        fechaEmision = DateTime.Now,
                        fechaLlegada = DateTime.Now.AddDays(7),
                        activo = true
                    };
                }
                return (OrdenCompraWS.ordenCompra)Session["OrdenTemporalRegistro"];
            }
            set { Session["OrdenTemporalRegistro"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔹 VERIFICAR SI VIENEMOS DE MODIFICAR UNA LÍNEA O DE DETALLE
            bool vieneDeModificarLinea = Session["VieneDeModificarLinea"] != null && (bool)Session["VieneDeModificarLinea"];
            bool vieneDeDetalle = Session["VieneDeDetalle"] != null && (bool)Session["VieneDeDetalle"];

            System.Diagnostics.Debug.WriteLine($"=== PAGE_LOAD - IsPostBack: {IsPostBack}, VieneDeModificarLinea: {vieneDeModificarLinea}, VieneDeDetalle: {vieneDeDetalle} ===");

            if (!IsPostBack)
            {
                // 🔹 SOLO EN CARGA INICIAL: VERIFICAR MODO Y CARGAR DATOS
                string modo = Session["ModoOrden"] as string;

                if (modo == "modificar" || modo == "ver")
                {
                    CargarOrdenExistente(modo);
                }
                else
                {
                    // 🔹 CORRECCIÓN CRÍTICA: NO LIMPIAR LA SESIÓN SI VIENEMOS DE AÑADIR LÍNEA O DETALLE
                    if (!vieneDeModificarLinea && !vieneDeDetalle)
                    {
                        // Solo limpiar en modo nuevo cuando no venimos de otras páginas
                        Session.Remove("LineasOrdenCompra");
                        Session.Remove("OrdenTemporalRegistro");
                        System.Diagnostics.Debug.WriteLine("🔄 Modo nuevo - Sesiones limpiadas");
                    }
                    else if (vieneDeDetalle)
                    {
                        System.Diagnostics.Debug.WriteLine("🔄 Viene de detalle - Manteniendo líneas en sesión");
                        Session.Remove("VieneDeDetalle"); // Limpiar bandera
                    }
                }

                CargarLineasOrden();
            }
            else if (vieneDeModificarLinea)
            {
                // 🔹 CUANDO VENIMOS DE MODIFICAR UNA LÍNEA: SOLO ACTUALIZAR EL GRID
                System.Diagnostics.Debug.WriteLine("🔄 Recargando grid después de modificar línea");
                CargarLineasOrden();
                Session.Remove("VieneDeModificarLinea");
            }
            else if (vieneDeDetalle)
            {
                // 🔹 CUANDO VENIMOS DE DETALLE: MANTENER DATOS Y ACTUALIZAR
                System.Diagnostics.Debug.WriteLine("🔄 Recargando después de regresar de detalle");
                CargarLineasOrden();
                Session.Remove("VieneDeDetalle");
            }

            // 🔹 DEBUG: VERIFICAR ESTADO ACTUAL
            System.Diagnostics.Debug.WriteLine($"Líneas en sesión después de Page_Load: {LineasOrden?.Count ?? 0}");

            // 🔹 DIAGNÓSTICO COMPLETO
            DiagnosticarSesion();
        }
        // 🔹 MÉTODO DE DIAGNÓSTICO
        private void DiagnosticarSesion()
        {
            System.Diagnostics.Debug.WriteLine("=== DIAGNÓSTICO COMPLETO DE SESIÓN ===");
            System.Diagnostics.Debug.WriteLine($"LineasOrden: {LineasOrden?.Count ?? 0} líneas");
            System.Diagnostics.Debug.WriteLine($"OrdenTemporal: {(OrdenTemporal != null ? "EXISTE" : "NULL")}");
            System.Diagnostics.Debug.WriteLine($"ModoOrden: {Session["ModoOrden"] ?? "NO DEFINIDO"}");
            System.Diagnostics.Debug.WriteLine($"VieneDeModificarLinea: {Session["VieneDeModificarLinea"] ?? "FALSE"}");

            // Verificar todas las claves de sesión
            System.Diagnostics.Debug.WriteLine("Claves de sesión activas:");
            foreach (string key in Session.Keys)
            {
                var value = Session[key];
                if (value is List<OrdenCompraWS.lineaLoteCompra> lineas)
                {
                    System.Diagnostics.Debug.WriteLine($"  - {key}: List<lineaLoteCompra> con {lineas.Count} elementos");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"  - {key}: {value?.GetType().Name ?? "NULL"} = {value}");
                }
            }
            System.Diagnostics.Debug.WriteLine("=============================");
        }


        // 🔹 MÉTODO CORREGIDO: Cargar orden existente para modificar/ver
        private void CargarOrdenExistente(string modo)
        {
            try
            {
                // 🔹 VERIFICAR SI YA TENEMOS LÍNEAS MODIFICADAS EN SESIÓN (DE AÑADIR LÍNEA)
                bool tieneLineasModificadas = LineasOrden != null && LineasOrden.Count > 0;
                bool vieneDeModificarLinea = Session["VieneDeModificarLinea"] != null && (bool)Session["VieneDeModificarLinea"];

                System.Diagnostics.Debug.WriteLine($"CargarOrdenExistente - Modo: {modo}, TieneLineasModificadas: {tieneLineasModificadas}, VieneDeModificarLinea: {vieneDeModificarLinea}");

                if (tieneLineasModificadas && vieneDeModificarLinea)
                {
                    System.Diagnostics.Debug.WriteLine("✅ MANTENIENDO líneas modificadas en sesión");
                    // 🔹 NO CARGAR DESDE LA BD - USAR LAS LÍNEAS QUE YA ESTÁN EN SESIÓN
                }
                else
                {
                    // 🔹 SOLO CARGAR DESDE LA BD SI NO HAY LÍNEAS EN SESIÓN O NO VIENEMOS DE MODIFICAR
                    var ordenCompleta = Session["OrdenPara" + modo] as OrdenCompraWS.ordenCompra;

                    if (ordenCompleta != null && ordenCompleta.items != null)
                    {
                        // 🔹 CARGAR LÍNEAS INICIALES DESDE LA BD SOLO LA PRIMERA VEZ
                        LineasOrden = ordenCompleta.items.ToList();
                        System.Diagnostics.Debug.WriteLine($"✅ Cargadas {LineasOrden.Count} líneas iniciales desde BD");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("ℹ️ No hay orden completa para cargar o no tiene items");
                    }
                }

                // 🔹 GUARDAR ORDEN TEMPORAL PARA REGISTRAR DETALLE
                var ordenCompletaParaDatos = Session["OrdenPara" + modo] as OrdenCompraWS.ordenCompra;
                if (ordenCompletaParaDatos != null)
                {
                    OrdenTemporal = ordenCompletaParaDatos;

                    // 🔹 ACTUALIZAR EL MONTO TOTAL CON LAS LÍNEAS ACTUALES (MODIFICADAS O NO)
                    if (LineasOrden != null && LineasOrden.Count > 0)
                    {
                        OrdenTemporal.montoTotal = LineasOrden.Sum(linea => linea.precioLote);
                        OrdenTemporal.deudaPendiente = OrdenTemporal.montoTotal;
                    }
                }

                // 🔹 CONFIGURAR INTERFAZ SEGÚN MODO
                ConfigurarInterfazPorModo(modo);

                System.Diagnostics.Debug.WriteLine($"✅ Orden cargada en modo {modo}. Líneas en sesión: {LineasOrden?.Count ?? 0}");

            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar orden existente: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO MEJORADO: Configurar interfaz según modo
        private void ConfigurarInterfazPorModo(string modo)
        {
            if (modo == "ver")
            {
                btnAgregarLinea.Visible = false;

                // 🔹 CORRECCIÓN: Mantener el color normal del botón (azul)
                btnRegistrarOrden.Visible = true;
                btnRegistrarOrden.Text = "Ver Detalles de Orden";
                btnRegistrarOrden.CssClass = "btn-wd rounded shadow-sm"; // 🔹 QUITAR btn-ver-detalle

                lblTitulo.Text = "Ver Orden de Compra";
                btnRegresar.Text = "Cerrar";
            }
            else if (modo == "modificar")
            {
                btnAgregarLinea.Visible = true;
                btnRegistrarOrden.Visible = true;
                btnRegistrarOrden.Text = "Actualizar Orden";
                btnRegistrarOrden.CssClass = "btn-wd rounded shadow-sm";
                lblTitulo.Text = "Modificar Orden de Compra";
                btnRegresar.Text = "Regresar";
            }
            else
            {
                btnRegistrarOrden.Text = "Registrar Orden";
                btnRegistrarOrden.CssClass = "btn-wd rounded shadow-sm";
                btnRegresar.Text = "Regresar";
            }
        }
        // 🔹 MÉTODO MEJORADO: Cargar líneas con debug mejorado
        private void CargarLineasOrden()
        {
            try
            {
                // 🔹 VERIFICAR SI HAY CAMBIOS EN LA SESIÓN
                System.Diagnostics.Debug.WriteLine($"=== CARGANDO LÍNEAS DESDE SESIÓN ===");
                System.Diagnostics.Debug.WriteLine($"Líneas en sesión: {LineasOrden?.Count ?? 0}");

                if (LineasOrden == null)
                {
                    System.Diagnostics.Debug.WriteLine("❌ ERROR: LineasOrden es NULL - Inicializando...");
                    LineasOrden = new List<OrdenCompraWS.lineaLoteCompra>();
                }

                // 🔹 DEBUG DETALLADO DE LAS LÍNEAS
                if (LineasOrden.Count > 0)
                {
                    System.Diagnostics.Debug.WriteLine("=== DETALLE DE LÍNEAS EN SESIÓN ===");
                    for (int i = 0; i < LineasOrden.Count; i++)
                    {
                        var linea = LineasOrden[i];
                        System.Diagnostics.Debug.WriteLine($"Línea {i}: ID={linea.idPrenda}, Cantidad={linea.cantidad}, Precio={linea.precioLote}, Talla={linea.talla}, Lote={linea.lote?.idLote}");
                    }
                    System.Diagnostics.Debug.WriteLine("=================================");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay líneas en la sesión");
                }

                if (LineasOrden.Count == 0)
                {
                    var emptyList = new List<dynamic> { new {
                Numero = 0,
                Prenda = "No hay líneas agregadas",
                Talla = "",
                Lote = "",
                Cantidad = 0,
                PrecioLote = 0.0
            }};
                    dgvOrdenDetalle.DataSource = emptyList;
                    dgvOrdenDetalle.EmptyDataText = "No hay líneas de compra agregadas";
                    System.Diagnostics.Debug.WriteLine("ℹ️ No hay líneas para mostrar - Grid vacío");
                }
                else
                {
                    // 🔹 CALCULAR MONTO TOTAL Y ACTUALIZAR ORDEN TEMPORAL
                    double montoTotal = LineasOrden.Sum(linea => linea.precioLote);
                    OrdenTemporal.montoTotal = montoTotal;
                    OrdenTemporal.deudaPendiente = montoTotal;

                    // 🔹 USAR DATOS REALES DE LA LISTA
                    var datosParaMostrar = LineasOrden.Select((linea, index) => new
                    {
                        Numero = index + 1,
                        Prenda = ObtenerNombrePrenda(linea.idPrenda) ?? $"Prenda ID: {linea.idPrenda}",
                        Talla = linea.talla.ToString(),
                        Lote = linea.lote?.idLote.ToString() ?? "N/A",
                        Cantidad = linea.cantidad,
                        PrecioLote = linea.precioLote
                    }).ToList();

                    System.Diagnostics.Debug.WriteLine($"=== DATOS PARA MOSTRAR EN GRID ===");
                    foreach (var item in datosParaMostrar)
                    {
                        System.Diagnostics.Debug.WriteLine($"Línea {item.Numero}: {item.Prenda}, Cantidad: {item.Cantidad}, Precio: {item.PrecioLote}");
                    }

                    dgvOrdenDetalle.DataSource = datosParaMostrar;
                    System.Diagnostics.Debug.WriteLine($"✅ Grid cargado con {datosParaMostrar.Count} líneas");
                }

                dgvOrdenDetalle.DataBind();

                // 🔹 VERIFICAR QUE EL GRID SE ACTUALIZÓ
                System.Diagnostics.Debug.WriteLine($"Grid rows después de DataBind: {dgvOrdenDetalle.Rows.Count}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"💥 ERROR en CargarLineasOrden: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack: {ex.StackTrace}");
            }
        }

        // 🔹 ACTUALIZAR EL BOTÓN REGISTRAR PARA MANEJAR MODIFICACIÓN Y MODO VER
        protected void btnRegistrarOrden_Click(object sender, EventArgs e)
        {
            string modo = Session["ModoOrden"] as string;

            // 🔹 EN MODO "VER", SOLO REDIRIGIR A LA PÁGINA DE DETALLES SIN VALIDACIONES
            if (modo == "ver")
            {
                try
                {
                    // 🔹 PREPARAR DATOS PARA LA SIGUIENTE PÁGINA (SOLO LECTURA)
                    OrdenTemporal.items = LineasOrden.ToArray();
                    OrdenTemporal.montoTotal = LineasOrden.Sum(linea => linea.precioLote);

                    // 🔹 REDIRIGIR A LA PÁGINA DE DETALLES EN MODO VISUALIZACIÓN
                    Response.Redirect("~/RegistrarDetalleOrdenCompra.aspx");
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al cargar detalles: {ex.Message}", "error");
                }
                return;
            }

            // 🔹 VALIDACIONES SOLO PARA MODOS QUE PERMITEN MODIFICACIÓN
            if (LineasOrden.Count == 0)
            {
                MostrarMensaje("Debe agregar al menos una línea a la orden.", "error");
                return;
            }

            try
            {
                // 🔹 PREPARAR DATOS PARA LA SIGUIENTE PÁGINA
                OrdenTemporal.items = LineasOrden.ToArray();
                OrdenTemporal.montoTotal = LineasOrden.Sum(linea => linea.precioLote);

                // 🔹 SI ES MODIFICACIÓN, MANTENER EL ID EXISTENTE
                if (modo == "modificar" && Session["IdOrdenmodificar"] != null)
                {
                    OrdenTemporal.idCompra = (int)Session["IdOrdenmodificar"];
                }

                // 🔹 REDIRIGIR A LA PÁGINA DE DETALLES
                Response.Redirect("~/RegistrarDetalleOrdenCompra.aspx");
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al preparar orden: {ex.Message}", "error");
            }
        }

        // 🔹 MÉTODO MODIFICADO: Agregar bandera cuando vamos a modificar una línea
        protected void btnAgregarLinea_Click(object sender, EventArgs e)
        {
            Session["ModoLinea"] = "nuevo";
            Session["LineaSeleccionada"] = null;
            Session["IndiceLineaEditar"] = null;
            Response.Redirect("~/AnnadirLineaDeLaCompra.aspx");
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            // 🔹 LIMPIAR SESIONES AL REGRESAR
            Session.Remove("LineasOrdenCompra");
            Session.Remove("OrdenTemporalRegistro");
            Session.Remove("ModoOrden");
            Session.Remove("IdOrdenmodificar");
            Response.Redirect("~/GestionarOrdenesDeCompra.aspx");
        }

        // 🔹 MÉTODO MEJORADO - RowCommand para el GridView
        protected void dgvOrdenDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerLinea" || e.CommandName == "EditarLinea" || e.CommandName == "EliminarLinea")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int indexReal = ObtenerIndiceReal(rowIndex);

                System.Diagnostics.Debug.WriteLine($"=== EJECUTANDO COMANDO: {e.CommandName} ===");
                System.Diagnostics.Debug.WriteLine($"RowIndex: {rowIndex}, IndexReal: {indexReal}");
                System.Diagnostics.Debug.WriteLine($"Total líneas: {LineasOrden.Count}");

                if (indexReal >= 0 && indexReal < LineasOrden.Count)
                {
                    var lineaSeleccionada = LineasOrden[indexReal];

                    if (e.CommandName == "VerLinea")
                    {
                        Session["LineaSeleccionada"] = lineaSeleccionada;
                        Session["ModoLinea"] = "ver";
                        Response.Redirect("~/AnnadirLineaDeLaCompra.aspx");
                    }
                    else if (e.CommandName == "EditarLinea")
                    {
                        Session["LineaSeleccionada"] = lineaSeleccionada;
                        Session["ModoLinea"] = "modificar";
                        Session["IndiceLineaEditar"] = indexReal;
                        Response.Redirect("~/AnnadirLineaDeLaCompra.aspx");
                    }
                    else if (e.CommandName == "EliminarLinea")
                    {
                        LineasOrden.RemoveAt(indexReal);
                        CargarLineasOrden();
                        MostrarMensaje("Línea eliminada correctamente.", "exito");
                    }
                }
                else
                {
                    MostrarMensaje("Error: No se pudo encontrar la línea seleccionada.", "error");
                }
            }
        }

        // 🔹 MÉTODO PARA OBTENER EL ÍNDICE REAL CONSIDERANDO PAGINACIÓN
        protected int ObtenerIndiceReal(int rowIndex)
        {
            int pageSize = dgvOrdenDetalle.PageSize;
            int pageIndex = dgvOrdenDetalle.PageIndex;
            return (pageIndex * pageSize) + rowIndex;
        }

        // 🔹 MÉTODO MODIFICADO: Configurar botones de acción en el GridView
        protected void dgvOrdenDetalle_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Verificar si es la fila de "No hay líneas"
                if (LineasOrden.Count == 0)
                {
                    // Ocultar botones de acción si no hay líneas
                    var actionCell = e.Row.Cells[e.Row.Cells.Count - 1]; // Última celda (Acciones)
                    actionCell.Visible = false;
                }
                else
                {
                    // Configurar botones para líneas reales
                    var btnVer = (LinkButton)e.Row.FindControl("btnVerLinea");
                    var btnEditar = (LinkButton)e.Row.FindControl("btnEditarLinea");
                    var btnEliminar = (LinkButton)e.Row.FindControl("btnEliminarLinea");

                    if (btnVer != null) btnVer.CommandArgument = e.Row.RowIndex.ToString();
                    if (btnEditar != null) btnEditar.CommandArgument = e.Row.RowIndex.ToString();
                    if (btnEliminar != null) btnEliminar.CommandArgument = e.Row.RowIndex.ToString();

                    // 🔹 NUEVO: Deshabilitar botones de editar/eliminar en modo "ver"
                    string modo = Session["ModoOrden"] as string;
                    if (modo == "ver")
                    {
                        if (btnEditar != null)
                        {
                            btnEditar.Enabled = false;
                            btnEditar.CssClass = "btn btn-sm btn-outline-secondary";
                            btnEditar.ToolTip = "No disponible en modo visualización";
                        }
                        if (btnEliminar != null)
                        {
                            btnEliminar.Enabled = false;
                            btnEliminar.CssClass = "btn btn-sm btn-outline-secondary";
                            btnEliminar.ToolTip = "No disponible en modo visualización";
                        }
                        // El botón Ver sigue habilitado
                        if (btnVer != null)
                        {
                            btnVer.Enabled = true;
                            btnVer.CssClass = "btn btn-sm btn-outline-success";
                        }
                    }
                }
            }
        }

        protected void dgvOrdenDetalle_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvOrdenDetalle.PageIndex = e.NewPageIndex;
            CargarLineasOrden();
        }

        // 🔹 MÉTODO PARA OBTENER NOMBRE DE PRENDA POR ID - CORREGIDO
        private string ObtenerNombrePrenda(int idPrenda)
        {
            try
            {
                // Buscar en todos los tipos de prenda
                string[] tipos = { "Blusa", "Casaca", "Falda", "Gorro", "Pantalon", "Polo", "Vestido" };

                foreach (string tipo in tipos)
                {
                    var prenda = BuscarPrendaPorId(idPrenda, tipo);
                    if (prenda != null)
                        return prenda.Nombre;
                }
                return null;
            }
            catch
            {
                return null;
            }
        }

        private PrendaViewModel BuscarPrendaPorId(int idPrenda, string tipoPrenda)
        {
            try
            {
                switch (tipoPrenda)
                {
                    case "Blusa":
                        var blusaWS = new PackagePrendas.BlusaWSClient();
                        var blusa = blusaWS.obtenerBlusaPorId(idPrenda);
                        return blusa != null ? new PrendaViewModel
                        {
                            Id = blusa.idPrenda,
                            Nombre = blusa.nombre
                        } : null;
                    case "Casaca":
                        var casacaWS = new PackagePrendas.CasacaWSClient();
                        var casaca = casacaWS.obtenerCasacaPorId(idPrenda);
                        return casaca != null ? new PrendaViewModel { Id = casaca.idPrenda, Nombre = casaca.nombre } : null;
                    case "Falda":
                        var faldaWS = new PackagePrendas.FaldaWSClient();
                        var falda = faldaWS.obtenerFaldaPorId(idPrenda);
                        return falda != null ? new PrendaViewModel { Id = falda.idPrenda, Nombre = falda.nombre } : null;
                    case "Gorro":
                        var gorroWS = new PackagePrendas.GorroWSClient();
                        var gorro = gorroWS.obtenerGorroPorId(idPrenda);
                        return gorro != null ? new PrendaViewModel { Id = gorro.idPrenda, Nombre = gorro.nombre } : null;
                    case "Pantalon":
                        var pantalonWS = new PackagePrendas.PantalonWSClient();
                        var pantalon = pantalonWS.obtenerPantalonPorId(idPrenda);
                        return pantalon != null ? new PrendaViewModel { Id = pantalon.idPrenda, Nombre = pantalon.nombre } : null;
                    case "Polo":
                        var poloWS = new PackagePrendas.PoloWSClient();
                        var polo = poloWS.obtenerPoloPorId(idPrenda);
                        return polo != null ? new PrendaViewModel { Id = polo.idPrenda, Nombre = polo.nombre } : null;
                    case "Vestido":
                        var vestidoWS = new PackagePrendas.VestidoWSClient();
                        var vestido = vestidoWS.obtenerVestidoPorId(idPrenda);
                        return vestido != null ? new PrendaViewModel { Id = vestido.idPrenda, Nombre = vestido.nombre } : null;
                    default:
                        return null;
                }
            }
            catch
            {
                return null;
            }
        }

        private void MostrarMensaje(string mensaje, string tipo = "info")
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }
    }

    // 🔹 CLASE VIEWMODEL PARA PRENDAS
}