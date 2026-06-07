 <%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistarVentas.aspx.cs" Inherits="WearDropWA.RegistarVentas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <span id="tituloPagina" runat="server">Registrar Venta</span>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* -------------------- VARIABLES DE COLOR GORROS -------------------- */
        .theme-gorros {
            --tone-1: #E0B6BC;
            --tone-2: #C99298;
            --tone-3: #A86E75;
            --btn: #A86E75;
        }
        /* 🔹 ESTILOS PARA MODO VISUALIZACIÓN SOLO LECTURA */
.modo-lectura .header-title {
    border: 3px solid #28a745 !important;
    background: linear-gradient(90deg, #fff, #f8fff8) !important;
}

.modo-lectura .title-section h2 {
    color: #28a745 !important;
    font-weight: 600;
}

.modo-lectura .scroll-container {
    border: 2px solid #e9ecef;
}

/* 🔹 OCULTAR COLUMNA ACCIONES COMPLETAMENTE */
.acciones-ocultas th:last-child,
.acciones-ocultas td:last-child {
    display: none !important;
}

/* 🔹 ESTILO PARA ALERTA INFORMATIVA */
.alert-info-custom {
    background-color: #d1ecf1;
    border-color: #bee5eb;
    color: #0c5460;
    padding: 12px 20px;
    border-radius: 6px;
    margin-bottom: 15px;
    border-left: 4px solid #17a2b8;
}



        /* 🔹 ESTILO PARA CAMPO DE TOTAL */
.total-field {
    background-color: #f8f9fa !important;
    font-weight: 600;
    color: #495057;
    border: 1px solid #ced4da;
}

        .theme-scope .bar-1 {
            background: var(--tone-1);
        }

        .theme-scope .bar-2 {
            background: var(--tone-2);
        }

        .theme-scope .custom-grid th {
            background: var(--tone-2) !important;
            color: #333;
        }

        .theme-scope .btn-wd {
            background: var(--tone-3);
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none !important;
        }

        .theme-scope .btn-wd:hover {
            filter: brightness(.95);
            color: #fff;
        }

        .theme-scope .btn-wd:active {
            transform: translateY(1px);
        }

        .theme-scope .top-accent {
            background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
        }

        /* -------------------- ESTRUCTURA HEADER -------------------- */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
        }

        .title-section {
            background: #fff;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 280px;
        }

        .title-section h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: #333;
            white-space: nowrap;
        }

        .color-bar {
            height: 100%;
        }

        .bar-1 {
            flex: 1.5;
        }

        .bar-2 {
            flex: 1.5;
        }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            border-radius: 4px;
        }

        /* -------------------- BOTONES DE ACCIÓN -------------------- */
        .action-btns i {
            font-size: 1.1em;
        }

        .btn-sm {
            padding: 4px 8px !important;
            margin-right: 4px;
        }

        /* -------------------- GRILLA PERSONALIZADA -------------------- */
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
            border-radius: 6px;
            overflow: hidden;
        }

        .custom-grid th {
            color: #333;
            font-weight: 500;
            padding: 15px 20px;
            text-align: center;
            border: none;
        }

        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
            text-align: center;
            vertical-align: middle;
        }

        .custom-grid tr:nth-child(even) {
            background: #F5F5F5;
        }

        .custom-grid tr:hover {
            background: #E8F4E5;
        }

        /* 🔹 Contenedor con scroll */
        .scroll-container {
            max-height: 325px;
            overflow-y: auto;
            overflow-x: hidden;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            margin-top: 20px;
        }

        /* 🔹 Asegura que la tabla ocupe todo el ancho */
        .scroll-container table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .scroll-container thead th {
            position: sticky;
            top: 0;
            z-index: 2;
            background-color: var(--tone-2) !important;
            color: #333 !important;
            text-align: center;
        }

        /* -------------------- Sección Total -------------------- */
        .total-container {
            width: 100%;
            max-width: 100%;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            margin-top: 20px;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--tone-2);
            box-sizing: border-box;
        }

        .total-container label {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
        }

        /* 🔹 Subcontenedor de moneda y textbox */
        .total-right {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .total-right h2 {
            margin: 0;
            color: #333;
            font-size: 1.5rem;
            font-weight: 600;
        }

        /* 🔹 Caja del total */
        .total-container .total-box {
            width: 150px;
            text-align: right;
            font-weight: bold;
            background-color: var(--tone-2);
            border: none;
            border-radius: 8px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
            cursor: default;
            color: #000;
        }

        /* -------------------- Contenedor de botones inferiores -------------------- */
        .buttons-bottom-container {
            width: 100%;
            max-width: 100%;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            margin-top: 20px;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #fff;
        }

        /* Botones inferiores */
        .buttons-bottom-container .btn-wd {
            font-weight: 400;
            padding: 10px 25px;
            border-radius: 8px;
            background-color: var(--tone-3);
            border: none;
            color: white;
            transition: all 0.2s ease-in-out;
            text-decoration: none;
        }

        .buttons-bottom-container .btn-wd:hover {
            filter: brightness(.95);
            color: white;
        }

        .buttons-bottom-container .btn-wd i {
            margin-right: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="theme-gorros">
        <div class="theme-scope">
            <div class="container">
                <!-- Línea acento superior -->
                <div class="top-accent"></div>

                <!-- SECCIÓN SUPERIOR CON TÍTULO Y BOTONES -->
                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2 id="lblTitulo" runat="server">Registrar Venta</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:LinkButton 
                                ID="btnIrAnnadirProductos" 
                                runat="server" 
                                CssClass="btn-wd"
                                OnClick="btnIrAnnadirProductos_Click"
                                Text="Añadir productos" />
                        </div>
                    </div>
                </div>

                <!-- GRILLA DE PRODUCTOS CON SCROLL -->
                <div class="scroll-container">
                    <asp:GridView ID="dgvProductosVenta" 
                        runat="server"
                        AutoGenerateColumns="false"
                        CssClass="custom-grid"
                        ShowHeaderWhenEmpty="true"
                        AllowPaging="false"
                        UseAccessibleHeader="true"
                        OnPreRender="dgvProductosVenta_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Nº" HeaderText="Nº" />
                            <asp:BoundField DataField="Prenda" HeaderText="Prenda" />
                            <asp:BoundField DataField="Talla" HeaderText="Talla" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:N2}" HtmlEncode="false"/>
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                         <asp:LinkButton 
                ID="btnModificarProductoVenta" 
                runat="server" 
                CssClass="btn btn-sm btn-outline-primary"
                CommandName="Modificar"
                CommandArgument='<%# Eval("Nº") %>'
                OnCommand="btnModificarProductoVenta_Command">
                <i class="fa-solid fa-pen"></i>
            </asp:LinkButton>
                                         <asp:LinkButton 
                ID="btnEliminarProductoVenta" 
                runat="server" 
                CssClass="btn btn-sm btn-outline-danger"
                CommandName="Eliminar"
                CommandArgument='<%# Eval("Nº") %>'
                OnCommand="btnEliminarProductoVenta_Command"
                OnClientClick="return confirm('¿Está seguro de eliminar este producto de la venta?');">
                <i class="fa-solid fa-trash"></i>
            </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- SECCIÓN TOTAL PAGADO -->
                <div class="total-container">
                    <label>Total pagado:</label>
                    <div class="total-right">
                        <h2>S/</h2>
                        <asp:TextBox ID="txtTotalPagado" runat="server" CssClass="form-control total-box" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <!-- SECCIÓN BOTONES INFERIORES -->
                <div class="buttons-bottom-container">
                    <asp:LinkButton 
                        ID="btnRegresarVentaProducto" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnRegresarVentaProducto_Click">
                        <i class="fa-solid fa-circle-left"></i> Regresar
                    </asp:LinkButton>

                    <asp:LinkButton 
                        ID="btnIniciarRegistroVenta" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnIniciarRegistroVenta_Click"
                        Text="Iniciar Registro" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">

    <script type="text/javascript">
        // Función para confirmar eliminación con mejor UX
        function confirmarEliminacion(boton) {
            // Agregar efecto visual
            boton.classList.add('btn-danger');
            boton.classList.remove('btn-outline-danger');

            // Mostrar confirmación
            return confirm('¿Está seguro de eliminar este producto de la venta?');
        }

        // Función para mejorar la interacción del grid después de postback
        function mejorarInteraccionGrid() {
            const botonesEliminar = document.querySelectorAll('[id*="btnEliminarProductoVenta"]');

            botonesEliminar.forEach(boton => {
                boton.addEventListener('mouseenter', function () {
                    this.classList.add('btn-danger');
                    this.classList.remove('btn-outline-danger');
                });

                boton.addEventListener('mouseleave', function () {
                    if (!this.classList.contains('active')) {
                        this.classList.remove('btn-danger');
                        this.classList.add('btn-outline-danger');
                    }
                });
            });
        }

        // Inicializar después de carga
        document.addEventListener('DOMContentLoaded', function () {
            mejorarInteraccionGrid();
        });

        // También inicializar después de postback de ASP.NET
        if (typeof (Sys) !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setTimeout(mejorarInteraccionGrid, 100);
            });
        }
    </script>

    <script type="text/javascript">
        function configurarModoVisualizacion() {
            // Verificar si estamos en modo visualización
            var urlParams = new URLSearchParams(window.location.search);
            var modo = urlParams.get('modo');

            if (modo === 'ver') {
                console.log('🔍 MODO VISUALIZACIÓN ACTIVADO - Deshabilitando botones');

                // 🔹 DESHABILITAR BOTONES DE ACCIÓN
                var botonesModificar = document.querySelectorAll('[id*="btnModificarProductoVenta"]');
                var botonesEliminar = document.querySelectorAll('[id*="btnEliminarProductoVenta"]');
                var btnAnadirProductos = document.getElementById('<%= btnIrAnnadirProductos.ClientID %>');
                var btnIniciarRegistro = document.getElementById('<%= btnIniciarRegistroVenta.ClientID %>');

                // Deshabilitar botones de modificar y eliminar
                botonesModificar.forEach(function (boton) {
                    boton.disabled = true;
                    boton.classList.remove('btn-outline-primary');
                    boton.classList.add('btn-secondary');
                    boton.style.pointerEvents = 'none';
                    boton.style.opacity = '0.5';
                });

                botonesEliminar.forEach(function (boton) {
                    boton.disabled = true;
                    boton.classList.remove('btn-outline-danger');
                    boton.classList.add('btn-secondary');
                    boton.style.pointerEvents = 'none';
                    boton.style.opacity = '0.5';
                });

                // Deshabilitar botón añadir productos
                if (btnAnadirProductos) {
                    btnAnadirProductos.disabled = true;
                    btnAnadirProductos.classList.remove('btn-wd');
                    btnAnadirProductos.classList.add('btn-secondary');
                    btnAnadirProductos.style.pointerEvents = 'none';
                    btnAnadirProductos.style.opacity = '0.5';
                }

                // Cambiar texto del botón iniciar registro
                if (btnIniciarRegistro) {
                    btnIniciarRegistro.textContent = ' Ver Resumen de Venta';
                    btnIniciarRegistro.disabled = false; // Permitir ver el resumen
                }

                // 🔹 CAMBIAR TÍTULO DE LA PÁGINA
                var titulo = document.querySelector('.title-section h2');
                if (titulo) {
                    titulo.textContent = 'Visualizar Venta - Productos';
                }

                // 🔹 AGREGAR INDICADOR VISUAL
                var header = document.querySelector('.header-title');
                if (header) {
                    header.style.border = '2px solid #28a745';
                }
            }
        }

        // Ejecutar cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', function () {
            configurarModoVisualizacion();
        });

        // También ejecutar después de postback
        if (typeof (Sys) !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setTimeout(configurarModoVisualizacion, 100);
            });
        }
    </script>

    <script type="text/javascript">
        function configurarModoVisualizacionLineas() {
            // Verificar si estamos en modo visualización
            var urlParams = new URLSearchParams(window.location.search);
            var modo = urlParams.get('modo');

            if (modo === 'ver') {
                console.log('🔍 MODO VISUALIZACIÓN ACTIVADO - Solo ver líneas');

                // 🔹 DESHABILITAR COMPLETAMENTE BOTONES DE ACCIÓN EN LÍNEAS
                var botonesModificar = document.querySelectorAll('[id*="btnModificarProductoVenta"]');
                var botonesEliminar = document.querySelectorAll('[id*="btnEliminarProductoVenta"]');

                // Ocultar completamente los botones de modificar y eliminar
                botonesModificar.forEach(function (boton) {
                    boton.style.display = 'none';
                });

                botonesEliminar.forEach(function (boton) {
                    boton.style.display = 'none';
                });

                // 🔹 OCULTAR COLUMNA COMPLETA DE ACCIONES SI NO HAY BOTONES VISIBLES
                setTimeout(function () {
                    var grid = document.getElementById('<%= dgvProductosVenta.ClientID %>');
                    if (grid) {
                        var headerCells = grid.getElementsByTagName('th');
                        var dataCells = grid.getElementsByTagName('td');

                        // Buscar la columna de Acciones (última columna)
                        for (var i = 0; i < headerCells.length; i++) {
                            if (headerCells[i].innerText.trim() === 'Acciones') {
                                // Ocultar header de acciones
                                headerCells[i].style.display = 'none';

                                // Ocultar todas las celdas de acciones en las filas
                                for (var j = 0; j < dataCells.length; j++) {
                                    if (dataCells[j].cellIndex === i) {
                                        dataCells[j].style.display = 'none';
                                    }
                                }
                                break;
                            }
                        }
                    }
                }, 100);

                // 🔹 CAMBIAR TEXTO DEL BOTÓN INFERIOR
                var btnIniciarRegistro = document.getElementById('<%= btnIniciarRegistroVenta.ClientID %>');
                if (btnIniciarRegistro) {
                    btnIniciarRegistro.textContent = ' Ver Resumen de Venta';
                    btnIniciarRegistro.innerHTML = '<i class="fa-solid fa-eye"></i> Ver Resumen de Venta';
                }

                // 🔹 CAMBIAR TÍTULO DE LA PÁGINA
                var titulo = document.querySelector('.title-section h2');
                if (titulo) {
                    titulo.textContent = 'Visualizar Venta - Líneas';
                    titulo.style.color = '#28a745'; // Verde para indicar solo lectura
                }

                // 🔹 AGREGAR INDICADOR VISUAL EN EL HEADER
                var header = document.querySelector('.header-title');
                if (header) {
                    header.style.border = '3px solid #28a745';
                    header.style.background = 'linear-gradient(90deg, #fff, #f8fff8)';
                }

                // 🔹 AGREGAR TEXTO INFORMATIVO
                var gridContainer = document.querySelector('.scroll-container');
                if (gridContainer) {
                    var infoText = document.createElement('div');
                    infoText.className = 'alert alert-info mt-3';
                    infoText.innerHTML = '<i class="fa-solid fa-info-circle"></i> <strong>Modo visualización:</strong> Solo puede ver los productos de la venta.';
                    gridContainer.parentNode.insertBefore(infoText, gridContainer);
                }

                console.log('✅ Modo visualización configurado - Solo ver líneas');
            }
        }

        // 🔹 FUNCIÓN PARA OCULTAR BOTÓN AÑADIR PRODUCTOS
        function ocultarBotonAnadirProductos() {
            var urlParams = new URLSearchParams(window.location.search);
            var modo = urlParams.get('modo');

            if (modo === 'ver') {
                var btnAnadir = document.getElementById('<%= btnIrAnnadirProductos.ClientID %>');
                if (btnAnadir) {
                    btnAnadir.style.display = 'none';
                }
            }
        }

        // Ejecutar cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', function () {
            configurarModoVisualizacionLineas();
            ocultarBotonAnadirProductos();
        });

        // También ejecutar después de postback de ASP.NET
        if (typeof (Sys) !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setTimeout(function () {
                    configurarModoVisualizacionLineas();
                    ocultarBotonAnadirProductos();
                }, 100);
            });
        }
    </script>
    </asp:Content>