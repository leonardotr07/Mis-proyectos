<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarOrdenCompra.aspx.cs" Inherits="WearDropWA.RegistrarOrdenCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    Registrar Orden de Compra

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

        /* ===== Tonos AZULES como en la página anterior ===== */
        .theme-ordenes-compra { 
            --tone-1: #C7D6E2; /* azul claro */
            --tone-2: #9FB6C8; /* azul medio */  
            --tone-3: #7C98AD; /* azul oscuro */
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
        
        /* Estilos de paginación */
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

        /* ===== Sección de contenido ===== */
        .section-container {
            width: 60%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* ===== CONTENEDOR PRINCIPAL DE BOTONES INFERIORES ===== */
        .main-buttons-container {
            width: 60%;
            display: flex;
            justify-content: space-between; /* 🔹 Regresar izquierda, Registrar derecha */
            align-items: center;
            margin-top: 30px;
        }

        /* ===== Botón Regresar a la izquierda ===== */
        .left-button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }

        /* ===== Botón Registrar a la derecha ===== */
        .right-button-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }


        /* 🔹 ESTILOS PARA BOTONES DESHABILITADOS EN MODO VER */
    .btn-outline-secondary {
        color: #6c757d;
        border-color: #6c757d;
        opacity: 0.6;
        cursor: not-allowed;
    }
    
    .btn-outline-secondary:hover {
        color: #6c757d;
        border-color: #6c757d;
        background-color: transparent;
    }
    
    /* Indicador visual del modo */
    .modo-ver .header-title {
        background: linear-gradient(90deg, #e9ecef, #dee2e6);
    }
    
    .modo-ver .title-section {
        background: #f8f9fa;
    }
    /* 🔹 ESTILOS PARA BOTONES DESHABILITADOS EN MODO VER */
    .btn-outline-secondary {
        color: #6c757d;
        border-color: #6c757d;
        opacity: 0.6;
        cursor: not-allowed;
    }
    
    .btn-outline-secondary:hover {
        color: #6c757d;
        border-color: #6c757d;
        background-color: transparent;
    }
    
    
    
    /* Indicador visual del modo */
    .modo-ver .header-title {
        background: linear-gradient(90deg, #e9ecef, #dee2e6);
    }
    
    .modo-ver .title-section {
        background: #f8f9fa;
    }
        /* ===== ELIMINADO: .registrar-button-container ===== */
    </style>
<!-- -------------------- SECCIÓN SUPERIOR -------------------- -->
<div id="themeWrap" runat="server" class="theme-ordenes-compra">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <!-- 🔹 BLOQUES DE COLOR Y TÍTULO -->
<div class="container row">
    <div class="row align-items-center">
        <div class="col-md-6 p-0">
            <div class="header-title">
                <div class="title-section">
                    <!-- 🔹 CAMBIO: Usar Label en lugar de h2 fijo -->
                    <asp:Label ID="lblTitulo" runat="server" Text="Registrar Orden de Compra" 
                        style="margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap"></asp:Label>
                </div>
                <div class="color-bar bar-1"></div>
                <div class="color-bar bar-2"></div>
            </div>
        </div>
        <div class="col text-end p-3">
            <div class="buttons-top-container">
                <asp:LinkButton ID="btnAgregarLinea" CssClass="btn-wd" 
                    runat="server" 
                    OnClick="btnAgregarLinea_Click" 
                    Text="Añadir línea" />
            </div>
        </div>
    </div>
</div>

                <!-- 🔹 GRIDVIEW DE DETALLES DE ORDEN -->
                <div class="container row mt-3">
                   <asp:GridView ID="dgvOrdenDetalle" runat="server" AutoGenerateColumns="false"
    AllowPaging="true" PageSize="8"
    CssClass="table table-hover table-striped custom-grid"
    OnPageIndexChanging="dgvOrdenDetalle_PageIndexChanging"
    OnRowCommand="dgvOrdenDetalle_RowCommand"
    OnRowDataBound="dgvOrdenDetalle_RowDataBound">
    
    <Columns>
        <asp:BoundField DataField="Numero" HeaderText="N.º" />
        <asp:BoundField DataField="Prenda" HeaderText="Prenda" />
        <asp:BoundField DataField="Talla" HeaderText="Talla" />
        <asp:BoundField DataField="Lote" HeaderText="Lote" />
        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
        <asp:BoundField DataField="PrecioLote" HeaderText="Precio Lote" DataFormatString="{0:C}" />

        <asp:TemplateField HeaderText="Acciones">
            <ItemTemplate>
                <div class="action-btns">
                    <!-- 🔹 BOTÓN VER -->
                    <asp:LinkButton 
                        ID="btnVerLinea"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-success"
                        CommandArgument='<%# Container.DataItemIndex %>'
                        CommandName="VerLinea"
                        ToolTip="Ver línea">
                        <i class="fa-solid fa-eye"></i>
                    </asp:LinkButton>

                    <!-- 🔹 BOTÓN EDITAR -->
                    <asp:LinkButton
                        ID="btnEditarLinea"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-primary"
                        CommandArgument='<%# Container.DataItemIndex %>'
                        CommandName="EditarLinea"
                        ToolTip="Editar línea">
                        <i class="fa-solid fa-pen"></i>
                    </asp:LinkButton>

                    <!-- 🔹 BOTÓN ELIMINAR -->
                    <asp:LinkButton 
                        ID="btnEliminarLinea" 
                        runat="server"
                        CssClass="btn btn-sm btn-outline-danger"
                        CommandArgument='<%# Container.DataItemIndex %>'
                        CommandName="EliminarLinea"
                        OnClientClick="return confirm('¿Estás seguro de eliminar esta línea?');"
                        ToolTip="Eliminar línea">
                        <i class="fa-solid fa-trash"></i>
                    </asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    
    <PagerStyle CssClass="pagination-container" />
</asp:GridView>
                </div>

                <!-- 🔹 CONTENEDOR PRINCIPAL DE BOTONES INFERIORES (AMBOS BOTONES EN LA MISMA FILA) -->
                <div class="main-buttons-container">
                    <!-- 🔹 BOTÓN REGRESAR (IZQUIERDA) -->
                    <div class="left-button-container">
                        <asp:LinkButton 
                            ID="btnRegresar" 
                            runat="server" 
                            CssClass="btn-wd rounded shadow-sm"
                            OnClick="btnRegresar_Click">
                            <i class="fa-solid fa-circle-left"></i> Regresar
                        </asp:LinkButton>
                    </div>

                    <!-- 🔹 BOTÓN REGISTRAR ORDEN (DERECHA) -->
                    <div class="right-button-container">
                        <asp:Button
                            ID="btnRegistrarOrden"
                            runat="server"
                            Text="Registrar Orden"
                            CssClass="btn-wd rounded shadow-sm"
                            OnClick="btnRegistrarOrden_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">

    <script type="text/javascript">
        // 🔹 FORZAR ACTUALIZACIÓN CUANDO SE REGRESA DE MODIFICAR LÍNEA
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Página cargada - verificando si viene de modificación');
            
            // Verificar si hay un parámetro que indique modificación reciente
            if (sessionStorage.getItem('recargarGrid') === 'true') {
                console.log('Forzando recarga del grid...');
                // Recargar la página para asegurar que se muestren los datos actualizados
                setTimeout(function() {
                    window.location.reload();
                }, 100);
                sessionStorage.removeItem('recargarGrid');
            }
        });

        // Función para marcar que se necesita recargar al regresar
        function marcarParaRecargar() {
            sessionStorage.setItem('recargarGrid', 'true');
        }
    </script>


</asp:Content>
