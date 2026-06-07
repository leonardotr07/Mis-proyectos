using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CargoWS;
using WearDropWA.EmpleadoWS;

namespace WearDropWA
{
    public partial class RegistrarEmpleado : System.Web.UI.Page
    {
        private EmpleadoWSClient boEmpleado;
        private empleado empleado;
        private CargoWSClient boCargo;
        private String estado;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                boCargo = new CargoWSClient();
                ddlCargo.DataSource = boCargo.listarCargos();
                ddlCargo.DataTextField = "descripcion";  
                ddlCargo.DataValueField = "idCargo"; // Valor interno (ID)
                ddlCargo.DataBind();
            }

            String accion = Request.QueryString["accion"];
            if (accion == null)
            {
                empleado = new empleado();
                lblTitulo.Text = "Registrar Empleado";
                estado = "nuevo";
                txtID.Enabled = false;
            }
            else if (accion == "modificar")
            {
                lblTitulo.Text = "Modificar Empleado";
                estado = "modificar";
                empleado = (empleado)Session["empleado"];
                if (!IsPostBack)
                    AsignarValores();
                txtID.Enabled = false;
            }

        }

        void AsignarValores()
        {
            txtApellidoMaterno.Text = empleado.segundoApellido;
            txtApellidoPaterno.Text = empleado.primerApellido;
            ddlCargo.SelectedValue = empleado.cargoAsignado.idCargo.ToString();
            txtDni.Text = empleado.dni.ToString();
            txtID.Text = empleado.idPersona.ToString();
            txtNombre.Text = empleado.nombre;
            txtSueldo.Text = empleado.sueldo.ToString();
            txtTelefono.Text = empleado.telefono.ToString();
            if (empleado.genero.Equals('M')) rbMasculino.Checked = true;
            else rbFemenino.Checked = true;
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            boEmpleado = new EmpleadoWSClient();
            empleado.dni = Int32.Parse(txtDni.Text);
            empleado.segundoApellido = txtApellidoMaterno.Text;
            empleado.primerApellido = txtApellidoPaterno.Text;
            empleado.telefono = Int32.Parse(txtTelefono.Text);
            empleado.nombre = txtNombre.Text;

            EmpleadoWS.cargo cargo = new EmpleadoWS.cargo();
            cargo.idCargo = Int32.Parse(ddlCargo.SelectedValue);
            empleado.cargoAsignado = cargo;

            if (!rbFemenino.Checked && !rbMasculino.Checked)
            {
                mostrarModal("Debe seleccionar un sexo");
                return;
            }
            if (rbMasculino.Checked) empleado.genero = 'M';
            else if (rbFemenino.Checked) empleado.genero = 'F';

            try
            {
                empleado.sueldo = Double.Parse(txtSueldo.Text);
            }
            catch (Exception ex)
            {
                mostrarModal("Debe colocar un sueldo adecuado");
                return;
            }

            //Realizar CRUD
            try
            {
                if (estado == "nuevo")
                    boEmpleado.insertarEmpleado(empleado);
                else if (estado == "modificar")
                    boEmpleado.modificarEmpleado(empleado);
            }
            catch (Exception ex)
            {
                mostrarModal(ex.Message);
                return;
            }

            Response.Redirect("ListarEmpleados.aspx");
        }

        public void mostrarModal(String message)
        {
            lblModalError.Text = message;
            string script = "mostrarModalError();";
            ScriptManager.RegisterStartupScript(
                this, GetType(), "modalError", script, true);
        }
    }
}