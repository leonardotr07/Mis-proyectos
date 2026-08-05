using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;
using WearDropWA.EmpleadoWS;

namespace WearDropWA
{
    public partial class ListarCuentas : System.Web.UI.Page
    {
        private CuentaUsuarioWSClient boCuentaUsuario;
        private BindingList<cuentaUsuario> cus;
        private cuentaUsuario cu;
        private tipoCuenta tip;
        protected void Page_Load(object sender, EventArgs e)
        {
            boCuentaUsuario = new CuentaUsuarioWSClient();
            cus = new BindingList<cuentaUsuario>(boCuentaUsuario.listarCuentasUsuario());
            gvCuentas.DataSource = cus;
            gvCuentas.DataBind();
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCuentas.aspx");
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCuentas.aspx");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            int idCuenta = Int32.Parse(((LinkButton)sender).CommandArgument);
            cuentaUsuario cuSelect = cus.Single(x => x.idCuenta == idCuenta);
            Session["cuentaUsuarioVer"] = cuSelect;
            Response.Redirect("VerCuenta.aspx");
        }

        protected void gvCuentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCuentas.PageIndex = e.NewPageIndex;
            gvCuentas.DataBind();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int idCuenta = Int32.Parse(((LinkButton)sender).CommandArgument);
            boCuentaUsuario.eliminarCuentaUsuario(idCuenta);
            Response.Redirect("ListarCuentas.aspx");
        }
    }
}