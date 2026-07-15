<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarPrenda.aspx.cs" Inherits="WearDropWA.RegistrarPrenda" %>

<asp:Content ID="cTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <asp:Literal ID="litTitulo" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
   <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.08);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden
        }

        .title-section {
            background: #fff;
            padding: 0 22px;
            display: flex;
            align-items: center
        }

            .title-section h2 {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
                color: #333
            }

        .color-bar {
            height: 100%
        }

        .bar-1 {
            flex: 1.2
        }

        .bar-2 {
            flex: 1
        }

        .theme-polos .bar-1 {
            background: #CFE1CC
        }

        .theme-polos .bar-2 {
            background: #9DBD9B
        }

        .theme-vestidos .bar-1 {
            background: #CCD8E1
        }

        .theme-vestidos .bar-2 {
            background: #9FB6C8
        }

        .theme-faldas .bar-1 {
            background: #E4C3CC
        }

        .theme-faldas .bar-2 {
            background: #C5A0B0
        }

        .theme-gorros .bar-1 {
            background: #E4B9BD
        }

        .theme-gorros .bar-2 {
            background: #C99298
        }

        .theme-pantalones .bar-1 {
            background: #D8D1EC
        }

        .theme-pantalones .bar-2 {
            background: #B4A6D6
        }

        .theme-casacas .bar-1 {
            background: #CFE6E1
        }

        .theme-casacas .bar-2 {
            background: #9AC5BE
        }

        .theme-blusas .bar-1 {
            background: #F6F1B8
        }

        .theme-blusas .bar-2 {
            background: #EDE28A
        }

        .card-white {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,.06);
            padding: 22px;
            margin: 14px 0
        }

        .card-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 14px
        }

        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
            display: block
        }

        .form-control {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 10px 14px;
            width: 100%
        }

        .form-note {
            color: #9aa1a9;
            font-size: 12px
        }

        .btn {
            color: #fff;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: #73866D
        }

            .btn:hover {
                filter: brightness(.95)
            }

        .btn-outline {
            background: #fff;
            border: 1px solid #d6d8dc;
            color: #333;
            border-radius: 8px;
            padding: 10px 24px
        }

            .btn-outline:hover {
                background: #f6f7f8
            }
            .btn-wd{color:#fff;border:none;padding:12px 26px;border-radius:10px;font-size:18px;cursor:pointer;text-decoration:none !important}
        .btn-wd:hover{text-decoration:none !important}


        .pill-actions{display:flex;gap:40px;margin:24px 0}
        .table-striped > tbody > tr:nth-of-type(odd){--bs-table-accent-bg:#F5F5F5}
        .gv-header{color:#333}
        /* Card de stock más angosta y centrada */
        .stock-card {
            max-width: 700px; /* más angosta */
            margin: 16px auto 20px; /* centrada horizontalmente */
        }

        /* Título igual que los demás pero un poquito marcado */
        .stock-title {
            font-size: 16px; /* similar a "Tipo de Manga" */
            font-weight: 600; /* negrita */
        }

        /* Tabla de stock: mismo estilo pero encabezado marcado */
        .stock-table thead tr th {
            font-size: 14px; /* como resto de labels */
            font-weight: 600; /* negrita */
            color: #333;
        }
        /* Contenedor del banner de stock: centrado y más angosto */
        .alert-wrap {
            max-width: 900px; /* ancho similar a tus cards */
            margin: 10px auto 16px; /* centrado, con separación */
        }

        .stock-alert {
            max-width: 720px;
            width: 100%;
            margin-top: 10px;
            margin-bottom: 16px;
            border-radius: 10px;
            font-size: 14px;
        }
        .theme-polos .btn-wd{background:#9DBD9B}
        .theme-polos .btn-wd:hover{background:#8aab89}
        .theme-polos .gv-header{background:#CFE1CC}
        .theme-polos .modal-bar-1{background:#CFE1CC}
        .theme-polos .modal-bar-2{background:#9DBD9B}

        .theme-vestidos .btn-wd{background:#9FB6C8}
        .theme-vestidos .btn-wd:hover{background:#8da4b5}
        .theme-vestidos .gv-header{background:#CCD8E1}
        .theme-vestidos .modal-bar-1{background:#CCD8E1}
        .theme-vestidos .modal-bar-2{background:#9FB6C8}

        theme-faldas .btn-wd{background:#C5A0B0}
        .theme-faldas .btn-wd:hover{background:#b38f9e}
        .theme-faldas .gv-header{background:#E4C3CC}
        .theme-faldas .modal-bar-1{background:#E4C3CC}
        .theme-faldas .modal-bar-2{background:#C5A0B0}

        .theme-gorros .btn-wd{background:#C99298}
        .theme-gorros .btn-wd:hover{background:#b78188}
        .theme-gorros .gv-header{background:#E4B9BD}
        .theme-gorros .modal-bar-1{background:#E4B9BD}
        .theme-gorros .modal-bar-2{background:#C99298}

        .theme-pantalones .btn-wd{background:#B4A6D6}
        .theme-pantalones .btn-wd:hover{background:#a295c3}
        .theme-pantalones .gv-header{background:#D8D1EC}
        .theme-pantalones .modal-bar-1{background:#D8D1EC}
        .theme-pantalones .modal-bar-2{background:#B4A6D6}

        .theme-casacas .btn-wd{background:#9AC5BE}
        .theme-casacas .btn-wd:hover{background:#89b3ac}
        .theme-casacas .gv-header{background:#CFE6E1}
        .theme-casacas .modal-bar-1{background:#CFE6E1}
        .theme-casacas .modal-bar-2{background:#9AC5BE}

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
            <div class="col-md-8 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2>
                            <asp:Literal ID="litHeader" runat="server"></asp:Literal>
                        </h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- 🔔 Alerta global de stock bajo -->
        <div class="row">
            <div class="col-md-8 p-0 d-flex justify-content-center">
                <asp:Label ID="lblAlertaStock" runat="server"
                           Visible="false"
                           CssClass="alert alert-warning stock-alert"
                           Text="Este producto está en último stock: quedan 0 unidades. Considere reponerlo.">
                </asp:Label>
            </div>
        </div>


           <!-- AVISO GENERAL CAMPOS OBLIGATORIOS -->
<asp:Panel ID="pnlAlertCampos" runat="server" 
           CssClass="alert alert-warning d-flex align-items-center mb-3"
           Visible="false">
    <i class="fa fa-exclamation-triangle me-2"></i>
    <span>Completa todos los campos obligatorios (*) antes de guardar.</span>
</asp:Panel>

<asp:ValidationSummary ID="valSummary" runat="server"
    CssClass="text-danger mb-2"
    HeaderText="Revisa los siguientes campos:"
    DisplayMode="BulletList"
    ValidationGroup="Prenda" />
    

<!-- Datos básicos -->
<div class="card-white">
    <div class="card-title">Datos básicos</div>
    <div class="row g-3">
        <asp:Panel ID="divId" runat="server" CssClass="col-md-2" Visible="false">
            <label class="form-label" for="txtId">ID</label>
            <asp:TextBox ID="txtId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            <div class="form-note">Solo visible en edición</div>
        </asp:Panel>

        <div class="col-md-6">
            <label class="form-label" for="txtNombre">
                Nombre <span id="spanReq" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                placeholder="Nombre de la prenda"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                ControlToValidate="txtNombre"
                ErrorMessage="El nombre es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>

        <!-- (TALLA eliminado) -->

        <div class="col-md-3">
            <label class="form-label" for="ddlMaterial">
                Material <span id="spanReqMaterial" runat="server">(*)</span>
            </label>
            <asp:DropDownList ID="ddlMaterial" runat="server" CssClass="form-control"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvMaterial" runat="server"
                ControlToValidate="ddlMaterial"
                ErrorMessage="Selecciona un material."
                CssClass="text-danger small"
                Display="Dynamic"
                InitialValue=""
                ValidationGroup="Prenda" />
        </div>

        <div class="col-md-3">
            <label class="form-label" for="txtColor">
                Color <span id="spanReqColor" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" placeholder="Ej: Blanco"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvColor" runat="server"
                ControlToValidate="txtColor"
                ErrorMessage="El color es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>

        <div class="col-md-3">
            <label class="form-label" for="txtStock">
                Stock <span id="spanReqStock" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" placeholder="0"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                ControlToValidate="txtStock"
                ErrorMessage="El stock es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>
    </div>
</div>

<!-- Precios -->
<div class="card-white">
    <div class="card-title">Precios</div>
    <div class="row g-3">
        <div class="col-md-3">
            <label class="form-label" for="txtPU">
                Precio Unidad <span id="spanReqPU" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtPU" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPU" runat="server"
                ControlToValidate="txtPU"
                ErrorMessage="El precio unidad es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>
        <div class="col-md-3">
            <label class="form-label" for="txtPM">
                Precio Mayor <span id="spanReqPM" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtPM" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPM" runat="server"
                ControlToValidate="txtPM"
                ErrorMessage="El precio mayor es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>
        <div class="col-md-3">
            <label class="form-label" for="txtPD">
                Precio Docena <span id="spanReqPD" runat="server">(*)</span>
            </label>
            <asp:TextBox ID="txtPD" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPD" runat="server"
                ControlToValidate="txtPD"
                ErrorMessage="El precio por docena es obligatorio."
                CssClass="text-danger small"
                Display="Dynamic"
                ValidationGroup="Prenda" />
        </div>
    </div>
</div>

<!-- Card: Campos específicos por tipo -->
<div class="card-white">
    <div class="card-title">Características específicas</div>

    <!-- PANEL POLO -->
    <asp:Panel ID="pnlPOLO" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoManga">
                    Tipo de Manga <span id="spanReqManga" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoManga" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoManga" runat="server"
                    ControlToValidate="ddlTipoManga"
                    ErrorMessage="Selecciona un tipo de manga."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-4">
                <label class="form-label" for="txtEstampado">Estampado</label>
                <asp:TextBox ID="txtEstampado" runat="server" CssClass="form-control"
                    placeholder="Descripción del estampado (opcional)"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoCuello">
                    Tipo de Cuello <span id="spanReqCuello" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoCuello" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoCuello" runat="server"
                    ControlToValidate="ddlTipoCuello"
                    ErrorMessage="Selecciona un tipo de cuello."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>

    <!-- PANEL BLUSA -->
    <asp:Panel ID="pnlBLUSA" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label" for="ddlTipoBlusa">
                    Tipo de Blusa <span id="spanReqTipoBlusa" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoBlusa" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoBlusa" runat="server"
                    ControlToValidate="ddlTipoBlusa"
                    ErrorMessage="Selecciona un tipo de blusa."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-6">
                <label class="form-label" for="ddlTipoMangaB">
                    Tipo de Manga <span id="spanReqMangaB" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoMangaB" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoMangaB" runat="server"
                    ControlToValidate="ddlTipoMangaB"
                    ErrorMessage="Selecciona un tipo de manga."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>

    <!-- PANEL VESTIDO -->
    <asp:Panel ID="pnlVESTIDO" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoVestido">
                    Tipo de Vestido <span id="spanReqTipoVestido" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoVestido" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoVestido" runat="server"
                    ControlToValidate="ddlTipoVestido"
                    ErrorMessage="Selecciona un tipo de vestido."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>

            <div class="col-md-4">
                <label class="form-label" for="ddlTipoMangaV">
                    Tipo de Manga <span id="spanReqMangaV" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoMangaV" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoMangaV" runat="server"
                    ControlToValidate="ddlTipoMangaV"
                    ErrorMessage="Selecciona un tipo de manga."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>

            <div class="col-md-4">
                <label class="form-label" for="txtLargoVestido">
                    Largo (cm) <span id="spanReqLargoVestido" runat="server">(*)</span>
                </label>
                <asp:TextBox ID="txtLargoVestido" runat="server" CssClass="form-control" placeholder="Ej: 90"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLargoVestido" runat="server"
                    ControlToValidate="txtLargoVestido"
                    ErrorMessage="El largo del vestido es obligatorio."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>


    <!-- PANEL FALDA -->
    <asp:Panel ID="pnlFALDA" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoFalda">
                    Tipo de Falda <span id="spanReqTipoFalda" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoFalda" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoFalda" runat="server"
                    ControlToValidate="ddlTipoFalda"
                    ErrorMessage="Selecciona un tipo de falda."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-4">
                <label class="form-label" for="txtLargoFalda">
                    Largo (cm) <span id="spanReqLargoFalda" runat="server">(*)</span>
                </label>
                <asp:TextBox ID="txtLargoFalda" runat="server" CssClass="form-control" placeholder="Ej: 60"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLargoFalda" runat="server"
                    ControlToValidate="txtLargoFalda"
                    ErrorMessage="El largo de la falda es obligatorio."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-4">
                <label class="form-label" for="ddlConVolantes">
                    Con Volantes <span id="spanReqVolantes" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlConVolantes" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="1">Sí</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvConVolantes" runat="server"
                    ControlToValidate="ddlConVolantes"
                    ErrorMessage="Indica si la falda tiene volantes."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>

    <!-- PANEL PANTALÓN -->
    <asp:Panel ID="pnlPANTALON" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoPantalon">
                    Tipo de Pantalón <span id="spanReqTipoPantalon" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoPantalon" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoPantalon" runat="server"
                    ControlToValidate="ddlTipoPantalon"
                    ErrorMessage="Selecciona un tipo de pantalón."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>

            <div class="col-md-4">
                <label class="form-label" for="txtLargoPierna">
                    Largo pierna (cm) <span id="spanReqLargoPierna" runat="server">(*)</span>
                </label>
                <asp:TextBox ID="txtLargoPierna" runat="server" CssClass="form-control" placeholder="Ej: 100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLargoPierna" runat="server"
                    ControlToValidate="txtLargoPierna"
                    ErrorMessage="El largo de pierna es obligatorio."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    ValidationGroup="Prenda" />
            </div>

            <!-- NUEVO: Cintura (cm) -->
            <div class="col-md-4">
                <label class="form-label" for="txtCintura">
                    Cintura (cm) <span id="spanReqCintura" runat="server">(*)</span>
                </label>
                <asp:TextBox ID="txtCintura" runat="server" CssClass="form-control" placeholder="Ej: 78"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCintura" runat="server"
                    ControlToValidate="txtCintura"
                    ErrorMessage="La cintura es obligatoria."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>

    <!-- PANEL CASACA -->
    <asp:Panel ID="pnlCASACA" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label" for="ddlTipoCasaca">
                    Tipo de Casaca <span id="spanReqTipoCasaca" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoCasaca" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoCasaca" runat="server"
                    ControlToValidate="ddlTipoCasaca"
                    ErrorMessage="Selecciona un tipo de casaca."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-6">
                <label class="form-label" for="ddlConCapucha">
                    Con Capucha <span id="spanReqCapucha" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlConCapucha" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="1">Sí</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvConCapucha" runat="server"
                    ControlToValidate="ddlConCapucha"
                    ErrorMessage="Indica si la casaca tiene capucha."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>

    <!-- PANEL GORRO -->
    <asp:Panel ID="pnlGORRO" runat="server" Visible="false">
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label" for="ddlTipoGorra">
                    Tipo de Gorro <span id="spanReqTipoGorra" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTipoGorra" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoGorra" runat="server"
                    ControlToValidate="ddlTipoGorra"
                    ErrorMessage="Selecciona un tipo de gorro."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-4">
                <label class="form-label" for="ddlTallaAjustable">
                    Talla Ajustable <span id="spanReqTallaAjustable" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlTallaAjustable" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="1">Sí</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTallaAjustable" runat="server"
                    ControlToValidate="ddlTallaAjustable"
                    ErrorMessage="Indica si la talla es ajustable."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
            <div class="col-md-4">
                <label class="form-label" for="ddlImpermeable">
                    Impermeable <span id="spanReqImpermeable" runat="server">(*)</span>
                </label>
                <asp:DropDownList ID="ddlImpermeable" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="1">Sí</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvImpermeable" runat="server"
                    ControlToValidate="ddlImpermeable"
                    ErrorMessage="Indica si el gorro es impermeable."
                    CssClass="text-danger small"
                    Display="Dynamic"
                    InitialValue=""
                    ValidationGroup="Prenda" />
            </div>
        </div>
    </asp:Panel>
</div>

        <!-- PANEL STOCK POR TALLA (solo en VER) -->
        <asp:Panel ID="pnlStockTallas" runat="server"
            CssClass="card-white stock-card" Visible="false">
            <div class="card-title stock-title">Stock por talla</div>
            
            <asp:GridView ID="gvStockTallas" runat="server"
                CssClass="table table-striped table-sm stock-table"
                AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Talla" HeaderText="Talla" />
                    <asp:BoundField DataField="Stock" HeaderText="Stock disponible" />
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <div class="card-white" style="display: flex; justify-content: space-between; align-items: center">
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-outline" OnClick="btnCancelar_Click" />
<%--           <asp:Button ID="btnVerPromosDesc" runat="server" Text="Ver Promociones Y Descuentos" CssClass="btn" OnClick="btnVerPromosDesc_Click" />--%>
            <asp:LinkButton ID="lbVerDescuentos" runat="server" CssClass="btn-wd"
                        OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#form-modal-descuentos">
                        Visualizar Descuentos
                    </asp:LinkButton>

                    <asp:LinkButton ID="lbVerPromociones" runat="server" CssClass="btn-wd"
                        OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#form-modal-promociones">
                        Visualizar Promociones
                    </asp:LinkButton>
            <asp:Button ID="btnGuardar" runat="server"
                Text="Guardar"
                CssClass="btn btn-primary"
                OnClick="btnGuardar_Click"
                ValidationGroup="Prenda"
                CausesValidation="true" />
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
                                    <asp:BoundField HeaderText="ID" DataField="IdDescuento" />
                                    <asp:BoundField HeaderText="Nombre Descuento Monto" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Monto Editable" DataField="montoEditable" />
                                    <asp:BoundField HeaderText="Monto Máximo" DataField="montoMaximo" DataFormatString="{0:C}" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Descuentos por Porcentaje</h6>
                            <asp:GridView ID="gvDescPorc" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped mb-4" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="IdDescuento" />
                                    <asp:BoundField HeaderText="Nombre Descuento Porcentaje" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Porcentaje %" DataField="porcentaje" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Descuentos por Liquidación</h6>
                            <asp:GridView ID="gvDescLiq" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="IdDescuento" />
                                    <asp:BoundField HeaderText="Nombre Descuento Liquidación" DataField="Nombre" />
                                    <asp:BoundField HeaderText="Porcentaje Liquidación %" DataField="porcentajeLiquidacion" />
                                    <asp:BoundField HeaderText="Stock Mínimo" DataField="condicionStockMin" />
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
                                    <asp:BoundField HeaderText="ID" DataField="idPromocion" />
                                    <asp:BoundField HeaderText="Nombre Promoción Combo" DataField="nombre" />
                                    <asp:BoundField HeaderText="Cantidad Gratis" DataField="cantidadGratis" />
                                    <asp:BoundField HeaderText="Cantidad Requerida" DataField="cantidadRequerida" />
                                </Columns>
                            </asp:GridView>

                            <h6 class="fw-semibold text-secondary mb-2">Promoción Conjunto</h6>
                            <asp:GridView ID="gvPromoConjunto" runat="server" AutoGenerateColumns="false" GridLines="None"
                                CssClass="table table-hover table-striped" ShowHeaderWhenEmpty="True">
                                <HeaderStyle CssClass="gv-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="idPromocion" />
                                    <asp:BoundField HeaderText="Nombre Promoción Conjunto" DataField="nombre" />
                                    <asp:BoundField HeaderText="Porcentaje Promoción %" DataField="porcentajePromocion" />
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

<asp:Content ID="cScripts" ContentPlaceHolderID="ScriptsContent" runat="server" >
 <%--<!-- Asegúrate de que jQuery esté cargado primero -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- El script para mostrar los modales -->
    <script type="text/javascript">
        // Función que abre el modal de descuentos
        $(document).ready(function () {
            // Mostrar los modales cuando la página cargue (ajusta según la lógica de tu evento)
            $('#form-modal-descuentos').modal('show');
            $('#form-modal-promociones').modal('show');
        });
    </script>--%>
</asp:Content>