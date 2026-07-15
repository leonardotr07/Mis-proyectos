<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrarCuentas.aspx.cs" Inherits="WearDropWA.RegistrarCuentas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Registrar Cuenta - WearDrop</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

  <style>
    :root {
      --bg:#f6f6f6; --card:#ffffff; --ink:#1f2d3a;
      --accent:#1f2d3a; --btn:#1f2d3a; --btn-hover:#15202c; --btn-text:#ffffff;
      --teal:#5faea6; --coral:#dc7a73; --mustard:#e6c85a; --navy:#22334a;
    }
    html,body{height:100%;background:var(--bg);color:var(--ink);font-family:system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif}
    .page-wrap{position:relative;min-height:100vh;overflow:hidden}

    /* Burbujas */
    .bubbles{position:absolute;inset:0;pointer-events:none; z-index:0;}
    .bubble{position:absolute;border-radius:50%;opacity:.97;filter:drop-shadow(0 6px 12px rgba(0,0,0,.06))}
    .b-teal{background:var(--teal)} .b-coral{background:var(--coral)}
    .b-mustard{background:var(--mustard)} .b-navy{background:var(--navy)}
    
    /* Posiciones burbujas */
    .b1{width:110px;height:110px;left:70px;bottom:120px} .b2{width:22px;height:22px;left:24px;bottom:185px}
    .b3{width:44px;height:44px;left:210px;bottom:95px} .b4{width:24px;height:24px;left:320px;bottom:170px}
    .b5{width:360px;height:360px;right:-100px;bottom:-80px} .b6{width:90px;height:90px;right:130px;bottom:85px}
    .b7{width:20px;height:20px;right:210px;bottom:220px} .b8{width:18px;height:18px;right:270px;top:300px}
    .b9{width:20px;height:20px;left:90px;top:340px}

    /* Marca */
    .brand{display:flex;align-items:center;justify-content:center;gap:12px;margin-bottom:20px; position: relative; z-index: 10;}
    .brand img.logo{width:80px;height:80px;object-fit:contain;display:block}
    .brand .brand-title{font-size:36px;font-weight:700;color:var(--accent);letter-spacing:.2px}

    /* Tarjeta */
    .register-card{
      width:100%; max-width:480px; background:var(--card); border-radius:16px;
      padding:30px; 
      box-shadow:0 16px 30px rgba(0,0,0,.07),0 2px 8px rgba(0,0,0,.05);
      border:1px solid rgba(0,0,0,.04); margin-inline:auto;
      position: relative; z-index: 100;
    }
    .register-title{font-size:24px;text-align:center;margin:0 0 25px;font-weight:700;color:var(--ink);}
    
    .form-label{font-weight:600; font-size: 14px; color: var(--ink);}
    .form-control{height:46px; border-radius:10px; border:1px solid #e0e0e0; background:#fff; padding-left: 15px;}
    .form-control:focus{border-color:var(--teal); box-shadow:0 0 0 .2rem rgba(95, 174, 166, 0.2)}

    /* Botón Registrar */
    .btn-register{
      height:48px; border-radius:10px; background:var(--teal); border:none;
      color:#fff; font-weight:700; letter-spacing:.3px; width: 100%; margin-top: 10px;
      transition: all 0.2s;
    }
    .btn-register:hover { background: #4d9b8f; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(95, 174, 166, 0.3); }

    .help-link{color:var(--teal); text-decoration:none; font-weight: 600;}
    .help-link:hover{text-decoration:underline; color: var(--navy);}

    /* Estilos para Validadores */
    .validator-msg {
        font-size: 12px; display: block; margin-top: 4px; color: #dc3545;
        background: #fff5f5; padding: 4px 8px; border-radius: 4px; border-left: 3px solid #dc3545;
    }
  </style>
</head>
<body>
  <form id="formRegister" runat="server">
    <div class="page-wrap d-flex flex-column justify-content-center align-items-center">

      <div class="brand">
        <img src="<%= ResolveUrl("~/images/logo.png") %>" alt="Logo" class="logo" />
        <div class="brand-title">WearDrop</div>
      </div>

      <div class="register-card">
        <h1 class="register-title">Crear Nueva Cuenta</h1>

        <div class="mb-3">
          <label for="txtDniEmpleado" class="form-label">DNI Empleado</label>
          <asp:TextBox ID="txtDniEmpleado" runat="server" CssClass="form-control" placeholder="8 dígitos" MaxLength="8" />
          <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDniEmpleado" 
              ErrorMessage="El DNI es obligatorio." CssClass="validator-msg" Display="Dynamic" />
          <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDniEmpleado"
              ValidationExpression="^\d{8}$" ErrorMessage="El DNI debe tener 8 dígitos numéricos." 
              CssClass="validator-msg" Display="Dynamic" />
          <asp:CustomValidator ID="cvDniEmpleado" runat="server" ControlToValidate="txtDniEmpleado"
              CssClass="validator-msg" Display="Dynamic" ValidateEmptyText="true" 
              OnServerValidate="cvDniEmpleado_ServerValidate" />
        </div>

        <div class="mb-3">
            <label for="txtEmail" class="form-label">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ejemplo@gmail.com" TextMode="Email"/>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="El email es obligatorio." CssClass="validator-msg" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmailFormat" runat="server" ControlToValidate="txtEmail"
                ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Formato de correo inválido."
                CssClass="validator-msg" Display="Dynamic" />
            <asp:CustomValidator ID="cvEmailUnico" runat="server" ControlToValidate="txtEmail"
                CssClass="validator-msg" Display="Dynamic" OnServerValidate="cvEmailUnico_ServerValidate" />
        </div>

        <div class="mb-3">
          <label for="txtUser" class="form-label">Usuario</label>
          <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
          <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUser"
              ErrorMessage="El usuario es obligatorio." CssClass="validator-msg" Display="Dynamic" />
          <asp:CustomValidator ID="cvUsuarioUnico" runat="server" ControlToValidate="txtUser"
              CssClass="validator-msg" Display="Dynamic" OnServerValidate="cvUsuarioUnico_ServerValidate" />
        </div>

        <div class="mb-3">
          <label for="txtPassword" class="form-label">Contraseña</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Mínimo 6 caracteres" />
          <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
              ErrorMessage="La contraseña es obligatoria." CssClass="validator-msg" Display="Dynamic" />
          <asp:RegularExpressionValidator ID="revPassLength" runat="server" ControlToValidate="txtPassword"
              ValidationExpression="^.{6,}$" ErrorMessage="La contraseña debe tener al menos 6 caracteres."
              CssClass="validator-msg" Display="Dynamic" />
        </div>

        <div class="mb-4">
          <label for="ddlTipoCuenta" class="form-label">Rol de Usuario</label>
          <asp:DropDownList ID="ddlTipoCuenta" runat="server" CssClass="form-select" style="height: 46px; border-radius: 10px;">
          </asp:DropDownList>
        </div>

        <asp:Button ID="btnRegistrarCuenta" runat="server" Text="Registrarme" CssClass="btn btn-register" OnClick="btnRegistrarCuenta_Click" />

        <div class="text-center mt-3">
          <small class="text-muted">¿Ya tienes cuenta? <a href="InicioSesion.aspx" class="help-link">Inicia sesión aquí</a></small>
        </div>
      </div>

      <div class="bubbles">
        <span class="bubble b-teal    b1"></span> <span class="bubble b-coral   b2"></span>
        <span class="bubble b-coral   b3"></span> <span class="bubble b-mustard b4"></span>
        <span class="bubble b-navy    b5"></span> <span class="bubble b-coral   b6"></span>
        <span class="bubble b-mustard b7"></span> <span class="bubble b-teal    b8"></span>
        <span class="bubble b-mustard b9"></span>
      </div>
    </div>
  </form>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>