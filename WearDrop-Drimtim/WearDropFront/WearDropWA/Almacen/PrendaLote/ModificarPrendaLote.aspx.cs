using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackagePrendas;

namespace WearDropWA
{
    public partial class ModificarPrendaLote : System.Web.UI.Page
    {
        private int idAlmacen;
        private int idLote;
        private int idPrendaLote;
        private PrendaLoteWSClient wsClient;

        protected void Page_Load(object sender, EventArgs e)
        {
            wsClient = new PrendaLoteWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null &&
                    Request.QueryString["idLote"] != null &&
                    Request.QueryString["idAlmacen"] != null)
                {
                    idPrendaLote = Convert.ToInt32(Request.QueryString["id"]);
                    idLote = Convert.ToInt32(Request.QueryString["idLote"]);
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);

                    ViewState["IdPrendaLote"] = idPrendaLote;
                    ViewState["IdLote"] = idLote;
                    ViewState["IdAlmacen"] = idAlmacen;

                    CargarTallas();
                    CargarDatosPrendaLote();
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                    return;
                }
            }
            else
            {
                idPrendaLote = (int)ViewState["IdPrendaLote"];
                idLote = (int)ViewState["IdLote"];
                idAlmacen = (int)ViewState["IdAlmacen"];
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

        private void CargarDatosPrendaLote()
        {
            try
            {
                prendaLote prendaLote = wsClient.obtenerPrendaLotePorId(idPrendaLote);

                if (prendaLote != null)
                {
                    // Guardar en ViewState
                    ViewState["PrendaLoteActual"] = prendaLote;

                    // Buscar la información completa de la prenda
                    polo prendaCompleta = BuscarPrendaPorId(prendaLote.idPrenda);

                    if (prendaCompleta != null)
                    {
                        // Campos de solo lectura (información de la prenda)
                        txtIdPrenda.Text = prendaCompleta.idPrenda.ToString();
                        txtNombrePrenda.Text = prendaCompleta.nombre;
                        txtColorPrenda.Text = prendaCompleta.color;
                        txtMaterialPrenda.Text = ConvertirMaterialATexto(prendaCompleta.material.ToString());

                        // Campos editables (talla y stock)
                        ddlTalla.SelectedValue = prendaLote.talla.ToString();
                        txtStock.Text = prendaLote.stock.ToString();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('No se pudo cargar la información de la prenda');", true);
                        Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={idLote}&idAlmacen={idAlmacen}");
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Prenda no encontrada en el lote');", true);
                    Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={idLote}&idAlmacen={idAlmacen}");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar datos: {ex.Message}');", true);
            }
        }

        private polo BuscarPrendaPorId(int idPrenda)
        {
            // 1. Intentar Polo
            try
            {
                PoloWSClient poloWS = new PoloWSClient();
                polo p = poloWS.obtenerPoloPorId(idPrenda);
                poloWS.Close();
                if (p != null) return p;
            }
            catch { }

            // 2. Intentar Blusa
            try
            {
                BlusaWSClient blusaWS = new BlusaWSClient();
                blusa b = blusaWS.obtenerBlusaPorId(idPrenda);
                blusaWS.Close();

                if (b != null)
                {
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
            catch { }

            // 3. Intentar Vestido
            try
            {
                VestidoWSClient vestidoWS = new VestidoWSClient();
                vestido v = vestidoWS.obtenerVestidoPorId(idPrenda);
                vestidoWS.Close();

                if (v != null)
                {
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
            catch { }

            // 4. Intentar Falda
            try
            {
                FaldaWSClient faldaWS = new FaldaWSClient();
                falda f = faldaWS.obtenerFaldaPorId(idPrenda);
                faldaWS.Close();

                if (f != null)
                {
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
            catch { }

            // 5. Intentar Pantalon
            try
            {
                PantalonWSClient pantalonWS = new PantalonWSClient();
                pantalon p = pantalonWS.obtenerPantalonPorId(idPrenda);
                pantalonWS.Close();

                if (p != null)
                {
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
            catch { }

            // 6. Intentar Casaca
            try
            {
                CasacaWSClient casacaWS = new CasacaWSClient();
                casaca c = casacaWS.obtenerCasacaPorId(idPrenda);
                casacaWS.Close();

                if (c != null)
                {
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
            catch { }

            // 7. Intentar Gorro
            try
            {
                GorroWSClient gorroWS = new GorroWSClient();
                gorro g = gorroWS.obtenerGorroPorId(idPrenda);
                gorroWS.Close();

                if (g != null)
                {
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
            catch { }

            return null;
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

        protected void lkGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (string.IsNullOrEmpty(ddlTalla.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Debe seleccionar una talla');", true);
                return;
            }

            try
            {
                prendaLote prendaLoteActual = (prendaLote)ViewState["PrendaLoteActual"];

                if (prendaLoteActual == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Error: No se encontró la prenda en el lote');", true);
                    return;
                }

                // Verificar si cambió la talla y si ya existe otra prenda con esa combinación
                string nuevaTalla = ddlTalla.SelectedValue;
                if (prendaLoteActual.talla.ToString() != nuevaTalla)
                {
                    bool yaExiste = wsClient.existePrendaTallaEnLote(
                        prendaLoteActual.idPrenda,
                        nuevaTalla,
                        idLote
                    );

                    if (yaExiste)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('Ya existe esta prenda con esta talla en el lote');", true);
                        return;
                    }
                }

                // Actualizar solo los campos modificables
                talla tallaEnum;
                if (!Enum.TryParse<talla>(nuevaTalla, out tallaEnum))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Talla inválida');", true);
                    return;
                }

                prendaLoteActual.talla = tallaEnum;
                prendaLoteActual.tallaSpecified = true;
                prendaLoteActual.stock = Convert.ToInt32(txtStock.Text);

                int resultado = wsClient.modificarPrendaLote(prendaLoteActual);

                if (resultado > 0)
                {
                    Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={idLote}&idAlmacen={idAlmacen}&msg=prendaModificada");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Error al modificar la prenda en el lote');", true);
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
            Response.Redirect($"~/Almacen/Lote/ModificarLote.aspx?id={idLote}&idAlmacen={idAlmacen}");
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