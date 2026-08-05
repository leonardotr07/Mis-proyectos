<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContrasena.aspx.cs" Inherits="WearDropWA.RecuperarContrasena" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Restablecer Contraseña - WearDrop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <style>
        /* Copiamos las mismas variables para consistencia */
        :root {
            --bg: #f6f6f6; --card: #ffffff; --ink: #1f2d3a;
            --accent: #1f2d3a; --btn: #1f2d3a; --btn-hover: #15202c; --btn-text: #ffffff;
            --teal: #5faea6; --coral: #dc7a73; --mustard: #e6c85a; --navy: #22334a;
        }
        
        html, body { height: 100%; background: var(--bg); color: var(--ink); font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
        .page-wrap { position: relative; min-height: 100vh; overflow: hidden; }

        /* Burbujas */
        .bubbles { position: absolute; inset: 0; pointer-events: none; z-index: 0; }
        .bubble { position: absolute; border-radius: 50%; opacity: .97; filter: drop-shadow(0 6px 12px rgba(0,0,0,.06)); }
        .b-teal { background: var(--teal); } .b-coral { background: var(--coral); }
        .b-mustard { background: var(--mustard); } .b-navy { background: var(--navy); }
        
        /* Posiciones */
        .b1 { width: 110px; height: 110px; left: 70px; bottom: 120px; }
        .b2 { width: 22px; height: 22px; left: 24px; bottom: 185px; }
        .b3 { width: 44px; height: 44px; left: 210px; bottom: 95px; }
        .b4 { width: 24px; height: 24px; left: 320px; bottom: 170px; }
        .b5 { width: 360px; height: 360px; right: -100px; bottom: -80px; }
        .b6 { width: 90px; height: 90px; right: 130px; bottom: 85px; }
        .b7 { width: 20px; height: 20px; right: 210px; bottom: 220px; }
        .b8 { width: 18px; height: 18px; right: 270px; top: 300px; }
        .b9 { width: 20px; height: 20px; left: 90px; top: 340px; }

        /* Marca */
        .brand { display: flex; align-items: center; justify-content: center; gap: 12px; margin-bottom: 20px; position: relative; z-index: 10; }
        .brand img.logo { width: 80px; height: 80px; object-fit: contain; display: block; }
        .brand .brand-title { font-size: 36px; font-weight: 700; color: var(--accent); letter-spacing: .2px; }

        /* Tarjeta */
        .reset-card {
            width: 100%; max-width: 460px; background: var(--card); border-radius: 16px;
            padding: 40px 30px; 
            box-shadow: 0 16px 30px rgba(0,0,0,.07), 0 2px 8px rgba(0,0,0,.05);
            border: 1px solid rgba(0,0,0,.04); margin-inline: auto;
            position: relative; z-index: 100; /* Vital para clics */
        }

        .card-title { font-size: 24px; font-weight: 700; color: var(--ink); margin-bottom: 10px; text-align: center; }
        .card-subtitle { font-size: 14px; color: #6c757d; text-align: center; margin-bottom: 25px; }

        /* Inputs y Labels */
        .form-label { font-weight: 600; font-size: 14px; color: var(--ink); }
        .form-control { height: 46px; border-radius: 12px; border: 1px solid #e7e7e7; background: #fff; padding-right: 45px; /* Espacio para el ojo */ }
        .form-control:focus { border-color: var(--teal); box-shadow: 0 0 0 .2rem rgba(95, 174, 166, 0.2); }

        /* Icono de Ojo */
        .password-wrapper { position: relative; }
        .password-toggle {
            position: absolute; right: 15px; top: 38px; /* Ajustado */
            color: #999; cursor: pointer; font-size: 16px; z-index: 10;
        }
        .password-toggle:hover { color: var(--ink); }

        .password-requirements { font-size: 12px; color: #6c757d; margin-top: 5px; display: flex; align-items: center; gap: 5px; }

        /* Botón */
        .btn-submit {
            height: 48px; border-radius: 12px; background: var(--btn); border: none;
            color: var(--btn-text); font-weight: 700; letter-spacing: .3px; width: 100%;
            margin-top: 20px; transition: all 0.2s ease;
        }
        .btn-submit:hover { background: var(--btn-hover); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(31, 45, 58, 0.2); }

        /* Mensajes */
        .alert-custom {
            padding: 15px; border-radius: 10px; font-size: 14px; margin-bottom: 20px;
            display: block; line-height: 1.4; border: 1px solid transparent;
        }
        .alert-danger { background-color: #fee2e2; color: #991b1b; border-color: #fecaca; }
        .alert-success { background-color: #d1fae5; color: #065f46; border-color: #a7f3d0; }
        .alert-warning { background-color: #fef3c7; color: #92400e; border-color: #fde68a; }

        .icon-header { font-size: 40px; color: var(--mustard); margin-bottom: 15px; text-align: center; display: block;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrap d-flex flex-column justify-content-center align-items-center">
            
            <div class="brand">
                <img src="<%= ResolveUrl("~/images/logo.png") %>" alt="WearDrop" class="logo" />
                <div class="brand-title">WearDrop</div>
            </div>

            <div class="reset-card">
                <div class="icon-header">
                    <i class="fas fa-lock"></i>
                </div>
                <h2 class="card-title">Restablecer Contraseña</h2>
                <p class="card-subtitle">Crea una nueva contraseña segura para tu cuenta.</p>

                <asp:Label ID="lblMensaje" runat="server" Visible="false" CssClass="alert-custom w-100"></asp:Label>

                <asp:Panel ID="pnlFormulario" runat="server" Visible="true">
                    <div class="mb-3 password-wrapper">
                        <label for="txtNuevaContrasena" class="form-label">Nueva Contraseña</label>
                        <asp:TextBox ID="txtNuevaContrasena" runat="server" CssClass="form-control" 
                                     TextMode="Password" placeholder="********" required="required"></asp:TextBox>
                        <span class="password-toggle" onclick="togglePassword('txtNuevaContrasena', this)">
                            <i class="far fa-eye"></i>
                        </span>
                        <div class="password-requirements">
                            <i class="fas fa-info-circle"></i> Mínimo 6 caracteres
                        </div>
                    </div>

                    <div class="mb-3 password-wrapper">
                        <label for="txtConfirmarContrasena" class="form-label">Confirmar Contraseña</label>
                        <asp:TextBox ID="txtConfirmarContrasena" runat="server" CssClass="form-control" 
                                     TextMode="Password" placeholder="********" required="required"></asp:TextBox>
                        <span class="password-toggle" onclick="togglePassword('txtConfirmarContrasena', this)">
                            <i class="far fa-eye"></i>
                        </span>
                    </div>

                    <asp:Button ID="btnRestablecer" runat="server" Text="Cambiar Contraseña" 
                                CssClass="btn btn-submit" OnClick="btnRestablecer_Click" />
                </asp:Panel>

                <div class="text-center mt-4">
                    <a href="InicioSesion.aspx" class="text-decoration-none" style="color: var(--navy); font-weight: 600; font-size: 14px;">
                        ← Cancelar y volver
                    </a>
                </div>
            </div>

            <div class="bubbles">
                <span class="bubble b-teal    b1"></span>
                <span class="bubble b-coral   b2"></span>
                <span class="bubble b-coral   b3"></span>
                <span class="bubble b-mustard b4"></span>
                <span class="bubble b-navy    b5"></span>
                <span class="bubble b-coral   b6"></span>
                <span class="bubble b-mustard b7"></span>
                <span class="bubble b-teal    b8"></span>
                <span class="bubble b-mustard b9"></span>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(inputId, iconSpan) {
            var input = document.getElementById(inputId);
            var icon = iconSpan.querySelector('i');

            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = "password";
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>