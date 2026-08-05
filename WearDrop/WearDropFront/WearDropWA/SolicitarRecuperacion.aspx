<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SolicitarRecuperacion.aspx.cs" Inherits="WearDropWA.SolicitarRecuperacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Recuperar Contraseña - WearDrop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <style>
        /* --- VARIABLES DE DISEÑO (Idéntico al Login) --- */
        :root {
            --bg: #f6f6f6; --card: #ffffff; --ink: #1f2d3a;
            --accent: #1f2d3a; --btn: #1f2d3a; --btn-hover: #15202c; --btn-text: #ffffff;
            --teal: #5faea6; --coral: #dc7a73; --mustard: #e6c85a; --navy: #22334a;
        }
        
        html, body { height: 100%; background: var(--bg); color: var(--ink); font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
        .page-wrap { position: relative; min-height: 100vh; overflow: hidden; }

        /* --- BURBUJAS DE FONDO --- */
        .bubbles { position: absolute; inset: 0; pointer-events: none; z-index: 0; }
        .bubble { position: absolute; border-radius: 50%; opacity: .97; filter: drop-shadow(0 6px 12px rgba(0,0,0,.06)); }
        .b-teal { background: var(--teal); } .b-coral { background: var(--coral); }
        .b-mustard { background: var(--mustard); } .b-navy { background: var(--navy); }
        
        /* Posiciones (mismas del login) */
        .b1 { width: 110px; height: 110px; left: 70px; bottom: 120px; }
        .b2 { width: 22px; height: 22px; left: 24px; bottom: 185px; }
        .b3 { width: 44px; height: 44px; left: 210px; bottom: 95px; }
        .b4 { width: 24px; height: 24px; left: 320px; bottom: 170px; }
        .b5 { width: 360px; height: 360px; right: -100px; bottom: -80px; }
        .b6 { width: 90px; height: 90px; right: 130px; bottom: 85px; }
        .b7 { width: 20px; height: 20px; right: 210px; bottom: 220px; }
        .b8 { width: 18px; height: 18px; right: 270px; top: 300px; }
        .b9 { width: 20px; height: 20px; left: 90px; top: 340px; }

        /* --- MARCA --- */
        .brand { display: flex; align-items: center; justify-content: center; gap: 12px; margin-bottom: 20px; position: relative; z-index: 10; }
        .brand img.logo { width: 80px; height: 80px; object-fit: contain; display: block; }
        .brand .brand-title { font-size: 36px; font-weight: 700; color: var(--accent); letter-spacing: .2px; }

        /* --- TARJETA (CARD) --- */
        .recovery-card {
            width: 100%; max-width: 460px; background: var(--card); border-radius: 16px;
            padding: 40px 30px; 
            box-shadow: 0 16px 30px rgba(0,0,0,.07), 0 2px 8px rgba(0,0,0,.05);
            border: 1px solid rgba(0,0,0,.04); margin-inline: auto;
            
            /* IMPORTANTE: Z-INDEX PARA QUE FUNCIONEN LOS CLICS */
            position: relative; z-index: 100; 
        }

        .card-title { font-size: 24px; font-weight: 700; color: var(--ink); margin-bottom: 10px; text-align: center; }
        .card-subtitle { font-size: 14px; color: #6c757d; text-align: center; margin-bottom: 25px; line-height: 1.5; }

        /* --- CONTROLES --- */
        .form-label { font-weight: 600; font-size: 14px; color: var(--ink); }
        .form-control { height: 46px; border-radius: 12px; border: 1px solid #e7e7e7; background: #fff; padding-left: 15px; }
        .form-control:focus { border-color: var(--teal); box-shadow: 0 0 0 .2rem rgba(95, 174, 166, 0.2); }

        /* Botón Principal */
        .btn-submit {
            height: 48px; border-radius: 12px; background: var(--btn); border: none;
            color: var(--btn-text); font-weight: 700; letter-spacing: .3px; width: 100%;
            margin-top: 10px; transition: all 0.2s ease;
        }
        .btn-submit:hover { background: var(--btn-hover); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(31, 45, 58, 0.2); }
        .btn-submit:disabled { opacity: 0.7; cursor: not-allowed; transform: none; }

        /* Link de Volver */
        .back-link { display: block; text-align: center; margin-top: 25px; font-size: 14px; }
        .back-link a { color: var(--navy); text-decoration: none; font-weight: 600; }
        .back-link a:hover { color: var(--teal); text-decoration: underline; }

        /* --- MENSAJES DE ALERTA MEJORADOS --- */
        .alert-custom {
            padding: 15px; border-radius: 10px; font-size: 14px; margin-bottom: 20px;
            display: flex; align-items: start; gap: 10px; line-height: 1.4;
        }
        /* Estilos específicos para tipos de alerta */
        .alert-danger { background-color: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .alert-success { background-color: #d1fae5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-warning { background-color: #fef3c7; color: #92400e; border: 1px solid #fde68a; }

        .icon-header { font-size: 40px; color: var(--teal); margin-bottom: 15px; text-align: center; display: block;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrap d-flex flex-column justify-content-center align-items-center">
            
            <div class="brand">
                <img src="<%= ResolveUrl("~/images/logo.png") %>" alt="WearDrop" class="logo" />
                <div class="brand-title">WearDrop</div>
            </div>

            <div class="recovery-card">
                <div class="icon-header">
                    <i class="fas fa-envelope-open-text"></i>
                </div>
                <h2 class="card-title">¿Olvidaste tu contraseña?</h2>
                <p class="card-subtitle">No te preocupes. Ingresa tu correo electrónico y te enviaremos las instrucciones para recuperarla.</p>

                <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
                    <asp:Label ID="lblMensaje" runat="server" CssClass="alert-custom w-100"></asp:Label>
                </asp:Panel>

                <div class="mb-3 text-start">
                    <label for="txtEmail" class="form-label">Correo Electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                 placeholder="ejemplo@correo.com" TextMode="Email" required="required"></asp:TextBox>
                </div>

                <asp:Button ID="btnEnviar" runat="server" Text="Enviar Enlace" 
                            CssClass="btn btn-submit" OnClick="btnEnviar_Click" />

                <div class="back-link">
                    <a href="InicioSesion.aspx"><i class="fas fa-arrow-left me-1"></i> Volver al inicio de sesión</a>
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
</body>
</html>