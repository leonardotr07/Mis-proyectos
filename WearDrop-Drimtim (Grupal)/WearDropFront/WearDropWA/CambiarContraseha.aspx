<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarContraseha.aspx.cs" Inherits="WearDropWA.CambiarContraseha" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar Contraseña - WearDrop</title>
    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Variables y Fuente Globales */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        :root{
            --bg:#f6f6f6;
            --card:#ffffff;
            --ink:#1f2d3a;
            --accent:#1f2d3a;
            --btn:#1f2d3a;
            --btn-hover:#15202c;
            --btn-text:#ffffff;
            --teal:#5faea6;
            --coral:#dc7a73;
            --mustard:#e6c85a;
            --navy:#22334a;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg);
            color: var(--ink);
            min-height: 100vh;
        }

        .page-wrap-content {
            position: relative;
            z-index: 100;
            min-height: 100vh;
        }

        .btn-primary {
            background-color: var(--btn);
            transition: all 0.2s ease-in-out;
            color: var(--btn-text);
        }
        .btn-primary:hover {
            background-color: var(--btn-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(31, 45, 58, 0.3);
        }

        .bubbles{
            position:absolute;
            inset:0;
            pointer-events:none;
            overflow: hidden;
            opacity: 0.5;
        }
        .bubble{
            position:absolute;
            border-radius:50%;
            opacity:.97;
            filter:drop-shadow(0 6px 12px rgba(0,0,0,.06));
            animation: moveBubble 15s infinite alternate ease-in-out;
        }

        .b-teal{background:var(--teal)} .b-coral{background:var(--coral)}
        .b-mustard{background:var(--mustard)} .b-navy{background:var(--navy)}

        .b1{width:110px;height:110px;left:7%;bottom:20%}
        .b2{width:22px;height:22px;left:2%;bottom:28%}
        .b3{width:44px;height:44px;left:18%;bottom:15%}
        .b4{width:24px;height:24px;left:30%;bottom:35%}
        .b5{width:360px;height:360px;right:-50px;bottom:-80px} 
        .b6{width:90px;height:90px;right:10%;bottom:25%}
        .b7{width:20px;height:20px;right:22%;bottom:40%}
        .b11{width:30px;height:30px;right:5%;top:45%}

        @keyframes moveBubble {
            0% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(5px, 10px) scale(1.05); }
            100% { transform: translate(0, 0) scale(1); }
        }
    </style>
</head>
<body>
    
    <form id="form1" runat="server">

        <!-- Burbujas de Fondo -->
        <div class="bubbles">
            <span class="bubble b-teal b1"></span>
            <span class="bubble b-coral b2"></span>
            <span class="bubble b-coral b3"></span>
            <span class="bubble b-mustard b4"></span>

            <span class="bubble b-navy b5" style="transform: translateX(25%) translateY(25%);"></span>
            <span class="bubble b-coral b6"></span>
            <span class="bubble b-mustard b7"></span>

            <span class="bubble b-navy b11"></span>
        </div>

        <div class="page-wrap-content p-4 sm:p-6 md:p-10 lg:p-12 mx-auto max-w-7xl">

            <!-- Botón Regresar -->
            <a href="Configuraciones.aspx" class="inline-flex items-center text-[var(--ink)] hover:text-[var(--accent)] font-semibold mb-6 transition duration-150">
                <i class="fas fa-arrow-left mr-2"></i>
                <span>Regresar</span>
            </a>

            <!-- Encabezado de la Página -->
            <div class="mb-8">
                <h1 class="text-3xl font-extrabold text-[var(--ink)] tracking-tight">Cambiar Contraseña</h1>
                <p class="text-gray-500 mt-1">Asegura tu cuenta estableciendo una nueva contraseña.</p>
            </div>

            <!-- Card Centrada -->
            <div class="grid grid-cols-1 mx-auto max-w-lg">
                <div class="bg-white rounded-2xl shadow-[0_16px_30px_rgba(0,0,0,0.07),0_2px_8px_rgba(0,0,0,0.05)] p-5 md:p-6">
                    <div class="flex items-center mb-6 border-b pb-4">
                        <i class="fas fa-key text-2xl text-[var(--accent)] mr-3"></i>
                        <h2 class="text-xl font-bold text-[var(--ink)]">Actualizar Contraseña</h2>
                    </div>

                    <div class="grid grid-cols-1 gap-6">
                        <!-- Campo 1: Nueva Contraseña -->
                        <div>
                            <label for="txtNewPassword" class="block text-sm font-medium text-gray-700 mb-1">
                                Nueva Contraseña
                            </label>
                            <input runat="server" type="password" id="txtNewPassword"
                                class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-white text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                        </div>

                        <!-- Campo 2: Verificar Contraseña -->
                        <div>
                            <label for="txtConfirmPassword" class="block text-sm font-medium text-gray-700 mb-1">
                                Verificar Contraseña
                            </label>
                            <input runat="server" type="password" id="txtConfirmPassword"
                                class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-white text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                            <p id="passwordError" class="text-red-500 text-sm mt-2 hidden"></p>
                        </div>
                    </div>

                    <!-- Botón Guardar -->
                    <div class="flex justify-center mt-8 pt-4 border-t border-gray-100">
                        <asp:LinkButton ID="btnGuardar" runat="server"
                            OnClick="btnGuardar_Click"
                            OnClientClick="return validatePassword();"
                            CssClass="btn-primary px-8 py-3 font-semibold rounded-xl shadow-lg hover:shadow-xl 
                                      focus:outline-none focus:ring-2 focus:ring-[var(--accent)] focus:ring-offset-2 
                                      flex items-center">
                            <i class="fas fa-save mr-2"></i>
                            <span>Guardar</span>
                        </asp:LinkButton>
                    </div>

                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script type="text/javascript">
            function validatePassword() {
                const newPass = document.getElementById('<%= txtNewPassword.ClientID %>').value;
                const confirmPass = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
                const errorElement = document.getElementById('passwordError');

                if (newPass !== confirmPass) {
                    errorElement.classList.remove('hidden');
                    errorElement.textContent = "Las contraseñas no coinciden. Por favor, verifica.";
                    return false; // NO hace postback
                } else if (newPass.length < 6) {
                    errorElement.classList.remove('hidden');
                    errorElement.textContent = "La contraseña debe tener al menos 6 caracteres.";
                    return false;
                }

                // Todo bien, se oculta el error y se permite el postback
                errorElement.classList.add('hidden');
                return true;
            }

            function alertMessage(message, type) {
                const body = document.body;
                const existingAlert = document.getElementById('customAlert');
                if (existingAlert) existingAlert.remove();

                const alertDiv = document.createElement('div');
                alertDiv.id = 'customAlert';
                alertDiv.className = 'fixed top-0 left-1/2 transform -translate-x-1/2 mt-4 px-6 py-3 rounded-xl text-white shadow-xl z-[300] transition-opacity duration-300';

                let bgColor = 'bg-blue-500';
                if (type === 'success') bgColor = 'bg-green-600';
                if (type === 'error') bgColor = 'bg-red-600';
                if (type === 'warning') bgColor = 'bg-yellow-600';

                alertDiv.classList.add(bgColor);
                alertDiv.innerHTML = '<i class="fas fa-info-circle mr-2"></i> ' + message;

                body.appendChild(alertDiv);

                setTimeout(() => {
                    alertDiv.style.opacity = '0';
                    setTimeout(() => alertDiv.remove(), 300);
                }, 3000);
            }
        </script>
    </form>
</body>
</html>
