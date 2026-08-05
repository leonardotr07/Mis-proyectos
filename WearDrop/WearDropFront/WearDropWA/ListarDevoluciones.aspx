<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master"
    AutoEventWireup="true" CodeBehind="ListarDevoluciones.aspx.cs"
    Inherits="WearDropWA.ListarDevoluciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Listar Devoluciones
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .title-section {
            background-color: #FFFFFF;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 250px;
        }
        .title-section h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 500;
            color: #333;
            white-space: nowrap;
        }
        .color-bar { height: 100%; }
        .bar-1 { background-color: #DFBCBC; flex: 1.5; }
        .bar-2 { background-color: #C5A0A0; flex: 1.5; }

        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }
        .custom-grid th {
            background-color: #DFBCBC !important;
            color: #333333;
            font-weight: 500;
            padding: 15px 20px;
            text-align: left;
            border: none;
        }
        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
        }
        .custom-grid tr:nth-child(even) { background-color: #F5F5F5; }
        .custom-grid tr:hover { background-color: #E8F4E5; }

        a, a:visited, a:hover, a:active, .btn-wd {
            text-decoration:none !important;
            color:inherit;
        }

        .btn-wd {
            background:var(--btn); color:#fff; border:none; padding:8px 18px;
            border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        .btn-outline-success i { color: #28a745; }
        .btn-outline-primary i { color: #007bff; }
        .btn-outline-danger i { color: #dc3545; }

        .action-btns i { font-size:1.1em; }
        .btn-sm { padding:4px 8px !important; margin-right:4px; }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
        }
        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        .modal-body { margin-bottom: 25px; }
        .info-field { margin-bottom: 15px; }
        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .info-value {
            background-color: #f0f0f0;
            padding: 10px;
            border-radius: 4px;
            color: #333;
        }
        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .btn-eliminar {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-eliminar:hover { background-color: #c82333; }

        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent {
            background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3));
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container theme-scope">
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Gestionar Devoluciones</h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
                <div class="col text-end p-3">
                    <asp:LinkButton ID="lkRegistrar" CssClass="btn"
                        Style="background-color:#C5A0A0; color:#FFFFFF; border-color:#73866D; margin-right:20px"
                        runat="server" OnClick="lkRegistrar_Click"
                        Text="Registrar Devolución" />
                </div>
            </div>
        </div>

        <div class="container row mt-4">
            <asp:GridView ID="gvDevoluciones" runat="server"
                AutoGenerateColumns="false" ShowHeaderWhenEmpty="True"
                CssClass="table table-hover table-striped custom-grid"
                HeaderStyle-Font-Bold="false"
                HeaderStyle-Height="40px"
                GridLines="None">
                <Columns>
                   <asp:BoundField HeaderText="ID" DataField="Id" />
                <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />

                
                <asp:BoundField HeaderText="Prenda" DataField="NombrePrenda" />
              <asp:BoundField HeaderText="Proveedor" DataField="NombreProveedor" />

                 <asp:BoundField HeaderText="Talla" DataField="Talla" />
                  <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />
                 <asp:BoundField HeaderText="Monto" DataField="Monto" DataFormatString="{0:C}" />
                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                

                                <asp:LinkButton ID="btnEliminar" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick='<%# "return mostrarModal(" + Eval("Id") + ", \"" + Eval("Descripcion") + "\");" %>'
                                    ToolTip="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="modalEliminar" class="modal-overlay">
        <div class="modal-content">
            <h3 class="modal-title">¿Está seguro de eliminar esta devolución?</h3>
            <div class="modal-body">
                <div class="info-field">
                    <div class="info-label">Descripción:</div>
                    <div class="info-value" id="modalDescripcion"></div>
                </div>
            </div>
            <div class="modal-buttons">
                <asp:Button ID="btnConfirmarEliminar" runat="server"
                    CssClass="btn-eliminar"
                    Text="Eliminar"
                    OnClick="btnConfirmarEliminar_Click" />
                <button type="button" class="btn btn-secondary-custom" onclick="cerrarModal()">Cancelar</button>
            </div>
            <asp:HiddenField ID="hfIdDevolucionEliminar" runat="server" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function mostrarModal(idDevolucion, descripcion) {
            document.getElementById('modalDescripcion').innerText = descripcion;
            document.getElementById('<%= hfIdDevolucionEliminar.ClientID %>').value = idDevolucion;
            document.getElementById('modalEliminar').style.display = 'flex';
            return false;
        }

        function cerrarModal() {
            document.getElementById('modalEliminar').style.display = 'none';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('modalEliminar');
            if (event.target == modal) {
                cerrarModal();
            }
        }
    </script>
</asp:Content>
