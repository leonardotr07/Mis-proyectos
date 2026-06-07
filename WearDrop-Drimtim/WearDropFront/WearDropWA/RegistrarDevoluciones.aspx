<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarDevolucion.aspx.cs" Inherits="WearDropWA.RegistrarDevolucion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Devolución
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* ------- Layout Base ------- */
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 280px }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% }
        .bar-1 { flex:1.5 }
        .bar-2 { flex:1.5 }

        .top-accent { height:4px; margin-top:10px; border-radius:4px }

        a, a:visited, a:hover, a:active, .btn-wd { text-decoration:none !important; color:inherit }

        .btn-wd {
            background:var(--btn); color:#fff; border:none; padding:8px 18px;
            border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        /* ===== Tonos NARANJAS para Devoluciones ===== */
        .theme-devolucion { 
            --tone-1: #FFD4B2;
            --tone-2: #FFB380;
            --tone-3: #FF8C42;
        }

        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }

        /* ===== Secciones ===== */
        .section-container {
            width: 80%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-top: 20px;
        }

        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
        }

        .label-title {
            margin-bottom: 12px;
            color: #333;
            font-size: 1rem;
            font-weight: 500;
        }

        .row-container {
            display: flex;
            justify-content: space-between;
            gap: 50px;
            width: 100%;
        }

        .col {
            flex: 1;
        }

        .form-control, .form-select {
            width: 100%;
            text-align: left;
            padding: 8px 12px;
            border: 1px solid #dee2e6;
            border-radius: 6px;
        }

        /* ===== Contenedor de Proveedor ===== */
        .proveedor-container {
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }

        .proveedor-textbox {
            flex: 1;
        }

        .proveedor-button {
            flex: 0 0 auto;
        }

        /* ===== Estilos del GridView ===== */
        .modal-grid {
            border-collapse: collapse;
            width: 100%;
        }
        .modal-grid th {
            background-color: var(--tone-2) !important;
            color: #333;
            font-weight: 500;
            padding: 12px 15px;
            text-align: center;
            border: none;
        }
        .modal-grid td {
            padding: 10px 15px;
            border-bottom: 1px solid #E8E8E8;
            text-align: center;
        }
        .modal-grid tr:nth-child(even) {
            background: #F5F5F5;
        }
        .modal-grid tr:hover {
            background: #FFE8D6;
        }

        /* ===== Mensajes ===== */
        .mensaje-alerta {
            padding: 12px 16px;
            margin: 15px 0;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
        }
        .mensaje-exito {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .mensaje-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .mensaje-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        /* ===== Botones de Acción ===== */
        .main-buttons-container {
            width: 80%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }

        .left-button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }

        .right-button-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
        }

        /* ===== Estilos para montos ===== */
        .monto-total {
            font-weight: bold;
            font-size: 1.1em;
            color: #FF8C42;
            background-color: #FFF3E8;
            border: 2px solid #FFD4B2;
        }

        .precio-unitario {
            background-color: #F8F9FA;
        }

        /* ===== Modal Styles ===== */
        .modal-backdrop {
            z-index: 1040 !important;
        }

        .modal {
            z-index: 1050 !important;
        }

        body.modal-open {
            overflow: hidden;
            padding-right: 0px !important;
        }

        .modal-backdrop.show {
            opacity: 0.5;
        }

        .modal:not(.show) {
            display: none !important;
        }
    </style>

    <!-- -------------------- TÍTULO PRINCIPAL -------------------- -->
    <div id="themeWrap" runat="server" class="theme-devolucion">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <!-- 🔹 BLOQUES DE COLOR Y TÍTULO -->
                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2><asp:Label ID="lblTitulo" runat="server" Text="Registrar Devolución"></asp:Label></h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 🔹 UPDATE PANEL PRINCIPAL -->
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <!-- 🔹 CONTENEDOR DE MENSAJES -->
                        <div class="section-container" style="width: 80%;">
                            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-alerta" 
                                Visible="false" EnableViewState="false" />
                        </div>

                        <!-- 🔹 SECCIÓN DE CONTENIDO -->
                        <div class="section-container">

                            <!-- 🔹 INFORMACIÓN BÁSICA DE LA DEVOLUCIÓN -->
                            <div class="subsection">
                                <h3 class="label-title" style="margin-bottom: 20px; font-size: 1.1rem; color: var(--tone-3);">
                                    Información Básica
                                </h3>
                                <div class="row-container">
                                    <div class="col">
                                        <h4 class="label-title">Fecha de Devolución (*)</h4>
                                        <asp:TextBox ID="txtFechaDevolucion" runat="server" CssClass="form-control" 
                                            TextMode="Date"></asp:TextBox>
                                    </div>
                                    <div class="col">
                                        <h4 class="label-title">Motivo de Devolución (*)</h4>
                                        <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-control" 
                                            TextMode="MultiLine" Rows="3" placeholder="Describa el motivo de la devolución"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- 🔹 SELECCIÓN DE PROVEEDOR -->
                            <div class="subsection">
                                <h3 class="label-title" style="margin-bottom: 20px; font-size: 1.1rem; color: var(--tone-3);">
                                    Proveedor
                                </h3>
                                <div class="row-container">
                                    <div class="col">
                                        <h4 class="label-title">Proveedor (*)</h4>
                                        <div class="proveedor-container">
                                            <div class="proveedor-textbox">
                                                <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" 
                                                    ReadOnly="true" placeholder="Seleccione un proveedor"></asp:TextBox>
                                                <asp:HiddenField ID="hdnIdProveedor" runat="server" />
                                            </div>
                                            <div class="proveedor-button">
                                                <asp:Button ID="btnSeleccionarProveedor" runat="server" Text="Seleccionar Proveedor" 
                                                    CssClass="btn-wd" OnClick="btnSeleccionarProveedor_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <!-- Espacio vacío -->
                                    </div>
                                </div>
                            </div>

                            <!-- 🔹 SELECCIÓN DE PRENDA - SECCIÓN MEJORADA -->
                            <div class="subsection">
                                <h3 class="label-title" style="margin-bottom: 20px; font-size: 1.1rem; color: var(--tone-3);">
                                    Prenda a Devolver
                                </h3>
                                
                                <!-- Selección de Tipo de Prenda -->
                                <div class="row-container">
                                    <div class="col">
                                        <h4 class="label-title">Tipo de Prenda (*)</h4>
                                        <asp:DropDownList ID="ddlTipoPrenda" runat="server" CssClass="form-select" 
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlTipoPrenda_SelectedIndexChanged">
                                            <asp:ListItem Text="Seleccionar tipo de prenda" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Blusa" Value="Blusa"></asp:ListItem>
                                            <asp:ListItem Text="Casaca" Value="Casaca"></asp:ListItem>
                                            <asp:ListItem Text="Falda" Value="Falda"></asp:ListItem>
                                            <asp:ListItem Text="Gorro" Value="Gorro"></asp:ListItem>
                                            <asp:ListItem Text="Pantalon" Value="Pantalon"></asp:ListItem>
                                            <asp:ListItem Text="Polo" Value="Polo"></asp:ListItem>
                                            <asp:ListItem Text="Vestido" Value="Vestido"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col" style="display: flex; align-items: flex-end;">
                                        <asp:Button ID="btnSeleccionarPrenda" runat="server" Text="Seleccionar Prenda" 
                                            CssClass="btn-wd" OnClick="btnSeleccionarPrenda_Click" Enabled="false" />
                                    </div>
                                </div>

                                <!-- Información de la Prenda Seleccionada -->
                                <div class="row-container" style="margin-top: 20px;">
                                    <div class="col">
                                        <h4 class="label-title">Prenda Seleccionada</h4>
                                        <asp:TextBox ID="txtNombrePrenda" runat="server" CssClass="form-control" 
                                            ReadOnly="true" placeholder="Ninguna prenda seleccionada"></asp:TextBox>
                                        <asp:HiddenField ID="hdnIdPrenda" runat="server" />
                                    </div>
                                    <div class="col">
                                        <h4 class="label-title">Talla (*)</h4>
                                        <asp:DropDownList ID="ddlTalla" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Seleccionar talla" Value=""></asp:ListItem>
                                            <asp:ListItem Text="XS" Value="XS"></asp:ListItem>
                                            <asp:ListItem Text="S" Value="S"></asp:ListItem>
                                            <asp:ListItem Text="M" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="L" Value="L"></asp:ListItem>
                                            <asp:ListItem Text="XL" Value="XL"></asp:ListItem>
                                            <asp:ListItem Text="XXL" Value="XXL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <h4 class="label-title">Cantidad a Devolver (*)</h4>
                                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" 
                                            TextMode="Number" min="1" step="1" placeholder="Ingrese la cantidad"
                                            AutoPostBack="true" OnTextChanged="txtCantidad_TextChanged"></asp:TextBox>
                                    </div>
                                </div>

                                <!-- 🔹 NUEVA SECCIÓN: CÁLCULO DE MONTOS -->
                                <div class="row-container" style="margin-top: 15px;">
                                    <div class="col">
                                        <h4 class="label-title">Precio Unitario (S/)</h4>
                                        <asp:TextBox ID="txtPrecioUnitario" runat="server" CssClass="form-control precio-unitario" 
                                            TextMode="Number" step="0.01" placeholder="0.00" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col">
                                        <h4 class="label-title">Monto Total a Devolver (S/)</h4>
                                        <asp:TextBox ID="txtMontoTotal" runat="server" CssClass="form-control monto-total" 
                                            ReadOnly="true" placeholder="0.00"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- 🔹 CONTENEDOR DE BOTONES -->
                        <div class="main-buttons-container">
                            <!-- Botón Cancelar -->
                            <div class="left-button-container">
                                <asp:LinkButton 
                                    ID="btnCancelar" 
                                    runat="server" 
                                    CssClass="btn-wd rounded shadow-sm"
                                    OnClick="btnCancelar_Click">
                                    <i class="fa-solid fa-circle-left"></i> Cancelar
                                </asp:LinkButton>
                            </div>

                            <!-- Botón Guardar -->
                            <div class="right-button-container">
                                <asp:Button 
                                    ID="btnGuardar" 
                                    runat="server" 
                                    Text="Guardar Devolución"
                                    CssClass="btn-wd rounded shadow-sm"
                                    OnClick="btnGuardar_Click" />
                            </div>
                        </div>

                        <!-- 🔹 MODAL SELECCIONAR PROVEEDOR -->
                        <div class="modal fade" id="modalSeleccionarProveedor" tabindex="-1" aria-labelledby="modalProveedorLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalProveedorLabel">Seleccionar Proveedor</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="false" 
                                                CssClass="table table-hover table-striped modal-grid"
                                                OnRowCommand="gvProveedores_RowCommand" 
                                                EmptyDataText="No se encontraron proveedores activos"
                                                ShowHeaderWhenEmpty="true">
                                                <Columns>
                                                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="80px" />
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                                    <asp:BoundField DataField="RUC" HeaderText="RUC" ItemStyle-Width="120px" />
                                                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" ItemStyle-Width="120px" />
                                                    <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnSeleccionarProv" runat="server" CssClass="btn btn-sm btn-wd"
                                                                CommandName="SeleccionarProveedor"
                                                                CommandArgument='<%# Eval("Id") + "|" + Eval("Nombre") %>'
                                                                Text="Seleccionar" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <div class="text-center p-3">
                                                        <i class="fas fa-exclamation-circle fa-2x text-muted mb-2"></i>
                                                        <p class="text-muted">No se encontraron proveedores activos</p>
                                                    </div>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 🔹 MODAL SELECCIONAR PRENDA -->
                        <div class="modal fade" id="modalSeleccionarPrenda" tabindex="-1" aria-labelledby="modalPrendaLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalPrendaLabel">
                                            Seleccionar Prenda - <asp:Label ID="lblTipoPrendaModal" runat="server" Text=""></asp:Label>
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <asp:GridView ID="gvPrendas" runat="server" AutoGenerateColumns="false" 
                                                CssClass="table table-hover table-striped modal-grid"
                                                OnRowCommand="gvPrendas_RowCommand" 
                                                EmptyDataText="No se encontraron prendas activas"
                                                ShowHeaderWhenEmpty="true">
                                                <Columns>
                                                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="70px" />
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                                    <asp:BoundField DataField="Color" HeaderText="Color" ItemStyle-Width="100px" />
                                                    <asp:BoundField DataField="Material" HeaderText="Material" ItemStyle-Width="120px" />
                                                    <asp:BoundField DataField="PrecioFormateado" HeaderText="Precio Mayor" ItemStyle-Width="100px" />
                                                    <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnSeleccionarPrnd" runat="server" CssClass="btn btn-sm btn-wd"
                                                                CommandName="SeleccionarPrenda"
                                                                CommandArgument='<%# Eval("Id") + "|" + Eval("Nombre") %>'
                                                                Text="Seleccionar" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <div class="text-center p-3">
                                                        <i class="fas fa-exclamation-circle fa-2x text-muted mb-2"></i>
                                                        <p class="text-muted">No se encontraron prendas activas</p>
                                                    </div>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>
    </div>

    <!-- 🔹 SCRIPTS PARA MODALES - CORREGIDOS -->
    <script type="text/javascript">
        // Función para cerrar modal de proveedor
        function cerrarModalProveedor() {
            console.log('Cerrando modal de proveedor...');
            var modalElement = document.getElementById('modalSeleccionarProveedor');
            if (modalElement) {
                var modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                } else {
                    var newModal = new bootstrap.Modal(modalElement);
                    newModal.hide();
                }
            }
            setTimeout(function () {
                limpiarBackdrops();
            }, 150);
        }

        // Función para cerrar modal de prenda
        function cerrarModalPrenda() {
            console.log('Cerrando modal de prenda...');
            var modalElement = document.getElementById('modalSeleccionarPrenda');
            if (modalElement) {
                var modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                } else {
                    var newModal = new bootstrap.Modal(modalElement);
                    newModal.hide();
                }
            }
            setTimeout(function () {
                limpiarBackdrops();
            }, 150);
        }

        function limpiarBackdrops() {
            var backdrops = document.querySelectorAll('.modal-backdrop');
            backdrops.forEach(function (backdrop) {
                backdrop.remove();
            });
            document.body.classList.remove('modal-open');
            document.body.style.paddingRight = '';
            document.body.style.overflow = '';
            console.log('Backdrops limpiados');
        }

        // Configurar eventos de cierre
        document.addEventListener('DOMContentLoaded', function () {
            ['modalSeleccionarProveedor', 'modalSeleccionarPrenda'].forEach(function (modalId) {
                var modalElement = document.getElementById(modalId);
                if (modalElement) {
                    modalElement.addEventListener('hidden.bs.modal', function () {
                        setTimeout(limpiarBackdrops, 100);
                    });
                }
            });
        });

        // Hacer funciones globales
        window.cerrarModalProveedor = cerrarModalProveedor;
        window.cerrarModalPrenda = cerrarModalPrenda;

        // 🔹 NUEVO: Función para formatear montos automáticamente
        function formatearMonto(input) {
            if (input.value) {
                let valor = parseFloat(input.value);
                if (!isNaN(valor)) {
                    input.value = valor.toFixed(2);
                }
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>