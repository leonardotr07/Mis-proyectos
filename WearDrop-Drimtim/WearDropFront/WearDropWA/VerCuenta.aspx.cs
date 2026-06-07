using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;

namespace WearDropWA
{
    public partial class VerCuenta : System.Web.UI.Page
    {
        private cuentaUsuario cu;
        protected void Page_Load(object sender, EventArgs e)
        {

            cu = (cuentaUsuario)Session["cuentaUsuarioVer"];
            if (!IsPostBack)
                AsignarValores();
            txtID.Enabled = false;
            txtEmail.Enabled = false;
            txtPassword.Enabled = false;
            txtTipoCuenta.Enabled = false;
            txtEmpleado.Enabled = false;
            txtUser.Enabled = false;
        }

        void AsignarValores()
        {
            txtID.Text = cu.idCuenta.ToString();
            txtEmail.Text = cu.email;
            txtUser.Text = cu.username;
            txtEmpleado.Text = cu.empleado.nombre.ToString();
            txtPassword.Text = "********";
            txtTipoCuenta.Text = cu.tipo.descripcion;
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCuentas.aspx");
        }

    }
}