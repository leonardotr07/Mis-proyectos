using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ClienteWS;

namespace WearDropWA
{
    public partial class VerCliente : System.Web.UI.Page
    {
        private ClienteWSClient boCliente;
        private cliente cliente;
        protected void Page_Load(object sender, EventArgs e)
        {
            cliente = (cliente)Session["cliente"];
            if (!IsPostBack)
                AsignarValores();
            txtID.Enabled = false;
            txtApellidoMaterno.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtDni.Enabled = false;
            txtID.Enabled = false;
            txtNombre.Enabled = false;
            txtTelefono.Enabled = false;
            ddlTipoCliente.Enabled = false;
            rbFemenino.Disabled = true;
            rbMasculino.Disabled = true;
        }

        void AsignarValores()
        {
            txtApellidoMaterno.Text = cliente.segundoApellido;
            txtApellidoPaterno.Text = cliente.primerApellido;
            ddlTipoCliente.SelectedValue = cliente.tipo.tipoCliente.ToString();
            txtDni.Text = cliente.dni.ToString();
            txtID.Text = cliente.idPersona.ToString();
            txtNombre.Text = cliente.nombre;
            txtTelefono.Text = cliente.telefono.ToString();
            if (cliente.genero.Equals('M')) rbMasculino.Checked = true;
            else rbFemenino.Checked = true;
        }
        protected void btnVerCompras_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarClientexCompras.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarClientes.aspx");
        }
    }
}