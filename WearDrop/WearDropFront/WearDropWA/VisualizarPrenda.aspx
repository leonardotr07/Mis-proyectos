<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="VisualizarPrenda.aspx.cs" Inherits="WearDropWA.VisualizarPrenda" %>

<asp:Content ID="cTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <asp:Literal ID="litTitulo" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .header-title{display:flex;align-items:stretch;height:60px;box-shadow:0 2px 4px rgba(0,0,0,.1);margin-top:14px}
        .title-section{background:#fff;padding:0 25px;display:flex;align-items:center;flex:0 0 280px}
        .title-section h2{margin:0;font-size:20px;font-weight:500;color:#333;white-space:nowrap}
        .color-bar{height:100%}

        .form-label{font-size:14px;color:#333;margin-bottom:8px;display:block}
        .form-control{background:#F5F5F5;border:1px solid #E0E0E0;border-radius:6px;padding:12px 15px;width:100%}
        .form-control[readonly], .form-control:disabled{opacity:.95;color:#555;cursor:default}

        .btn-wd{color:#fff;border:none;padding:12px 26px;border-radius:10px;font-size:18px;cursor:pointer;text-decoration:none !important}
        .btn-wd:hover{text-decoration:none !important}

        .pill-actions{display:flex;gap:40px;margin:24px 0}
        .table-striped > tbody > tr:nth-of-type(odd){--bs-table-accent-bg:#F5F5F5}
        .gv-header{color:#333}

        /* Temas por tipo de prenda */
        .theme-polos .color-bar.bar-1{background:#CFE1CC}
        .theme-polos .color-bar.bar-2{background:#9DBD9B}
        .theme-polos .btn-wd{background:#9DBD9B}
        .theme-polos .btn-wd:hover{background:#8aab89}
        .theme-polos .gv-header{background:#CFE1CC}
        .theme-polos .modal-bar-1{background:#CFE1CC}
        .theme-polos .modal-bar-2{background:#9DBD9B}
        
        .theme-vestidos .color-bar.bar-1{background:#CCD8E1}
        .theme-vestidos .color-bar.bar-2{background:#9FB6C8}
        .theme-vestidos .btn-wd{background:#9FB6C8}
        .theme-vestidos .btn-wd:hover{background:#8da4b5}
        .theme-vestidos .gv-header{background:#CCD8E1}
        .theme-vestidos .modal-bar-1{background:#CCD8E1}
        .theme-vestidos .modal-bar-2{background:#9FB6C8}
        
        .theme-faldas .color-bar.bar-1{background:#E4C3CC}
        .theme-faldas .color-bar.bar-2{background:#C5A0B0}
        .theme-faldas .btn-wd{background:#C5A0B0}
        .theme-faldas .btn-wd:hover{background:#b38f9e}
        .theme-faldas .gv-header{background:#E4C3CC}
        .theme-faldas .modal-bar-1{background:#E4C3CC}
        .theme-faldas .modal-bar-2{background:#C5A0B0}
        
        .theme-gorros .color-bar.bar-1{background:#E4B9BD}
        .theme-gorros .color-bar.bar-2{background:#C99298}
        .theme-gorros .btn-wd{background:#C99298}
        .theme-gorros .btn-wd:hover{background:#b78188}
        .theme-gorros .gv-header{background:#E4B9BD}
        .theme-gorros .modal-bar-1{background:#E4B9BD}
        .theme-gorros .modal-bar-2{background:#C99298}
        
        .theme-pantalones .color-bar.bar-1{background:#D8D1EC}
        .theme-pantalones .color-bar.bar-2{background:#B4A6D6}
        .theme-pantalones .btn-wd{background:#B4A6D6}
        .theme-pantalones .btn-wd:hover{background:#a295c3}
        .theme-pantalones .gv-header{background:#D8D1EC}
        .theme-pantalones .modal-bar-1{background:#D8D1EC}
        .theme-pantalones .modal-bar-2{background:#B4A6D6}
        
        .theme-casacas .color-bar.bar-1{background:#CFE6E1}
        .theme-casacas .color-bar.bar-2{background:#9AC5BE}
        .theme-casacas .btn-wd{background:#9AC5BE}
        .theme-casacas .btn-wd:hover{background:#89b3ac}
        .theme-casacas .gv-header{background:#CFE6E1}
        .theme-casacas .modal-bar-1{background:#CFE6E1}
        .theme-casacas .modal-bar-2{background:#9AC5BE}
        
        .theme-blusas .color-bar.bar-1{background:#F6F1B8}
        .theme-blusas .color-bar.bar-2{background:#EDE28A}
        .theme-blusas .btn-wd{background:#EDE28A}
        .theme-blusas .btn-wd:hover{background:#e3d878}
        .theme-blusas .gv-header{background:#F6F1B8}
        .theme-blusas .modal-bar-1{background:#F6F1B8}
        .theme-blusas .modal-bar-2{background:#EDE28A}
    </style>
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container" id="themeWrap" runat="server">
        <div class="row">
            <div class="col-md-6 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2><asp:Literal ID="litHeader" runat="server"></asp:Literal></h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <div class="row g-4">
                    <div class="col-md-2">
                        <label class="form-label" for="txtId">ID:</label>
                        <asp:TextBox ID="txtId" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label" for="txtNombre">Nombre:</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label" for="ddlTalla">Talla:</label>
                        <asp:DropDownList ID="ddlTalla" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label" for="ddlMaterial">Material:</label>
                        <asp:DropDownList ID="ddlMaterial" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label" for="txtColor">Color:</label>
                        <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label" for="txtStock">Stock:</label>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label" for="txtPU">Precio Unidad:</label>
                        <asp:TextBox ID="txtPU" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label" for="txtPM">Precio Mayor:</label>
                        <asp:TextBox ID="txtPM" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label" for="txtPD">Precio Docena:</label>
                        <asp:TextBox ID="txtPD" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <!-- CAMPOS ESPECÍFICOS POR TIPO DE PRENDA -->
                    <asp:PlaceHolder ID="phCamposEspecificos" runat="server"></asp:PlaceHolder>
                </div>

                <div class="pill-actions">
                    <asp:LinkButton ID="lbVerDescuentos" runat="server" CssClass="btn-wd"
                        OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#form-modal-descuentos">
                        Visualizar Descuentos
                    </asp:LinkButton>

                    <asp:LinkButton ID="lbVerPromociones" runat="server" CssClass="btn-wd"
                        OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#form-modal-promociones">
                        Visualizar Promociones
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: DESCUENTOS -->
    <div class="modal fade" id="form-modal-descuentos" tabindex="-1" aria-labelledby="mdlDescLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header p-0">
                    <div class="w-100">
                        <div class="d-flex align-items-stretch" style="height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1);">
                            <div class="d-flex align-items-center px-4" style="background:#fff; flex:0 0 280px;">
                                <h5 id="mdlDescLabel" class="mb-0">Visualizar Descuentos</h5>
                            </div>
                            <div class="modal-bar-1" style="flex:1.5;"></div>
                            <div class="modal-bar-2" style="flex:1.5;"></div>
                        </div>
                    </div>
                </div>

                <div class="modal-body">
                    <asp:UpdatePanel ID="upDescuentos" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h6 class="fw-semibold text-secondary mb-2">Descuentos por Monto</h6>
                            <asp:GridView ID="gvDescMonto" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped mb-4" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="Id" />
                                    <asp:BoundField HeaderText="Nombre Descuento Monto" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Monto Editable" DataField="Editable" />
                                    <asp:BoundField HeaderText="Monto Máximo" DataField="MontoMax" DataFormatString="{0:C}" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Descuentos por Porcentaje</h6>
                            <asp:GridView ID="gvDescPorc" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped mb-4" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="Id" />
                                    <asp:BoundField HeaderText="Nombre Descuento Porcentaje" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Porcentaje" DataField="Porcentaje" DataFormatString="{0:P2}" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Descuentos por Liquidación</h6>
                            <asp:GridView ID="gvDescLiq" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="Id" />
                                    <asp:BoundField HeaderText="Nombre Descuento Liquidación" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Porcentaje Liquidación" DataField="Porcentaje" DataFormatString="{0:P2}" />
                                    <asp:BoundField HeaderText="Stock Mínimo" DataField="StockMin" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: PROMOCIONES -->
    <div class="modal fade" id="form-modal-promociones" tabindex="-1" aria-labelledby="mdlPromoLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header p-0">
                    <div class="w-100">
                        <div class="d-flex align-items-stretch" style="height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1);">
                            <div class="d-flex align-items-center px-4" style="background:#fff; flex:0 0 280px;">
                                <h5 id="mdlPromoLabel" class="mb-0">Visualizar Promociones</h5>
                            </div>
                            <div class="modal-bar-1" style="flex:1.5;"></div>
                            <div class="modal-bar-2" style="flex:1.5;"></div>
                        </div>
                    </div>
                </div>

                <div class="modal-body">
                    <asp:UpdatePanel ID="upPromos" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h6 class="fw-semibold text-secondary mb-2">Promoción Combo</h6>
                            <asp:GridView ID="gvPromoCombo" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped mb-4" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="Id" />
                                    <asp:BoundField HeaderText="Nombre Promoción Combo" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Cantidad Gratis" DataField="CantGratis" />
                                    <asp:BoundField HeaderText="Cantidad Requerida" DataField="CantReq" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Promoción Conjunto</h6>
                            <asp:GridView ID="gvPromoConjunto" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="Id" />
                                    <asp:BoundField HeaderText="Nombre Promoción Conjunto" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Porcentaje Promoción" DataField="Porcentaje" DataFormatString="{0:P2}" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="cScripts" ContentPlaceHolderID="ScriptsContent" runat="server" />