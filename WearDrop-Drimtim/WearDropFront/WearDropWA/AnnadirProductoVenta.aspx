<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="AnnadirProductoVenta.aspx.cs" Inherits="WearDropWA.AnnadirProductoVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Añadir Producto
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

        /* -------------------- SECCIONES DE CONTENIDO -------------------- */
        .section-container {
            width: 60%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* Subdivisiones generales */
        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
        }

        /* 🔹 Etiquetas pequeñas */
        .label-title {
            margin-bottom: 12px;
            color: #333;
            font-size: 1rem;
            font-weight: 500;
        }

        /* 🔹 Separador o subtítulo principal */
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
        }

        /* Alineaciones comunes */
        .dropdown-container,
        .textbox-container {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        /* -------------------- NUEVAS SECCIONES SEPARADAS: TALLAS Y PRECIOS -------------------- */
        .tallas-section,
        .precios-section {
            width: 65%;
            margin-top: 20px;
            margin-left: 0;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        /* 🔹 Sección Tallas */
        .size-section {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .size-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

        .size-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid var(--tone-3);
            background-color: #fff;
            color: var(--tone-3);
            font-weight: 600;
            transition: all 0.2s ease-in-out;
            cursor: pointer;
        }

        .size-btn:hover {
            background-color: var(--tone-3);
            color: #fff;
        }

        .size-btn.active {
            background-color: var(--tone-3);
            color: #fff;
        }

        .size-btn.disabled {
            border-color: #ccc;
            color: #ccc;
            cursor: not-allowed;
        }

        .size-btn.disabled:hover {
            background-color: #fff;
            color: #ccc;
        }

        /* 🔹 Sección Precios */
        .price-section {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .price-row-horizontal {
            display: flex;
            align-items: center;
            gap: 25px;
            flex-wrap: nowrap;
        }

        .price-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .price-item label {
            font-weight: 500;
            color: #333;
        }

        .price-item .form-control {
            width: 200px;
        }

        /* -------------------- CANTIDADES Y SUBTOTAL -------------------- */
        .quantity-section,
.subtotal-section {
    width: 65%;
    margin-top: 20px;
    margin-left: 0;
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 25px 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.subtotal-container {
    display: flex;
    flex-direction: column;
    width: 100%;
}

.subtotal-container h3 {
    font-size: 1rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 12px;
}

.subtotal-row {
    display: flex;
    align-items: center;
    gap: 20px;
}
        /* Contenedor de 2 columnas (Cantidad disponible / requerida) */
        .two-columns-quantity {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 60px;
            width: 100%;
        }

        /* Subdivisiones internas */
        .quantity-sub {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .quantity-sub h3 {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }

        .quantity-sub .form-control {
            width: 200px;
        }

        /* 🔹 Subtotal */
        .subtotal-section h3 {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 12px;
        }

        /* Contenedor horizontal de subtotal + botones */
        .subtotal-row {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        /* -------------------- CONTENEDOR DE BOTONES INFERIORES -------------------- */
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

        /* Form controls generales */
        .form-control {
            width: 250px;
            text-align: left;
        }

        .form-select {
            width: 250px;
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

        /* ===== ESTILOS PARA MENSAJES ===== */
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

        /* ===== ESTILOS PARA DETALLES DE PRENDA ===== */
        .detalle-prenda-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        .detalle-prenda-row {
            display: flex;
            margin-bottom: 8px;
        }

        .detalle-prenda-label {
            font-weight: 600;
            min-width: 150px;
            color: #333;
        }

        .detalle-prenda-value {
            color: #666;
        }

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
        /* ===== ESTILOS PARA DETALLES DE PRENDA ===== */
.detalle-prenda-section {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #f8f9fa;
    border-radius: 8px;
    border: 1px solid #dee2e6;
}

.detalle-prenda-row {
    display: flex;
    margin-bottom: 8px;
}

.detalle-prenda-label {
    font-weight: 600;
    min-width: 150px;
    color: #333; /* Mantener oscuro para las etiquetas */
}

.detalle-prenda-value {
    color: #495057; /* 🔹 CAMBIO: Gris más oscuro (#495057 en lugar de #666) */
    font-weight: 400;
}
.subtotal-section .form-control {
    background-color: #f8f9fa;
    border: 1px solid #ced4da;
    font-weight: 600;
    color: #495057;
    text-align: right;
}

/* 🔹 ESTILOS PARA EL RESUMEN DE DESCUENTOS */
.bg-light.rounded {
    border: 1px solid #dee2e6 !important;
}

.text-success {
    font-size: 1.1rem;
    font-weight: 600;
}

.modal-descuentos .modal-header {
    background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
    color: white;
    border-bottom: none;
}

.modal-descuentos .modal-title {
    font-weight: 600;
    font-size: 1.3rem;
}

.modal-descuentos .card-header {
    font-weight: 600;
    border-bottom: none;
}

.modal-descuentos .bg-warning {
    background: linear-gradient(135deg, #ffc107, #ffb300) !important;
}

.modal-descuentos .bg-info {
    background: linear-gradient(135deg, var(--tone-2), var(--tone-3)) !important;
}

.modal-descuentos .bg-success {
    background: linear-gradient(135deg, #28a745, #20c997) !important;
}

.modal-descuentos .btn-primary {
    background: var(--tone-3);
    border-color: var(--tone-3);
}

.modal-descuentos .btn-primary:hover {
    background: var(--tone-2);
    border-color: var(--tone-2);
}

/* 🔹 ESTILOS PARA RESUMEN DE DESCUENTOS */
.resumen-descuentos {
    border: 2px solid var(--tone-1) !important;
    background: #f8f9fa !important;
}

.resumen-descuentos h6 {
    color: var(--tone-3);
    font-weight: 600;
}

.resumen-descuentos .fw-bold {
    color: var(--tone-3);
}

.resumen-descuentos .text-success {
    color: #28a745 !important;
}

.resumen-descuentos .text-primary {
    color: var(--tone-3) !important;
}

.resumen-descuentos .fs-5 {
    font-size: 1.4rem !important;
}

/* 🔹 ESTILOS PARA MODAL DE DESCUENTOS - BLANCO Y SIMPLE */
.modal-descuentos .modal-header {
    background: white !important;
    border-bottom: 2px solid var(--tone-1);
    color: #333;
}

.modal-descuentos .modal-title {
    font-weight: 600;
    font-size: 1.3rem;
    color: #333;
}

.modal-descuentos .card {
    border: 1px solid #dee2e6;
    background: white;
}

.modal-descuentos .card-header {
    font-weight: 600;
    border-bottom: 1px solid #dee2e6;
    background: white !important;
    color: #333;
}

.modal-descuentos .btn-wd {
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

.modal-descuentos .btn-wd:hover {
    filter: brightness(.95);
    color: #fff;
}

.modal-descuentos .btn-secondary {
    background: #6c757d;
    border-color: #6c757d;
}

/* 🔹 ESTILOS PARA RESUMEN DE DESCUENTOS */
.resumen-descuentos {
    border: 2px solid var(--tone-1) !important;
    background: #f8f9fa !important;
}

.resumen-descuentos h6 {
    color: var(--tone-3);
    font-weight: 600;
}

.resumen-descuentos .fw-bold {
    color: var(--tone-3);
}

.resumen-descuentos .text-success {
    color: #28a745 !important;
}

.resumen-descuentos .text-primary {
    color: var(--tone-3) !important;
}

.resumen-descuentos .fs-5 {
    font-size: 1.4rem !important;
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
                                    <h2>Seleccionar Prenda</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 🔹 UPDATE PANEL QUE INCLUYE TODO, INCLUIDO LOS MODALES -->
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <!-- 🔹 CONTENEDOR DE MENSAJES -->
                        <div class="section-container">
                            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-alerta" 
                                Visible="false" EnableViewState="false" />
                        </div>

                        <!-- -------------------- CONTENIDO PRINCIPAL -------------------- -->
                        <div class="section-container">

                            <!-- 🔹 Tipo de Prenda -->
                            <div class="subsection">
                                <h3 class="label-title">Tipo de Prenda</h3>
                                <div class="dropdown-container">
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
                                    <asp:LinkButton 
                                        ID="btnSeleccionarPrenda" 
                                        runat="server" 
                                        CssClass="btn-wd"
                                        OnClick="btnSeleccionarPrenda_Click" 
                                        Enabled="false"
                                        Text="Seleccionar Prenda" />
                                </div>
                            </div>

                            <!-- 🔹 Separador -->
                            <div class="subsection">
                                <h2 class="section-title">Detalles de la Prenda:</h2>
                            </div>

                            <!-- 🔹 Nombre de la Prenda -->
                            <div class="subsection">
                                <h3 class="label-title">Nombre de la Prenda:</h3>
                                <div class="textbox-container">
                                    <asp:TextBox ID="txtNombrePrenda" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    <asp:HiddenField ID="hdnIdPrenda" runat="server" />
                                    <asp:LinkButton 
                                        ID="btnVerPrenda" 
                                        runat="server" 
                                        CssClass="btn-wd"
                                        OnClick="btnVerPrenda_Click"
                                        Enabled="false"
                                        Text="Ver Prenda" />
                                </div>
                            </div>
                        </div>

                        <!-- 🟢 SECCIÓN SEPARADA: TALLAS DISPONIBLES -->
                        <div class="tallas-section">
                            <div class="size-section">
                                <h3 class="label-title">Tallas disponibles (*)</h3>
                                <div class="size-buttons" id="sizeButtonsContainer">
                                    <button type="button" class="size-btn disabled" data-talla="XS">XS</button>
                                    <button type="button" class="size-btn disabled" data-talla="S">S</button>
                                    <button type="button" class="size-btn disabled" data-talla="M">M</button>
                                    <button type="button" class="size-btn disabled" data-talla="L">L</button>
                                    <button type="button" class="size-btn disabled" data-talla="XL">XL</button>
                                    <button type="button" class="size-btn disabled" data-talla="XXL">XXL</button>
                                </div>
                                <asp:HiddenField ID="hdnTallaSeleccionada" runat="server" />
                                <asp:HiddenField ID="hdnStockPorTalla" runat="server" />
                            </div>
                        </div>

                        <!-- 🟣 SECCIÓN SEPARADA: PRECIOS -->
                        <div class="precios-section">
                            <div class="price-section">
                                <h3 class="label-title">Precio</h3>
                                <div class="price-row-horizontal">
                                    <div class="price-item">
                                        <label>P/U: S/</label>
                                        <asp:TextBox ID="txtPrecioUnidad" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="price-item">
                                        <label>P/M: S/</label>
                                        <asp:TextBox ID="txtPrecioMayor" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="price-item">
                                        <label>P/D: S/</label>
                                        <asp:TextBox ID="txtPrecioDescuento" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 🔹 CANTIDADES -->
                        <div class="quantity-section">
                            <div class="two-columns-quantity">
                                <!-- Cantidad disponible -->
                                <div class="quantity-sub">
                                    <h3>Cantidad disponible:</h3>
                                    <asp:TextBox ID="txtCantidadDisponible" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>

                                <!-- Cantidad requerida -->
                                <div class="quantity-sub">
                                    <h3>Cantidad requerida (*):</h3>
                                    <asp:TextBox ID="txtCantidadRequerida" runat="server" CssClass="form-control" 
                                        onkeyup="actualizarSubtotal()" AutoPostBack="false"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                      <!-- 🔹 SUBTOTAL -->
<div class="subtotal-section">
    <div class="subtotal-container">
        <h3 class="label-title">Subtotal:</h3>
        <div class="subtotal-row">
            <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" ReadOnly="true" Width="200px"></asp:TextBox>
            
            <!-- 🔹 BOTONES DE PROMOCIONES Y DESCUENTOS -->
            <asp:LinkButton 
                ID="btnPromocionesAplicadas" 
                runat="server" 
                Text="Promociones aplicadas" 
                CssClass="btn-wd" 
                Enabled="false"
                OnClick="btnPromocionesAplicadas_Click" />
                
            <asp:LinkButton 
                ID="btnDescuentosAplicados" 
                runat="server" 
                Text="Descuentos aplicados" 
                CssClass="btn-wd"
                Enabled="false"
                 OnClick="btnDescuentosAplicados_Click"/>
        </div>
    </div>
</div>

                        <!-- -------------------- BOTONES INFERIORES -------------------- -->
                        <div class="buttons-bottom-container">
                            <!-- 🔹 Botón Regresar (izquierda) -->
                            <asp:LinkButton 
                                ID="btnRegresarAnnadir" 
                                runat="server" 
                                CssClass="btn-wd"
                                OnClick="btnRegresarAnnadirProd_Click">
                                <i class="fa-solid fa-circle-left"></i> Regresar
                            </asp:LinkButton>

                            <!-- 🔹 Botón Añadir producto (derecha) -->
                            <asp:LinkButton 
                                ID="btnAnadirProducto" 
                                runat="server" 
                                Text="Añadir Producto"
                                CssClass="btn-wd"
                                OnClick="btnAnadirProducto_Click" 
                                Enabled="false"/>
                        </div>

                        <!-- 🔹 MODAL PARA SELECCIONAR PRENDA -->
                        <div class="modal fade" id="modalSeleccionarPrenda" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalLabel">Seleccionar Prenda - <asp:Label ID="lblTipoPrendaModal" runat="server" Text=""></asp:Label></h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <asp:GridView ID="gvPrendas" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped modal-grid"
                                                OnRowCommand="gvPrendas_RowCommand" EmptyDataText="No se encontraron prendas activas"
                                                ShowHeaderWhenEmpty="true">
                                                <Columns>
                                                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="70px" />
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                                    <asp:BoundField DataField="Color" HeaderText="Color" ItemStyle-Width="100px" />
                                                    <asp:BoundField DataField="Material" HeaderText="Material" ItemStyle-Width="120px" />
                                                    <asp:BoundField DataField="PrecioFormateado" HeaderText="Precio Mayor" ItemStyle-Width="100px" />
                                                    <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnSeleccionar" runat="server" CssClass="btn btn-sm btn-wd"
                                                                CommandName="Seleccionar" 
                                                                CommandArgument='<%# Eval("Id") %>'
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

                        <!-- 🔹 MODAL PARA VER DETALLES DE PRENDA -->
                        <div class="modal fade" id="modalVerPrenda" tabindex="-1" aria-labelledby="modalVerPrendaLabel" aria-hidden="true">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalVerPrendaLabel">Detalles de la Prenda</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- 🔹 SECCIÓN DETALLES DE LA PRENDA -->
                                        <div class="detalle-prenda-section">
                                            <h6 class="mb-3">Información General</h6>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">ID:</div>
                                                <div class="detalle-prenda-value" id="detalleIdPrenda"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Nombre:</div>
                                                <div class="detalle-prenda-value" id="detalleNombre"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Color:</div>
                                                <div class="detalle-prenda-value" id="detalleColor"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Material:</div>
                                                <div class="detalle-prenda-value" id="detalleMaterial"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Precio Unidad:</div>
                                                <div class="detalle-prenda-value" id="detallePrecioUnidad"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Precio Mayor:</div>
                                                <div class="detalle-prenda-value" id="detallePrecioMayor"></div>
                                            </div>
                                            <div class="detalle-prenda-row">
                                                <div class="detalle-prenda-label">Precio Docena:</div>
                                                <div class="detalle-prenda-value" id="detallePrecioDocena"></div>
                                            </div>
                                            <!-- 🔹 ELIMINADO: Stock Total -->
                                            <!-- 🔹 CAMPOS ESPECÍFICOS SEGÚN TIPO DE PRENDA -->
                                            <div id="detalleCamposEspecificos"></div>
                                        </div>

                                        <!-- 🔹 SECCIÓN TALLAS DISPONIBLES -->
                                        <div class="mt-4">
                                            <h6 class="mb-3">Tallas Disponibles en Inventario</h6>
                                            <div class="table-responsive">
                                                <asp:GridView ID="gvTallasPrenda" runat="server" AutoGenerateColumns="false"
                                                    CssClass="table table-hover table-striped modal-grid"
                                                    EmptyDataText="No se encontraron tallas disponibles para esta prenda"
                                                    ShowHeaderWhenEmpty="true">
                                                    <Columns>
                                                        <asp:BoundField DataField="Talla" HeaderText="Talla" ItemStyle-Width="100px" />
                                                        <asp:BoundField DataField="Stock" HeaderText="Stock Disponible" ItemStyle-Width="120px" />
                                                        <asp:BoundField DataField="Lote" HeaderText="ID Lote" ItemStyle-Width="100px" />
                                                    </Columns>
                                                    <EmptyDataTemplate>
                                                        <div class="text-center p-3">
                                                            <i class="fas fa-exclamation-circle fa-2x text-muted mb-2"></i>
                                                            <p class="text-muted">No se encontraron tallas disponibles para esta prenda</p>
                                                        </div>
                                                    </EmptyDataTemplate>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 🔹 NUEVO MODAL: PARA MOSTRAR PROMOCIONES COMBO -->
<div class="modal fade" id="modalPromociones" tabindex="-1" aria-labelledby="modalPromocionesLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalPromocionesLabel">Promociones Combo Disponibles</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvPromociones" runat="server" AutoGenerateColumns="false" 
                        CssClass="table table-hover table-striped modal-grid"
                        EmptyDataText="No se encontraron promociones combo para esta prenda"
                        ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:BoundField DataField="Nombre" HeaderText="Promoción" />
                            <asp:BoundField DataField="DescripcionPromocion" HeaderText="Descripción" />
                            <asp:BoundField DataField="CantidadRequerida" HeaderText="Lleva" ItemStyle-Width="80px" />
                            <asp:BoundField DataField="CantidadGratis" HeaderText="Gratis" ItemStyle-Width="80px" />
                            <asp:BoundField DataField="Estado" HeaderText="Estado" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="PrendasGratis" HeaderText="Prendas Gratis" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="DescuentoFormateado" HeaderText="Descuento" ItemStyle-Width="100px" />
                        </Columns>
                    </asp:GridView>
                </div>
                
                <!-- 🔹 RESUMEN DE TOTALES - ACTUALIZADO -->
                <div class="mt-4 p-3 bg-light rounded">
                    <h6 class="mb-3">Resumen de Totales</h6>
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <strong>Subtotal sin descuento:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblSubtotalPromociones" class="fw-bold">S/ 0.00</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <strong>Total descuento promociones:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblTotalDescuentoPromociones" class="fw-bold text-success">S/ 0.00</span>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Total con descuento:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblTotalConDescuentoPromociones" class="fw-bold text-primary fs-5">S/ 0.00</span>
                        </div>
                    </div>
                </div>
           </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-wd" data-bs-dismiss="modal">Cancelar</button>
    <button type="button" class="btn btn-primary btn-wd" onclick="aplicarPromociones()">
        Aplicar Descuentos
    </button>
</div>
        </div>
    </div>
</div>

<div class="modal fade modal-descuentos" id="modalDescuentos" tabindex="-1" aria-labelledby="modalDescuentosLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalDescuentosLabel">Descuentos Disponibles</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 🔹 SECCIÓN DESCUENTO POR LIQUIDACIÓN -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">Descuento por Liquidación</h6>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvDescuentosLiquidacion" runat="server" AutoGenerateColumns="false" 
                            CssClass="table table-sm table-hover modal-grid"
                            EmptyDataText="No hay descuentos de liquidación disponibles"
                            ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="Nombre" HeaderText="Descuento" />
                                <asp:BoundField DataField="CondicionStock" HeaderText="Stock Mínimo" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="Porcentaje" HeaderText="Descuento %" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="Estado" HeaderText="Estado" ItemStyle-Width="120px" />
                                <asp:BoundField DataField="DescuentoAplicadoFormateado" HeaderText="Monto Descontado" ItemStyle-Width="120px" />
                            </Columns>
                        </asp:GridView>
                        <div id="resumenLiquidacion" class="mt-2 p-2 bg-light rounded" style="display:none;">
                            <small><strong>Descuento aplicado:</strong> <span id="lblDescuentoLiquidacion" class="text-success">S/ 0.00</span></small>
                        </div>
                    </div>
                </div>

                <!-- 🔹 SECCIÓN DESCUENTO POR PORCENTAJE -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">Descuento por Porcentaje</h6>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvDescuentosPorcentaje" runat="server" AutoGenerateColumns="false" 
                            CssClass="table table-sm table-hover modal-grid"
                            EmptyDataText="No hay descuentos por porcentaje disponibles"
                            ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="Nombre" HeaderText="Descuento" />
                                <asp:BoundField DataField="PorcentajeFormateado" HeaderText="Descuento %" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="Estado" HeaderText="Estado" ItemStyle-Width="120px" />
                                <asp:BoundField DataField="DescuentoAplicadoFormateado" HeaderText="Monto Descontado" ItemStyle-Width="120px" />
                            </Columns>
                        </asp:GridView>
                        <div id="resumenPorcentaje" class="mt-2 p-2 bg-light rounded" style="display:none;">
                            <small><strong>Descuento aplicado:</strong> <span id="lblDescuentoPorcentaje" class="text-success">S/ 0.00</span></small>
                        </div>
                    </div>
                </div>

                <!-- 🔹 SECCIÓN DESCUENTO POR MONTO -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">Descuento por Monto</h6>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvDescuentosMonto" runat="server" AutoGenerateColumns="false" 
                            CssClass="table table-sm table-hover modal-grid"
                            EmptyDataText="No hay descuentos por monto disponibles"
                            ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="Nombre" HeaderText="Descuento" />
                                <asp:BoundField DataField="MontoEditableFormateado" HeaderText="Monto Editable" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="MontoMaximoFormateado" HeaderText="Monto Máximo" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="Estado" HeaderText="Estado" ItemStyle-Width="120px" />
                                <asp:BoundField DataField="DescuentoAplicadoFormateado" HeaderText="Monto Descontado" ItemStyle-Width="120px" />
                            </Columns>
                        </asp:GridView>
                        <div id="resumenMonto" class="mt-2 p-2 bg-light rounded" style="display:none;">
                            <small><strong>Descuento aplicado:</strong> <span id="lblDescuentoMonto" class="text-success">S/ 0.00</span></small>
                        </div>
                    </div>
                </div>

                <!-- 🔹 RESUMEN FINAL DE DESCUENTOS -->
                <div class="mt-4 p-3 resumen-descuentos rounded">
                    <h6 class="mb-3">Resumen de Aplicación de Descuentos</h6>
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <strong>Subtotal inicial:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblSubtotalInicialDescuentos" class="fw-bold">S/ 0.00</span>
                        </div>
                    </div>
                    
                    <div class="row mb-1">
                        <div class="col-md-6">
                            <small class="text-muted">- Descuento Liquidación:</small>
                        </div>
                        <div class="col-md-6 text-end">
                            <small class="text-muted" id="lblDescLiquidacionResumen">S/ 0.00</small>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-md-6">
                            <small class="text-muted">- Descuento Porcentaje:</small>
                        </div>
                        <div class="col-md-6 text-end">
                            <small class="text-muted" id="lblDescPorcentajeResumen">S/ 0.00</small>
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-md-6">
                            <small class="text-muted">- Descuento Monto:</small>
                        </div>
                        <div class="col-md-6 text-end">
                            <small class="text-muted" id="lblDescMontoResumen">S/ 0.00</small>
                        </div>
                    </div>
                    
                    <hr>
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <strong>Total descuentos:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblTotalDescuentosAplicados" class="fw-bold text-success">S/ 0.00</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Total con descuentos:</strong>
                        </div>
                        <div class="col-md-6 text-end">
                            <span id="lblTotalConDescuentos" class="fw-bold text-primary fs-5">S/ 0.00</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-wd" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary btn-wd" onclick="aplicarDescuentos()">
                    Aplicar Descuentos
                </button>
            </div>
        </div>
    </div>
</div>


                        <asp:HiddenField ID="hdnSubtotalConPromociones" runat="server" />

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">

    
    <!-- 🔹 SCRIPT PARA BOTONES DE TALLA Y FUNCIONALIDADES -->
    <script type="text/javascript">
        // Función para inicializar los botones de talla
        function inicializarBotonesTalla() {
            console.log('Inicializando botones de talla...');

            const botonesTalla = document.querySelectorAll('.size-btn');

            botonesTalla.forEach(btn => {
                // Remover event listeners existentes para evitar duplicados
                btn.replaceWith(btn.cloneNode(true));
            });

            // Volver a obtener los botones después del clone
            const nuevosBotones = document.querySelectorAll('.size-btn');

            nuevosBotones.forEach(btn => {
                btn.addEventListener('click', function () {
                    // Si el botón está deshabilitado, no hacer nada
                    if (this.classList.contains('disabled')) {
                        console.log('Talla no disponible:', this.getAttribute('data-talla'));
                        return;
                    }

                    const tallaSeleccionada = this.getAttribute('data-talla');
                    console.log('Talla seleccionada:', tallaSeleccionada);

                    // Remover clase active de todos los botones
                    nuevosBotones.forEach(b => b.classList.remove('active'));

                    // Agregar clase active al botón clickeado
                    this.classList.add('active');

                    // Actualizar el hidden field
                    const hiddenField = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>');
                    if (hiddenField) {
                        hiddenField.value = tallaSeleccionada;
                        console.log('Hidden field actualizado:', hiddenField.value);
                    }

                    // Actualizar cantidad disponible
                    actualizarCantidadDisponible(tallaSeleccionada);
                    actualizarSubtotal();

                    console.log('✅ Talla seleccionada y guardada:', tallaSeleccionada);
                });
            });

            // Si hay una talla existente, seleccionarla
            const tallaExistente = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value;
            if (tallaExistente && tallaExistente !== '') {
                console.log('Talla existente encontrada:', tallaExistente);
                setTimeout(() => {
                    seleccionarTallaExistente(tallaExistente);
                }, 100);
            }

            console.log('Botones de talla inicializados correctamente');
        }

        // Función para seleccionar talla existente (MEJORADA)
        function seleccionarTallaExistente(talla) {
            console.log('🔹 Intentando seleccionar talla existente:', talla);

            const botones = document.querySelectorAll('.size-btn');
            let encontrada = false;

            botones.forEach(btn => {
                const tallaBtn = btn.getAttribute('data-talla');
                if (tallaBtn && tallaBtn.toUpperCase() === talla.toUpperCase() && !btn.classList.contains('disabled')) {
                    btn.classList.add('active');
                    document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value = talla;
                    encontrada = true;
                    console.log('✅ Talla existente seleccionada:', talla);

                    // Actualizar cantidad disponible
                    actualizarCantidadDisponible(talla);
                } else {
                    btn.classList.remove('active');
                }
            });

            if (!encontrada) {
                console.warn('❌ Talla no encontrada o no disponible:', talla);
                document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value = '';
            }
        }

        // Función para actualizar cantidad disponible según talla seleccionada
        function actualizarCantidadDisponible(talla) {
            const stockPorTalla = document.getElementById('<%= hdnStockPorTalla.ClientID %>').value;
            let stockData = {};

            try {
                stockData = JSON.parse(stockPorTalla || '{}');
            } catch (e) {
                console.error('Error parsing stock data:', e);
                stockData = {};
            }

            const cantidadDisponible = stockData[talla] || 0;
            document.getElementById('<%= txtCantidadDisponible.ClientID %>').value = cantidadDisponible;
            console.log('Cantidad disponible actualizada:', cantidadDisponible, 'para talla:', talla);
        }

        // Función para habilitar/deshabilitar botones de talla según stock
        function actualizarDisponibilidadTallas(stockData) {
            console.log('🔹 Actualizando disponibilidad de tallas con datos:', stockData);

            const botones = document.querySelectorAll('.size-btn');
            let tallasDisponibles = 0;

            botones.forEach(btn => {
                const talla = btn.getAttribute('data-talla');
                const stock = stockData[talla] || 0;

                console.log(`Talla: ${talla}, Stock: ${stock}`);

                if (stock > 0) {
                    btn.classList.remove('disabled');
                    btn.style.cursor = 'pointer';
                    tallasDisponibles++;
                    console.log(`✅ Talla ${talla} habilitada (stock: ${stock})`);
                } else {
                    btn.classList.add('disabled');
                    btn.style.cursor = 'not-allowed';
                    btn.classList.remove('active');
                    console.log(`❌ Talla ${talla} deshabilitada (sin stock)`);
                }
            });

            console.log(`🔹 Total de tallas disponibles: ${tallasDisponibles}`);

            // Si no hay tallas disponibles, limpiar selección
            if (tallasDisponibles === 0) {
                document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value = '';
                document.getElementById('<%= txtCantidadDisponible.ClientID %>').value = '0';
            }
        }

        // Función para actualizar subtotal con precios escalonados
        function actualizarSubtotal() {
            const precioUnidad = parseFloat(document.getElementById('<%= txtPrecioUnidad.ClientID %>').value) || 0;
            const precioMayor = parseFloat(document.getElementById('<%= txtPrecioMayor.ClientID %>').value) || 0;
            const precioDocena = parseFloat(document.getElementById('<%= txtPrecioDescuento.ClientID %>').value) || 0;
            const cantidadRequerida = parseInt(document.getElementById('<%= txtCantidadRequerida.ClientID %>').value) || 0;

            let precioAplicado = precioUnidad;

            // Aplicar precios escalonados
            if (cantidadRequerida >= 6 && cantidadRequerida < 12) {
                precioAplicado = precioMayor;
                console.log('Aplicando precio mayorista (P/M)');
            } else if (cantidadRequerida >= 12) {
                precioAplicado = precioDocena;
                console.log('Aplicando precio por docena (P/D)');
            } else {
                console.log('Aplicando precio unitario (P/U)');
            }

            const subtotal = precioAplicado * cantidadRequerida;
            document.getElementById('<%= txtSubtotal.ClientID %>').value = subtotal.toFixed(2);

            console.log('Subtotal actualizado:', subtotal, 'Cantidad:', cantidadRequerida, 'Precio aplicado:', precioAplicado);
        }
        // 🔹 ACTUALIZAR: Inicializar después de mostrar el modal
        function inicializarModalPromociones() {
            setTimeout(() => {
                calcularTotalDescuentoPromociones();
            }, 500);
        }

        function calcularTotalDescuentoPromociones() {
            let totalDescuento = 0;

            // Recorrer todas las filas del GridView de promociones
            const filas = document.querySelectorAll('#gvPromociones tr:not(:first-child)');

            filas.forEach(fila => {
                const celdas = fila.querySelectorAll('td');
                if (celdas.length >= 5) {
                    const textoDescuento = celdas[4].textContent.trim();
                    const descuento = parseFloat(textoDescuento.replace('S/', '').trim()) || 0;
                    totalDescuento += descuento;
                }
            });

            // Actualizar el label
            const lblTotal = document.getElementById('lblTotalDescuentoPromociones');
            if (lblTotal) {
                lblTotal.textContent = `S/ ${totalDescuento.toFixed(2)}`;
            }

            return totalDescuento;
        }


        // Función para validar cantidad en tiempo real (SOLO VALIDACIÓN, NO AFECTA CÁLCULO)
        function validarCantidadEnTiempoReal() {
            const cantidadInput = document.getElementById('<%= txtCantidadRequerida.ClientID %>');
            const cantidadRequerida = parseInt(cantidadInput.value) || 0;
            const tallaSeleccionada = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value;

            if (!tallaSeleccionada) {
                // Si no hay talla seleccionada, solo actualizar subtotal
                actualizarSubtotal();
                return true; // No hay validación posible sin talla
            }

            // Obtener stock disponible
            const stockPorTallaValue = document.getElementById('<%= hdnStockPorTalla.ClientID %>').value;
            let stockPorTalla = {};

            try {
                stockPorTalla = JSON.parse(stockPorTallaValue || '{}');
            } catch (e) {
                console.error('Error parsing stock data:', e);
            }

            const stockDisponible = stockPorTalla[tallaSeleccionada] || 0;

            // 🔹 VALIDACIÓN VISUAL (NO BLOQUEANTE)
            if (cantidadRequerida > stockDisponible) {
                cantidadInput.style.borderColor = 'red';
                cantidadInput.title = `La cantidad (${cantidadRequerida}) excede el stock disponible (${stockDisponible})`;
                console.warn(`⚠️ Validación: Cantidad excede stock: ${cantidadRequerida} > ${stockDisponible}`);
                return false;
            } else if (cantidadRequerida <= 0) {
                cantidadInput.style.borderColor = 'orange';
                cantidadInput.title = 'La cantidad debe ser mayor a cero';
                return false;
            } else {
                cantidadInput.style.borderColor = '';
                cantidadInput.title = '';
                console.log('✅ Cantidad válida');
                return true;
            }
        }

        function mostrarModalPromociones() {
            console.log('🔹 Intentando mostrar modal de promociones...');

            // Esperar un poco para que el UpdatePanel termine
            setTimeout(function () {
                const modalElement = document.getElementById('modalPromociones');
                if (modalElement) {
                    console.log('🔹 Modal encontrado, mostrando...');

                    // Usar jQuery para mejor compatibilidad con Bootstrap
                    $('#modalPromociones').modal({
                        backdrop: 'static',
                        keyboard: false
                    });

                    $('#modalPromociones').modal('show');

                    // 🔹 CORRECCIÓN: Esperar más tiempo para que el GridView se renderice completamente
                    setTimeout(function () {
                        console.log('🔹 Calculando descuentos después de mostrar modal...');
                        calcularTotalDescuentoPromociones();
                    }, 800); // 🔹 Aumentar el tiempo de espera

                } else {
                    console.error('❌ No se encontró el modal con ID modalPromociones');
                }
            }, 300);
        }

        function forzarSeleccionTalla(talla, cantidad) {
            console.log('🔹 Forzando selección de talla:', talla, 'Cantidad:', cantidad);

            // Esperar a que los botones estén listos
            setTimeout(function () {
                const botones = document.querySelectorAll('.size-btn');
                let tallaEncontrada = false;

                botones.forEach(btn => {
                    const tallaBtn = btn.getAttribute('data-talla');
                    if (tallaBtn && tallaBtn.toUpperCase() === talla.toUpperCase() && !btn.classList.contains('disabled')) {
                        console.log('✅ Talla encontrada y disponible:', tallaBtn);
                        btn.classList.add('active');
                        document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value = talla;
                tallaEncontrada = true;

                // Actualizar cantidad disponible
                actualizarCantidadDisponible(talla);

                // Establecer cantidad
                if (cantidad > 0) {
                    document.getElementById('<%= txtCantidadRequerida.ClientID %>').value = cantidad;
                    // Actualizar subtotal después de establecer cantidad
                    setTimeout(actualizarSubtotal, 200);
                }
            } else {
                btn.classList.remove('active');
            }
        });

        if (!tallaEncontrada) {
            console.warn('❌ Talla no encontrada o no disponible:', talla);
            // Reintentar después de un segundo
            setTimeout(function () { forzarSeleccionTalla(talla, cantidad); }, 1000);
        }
    }, 500);
        }

        // 🔹 INICIALIZACIÓN MEJORADA PARA MODO MODIFICACIÓN
        function inicializarModoModificacion() {
            const urlParams = new URLSearchParams(window.location.search);
            const modo = urlParams.get('modo');

            if (modo === 'modificar') {
                console.log('🔹 Inicializando modo modificación...');

                // Esperar a que todo esté cargado
                setTimeout(function () {
                    // Las tallas y cantidad se establecerán desde el código servidor
                    console.log('🔹 Modo modificación inicializado');
                }, 1500);
            }
        }

        // Ejecutar cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', function () {
            inicializarModoModificacion();
        });



        // 🔹 CORREGIDO: CALCULAR TOTAL DESCUENTO PROMOCIONES
        function calcularTotalDescuentoPromociones() {
            let totalDescuento = 0;
            console.log('🔹 Calculando total de descuentos...');

            const tabla = document.getElementById('<%= gvPromociones.ClientID %>');
            if (!tabla) {
                console.log('❌ No se encontró la tabla de promociones');
                return 0;
            }

            const filas = tabla.querySelectorAll('tbody tr');
            console.log(`🔹 Encontradas ${filas.length} filas en la tabla`);

            filas.forEach((fila, index) => {
                const celdas = fila.querySelectorAll('td');
                console.log(`Fila ${index + 1}: ${celdas.length} celdas encontradas`);

                // 🔹 CORRECCIÓN: La columna de descuento ahora es la 6 (índice 5)
                if (celdas.length >= 6) {
                    const textoDescuento = celdas[5].textContent.trim();
                    console.log(`Fila ${index + 1}: Texto descuento = "${textoDescuento}"`);

                    // 🔹 CORRECCIÓN: Mejorar el parseo del texto
                    const textoLimpio = textoDescuento.replace('S/', '').replace(',', '').trim();
                    const descuento = parseFloat(textoLimpio) || 0;

                    totalDescuento += descuento;
                    console.log(`Fila ${index + 1}: Descuento numérico = ${descuento}, Acumulado = ${totalDescuento}`);
                } else {
                    console.log(`Fila ${index + 1}: No tiene suficientes celdas (${celdas.length})`);
                }
            });

            // Actualizar el label
            const lblTotal = document.getElementById('lblTotalDescuentoPromociones');
            if (lblTotal) {
                lblTotal.textContent = 'S/ ' + totalDescuento.toFixed(2);
                console.log(`✅ Total descuento actualizado: S/ ${totalDescuento.toFixed(2)}`);
            } else {
                console.error('❌ No se encontró el label lblTotalDescuentoPromociones');
            }

            return totalDescuento;
        }

        // 🔹 SCRIPT TEMPORAL PARA DEBUG DEL GRIDVIEW
        function debugGridViewPromociones() {
            console.log('=== DEBUG GRIDVIEW PROMOCIONES ===');

            const tabla = document.getElementById('<%= gvPromociones.ClientID %>');
            if (!tabla) {
                console.log('❌ Tabla no encontrada');
                return;
            }

            const filas = tabla.querySelectorAll('tbody tr');
            console.log(`📊 Filas encontradas: ${filas.length}`);

            filas.forEach((fila, index) => {
                const celdas = fila.querySelectorAll('td');
                console.log(`Fila ${index + 1}: ${celdas.length} celdas`);

                celdas.forEach((celda, celdaIndex) => {
                    console.log(`  Celda ${celdaIndex}: "${celda.textContent.trim()}"`);
                });
            });

            console.log('=== FIN DEBUG ===');
        }


        // Llamar después de abrir el modal
        function mostrarModalPromocionesConDebug() {
            mostrarModalPromociones();
            setTimeout(debugGridViewPromociones, 1000);
        }


        // Función para validar antes de enviar
        function validarCantidadAntesDeEnviar() {
            const cantidadInput = document.getElementById('<%= txtCantidadRequerida.ClientID %>');
            const cantidadRequerida = parseInt(cantidadInput.value) || 0;
            const tallaSeleccionada = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value;

            if (!tallaSeleccionada) {
                alert('Por favor, seleccione una talla.');
                return false;
            }

            // Obtener stock disponible
            const stockPorTallaValue = document.getElementById('<%= hdnStockPorTalla.ClientID %>').value;
            let stockPorTalla = {};

            try {
                stockPorTalla = JSON.parse(stockPorTallaValue || '{}');
            } catch (e) {
                console.error('Error parsing stock data:', e);
                return false;
            }

            const stockDisponible = stockPorTalla[tallaSeleccionada] || 0;

            if (cantidadRequerida > stockDisponible) {
                alert(`La cantidad requerida (${cantidadRequerida}) no puede ser mayor al stock disponible (${stockDisponible}) para la talla ${tallaSeleccionada}.`);
                return false;
            }

            if (cantidadRequerida <= 0) {
                alert('La cantidad requerida debe ser mayor a cero.');
                return false;
            }

            return true;
        }

        // Inicializar cuando el documento esté listo
        document.addEventListener('DOMContentLoaded', function () {
            console.log('DOM completamente cargado - Inicializando componentes...');

            // Inicializar botones de talla
            inicializarBotonesTalla();

            // 🔹 EJECUTAR ACTUALIZACIÓN DE DISPONIBILIDAD SI HAY DATOS DE STOCK
            const stockPorTalla = document.getElementById('<%= hdnStockPorTalla.ClientID %>').value;
            if (stockPorTalla && stockPorTalla !== '{}') {
                try {
                    const stockData = JSON.parse(stockPorTalla);
                    console.log('🔹 Datos de stock encontrados al cargar:', stockData);
                    actualizarDisponibilidadTallas(stockData);

                    // Restaurar talla seleccionada si existe
                    const tallaSeleccionada = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value;
                    if (tallaSeleccionada) {
                        setTimeout(() => {
                            seleccionarTallaExistente(tallaSeleccionada);
                        }, 200);
                    }
                } catch (e) {
                    console.error('Error parsing stock data on load:', e);
                }
            }

            // Configurar eventos de cantidad
            const cantidadInput = document.getElementById('<%= txtCantidadRequerida.ClientID %>');
            if (cantidadInput) {
                cantidadInput.addEventListener('input', function () {
                    validarCantidadEnTiempoReal(); // Solo validación visual
                    actualizarSubtotal(); // 🔹 EL CÁLCULO DEL SUBTOTAL SIGUE FUNCIONANDO NORMALMENTE
                });
                cantidadInput.addEventListener('change', function () {
                    validarCantidadEnTiempoReal(); // Solo validación visual
                    actualizarSubtotal(); // 🔹 EL CÁLCULO DEL SUBTOTAL SIGUE FUNCIONANDO NORMALMENTE
                });
            }

            // Configurar validación del botón "Añadir Producto"
            const btnAnadirProducto = document.getElementById('<%= btnAnadirProducto.ClientID %>');
            if (btnAnadirProducto) {
                btnAnadirProducto.addEventListener('click', function (e) {
                    if (!validarCantidadAntesDeEnviar()) {
                        e.preventDefault(); // Detener el envío del formulario
                        return false;
                    }
                });
            }

            // También inicializar después de un postback de ASP.NET
            if (typeof (Sys) !== 'undefined') {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    console.log('🔹 Postback completado - Reinicializando componentes...');
                    setTimeout(() => {
                        inicializarBotonesTalla();

                        // 🔹 ACTUALIZAR DISPONIBILIDAD DESPUÉS DE POSTBACK
                        const stockPorTalla = document.getElementById('<%= hdnStockPorTalla.ClientID %>').value;
                        if (stockPorTalla && stockPorTalla !== '{}') {
                            try {
                                const stockData = JSON.parse(stockPorTalla);
                                console.log('🔹 Datos de stock después de postback:', stockData);
                                actualizarDisponibilidadTallas(stockData);

                                // Restaurar talla seleccionada si existe
                                const tallaSeleccionada = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value;
                                if (tallaSeleccionada) {
                                    setTimeout(() => {
                                        seleccionarTallaExistente(tallaSeleccionada);
                                    }, 200);
                                }
                            } catch (e) {
                                console.error('Error updating talla availability after postback:', e);
                            }
                        }
                    }, 100);
                });
            }
        });

        // 🔹 CORREGIDO: FUNCIÓN PARA APLICAR PROMOCIONES
        function aplicarPromociones() {
            console.log('🔹 Aplicando promociones...');

            // Obtener el total con descuento del modal
            var totalConDescuentoElement = document.getElementById('lblTotalConDescuentoPromociones');
            if (!totalConDescuentoElement) {
                console.error('❌ No se encontró el elemento lblTotalConDescuentoPromociones');
                alert('Error: No se pudo obtener el total con descuento.');
                return;
            }

            var totalConDescuentoText = totalConDescuentoElement.textContent;
            console.log('🔹 Texto del total:', totalConDescuentoText);

            // Extraer el número (remover "S/ ")
            var totalConDescuento = totalConDescuentoText.replace('S/', '').trim();
            console.log('🔹 Total numérico:', totalConDescuento);

            // Validar que sea un número válido
            if (isNaN(parseFloat(totalConDescuento))) {
                console.error('❌ Total con descuento no es un número válido:', totalConDescuento);
                alert('Error: El total con descuento no es válido.');
                return;
            }

            // 🔹 ACTUALIZAR DIRECTAMENTE EL SUBTOTAL EN PANTALLA
            var txtSubtotal = document.getElementById('<%= txtSubtotal.ClientID %>');
       if (txtSubtotal) {
           txtSubtotal.value = parseFloat(totalConDescuento).toFixed(2);
           console.log('✅ Subtotal actualizado inmediatamente: S/ ' + totalConDescuento);
       }

       // 🔹 ACTUALIZAR HIDDEN FIELD
       var hdnSubtotal = document.getElementById('<%= hdnSubtotalConPromociones.ClientID %>');
       if (hdnSubtotal) {
           hdnSubtotal.value = parseFloat(totalConDescuento).toFixed(2);
           console.log('✅ HiddenField actualizado: S/ ' + totalConDescuento);
       }

       // Cerrar el modal
       var modal = bootstrap.Modal.getInstance(document.getElementById('modalPromociones'));
       if (modal) {
           modal.hide();
       }

       console.log('✅ Promociones aplicadas correctamente');
   }


        function aplicarDescuentos() {
            console.log('🔹 Aplicando descuentos...');

            // Obtener el TOTAL CON DESCUENTO (no el monto del descuento)
            var totalConDescuentoElement = document.getElementById('lblTotalConDescuentos');
            if (!totalConDescuentoElement) {
                console.error('❌ No se encontró el elemento lblTotalConDescuentos');
                alert('Error: No se pudo obtener el total con descuento.');
                return;
            }

            var totalConDescuentoText = totalConDescuentoElement.textContent;
            console.log('🔹 Texto del TOTAL CON DESCUENTO:', totalConDescuentoText);

            // Extraer el número (remover "S/ ")
            var totalConDescuento = totalConDescuentoText.replace('S/', '').trim();
            console.log('🔹 Total con descuento numérico:', totalConDescuento);

            // Validar que sea un número válido
            if (isNaN(parseFloat(totalConDescuento))) {
                console.error('❌ Total con descuento no es un número válido:', totalConDescuento);
                alert('Error: El total con descuento no es válido.');
                return;
            }

            var subtotalOriginal = parseFloat(document.getElementById('<%= txtSubtotal.ClientID %>').value) || 0;

           // Validación adicional en el cliente
           if (parseFloat(totalConDescuento) > subtotalOriginal) {
               console.error('❌ Validación cliente: Total con descuento > Subtotal original');
               alert('Error: El descuento no puede resultar en un valor mayor al subtotal original.');
               return;
           }

           console.log('✅ Validaciones pasadas - procediendo con postback');

           // Hacer postback para aplicar los descuentos
           __doPostBack('AplicarDescuentos', '');

           // Cerrar el modal después de un breve delay
           setTimeout(function () {
               var modal = bootstrap.Modal.getInstance(document.getElementById('modalDescuentos'));
               if (modal) {
                   modal.hide();
               }
           }, 500);

           console.log('✅ Postback para aplicar descuentos enviado');
        }

        function cerrarModalDescuentos() {
            console.log('🔹 Cerrando modal de descuentos desde JavaScript...');

            var modalElement = document.getElementById('modalDescuentos');
            if (modalElement) {
                var modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) {
                    modal.hide();
                } else {
                    var newModal = new bootstrap.Modal(modalElement);
                    newModal.hide();
                }
            }

            // Limpiar backdrop
            setTimeout(function () {
                var backdrops = document.querySelectorAll('.modal-backdrop');
                backdrops.forEach(function (backdrop) {
                    backdrop.remove();
                });
                document.body.classList.remove('modal-open');
                document.body.style.paddingRight = '';
                document.body.style.overflow = '';
            }, 150);

            console.log('✅ Modal de descuentos cerrado correctamente');
        }



        function configurarDeteccionCambios() {
            const cantidadInput = document.getElementById('<%= txtCantidadRequerida.ClientID %>');
            const tipoPrendaDropdown = document.getElementById('<%= ddlTipoPrenda.ClientID %>');

            if (cantidadInput) {
                cantidadInput.addEventListener('change', function () {
                    // Si estamos en modo modificación y hay cambios, permitir recalcular descuentos
                    const esModificacion = '<%= Request.QueryString["modo"] %>' === 'modificar';
            if (esModificacion) {
                console.log('🔹 Cambio detectado en modo modificación - habilitando recálculo');
                // Mostrar mensaje al usuario
                mostrarMensajeCambios();
            }
        });
            }
        }

        function mostrarMensajeCambios() {
            // Puedes mostrar un tooltip o mensaje indicando que puede recalcular descuentos
            console.log('🔹 Informar al usuario que puede recalcular descuentos si lo desea');
        }

        // Inicializar cuando el documento esté listo
        document.addEventListener('DOMContentLoaded', function () {
            configurarDeteccionCambios();
        });


        function aplicarDescuentos() {
            console.log('🔹 Aplicando descuentos...');

            // Obtener el TOTAL CON DESCUENTO (no el monto del descuento)
            var totalConDescuentoElement = document.getElementById('lblTotalConDescuentos');
            if (!totalConDescuentoElement) {
                console.error('❌ No se encontró el elemento lblTotalConDescuentos');
                alert('Error: No se pudo obtener el total con descuento.');
                return;
            }

            var totalConDescuentoText = totalConDescuentoElement.textContent;
            console.log('🔹 Texto del TOTAL CON DESCUENTO:', totalConDescuentoText);

            // Extraer el número (remover "S/ ")
            var totalConDescuento = totalConDescuentoText.replace('S/', '').trim();
            console.log('🔹 Total con descuento numérico:', totalConDescuento);

            // Validar que sea un número válido
            if (isNaN(parseFloat(totalConDescuento))) {
                console.error('❌ Total con descuento no es un número válido:', totalConDescuento);
                alert('Error: El total con descuento no es válido.');
                return;
            }

            var subtotalOriginal = parseFloat(document.getElementById('<%= txtSubtotal.ClientID %>').value) || 0;

           // Validación adicional en el cliente
           if (parseFloat(totalConDescuento) > subtotalOriginal) {
               console.error('❌ Validación cliente: Total con descuento > Subtotal original');
               alert('Error: El descuento no puede resultar en un valor mayor al subtotal original.');
               return;
           }

           console.log('✅ Validaciones pasadas - procediendo con postback');

           // 🔹 CORRECCIÓN: Cerrar el modal inmediatamente antes del postback
           cerrarModalDescuentos();

           // Hacer postback para aplicar los descuentos
           __doPostBack('AplicarDescuentos', '');

           console.log('✅ Postback para aplicar descuentos enviado');
       }





    </script>
</asp:Content> 