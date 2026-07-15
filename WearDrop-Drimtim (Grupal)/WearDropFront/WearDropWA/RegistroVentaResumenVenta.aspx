<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistroVentaResumenVenta.aspx.cs" Inherits="WearDropWA.RegistroVentaResumenVenta" %>
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

/* 🔹 ESTILOS PARA MODAL DE CLIENTES (CONSISTENTE CON EL TEMA) */
.modal-clientes .modal-header {
    background: white !important;
    border-bottom: 2px solid var(--tone-3); /* 🔹 BORDE ROJO */
    color: #333;
}

.modal-clientes .modal-title {
    font-weight: 600;
    font-size: 1.3rem;
    color: #333;
}

/* 🔹 GRILLA CON ESTILO SIMILAR A REGISTRAR VENTAS */
.modal-grid {
    border-collapse: collapse;
    width: 100%;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.modal-grid th {
    background: var(--tone-3) !important; /* 🔹 ROJO DEL TEMA */
    color: white !important; /* 🔹 TEXTO BLANCO */
    font-weight: 500;
    padding: 12px 15px;
    text-align: center;
    border: none;
    font-size: 0.9rem;
}

.modal-grid td {
    padding: 10px 15px;
    border-bottom: 1px solid #E8E8E8;
    text-align: center;
    transition: background-color 0.2s ease;
    font-size: 0.875rem;
}

.modal-grid tr:nth-child(even) {
    background: #F8F9FA;
}

.modal-grid tr:hover {
    background: #E8F4E8; /* 🔹 VERDE CLARO AL HOVER */
}

/* 🔹 ESTILO PARA FILA SELECCIONADA CON PUNTO ROJO */
.modal-grid tr.selected {
    background-color: #FFF5F5 !important; /* 🔹 ROJO MUY CLARO */
    position: relative;
    border-left: 3px solid var(--tone-3); /* 🔹 BORDE IZQUIERDO ROJO */
}

.modal-grid tr.selected::before {
    content: "●"; /* 🔹 PUNTO DE SELECCIÓN */
    color: var(--tone-3); /* 🔹 COLOR ROJO DEL TEMA */
    font-size: 16px;
    position: absolute;
    left: 8px;
    top: 50%;
    transform: translateY(-50%);
}

/* 🔹 ESTILOS PARA BOTÓN SELECCIONAR CLIENTE EN GRILLA */
.btn-seleccionar-grid {
    background: var(--tone-3) !important; /* 🔹 ROJO DEL TEMA */
    color: white !important;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 0.875rem;
    text-decoration: none;
    display: inline-block;
}

.btn-seleccionar-grid:hover {
    background: #8B4A52 !important; /* 🔹 ROJO MÁS OSCURO */
    color: white !important;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

/* 🔹 BOTÓN CANCELAR CON ESTILO DE LA PÁGINA */
.btn-cancelar-wd {
    background: #6c757d !important; /* 🔹 GRIS CONSISTENTE */
    color: white !important;
    border: none;
    padding: 8px 18px;
    border-radius: 8px;
    cursor: pointer;
    transition: .15s;
    box-shadow: 0 1px 2px rgba(0,0,0,.08);
    text-decoration: none !important;
}

.btn-cancelar-wd:hover {
    background: #5a6268 !important; /* 🔹 GRIS MÁS OSCURO */
    color: white !important;
    filter: brightness(.95);
}

/* 🔹 BOTÓN SELECCIONAR CLIENTE (FUERA DEL MODAL) */
.btn-seleccionar-container {
    display: flex;
    align-items: center;
    gap: 15px;
}

.btn-seleccionar-cliente {
    background: var(--tone-3);
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 8px;
    cursor: pointer;
    transition: .15s;
    box-shadow: 0 1px 2px rgba(0,0,0,.08);
}

.btn-seleccionar-cliente:hover {
    background: #8B4A52; /* 🔹 ROJO MÁS OSCURO */
    color: #fff;
    transform: translateY(-1px);
}

/* 🔹 ESTILOS PARA INFORMACIÓN DEL CLIENTE SELECCIONADO */
.cliente-info {
    background-color: #f8f9fa;
    border: 1px solid var(--tone-1); /* 🔹 BORDE TONO CLARO */
    border-radius: 6px;
    padding: 10px 15px;
    margin-top: 8px;
}

.cliente-info small {
    font-size: 0.85rem;
    color: #495057;
}

/* 🔹 ESTILO PARA MODAL CONTENT */
.modal-clientes .modal-content {
    border-radius: 10px;
    border: none;
    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
}

/* 🔹 ESTILO PARA MODAL FOOTER */
.modal-clientes .modal-footer {
    border-top: 1px solid #dee2e6;
    padding: 15px 20px;
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

        /* -------------------- CONTENEDOR PRINCIPAL -------------------- */
        .section-container {
            width: 60%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* -------------------- SUBSECCIONES GENERALES -------------------- */
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

        /* 🔹 Filas con dos columnas */
        .two-columns {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 60px;
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

        /* 🔹 Form controls */
        .form-control {
            width: 250px;
            text-align: left;
        }

        .form-select {
            width: 250px;
        }

        /* -------------------- BOTONES INFERIORES -------------------- */
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

                <!-- SECCIÓN SUPERIOR CON TÍTULO Y BOTONES - Mismo diseño que otras páginas -->
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
                    </div>
                </div>

                <!-- -------------------- CONTENIDO PRINCIPAL -------------------- -->
                <div class="section-container">

                    <!-- 🔹 FILA 1 - SOLO ID Venta -->
                    <div class="subsection">
                        <div class="two-columns">
                            <div class="field-block">
                                <h3>ID Venta</h3>
                                <asp:TextBox ID="txtIDVenta" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <!-- Este div se deja vacío para mantener la estructura de dos columnas -->
                            <div class="field-block">
                                <!-- Espacio vacío -->
                            </div>
                        </div>
                    </div>

<!-- 🔹 FILA 2 - ID Cliente (MODIFICADA) -->
<div class="subsection">
    <div class="two-columns">
        <div class="field-block">
            <h3>Cliente (*)</h3>
            <div class="btn-seleccionar-container">
                <asp:TextBox ID="txtIDCliente" runat="server" CssClass="form-control" ReadOnly="true" 
    placeholder="ID del cliente seleccionado"></asp:TextBox>
                <asp:LinkButton 
                    ID="btnSeleccionarCliente" 
                    runat="server" 
                    CssClass="btn-seleccionar-cliente"
                    OnClick="btnSeleccionarCliente_Click"
                    Text="Seleccionar Cliente" />
            </div>
            <!-- 🔹 MOSTRAR INFORMACIÓN DEL CLIENTE SELECCIONADO -->
            <asp:Panel ID="pnlInfoCliente" runat="server" CssClass="cliente-info" Visible="false">
                <small class="text-muted">
                    <strong>Cliente seleccionado:</strong><br />
                    <span id="lblNombreCliente" runat="server"></span><br />
                    <span id="lblDNICliente" runat="server"></span> | 
                    <span id="lblTelefonoCliente" runat="server"></span> | 
                    <span id="lblTipoCliente" runat="server"></span>
                </small>
            </asp:Panel>
        </div>
        <!-- Espacio vacío para mantener estructura -->
        <div class="field-block">
            <!-- Espacio vacío -->
        </div>
    </div>
</div>
                    <!-- 🔹 FILA 3 - ID Empleado -->
<div class="subsection">
    <div class="two-columns">
       <div class="field-block">
    <h3>ID Empleado (*)</h3>
    <asp:TextBox ID="txtIDEmpleado" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
</div>
        <!-- Este div se deja vacío para mantener la estructura de dos columnas -->
        <div class="field-block">
            <!-- Espacio vacío -->
        </div>
    </div>
</div>



                    <!-- 🔹 FILA 4 - Fecha y Monto Total -->
                    <div class="subsection">
                        <div class="two-columns">
                            <div class="field-block">
                                <h3>Fecha</h3>
                                <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="field-block">
                                <h3>Monto Total</h3>
                                <asp:TextBox ID="txtMontoTotal" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- 🔹 Tipo de comprobante -->
                    <div class="subsection">
                        <h3 class="label-title">Tipo de Comprobante (*)</h3>
                        <asp:DropDownList ID="ddlTipoComprobante" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccionar tipo" Value=""></asp:ListItem>
                            <asp:ListItem Text="Boleta" Value="Boleta"></asp:ListItem>
                            <asp:ListItem Text="Factura" Value="Factura"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>

                <!-- -------------------- BOTONES INFERIORES -------------------- -->
                <div class="buttons-bottom-container">
                    <asp:LinkButton 
                        ID="btnRegresarVenta" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnRegresarVenta_Click">
                        <i class="fa-solid fa-circle-left"></i> Regresar
                    </asp:LinkButton>

                    <asp:LinkButton 
                        ID="btnRegistrarComprobante" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnRegistrarComprobante_Click">
                        <i class="fa-solid fa-receipt"></i> Registrar Comprobante
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        
<!-- 🔹 MODAL PARA SELECCIONAR CLIENTE (MODIFICADO) -->
<div class="modal fade modal-clientes" id="modalSeleccionarCliente" tabindex="-1" aria-labelledby="modalClienteLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalClienteLabel">
                    <i class="fas fa-users me-2"></i>Seleccionar Cliente
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="false" 
                        CssClass="table table-hover table-striped modal-grid"
                        OnRowCommand="gvClientes_RowCommand" 
                        OnRowDataBound="gvClientes_RowDataBound"
                        EmptyDataText="No se encontraron clientes activos"
                        ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="70px" />
                            <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre Completo" />
                            <asp:BoundField DataField="DNI" HeaderText="DNI" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="TipoCliente" HeaderText="Tipo Cliente" ItemStyle-Width="120px" />
                            <asp:TemplateField HeaderText="Acción" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSeleccionarCliente" runat="server" CssClass="btn-seleccionar-grid"
                                        CommandName="Seleccionar" 
                                        CommandArgument='<%# Eval("Id") %>'
                                        Text="Seleccionar" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center p-3">
                                <i class="fas fa-exclamation-circle fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No se encontraron clientes activos</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancelar-wd" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Cancelar
                </button>
            </div>
        </div>
    </div>
</div>



    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">


       <script type="text/javascript">
           // 🔹 FUNCIÓN PARA SELECCIÓN VISUAL DE FILAS
           function seleccionarFila(fila) {
               // Remover selección de todas las filas
               var todasLasFilas = document.querySelectorAll('#gvClientes tr');
               todasLasFilas.forEach(function (f) {
                   f.classList.remove('selected');
               });

               // Agregar selección a la fila clickeada
               fila.classList.add('selected');

               // También resaltar el botón de la fila seleccionada
               var botones = document.querySelectorAll('.btn-seleccionar-grid');
               botones.forEach(function (btn) {
                   btn.style.backgroundColor = ''; // Resetear todos
               });

               var botonFila = fila.querySelector('.btn-seleccionar-grid');
               if (botonFila) {
                   botonFila.style.backgroundColor = '#8B4A52'; // Rojo más oscuro
               }
           }

           // 🔹 FUNCIÓN PARA LIMPIAR SELECCIÓN AL CERRAR MODAL
           function limpiarSeleccionModal() {
               var todasLasFilas = document.querySelectorAll('#gvClientes tr');
               todasLasFilas.forEach(function (f) {
                   f.classList.remove('selected');
               });

               var botones = document.querySelectorAll('.btn-seleccionar-grid');
               botones.forEach(function (btn) {
                   btn.style.backgroundColor = '';
               });
           }

           // 🔹 INICIALIZAR CUANDO EL MODAL SE CIERRA
           document.addEventListener('DOMContentLoaded', function () {
               var modal = document.getElementById('modalSeleccionarCliente');
               if (modal) {
                   modal.addEventListener('hidden.bs.modal', function () {
                       limpiarSeleccionModal();
                   });
               }
           });

           // 🔹 MEJORAR LA INTERACCIÓN DEL BOTÓN SELECCIONAR
           function mejorarInteraccionSeleccion() {
               var botonesSeleccionar = document.querySelectorAll('.btn-seleccionar-grid');
               botonesSeleccionar.forEach(function (btn) {
                   btn.addEventListener('click', function (e) {
                       // Resaltar la fila padre cuando se hace clic en el botón
                       var fila = this.closest('tr');
                       seleccionarFila(fila);
                   });
               });
           }

           // 🔹 EJECUTAR CUANDO EL MODAL SE MUESTRE
           function inicializarModalClientes() {
               setTimeout(function () {
                   mejorarInteraccionSeleccion();
               }, 500);
           }
       </script>


</asp:Content>