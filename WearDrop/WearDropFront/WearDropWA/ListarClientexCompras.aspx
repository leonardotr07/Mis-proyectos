<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarClientexCompras.aspx.cs" Inherits="WearDropWA.ListarClientexCompras" %>
<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Compras Realizadas
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ===== Header con barras (ROJO) ===== */
        .header-title{
            display:flex;align-items:stretch;height:60px;
            box-shadow:0 2px 4px rgba(0,0,0,.1);
            margin-top:14px;border-radius:10px;overflow:hidden
        }
        .title-section{
            background:#fff;padding:0 25px;display:flex;align-items:center;flex:0 0 280px
        }
        .title-section h2{
            margin:0;font-size:20px;font-weight:600;color:#333;white-space:nowrap
        }
        .color-bar{height:100%}
        .bar-1{background:#E4CFCF;flex:1.5}   /* rojo claro */
        .bar-2{background:#B98F8F;flex:1.5}   /* rojo medio */

        /* ===== Filtros (inputs blancos con borde suave) ===== */
        .form-label{
            font-size:14px;color:#333;margin-bottom:6px;display:block
        }
        .form-control{
            width:100%;background:#fff;border:1px solid #E0E0E0;border-radius:10px;
            padding:10px 14px;font-size:15px
        }

        /* ===== Grilla ===== */
        .custom-grid{border-collapse:collapse;width:100%}
        .custom-grid th{
            background:#B98F8F !important;  /* cabecera rojo medio */
            color:#333;font-weight:500;padding:15px 20px;text-align:left;border:none
        }
        .custom-grid td{
            padding:12px 20px;border-bottom:1px solid #E8E8E8
        }
        .custom-grid tr:nth-child(even){background:#F5F5F5}
        .custom-grid tr:hover{background:#F8ECEC} /* hover rojizo claro */
        .action-btns i{font-size:1.05em}
        .btn-sm{padding:4px 8px !important;margin-right:6px}

        /* ===== Botones superiores ===== */
        .btn-solid{
            background:#A67B7B;color:#fff;border:none;padding:8px 18px;border-radius:10px;
            cursor:pointer;display:inline-block;transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08);text-decoration:none!important
        }
        .btn-solid:hover{filter:brightness(.95)}
        .btn-ghost{
            background:#F3EAEA;color:#3b2f2f;border:1px solid #D8C1C1;padding:8px 18px;
            border-radius:10px;text-decoration:none!important
        }
        .btn-ghost:hover{background:#EBDDDD}
        .no-underline,.no-underline:hover,.no-underline:focus{text-decoration:none!important}
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">

        <!-- Encabezado + botones -->
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section"><h2>Compras Realizadas</h2></div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
                <div class="col text-end p-3">
                    <asp:LinkButton ID="lkRegresar" runat="server"
                        CssClass="btn-ghost no-underline me-2" OnClick="lkRegresar_Click">
                        Regresar
                    </asp:LinkButton>
                    <asp:LinkButton ID="lkFiltrar" runat="server"
                        CssClass="btn-solid no-underline" OnClick="lkFiltrar_Click">
                        Filtrar
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- Filtros rápidos -->
        <div class="container row mt-3">
            <div class="col-md-3">
                <label class="form-label">ID</label>
                <asp:TextBox ID="txtFiltroId" runat="server"
                    CssClass="form-control" placeholder="X" />
            </div>
            <div class="col-md-9">
                <label class="form-label">Nombre</label>
                <asp:TextBox ID="txtFiltroNombre" runat="server"
                    CssClass="form-control" placeholder="Placeholder text" />
            </div>
        </div>

        <!-- Grilla -->
        <div class="container row mt-3">
            <asp:GridView ID="gvCompras" runat="server"
                CssClass="table table-hover table-striped custom-grid"
                AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="IdCompra" />
                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField HeaderText="Monto" DataField="Monto" DataFormatString="{0:C}" />
                    <asp:BoundField HeaderText="Comprobante" DataField="Comprobante" />
                    <asp:BoundField HeaderText="Empleado" DataField="Empleado" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnVisualizar" runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CommandArgument='<%# Eval("IdCompra") %>'
                                    OnClick="btnVisualizar_Click" ToolTip="Ver">
                                    <i class="fa fa-eye"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ctScripts" ContentPlaceHolderID="ScriptsContent" runat="server" />
