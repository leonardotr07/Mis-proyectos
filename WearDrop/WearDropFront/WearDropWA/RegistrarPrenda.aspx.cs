using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.DescuentoLiquidacionWS;
using WearDropWA.DescuentoMontoWS;
using WearDropWA.DescuentoPorcentajeWS;
using WearDropWA.PackagePrendas;
using WearDropWA.PromocionComboWS;
using WearDropWA.PromocionConjunto;

namespace WearDropWA
{
    public enum Estado { Nuevo, Modificar, Ver }

    public partial class RegistrarPrenda : System.Web.UI.Page
    {
        private Estado estado;
        private string Tipo => (Request["tipo"] ?? "Polos").Trim();
        private string IdQS => (Request["id"] ?? "").Trim();
        private int Id => int.TryParse(IdQS, out var n) ? n : 0;
        private DescuentoPorcentajeWSClient boDesc;
        private BindingList<descuentoPorcentaje> descuentos;
        private PromocionConjuntoWSClient boProm;
        private BindingList<promocionConjunto> promociones;
        private DescuentoMontoWSClient boDesc1;
        private BindingList<descuentoMonto> descuentos1;
        private DescuentoLiquidacionWSClient boDesc2;
        private BindingList<DescuentoLiquidacionWS.descuentoLiquidacion> descuentos2;
        private PromocionComboWSClient boProm2;
        private BindingList<promocionCombo> promociones2;
        protected void Page_Load(object sender, EventArgs e)
        {
            boDesc = new DescuentoPorcentajeWSClient();
            boDesc1 = new DescuentoMontoWSClient();
            boDesc2 = new DescuentoLiquidacionWSClient();
            boProm = new PromocionConjuntoWSClient();
            boProm2 = new PromocionComboWSClient();
            string accion = (Request.QueryString["accion"] ?? "").Trim().ToLower();

            if (accion == "ver") estado = Estado.Ver;
            else if (accion == "modificar") estado = Estado.Modificar;
            else estado = Estado.Nuevo;

            if (IsPostBack) return;

            ConfigurarCabecera();
            MostrarPanelPorTipo();
            CargarCombosGenerales();
            CargarCombosEspecificosPorTipo();
          

            if (estado == Estado.Modificar || estado == Estado.Ver)
            {
                AsignarValores();
                txtId.Enabled = false;
            }
            if (estado == Estado.Ver) BloquearEdicion();

            if (estado == Estado.Modificar || estado == Estado.Ver)
            {
                AsignarValores();
                txtId.Enabled = false;
            }
            if (estado == Estado.Ver)
            {
                CargarDescuentos(Id);  // Cargar los descuentos al inicializar la página
                CargarPromociones(Id);
                BloquearEdicion();
                CargarStockPorTallas();   // 👈 aquí se carga la tabla solo en visualizar
            }
            else
            {
                pnlStockTallas.Visible = false;
            }
            if(estado==Estado.Modificar || estado == Estado.Nuevo)
            {
                lbVerDescuentos.Visible = false;
                lbVerPromociones.Visible = false;
            }



        }
        private void CargarDescuentos(int Id)
        {
            // Estas funciones son las mismas para todas las prendas
            // Solo llamas a los BOs genéricos de descuentos

            //var monto = new DataTable();
            //monto.Columns.Add("Id");
            //monto.Columns.Add("Nombre");
            //monto.Columns.Add("Monto", typeof(decimal));
            //monto.Columns.Add("Editable");
            //monto.Columns.Add("MontoMax", typeof(decimal));
            //monto.Rows.Add("1", "Bienvenida", 10m, "Sí", 30m);
            //monto.Rows.Add("2", "Cyber", 15m, "No", 15m);
            //gvDescMonto.DataSource = monto;
            //gvDescMonto.DataBind();

            //var porc = new DataTable();
            //porc.Columns.Add("Id");
            //porc.Columns.Add("Nombre");
            //porc.Columns.Add("Porcentaje", typeof(decimal));
            //porc.Rows.Add("1", "Temporada", 0.10m);
            //porc.Rows.Add("2", "Socios", 0.08m);
            //gvDescPorc.DataSource = porc;
            //gvDescPorc.DataBind();

            //var liq = new DataTable();
            //liq.Columns.Add("Id");
            //liq.Columns.Add("Nombre");
            //liq.Columns.Add("Porcentaje", typeof(decimal));
            //liq.Columns.Add("StockMin", typeof(int));
            //liq.Rows.Add("1", "Fin de línea", 0.25m, 5);
            //liq.Rows.Add("2", "Últimas unidades", 0.35m, 2);
            //gvDescLiq.DataSource = liq;
            //gvDescLiq.DataBind();


            // En producción:
            // gvDescMonto.DataSource = DescuentoMontoBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvDescPorc.DataSource = DescuentoPorcentajeBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvDescLiq.DataSource = DescuentoLiquidacionBO.ListarPorPrenda(int.Parse(Id), Tipo);
            if (boDesc.mostrarPorcentajeXPrenda(Id) == null)
            {
                descuentos = new BindingList<descuentoPorcentaje>();

            }
            else
            {
                descuentos = new BindingList<descuentoPorcentaje>(boDesc.mostrarPorcentajeXPrenda(Id));
            }
            //if (descuentos == null)
            //{
            //    descuentos = new BindingList<descuentoPorcentaje>();  // Lista vacía si es null
            //}
            gvDescPorc.DataSource = descuentos;
            gvDescPorc.DataBind();
            if (boDesc1.mostrarMontoXPrenda(Id) == null)
            {
                descuentos1 = new BindingList<descuentoMonto>();  // Lista vacía si es null

            }
            else
            {
                descuentos1 = new BindingList<descuentoMonto>(boDesc1.mostrarMontoXPrenda(Id));
            }
     
            gvDescMonto.DataSource = descuentos1;
            gvDescMonto.DataBind();
            if (boDesc2.mostrarLiquidacionXPrenda(Id) == null)
            {
                descuentos2 = new BindingList<descuentoLiquidacion>();
            }
            else
            {
                descuentos2 = new BindingList<descuentoLiquidacion>(boDesc2.mostrarLiquidacionXPrenda(Id));

            }
            gvDescLiq.DataSource = descuentos2;
            gvDescLiq.DataBind();
        }

