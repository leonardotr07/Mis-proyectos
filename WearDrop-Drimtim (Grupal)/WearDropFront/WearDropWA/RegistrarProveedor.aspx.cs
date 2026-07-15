using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class RegistrarProveedor : System.Web.UI.Page
    {
        private ProveedorWSClient boProveedor;
        private proveedor provee;
        private String estado;

        protected void Page_Load(object sender, EventArgs e)
        {
            boProveedor = new ProveedorWSClient();
            txtIDProveedor.Enabled = false;

            // 🔹 Recuperamos el proveedor si ya existe en sesión
            if (Session["proveedorActual"] != null)
                provee = (proveedor)Session["proveedorActual"];
            else
                provee = new proveedor();

            String accion = Request.QueryString["accion"];
            if (accion == null)
            {
                lblTitulo.InnerText = "Registrar Proveedor";
                estado = "nuevo";
                btnAñadirCondiciones.Text = "Añadir condiciones de pago";
            }
            else if (accion == "modificar")
            {
                lblTitulo.InnerText = "Modificar Proveedor";
                estado = "modificar";
                provee = (proveedor)Session["proveedorSelect"];
                btnAñadirCondiciones.Text = "Modificar condiciones de pago";

                if (!IsPostBack)
                {
                    AsignarValores();
                    // 🔹 Cargar condiciones existentes desde BD al modificar
                    CargarCondicionesDesdeBD();
                }
            }
            else if (accion == "ver")
            {
                lblTitulo.InnerText = "Ver Proveedor";
                estado = "ver";
                provee = (proveedor)Session["proveedorSelect"];
                AsignarValores();
                txtNombre.Enabled = false;
                txtDireccion.Enabled = false;
                txtRUC.Enabled = false;
                txtTelefono.Enabled = false;
                btnRegistrarProveedor.Visible = false;
                btnAñadirCondiciones.Text = "Ver Condiciones de Pago";

                // 🔹 Cargar condiciones existentes desde BD al ver
                if (!IsPostBack)
                {
                    CargarCondicionesDesdeBD();
                }
            }

            // 🔹 Solo si NO es postback, traemos condiciones desde sesión (para que no se pierdan)
            if (!IsPostBack)
            {
                if (Session["proveedorActual"] != null)
                {
                    provee = (proveedor)Session["proveedorActual"];
                    AsignarValores();
                }

                if (Session["condicionesPago"] != null)
                {
                    provee.condiciones = ((List<condicionPago>)Session["condicionesPago"]).ToArray();
                }
            }

            // 🔹 Guardamos el estado y proveedor en sesión para mantenerlo entre postbacks
            Session["proveedorActual"] = provee;
            Session["estadoProveedor"] = estado; // 🔹 CRÍTICO: Guardar estado en sesión
        }

        // 🔹 Método para cargar condiciones desde BD
        private void CargarCondicionesDesdeBD()
        {
            if (provee != null && provee.idProveedor > 0)
            {
                try
                {
                    // Obtener el proveedor completo con condiciones desde BD
                    var proveedorCompleto = boProveedor.obtenerProveedorPorID(provee.idProveedor);
                    if (proveedorCompleto != null && proveedorCompleto.condiciones != null)
                    {
                        // Convertir array a List y guardar en sesión
                        var condicionesList = proveedorCompleto.condiciones.ToList();
                        Session["condicionesPago"] = condicionesList;
                        provee.condiciones = proveedorCompleto.condiciones;

                        System.Diagnostics.Debug.WriteLine($"🔹 Cargadas {condicionesList.Count} condiciones desde BD");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"❌ Error al cargar condiciones: {ex.Message}");
                    // En caso de error, inicializar lista vacía
                    Session["condicionesPago"] = new List<condicionPago>();
                }
            }
        }

        public void AsignarValores()
        {
            txtIDProveedor.Text = provee.idProveedor.ToString();
            txtNombre.Text = provee.nombre;
            txtDireccion.Text = provee.direccion;
            txtRUC.Text = provee.RUC.ToString();
            txtTelefono.Text = provee.telefono.ToString();
        }

        protected void btnRegistrarProveedor_Click(object sender, EventArgs e)
        {
            // Recuperamos el proveedor desde la sesión
            provee = (proveedor)Session["proveedorActual"] ?? new proveedor();

            // 🔹 Actualizamos datos desde los campos
            provee.nombre = txtNombre.Text.Trim();
            provee.direccion = txtDireccion.Text.Trim();
            if (!string.IsNullOrWhiteSpace(txtRUC.Text))
                provee.RUC = long.Parse(txtRUC.Text);
            if (!string.IsNullOrWhiteSpace(txtTelefono.Text))
                provee.telefono = Int32.Parse(txtTelefono.Text);

            // 🔹 Copiamos las condiciones desde la sesión al proveedor
            if (Session["condicionesPago"] != null)
            {
                provee.condiciones = ((List<condicionPago>)Session["condicionesPago"]).ToArray();
                System.Diagnostics.Debug.WriteLine($"🔹 Condiciones a guardar: {provee.condiciones.Length}");
            }
            else
            {
                provee.condiciones = new condicionPago[0];
                System.Diagnostics.Debug.WriteLine("🔹 No hay condiciones para guardar");
            }

            // 🔹 Validación básica
            if (string.IsNullOrWhiteSpace(provee.nombre) ||
                string.IsNullOrWhiteSpace(provee.direccion) ||
                provee.RUC == 0 ||
                provee.telefono == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alerta",
                    "alert('Por favor, complete todos los campos obligatorios.');", true);
                return;
            }

            try
            {
                if (estado == "nuevo")
                {
                    // insertar
                    var resultado = boProveedor.insertarProveedore(provee);
                    Response.Write("<script>alert('Resultado: " + resultado + "');</script>");
                }
                else if (estado == "modificar")
                {
                    // modificar
                    boProveedor.modificarProveedor(provee);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    $"alert('Error: {ex.Message}');", true);
                return;
            }

            // 🔹 Limpiamos sesión temporal
            Session.Remove("condicionesPago");
            Session.Remove("proveedorActual");
            Session.Remove("estadoProveedor");

            // 🔹 Redirigir después del registro
            Response.Redirect("~/GestionarProveedores.aspx");
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            // 🔹 Limpiar sesión al regresar sin guardar
            Session.Remove("condicionesPago");
            Session.Remove("proveedorActual");
            Session.Remove("estadoProveedor");
            Response.Redirect("~/GestionarProveedores.aspx");
        }

        protected void btnAñadirCondiciones_Click(object sender, EventArgs e)
        {
            // 🔹 Copiamos los valores del formulario al objeto antes de redirigir
            if (provee == null)
                provee = new proveedor();

            provee.nombre = txtNombre.Text.Trim();
            provee.direccion = txtDireccion.Text.Trim();

            if (!string.IsNullOrWhiteSpace(txtRUC.Text))
                provee.RUC = long.Parse(txtRUC.Text);

            if (!string.IsNullOrWhiteSpace(txtTelefono.Text))
                provee.telefono = Int32.Parse(txtTelefono.Text);

            // 🔹 Guardamos las condiciones actuales si existen
            if (Session["condicionesPago"] != null)
                provee.condiciones = ((List<condicionPago>)Session["condicionesPago"]).ToArray();

            // 🔹 CRÍTICO: Guardamos el proveedor actualizado y estado en sesión
            Session["proveedorActual"] = provee;
            Session["estadoProveedor"] = estado; // 🔹 ESTO ES LO MÁS IMPORTANTE

            // 🔹 DEBUG: Verificar que el estado se está enviando
            System.Diagnostics.Debug.WriteLine($"🔹 Redirigiendo a condiciones con estado: {estado}");
            System.Diagnostics.Debug.WriteLine($"🔹 Condiciones en sesión: {(Session["condicionesPago"] != null ? ((List<condicionPago>)Session["condicionesPago"]).Count : 0)}");

            // 🔹 Redirigimos
            Response.Redirect("~/RegistrarCondicionesdePago.aspx");
        }
    }
}