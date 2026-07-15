<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="AnnadirLineaDeLaCompra.aspx.cs" Inherits="WearDropWA.AnnadirLineaDeLaCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">


    Añadir Línea de la Compra

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

        a, a:visited, a:hover, a:active, .btn-wd { text-decoration:none !important; color:inherit }

        .btn-wd {
            background:var(--btn); color:#fff; border:none; padding:8px 18px;
            border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        /* ===== Tonos AZULES como en las páginas anteriores ===== */
        .theme-linea-compra { 
            --tone-1: #C7D6E2; /* azul claro */
            --tone-2: #9FB6C8; /* azul medio */  
            --tone-3: #7C98AD; /* azul oscuro */
        }

        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }

        /* ===== Secciones ===== */
        .section-container {
            width: 60%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* Subdivisiones */
        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
        }

        /* Etiquetas */
        .label-title {
            margin-bottom: 12px;
            color: #333;
            font-size: 1rem;
            font-weight: 500;
        }

        /* Contenedores */
        .row-container {
            display: flex;
            justify-content: space-between;
            gap: 50px;
            width: 100%;
        }

        .col {
            flex: 1;
        }

        /* TextBox y DropDownList */
        .form-control, .form-select {
            width: 100%;
            text-align: left;
            padding: 8px 12px;
            border: 1px solid #dee2e6;
            border-radius: 6px;
        }

        /* ===== Botones de tallas ===== */
        .size-section {
            display: flex;
            flex-direction: column;
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
        .size-btn:hover,
        .size-btn.active {
            background-color: var(--tone-3);
            color: #fff;
        }

        /* ===== CONTENEDOR PRINCIPAL DE BOTONES INFERIORES ===== */
        .main-buttons-container {
            width: 60%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }

        /* ===== Botón Regresar a la izquierda ===== */
        .left-button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }

        /* ===== Botón Añadir Línea a la derecha ===== */
        .right-button-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
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

        .modal-backdrop {
    z-index: 1040 !important;
}

.modal {
    z-index: 1050 !important;
}

/* Asegurar que el body se comporte correctamente */
body.modal-open {
    overflow: hidden;
    padding-right: 0px !important;
}

/* Forzar la eliminación de cualquier backdrop residual */
.modal-backdrop.show {
    opacity: 0.5;
}

