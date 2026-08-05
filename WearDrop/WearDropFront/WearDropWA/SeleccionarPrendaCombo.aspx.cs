using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.PromocionComboWS;
using WearDropWA.PackageAlmacen;
using WearDropWA.PackagePrendas;
namespace WearDropWA
{
    public partial class SeleccionarPrendaCombo : System.Web.UI.Page
    {
        private int idProm;
        private PromocionComboWSClient boProm;
        private BindingList<PackagePrendas.falda> faldas;
        private PackagePrendas.FaldaWSClient boFaldas;
        private BindingList<PackagePrendas.blusa> blusas;
        private PackagePrendas.BlusaWSClient boBlusas;
        private BindingList<PackagePrendas.vestido> vestidos;
        private PackagePrendas.VestidoWSClient boVest;
        private BindingList<PackagePrendas.gorro> gorros;
        private PackagePrendas.GorroWSClient boGo;
        private BindingList<PackagePrendas.casaca> casacas;
        private PackagePrendas.CasacaWSClient boCasaca;
        private BindingList<PackagePrendas.pantalon> pantalones;
        private PackagePrendas.PantalonWSClient boPantalon;
        private BindingList<PackagePrendas.polo> polos;
        private PackagePrendas.PoloWSClient boPolos;
        protected void Page_Load(object sender, EventArgs e)
        {
            boFaldas = new PackagePrendas.FaldaWSClient();
            boBlusas = new BlusaWSClient();
            boCasaca = new CasacaWSClient();
            boGo = new GorroWSClient();
            boPantalon = new PantalonWSClient();
            boPolos = new PoloWSClient();
            boVest = new VestidoWSClient();
            boProm=new PromocionComboWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idProm"] != null)
                {
                    idProm = Convert.ToInt32(Request.QueryString["idProm"]);
                    ViewState["IdProm"] = idProm;

                    CargarFalda();
                    CargarGorro();
                    CargarBlusa();
                    CargarCasaca();
                    CargarPantalon();
                    CargarVestido();
                    CargarPolo();

                    //if (Request.QueryString["idMovimiento"] != null)
                    //{
                    //    //int idMovimiento = Convert.ToInt32(Request.QueryString["idMovimiento"]);
                    //    //ddlIdMovimiento.SelectedValue = idMovimiento.ToString();
                    //    //ActualizarDatosMovimiento(idMovimiento);
                    //}
                }
                else
                {
                    Response.Redirect("ListarCombo.aspx");
                }
            }
            else
            {
                idProm = (int)ViewState["IdProm"];
            }
        }
        protected void ddlIdFalda_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlIdBlusas_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlIdGorro_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlIdCasaca_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlPantalon_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlPolo_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        protected void ddlVestido_SelectedIndex(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlFaldas.SelectedValue);

