<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarDetalleOrdenCompra.aspx.cs" Inherits="WearDropWA.RegistrarDetalleOrdenCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    Registrar Orden

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
  <style>
    /* ===== Tonos AZULES como en RegistrarOrdenCompra ===== */
    .theme-ordenes { 
        --tone-1: #C7D6E2; /* azul claro */
        --tone-2: #9FB6C8; /* azul medio */  
        --tone-3: #7C98AD; /* azul oscuro */
    }

    .theme-ordenes .bar-1 { background: var(--tone-1); }
    .theme-ordenes .bar-2 { background: var(--tone-2); }
    .theme-ordenes .btn-wd { background: var(--tone-3); color: #fff; }
    .theme-ordenes .btn-wd:hover { filter: brightness(.95); }
    .theme-ordenes .top-accent { background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3)); }

    /* ===== Cabecera con bloques de color ===== */
    .header-title {
        display: flex;
        align-items: stretch;
        height: 60px;
        box-shadow: 0 2px 4px rgba(0,0,0,.1);
        margin-top: 14px;
        border-radius: 10px;
        overflow: hidden;
        width: 60%;
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
    .color-bar { height: 100%; }
    .bar-1 { flex: 1.5; }
    .bar-2 { flex: 1.5; }

    .top-accent {
        height: 4px;
        margin-top: 10px;
        border-radius: 4px;
    }

    /* ===== Estructura general ===== */
    .section-container {
        width: 60%;
        margin-left: 0;
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    .subsection {
        background-color: #fff;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 25px 30px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        width: 100%;
    }

    .two-columns {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 60px;
        width: 100%;
    }

    .one-column {
        display: flex;
        flex-direction: column;
        width: 100%;
    }

    .field-block {
        display: flex;
        flex-direction: column;
        flex: 1;
    }

    .field-block h3 {
        font-size: 1rem;
        font-weight: 500;
        color: #333;
        margin-bottom: 10px;
    }

    .form-control {
        width: 250px;
        text-align: left;
    }

    /* ===== Botones generales ===== */
    .btn-wd {
        border: none;
        padding: 10px 25px;
        border-radius: 12px;
        cursor: pointer;
        transition: .15s;
        box-shadow: 0 1px 2px rgba(0,0,0,.08);
    }
    .btn-wd:hover {
        filter: brightness(.95);
    }
    .btn-wd i { margin-right: 6px; }

    /* ===== Contenedor inferior ===== */
    .buttons-bottom-container {
        width: 60%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 30px;
    }

    /* ===== Estilos del GridView en el Modal ===== */
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
        background: #E8F4E5;
    }

    /* ===== Contenedor para selección de proveedor ===== */
    .proveedor-container {
        display: flex;
        align-items: flex-end;
        gap: 15px;
    }
    .proveedor-textbox {
        flex: 1;
    }
    .proveedor-button {
        flex: 0 0 auto;
    }

    /* ===== Estilos para el botón del modal ===== */
    .btn-modal {
        background: var(--tone-3);
        color: #fff;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.9rem;
    }
    .btn-modal:hover {
        background: var(--tone-2);
    }

    /* ===== Asegurar que el modal funcione correctamente ===== */
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

    /* Agregar esto en tu sección de estilos existente */
.modal.fade.show {
    display: block !important;
    background-color: rgba(0,0,0,0.5);
}

/* Asegurar que el backdrop se quite completamente */
.modal-backdrop.fade.show {
    opacity: 0.5;
}

/* Cuando el modal está oculto */
.modal.fade:not(.show) {
    display: none !important;
}

/* 🔹 ESTILOS PARA MODO VER EN DETALLE */
    .modo-ver-detalle .form-control:disabled,
    .modo-ver-detalle .form-control[readonly] {
        background-color: #f8f9fa;
        border-color: #e9ecef;
        color: #495057;
        opacity: 1;
    }
    
    .modo-ver-detalle .btn-wd:disabled {
        background-color: #6c757d;
        border-color: #6c757d;
        opacity: 0.6;
        cursor: not-allowed;
    }
    
    .modo-ver-detalle .subsection {
        background-color: #f8f9fa;
        border-color: #e9ecef;
    }
    
    .modo-ver-detalle .header-title {
        background: linear-gradient(90deg, #e9ecef, #dee2e6);
    }
    
    .modo-ver-detalle .title-section {
        background: #f8f9fa;
    }
    
   
    /* 🔹 ESTILOS PARA MODO VER EN DETALLE */
    .modo-ver-detalle .form-control:disabled,
    .modo-ver-detalle .form-control[readonly] {
        background-color: #f8f9fa;
        border-color: #e9ecef;
        color: #495057;
        opacity: 1;
        cursor: not-allowed;
    }
    
    .modo-ver-detalle .btn-wd:disabled {
        background-color: #6c757d;
        border-color: #6c757d;
        opacity: 0.6;
        cursor: not-allowed;
    }
    
    .modo-ver-detalle .subsection {
        background-color: #f8f9fa;
        border-color: #e9ecef;
    }
    
    .modo-ver-detalle .header-title {
        background: linear-gradient(90deg, #e9ecef, #dee2e6) !important;
    }
    
    .modo-ver-detalle .title-section {
        background: #f8f9fa !important;
    }
    
    .modo-ver-detalle .top-accent {
        background: linear-gradient(90deg, #e9ecef, #dee2e6, #adb5bd) !important;
    }
    
    /* 🔹 ESTILOS PARA MODO MODIFICAR EN DETALLE */
    .modo-modificar-detalle .header-title {
        background: linear-gradient(90deg, #fff3cd, #ffeaa7) !important;
    }
    
    .modo-modificar-detalle .title-section {
        background: #fff3cd !important;
    }
    
    .modo-modificar-detalle .top-accent {
        background: linear-gradient(90deg, #fff3cd, #ffeaa7, #fdcb6e) !important;
    }


</style>

<!-- -------------------- ENCABEZADO -------------------- -->
<div class="theme-ordenes">
    <div class="top-accent"></div>

    <!-- ===== CABECERA ===== -->
    <div class="header-title">
        <div class="title-section">
            <h2 id="lblTitulo" runat="server">Registrar Orden</h2>
        </div>
        <div class="color-bar bar-1"></div>
        <div class="color-bar bar-2"></div>
    </div>

    <!-- ===== CONTENIDO ===== -->
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
            <div class="section-container">

                <!-- 🔹 FILA 1: ID e ID Empleado -->
                <div class="subsection">
                    <div class="two-columns">
                        <div class="field-block">
                            <h3>ID</h3>
                            <asp:TextBox ID="txtIDOrden" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="field-block">
                            <h3>ID Empleado (*)</h3>
                            <asp:TextBox ID="txtIDEmpleado" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- 🔹 FILA 2: Fechas -->
                <div class="subsection">
                    <div class="two-columns">
                        <div class="field-block">
                            <h3>Fecha de Emisión (*)</h3>
                            <asp:TextBox ID="txtFechaEmision" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="field-block">
                            <h3>Fecha de Llegada (*)</h3>
                            <asp:TextBox ID="txtFechaLlegada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- 🔹 FILA 3: Montos -->
                <div class="subsection">
                    <div class="two-columns">
                        <div class="field-block">
                            <h3>Deuda Pendiente (*)</h3>
                            <asp:TextBox ID="txtDeudaPendiente" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                        </div>
                        <div class="field-block">
                            <h3>Monto Total</h3>
                            <asp:TextBox ID="txtMontoTotal" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- 🔹 FILA 4: Proveedor con Modal -->
                <div class="subsection">
                    <div class="one-column">
                        <div class="field-block">
                            <h3>Proveedor (*)</h3>
                            <div class="proveedor-container">
                                <div class="proveedor-textbox">
                                    <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" ReadOnly="true" placeholder="Seleccione un proveedor"></asp:TextBox>
                                    <asp:HiddenField ID="hdnIdProveedor" runat="server" />
                                </div>
                                <div class="proveedor-button">
                                    <!-- 🔹 CAMBIO: ID único para el botón principal -->
                                    <asp:Button ID="btnAbrirModalProveedor" runat="server" Text="Elegir Proveedor" 
                                        CssClass="btn-wd" OnClick="btnAbrirModalProveedor_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- ===== BOTONES INFERIORES ===== -->
            <div class="buttons-bottom-container">
                <asp:LinkButton 
                    ID="btnRegresar" 
                    runat="server" 
                    CssClass="btn-wd rounded shadow-sm"
                    OnClick="btnRegresar_Click">
                    <i class="fa-solid fa-circle-left"></i> Regresar
                </asp:LinkButton>

                <asp:Button 
                    ID="btnRegistrarOrden" 
                    runat="server" 
                    Text="Registrar"
                    CssClass="btn-wd rounded shadow-sm"
                    OnClick="btnRegistrarOrden_Click" />
            </div>

            <!-- 🔹 MODAL PARA SELECCIONAR PROVEEDOR -->
            <div class="modal fade" id="modalSeleccionarProveedor" tabindex="-1" aria-labelledby="modalProveedorLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalProveedorLabel">Seleccionar Proveedor</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped modal-grid"
                                    OnRowCommand="gvProveedores_RowCommand" EmptyDataText="No se encontraron proveedores activos"
                                    ShowHeaderWhenEmpty="true">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="80px" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                        <asp:BoundField DataField="RUC" HeaderText="RUC" ItemStyle-Width="120px" />
                                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" ItemStyle-Width="100px" />
                                        <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                                        <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
                                            <ItemTemplate>
                                                <!-- 🔹 CAMBIO: ID único para el LinkButton del GridView -->
                                                <asp:LinkButton ID="lnkSeleccionarProveedor" runat="server" CssClass="btn btn-sm btn-wd"
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

        </ContentTemplate>
    </asp:UpdatePanel>
</div>



</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <!-- 🔹 SCRIPT MEJORADO PARA MODAL -->
<script type="text/javascript">
    function mostrarModalProveedor() {
        console.log('🔄 Función mostrarModalProveedor ejecutada');

        var modalElement = document.getElementById('modalSeleccionarProveedor');
        console.log('🔍 Modal encontrado:', modalElement);

        if (modalElement) {
            // Usar Bootstrap para mostrar el modal
            var modal = new bootstrap.Modal(modalElement);
            modal.show();
            console.log('✅ Modal mostrado con Bootstrap');

        } else {
            console.error('❌ No se pudo encontrar el modal');
            alert('Error: No se puede abrir el selector de proveedores.');
        }
    }

    function cerrarModalProveedor() {
        console.log('🔄 Cerrando modal de proveedores...');

        var modalElement = document.getElementById('modalSeleccionarProveedor');
        if (modalElement) {
            var modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) {
                modal.hide();
            } else {
                // Si no hay instancia, crear una nueva y ocultarla
                var newModal = new bootstrap.Modal(modalElement);
                newModal.hide();
            }

            // Limpieza adicional para asegurar que se cierre completamente
            setTimeout(function () {
                // Remover backdrops manualmente si existen
                var backdrops = document.querySelectorAll('.modal-backdrop');
                backdrops.forEach(function (backdrop) {
                    backdrop.remove();
                });

                // Remover clases del body
                document.body.classList.remove('modal-open');
                document.body.style.paddingRight = '';
                document.body.style.overflow = '';

                // Ocultar el modal directamente
                modalElement.style.display = 'none';
                modalElement.classList.remove('show');

                console.log('✅ Modal cerrado y limpiado completamente');
            }, 150);
        }
    }

    // Configurar eventos de cierre para los botones nativos del modal
    document.addEventListener('DOMContentLoaded', function () {
        var modalElement = document.getElementById('modalSeleccionarProveedor');
        if (modalElement) {
            // Configurar el botón de cerrar (X)
            var closeButton = modalElement.querySelector('.btn-close');
            if (closeButton) {
                closeButton.addEventListener('click', function () {
                    cerrarModalProveedor();
                });
            }

            // Configurar el botón Cancelar
            var cancelButton = modalElement.querySelector('.btn-secondary');
            if (cancelButton) {
                cancelButton.addEventListener('click', function () {
                    cerrarModalProveedor();
                });
            }

            // Configurar evento cuando Bootstrap cierra el modal
            modalElement.addEventListener('hidden.bs.modal', function () {
                console.log('🔒 Evento hidden.bs.modal disparado');
                // Limpieza adicional
                setTimeout(function () {
                    var backdrops = document.querySelectorAll('.modal-backdrop');
                    backdrops.forEach(function (backdrop) {
                        backdrop.remove();
                    });
                    document.body.classList.remove('modal-open');
                }, 100);
            });
        }
    });

    // Hacer las funciones globales para que ASP.NET las pueda llamar
    window.mostrarModalProveedor = mostrarModalProveedor;
    window.cerrarModalProveedor = cerrarModalProveedor;
</script>



</asp:Content>
