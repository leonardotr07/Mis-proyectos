using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class CambiarContraseha : System.Web.UI.Page
    {
        private CuentaUsuarioWS.cuentaUsuario cu;
        private CuentaUsuarioWSClient boCuentaUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Podrías usar esto si necesitas algo más en Page_Load
            cu = (CuentaUsuarioWS.cuentaUsuario)Session["cuentaUsuario"];
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Recuperar de sesión SIEMPRE en el postback
            cu = (CuentaUsuarioWS.cuentaUsuario)Session["cuentaUsuario"];

            string pass1 = txtNewPassword.Value.Trim();
            string pass2 = txtConfirmPassword.Value.Trim();

            // Validación del lado servidor (por seguridad)
            if (string.IsNullOrWhiteSpace(pass1) || string.IsNullOrWhiteSpace(pass2))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alertMessage('Los campos no pueden estar vacíos.','error');", true);
                return;
            }

            if (pass1.Length < 6)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alertMessage('La contraseña debe tener al menos 6 caracteres.','warning');", true);
                return;
            }

            if (pass1 != pass2)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alertMessage('Las contraseñas no coinciden.','error');", true);
                return;
            }

            // Asignar nueva contraseña y llamar al servicio
            cu.contrasenha = pass1;
            boCuentaUsuario = new CuentaUsuarioWSClient();

            int res = boCuentaUsuario.modificarCuentaUsuario(cu,"contrasena");

            if (res != 0)
            {
                FormsAuthentication.SignOut();     // ← Cierra sesión formalmente
                Session.Clear();
                Session.Abandon();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alertMessage('Contraseña actualizada correctamente. Inicia sesión nuevamente.','success');", true);

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "redirect", "setTimeout(function(){ window.location='InicioSesion.aspx'; }, 1500);", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alertMessage('Ocurrió un error al actualizar la contraseña.','error');", true);
            }
        }
    }
}