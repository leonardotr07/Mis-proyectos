using System;
using System.Collections.Generic;
using System.ComponentModel; // Para BindingList
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;
using WearDropWA.EmpleadoWS;
using WearDropWA.TipoCuentaWS;

namespace WearDropWA
{
    public partial class RegistrarCuentas : System.Web.UI.Page
    {
        // Clientes de Servicios Web
        private CuentaUsuarioWSClient boCuentaUsuario;
        private TipoCuentaWSClient boTipoCuenta;
        private EmpleadoWSClient boEmpleado;

        // Listas en memoria para validaciones rápidas
        // Usamos propiedades estáticas o ViewState si queremos persistencia, 
        // pero para este caso cargaremos en cada Load para tener datos frescos.
        private BindingList<cuentaUsuario> listaCuentas;
        private BindingList<EmpleadoWS.empleado> listaEmpleados;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Inicializar los clientes del servicio
            boCuentaUsuario = new CuentaUsuarioWSClient();
            boEmpleado = new EmpleadoWSClient();
            boTipoCuenta = new TipoCuentaWSClient();

            // Cargar listas auxiliares para las validaciones
            CargarListasAuxiliares();

            if (!IsPostBack)
            {
                // Solo cargamos el combo la primera vez que se abre la página
                CargarTiposCuenta();
            }
        }

        private void CargarListasAuxiliares()
        {
            try
            {
                // 1. Obtener Cuentas
                var arrayCuentas = boCuentaUsuario.listarCuentasUsuario();
                listaCuentas = arrayCuentas != null ? new BindingList<cuentaUsuario>(arrayCuentas) : new BindingList<cuentaUsuario>();

                // 2. Obtener Empleados
                var arrayEmpleados = boEmpleado.listarEmpleados();
                listaEmpleados = arrayEmpleados != null ? new BindingList<EmpleadoWS.empleado>(arrayEmpleados) : new BindingList<EmpleadoWS.empleado>();
            }
            catch (Exception ex)
            {
                // Si falla la conexión, inicializamos listas vacías para que no explote
                System.Diagnostics.Debug.WriteLine("Error cargando listas: " + ex.Message);
                listaCuentas = new BindingList<cuentaUsuario>();
                listaEmpleados = new BindingList<EmpleadoWS.empleado>();
            }
        }

