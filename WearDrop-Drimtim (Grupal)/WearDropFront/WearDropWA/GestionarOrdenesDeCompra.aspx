<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarOrdenesDeCompra.aspx.cs" Inherits="WearDropWA.GestionarOrdenesDeCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">


     Gestionar Ordenes de Compra

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


   
        <style>
        /* ------- layout base ------- */
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 280px }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% }
        .bar-1 { flex:1.5 }
        .bar-2 { flex:1.5 }

        .top-accent { height:4px; margin-top:10px; border-radius:4px }

        .custom-grid { border-collapse:collapse; width:100% }
        .custom-grid th { color:#333; font-weight:500; padding:15px 20px; text-align:center; border:none; background:var(--c1) }
        .custom-grid td { padding:12px 20px; border-bottom:1px solid #E8E8E8; text-align:center }
        .custom-grid tr:nth-child(even) { background:#F5F5F5 }
        .custom-grid tr:hover { background:#E8F4E5 }

        a, a:visited, a:hover, a:active, .btn-wd { text-decoration:none !important; color:inherit }

        .btn-wd {
            background:var(--btn); color:#fff; border:none; padding:8px 18px;
            border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        /* ===== Tonos AZULES como en el ejemplo ===== */
        .theme-ordenes-compra { 
            --tone-1: #C7D6E2; /* azul claro (igual que theme-comprobantes) */
            --tone-2: #9FB6C8; /* azul medio (igual que theme-comprobantes) */  
            --tone-3: #7C98AD; /* azul oscuro (igual que theme-comprobantes) */
        }

        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }

        /* ===== Botones de acción estilo Bootstrap ===== */
        .action-btns i { font-size:1.1em; }
        .btn-sm { padding:4px 8px !important; margin-right:4px; }
        
        /* Estilos de tu GridView anterior (Paginación) */
        .pagination-container {
            text-align: right;
            margin-top: 15px;
        }

        /* ===== Contenedor de botones superiores ===== */
        .buttons-top-container {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            align-items: center;
        }
         /* 🔹 ESTILOS CORREGIDOS PARA EL MODAL */
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
        
        /* 🔹 ASEGURAR QUE EL MODAL SE CIERRE COMPLETAMENTE */
        .modal.fade:not(.show) {
            display: none !important;
            opacity: 0;
        }
        
        /* 🔹 BOTÓN DE EMERGENCIA PARA CERRAR MODAL */
        .btn-emergencia {
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1060;
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
        }

        .lote-container {
    display: flex;
    align-items: flex-end;
    gap: 15px;
}
.lote-textbox {
    flex: 1;
}
.lote-button {
    flex: 0 0 auto;
}
    </style>
    </style>
  
     <div id="themeWrap" runat="server" class="theme-ordenes-compra">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <!-- 🔹 BLOQUES DE COLOR Y TÍTULO (Estilo de la primera página) -->
                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2>Gestionar Ordenes de Compra</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <div class="buttons-top-container">
                                <asp:LinkButton ID="btnRegistrarOrden" CssClass="btn-wd" 
                                    runat="server" 
                                    OnClick="btnRegistrarOrden_Click" 
                                    Text="Registrar" />
                                <asp:LinkButton ID="btnFiltrarOrdenes" CssClass="btn-wd" 
                                    runat="server" 
                                    Text="Filtrar" />
                            </div>
                        </div>
                    </div>
                </div>

              <!-- 🔹 GRIDVIEW DE ÓRDENES DE COMPRA -->
<div class="container row mt-3">
    <asp:GridView ID="dgvOrdenesCompra"
        runat="server"
        AutoGenerateColumns="false"
        AllowPaging="true"
        PageSize="8"
        CssClass="table table-hover table-striped custom-grid"
        HeaderStyle-CssClass="grid-header"
        PagerStyle-CssClass="custom-pager"
        OnPageIndexChanging="dgvOrdenesCompra_PageIndexChanging"
        OnRowCommand="dgvOrdenesCompra_RowCommand"
        OnRowDataBound="dgvOrdenesCompra_RowDataBound">

        <Columns>
            <asp:BoundField DataField="idCompra" HeaderText="ID" />
            <asp:BoundField DataField="fechaEmision" HeaderText="Fecha Emisión" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="fechaLlegada" HeaderText="Fecha Llegada" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="deudaPendiente" HeaderText="Deuda Pendiente" DataFormatString="{0:C}" />
            <asp:BoundField DataField="empleado.nombre" HeaderText="Empleado" />
            <asp:BoundField DataField="proveedor.nombre" HeaderText="Proveedor" />
            <asp:BoundField DataField="montoTotal" HeaderText="Monto Total" DataFormatString="{0:C}" />

            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <div class="action-btns">
                        <asp:LinkButton
                            ID="btnModificarOrden"
                            runat="server"
                            CssClass="btn btn-sm btn-outline-primary"
                            CommandArgument='<%# Eval("idCompra") %>'
                            CommandName="Modificar"
                            ToolTip="Modificar">
                            <i class="fa-solid fa-pen"></i>
                        </asp:LinkButton>

                        <asp:LinkButton 
    ID="btnEliminarOrden" 
    runat="server"
    CssClass="btn btn-sm btn-outline-danger"
    CommandArgument='<%# Eval("idCompra") %>'
    CommandName="Eliminar"
    OnClientClick='<%# "return showConfirm(this, " + Eval("idCompra") + ");" %>'
    ToolTip="Eliminar">
    <i class="fa-solid fa-trash"></i>
</asp:LinkButton>

                        <asp:LinkButton 
                            ID="btnVerOrden"
                            runat="server"
                            CssClass="btn btn-sm btn-outline-success"
                            CommandArgument='<%# Eval("idCompra") %>'
                            CommandName="Ver"
                            ToolTip="Ver">
                            <i class="fa-solid fa-eye"></i>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
        <PagerStyle CssClass="pagination-container" />
    </asp:GridView>
</div>
            </div>
        </div>
    </div>

    <!-- 🔹 MODAL DE CONFIRMACIÓN (Igual que la primera página) -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de borrar esta orden de compra? Esta acción no se puede deshacer.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmDelete" class="btn btn-danger" onclick="executeDelete()">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdnOrdenIdToDelete" runat="server" Value="0" />


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
   <script type="text/javascript">
       // 🔹 VARIABLES GLOBALES MEJORADAS
       var _ordenIdToDelete = 0;

       // 🔹 FUNCIÓN SIMPLIFICADA
       function showConfirm(btn, ordenId) {
           console.log('🔄 showConfirm llamado - Orden ID:', ordenId);

           if (!ordenId || ordenId <= 0) {
               console.error('❌ ERROR: ID de orden inválido');
               alert('Error: No se puede identificar la orden a eliminar.');
               return false;
           }

           // Guardar ID
           _ordenIdToDelete = ordenId;

           console.log('✅ Datos guardados - Orden ID:', _ordenIdToDelete);

           // 🔹 MOSTRAR MODAL CON BOOTSTRAP
           var modalElement = document.getElementById('confirmDeleteModal');
           if (modalElement) {
               var modal = new bootstrap.Modal(modalElement);
               modal.show();
               console.log('✅ Modal mostrado correctamente');
           }

           return false; // 🔹 IMPORTANTE: Prevenir postback
       }

       // 🔹 FUNCIÓN EJECUTAR ELIMINACIÓN - SIMPLIFICADA
       function executeDelete() {
           console.log('🎯 executeDelete llamado - Orden ID:', _ordenIdToDelete);

           if (_ordenIdToDelete > 0) {
               // 🔹 CERRAR MODAL PRIMERO
               var modalElement = document.getElementById('confirmDeleteModal');
               if (modalElement) {
                   var modal = bootstrap.Modal.getInstance(modalElement);
                   if (modal) {
                       modal.hide();
                       console.log('✅ Modal cerrado');
                   }
               }

               // 🔹 EJECUTAR ELIMINACIÓN USANDO UN HIDDEN FIELD
               console.log('🔄 Ejecutando eliminación para orden:', _ordenIdToDelete);

               // Crear un hidden field temporal o usar uno existente
               var hiddenField = document.getElementById('hdnOrdenIdToDelete');
               if (!hiddenField) {
                   hiddenField = document.createElement('input');
                   hiddenField.type = 'hidden';
                   hiddenField.id = 'hdnOrdenIdToDelete';
                   hiddenField.name = 'hdnOrdenIdToDelete';
                   document.body.appendChild(hiddenField);
               }
               hiddenField.value = _ordenIdToDelete;

               // 🔹 ENVIAR FORMULARIO DIRECTAMENTE
               __doPostBack('DeleteOrder', _ordenIdToDelete.toString());

           } else {
               console.error('❌ ERROR: No hay ID de orden para eliminar');
               alert('Error: No se puede completar la eliminación.');
           }
       }

       // 🔹 MANEJAR EVENTOS DE CIERRE DEL MODAL
       document.addEventListener('DOMContentLoaded', function () {
           var modalElement = document.getElementById('confirmDeleteModal');
           if (modalElement) {
               modalElement.addEventListener('hidden.bs.modal', function () {
                   var backdrops = document.querySelectorAll('.modal-backdrop');
                   backdrops.forEach(function (backdrop) {
                       backdrop.remove();
                   });
                   document.body.classList.remove('modal-open');
                   document.body.style.paddingRight = '';
                   console.log('✅ Modal completamente cerrado');
               });
           }
       });

       // 🔹 FUNCIÓN ALTERNATIVA - MÁS DIRECTA
       function eliminarDirecto(ordenId) {
           if (confirm('¿Estás seguro de eliminar la orden ' + ordenId + '?')) {
               // Usar el método tradicional de ASP.NET
               __doPostBack('EliminarOrden', ordenId.toString());
           }
           return false;
       }
   </script>
</asp:Content>
