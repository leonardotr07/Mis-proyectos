using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS; // Verifica tu namespace

namespace WearDropWA
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ControlarAccesos();
            }

            if (Session["cuentaUsuario"] == null)
            {
                Response.Redirect("InicioSesion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Cargar datos del usuario
                cuentaUsuario cuenta = (cuentaUsuario)Session["cuentaUsuario"];

                // Si tienes el nombre del empleado, mejor usa ese. Si no, el username está bien.
                lblUsuario.Text = cuenta.username;

                // Fecha formateada
                lblFecha.Text = DateTime.Now.ToString("dddd, dd 'de' MMMM 'de' yyyy");
            }

        }

        private void ControlarAccesos()
        {
            // Si es Almacenero, ocultar opciones que no debe ver
            if (EsAlmacenero())
            {
                lnkNuevaVenta.Visible = false;
                lnkRecibir.Visible = false;
            }

            // Si es Administrador muestra todo (opcional)
            if (EsAdministrador())
            {
                lnkNuevaVenta.Visible = true;
                lnkRecibir.Visible = true;
            }
        }

        private bool EsAdministrador()
        {
            if (!Request.IsAuthenticated) return false;

            var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);

            string roles = ticket.UserData;
            return roles.Contains("Administrador");
        }

        private bool EsAlmacenero()
        {
            if (!Request.IsAuthenticated) return false;

            var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            var ticket = FormsAuthentication.Decrypt(cookie.Value);

            string roles = ticket.UserData;
            return roles.Contains("Almacenero");
        }


    }
}