        private void CargarTiposCuenta()
        {
            try
            {
                var tipos = boTipoCuenta.listarTiposCuenta();

                if (tipos != null && tipos.Length > 0)
                {
                    ddlTipoCuenta.DataSource = tipos;
                    ddlTipoCuenta.DataTextField = "descripcion";  // Nombre visible
                    ddlTipoCuenta.DataValueField = "idTipoCuenta"; // Valor interno (ID)
                    ddlTipoCuenta.DataBind();
                }
                else
                {
                    // Si no hay tipos en BD, agregamos uno por defecto o mostramos error
                    ddlTipoCuenta.Items.Add(new ListItem("No hay roles disponibles", "0"));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error cargando roles: " + ex.Message);
            }
        }

        protected void btnRegistrarCuenta_Click(object sender, EventArgs e)
        {
            // 1. Disparar validaciones de la página (Required, Regex, Custom)
            if (!Page.IsValid) return;

            // 2. Recuperar datos validados
            int dniIngresado = int.Parse(txtDniEmpleado.Text.Trim());

            // Buscar el ID real del empleado (idPersona) usando el DNI
            // Usamos FirstOrDefault porque el validador ya garantizó que existe
            var empleadoEncontrado = listaEmpleados.FirstOrDefault(x => x.dni == dniIngresado);

            if (empleadoEncontrado == null) return; // Seguridad extra

            // 3. Construir el objeto CuentaUsuario
            cuentaUsuario nuevaCuenta = new cuentaUsuario();

            // A) Asignar Empleado (OJO con el namespace)
            WearDropWA.CuentaUsuarioWS.empleado empParaCuenta = new WearDropWA.CuentaUsuarioWS.empleado();
            empParaCuenta.idPersona = empleadoEncontrado.idPersona;
            empParaCuenta.dni = dniIngresado;
            // Puedes copiar nombres también si el objeto lo permite

            nuevaCuenta.empleado = empParaCuenta;
            nuevaCuenta.email = txtEmail.Text.Trim();
            nuevaCuenta.username = txtUser.Text.Trim();
            nuevaCuenta.contrasenha = txtPassword.Text.Trim(); // Se envía plana, el Java la encriptará

            // B) Asignar Rol
            WearDropWA.CuentaUsuarioWS.tipoCuenta tipo = new WearDropWA.CuentaUsuarioWS.tipoCuenta();
            if (int.TryParse(ddlTipoCuenta.SelectedValue, out int idRol))
            {
                tipo.idTipoCuenta = idRol;
            }
            else
            {
                // Si no seleccionó rol válido
                return;
            }
            nuevaCuenta.tipo = tipo;

            // 4. Llamar al Servicio Web para Insertar
            try
            {
                int resultado = boCuentaUsuario.insertarCuentaUsuario(nuevaCuenta);

                if (resultado > 0)
                {
                    // Éxito -> Redirigir al Login
                    Response.Redirect("InicioSesion.aspx");
                }
                else
                {
                    // Fallo en BD (pero sin excepción)
                    MostrarAlerta("No se pudo registrar la cuenta. Intente nuevamente.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al registrar: " + ex.Message);
                MostrarAlerta("Ocurrió un error técnico al registrar.");
            }
        }

        private void MostrarAlerta(string mensaje)
        {
            string script = $"alert('{mensaje}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
        }

        // ---------------- VALIDACIONES PERSONALIZADAS ----------------

        // 1. DNI: Numérico, Existe en Empleados, No tiene Cuenta
        protected void cvDniEmpleado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string dniStr = args.Value.Trim();

            // A) Formato
            if (string.IsNullOrEmpty(dniStr) || !int.TryParse(dniStr, out int dni))
            {
                args.IsValid = false; return; // Dejar que los otros validadores manejen esto
            }

            // B) Existencia (¿Es empleado?)
            bool esEmpleado = listaEmpleados.Any(e => e.dni == dni);
            if (!esEmpleado)
            {
                args.IsValid = false;
                cvDniEmpleado.ErrorMessage = "Este DNI no corresponde a ningún empleado activo.";
                return;
            }

            // C) Unicidad (¿Ya tiene cuenta?)
            // Verificamos nulls para evitar el error que tuviste antes
            bool yaTieneCuenta = listaCuentas.Any(c => c.empleado != null && c.empleado.dni == dni);

            if (yaTieneCuenta)
            {
                args.IsValid = false;
                cvDniEmpleado.ErrorMessage = "Este empleado ya tiene una cuenta registrada.";
                return;
            }

            args.IsValid = true;
        }

        // 2. Email: Formato, Dominio, Unicidad
        protected void cvEmailUnico_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value.Trim().ToLower();

            // A) Dominio
            if (!email.EndsWith("@gmail.com") && !email.EndsWith("@hotmail.com"))
            {
                args.IsValid = false;
                cvEmailUnico.ErrorMessage = "Solo se permiten correos Gmail o Hotmail.";
                return;
            }

            // B) Unicidad
            bool existe = listaCuentas.Any(c => c.email.Trim().ToLower() == email);
            if (existe)
            {
                args.IsValid = false;
                cvEmailUnico.ErrorMessage = "Este correo ya está en uso por otro usuario.";
                return;
            }
            args.IsValid = true;
        }

        // 3. Usuario: Unicidad
        protected void cvUsuarioUnico_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string user = args.Value.Trim();

            bool existe = listaCuentas.Any(c => c.username.Trim().Equals(user, StringComparison.OrdinalIgnoreCase));

            if (existe)
            {
                args.IsValid = false;
                cvUsuarioUnico.ErrorMessage = "Este nombre de usuario ya existe.";
                return;
            }
            args.IsValid = true;
        }
    }
}