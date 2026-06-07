using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class RecuperarContrasena : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Obtener el token de la URL
                string token = Request.QueryString["token"];

                if (string.IsNullOrEmpty(token))
                {
                    BloquearFormulario("Token no proporcionado. Por favor usa el enlace de tu correo.");
                    return;
                }

                // 2. Validar que el token exista y no haya expirado
                try
                {
                    CuentaUsuarioWSClient dao = new CuentaUsuarioWSClient();
                    var cuenta = dao.validarTokenRecuperacion(token);

                    if (cuenta == null || cuenta.idCuenta == 0)
                    {
                        BloquearFormulario("Este enlace de recuperación es inválido o ha expirado.");
                    }
                    else
                    {
                        // El token es válido, dejamos que el usuario escriba
                        lblMensaje.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    BloquearFormulario("Error al validar el token: " + ex.Message);
                }
            }
        }

        protected void btnRestablecer_Click(object sender, EventArgs e)
        {
            string nuevaPass = txtNuevaContrasena.Text;
            string confirmarPass = txtConfirmarContrasena.Text;
            string token = Request.QueryString["token"];

            // 1. Validaciones
            if (string.IsNullOrEmpty(nuevaPass) || string.IsNullOrEmpty(confirmarPass))
            {
                MostrarMensaje("Debe completar ambos campos.", "alert alert-warning");
                return;
            }

            if (nuevaPass != confirmarPass)
            {
                MostrarMensaje("Las contraseñas no coinciden.", "alert alert-warning");
                return;
            }

            if (nuevaPass.Length < 6)
            {
                MostrarMensaje("La contraseña debe tener al menos 6 caracteres.", "alert alert-warning");
                return;
            }

            // 2. Llamar al servicio para cambiar la contraseña
            try
            {
                CuentaUsuarioWSClient dao = new CuentaUsuarioWSClient();
                bool resultado = dao.cambiarContrasenaConToken(token, nuevaPass);

                if (resultado)
                {
                    MostrarMensaje("¡Contraseña restablecida con éxito! Redirigiendo...", "alert alert-success");
                    pnlFormulario.Visible = false; // Ocultar formulario

                    // Redirigir al login después de 3 segundos (opcional)
                    Response.AddHeader("REFRESH", "3;URL=InicioSesion.aspx");
                }
                else
                {
                    MostrarMensaje("No se pudo cambiar la contraseña. El token puede haber expirado justo ahora.", "alert alert-danger");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error técnico: " + ex.Message, "alert alert-danger");
            }
        }

        private void BloquearFormulario(string mensajeError)
        {
            lblMensaje.Text = mensajeError;
            lblMensaje.CssClass = "alert alert-danger";
            lblMensaje.Visible = true;
            pnlFormulario.Visible = false; // Oculta los textbox y botones
        }

        private void MostrarMensaje(string texto, string cssClass)
        {
            lblMensaje.Text = texto;
            lblMensaje.CssClass = cssClass;
            lblMensaje.Visible = true;
        }
    }
}