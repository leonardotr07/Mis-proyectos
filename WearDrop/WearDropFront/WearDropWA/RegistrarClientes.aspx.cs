using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ClienteWS;
using WearDropWA.EmpleadoWS;

namespace WearDropWA
{
    public partial class RegistrarClientes : System.Web.UI.Page
    {
        private ClienteWSClient boCliente;
        private cliente cliente;
        private String estado;
        protected void Page_Load(object sender, EventArgs e)
        {

            String accion = Request.QueryString["accion"];
            if (accion == null)
            {
                cliente = new cliente();
                lblTitulo.Text = "Registrar Cliente";
                estado = "nuevo";
                txtID.Enabled = false;
            }
            else if (accion == "modificar")
            {
                lblTitulo.Text = "Modificar Cliente";
                estado = "modificar";
                cliente = (cliente)Session["cliente"];
                if (!IsPostBack)
                    AsignarValores();
                txtID.Enabled = false;
            }
        }

        public void AsignarValores()
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
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarClientes.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            // Primero verifica que las validaciones se cumplan
            if (!Page.IsValid) return;

            boCliente = new ClienteWSClient();

            // Si estás registrando un nuevo cliente, te aseguras que no sea null
            if (cliente == null)
                cliente = new cliente();

            // Asignas los campos del formulario
            cliente.dni = Int32.Parse(txtDni.Text);
            cliente.segundoApellido = txtApellidoMaterno.Text;
            cliente.primerApellido = txtApellidoPaterno.Text;
            cliente.telefono = Int32.Parse(txtTelefono.Text);
            cliente.nombre = txtNombre.Text;

            // ⬇️ Aquí usamos el DropDownList
            if (cliente.tipo == null)
                cliente.tipo = new tipoDeCliente();

            cliente.tipo.tipoCliente = Int32.Parse(ddlTipoCliente.SelectedValue);
            // Ahora el tipoCliente será 6 o 7 según lo elegido

            if (rbMasculino.Checked)
                cliente.genero = 'M';
            else if (rbFemenino.Checked)
                cliente.genero = 'F';

            // CRUD
            if (estado == "nuevo")
                boCliente.insertarCliente(cliente);
            else if (estado == "modificar")
                boCliente.modificarCliente(cliente);

            Response.Redirect("ListarClientes.aspx");
        }
    }
}