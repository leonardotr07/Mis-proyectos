using System;
using System.Data;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class VisualizarPrenda : System.Web.UI.Page
    {
        private string Tipo => (Request["tipo"] ?? "Polos").Trim();
        private string Id => (Request["id"] ?? "").Trim();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarPagina();
                CargarCombosComunes();
                CargarCamposEspecificos();
                CargarDatosPrenda();
                CargarDescuentos();
                CargarPromociones();
            }
        }

        private void ConfigurarPagina()
        {
            string nombrePrenda = ObtenerNombreSingular();
            litTitulo.Text = $"Visualizar {nombrePrenda}";
            litHeader.Text = $"Visualizar {nombrePrenda}";
            themeWrap.Attributes["class"] = "container theme-" + Tipo.ToLower();
        }

        private void CargarCombosComunes()
        {
            // Tallas
            ddlTalla.Items.Add(new ListItem("XS", "1"));
            ddlTalla.Items.Add(new ListItem("S", "2"));
            ddlTalla.Items.Add(new ListItem("M", "3"));
            ddlTalla.Items.Add(new ListItem("L", "4"));
            ddlTalla.Items.Add(new ListItem("XL", "5"));

            // Materiales
            ddlMaterial.Items.Add(new ListItem("Algodón", "1"));
            ddlMaterial.Items.Add(new ListItem("Poliéster", "2"));
            ddlMaterial.Items.Add(new ListItem("Mezcla", "3"));
            ddlMaterial.Items.Add(new ListItem("Lana", "4"));
            ddlMaterial.Items.Add(new ListItem("Licra", "5"));
        }

        private void CargarCamposEspecificos()
        {
            phCamposEspecificos.Controls.Clear();

            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos":
                    AgregarCamposPolos();
                    break;
                case "blusa":
                case "blusas":
                    AgregarCamposBlusas();
                    break;
                case "vestido":
                case "vestidos":
                    AgregarCamposVestidos();
                    break;
                case "falda":
                case "faldas":
                    AgregarCamposFaldas();
                    break;
                case "pantalon":
                case "pantalones":
                    AgregarCamposPantalones();
                    break;
                case "casaca":
                case "casacas":
                    AgregarCamposCasacas();
                    break;
                case "gorro":
                case "gorros":
                    AgregarCamposGorros();
                    break;
            }
        }

        private void AgregarCamposPolos()
        {
            // Tipo de Manga
            var divManga = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divManga.Attributes["class"] = "col-md-4";
            var lblManga = new Label { Text = "Tipo de Manga:", CssClass = "form-label" };
            var ddlTipoManga = new DropDownList { ID = "ddlTipoManga", CssClass = "form-control", Enabled = false };
            ddlTipoManga.Items.Add(new ListItem("Manga corta", "1"));
            ddlTipoManga.Items.Add(new ListItem("Manga larga", "2"));
            ddlTipoManga.Items.Add(new ListItem("3/4", "3"));
            divManga.Controls.Add(lblManga);
            divManga.Controls.Add(ddlTipoManga);
            phCamposEspecificos.Controls.Add(divManga);

            // Estampado
            var divEstampado = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divEstampado.Attributes["class"] = "col-md-4";
            var lblEstampado = new Label { Text = "Estampado:", CssClass = "form-label" };
            var txtEstampado = new TextBox { ID = "txtEstampado", CssClass = "form-control", Enabled = false };
            divEstampado.Controls.Add(lblEstampado);
            divEstampado.Controls.Add(txtEstampado);
            phCamposEspecificos.Controls.Add(divEstampado);

            // Tipo de Cuello
            var divCuello = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divCuello.Attributes["class"] = "col-md-4";
            var lblCuello = new Label { Text = "Tipo de Cuello:", CssClass = "form-label" };
            var ddlTipoCuello = new DropDownList { ID = "ddlTipoCuello", CssClass = "form-control", Enabled = false };
            ddlTipoCuello.Items.Add(new ListItem("Redondo", "1"));
            ddlTipoCuello.Items.Add(new ListItem("V", "2"));
            ddlTipoCuello.Items.Add(new ListItem("Polo", "3"));
            divCuello.Controls.Add(lblCuello);
            divCuello.Controls.Add(ddlTipoCuello);
            phCamposEspecificos.Controls.Add(divCuello);
        }

        private void AgregarCamposBlusas()
        {
            // Tipo de Blusa
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-6";
            var lblTipo = new Label { Text = "Tipo de Blusa:", CssClass = "form-label" };
            var ddlTipoBlusa = new DropDownList { ID = "ddlTipoBlusa", CssClass = "form-control", Enabled = false };
            ddlTipoBlusa.Items.Add(new ListItem("Casual", "1"));
            ddlTipoBlusa.Items.Add(new ListItem("Formal", "2"));
            ddlTipoBlusa.Items.Add(new ListItem("Crop Top", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoBlusa);
            phCamposEspecificos.Controls.Add(divTipo);

            // Tipo de Manga
            var divManga = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divManga.Attributes["class"] = "col-md-6";
            var lblManga = new Label { Text = "Tipo de Manga:", CssClass = "form-label" };
            var ddlTipoMangaB = new DropDownList { ID = "ddlTipoMangaB", CssClass = "form-control", Enabled = false };
            ddlTipoMangaB.Items.Add(new ListItem("Sin Manga", "1"));
            ddlTipoMangaB.Items.Add(new ListItem("Corta", "2"));
            ddlTipoMangaB.Items.Add(new ListItem("Larga", "3"));
            divManga.Controls.Add(lblManga);
            divManga.Controls.Add(ddlTipoMangaB);
            phCamposEspecificos.Controls.Add(divManga);
        }

        private void AgregarCamposVestidos()
        {
            // Tipo de Vestido
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-6";
            var lblTipo = new Label { Text = "Tipo de Vestido:", CssClass = "form-label" };
            var ddlTipoVestido = new DropDownList { ID = "ddlTipoVestido", CssClass = "form-control", Enabled = false };
            ddlTipoVestido.Items.Add(new ListItem("Casual", "1"));
            ddlTipoVestido.Items.Add(new ListItem("Formal", "2"));
            ddlTipoVestido.Items.Add(new ListItem("Cocktail", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoVestido);
            phCamposEspecificos.Controls.Add(divTipo);

            // Largo
            var divLargo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divLargo.Attributes["class"] = "col-md-6";
            var lblLargo = new Label { Text = "Largo (cm):", CssClass = "form-label" };
            var txtLargoVestido = new TextBox { ID = "txtLargoVestido", CssClass = "form-control", Enabled = false };
            divLargo.Controls.Add(lblLargo);
            divLargo.Controls.Add(txtLargoVestido);
            phCamposEspecificos.Controls.Add(divLargo);
        }

        private void AgregarCamposFaldas()
        {
            // Tipo de Falda
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-4";
            var lblTipo = new Label { Text = "Tipo de Falda:", CssClass = "form-label" };
            var ddlTipoFalda = new DropDownList { ID = "ddlTipoFalda", CssClass = "form-control", Enabled = false };
            ddlTipoFalda.Items.Add(new ListItem("Recta", "1"));
            ddlTipoFalda.Items.Add(new ListItem("Acampanada", "2"));
            ddlTipoFalda.Items.Add(new ListItem("Plisada", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoFalda);
            phCamposEspecificos.Controls.Add(divTipo);

            // Largo
            var divLargo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divLargo.Attributes["class"] = "col-md-4";
            var lblLargo = new Label { Text = "Largo (cm):", CssClass = "form-label" };
            var txtLargoFalda = new TextBox { ID = "txtLargoFalda", CssClass = "form-control", Enabled = false };
            divLargo.Controls.Add(lblLargo);
            divLargo.Controls.Add(txtLargoFalda);
            phCamposEspecificos.Controls.Add(divLargo);

            // Con Volantes
            var divVolantes = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divVolantes.Attributes["class"] = "col-md-4";
            var lblVolantes = new Label { Text = "Con Volantes:", CssClass = "form-label" };
            var ddlConVolantes = new DropDownList { ID = "ddlConVolantes", CssClass = "form-control", Enabled = false };
            ddlConVolantes.Items.Add(new ListItem("Sí", "1"));
            ddlConVolantes.Items.Add(new ListItem("No", "0"));
            divVolantes.Controls.Add(lblVolantes);
            divVolantes.Controls.Add(ddlConVolantes);
            phCamposEspecificos.Controls.Add(divVolantes);
        }

        private void AgregarCamposPantalones()
        {
            // Tipo de Pantalón
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-6";
            var lblTipo = new Label { Text = "Tipo de Pantalón:", CssClass = "form-label" };
            var ddlTipoPantalon = new DropDownList { ID = "ddlTipoPantalon", CssClass = "form-control", Enabled = false };
            ddlTipoPantalon.Items.Add(new ListItem("Jean", "1"));
            ddlTipoPantalon.Items.Add(new ListItem("Casual", "2"));
            ddlTipoPantalon.Items.Add(new ListItem("Formal", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoPantalon);
            phCamposEspecificos.Controls.Add(divTipo);

            // Largo pierna
            var divLargo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divLargo.Attributes["class"] = "col-md-6";
            var lblLargo = new Label { Text = "Largo pierna (cm):", CssClass = "form-label" };
            var txtLargoPierna = new TextBox { ID = "txtLargoPierna", CssClass = "form-control", Enabled = false };
            divLargo.Controls.Add(lblLargo);
            divLargo.Controls.Add(txtLargoPierna);
            phCamposEspecificos.Controls.Add(divLargo);
        }

        private void AgregarCamposCasacas()
        {
            // Tipo de Casaca
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-6";
            var lblTipo = new Label { Text = "Tipo de Casaca:", CssClass = "form-label" };
            var ddlTipoCasaca = new DropDownList { ID = "ddlTipoCasaca", CssClass = "form-control", Enabled = false };
            ddlTipoCasaca.Items.Add(new ListItem("Bomber", "1"));
            ddlTipoCasaca.Items.Add(new ListItem("Cortaviento", "2"));
            ddlTipoCasaca.Items.Add(new ListItem("Parka", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoCasaca);
            phCamposEspecificos.Controls.Add(divTipo);

            // Con Capucha
            var divCapucha = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divCapucha.Attributes["class"] = "col-md-6";
            var lblCapucha = new Label { Text = "Con Capucha:", CssClass = "form-label" };
            var ddlConCapucha = new DropDownList { ID = "ddlConCapucha", CssClass = "form-control", Enabled = false };
            ddlConCapucha.Items.Add(new ListItem("Sí", "1"));
            ddlConCapucha.Items.Add(new ListItem("No", "0"));
            divCapucha.Controls.Add(lblCapucha);
            divCapucha.Controls.Add(ddlConCapucha);
            phCamposEspecificos.Controls.Add(divCapucha);
        }

        private void AgregarCamposGorros()
        {
            // Tipo de Gorro
            var divTipo = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divTipo.Attributes["class"] = "col-md-4";
            var lblTipo = new Label { Text = "Tipo de Gorro:", CssClass = "form-label" };
            var ddlTipoGorra = new DropDownList { ID = "ddlTipoGorra", CssClass = "form-control", Enabled = false };
            ddlTipoGorra.Items.Add(new ListItem("Beanie", "1"));
            ddlTipoGorra.Items.Add(new ListItem("Snapback", "2"));
            ddlTipoGorra.Items.Add(new ListItem("Dad Hat", "3"));
            divTipo.Controls.Add(lblTipo);
            divTipo.Controls.Add(ddlTipoGorra);
            phCamposEspecificos.Controls.Add(divTipo);

            // Talla Ajustable
            var divAjustable = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divAjustable.Attributes["class"] = "col-md-4";
            var lblAjustable = new Label { Text = "Talla Ajustable:", CssClass = "form-label" };
            var ddlTallaAjustable = new DropDownList { ID = "ddlTallaAjustable", CssClass = "form-control", Enabled = false };
            ddlTallaAjustable.Items.Add(new ListItem("Sí", "1"));
            ddlTallaAjustable.Items.Add(new ListItem("No", "0"));
            divAjustable.Controls.Add(lblAjustable);
            divAjustable.Controls.Add(ddlTallaAjustable);
            phCamposEspecificos.Controls.Add(divAjustable);

            // Impermeable
            var divImpermeable = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            divImpermeable.Attributes["class"] = "col-md-4";
            var lblImpermeable = new Label { Text = "Impermeable:", CssClass = "form-label" };
            var ddlImpermeable = new DropDownList { ID = "ddlImpermeable", CssClass = "form-control", Enabled = false };
            ddlImpermeable.Items.Add(new ListItem("Sí", "1"));
            ddlImpermeable.Items.Add(new ListItem("No", "0"));
            divImpermeable.Controls.Add(lblImpermeable);
            divImpermeable.Controls.Add(ddlImpermeable);
            phCamposEspecificos.Controls.Add(divImpermeable);
        }

        private void CargarDatosPrenda()
        {
            // Cargar los datos reales desde el BO
            // Por ahora, datos de ejemplo:

            txtId.Text = Id;
            txtNombre.Text = $"{ObtenerNombreSingular()} Ejemplo";
            ddlTalla.SelectedValue = "3"; // M
            ddlMaterial.SelectedValue = "1"; // Algodón
            txtColor.Text = "Blanco";
            txtStock.Text = "50";
            txtPU.Text = "S/ 39.90";
            txtPM.Text = "S/ 34.50";
            txtPD.Text = "S/ 29.90";

            // Se cargan los datos específicos según el tipo
            /*
            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos":
                    var polo = PoloBO.ObtenerPorId(int.Parse(Id));
                    // Cargar datos específicos del polo
                    break;
                // ... otros casos
            }
            */
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

        // MÉTODOS DE DESCUENTOS Y PROMOCIONES (REUTILIZABLES)
        private void CargarDescuentos()
        {
            // Estas funciones son las mismas para todas las prendas
            // Solo llamas a los BOs genéricos de descuentos

            var monto = new DataTable();
            monto.Columns.Add("Id");
            monto.Columns.Add("Nombre");
            monto.Columns.Add("Monto", typeof(decimal));
            monto.Columns.Add("Editable");
            monto.Columns.Add("MontoMax", typeof(decimal));
            monto.Rows.Add("1", "Bienvenida", 10m, "Sí", 30m);
            monto.Rows.Add("2", "Cyber", 15m, "No", 15m);
            gvDescMonto.DataSource = monto;
            gvDescMonto.DataBind();

            var porc = new DataTable();
            porc.Columns.Add("Id");
            porc.Columns.Add("Nombre");
            porc.Columns.Add("Porcentaje", typeof(decimal));
            porc.Rows.Add("1", "Temporada", 0.10m);
            porc.Rows.Add("2", "Socios", 0.08m);
            gvDescPorc.DataSource = porc;
            gvDescPorc.DataBind();

            var liq = new DataTable();
            liq.Columns.Add("Id");
            liq.Columns.Add("Nombre");
            liq.Columns.Add("Porcentaje", typeof(decimal));
            liq.Columns.Add("StockMin", typeof(int));
            liq.Rows.Add("1", "Fin de línea", 0.25m, 5);
            liq.Rows.Add("2", "Últimas unidades", 0.35m, 2);
            gvDescLiq.DataSource = liq;
            gvDescLiq.DataBind();

            // En producción:
            // gvDescMonto.DataSource = DescuentoMontoBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvDescPorc.DataSource = DescuentoPorcentajeBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvDescLiq.DataSource = DescuentoLiquidacionBO.ListarPorPrenda(int.Parse(Id), Tipo);
        }

        private void CargarPromociones()
        {
            // Estas funciones son las mismas para todas las prendas
            // Solo llamas a los BOs genéricos de promociones

            var combo = new DataTable();
            combo.Columns.Add("Id");
            combo.Columns.Add("Nombre");
            combo.Columns.Add("CantGratis", typeof(int));
            combo.Columns.Add("CantReq", typeof(int));
            combo.Rows.Add("1", "2x1 Fin de semana", 1, 1);
            combo.Rows.Add("2", "3x2 Alumnos", 1, 2);
            gvPromoCombo.DataSource = combo;
            gvPromoCombo.DataBind();

            var conj = new DataTable();
            conj.Columns.Add("Id");
            conj.Columns.Add("Nombre");
            conj.Columns.Add("Porcentaje", typeof(decimal));
            conj.Rows.Add("1", "Set deportivo", 0.12m);
            conj.Rows.Add("2", "Look casual", 0.15m);
            gvPromoConjunto.DataSource = conj;
            gvPromoConjunto.DataBind();

            // En producción:
            // gvPromoCombo.DataSource = PromocionComboBO.ListarPorPrenda(int.Parse(Id), Tipo);
            // gvPromoConjunto.DataSource = PromocionConjuntoBO.ListarPorPrenda(int.Parse(Id), Tipo);
        }
    }
}