        private void CargarPromociones(int Id)
        {
            // Estas funciones son las mismas para todas las prendas
            // Solo llamas a los BOs genéricos de promociones

            //var combo = new DataTable();
            //combo.Columns.Add("Id");
            //combo.Columns.Add("Nombre");
            //combo.Columns.Add("CantGratis", typeof(int));
            //combo.Columns.Add("CantReq", typeof(int));
            //combo.Rows.Add("1", "2x1 Fin de semana", 1, 1);
            //combo.Rows.Add("2", "3x2 Alumnos", 1, 2);
            //gvPromoCombo.DataSource = combo;
            //gvPromoCombo.DataBind();

            //var conj = new DataTable();
            //conj.Columns.Add("Id");
            //conj.Columns.Add("Nombre");
            //conj.Columns.Add("Porcentaje", typeof(decimal));
            //conj.Rows.Add("1", "Set deportivo", 0.12m);
            //conj.Rows.Add("2", "Look casual", 0.15m);
            //gvPromoConjunto.DataSource = conj;
            //gvPromoConjunto.DataBind();
            if (boProm.mostrarConjuntoXPrenda(Id) == null)
            {
                promociones = new BindingList<promocionConjunto>();  // Lista vacía si es null
            }
            else
            {
                promociones = new BindingList<promocionConjunto>(boProm.mostrarConjuntoXPrenda(Id));

            }
            gvPromoConjunto.DataSource = promociones;
            gvPromoConjunto.DataBind();

            if (boProm2.mostrarComboXPrenda(Id) == null)
            {
                promociones2 = new BindingList<promocionCombo>();  // Lista vacía si es null
            }
            else
            {
                promociones2 = new BindingList<promocionCombo>(boProm2.mostrarComboXPrenda(Id));

            }
            gvPromoCombo.DataSource = promociones2;
            gvPromoCombo.DataBind();

            // En producción:
            // gvPromoCombo.DataSource = PromocionComboBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvPromoConjunto.DataSource = PromocionConjuntoBO.ListarPorPrenda(int.Parse(Id), Tipo);
        }
        // ========= UI helpers =========
        private void SetVisible(Control c, bool visible) { if (c != null) c.Visible = visible; }

