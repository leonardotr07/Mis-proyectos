<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarVentaFactura.aspx.cs" Inherits="WearDropWA.RegistrarVentaFactura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <span id="tituloPagina" runat="server">Registrar Factura</span>
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

        /* -------------------- ESTILOS ESPECÍFICOS PARA FACTURA -------------------- */
        .form-group { 
            margin-bottom: 1.25rem; 
        }

        .subsection h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #808080;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .igv-row {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .igv-row label {
            margin-bottom: 0;
            font-weight: 500;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .summary-row strong {
            font-size: 1.1rem;
            color: #333;
        }

        /* Ajustes para campos específicos */
        .igv-row .form-control {
            width: 120px !important;
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
                                    <h2 id="lblTitulo" runat="server">Registrar Factura</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- -------------------- CONTENIDO PRINCIPAL -------------------- -->
                <div class="section-container">

                    <!-- 🔹 PANEL DE FACTURA -->
                    <div class="subsection">
                        <h4>Datos de Factura</h4>
                        <div class="form-group">
    <label class="label-title">Registro Único de Contribuyentes (RUC) (*)</label>
    <asp:TextBox ID="txtRUC" runat="server" CssClass="form-control" MaxLength="11" 
        placeholder="Ingrese 11 dígitos"></asp:TextBox>
</div>

<div class="form-group">
    <label class="label-title">Razón Social (*)</label>
    <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control" 
        placeholder="Ingrese la razón social de la empresa"></asp:TextBox>
</div>

<div class="form-group">
    <label class="label-title">Método de Pago (*)</label>
    <asp:DropDownList ID="ddlMetodoPago" runat="server" CssClass="form-select">
        <asp:ListItem Text="Seleccionar método" Value=""></asp:ListItem>
        <asp:ListItem Text="Efectivo" Value="Efectivo"></asp:ListItem>
        <asp:ListItem Text="Tarjeta" Value="Tarjeta"></asp:ListItem>
        <asp:ListItem Text="Transferencia" Value="Transferencia"></asp:ListItem>
    </asp:DropDownList>
</div>

<div class="form-group">
    <label class="label-title">Dirección</label>
    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" 
        placeholder="Ingrese la dirección"></asp:TextBox>
</div>

<div class="form-group">
    <label class="label-title">Nombres y Apellidos (Contacto)</label>
    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" 
        placeholder="Nombres y apellidos del contacto"></asp:TextBox>
</div>

                        <div class="form-group">
                            <label class="label-title">Nombres y Apellidos</label>
                            <asp:TextBox ID="txtNombresApellidos" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group igv-row">
                            <label class="label-title">IGV (%):</label>
                            <asp:TextBox ID="txtIGV" runat="server" CssClass="form-control" Text="18" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- 🔹 BLOQUE DE RESUMEN -->
                    <div class="subsection">
                        <h4>Resumen</h4>
                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <strong>S/ <asp:Label ID="lblSubtotal" runat="server" Text="0.00"></asp:Label></strong>
                        </div>
                        <div class="summary-row">
                            <span>IGV (18%):</span>
                            <strong>S/ <asp:Label ID="lblIGV" runat="server" Text="0.00"></asp:Label></strong>
                        </div>
                        <div class="summary-row" style="border-top: 1px solid #dee2e6; padding-top: 10px; margin-top: 10px;">
                            <span>Total:</span>
                            <strong style="font-size: 1.3rem; color: var(--tone-3);">S/ <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></strong>
                        </div>
                    </div>

                </div>

                <!-- -------------------- BOTONES INFERIORES -------------------- -->
                <div class="buttons-bottom-container">
                    <asp:LinkButton 
                        ID="btnRegresar" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnRegresar_Click">
                        <i class="fa-solid fa-circle-left"></i> Regresar
                    </asp:LinkButton>

                    <asp:LinkButton 
                        ID="btnRegistrarFactura" 
                        runat="server" 
                        CssClass="btn-wd"
                        OnClick="btnRegistrarVenta_Click">
                        <i class="fa-solid fa-check"></i> Registrar Venta
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>