using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace WearDropWA
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated) return;

            var cookie = Context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null) return;

            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            if (ticket == null) return;

            // Roles almacenados en UserData, ej: "Administrador;Almacenero"
            string[] roles = (ticket.UserData ?? "")
                .Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            var identidad = new FormsIdentity(ticket);
            var principal = new GenericPrincipal(identidad, roles);

            Context.User = principal;
            System.Threading.Thread.CurrentPrincipal = principal;
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}