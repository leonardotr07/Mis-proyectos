using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class RegistrarCondicion : System.Web.UI.Page
    {
        private List<condicionPago> condiciones
        {
            get => (List<condicionPago>)Session["condicionesPago"];
            set => Session["condicionesPago"] = value;
        }

        private string modo => Session["modoCondicion"]?.ToString() ?? "nuevo";

        private condicionPago condicionActual
        {
            get => (condicionPago)Session["condicionSeleccionada"];
            set => Session["condicionSeleccionada"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarModo();
            }
        }

        private void ConfigurarModo()
        {
            switch (modo)
            {
                case "nuevo":
                    lblTituloCondicion.InnerText = "Registrar Condición"; // 🔹 CAMBIA EL TEXTO
                    btnRegistrarCondicion.Text = "Registrar";
                    txtIDCondicion.Text = (condiciones.Count > 0 ? condiciones.Max(c => c.idCondicion) + 1 : 1).ToString();
                    txtIDProveedor.Text = "0";
                    Page.Title = "Registrar Condición";
                    break;

                case "modificar":
                    lblTituloCondicion.InnerText = "Modificar Condición"; // 🔹 CAMBIA EL TEXTO
                    btnRegistrarCondicion.Text = "Modificar";
                    Page.Title = "Modificar Condición";
                    if (condicionActual != null)
                    {
                        txtIDCondicion.Text = condicionActual.idCondicion.ToString();
                        txtNumeroDias.Text = condicionActual.numDias.ToString();
                        txtDescripcion.Text = condicionActual.descripcion;
                    }
                    break;

                case "ver":
                    lblTituloCondicion.InnerText = "Ver Condición"; // 🔹 CAMBIA EL TEXTO
                    btnRegistrarCondicion.Text = "Registrar";
                    Page.Title = "Ver Condición";
                    if (condicionActual != null)
                    {
                        txtIDCondicion.Text = condicionActual.idCondicion.ToString();
                        txtNumeroDias.Text = condicionActual.numDias.ToString();
                        txtDescripcion.Text = condicionActual.descripcion;
                        txtNumeroDias.Enabled = false;
                        txtDescripcion.Enabled = false;
                        btnRegistrarCondicion.Visible = false;
                    }
                    break;
            }
        }

        protected void btnRegistrarCondicion_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            int numDias = int.Parse(txtNumeroDias.Text);
            string descripcion = txtDescripcion.Text.Trim();

            if (modo == "nuevo")
            {
                var nueva = new condicionPago
                {
                    idCondicion = int.Parse(txtIDCondicion.Text),
                    descripcion = descripcion,
                    numDias = numDias
                };
                condiciones.Add(nueva);

                // 🔹 NUEVO: Mensaje de confirmación
                MostrarMensaje("Condición registrada exitosamente.");
            }
            else if (modo == "modificar" && condicionActual != null)
            {
                condicionActual.descripcion = descripcion;
                condicionActual.numDias = numDias;

                // 🔹 NUEVO: Mensaje de confirmación
                MostrarMensaje("Condición modificada exitosamente.");
            }

            Session["condicionesPago"] = condiciones;

            // Redirigir de vuelta a la página de condiciones
            string url = "~/RegistrarCondicionesdePago.aspx";
            Response.Redirect(url);
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            // Redirigir de vuelta a la página de condiciones
            string url = "~/RegistrarCondicionesdePago.aspx";
            Response.Redirect(url);
        }

        // 🔹 NUEVO: Método para validar campos
        private bool ValidarCampos()
        {
            if (string.IsNullOrWhiteSpace(txtNumeroDias.Text))
            {
                MostrarMensaje("Por favor, ingrese el número de días.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
            {
                MostrarMensaje("Por favor, ingrese la descripción.");
                return false;
            }

            // Validar que el número de días sea un valor positivo
            if (!int.TryParse(txtNumeroDias.Text, out int numDias) || numDias <= 0)
            {
                MostrarMensaje("Por favor, ingrese un número de días válido (mayor a 0).");
                return false;
            }

            // Validar longitud de descripción
            if (txtDescripcion.Text.Trim().Length > 120)
            {
                MostrarMensaje("La descripción no puede tener más de 120 caracteres.");
                return false;
            }

            return true;
        }

        private void MostrarMensaje(string mensaje)
        {
            string script = $"alert('{mensaje.Replace("'", "\\'")}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "msg", script, true);
        }

    }
}