        private void SetSelected(DropDownList ddl, string value)
        {
            if (ddl == null) return;
            var v = (value ?? "").Trim();
            var item = ddl.Items.FindByValue(v);
            if (item != null) ddl.SelectedValue = v;
        }

        private void ConfigurarCabecera()
        {
            string singular = ObtenerNombreSingular();
            string titulo = estado == Estado.Nuevo ? "Registrar" :
                            estado == Estado.Modificar ? "Modificar" : "Ver";

            litTitulo.Text = $"{titulo} {singular}";
            litHeader.Text = $"{titulo} {singular}";
            themeWrap.Attributes["class"] = "container theme-" + Tipo.ToLower();

            btnGuardar.Text = estado == Estado.Nuevo ? "Registrar" :
                              estado == Estado.Modificar ? "Guardar" : "Aceptar";

            SetVisible(divId, estado != Estado.Nuevo);
            if (estado != Estado.Nuevo && txtId != null) txtId.Text = IdQS;

            OcultarAsteriscos(estado != Estado.Nuevo);
        }

        private void OcultarAsteriscos(bool ocultar)
        {
            SetVisible(spanReq, !ocultar);
            SetVisible(spanReqMaterial, !ocultar);
            SetVisible(spanReqColor, !ocultar);
            SetVisible(spanReqStock, !ocultar);
            SetVisible(spanReqPU, !ocultar);
            SetVisible(spanReqPM, !ocultar);
            SetVisible(spanReqPD, !ocultar);
            SetVisible(spanReqManga, !ocultar);
            SetVisible(spanReqCuello, !ocultar);
            SetVisible(spanReqTipoBlusa, !ocultar);
            SetVisible(spanReqMangaB, !ocultar);
            SetVisible(spanReqTipoVestido, !ocultar);
            SetVisible(spanReqLargoVestido, !ocultar);
            SetVisible(spanReqTipoFalda, !ocultar);
            SetVisible(spanReqLargoFalda, !ocultar);
            SetVisible(spanReqVolantes, !ocultar);
            SetVisible(spanReqTipoPantalon, !ocultar);
            SetVisible(spanReqLargoPierna, !ocultar);
            SetVisible(spanReqTipoCasaca, !ocultar);
            SetVisible(spanReqCapucha, !ocultar);
            SetVisible(spanReqTipoGorra, !ocultar);
            SetVisible(spanReqTallaAjustable, !ocultar);
            SetVisible(spanReqImpermeable, !ocultar);
            SetVisible(spanReqMangaV, !ocultar);
            SetVisible(spanReqCintura, !ocultar);
        }

        private void MostrarPanelPorTipo()
        {
            pnlPOLO.Visible = pnlBLUSA.Visible = pnlVESTIDO.Visible =
            pnlFALDA.Visible = pnlPANTALON.Visible = pnlCASACA.Visible =
            pnlGORRO.Visible = false;

            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos": pnlPOLO.Visible = true; break;
                case "blusa":
                case "blusas": pnlBLUSA.Visible = true; break;
                case "vestido":
                case "vestidos": pnlVESTIDO.Visible = true; break;
                case "falda":
                case "faldas": pnlFALDA.Visible = true; break;
                case "pantalon":
                case "pantalones": pnlPANTALON.Visible = true; break;
                case "casaca":
                case "casacas": pnlCASACA.Visible = true; break;
                case "gorro":
                case "gorros": pnlGORRO.Visible = true; break;
            }
        }

