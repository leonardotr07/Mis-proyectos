<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="VerCuenta.aspx.cs" Inherits="WearDropWA.VerCuenta" %>
<asp:Content ID="t" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Cuenta
</asp:Content>

<asp:Content ID="h" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ======= Header con barras azules ======= */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            border-radius: 10px;
            overflow: hidden;
            margin-top: 6px;
        }
        .title-section {
            background: #fff;
            padding: 0 24px;
            display: flex;
            align-items: center;
            flex: 0 0 340px;
        }
        .title-section h2 {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
            color: #333;
        }
        .color-bar { height: 100%; }
        .bar-1 { background: #CFD9E4; flex: 1.5; }
        .bar-2 { background: #8FA6B9; flex: 1.5; }

        /* ======= Campos ======= */
        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 6px;
            display: block;
        }
        .form-control, .form-select {
            width: 100%;
            background: #fff;
            border: 1px solid #E0E0E0;
            border-radius: 10px;
            padding: 12px 14px;
            font-size: 15px;
        }
        .input-compact { max-width: 260px; }
        .row-gap { row-gap: 22px; }

        /* ======= Botones ======= */
        .btn-main {
            background: #6F889E;
            color: #fff;
            border: none;
            padding: 12px 28px;
            border-radius: 14px;
            transition: .15s;
        }
        .btn-main:hover { background: #607A91; }
        .btn-ghost {
            background: #E8EEF3;
            color: #3A495A;
            border: 1px solid #C0CEDA;
            padding: 12px 28px;
            border-radius: 14px;
        }
        .btn-ghost:hover { background: #DFE8EF; }
        .no-underline,
        .no-underline:hover,
        .no-underline:focus {
            text-decoration: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="m" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Encabezado -->
        <div class="row align-items-center mb-4">
            <div class="col-lg-10 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2>Registrar Cuenta</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Formulario sin card -->
        <div class="row row-gap col-lg-10">
            <!-- Fila 1 -->
            <div class="col-md-3">
                <asp:Label ID="lblID" runat="server" Text="ID" CssClass="form-label" />
                <asp:TextBox ID="txtID" runat="server" CssClass="form-control input-compact" ReadOnly="true" placeholder="X" />
            </div>
            <div class="col-md-9">
                <asp:Label ID="lblEmpleado" runat="server" Text="Empleado" CssClass="form-label" />
                <asp:TextBox ID="txtEmpleado" runat="server" CssClass="form-control" placeholder="Ingresar empleado" />
            </div>

            <!-- Fila 2 -->
            <div class="col-md-6">
                <asp:Label ID="lblUser" runat="server" Text="Username" CssClass="form-label" />
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
            </div>
            <div class="col-md-6">
                <asp:Label ID="lblPassword" runat="server" Text="Contraseña" CssClass="form-label" />
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="*********" />
            </div>

            <!-- Fila 3 -->
            <div class="col-md-6">
                <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="form-label" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="correo@dominio.com" />
            </div>
            <div class="col-md-6">
                <asp:Label ID="lblTipoCuenta" runat="server" Text="Tipo de cuenta" CssClass="form-label" />
                <asp:TextBox ID="txtTipoCuenta" runat="server" CssClass="form-control" placeholder="Admin, Empleado, etc." />
            </div>

            <!-- Botones -->
            <div class="row mt-4 col-lg-10">
                <div class="col-12 d-flex justify-content-between">
                    <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-ghost no-underline" OnClick="btnCancelar_Click">
                        Cancelar
                    </asp:LinkButton>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="s" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
