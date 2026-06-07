using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS; // referencia al servicio web

namespace WearDropWA
{
    public partial class WearDrop1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mostrar usuario en topbar
                if (Session["cuentaUsuario"] != null)
                {
                    cuentaUsuario cuenta = (cuentaUsuario)Session["cuentaUsuario"];
                    lblNombreUsuario.Text = cuenta.username; // Nombre de usuario logueado
                }
                else
                {
                    lblNombreUsuario.Text = "Invitado";
                    // Puedes redirigir si lo prefieres:
                    // Response.Redirect("~/InicioSesion.aspx");
                }

                // Control de visibilidad según rol
                if (EsAlmacenero())
                {
                    // Oculta opciones que no corresponden al rol Almacenero
                    lnkGestionarDescuentos.Visible = false;
                    lnkGestionarOrdenesCompra.Visible = false;
                    lnkGestionarPersonas.Visible = false;
                    lnkGestionarPromociones.Visible = false;
                    lnkGestionarProveedores.Visible = false;
                    lnkGestionarVentas.Visible = false;
                 
                }
                
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            // Limpiar la sesión por completo
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            // Borrar la cookie de autenticación (FormsAuthentication)
            FormsAuthentication.SignOut();

            // Redirigir al login
            Response.Redirect("~/InicioSesion.aspx");
        }

        private bool EsAdministrador()
        {
            if (!Request.IsAuthenticated) return false;

            HttpCookie cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null) return false;

            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
            string roles = ticket.UserData;
            return roles != null && roles.Contains("Administrador");
        }

        private bool EsAlmacenero()
        {
            if (!Request.IsAuthenticated) return false;

            HttpCookie cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null) return false;

            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
            string roles = ticket.UserData;
            return roles != null && roles.Contains("Almacenero");
        }
    }
}