/* Estilo para cuando el modal está oculto */
.modal:not(.show) {
    display: none !important;
}
size-btn {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    border: 2px solid var(--tone-3);
    background-color: #fff;
    color: var(--tone-3);
    font-weight: 600;
    transition: all 0.3s ease-in-out;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.size-btn:hover {
    background-color: var(--tone-2);
    color: #fff;
    transform: scale(1.1);
}

.size-btn.active {
    background-color: var(--tone-3) !important;
    color: #fff !important;
    border-color: var(--tone-3) !important;
    transform: scale(1.1);
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

/* Estilo para modo deshabilitado */
.size-btn:disabled,
.size-btn.disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none !important;
}

.size-btn:disabled:hover,
.size-btn.disabled:hover {
    background-color: #fff;
    color: var(--tone-3);
    transform: none;
}
/* ===== ESTILOS PARA INFORMACIÓN DE PRENDA ENCONTRADA ===== */
.prenda-info-encontrada {
    background-color: #e8f5e8;
    border: 1px solid #4caf50;
    border-radius: 6px;
    padding: 10px 15px;
    margin-top: 10px;
    font-size: 0.9rem;
    color: #2e7d32;
}

.prenda-info-encontrada strong {
    color: #1b5e20;
}

/* Estilos para diferentes modos */
.modo-ver .prenda-info-encontrada {
    background-color: #e3f2fd;
    border-color: #2196f3;
    color: #1565c0;
}

.modo-ver .prenda-info-encontrada strong {
    color: #0d47a1;
}

.modo-modificar .prenda-info-encontrada {
    background-color: #fff3e0;
    border-color: #ff9800;
    color: #ef6c00;
}

.modo-modificar .prenda-info-encontrada strong {
    color: #e65100;
}

/* Estilos para el dropdown en modo ver/modificar */
.modo-ver .form-select,
.modo-modificar .form-select {
    background-color: #f8f9fa;
    border-color: #6c757d;
}

.modo-ver .form-select:disabled,
.modo-modificar .form-select:disabled {
    background-color: #e9ecef;
    color: #495057;
    opacity: 1;
}


    </style>

<!-- -------------------- TÍTULO PRINCIPAL -------------------- -->
<div id="themeWrap" runat="server" class="theme-linea-compra">
    <div class="theme-scope">
        <div class="container">
            <div class="top-accent"></div>

            <!-- 🔹 BLOQUES DE COLOR Y TÍTULO -->
            <div class="container row">
                <div class="row align-items-center">
                    <div class="col-md-6 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <h2>Añadir Línea de la Compra</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 🔹 UPDATE PANEL QUE INCLUYE TODO, INCLUIDO EL MODAL -->
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <!-- 🔹 CONTENEDOR DE MENSAJES -->
                    <div class="section-container">
                        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-alerta" 
                            Visible="false" EnableViewState="false" />
                    </div>

                    <!-- 🔹 SECCIÓN DE CONTENIDO -->
                    <div class="section-container">

                        <!-- 🔹 TIPO DE PRENDA -->
                        <div class="subsection">
                            <div class="row-container">
                                <div class="col">
                                    <h3 class="label-title">Tipo de Prenda</h3>
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
                        </div>

                        <!-- 🔹 NOMBRE DE LA PRENDA -->
                        <div class="subsection">
                            <div class="row-container">
                                <div class="col">
                                    <h3 class="label-title">Nombre de la Prenda</h3>
                                    <asp:TextBox ID="txtNombrePrenda" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    <asp:HiddenField ID="hdnIdPrenda" runat="server" />
                                </div>
                                <div class="col">
                                    <!-- Espacio vacío para mantener la estructura -->
                                </div>
                            </div>
                        </div>

                        <!-- 🔹 TALLAS -->
                        <!-- 🔹 TALLAS - VERSIÓN CORREGIDA -->
<div class="subsection size-section">
    <h3 class="label-title">Talla (*)</h3>
    <div class="size-buttons">
        <button type="button" class="size-btn" data-talla="XS">XS</button>
        <button type="button" class="size-btn" data-talla="S">S</button>
        <button type="button" class="size-btn" data-talla="M">M</button>
        <button type="button" class="size-btn" data-talla="L">L</button>
        <button type="button" class="size-btn" data-talla="XL">XL</button>
        <button type="button" class="size-btn" data-talla="XXL">XXL</button>
    </div>
    <asp:HiddenField ID="hdnTallaSeleccionada" runat="server" />
    
    <!-- 🔹 AGREGAR ESTE ELEMENTO PARA DEBUG -->
    <div id="debugTalla" style="margin-top: 10px; font-size: 12px; color: #666;"></div>
</div>

                        <!-- 🔹 NUEVO CAMPO: CANTIDAD COMPRADA -->
                        <div class="subsection">
                            <div class="row-container">
                                <div class="col">
                                    <h3 class="label-title">Cantidad Comprada (*)</h3>
                                    <asp:TextBox ID="txtCantidadComprada" runat="server" CssClass="form-control" 
                                        TextMode="Number" min="1" step="1" placeholder="Ingrese la cantidad"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <!-- Espacio vacío para mantener la estructura -->
                                </div>
                            </div>
                        </div>

                        <!-- 🔹 SECCIÓN ID LOTE CON BOTÓN MODAL - SEPARADA DE PRECIO -->
<div class="subsection">
    <div class="row-container">
        <div class="col">
            <h3 class="label-title">ID de Lote (*)</h3>
            <div class="proveedor-container">
                <div class="proveedor-textbox">
                    <asp:TextBox ID="txtIDLote" runat="server" CssClass="form-control" ReadOnly="true" 
                        placeholder="Seleccione un lote"></asp:TextBox>
                    <asp:HiddenField ID="hdnIdLote" runat="server" />
                </div>
                <div class="proveedor-button">
                    <asp:Button ID="btnAbrirModalLote" runat="server" Text="Seleccionar Lote" 
                        CssClass="btn-wd" OnClick="btnAbrirModalLote_Click" />
                </div>
            </div>
        </div>
        
        <!-- 🔹 NUEVO: Columna vacía para mantener estructura -->
        <div class="col">
            <!-- Espacio vacío para mantener la estructura -->
        </div>
    </div>
</div>

<!-- 🔹 NUEVA SECCIÓN SEPARADA PARA PRECIO DEL LOTE -->
<div class="subsection">
    <div class="row-container">
        <div class="col">
            <h3 class="label-title">Precio del Lote (*)</h3>
            <asp:TextBox ID="txtPrecioLote" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
        </div>
        
        <!-- 🔹 NUEVO: Columna vacía para mantener estructura -->
        <div class="col">
            <!-- Espacio vacío para mantener la estructura -->
        </div>
    </div>
</div>

                    </div>

                    <!-- 🔹 CONTENEDOR PRINCIPAL DE BOTONES INFERIORES -->
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

                        <!-- 🔹 BOTÓN AÑADIR LÍNEA (DERECHA) -->
                        <div class="right-button-container">
                            <asp:Button 
                                ID="btnAnadirLinea" 
                                runat="server" 
                                Text="Añadir Línea"
                                CssClass="btn-wd rounded shadow-sm"
                                OnClick="btnAnadirLinea_Click" />
                        </div>
                    </div>

                    <!-- 🔹 MODAL DENTRO DEL UPDATE PANEL -->
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

                        <!-- 🔹 NUEVO MODAL PARA SELECCIONAR LOTE -->
<div class="modal fade" id="modalSeleccionarLote" tabindex="-1" aria-labelledby="modalLoteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLoteLabel">Seleccionar Lote</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvLotes" runat="server" AutoGenerateColumns="false" 
    CssClass="table table-hover table-striped modal-grid"
    OnRowCommand="gvLotes_RowCommand" 
    EmptyDataText="No se encontraron lotes activos"
    ShowHeaderWhenEmpty="true">
    
    <Columns>
        <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="80px" />
        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
        <asp:BoundField DataField="Almacen" HeaderText="Almacén" ItemStyle-Width="120px" />
        <asp:BoundField DataField="Activo" HeaderText="Estado" ItemStyle-Width="100px" />
        <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
            <ItemTemplate>
                <asp:LinkButton ID="lnkSeleccionarLote" runat="server" CssClass="btn btn-sm btn-wd"
                    CommandName="SeleccionarLote" 
                    CommandArgument='<%# Eval("Id") + "|" + Eval("Descripcion") %>'
                    Text="Seleccionar" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    
    <EmptyDataTemplate>
        <div class="text-center p-3">
            <i class="fas fa-exclamation-circle fa-2x text-muted mb-2"></i>
            <p class="text-muted">No se encontraron lotes activos</p>
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





    <!-- 🔹 SCRIPT ACTIVADOR DE TALLAS -->
    <!-- 🔹 SCRIPT MEJORADO PARA MANEJAR MODALES Y TALLAS -->
<!-- 🔹 SCRIPT MEJORADO PARA TALLAS Y MODALES -->
<script type="text/javascript">
    // Función para inicializar los botones de talla
    function inicializarBotonesTalla() {
        console.log('Inicializando botones de talla...');

        const botonesTalla = document.querySelectorAll('.size-btn');
        const modo = '<%= Session["ModoLinea"] ?? "nuevo" %>';
        const debugElement = document.getElementById('debugTalla');

        console.log('Modo detectado:', modo);
        console.log('Botones encontrados:', botonesTalla.length);

        botonesTalla.forEach(btn => {
            // Remover event listeners existentes para evitar duplicados
            btn.replaceWith(btn.cloneNode(true));
        });

        // Volver a obtener los botones después del clone
        const nuevosBotones = document.querySelectorAll('.size-btn');

        nuevosBotones.forEach(btn => {
            btn.addEventListener('click', function () {
                // Solo permitir cambios si no está en modo "ver"
                if (modo === 'ver') {
                    console.log('Modo ver - No se permiten cambios');
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

                // Mostrar debug info
                if (debugElement) {
                    debugElement.innerHTML = `Talla seleccionada: <strong>${tallaSeleccionada}</strong>`;
                    setTimeout(() => {
                        debugElement.innerHTML = '';
                    }, 3000);
                }

                // También mostrar en consola
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

    // Función para seleccionar talla existente
    function seleccionarTallaExistente(talla) {
        console.log('Seleccionando talla existente:', talla);
        
        const botones = document.querySelectorAll('.size-btn');
        let encontrada = false;
        
        botones.forEach(btn => {
            const tallaBtn = btn.getAttribute('data-talla');
            if (tallaBtn && tallaBtn.toUpperCase() === talla.toUpperCase()) {
                btn.classList.add('active');
                document.getElementById('<%= hdnTallaSeleccionada.ClientID %>').value = talla;
                encontrada = true;
                console.log('✅ Talla existente seleccionada:', talla);
            } else {
                btn.classList.remove('active');
            }
        });
        
        if (!encontrada) {
            console.warn('❌ Talla no encontrada en los botones:', talla);
        }
    }

    // Función para cerrar modal completamente
    function cerrarModalCompletamente() {
        console.log('Cerrando modal completamente...');

        const modalElement = document.getElementById('modalSeleccionarPrenda');
        if (modalElement) {
            const modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) {
                modal.hide();
            } else {
                const newModal = new bootstrap.Modal(modalElement);
                newModal.hide();
            }
        }

        // Limpiar backdrop después de un delay
        setTimeout(() => {
            const backdrops = document.querySelectorAll('.modal-backdrop');
            backdrops.forEach(backdrop => {
                backdrop.remove();
            });

            document.body.classList.remove('modal-open');
            document.body.style.paddingRight = '';
            document.body.style.overflow = '';
            
            console.log('✅ Modal completamente limpiado');
        }, 200);
    }

    // Inicializar cuando el documento esté listo
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM completamente cargado - Inicializando componentes...');
        
        // Inicializar botones de talla
        inicializarBotonesTalla();
        
        // Configurar eventos del modal
        const modalElement = document.getElementById('modalSeleccionarPrenda');
        if (modalElement) {
            modalElement.addEventListener('hidden.bs.modal', function() {
                setTimeout(() => {
                    const backdrops = document.querySelectorAll('.modal-backdrop');
                    backdrops.forEach(backdrop => backdrop.remove());
                    document.body.classList.remove('modal-open');
                }, 100);
            });
        }
        
        // También inicializar después de un postback de ASP.NET
        if (typeof(Sys) !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                console.log('Postback completado - Reinicializando botones de talla...');
                setTimeout(() => {
                    inicializarBotonesTalla();
                }, 100);
            });
        }
        
        console.log('✅ Todos los componentes inicializados correctamente');
    });

    // Función global para debug
    function debugTallas() {
        const hiddenField = document.getElementById('<%= hdnTallaSeleccionada.ClientID %>');
        const botones = document.querySelectorAll('.size-btn');

        console.log('=== DEBUG TALLAS ===');
        console.log('Hidden field value:', hiddenField ? hiddenField.value : 'No encontrado');
        console.log('Botones encontrados:', botones.length);

        botones.forEach((btn, index) => {
            console.log(`Botón ${index}:`, {
                text: btn.textContent,
                dataTalla: btn.getAttribute('data-talla'),
                hasActive: btn.classList.contains('active')
            });
        });
        console.log('====================');
    }

    // Ejecutar debug al hacer doble clic en cualquier parte (para testing)
    document.addEventListener('dblclick', function () {
        debugTallas();
    });
</script>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">

      <script type="text/javascript">
          // 🔹 FUNCIONES PARA EL MODAL DE LOTE
          function mostrarModalLote() {
              console.log('🔄 Función mostrarModalLote ejecutada');
              var modalElement = document.getElementById('modalSeleccionarLote');
              console.log('🔍 Modal encontrado:', modalElement);

              if (modalElement) {
                  var modal = new bootstrap.Modal(modalElement);
                  modal.show();
                  console.log('✅ Modal de lote mostrado con Bootstrap');
              } else {
                  console.error('❌ No se pudo encontrar el modal de lote');
                  alert('Error: No se puede abrir el selector de lotes.');
              }
          }

          function cerrarModalLote() {
              console.log('🔄 Cerrando modal de lote...');
              var modalElement = document.getElementById('modalSeleccionarLote');
              if (modalElement) {
                  var modal = bootstrap.Modal.getInstance(modalElement);
                  if (modal) {
                      modal.hide();
                  } else {
                      var newModal = new bootstrap.Modal(modalElement);
                      newModal.hide();
                  }

                  setTimeout(function () {
                      var backdrops = document.querySelectorAll('.modal-backdrop');
                      backdrops.forEach(function (backdrop) {
                          backdrop.remove();
                      });
                      document.body.classList.remove('modal-open');
                      document.body.style.paddingRight = '';
                      document.body.style.overflow = '';
                      modalElement.style.display = 'none';
                      modalElement.classList.remove('show');
                      console.log('✅ Modal de lote cerrado y limpiado completamente');
                  }, 150);
              }
          }

          // Configurar eventos de cierre para el modal de lote
          document.addEventListener('DOMContentLoaded', function () {
              var modalElement = document.getElementById('modalSeleccionarLote');
              if (modalElement) {
                  var closeButton = modalElement.querySelector('.btn-close');
                  if (closeButton) {
                      closeButton.addEventListener('click', function () {
                          cerrarModalLote();
                      });
                  }

                  var cancelButton = modalElement.querySelector('.btn-secondary');
                  if (cancelButton) {
                      cancelButton.addEventListener('click', function () {
                          cerrarModalLote();
                      });
                  }

                  modalElement.addEventListener('hidden.bs.modal', function () {
                      console.log('🔒 Evento hidden.bs.modal disparado para modal de lote');
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

          // Hacer las funciones globales
          window.mostrarModalLote = mostrarModalLote;
          window.cerrarModalLote = cerrarModalLote;

          // ... resto de scripts existentes para tallas ...
      </script>
</asp:Content>
