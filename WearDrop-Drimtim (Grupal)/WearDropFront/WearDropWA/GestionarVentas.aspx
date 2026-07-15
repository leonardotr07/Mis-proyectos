<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarVentas.aspx.cs" Inherits="WearDropWA.GestionarVentas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Ventas
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

        /* -------------------- PAGINADOR -------------------- */
        .custom-pager {
            display: flex !important;
            justify-content: center;
            align-items: center;
            gap: 10px;
            border: none !important;
            background: none !important;
            margin-top: 25px;
            margin-bottom: 40px;
        }

        .custom-pager a,
        .custom-pager span {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border: 1px solid #ccc;
            color: #000;
            background-color: #fff;
            text-decoration: none;
            transition: all 0.2s ease-in-out;
        }

        .custom-pager a:hover {
            background-color: #f1f1f1;
            border-color: var(--tone-3);
        }

        .custom-pager span {
            background-color: var(--tone-3);
            color: #fff;
            border-color: var(--tone-3);
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
                                    <h2>Gestionar Ventas</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:LinkButton
                                ID="btnIrARegistrarVenta"
                                runat="server"
                                CssClass="btn-wd"
                                OnClick="btnIrARegistrarVenta_Click"
                                Text="Registrar Venta" />
                            &nbsp;
                            <asp:LinkButton
                                ID="btnFiltrarVentas"
                                runat="server"
                                CssClass="btn-wd"
                                Text="Filtrar" />
                        </div>
                    </div>
                </div>

                <!-- GRILLA DE VENTAS -->
                <div class="container row mt-3">
                    <asp:GridView 
                        ID="dgvVentas"
                        runat="server"
                        AutoGenerateColumns="false"
                        AllowPaging="true"
                        PageSize="8"
                        CssClass="custom-grid"
                        PagerStyle-CssClass="custom-pager"
                        OnPageIndexChanging="dgvVentas_PageIndexChanging">

                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" />
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Monto"
                                HeaderText="Monto" 
                                DataFormatString="{0:N2}" 
                                HtmlEncode="false"/>
                            <asp:BoundField DataField="Comprobante" HeaderText="Comprobante" />
                            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                        <asp:LinkButton
                                            ID="btnModificarVenta"
                                            runat="server"
                                            CssClass="btn btn-sm btn-outline-primary"
                                            CommandArgument='<%# Eval("ID") %>'
                                            OnClick="btnModificar_Click">
                                            <i class="fa-solid fa-pen"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
    ID="btnEliminarVenta"
    runat="server"
    CssClass="btn btn-sm btn-outline-danger"
    CommandArgument='<%# Eval("ID") %>'
    OnClick="btnEliminar_Click"
    OnClientClick="return confirm('¿Está seguro de eliminar esta venta?');">
    <i class="fa-solid fa-trash"></i>
</asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnVerVenta"
                                            runat="server"
                                            CommandArgument='<%# Eval("ID") %>'
                                            CssClass="btn btn-sm btn-outline-success"
                                            OnClick="btnVerVenta_Click">
                                            <i class="fa-solid fa-eye"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">

    // En el ScriptsContent de GestionarVentas.aspx
<script type="text/javascript">
    function confirmEliminarVenta(boton, idVenta, cliente, monto) {
        var mensaje = `¿Está seguro de eliminar la venta?\n\n` +
            `ID: ${idVenta}\n` +
            `Cliente: ${cliente}\n` +
            `Monto: S/ ${parseFloat(monto).toFixed(2)}\n\n` +
            `Esta acción no se puede deshacer.`;

        // Efecto visual en el botón
        boton.classList.add('btn-danger');
        boton.classList.remove('btn-outline-danger');

        return confirm(mensaje);
    }

    // Mejorar interacción visual
    function mejorarInteraccionBotones() {
        const botonesEliminar = document.querySelectorAll('[id*="btnEliminarVenta"]');

        botonesEliminar.forEach(boton => {
            boton.addEventListener('mouseenter', function () {
                if (!this.classList.contains('btn-danger')) {
                    this.classList.add('btn-danger');
                    this.classList.remove('btn-outline-danger');
                }
            });

            boton.addEventListener('mouseleave', function () {
                if (!this.classList.contains('active')) {
                    this.classList.remove('btn-danger');
                    this.classList.add('btn-outline-danger');
                }
            });
        });
    }

    // Inicializar después de carga y postback
    document.addEventListener('DOMContentLoaded', mejorarInteraccionBotones);

    if (typeof (Sys) !== 'undefined') {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setTimeout(mejorarInteraccionBotones, 100);
        });
    }
</script>


</asp:Content>