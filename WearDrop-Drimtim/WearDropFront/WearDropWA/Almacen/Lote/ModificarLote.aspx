<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ModificarLote.aspx.cs" Inherits="WearDropWA.ModificarLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Lote
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ------- Layout Base ------- */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
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
            background-color: #C5D9C0;
            flex: 1.5;
        }

        .bar-2 {
            background-color: #95B88F;
            flex: 1.5;
        }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            border-radius: 4px;
            background: linear-gradient(90deg, #C5D9C0, #95B88F, #73866D);
        }

        /* ------- Info del Almacén (estilo de MostrarAlmacen) ------- */
        .info-section {
            margin-bottom: 20px;
        }

        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }

        .info-input {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            color: #333;
            background-color: #f8f9fa;
            cursor: default;
        }

        .info-input:focus {
            outline: none;
            border-color: #95B88F;
            background-color: #fff;
        }

        /* ------- Form Controls ------- */
        .form-control {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #95B88F;
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
            outline: none;
        }

        .form-control::placeholder {
            color: #999;
        }

        .form-control-desc {
            resize: vertical;
            min-height: 100px;
            max-height: 250px;
        }

        /* ------- Botones ------- */
        a, a:visited, a:hover, a:active {
            text-decoration: none !important;
            color: inherit;
        }

        .btn-custom {
            background-color: #73866D;
            color: #FFFFFF;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 500;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none;
            display: inline-block;
        }

        .btn-custom:hover {
            filter: brightness(.95);
            color: #FFFFFF;
        }

        .btn-custom:active {
            transform: translateY(1px);
        }

        .btn-secondary-custom {
            background-color: #FFFFFF;
            color: #333;
            border: 2px solid #ddd;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary-custom:hover {
            background-color: #f8f9fa;
            border-color: #95B88F;
            color: #73866D;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary-custom:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .button-group {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .required {
            color: #dc3545;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="top-accent"></div>

        <!-- Header con título -->
        <div class="row">
            <div class="col-md-6 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2>Modificar Lote</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Información del Almacén (como en MostrarAlmacen) -->
        <div class="row mb-2 mt-3">
            <div class="col-md-2">
                <div class="info-section">
                    <label class="info-label">ID Almacén</label>
                    <asp:TextBox ID="txtIdAlmacen" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-5">
                <div class="info-section">
                    <label class="info-label">Nombre Almacén</label>
                    <asp:TextBox ID="txtNombreAlmacen" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-5">
                <div class="info-section">
                    <label class="info-label">Ubicación</label>
                    <asp:TextBox ID="txtUbicacion" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- ID del Lote y Descripción en la misma fila -->
        <div class="row mb-3">
            <div class="col-md-2">
                <div class="info-section">
                    <label class="info-label">ID Lote</label>
                    <asp:TextBox ID="txtIdLote" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-10">
                <div class="info-section">
                    <label class="info-label">Descripción del Lote <span class="required">(*)</span></label>
                    <asp:TextBox ID="txtDescripcionLote" runat="server"
                        CssClass="form-control form-control-desc"
                        TextMode="MultiLine"
                        Rows="4"
                        placeholder="Ingrese la descripción del lote"
                        MaxLength="500">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                        ControlToValidate="txtDescripcionLote"
                        ErrorMessage="La descripción es obligatoria"
                        CssClass="text-danger"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
        </div>


        <!-- Botones principales -->
        <div class="row button-group">
            <div class="col-md-6">
                <asp:LinkButton ID="lkCancelar" runat="server"
                    CssClass="btn-secondary-custom"
                    OnClick="lkCancelar_Click"
                    CausesValidation="false"
                    Text="Cancelar">
                </asp:LinkButton>
            </div>
            <div class="col-md-6 text-end">
                <asp:LinkButton ID="lkGuardar" runat="server"
                    CssClass="btn-custom"
                    OnClick="lkGuardar_Click"
                    Text="Guardar Cambios">
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