        private void BloquearEdicion()
        {
            txtNombre.Enabled = false;
            ddlMaterial.Enabled = false;
            txtColor.Enabled = false;
            txtStock.Enabled = false;
            txtPU.Enabled = false;
            txtPM.Enabled = false;
            txtPD.Enabled = false;

            ddlTipoManga.Enabled = false;
            ddlTipoCuello.Enabled = false;
            txtEstampado.Enabled = false;

            ddlTipoBlusa.Enabled = false;
            ddlTipoMangaB.Enabled = false;

            ddlTipoVestido.Enabled = false;
            txtLargoVestido.Enabled = false;
            ddlTipoMangaV.Enabled = false;

            ddlTipoFalda.Enabled = false;
            txtLargoFalda.Enabled = false;
            ddlConVolantes.Enabled = false;

            ddlTipoPantalon.Enabled = false;
            txtLargoPierna.Enabled = false;
            txtCintura.Enabled = false;

            ddlTipoCasaca.Enabled = false;
            ddlConCapucha.Enabled = false;

            ddlTipoGorra.Enabled = false;
            ddlTallaAjustable.Enabled = false;
            ddlImpermeable.Enabled = false;

            btnGuardar.Visible = false;

        }

        // ========= COMBOS =========
        private void CargarCombosGenerales()
        {
            ddlMaterial.Items.Clear();
            ddlMaterial.Items.Add(new ListItem("-- Seleccione --", ""));

            // ✅ Usar material del PackagePrendas
            foreach (material it in Enum.GetValues(typeof(material)))
            {
                string name = Enum.GetName(typeof(material), it);
                ddlMaterial.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }
        }

