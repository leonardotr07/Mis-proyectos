<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Configuraciones.aspx.cs" Inherits="WearDropWA.Configuraciones" %>

<!DOCTYPE html>
<html lang="es" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Configuración de Cuenta - WearDrop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
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
        .b5{width:360px;height:360px;right:0px;bottom:0px; transform: translateX(25%) translateY(25%);}
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

        <!-- Burbujas -->
        <div class="bubbles">
            <span class="bubble b-teal b1"></span>
            <span class="bubble b-coral b2"></span>
            <span class="bubble b-coral b3"></span>
            <span class="bubble b-mustard b4"></span>
            <span class="bubble b-navy b5"></span>
            <span class="bubble b-coral b6"></span>
            <span class="bubble b-mustard b7"></span>
            <span class="bubble b-navy b11"></span>
        </div>

        <!-- Contenido -->
        <div class="page-wrap-content p-4 sm:p-6 md:p-10 lg:p-12 mx-auto max-w-7xl">

            <!-- Regresar -->
            <a href="/Home.aspx" class="inline-flex items-center text-[var(--ink)] hover:text-[var(--accent)] font-semibold mb-6 transition duration-150">
                <i class="fas fa-arrow-left mr-2"></i>
                <span>Regresar</span>
            </a>

            <!-- Encabezado -->
            <div class="mb-8">
                <h1 class="text-3xl font-extrabold text-[var(--ink)] tracking-tight">Configuración de la Cuenta</h1>
                <p class="text-gray-500 mt-1">Administra tu información personal y opciones de seguridad.</p>
            </div>

            <!-- Cards -->
            <div class="grid grid-cols-1 gap-8 mx-auto max-w-4xl">

                <!-- CARD 1 -->
                <div class="bg-white rounded-2xl shadow-[0_16px_30px_rgba(0,0,0,0.07),0_2px_8px_rgba(0,0,0,0.05)] p-5 md:p-6">
                    <div class="flex items-center mb-6 border-b pb-4">
                        <i class="fas fa-user-circle text-2xl text-[var(--accent)] mr-3"></i>
                        <h2 class="text-xl font-bold text-[var(--ink)]">Datos Personales</h2>
                    </div>

                    <div id="userInfoForm">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Usuario -->
                            <div>
                                <label for="txtUsuario" class="block text-sm font-medium text-gray-700 mb-1">Usuario</label>
                                <input runat="server" id="txtUsuario" type="text" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                                <asp:Label ID="lblMensajeUsuario" runat="server" CssClass="mt-2 d-block"></asp:Label>
                            </div>
                            <!-- Contraseña -->
                            <div>
                                <label for="txtPassword" class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                                <input id="txtPassword" type="password" value="******" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                            </div>
                            <!-- Email -->
                            <div>
                                <label for="txtEmail" class="block text-sm font-medium text-gray-700 mb-1">Correo Electrónico</label>
                                <input runat="server" id="txtEmail" type="email" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                                <asp:Label ID="lblMensajeEmail" runat="server" CssClass="mt-2 d-block"></asp:Label>
                            </div>
                            <!-- Tipo de cuenta -->
                            <div>
                                <label for="txtTipoCuenta" class="block text-sm font-medium text-gray-700 mb-1">Tipo de Cuenta</label>
                                <input runat="server" id="txtTipoCuenta" type="text" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                            </div>
                            <!-- Nombre -->
                            <div>
                                <label for="txtNombre" class="block text-sm font-medium text-gray-700 mb-1">Nombre Completo</label>
                                <input runat="server" id="txtNombre" type="text" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                            </div>
                            <!-- DNI -->
                            <div>
                                <label for="txtDni" class="block text-sm font-medium text-gray-700 mb-1">DNI</label>
                                <input runat="server" id="txtDni" type="text" readonly
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 text-[var(--ink)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)] transition duration-150" />
                            </div>
                        </div>

                        <!-- Botón Modificar -->
                        <div class="flex justify-between mt-8 pt-4 border-t border-gray-100 gap-x-10">

                            <!-- LinkButton Cambiar Contraseña (izquierda) -->
                            <asp:LinkButton ID="btnCambiarContrasena" runat="server"
                                OnClick="btnCambiarContrasena_Click"
                                CssClass="px-6 py-3 bg-gray-200 text-[var(--ink)] font-semibold rounded-xl shadow 
                   hover:bg-gray-300 transition duration-150 flex items-center">
        <i class="fas fa-key mr-2"></i>
        <span>Cambiar Contraseña</span>
                            </asp:LinkButton>

                            <!-- Botón Modificar (derecha) -->
                            <asp:LinkButton ID="btnModificar" runat="server"
                                OnClientClick="return onModificarClick();"
                                OnClick="btnModificar_Click"
                                CssClass="btn-primary px-6 py-3 font-semibold rounded-xl shadow-lg hover:shadow-xl 
                  focus:outline-none focus:ring-2 focus:ring-[var(--accent)] focus:ring-offset-2 
                  flex items-center">
        <i class="fas fa-edit mr-2"></i>
        <span>Modificar</span>
                            </asp:LinkButton>

                        </div>
                    </div>
                </div>

                <!-- CARD 2 -->
                <div>
                    <div class="bg-white rounded-2xl shadow-[0_16px_30px_rgba(0,0,0,0.07),0_2px_8px_rgba(0,0,0,0.05)] p-5 md:p-6 h-full flex flex-col justify-between">
                        <div>
                            <div class="flex items-center mb-6 border-b pb-4 border-red-100">
                                <i class="fas fa-shield-alt text-2xl text-red-500 mr-3"></i>
                                <h2 class="text-xl font-bold text-[var(--ink)]">Gestión de Cuenta</h2>
                            </div>
                            
                            <p class="text-gray-600 mb-6">
                                Esta acción es permanente y eliminará todos los datos asociados a tu tienda. Procede con precaución.
                            </p>
                        </div>

                        <div class="mt-auto">
                            <button type="button" onclick="showDeleteModal()"
                                    class="w-full px-6 py-3 bg-red-600 text-white font-bold rounded-xl shadow-lg hover:bg-red-700 transition duration-150 ease-in-out hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 flex items-center justify-center">
                                <i class="fas fa-trash-alt mr-2"></i>
                                Eliminar Cuenta
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- MODAL -->
        <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[200] hidden" onclick="hideDeleteModal()">
            <div class="bg-white p-8 rounded-2xl shadow-2xl w-full max-w-md m-4" onclick="event.stopPropagation()">
                <div class="text-center">
                    <i class="fas fa-exclamation-triangle text-5xl text-red-500 mb-4 animate-pulse"></i>
                    <h3 class="text-2xl font-bold text-[var(--ink)] mb-2">Confirmar Eliminación</h3>
                    <p class="text-gray-600 mb-6">¿Estás absolutamente seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer.</p>
                </div>

                <div class="flex justify-end space-x-4">
                    <button type="button" onclick="hideDeleteModal()"
                            class="px-5 py-2 text-sm font-semibold text-gray-600 bg-gray-200 rounded-xl hover:bg-gray-300 transition duration-150">
                        Cancelar
                    </button>
                    <button type="button" onclick="executeDeleteAccount()"
                            class="px-5 py-2 text-sm font-semibold text-white bg-red-600 rounded-xl hover:bg-red-700 transition duration-150">
                        Sí, Eliminar Permanentemente
                    </button>
                </div>
            </div>
        </div>

        <asp:LinkButton ID="btnEliminarCuenta" runat="server"
            OnClick="btnEliminarCuenta_Click"
            Style="display: none;">
        </asp:LinkButton>

    </form>

    <script>
        function toggleEditMode() {
            // Solo estos dos campos serán editables
            const editableFields = [
                document.getElementById('<%= txtUsuario.ClientID %>'),
        document.getElementById('<%= txtEmail.ClientID %>')
    ];

            const btn = document.getElementById('<%= btnModificar.ClientID %>');
            const isSaving = btn.textContent.includes('Guardar');

            // HABILITAR / DESHABILITAR SOLO ESTOS 2 CAMPOS
            editableFields.forEach(input => {
                input.readOnly = isSaving;
                if (!isSaving) {
                    input.classList.add('bg-white', 'border-[var(--accent)]');
                    input.classList.remove('bg-gray-50', 'border-gray-200');
                } else {
                    input.classList.remove('bg-white', 'border-[var(--accent)]');
                    input.classList.add('bg-gray-50', 'border-gray-200');
                }
            });

            // LOS DEMÁS SIEMPRE READONLY
            const allInputs = document.querySelectorAll('#userInfoForm input');
            allInputs.forEach(input => {
                if (!editableFields.includes(input)) {
                    input.readOnly = true;
                    input.classList.add('bg-gray-50', 'border-gray-200');
                    input.classList.remove('bg-white', 'border-[var(--accent)]');
                }
            });

            // Cambiar texto del botón
            if (isSaving) {
                btn.innerHTML = '<i class="fas fa-edit mr-2"></i><span>Modificar</span>';
            } else {
                btn.innerHTML = '<i class="fas fa-save mr-2"></i><span>Guardar Cambios</span>';
            }
        }

        function onModificarClick() {
            const btn = document.getElementById('<%= btnModificar.ClientID %>');

            // Si el botón MUESTRA "Modificar", estamos entrando a modo edición
            const estaEnModoGuardar = btn.textContent.includes('Guardar');

            if (!estaEnModoGuardar) {
                // 1er click: solo cambiamos a modo edición (sin postback)
                toggleEditMode();  // ya tienes esta función
                return false;      // CANCELA el postback
            } else {
                // 2do click: ya está en "Guardar cambios" → dejamos que haga postback
                // opcional: podrías aquí hacer alguna validación JS antes de enviar
                return true;       // PERMITE el postback al servidor
            }
        }

        function showDeleteModal() {
            document.getElementById('deleteModal').classList.remove('hidden');
        }

        function hideDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }

        function executeDeleteAccount() {
            hideDeleteModal(); // opcional: cerrar el modal antes

            // Hace postback al botón servidor btnEliminarCuenta
            __doPostBack('<%= btnEliminarCuenta.ClientID %>', '');
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
</body>
</html>