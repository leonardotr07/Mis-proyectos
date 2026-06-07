
<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarProveedores.aspx.cs" Inherits="WearDropWA.GestionarProveedores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Proveedores
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* ====== Layout base ====== */
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

        .color-bar { height: 100%; }
        .bar-1 { flex: 1.5; }
        .bar-2 { flex: 1.5; }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            border-radius: 4px;
        }

        /* ====== Grid ====== */
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }
        .custom-grid th {
            color: #333;
            font-weight: 500;
            padding: 15px 20px;
            text-align: center;
            border: none;
            background: var(--tone-2);
        }
        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
            text-align: center;
        }
        .custom-grid tr:nth-child(even) { background: #F5F5F5; }
        .custom-grid tr:hover { background: #E5F8E5; }

        /* ===== Botones personalizados ===== */
        .btn-wd {
            background: var(--tone-3);
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
        }
        .btn-wd:hover { filter: brightness(.95); }
        .btn-wd:active { transform: translateY(1px); }

        /* ===== Tonos verdes ===== */
        .theme-proveedores {
            --tone-1: #C6D8C4; /* verde claro */
            --tone-2: #9DBD9B; /* verde medio */
            --tone-3: #7FA07E; /* verde más oscuro */
        }
        .theme-scope .bar-1 { background: var(--tone-1); }
        .theme-scope .bar-2 { background: var(--tone-2); }
        .theme-scope .custom-grid th { background: var(--tone-2) !important; color: #333; }
        .theme-scope .btn-wd { background: var(--tone-3); color: #fff; }
        .theme-scope .btn-wd:hover { filter: brightness(.95); }
        .theme-scope .top-accent { background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3)); }

        /* ===== Botones de acción ===== */
        .action-btns i { font-size: 1.1em; }
        .btn-sm { padding: 4px 8px !important; margin-right: 4px; }
    </style>

<!-- -------------------- SECCIÓN SUPERIOR -------------------- -->
 <div class="theme-proveedores theme-scope">
        <div class="container">
            <div class="top-accent"></div>

            <!-- ====== Cabecera ====== -->
            <div class="container row">
                <div class="row align-items-center">
                    <div class="col-md-6 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <h2>Gestionar Proveedores</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                    <div class="col text-end p-3">
                        <asp:LinkButton ID="btnRegistrarProveedor" CssClass="btn-wd" runat="server" Text="Registrar" OnClick="btnRegistrarProveedor_Click" />
                        &nbsp;
                        <asp:LinkButton ID="btnFiltrarProveedores" CssClass="btn-wd" runat="server" Text="Filtrar" />
                    </div>
                </div>
            </div>

            <!-- ====== Tabla ====== -->
            <div class="container row mt-3">
                <asp:GridView 
                    ID="dgvProveedores"
                    runat="server"
                    AutoGenerateColumns="false"
                    AllowPaging="true"
                    PageSize="8"
                    CssClass="table table-hover table-striped custom-grid"
                    GridLines="None"
                    HeaderStyle-CssClass="grid-header"
                    PagerStyle-CssClass="custom-pager"
                    OnPageIndexChanging="dgvProveedores_PageIndexChanging"
                    OnRowDataBound="dgvProveedores_RowDataBound"
                    >
                    <Columns>
                        <asp:BoundField HeaderText="ID" />
                        <asp:BoundField  HeaderText="Nombre" />
                        <asp:BoundField  HeaderText="Teléfono" />
                        <asp:BoundField HeaderText="Dirección" />
                        <asp:BoundField  HeaderText="RUC" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <div class="action-btns">
                                    <asp:LinkButton 
                                        ID="btnModificarProveedor"
                                        runat="server"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        CommandArgument='<%# Eval("idProveedor") %>'
                                        OnClick="btnModificarProveedor_Click"
                                        ToolTip="Editar">
                                        <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton 
                                        ID="btnEliminarProveedor"
                                        runat="server"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        CommandArgument='<%# Eval("idProveedor") %>'
                                        OnClick="btnEliminarProveedor_Click"
                                        ToolTip="Eliminar">
                                        <i class="fa fa-trash"></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton 
                                        ID="btnVerProveedor"
                                        runat="server"
                                        CssClass="btn btn-sm btn-outline-success"
                                        CommandArgument='<%# Eval("idProveedor") %>'
                                        OnClick="btnVerProveedor_Click"
                                        ToolTip="Ver">
                                        <i class="fa fa-eye"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server" />