        private void CargarCombosEspecificosPorTipo()
        {
            // Polo
            ddlTipoManga.Items.Clear();
            ddlTipoManga.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoManga it in Enum.GetValues(typeof(tipoManga)))
            {
                string name = Enum.GetName(typeof(tipoManga), it);
                ddlTipoManga.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoCuello.Items.Clear();
            ddlTipoCuello.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoCuello it in Enum.GetValues(typeof(tipoCuello)))
            {
                string name = Enum.GetName(typeof(tipoCuello), it);
                ddlTipoCuello.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Blusa
            ddlTipoBlusa.Items.Clear();
            ddlTipoBlusa.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoBlusa it in Enum.GetValues(typeof(tipoBlusa)))
            {
                string name = Enum.GetName(typeof(tipoBlusa), it);
                ddlTipoBlusa.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoMangaB.Items.Clear();
            ddlTipoMangaB.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoManga it in Enum.GetValues(typeof(tipoManga)))
            {
                string name = Enum.GetName(typeof(tipoManga), it);
                ddlTipoMangaB.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Vestido
            ddlTipoVestido.Items.Clear();
            ddlTipoVestido.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoVestido it in Enum.GetValues(typeof(tipoVestido)))
            {
                string name = Enum.GetName(typeof(tipoVestido), it);
                ddlTipoVestido.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoMangaV.Items.Clear();
            ddlTipoMangaV.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoManga it in Enum.GetValues(typeof(tipoManga)))
            {
                string name = Enum.GetName(typeof(tipoManga), it);
                ddlTipoMangaV.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Falda
            ddlTipoFalda.Items.Clear();
            ddlTipoFalda.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoFalda it in Enum.GetValues(typeof(tipoFalda)))
            {
                string name = Enum.GetName(typeof(tipoFalda), it);
                ddlTipoFalda.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlConVolantes.Items.Clear();
            ddlConVolantes.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlConVolantes.Items.Add(new ListItem("No", "0"));
            ddlConVolantes.Items.Add(new ListItem("Sí", "1"));

            // Pantalón
            ddlTipoPantalon.Items.Clear();
            ddlTipoPantalon.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoPantalon it in Enum.GetValues(typeof(tipoPantalon)))
            {
                string name = Enum.GetName(typeof(tipoPantalon), it);
                ddlTipoPantalon.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Casaca
            ddlTipoCasaca.Items.Clear();
            ddlTipoCasaca.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoCasaca it in Enum.GetValues(typeof(tipoCasaca)))
            {
                string name = Enum.GetName(typeof(tipoCasaca), it);
                ddlTipoCasaca.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlConCapucha.Items.Clear();
            ddlConCapucha.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlConCapucha.Items.Add(new ListItem("No", "0"));
            ddlConCapucha.Items.Add(new ListItem("Sí", "1"));

            // Gorro
            ddlTipoGorra.Items.Clear();
            ddlTipoGorra.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (tipoGorra it in Enum.GetValues(typeof(tipoGorra)))
            {
                string name = Enum.GetName(typeof(tipoGorra), it);
                ddlTipoGorra.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTallaAjustable.Items.Clear();
            ddlTallaAjustable.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlTallaAjustable.Items.Add(new ListItem("No", "0"));
            ddlTallaAjustable.Items.Add(new ListItem("Sí", "1"));

            ddlImpermeable.Items.Clear();
            ddlImpermeable.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlImpermeable.Items.Add(new ListItem("No", "0"));
            ddlImpermeable.Items.Add(new ListItem("Sí", "1"));
        }

        // ========= CARGA PARA MODIFICAR/VER =========
        private void AsignarValores()
        {
            if (Id <= 0) { MostrarError("Id inválido."); return; }

            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos":
                    {
                        var ws = new PoloWSClient();
                        var p = ws.obtenerPoloPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Polo.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoManga, p.tipoManga.ToString());
                        SetSelected(ddlTipoCuello, p.tipoCuello.ToString());
                        txtEstampado.Text = p.estampado;
                        break;
                    }
                case "blusa":
                case "blusas":
                    {
                        var ws = new BlusaWSClient();
                        var p = ws.obtenerBlusaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Blusa.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoBlusa, p.tipoBlusa.ToString());
                        SetSelected(ddlTipoMangaB, p.tipoManga.ToString());
                        break;
                    }
                case "vestido":
                case "vestidos":
                    {
                        var ws = new VestidoWSClient();
                        var p = ws.obtenerVestidoPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Vestido.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoVestido, p.tipoVestido.ToString());
                        SetSelected(ddlTipoMangaV, p.tipoManga.ToString());
                        txtLargoVestido.Text = p.largo.ToString("0.##");
                        break;
                    }
                case "falda":
                case "faldas":
                    {
                        var ws = new FaldaWSClient();
                        var p = ws.obtenerFaldaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Falda.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoFalda, p.tipoFalda.ToString());
                        txtLargoFalda.Text = p.largo.ToString("0.##");
                        SetSelected(ddlConVolantes, BoolTo10(p.conVolantes));
                        break;
                    }
                case "pantalon":
                case "pantalones":
                    {
                        var ws = new PantalonWSClient();
                        var p = ws.obtenerPantalonPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Pantalón.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoPantalon, p.tipoPantalon.ToString());
                        txtLargoPierna.Text = p.largoPierna.ToString("0.##");
                        txtCintura.Text = p.cintura.ToString("0.##");
                        break;
                    }
                case "casaca":
                case "casacas":
                    {
                        var ws = new CasacaWSClient();
                        var p = ws.obtenerCasacaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Casaca.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoCasaca, p.tipoCasaca.ToString());
                        SetSelected(ddlConCapucha, BoolTo10(p.conCapucha));
                        break;
                    }
                case "gorro":
                case "gorros":
                    {
                        var ws = new GorroWSClient();
                        var p = ws.obtenerGorroPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Gorro.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoGorra, p.tipoGorra.ToString());
                        SetSelected(ddlTallaAjustable, BoolTo10(p.tallaAjustable));
                        SetSelected(ddlImpermeable, BoolTo10(p.impermeable));
                        break;
                    }
            }
        }

        private void MapGeneralFromEntity(string nombre, string color, int alertaMinStock,
                                          double pu, double pm, double pd)
        {
            txtNombre.Text = nombre;
            txtColor.Text = color;
            txtStock.Text = alertaMinStock.ToString();
            txtPU.Text = pu.ToString("0.##");
            txtPM.Text = pm.ToString("0.##");
            txtPD.Text = pd.ToString("0.##");
        }

        // ========= GUARDAR =========
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Ejecutar validaciones del grupo "Prenda"
            Page.Validate("Prenda");

            // 2. Si hay errores, mostramos el aviso y NO guardamos
            if (!Page.IsValid)
            {
                pnlAlertCampos.Visible = true;
                return;
            }

            // 3. Todo OK → ocultamos el aviso (por si estaba visible antes)
            pnlAlertCampos.Visible = false;

            // 4. Lógica original de guardado
            try
            {
                switch (Tipo.ToLower())
                {
                    case "polo":
                    case "polos": GuardarPolo(); break;

                    case "blusa":
                    case "blusas": GuardarBlusa(); break;

                    case "vestido":
                    case "vestidos": GuardarVestido(); break;

                    case "falda":
                    case "faldas": GuardarFalda(); break;

                    case "pantalon":
                    case "pantalones": GuardarPantalon(); break;

                    case "casaca":
                    case "casacas": GuardarCasaca(); break;

                    case "gorro":
                    case "gorros": GuardarGorro(); break;
                }
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
                return;
            }

            Response.Redirect($"ListarPrendas.aspx?tipo={Tipo}");
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"ListarPrendas.aspx?tipo={Tipo}");
        }
        //protected void btnVerPromosDesc_Click(object sender, EventArgs e)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "$('#form-modal-descuentos').modal('show');", true);
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModalPromo", "$('#form-modal-promociones').modal('show');", true);
        //}
        // ========= GUARDAR POR TIPO =========
        private void GuardarPolo()
        {
            var ws = new PoloWSClient();
            var p = new polo
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoManga = (tipoManga)Enum.Parse(typeof(tipoManga), ddlTipoManga.SelectedValue, true),
                tipoCuello = (tipoCuello)Enum.Parse(typeof(tipoCuello), ddlTipoCuello.SelectedValue, true),
                tipoMangaSpecified = true,
                estampado = txtEstampado.Text,
                materialSpecified = true,
                tipoCuelloSpecified = true
            };


            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarPolo(p); }
            else ws.insertarPolo(p);
        }

        private void GuardarBlusa()
        {
            var ws = new BlusaWSClient();
            var p = new blusa
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoBlusa = (tipoBlusa)Enum.Parse(typeof(tipoBlusa), ddlTipoBlusa.SelectedValue, true),
                tipoManga = (tipoManga)Enum.Parse(typeof(tipoManga), ddlTipoMangaB.SelectedValue, true),
                materialSpecified = true,
                tipoMangaSpecified = true,
                tipoBlusaSpecified = true

            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarBlusa(p); }
            else ws.insertarBlusa(p);
        }

        private void GuardarVestido()
        {
            var ws = new VestidoWSClient();
            var p = new vestido
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoVestido = (tipoVestido)Enum.Parse(typeof(tipoVestido), ddlTipoVestido.SelectedValue, true),
                tipoManga = (tipoManga)Enum.Parse(typeof(tipoManga), ddlTipoMangaV.SelectedValue, true),
                largo = ParseInt(txtLargoVestido.Text, "Largo (cm)"),
                tipoMangaSpecified = true,
                tipoVestidoSpecified = true,
                materialSpecified = true
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarVestido(p); }
            else ws.insertarVestido(p);
        }

        private void GuardarFalda()
        {
            var ws = new FaldaWSClient();
            var p = new falda
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoFalda = (tipoFalda)Enum.Parse(typeof(tipoFalda), ddlTipoFalda.SelectedValue, true),
                largo = ParseDouble(txtLargoFalda.Text, "Largo (cm)"),
                conVolantes = IsTrue10(ddlConVolantes.SelectedValue),
                tipoFaldaSpecified = true,
                materialSpecified = true
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarFalda(p); }
            else ws.insertarFalda(p);
        }

        private void GuardarPantalon()
        {
            var ws = new PantalonWSClient();
            var p = new pantalon
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoPantalon = (tipoPantalon)Enum.Parse(typeof(tipoPantalon), ddlTipoPantalon.SelectedValue, true),
                largoPierna = ParseDouble(txtLargoPierna.Text, "Largo pierna (cm)"),
                cintura = ParseDouble(txtCintura.Text, "Cintura (cm)"),
                materialSpecified = true,
                tipoPantalonSpecified = true
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarPantalon(p); }
            else ws.insertarPantalon(p);
        }

        private void GuardarCasaca()
        {
            var ws = new CasacaWSClient();
            var p = new casaca
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoCasaca = (tipoCasaca)Enum.Parse(typeof(tipoCasaca), ddlTipoCasaca.SelectedValue, true),
                conCapucha = IsTrue10(ddlConCapucha.SelectedValue),
                materialSpecified = true,
                tipoCasacaSpecified = true

            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarCasaca(p); }
            else ws.insertarCasaca(p);
        }

        private void GuardarGorro()
        {
            var ws = new GorroWSClient();
            var p = new gorro
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (material)Enum.Parse(typeof(material), ddlMaterial.SelectedValue, true),
                tipoGorra = (tipoGorra)Enum.Parse(typeof(tipoGorra), ddlTipoGorra.SelectedValue, true),
                tallaAjustable = IsTrue10(ddlTallaAjustable.SelectedValue),
                impermeable = IsTrue10(ddlImpermeable.SelectedValue),
                materialSpecified = true,
                tipoGorraSpecified = true
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarGorro(p); }
            else ws.insertarGorro(p);
        }

        // ========= HELPERS =========
        private static string BoolTo10(bool b) => b ? "1" : "0";
        private static bool IsTrue10(string v) => (v ?? "").Trim() == "1";

        private static int ParseInt(string txt, string campo)
        {
            if (!int.TryParse((txt ?? "").Trim(), out var n))
                throw new ArgumentException($"Valor inválido para {campo}.");
            return n;
        }

        private static double ParseDouble(string txt, string campo)
        {
            if (!double.TryParse((txt ?? "").Trim(), out var d))
                throw new ArgumentException($"Valor inválido para {campo}.");
            return d;
        }

        private string ObtenerNombreSingular()
        {
            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos": return "Polo";
                case "blusa":
                case "blusas": return "Blusa";
                case "vestido":
                case "vestidos": return "Vestido";
                case "falda":
                case "faldas": return "Falda";
                case "pantalon":
                case "pantalones": return "Pantalón";
                case "casaca":
                case "casacas": return "Casaca";
                case "gorro":
                case "gorros": return "Gorro";
                default: return Tipo;
            }
        }

        // ========= STOCK POR TALLA =========
        private void CargarStockPorTallas()
        {
            if (Id <= 0) return;

            // Cliente del web service PackagePrendas
            // El nombre puede ser PackagePrendasClient o PackagePrendasWSClient según cómo lo generó VS.
            // Si te marca error, pon "new PackagePrendasClient()" y deja que IntelliSense te sugiera el tipo correcto.
            var wsStock = new PrendaLoteWSClient();

            // Estas tallas DEBEN coincidir EXACTO con el enum Talla del backend (Java)
            // Ajusta según tu enum Talla en PackagePrendas (XS, S, M, L, XL, UNICA, etc.)
            string[] tallas = new[] { "XS", "S", "M", "L", "XL" };

            var filas = new List<StockTallaRow>();

            foreach (string t in tallas)
            {
                int stock = 0;
                try
                {
                    stock = wsStock.obtenerStockPorTalla(Id, t);
                }
                catch
                {
                    stock = 0;
                }

                filas.Add(new StockTallaRow
                {
                    Talla = t,
                    Stock = stock
                });
            }

            gvStockTallas.DataSource = filas;
            gvStockTallas.DataBind();

            pnlStockTallas.Visible = true;

            // ==== LÓGICA DE ALERTA ====

            int alertaMinima = 0;
            int.TryParse((txtStock.Text ?? "").Trim(), out alertaMinima); // tu campo alertaMinStock

            int stockTotal = filas.Sum(f => f.Stock);

            if (stockTotal <= alertaMinima)
            {
                lblAlertaStock.Visible = true;
                lblAlertaStock.Text = $"⚠ Este producto está en último stock: quedan {stockTotal} unidades. Considere reponerlo.";
            }
            else
            {
                lblAlertaStock.Visible = false;
            }
        }

        private class StockTallaRow
        {
            public string Talla { get; set; }
            public int Stock { get; set; }
        }


        private void MostrarError(string mensaje)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", $"alert('{mensaje}');", true);
        }
    }
}
