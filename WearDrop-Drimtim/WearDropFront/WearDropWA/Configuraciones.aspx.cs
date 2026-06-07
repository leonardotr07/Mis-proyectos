using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class Configuraciones : System.Web.UI.Page
    {
        private CuentaUsuarioWS.cuentaUsuario cu = new CuentaUsuarioWS.cuentaUsuario();
        private CuentaUsuarioWSClient boCuentaUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cu = (CuentaUsuarioWS.cuentaUsuario)Session["cuentaUsuario"];
                txtDni.Value = cu.empleado.dni.ToString();
                txtUsuario.Value =cu.username.ToString();
                txtEmail.Value = cu.email.ToString();
                txtNombre.Value = cu.empleado.nombre.ToString();
                txtTipoCuenta.Value = cu.tipo.descripcion.ToString();
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            boCuentaUsuario = new CuentaUsuarioWSClient();
            cu = (CuentaUsuarioWS.cuentaUsuario)Session["cuentaUsuario"];

            // Limpiar mensajes previos
            lblMensajeUsuario.Text = string.Empty;
            lblMensajeEmail.Text = string.Empty;

            lblMensajeUsuario.ForeColor = Color.Red;
            lblMensajeEmail.ForeColor = Color.Red;

            bool hayError = false;

            // ================================
            // VALIDACIONES
            // ================================

            // Usuario obligatorio
            if (string.IsNullOrWhiteSpace(txtUsuario.Value))
            {
                lblMensajeUsuario.Text = "El usuario no puede estar vacío.";
                hayError = true;
            }

            // Email obligatorio
            if (string.IsNullOrWhiteSpace(txtEmail.Value))
            {
                lblMensajeEmail.Text = "El email no puede estar vacío.";
                hayError = true;
            }
            else if (!txtEmail.Value.Contains("@") || !txtEmail.Value.Contains("."))
            {
                lblMensajeEmail.Text = "El email ingresado no es válido.";
                hayError = true;
            }

            // Si hay errores, no seguimos
            if (hayError) return;

            // ================================
            // ASIGNAR VALORES AL OBJETO
            // ================================
            cu.username = txtUsuario.Value.Trim();
            cu.email = txtEmail.Value.Trim();

            // ================================
            // LLAMAR AL SERVICIO PARA MODIFICAR
            // ================================
            int resultado = boCuentaUsuario.modificarCuentaUsuario(cu,"usuario");

            // ================================
            // MENSAJE FINAL
            // ================================
            if (resultado > 0)
            {

                // Si quieres, puedes mostrar check en verde al lado del campo
                lblMensajeUsuario.ForeColor = Color.Green;
                lblMensajeEmail.ForeColor = Color.Green;

                lblMensajeUsuario.Text = "Usuario actualizado.";
                lblMensajeEmail.Text = "Email actualizado.";

                // Además usamos tu alerta flotante
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alertSuccess",
                    "alertMessage('Los cambios se guardaron correctamente', 'success');",
                    true
                );
            }
            else
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alertError",
                    "alertMessage('Ocurrió un error al guardar los cambios', 'error');",
                    true
                );
            }
        }

        protected void btnEliminarCuenta_Click(object sender, EventArgs e)
        {
            try
            {
                var cuenta = Session["cuentaUsuario"] as cuentaUsuario;
                //if (cuenta == null)
                //{
                //    Response.Redirect("InicioSesion.aspx");
                //    return;
                //}

                // 1. Eliminar en el servicio
                var boCuentaUsuario = new CuentaUsuarioWSClient();
                boCuentaUsuario.eliminarCuentaUsuario(cuenta.idCuenta);   // <-- tu método eliminar(id)
                boCuentaUsuario.Close();

                // 2. Limpiar sesión y cerrar autenticación
                Session.Clear();
                Session.Abandon();
                FormsAuthentication.SignOut();

                // 3. Redirigir a inicio de sesión
                Response.Redirect("InicioSesion.aspx", true);
            }
            catch (Exception)
            {
                // Opcional: mostrar error
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "errDel",
                    "alert('Ocurrió un error al eliminar la cuenta.');",
                    true
                );
            }
        }

        protected void btnCambiarContrasena_Click(object sender, EventArgs e)
        {
            Response.Redirect("CambiarContraseha.aspx");
        }
    }
}