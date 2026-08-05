<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarProveedor.aspx.cs" Inherits="WearDropWA.RegistrarProveedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    Registrar Proveedor

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <style>
        /* ===== Tonos verdes del nuevo tema ===== */
        .theme-proveedores {
            --tone-1: #C6D8C4; /* verde claro */
            --tone-2: #9DBD9B; /* verde medio */
            --tone-3: #7FA07E; /* verde oscuro */
        }

        /* ===== Cabecera con bloques de color ===== */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
            width: 60%;
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

        .theme-proveedores .bar-1 { background: var(--tone-1); }
        .theme-proveedores .bar-2 { background: var(--tone-2); }

        .top-accent {
            height: 4px;
            background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
            margin-top: 10px;
            border-radius: 4px;
        }

        /* ===== Estructura general ===== */
        .section-container {
            width: 60%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
        }

        .two-columns {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 60px;
            width: 100%;
        }

        .one-column {
            display: flex;
            flex-direction: column;
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

        .form-control {
            width: 250px;
            text-align: left;
        }

        /* ===== Botones generales (idénticos a la otra página) ===== */
        .btn-wd {
            background: var(--tone-3);
            color: #fff;
            border: none;
            padding: 10px 25px;
            border-radius: 12px;
            cursor: pointer;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
        }
        .btn-wd:hover {
            filter: brightness(.95);
        }
        .btn-wd i { margin-right: 6px; }

        /* ===== Contenedor inferior ===== */
        .buttons-bottom-container {
            width: 60%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }

    </style>

<!-- -------------------- ENCABEZADO -------------------- -->
<div class="theme-proveedores">
        <div class="top-accent"></div>

        <!-- ===== CABECERA ===== -->
        <div class="header-title">
            <div class="title-section">
                <h2 id="lblTitulo" runat="server">Registrar Proveedor</h2>
            </div>
            <div class="color-bar bar-1"></div>
            <div class="color-bar bar-2"></div>
        </div>

        <!-- ===== CONTENIDO ===== -->
        <div class="section-container">

            <!-- 🔹 FILA 1 -->
            <div class="subsection">
                <div class="two-columns">
                    <div class="field-block">
                        <h3>ID</h3>
                        <asp:TextBox ID="txtIDProveedor" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="field-block">
                        <h3>Nombre (*)</h3>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- 🔹 FILA 2 -->
            <div class="subsection">
                <div class="two-columns">
                    <div class="field-block">
                        <h3>Dirección (*)</h3>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="field-block">
                        <h3>RUC (*)</h3>
                        <asp:TextBox ID="txtRUC" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- 🔹 FILA 3 -->
            <div class="subsection">
                <div class="one-column">
                    <div class="field-block">
                        <h3>Teléfono (*)</h3>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- 🔹 CONDICIONES DE PAGO -->
            <div class="subsection">
                <div class="two-columns">
                    <div class="field-block">
                        <h3>Condiciones de pago:</h3>
                    </div>
                    <div class="field-block" style="display:flex; align-items:center; justify-content:flex-end;">
                        <asp:Button 
                            ID="btnAñadirCondiciones" 
                            runat="server"
                            Text="Añadir condiciones de pago"
                            CssClass="btn-wd shadow-sm"
                            OnClick="btnAñadirCondiciones_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== BOTONES INFERIORES ===== -->
        <div class="buttons-bottom-container">
            <asp:LinkButton 
                ID="btnRegresar" 
                runat="server" 
                CssClass="btn-wd rounded shadow-sm"
                OnClick="btnRegresar_Click">
                <i class="fa-solid fa-circle-left"></i> Regresar
            </asp:LinkButton>

            <asp:Button 
                ID="btnRegistrarProveedor" 
                runat="server" 
                Text="Registrar"
                CssClass="btn-wd rounded shadow-sm"
                OnClick="btnRegistrarProveedor_Click" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
