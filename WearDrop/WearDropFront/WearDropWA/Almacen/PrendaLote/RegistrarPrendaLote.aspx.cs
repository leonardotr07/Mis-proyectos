using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using WearDropWA.PackagePrendas;

namespace WearDropWA
{
    public partial class RegistrarPrendaLote : System.Web.UI.Page
    {
        private int idAlmacen;
        private int id_Lote;
        private PrendaLoteWSClient wsClient;
        private JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

        protected void Page_Load(object sender, EventArgs e)
        {
            wsClient = new PrendaLoteWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null && Request.QueryString["idLote"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    id_Lote = Convert.ToInt32(Request.QueryString["idLote"]);

                    ViewState["IdAlmacen"] = idAlmacen;
                    ViewState["IdLote"] = id_Lote;
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                    return;
                }

                CargarCombos();
                CargarTallas();
                pnlSearchError.CssClass = "search-error";
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
                id_Lote = (int)ViewState["IdLote"];
                if (ViewState["IdPrendaEncontrada"] != null)
                {
                    txtIdPrenda.Text = ViewState["IdPrendaEncontrada"].ToString();
                }
            }
        }
        private void CargarTallas()
        {
            ddlTalla.Items.Clear();
            ddlTalla.Items.Add(new ListItem("-- Seleccione talla --", ""));
            ddlTalla.Items.Add(new ListItem("XS", "XS"));
            ddlTalla.Items.Add(new ListItem("S", "S"));
            ddlTalla.Items.Add(new ListItem("M", "M"));
            ddlTalla.Items.Add(new ListItem("L", "L"));
            ddlTalla.Items.Add(new ListItem("XL", "XL"));
            ddlTalla.Items.Add(new ListItem("XXL", "XXL"));
        }
        private void CargarCombos()
        {
            CargarNombres();
            CargarColores();
            CargarMateriales();
        }

