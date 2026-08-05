using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class SolicitarRecuperacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No se requiere lógica al cargar la página
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            // 1. Validaciones básicas
            if (string.IsNullOrEmpty(email))
            {
                MostrarMensaje("Por favor, ingresa tu correo electrónico.", "alert alert-warning");
                return;
            }

            try
            {
                // 2. Llamar al Web Service
                CuentaUsuarioWSClient dao = new CuentaUsuarioWSClient();
                bool resultado = dao.solicitarRecuperacionContrasena(email);

                // 3. Mostrar resultado
                if (resultado)
                {
                    MostrarMensaje("¡Listo! Hemos enviado un enlace de recuperación a tu correo. Revisa tu bandeja de entrada (y Spam).", "alert alert-success");
                    btnEnviar.Enabled = false; // Desactivar botón para evitar doble envío
                }
                else
                {
                    MostrarMensaje("No encontramos una cuenta asociada a este correo o hubo un error al enviar el mensaje.", "alert alert-danger");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Ocurrió un error técnico: " + ex.Message, "alert alert-danger");
            }
        }

        private void MostrarMensaje(string texto, string cssClass)
        {
            lblMensaje.Text = texto;
            lblMensaje.CssClass = cssClass;
            lblMensaje.Visible = true;
        }
    }
}