            //if (idMovimiento > 0)
            //{
            //    ActualizarDatosMovimiento(idMovimiento);
            //}
            //else
            //{
            //    lblLugarOrigen.Text = "-";
            //    lblLugarDestino.Text = "-";
            //}
        }
        private void CargarBlusa()
        {
            try
            {
                blusas = new BindingList<PackagePrendas.blusa>(boBlusas.listarBlusas());

                var blu = blusas.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Blusa {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlBlusas.DataSource = blu;
                ddlBlusas.DataTextField = "DescripcionCompleta";
                ddlBlusas.DataValueField = "IdPrenda";
                ddlBlusas.DataBind();

                ddlBlusas.Items.Insert(0, new ListItem("--Seleccione una Blusa--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar las blusas: {ex.Message}');", true);
            }

        }
        private void CargarFalda()
        {
            try
            {
                faldas = new BindingList<PackagePrendas.falda>(boFaldas.listarFaldas());

                var falda = faldas.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Falda {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlFaldas.DataSource = falda;
                ddlFaldas.DataTextField = "DescripcionCompleta";
                ddlFaldas.DataValueField = "IdPrenda";
                ddlFaldas.DataBind();

                ddlFaldas.Items.Insert(0, new ListItem("--Seleccione una Falda--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar las faldas: {ex.Message}');", true);
            }
        }
        private void CargarGorro()
        {
            try
            {
                gorros = new BindingList<PackagePrendas.gorro>(boGo.listarGorros());

                var go = gorros.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Gorro {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlGorros.DataSource = go;
                ddlGorros.DataTextField = "DescripcionCompleta";
                ddlGorros.DataValueField = "IdPrenda";
                ddlGorros.DataBind();

                ddlGorros.Items.Insert(0, new ListItem("--Seleccione un Gorro--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar los Gorros: {ex.Message}');", true);
            }
        }
        private void CargarCasaca()
        {
            try
            {
                casacas = new BindingList<PackagePrendas.casaca>(boCasaca.listarCasacas());

                var ca = casacas.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Casaca {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlCasaca.DataSource = ca;
                ddlCasaca.DataTextField = "DescripcionCompleta";
                ddlCasaca.DataValueField = "IdPrenda";
                ddlCasaca.DataBind();

                ddlCasaca.Items.Insert(0, new ListItem("--Seleccione una Casaca--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar las Casacas: {ex.Message}');", true);
            }
        }
        private void CargarPantalon()
        {

            try
            {
                pantalones = new BindingList<PackagePrendas.pantalon>(boPantalon.listarPantalones());

                var ca = pantalones.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Pantalón {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlPantalon.DataSource = ca;
                ddlPantalon.DataTextField = "DescripcionCompleta";
                ddlPantalon.DataValueField = "IdPrenda";
                ddlPantalon.DataBind();

                ddlPantalon.Items.Insert(0, new ListItem("--Seleccione un Pantalón--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar los Pantalones: {ex.Message}');", true);
            }
        }
        private void CargarVestido()
        {
            try
            {
                vestidos = new BindingList<PackagePrendas.vestido>(boVest.listarVestidos());

                var ca = vestidos.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Vestido {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlVestido.DataSource = ca;
                ddlVestido.DataTextField = "DescripcionCompleta";
                ddlVestido.DataValueField = "IdPrenda";
                ddlVestido.DataBind();

                ddlVestido.Items.Insert(0, new ListItem("--Seleccione un Vestido--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar los Vestidos: {ex.Message}');", true);
            }
        }
        private void CargarPolo()
        {
            try
            {
                polos = new BindingList<PackagePrendas.polo>(boPolos.listarPolos());

                var ca = polos.Select(m => new
                {
                    IdPrenda = m.idPrenda,
                    DescripcionCompleta = $"Polo {m.idPrenda} - {m.nombre}"
                }).ToList();

                ddlPolo.DataSource = ca;
                ddlPolo.DataTextField = "DescripcionCompleta";
                ddlPolo.DataValueField = "IdPrenda";
                ddlPolo.DataBind();

                ddlPolo.Items.Insert(0, new ListItem("--Seleccione un Polo--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar los Polos: {ex.Message}');", true);
            }
        }

        protected void btnSeleccionarPrendas_Click(object sender, EventArgs e)
        {
            var idsPrendas = new List<int>();

            AgregarSiSeleccionado(ddlFaldas, idsPrendas);
            AgregarSiSeleccionado(ddlBlusas, idsPrendas);
            AgregarSiSeleccionado(ddlGorros, idsPrendas);
            AgregarSiSeleccionado(ddlCasaca, idsPrendas);
            AgregarSiSeleccionado(ddlPantalon, idsPrendas);
            AgregarSiSeleccionado(ddlVestido, idsPrendas);
            AgregarSiSeleccionado(ddlPolo, idsPrendas);

            // 2. Validar: si no seleccionó ninguna prenda
            if (idsPrendas.Count == 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "sinPrendas",
                    "alert('No se pudo registrar el combo porque no seleccionaste ninguna prenda.'); window.location='ListarCombo.aspx';",
                    true
                );
                return;
            }

            int idProm = (int)ViewState["IdProm"];

            try
            {
                // 🔹 Ajusta el nombre del cliente según tu referencia de servicio
                // Ejemplo, cámbialo por el real
                boProm.insertarPrendaCombo(idProm, idsPrendas.ToArray());

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ok",
                    "alert('Las prendas se registraron correctamente en el combo.'); window.location='ListarCombo.aspx';",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "error",
                    $"alert('Ocurrió un error al registrar el combo: {ex.Message}');",
                    true
                );
            }
        }
        private void AgregarSiSeleccionado(DropDownList ddl, List<int> lista)
        {
            if (!string.IsNullOrEmpty(ddl.SelectedValue) && ddl.SelectedValue != "0")
            {
                if (int.TryParse(ddl.SelectedValue, out int id))
                {
                    lista.Add(id);
                }
            }
        }
        protected void tipoPrenda_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Obtén el valor seleccionado en el DropDownList
            //    string seleccionada = tipoPrenda.SelectedValue;

            //    // Cambiar el texto dinámicamente en el span de la prenda
            //    prendaTitle.InnerText = tipoPrenda.SelectedItem.Text;

            //    // Limpiar las opciones previas del DropDownList
            //    opcionesPrenda.Items.Clear();

            //    // Mostrar el panel de opciones
            //    opcionesPrendaDiv.Visible = true;

            //    // Mostrar el fondo gris (overlay)
            //    overlay.Style["display"] = "block"; // Mostrar el fondo gris

            //    // Llenar las opciones dependiendo de la prenda seleccionada
            //    switch (seleccionada)
            //    {
            //        case "falda":
            //            opcionesPrenda.Items.Add(new ListItem("Falda Roja XL", "Falda Roja XL"));
            //            opcionesPrenda.Items.Add(new ListItem("Falda Azul M", "Falda Azul M"));
            //            opcionesPrenda.Items.Add(new ListItem("Falda Blanca S", "Falda Blanca S"));
            //            break;
            //        case "casaca":
            //            opcionesPrenda.Items.Add(new ListItem("Casaca Negra L", "Casaca Negra L"));
            //            opcionesPrenda.Items.Add(new ListItem("Casaca Azul M", "Casaca Azul M"));
            //            opcionesPrenda.Items.Add(new ListItem("Casaca Gris S", "Casaca Gris S"));
            //            break;
            //        case "polo":
            //            opcionesPrenda.Items.Add(new ListItem("Polo Rojo L", "Polo Rojo L"));
            //            opcionesPrenda.Items.Add(new ListItem("Polo Verde M", "Polo Verde M"));
            //            break;
            //        // Otros casos según sea necesario
            //        default:
            //            opcionesPrenda.Items.Add(new ListItem("No hay opciones disponibles", ""));
            //            break;
            //    }
            //}
        }
    }
}