<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarCondicionesdePago.aspx.cs" Inherits="WearDropWA.RegistrarCondicionesdePago" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    Registrar Condiciones de Pago

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

 <style>
/* ======= Tema de Condiciones de Pago ======= */
.theme-condiciones {
    --tone-1: #C6D8C4; /* verde claro */
    --tone-2: #9DBD9B; /* verde medio */
    --tone-3: #7FA07E; /* verde más oscuro */
}

/* ======= Encabezado ======= */
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
    flex: 0 0 350px;
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

/* ======= Botones superiores ======= */
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

.top-accent {
    height: 4px;
    margin-top: 10px;
    border-radius: 4px;
    background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
}

/* ======= Grid ======= */
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

/* ======= Acciones ======= */
.action-btns i { font-size: 1.1em; }
.btn-sm { padding: 4px 8px !important; margin-right: 4px; }

/* ======= Botón inferior ======= */
.footer-buttons {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    margin-top: 25px;
}
</style>
<!-- ======= SECCIÓN PRINCIPAL ======= -->
<div class="theme-condiciones theme-scope">
    <div class="container">
        <div class="top-accent"></div>

        <!-- ======= Cabecera ======= -->
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2 id="lblTituloPagina" runat="server"
                                >Registrar Condiciones de Pago</h2>
                        </div>
                        <div class="color-bar bar-1" style="background: var(--tone-1);"></div>
                        <div class="color-bar bar-2" style="background: var(--tone-2);"></div>
                    </div>
                </div>
                <div class="col text-end p-3">
                    <asp:LinkButton ID="btnRegistrarCondicion" CssClass="btn-wd" runat="server" Text="Registrar" OnClick="btnRegistrarCondicion_Click" />
                    &nbsp;
                    <asp:LinkButton ID="btnFiltrarCondiciones" CssClass="btn-wd" runat="server" Text="Filtrar" />
                </div>
            </div>
        </div>

        <!-- ======= Tabla ======= -->
        <div class="container row mt-3">
            <asp:GridView 
                ID="dgvCondicionesPago"
                runat="server"
                AutoGenerateColumns="false"
                AllowPaging="true"
                PageSize="8"
                CssClass="table table-hover table-striped custom-grid"
                GridLines="None"
                HeaderStyle-CssClass="grid-header"
                PagerStyle-CssClass="custom-pager"
                OnPageIndexChanging="dgvCondicionesPago_PageIndexChanging"
                OnRowDataBound="dgvCondicionesPago_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="idCondicion" HeaderText="ID" />
                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                    <asp:BoundField DataField="numDias" HeaderText="N.º Días" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton 
                                    ID="btnModificarCondicion"
                                    runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("idCondicion") %>'
                                    OnClick="btnModificarCondicion_Click"
                                    ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton 
                                    ID="btnEliminarCondicion"
                                    runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("idCondicion") %>'
                                    ToolTip="Eliminar"
                                    OnClick="btnEliminarCondicion_Click"
                                    >
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>

                                <asp:LinkButton 
                                    ID="btnVerCondicion"
                                    runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CommandArgument='<%# Eval("idCondicion") %>'
                                    OnClick="btnVerCondicion_Click"
                                    ToolTip="Ver">
                                    <i class="fa fa-eye"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- ======= Botón inferior ======= -->
        <div class="footer-buttons">
            <asp:LinkButton 
                ID="btnRegresar" 
                runat="server" 
                CssClass="btn-wd"
                OnClick="btnRegresar_Click">
                <i class="fa-solid fa-circle-left"></i> Regresar
            </asp:LinkButton>
        </div>
    </div>
</div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
