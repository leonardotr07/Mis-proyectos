using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.CuentaUsuarioWS;
using WearDropWA.EmpleadoWS;

namespace WearDropWA
{
    public partial class InicioSesion : System.Web.UI.Page
    {
        private CuentaUsuarioWSClient boCuentaUsuario;
        private EmpleadoWSClient boEmpleado;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Limpiar mensaje al cargar la página
                lblMensaje.Text = "";
                lblMensaje.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Limpiar mensaje previo
                lblMensaje.Text = "";
                lblMensaje.Visible = false;

                // Validar que los campos no estén vacíos
                if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    MostrarError("Por favor, ingrese usuario y contraseña.");
                    return;
                }

                cuentaUsuario cu = new cuentaUsuario();
                cu.username = txtUsername.Text.Trim();
                cu.contrasenha = txtPassword.Text.Trim();

                boCuentaUsuario = new CuentaUsuarioWSClient();
                int resultado = boCuentaUsuario.verificarCuentaUsuario(cu);

                if (resultado != 0)
                {
                    // Login 
                    cuentaUsuario cuentaCompleta = boCuentaUsuario.obtenerCuentaUsuarioPorId(resultado);

                    if (cuentaCompleta == null)
                    {
                        MostrarError("Error al obtener información de la cuenta de usuario.");
                        return;
                    }

                    //Asignacion de rol
                    String rol = "Almacenero";
                    if (cuentaCompleta.tipo.descripcion == "Administrador")
                    {
                        rol = "Administrador";
                    }

                    // Guardar la cuenta de usuario en la sesión
                    Session["cuentaUsuario"] = cuentaCompleta;

                    // Obtener información del empleado
                    boEmpleado = new EmpleadoWSClient();
                    WearDropWA.EmpleadoWS.empleado empleadoLog = boEmpleado.obtenerEmpleadoPorId(cuentaCompleta.empleado.idPersona);


                    if (empleadoLog == null)
                    {
                        MostrarError("Error al obtener información del empleado.");
                        return;
                    }

                    empleadoLog.idEmpleado = empleadoLog.idPersona;

                    // Guardar también el empleado (por si se necesita en otras páginas)
                    Session["empleadoLog"] = empleadoLog;

                    // Crear ticket de autenticación
                    FormsAuthenticationTicket tkt = new FormsAuthenticationTicket(
                        1,
                        cu.username,
                        DateTime.Now,
                        DateTime.Now.AddMinutes(30),
                        true,
                        rol
                    );

                    string cookiestr = FormsAuthentication.Encrypt(tkt);
                    HttpCookie ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                    ck.Expires = tkt.Expiration;
                    ck.Path = FormsAuthentication.FormsCookiePath;
                    Response.Cookies.Add(ck);

                    string strRedirect = Request["ReturnUrl"];
                    if (string.IsNullOrEmpty(strRedirect))
                        strRedirect = "Home.aspx";

                    // 🔹 Ajuste clave:
                    if (rol == "Almacenero")
                    {
                        // Nunca lo regreses a una URL "vieja" que quizá no le pertenece
                        strRedirect = "Home.aspx";
                    }

                    Response.Redirect(strRedirect, true);
                }
                else
                {
                    // Login fallido - Credenciales incorrectas
                    MostrarError("Usuario o contraseña incorrectos. Por favor, intente nuevamente.");

                    // Limpiar solo el campo de contraseña por seguridad
                    txtPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                // Error inesperado
                MostrarError("Ocurrió un error al intentar iniciar sesión. Por favor, intente más tarde.");

                // Log del error (opcional - para debugging)
                System.Diagnostics.Debug.WriteLine($"Error en login: {ex.Message}");
            }
            finally
            {
                // Cerrar conexiones
                if (boCuentaUsuario != null)
                {
                    try { boCuentaUsuario.Close(); } catch { }
                }
                if (boEmpleado != null)
                {
                    try { boEmpleado.Close(); } catch { }
                }
            }
        }

        /// <summary>
        /// Muestra un mensaje de error en el Label
        /// </summary>
        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
            lblMensaje.CssClass = "text-danger d-block text-center mb-2";
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCuentas.aspx");
        }
    }
}