        private void CargarNombres()
        {
            try
            {
                string[] nombres = wsClient.listarNombresDistintos();
                ddlNombrePrenda.Items.Clear();
                ddlNombrePrenda.Items.Add(new ListItem("-- Seleccione nombre --", ""));

                if (nombres != null && nombres.Length > 0)
                {
                    foreach (string nombre in nombres)
                    {
                        ddlNombrePrenda.Items.Add(new ListItem(nombre, nombre));
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error al cargar nombres: {ex.Message}');", true);
            }
        }

        private void CargarColores()
        {
            try
            {
                string[] colores = wsClient.listarColoresDistintos();
                ddlColorPrenda.Items.Clear();
                ddlColorPrenda.Items.Add(new ListItem("-- Seleccione color --", ""));

                if (colores != null && colores.Length > 0)
                {
                    foreach (string color in colores)
                    {
                        ddlColorPrenda.Items.Add(new ListItem(color, color));
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error al cargar colores: {ex.Message}');", true);
            }
        }

        private void CargarMateriales()
        {
            try
            {
                string[] materiales = wsClient.listarMaterialesDistintos();
                ddlMaterialPrenda.Items.Clear();
                ddlMaterialPrenda.Items.Add(new ListItem("-- Seleccione material --", ""));

                if (materiales != null && materiales.Length > 0)
                {
                    foreach (string material in materiales)
                    {
                        string textoMaterial = ConvertirMaterialATexto(material);
                        ddlMaterialPrenda.Items.Add(new ListItem(textoMaterial, material));
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error al cargar materiales: {ex.Message}');", true);
            }
        }

        private string ConvertirMaterialATexto(string material)
        {
            switch (material)
            {
                case "Algodon": return "Algodón";
                case "Poliester": return "Poliéster";
                case "Mezcla_algodon_poliester": return "Mezcla Algodón-Poliéster";
                case "Viscosa_rayon": return "Viscosa-Rayón";
                case "Elastano_lycra": return "Elastano-Lycra";
                case "Acrilico": return "Acrílico";
                case "Saten": return "Satén";
                case "Chifon": return "Chifón";
                default: return material;
            }
        }

        protected void lkBuscar_Click(object sender, EventArgs e)
        {
            // LIMPIAR ViewState y controles ANTES de buscar
            ViewState["IdPrendaEncontrada"] = null;

            pnlSearchError.CssClass = "search-error";

            string idPrenda = txtIdPrenda.Text.Trim();
            string nombre = ddlNombrePrenda.SelectedValue;
            string color = ddlColorPrenda.SelectedValue;
            string material = ddlMaterialPrenda.SelectedValue;

            bool buscaPorId = !string.IsNullOrEmpty(idPrenda);
            bool buscaPorCampos = !string.IsNullOrEmpty(nombre) ||
                                  !string.IsNullOrEmpty(color) ||
                                  !string.IsNullOrEmpty(material);

            if (buscaPorId && buscaPorCampos)
            {
                lblSearchError.Text = "Debe buscar SOLO por ID o SOLO por los otros campos";
                pnlSearchError.CssClass = "search-error show";
                LimpiarCamposBusqueda(); // Limpiar también en caso de error
                return;
            }

            if (!buscaPorId && !buscaPorCampos)
            {
                lblSearchError.Text = "Debe ingresar al menos un criterio de búsqueda";
                pnlSearchError.CssClass = "search-error show";
                return;
            }

            bool encontrado = false;

            if (buscaPorId)
            {
                LimpiarDropdowns();
                encontrado = BuscarPorId(idPrenda);
            }
            else
            {
                if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(color) || string.IsNullOrEmpty(material))
                {
                    lblSearchError.Text = "Para buscar por campos debe completar: Nombre, Color y Material";
                    pnlSearchError.CssClass = "search-error show";
                    return;
                }
                // Limpiar el ID antes de buscar por campos
                txtIdPrenda.Text = "";
                encontrado = BuscarPorCampos(nombre, color, material);
            }

            // Solo mostrar error si NO se encontró
            if (!encontrado)
            {
                lblSearchError.Text = "No se encontró ninguna prenda con los criterios especificados";
                pnlSearchError.CssClass = "search-error show";
                LimpiarCamposBusqueda(); // Limpiar si no se encontró nada
            }
            else
            {
                // OCULTAR el mensaje si se encontró la prenda
                pnlSearchError.CssClass = "search-error";
            }
        }
        

        // Nuevo método para limpiar todos los campos de búsqueda
        private void LimpiarCamposBusqueda()
        {
            txtIdPrenda.Text = "";
            ViewState["IdPrendaEncontrada"] = null;
            LimpiarDropdowns();
        }

        // Nuevo método para limpiar los dropdowns
        private void LimpiarDropdowns()
        {
            ddlNombrePrenda.SelectedIndex = 0;
            ddlColorPrenda.SelectedIndex = 0;
            ddlMaterialPrenda.SelectedIndex = 0;

            // Actualizar Select2 para reflejar la limpieza
            string script = $@"
        setTimeout(function() {{
            try {{
                $('#{ddlNombrePrenda.ClientID}').val('').trigger('change');
                $('#{ddlColorPrenda.ClientID}').val('').trigger('change');
                $('#{ddlMaterialPrenda.ClientID}').val('').trigger('change');
            }} catch(e) {{
                console.error('Error limpiando Select2:', e);
            }}
        }}, 100);
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "ClearSelect2", script, true);
        }

        private bool BuscarPorId(string idPrenda)
        {
            try
            {
                int id = Convert.ToInt32(idPrenda);

                ScriptManager.RegisterStartupScript(this, GetType(), "debugInit",
                    $"console.log('=== BUSCANDO PRENDA ID: {id} ===');", true);

                // BUSCAR EN TODOS LOS TIPOS
                polo prendaEncontrada = BuscarEnTodosLosTipos(id);

                if (prendaEncontrada != null)
                {
                    string poloData = jsSerializer.Serialize(new
                    {
                        idPrenda = prendaEncontrada.idPrenda,
                        nombre = prendaEncontrada.nombre,
                        color = prendaEncontrada.color,
                        material = prendaEncontrada.material.ToString(),
                        activo = prendaEncontrada.activo
                    });

                    ScriptManager.RegisterStartupScript(this, GetType(), "debugPolo",
                        $"console.log('Prenda encontrada:', {poloData});", true);

                    // GUARDAR EN VIEWSTATE
                    ViewState["IdPrendaEncontrada"] = prendaEncontrada.idPrenda;

                    AgregarYSeleccionarValor(ddlNombrePrenda, prendaEncontrada.nombre);
                    AgregarYSeleccionarValor(ddlColorPrenda, prendaEncontrada.color);
                    AgregarYSeleccionarValor(ddlMaterialPrenda, prendaEncontrada.material.ToString());

                    ActualizarSelect2();

                    return true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugNull",
                        "console.log('Prenda no encontrada en ningún tipo');", true);
                    return false;
                }
            }
            catch (Exception ex)
            {
                lblSearchError.Text = "Error: " + ex.Message;
                pnlSearchError.CssClass = "search-error show";
                return false;
            }
        }


        private polo BuscarEnTodosLosTipos(int id)
        {
            // 1. Intentar Polo
            try
            {
                PoloWSClient poloWS = new PoloWSClient();
                polo p = poloWS.obtenerPoloPorId(id);
                poloWS.Close();

                if (p != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Polo');", true);
                    return p;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugPolo",
                    $"console.log('No es Polo: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 2. Intentar Blusa
            try
            {
                BlusaWSClient blusaWS = new BlusaWSClient();
                blusa b = blusaWS.obtenerBlusaPorId(id);
                blusaWS.Close();

                if (b != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Blusa');", true);

                    // Convertir a polo (como contenedor genérico)
                    return new polo
                    {
                        idPrenda = b.idPrenda,
                        nombre = b.nombre,
                        color = b.color,
                        material = b.material,
                        precioUnidad = b.precioUnidad,
                        precioMayor = b.precioMayor,
                        precioDocena = b.precioDocena,
                        stockPrenda = b.stockPrenda,
                        alertaMinStock = b.alertaMinStock,
                        activo = b.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugBlusa",
                    $"console.log('No es Blusa: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 3. Intentar Vestido
            try
            {
                VestidoWSClient vestidoWS = new VestidoWSClient();
                vestido v = vestidoWS.obtenerVestidoPorId(id);
                vestidoWS.Close();

                if (v != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Vestido');", true);

                    return new polo
                    {
                        idPrenda = v.idPrenda,
                        nombre = v.nombre,
                        color = v.color,
                        material = v.material,
                        precioUnidad = v.precioUnidad,
                        precioMayor = v.precioMayor,
                        precioDocena = v.precioDocena,
                        stockPrenda = v.stockPrenda,
                        alertaMinStock = v.alertaMinStock,
                        activo = v.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugVestido",
                    $"console.log('No es Vestido: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 4. Intentar Falda
            try
            {
                FaldaWSClient faldaWS = new FaldaWSClient();
                falda f = faldaWS.obtenerFaldaPorId(id);
                faldaWS.Close();

                if (f != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Falda');", true);

                    return new polo
                    {
                        idPrenda = f.idPrenda,
                        nombre = f.nombre,
                        color = f.color,
                        material = f.material,
                        precioUnidad = f.precioUnidad,
                        precioMayor = f.precioMayor,
                        precioDocena = f.precioDocena,
                        stockPrenda = f.stockPrenda,
                        alertaMinStock = f.alertaMinStock,
                        activo = f.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugFalda",
                    $"console.log('No es Falda: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 5. Intentar Pantalon ✅
            try
            {
                PantalonWSClient pantalonWS = new PantalonWSClient();
                pantalon p = pantalonWS.obtenerPantalonPorId(id);
                pantalonWS.Close();

                if (p != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Pantalon');", true);

                    return new polo
                    {
                        idPrenda = p.idPrenda,
                        nombre = p.nombre,
                        color = p.color,
                        material = p.material,
                        precioUnidad = p.precioUnidad,
                        precioMayor = p.precioMayor,
                        precioDocena = p.precioDocena,
                        stockPrenda = p.stockPrenda,
                        alertaMinStock = p.alertaMinStock,
                        activo = p.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugPantalon",
                    $"console.log('No es Pantalon: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 6. Intentar Casaca
            try
            {
                CasacaWSClient casacaWS = new CasacaWSClient();
                casaca c = casacaWS.obtenerCasacaPorId(id);
                casacaWS.Close();

                if (c != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('Encontrado como Casaca');", true);

                    return new polo
                    {
                        idPrenda = c.idPrenda,
                        nombre = c.nombre,
                        color = c.color,
                        material = c.material,
                        precioUnidad = c.precioUnidad,
                        precioMayor = c.precioMayor,
                        precioDocena = c.precioDocena,
                        stockPrenda = c.stockPrenda,
                        alertaMinStock = c.alertaMinStock,
                        activo = c.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugCasaca",
                    $"console.log('No es Casaca: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 7. Intentar Gorro
            try
            {
                GorroWSClient gorroWS = new GorroWSClient();
                gorro g = gorroWS.obtenerGorroPorId(id);
                gorroWS.Close();

                if (g != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "debugTipo",
                        "console.log('✅ Encontrado como Gorro');", true);

                    return new polo
                    {
                        idPrenda = g.idPrenda,
                        nombre = g.nombre,
                        color = g.color,
                        material = g.material,
                        precioUnidad = g.precioUnidad,
                        precioMayor = g.precioMayor,
                        precioDocena = g.precioDocena,
                        stockPrenda = g.stockPrenda,
                        alertaMinStock = g.alertaMinStock,
                        activo = g.activo
                    };
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugGorro",
                    $"console.log('No es Gorro: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // No se encontró en ningún tipo
            return null;
        }


        private void ActualizarSelect2()
        {
            string nombreJson = jsSerializer.Serialize(ddlNombrePrenda.SelectedValue ?? "");
            string colorJson = jsSerializer.Serialize(ddlColorPrenda.SelectedValue ?? "");
            string materialJson = jsSerializer.Serialize(ddlMaterialPrenda.SelectedValue ?? "");

            //Debug
            string script = $@"
                setTimeout(function() {{
                    try {{
                        console.log('Actualizando Select2...');
                        
                        $('#{ddlNombrePrenda.ClientID}').val({nombreJson}).trigger('change');
                        $('#{ddlColorPrenda.ClientID}').val({colorJson}).trigger('change');
                        $('#{ddlMaterialPrenda.ClientID}').val({materialJson}).trigger('change');
                        
                        console.log('Select2 actualizado');
                    }} catch(e) {{
                        console.error('Error:', e);
                    }}
                }}, 200);
            ";

            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateSelect2", script, true);
        }

        private void AgregarYSeleccionarValor(DropDownList ddl, string valor)
        {
            if (ddl == null || string.IsNullOrEmpty(valor)) return;

            ListItem item = ddl.Items.FindByValue(valor);

            if (item == null)
            {
                string textoVisible = valor;

                if (ddl.ID == ddlMaterialPrenda.ID)
                {
                    textoVisible = ConvertirMaterialATexto(valor);
                }

                ddl.Items.Add(new ListItem(textoVisible, valor));
            }

            ddl.SelectedValue = valor;
        }

        private bool BuscarPorCampos(string nombre, string color, string material)
        {
            try
            {
                // ✅ BUSCAR EN TODOS LOS TIPOS usando los WS específicos
                polo prendaEncontrada = BuscarPorAtributosEnTodosLosTipos(nombre, color, material);

                if (prendaEncontrada != null && prendaEncontrada.activo)
                {
                    string poloData = jsSerializer.Serialize(new
                    {
                        idPrenda = prendaEncontrada.idPrenda,
                        nombre = prendaEncontrada.nombre,
                        color = prendaEncontrada.color,
                        material = prendaEncontrada.material.ToString(),
                        activo = prendaEncontrada.activo
                    });

                    ScriptManager.RegisterStartupScript(this, GetType(), "debugCampos",
                        $"console.log('Prenda encontrada por campos:', {poloData});", true);

                    ViewState["IdPrendaEncontrada"] = prendaEncontrada.idPrenda;

                    //MOSTRAR EL ID EN LA CAJA DE TEXTO
                    txtIdPrenda.Text = prendaEncontrada.idPrenda.ToString();

                    // Autocompletar campos (por si falta alguno)
                    AgregarYSeleccionarValor(ddlNombrePrenda, prendaEncontrada.nombre);
                    AgregarYSeleccionarValor(ddlColorPrenda, prendaEncontrada.color);
                    AgregarYSeleccionarValor(ddlMaterialPrenda, prendaEncontrada.material.ToString());

                    ActualizarSelect2();

                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                string errorMsg = jsSerializer.Serialize(ex.Message);
                ScriptManager.RegisterStartupScript(this, GetType(), "debugErrorCampos",
                    $"console.error('Error buscando por campos:', {errorMsg});", true);
                return false;
            }
        }

        /// <summary>
        /// Buscar por nombre, color y material en todos los tipos de prendas
        /// </summary>
        private polo BuscarPorAtributosEnTodosLosTipos(string nombre, string color, string material)
        {
            // 1. Intentar Polo
            try
            {
                PoloWSClient poloWS = new PoloWSClient();
                polo[] polos = poloWS.listarPolos();
                poloWS.Close();

                if (polos != null)
                {
                    var encontrado = polos.FirstOrDefault(p =>
                        p.nombre == nombre &&
                        p.color == color &&
                        p.material.ToString() == material &&
                        p.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Polo');", true);
                        return encontrado;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugPoloCampos",
                    $"console.log('No es Polo: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 2. Intentar Blusa
            try
            {
                BlusaWSClient blusaWS = new BlusaWSClient();
                blusa[] blusas = blusaWS.listarBlusas();
                blusaWS.Close();

                if (blusas != null)
                {
                    var encontrado = blusas.FirstOrDefault(b =>
                        b.nombre == nombre &&
                        b.color == color &&
                        b.material.ToString() == material &&
                        b.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('✅ Encontrado como Blusa');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugBlusaCampos",
                    $"console.log('No es Blusa: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 3. Intentar Vestido
            try
            {
                VestidoWSClient vestidoWS = new VestidoWSClient();
                vestido[] vestidos = vestidoWS.listarVestidos();
                vestidoWS.Close();

                if (vestidos != null)
                {
                    var encontrado = vestidos.FirstOrDefault(v =>
                        v.nombre == nombre &&
                        v.color == color &&
                        v.material.ToString() == material &&
                        v.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Vestido');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugVestidoCampos",
                    $"console.log('No es Vestido: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 4. Intentar Falda
            try
            {
                FaldaWSClient faldaWS = new FaldaWSClient();
                falda[] faldas = faldaWS.listarFaldas();
                faldaWS.Close();

                if (faldas != null)
                {
                    var encontrado = faldas.FirstOrDefault(f =>
                        f.nombre == nombre &&
                        f.color == color &&
                        f.material.ToString() == material &&
                        f.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Falda');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugFaldaCampos",
                    $"console.log('No es Falda: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 5. Intentar Pantalon
            try
            {
                PantalonWSClient pantalonWS = new PantalonWSClient();
                pantalon[] pantalones = pantalonWS.listarPantalones();
                pantalonWS.Close();

                if (pantalones != null)
                {
                    var encontrado = pantalones.FirstOrDefault(p =>
                        p.nombre == nombre &&
                        p.color == color &&
                        p.material.ToString() == material &&
                        p.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Pantalon');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugPantalonCampos",
                    $"console.log('No es Pantalon: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 6. Intentar Casaca
            try
            {
                CasacaWSClient casacaWS = new CasacaWSClient();
                casaca[] casacas = casacaWS.listarCasacas();
                casacaWS.Close();

                if (casacas != null)
                {
                    var encontrado = casacas.FirstOrDefault(c =>
                        c.nombre == nombre &&
                        c.color == color &&
                        c.material.ToString() == material &&
                        c.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Casaca');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugCasacaCampos",
                    $"console.log('No es Casaca: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            // 7. Intentar Gorro
            try
            {
                GorroWSClient gorroWS = new GorroWSClient();
                gorro[] gorros = gorroWS.listarGorros();
                gorroWS.Close();

                if (gorros != null)
                {
                    var encontrado = gorros.FirstOrDefault(g =>
                        g.nombre == nombre &&
                        g.color == color &&
                        g.material.ToString() == material &&
                        g.activo);

                    if (encontrado != null)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "debugTipoCampos",
                            "console.log('Encontrado como Gorro');", true);

                        return new polo
                        {
                            idPrenda = encontrado.idPrenda,
                            nombre = encontrado.nombre,
                            color = encontrado.color,
                            material = encontrado.material,
                            precioUnidad = encontrado.precioUnidad,
                            precioMayor = encontrado.precioMayor,
                            precioDocena = encontrado.precioDocena,
                            stockPrenda = encontrado.stockPrenda,
                            alertaMinStock = encontrado.alertaMinStock,
                            activo = encontrado.activo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "debugGorroCampos",
                    $"console.log('No es Gorro: {jsSerializer.Serialize(ex.Message)}');", true);
            }

            return null;
        }



        protected void lkAgregar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (string.IsNullOrEmpty(ddlNombrePrenda.SelectedValue) ||
                string.IsNullOrEmpty(ddlColorPrenda.SelectedValue) ||
                string.IsNullOrEmpty(ddlMaterialPrenda.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Debe buscar una prenda primero');", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlTalla.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Debe seleccionar una talla');", true);
                return;
            }

            try
            {
                string nombre = ddlNombrePrenda.SelectedValue;
                string color = ddlColorPrenda.SelectedValue;
                string materialStr = ddlMaterialPrenda.SelectedValue;
                string tallaStr = ddlTalla.SelectedValue;
                int stock = Convert.ToInt32(txtStock.Text);

                polo prendaEncontrada = BuscarPorAtributosEnTodosLosTipos(nombre, color, materialStr);

                if (prendaEncontrada == null || !prendaEncontrada.activo)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró la prenda');", true);
                    return;
                }

                talla tallaEnum;
                if (!Enum.TryParse<talla>(tallaStr, out tallaEnum))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Talla inválida');", true);
                    return;
                }

                bool yaExiste = wsClient.existePrendaTallaEnLote(prendaEncontrada.idPrenda, tallaStr, id_Lote);

                if (yaExiste)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Esta prenda con esta talla ya existe en este lote');", true);
                    return;
                }

                prendaLote nuevaPrendaLote = new prendaLote
                {
                    idPrenda = prendaEncontrada.idPrenda,
                    idLote = id_Lote,
                    talla = tallaEnum,
                    tallaSpecified = true,
                    stock = stock,
                    activo = true
                };

                int resultado = wsClient.insertarPrendaLote(nuevaPrendaLote);

                if (resultado > 0)
                {
                    // REDIRIGIR A MODIFICAR LOTE
                    Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={id_Lote}&idAlmacen={idAlmacen}&msg=prendaAgregada");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Error al guardar la prenda');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }
        }




        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={id_Lote}&idAlmacen={idAlmacen}");
        }

        protected override void OnUnload(EventArgs e)
        {
            if (wsClient != null)
            {
                wsClient.Close();
            }
            base.OnUnload(e);
        }
    }
}
