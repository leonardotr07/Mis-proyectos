using System;
using System.ComponentModel; // BindingList
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PackagePrendas;

namespace WearDropWA
{
    public partial class ListarPrendas : System.Web.UI.Page
    {
        private BindingList<object> prendas;

        string Tipo => (Request["tipo"] ?? "Polos").Trim();
        string TipoLower => (Request["tipo"] ?? "Polos").Trim().ToLowerInvariant();

        private bool EstaFiltrado
        {
            get { return (bool?)ViewState["FiltradoVentas"] ?? false; }
            set { ViewState["FiltradoVentas"] = value; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            litTitulo.Text = "Gestionar " + Tipo;
            litHeader.Text = "Gestionar " + Tipo;
            themeWrap.Attributes["class"] = "theme-" + TipoLower;

            if (!IsPostBack)
            {
                EstaFiltrado = false;
                OrdenAscVentas = false;
                CargarPrendas();   // ahora sin parámetros
            }

            // Siempre actualizar el texto del botón y el label
            ActualizarUIFiltro();
        }



        private void CargarPrendas()
        {
            bool ordenarVentas = EstaFiltrado;
            bool asc = OrdenAscVentas;

            switch (TipoLower)
            {
                case "blusas":
                    {
                        var cli = new PackagePrendas.BlusaWSClient();
                        var data = cli.listarBlusas() ?? Array.Empty<PackagePrendas.blusa>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(b => b.stockPrenda).ToArray()
                                : data.OrderByDescending(b => b.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "polos":
                    {
                        var cli = new PackagePrendas.PoloWSClient();
                        var data = cli.listarPolos() ?? Array.Empty<PackagePrendas.polo>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(p => p.stockPrenda).ToArray()
                                : data.OrderByDescending(p => p.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "vestidos":
                    {
                        var cli = new PackagePrendas.VestidoWSClient();
                        var data = cli.listarVestidos() ?? Array.Empty<PackagePrendas.vestido>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(v => v.stockPrenda).ToArray()
                                : data.OrderByDescending(v => v.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "pantalones":
                    {
                        var cli = new PackagePrendas.PantalonWSClient();
                        var data = cli.listarPantalones() ?? Array.Empty<PackagePrendas.pantalon>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(p => p.stockPrenda).ToArray()
                                : data.OrderByDescending(p => p.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "casacas":
                    {
                        var cli = new PackagePrendas.CasacaWSClient();
                        var data = cli.listarCasacas() ?? Array.Empty<PackagePrendas.casaca>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(c => c.stockPrenda).ToArray()
                                : data.OrderByDescending(c => c.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "gorros":
                    {
                        var cli = new PackagePrendas.GorroWSClient();
                        var data = cli.listarGorros() ?? Array.Empty<PackagePrendas.gorro>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(g => g.stockPrenda).ToArray()
                                : data.OrderByDescending(g => g.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "faldas":
                    {
                        var cli = new PackagePrendas.FaldaWSClient();
                        var data = cli.listarFaldas() ?? Array.Empty<PackagePrendas.falda>();

                        if (ordenarVentas)
                            data = asc
                                ? data.OrderBy(f => f.stockPrenda).ToArray()
                                : data.OrderByDescending(f => f.stockPrenda).ToArray();

                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                default:
                    prendas = new BindingList<object>();
                    break;
            }

            gvPrendas.DataSource = prendas;
            gvPrendas.DataBind();
        }



        protected void gvPrendas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            string id = "";
            try { id = DataBinder.Eval(e.Row.DataItem, "IdPrenda").ToString(); }
            catch { try { id = DataBinder.Eval(e.Row.DataItem, "idPrenda").ToString(); } catch { } }
            e.Row.Cells[0].Text = id;

            string nombre = "";
            try { nombre = DataBinder.Eval(e.Row.DataItem, "Nombre").ToString(); }
            catch { try { nombre = DataBinder.Eval(e.Row.DataItem, "nombre").ToString(); } catch { } }
            e.Row.Cells[1].Text = nombre;

            string color = "";
            try { color = DataBinder.Eval(e.Row.DataItem, "Color").ToString(); }
            catch { try { color = DataBinder.Eval(e.Row.DataItem, "color").ToString(); } catch { } }
            e.Row.Cells[2].Text = color;

            string material = "";
            try { material = DataBinder.Eval(e.Row.DataItem, "Material").ToString(); }
            catch { try { material = DataBinder.Eval(e.Row.DataItem, "material").ToString(); } catch { } }
            e.Row.Cells[3].Text = material;

            string pu = "0";
            try { pu = DataBinder.Eval(e.Row.DataItem, "PrecioUnidad").ToString(); }
            catch { try { pu = DataBinder.Eval(e.Row.DataItem, "precioUnidad").ToString(); } catch { } }
            e.Row.Cells[4].Text = pu;

            string pm = "0";
            try { pm = DataBinder.Eval(e.Row.DataItem, "PrecioMayor").ToString(); }
            catch { try { pm = DataBinder.Eval(e.Row.DataItem, "precioMayor").ToString(); } catch { } }
            e.Row.Cells[5].Text = pm;

            string pd = "0";
            try { pd = DataBinder.Eval(e.Row.DataItem, "PrecioDocena").ToString(); }
            catch { try { pd = DataBinder.Eval(e.Row.DataItem, "precioDocena").ToString(); } catch { } }
            e.Row.Cells[6].Text = pd;

            // columna 7: Vendidas (stockPrenda)
            string vendidas = "0";
            try { vendidas = DataBinder.Eval(e.Row.DataItem, "StockPrenda").ToString(); }
            catch { try { vendidas = DataBinder.Eval(e.Row.DataItem, "stockPrenda").ToString(); } catch { } }
            e.Row.Cells[7].Text = vendidas;

        }

        protected void gvPrendas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPrendas.PageIndex = e.NewPageIndex;
            CargarPrendas();   // recarga respetando el estado de filtro/orden
        }



        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarPrenda.aspx?tipo=" + Tipo);
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            if (!EstaFiltrado)
            {
                // 1er clic: activar filtro en DESC
                EstaFiltrado = true;
                OrdenAscVentas = false;
            }
            else if (EstaFiltrado && !OrdenAscVentas)
            {
                // 2do clic: cambiar a ASC
                OrdenAscVentas = true;
            }
            else
            {
                // 3er clic: cancelar filtro
                EstaFiltrado = false;
                OrdenAscVentas = false;
            }

            CargarPrendas();
            ActualizarUIFiltro();
        }


        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect($"RegistrarPrenda.aspx?tipo={Tipo}&id={id}&accion=modificar");
        }

        protected void lkEliminar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            string tipo = (Request["tipo"] ?? "Polos").Trim().ToLowerInvariant();

            try
            {
                switch (tipo)
                {
                    case "polos":
                    case "polo":
                        new global::WearDropWA.PackagePrendas.PoloWSClient().eliminarPolo(id);
                        break;
                    case "blusas":
                    case "blusa":
                        new global::WearDropWA.PackagePrendas.BlusaWSClient().eliminarBlusa(id);
                        break;
                    case "vestidos":
                    case "vestido":
                        new global::WearDropWA.PackagePrendas.VestidoWSClient().eliminarVestido(id);
                        break;
                    case "pantalones":
                    case "pantalon":
                        new global::WearDropWA.PackagePrendas.PantalonWSClient().eliminarPantalon(id);
                        break;
                    case "casacas":
                    case "casaca":
                        new global::WearDropWA.PackagePrendas.CasacaWSClient().eliminarCasaca(id);
                        break;
                    case "gorros":
                    case "gorro":
                        new global::WearDropWA.PackagePrendas.GorroWSClient().eliminarGorro(id);
                        break;
                    case "faldas":
                    case "falda":
                        new global::WearDropWA.PackagePrendas.FaldaWSClient().eliminarFalda(id);
                        break;
                    default:
                        throw new InvalidOperationException("Tipo no reconocido.");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "errDel",
                    $"alert('Error al eliminar: {ex.Message.Replace("'", "\\'")}');",
                    true
                );
            }

            Response.Redirect($"ListarPrendas.aspx?tipo={(Request["tipo"] ?? "Polos")}");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect($"RegistrarPrenda.aspx?tipo={Tipo}&id={id}&accion=ver");
        }
        private bool OrdenAscVentas
        {
            get { return (bool?)ViewState["OrdenAscVentas"] ?? false; }
            set { ViewState["OrdenAscVentas"] = value; }
        }

        private void ActualizarUIFiltro()
        {
            if (!EstaFiltrado)
            {
                lkFiltrar.Text = "Ordenar por ventas";
                lkFiltrar.ToolTip = "Ordenar por cantidad vendida";
                lblFiltroVentas.Visible = false;
            }
            else
            {
                lblFiltroVentas.Visible = true;

                if (OrdenAscVentas)
                {
                    lkFiltrar.Text = "Ventas ↑ (quitar filtro)";
                    lkFiltrar.ToolTip = "Quitar orden por ventas";
                    lblFiltroVentas.Text = "Ordenado por ventas (ascendente)";
                }
                else
                {
                    lkFiltrar.Text = "Ventas ↓ (cambiar a ascendente)";
                    lkFiltrar.ToolTip = "Cambiar a orden ascendente";
                    lblFiltroVentas.Text = "Ordenado por ventas (descendente)";
                }
            }
        }


    }
}