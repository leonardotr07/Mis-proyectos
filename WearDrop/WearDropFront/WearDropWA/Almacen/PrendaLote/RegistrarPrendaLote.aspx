<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarPrendaLote.aspx.cs" Inherits="WearDropWA.RegistrarPrendaLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Prenda en Lote
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .title-section {
            background-color: #FFFFFF;
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

        /* Formulario */
        .form-container {
            background-color: #FFFFFF;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
            display: block;
        }

        .required {
            color: #dc3545;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }

        .form-control-short {
            max-width: 250px;
        }

        .form-control:focus {
            outline: none;
            border-color: #95B88F;
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
        }

        .form-control:disabled {
            background-color: #f5f5f5;
            color: #666;
            cursor: not-allowed;
        }

        .text-danger {
            color: #dc3545;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }

        /* Sección de búsqueda de prenda */
        .search-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 25px;
            border: 1px solid #e0e0e0;
        }

        .search-section-title {
            font-size: 16px;
            font-weight: 600;
            color: #73866D;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #95B88F;
        }

        .search-divider {
            text-align: center;
            position: relative;
            margin: 20px 0;
        }

        .search-divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 45%;
            height: 1px;
            background-color: #ddd;
        }

        .search-divider::after {
            content: '';
            position: absolute;
            right: 0;
            top: 50%;
            width: 45%;
            height: 1px;
            background-color: #ddd;
        }

        .search-divider span {
            background-color: #f8f9fa;
            padding: 0 15px;
            color: #666;
            font-weight: 500;
            font-size: 14px;
        }

        /* Sección de información de prenda */
        .info-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 25px;
            border: 1px solid #e0e0e0;
        }

        .info-section-title {
            font-size: 16px;
            font-weight: 600;
            color: #73866D;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #95B88F;
        }

        .info-row {
            display: flex;
            padding: 10px 0;
            border-bottom: 1px solid #e8e8e8;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #555;
            min-width: 120px;
            flex-shrink: 0;
        }

        .info-value {
            color: #333;
            flex-grow: 1;
        }

        /* Botones */
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
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #E8E8E8;
        }

        /* Select2 personalización */
        .select2-container--default .select2-selection--single {
            height: 42px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }

        .select2-container--default .select2-selection--single:focus,
        .select2-container--default.select2-container--open .select2-selection--single {
            border-color: #95B88F;
            box-shadow: 0 0 0 0.2rem rgba(149, 184, 143, 0.25);
            outline: none;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 40px;
            padding-left: 12px;
            color: #333;
            font-size: 14px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 40px;
            right: 8px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #666 transparent transparent transparent;
        }

        .select2-container--default .select2-selection--single .select2-selection__placeholder {
            color: #999;
        }

        .select2-dropdown {
            border: 1px solid #95B88F;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .select2-results__options {
            max-height: 200px !important;
            overflow-y: auto;
        }

        .select2-container--default .select2-results__option {
            padding: 10px 12px;
            font-size: 14px;
        }

        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: #E8F4E5 !important;
            color: #333;
        }

        .select2-container--default .select2-results__option[aria-selected="true"] {
            background-color: #95B88F !important;
            color: #fff;
        }

        .select2-results__options::-webkit-scrollbar {
            width: 10px;
        }

        .select2-results__options::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .select2-results__options::-webkit-scrollbar-thumb {
            background: #95B88F;
            border-radius: 4px;
        }

        .select2-results__options::-webkit-scrollbar-thumb:hover {
            background: #73866D;
        }

        .select2-container {
            width: 100% !important;
        }

        /* Ocultar sección de información inicialmente */
        .hidden {
            display: none;
        }

        /* Mensaje de error personalizado */
        .search-error {
            background-color: #fff5f5;
            border: 1px solid #feb2b2;
            border-radius: 6px;
            padding: 12px 15px;
            margin-top: 15px;
            display: none;
        }

        .search-error.show {
            display: block;
        }

        .search-error-text {
            color: #dc3545;
            font-size: 14px;
            font-weight: 500;
            margin: 0;
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
                        <h2>Registrar Prenda en Lote</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Formulario -->
        <div class="row">
            <div class="col-md-12">
                <div class="form-container">
                    
                    <!-- Sección de Búsqueda -->
                    <div class="search-section">
                        <div class="search-section-title">Buscar Prenda</div>
                        
                        <!-- Búsqueda por ID -->
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label">Buscar por ID de Prenda</label>
                                <asp:TextBox ID="txtIdPrenda" runat="server"
                                    CssClass="form-control"
                                    placeholder="Ingrese el ID de la prenda"
                                    AutoPostBack="false">
                                </asp:TextBox>
                            </div>
                        </div>

                        <!-- Divisor OR -->
                        <div class="search-divider">
                            <span>O</span>
                        </div>

                        <!-- Búsqueda por Nombre, Color y Material -->
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Nombre</label>
                                <asp:DropDownList ID="ddlNombrePrenda" runat="server" 
                                    CssClass="form-select"
                                    AutoPostBack="false">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Color</label>
                                <asp:DropDownList ID="ddlColorPrenda" runat="server" 
                                    CssClass="form-select"
                                    AutoPostBack="false">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Material</label>
                                <asp:DropDownList ID="ddlMaterialPrenda" runat="server" 
                                    CssClass="form-select"
                                    AutoPostBack="false">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <!-- Mensaje de error -->
                        <asp:Panel ID="pnlSearchError" runat="server" CssClass="search-error">
                            <p class="search-error-text">
                                <asp:Label ID="lblSearchError" runat="server" Text="No se encontró ninguna prenda con los criterios especificados"></asp:Label>
                            </p>
                        </asp:Panel>
                        
                        <div class="row mt-3">
                            <div class="col-md-12 text-end">
                                <asp:LinkButton ID="lkBuscar" runat="server"
                                    CssClass="btn-custom"
                                    OnClick="lkBuscar_Click"
                                    CausesValidation="false"
                                    Text="Buscar Prenda">
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <!-- Campos de PrendaXLote (Talla y Stock) -->
                    <div class="row mb-4 mt-4">
                        <div class="col-md-6">
                            <label class="form-label">
                                Talla <span class="required">(*)</span>
                            </label>
                            <asp:DropDownList ID="ddlTalla" runat="server" 
                                CssClass="form-select">
                                <asp:ListItem Value="">-- Seleccione talla --</asp:ListItem>
                                <asp:ListItem Value="XS">XS</asp:ListItem>
                                <asp:ListItem Value="S">S</asp:ListItem>
                                <asp:ListItem Value="M">M</asp:ListItem>
                                <asp:ListItem Value="L">L</asp:ListItem>
                                <asp:ListItem Value="XL">XL</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTalla" runat="server"
                                ControlToValidate="ddlTalla"
                                InitialValue=""
                                ErrorMessage="La talla es obligatoria"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label">
                                Stock <span class="required">(*)</span>
                            </label>
                            <asp:TextBox ID="txtStock" runat="server"
                                CssClass="form-control form-control-short"
                                TextMode="Number"
                                placeholder="Ingrese stock inicial">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                                ControlToValidate="txtStock"
                                ErrorMessage="El stock es obligatorio"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rvStock" runat="server"
                                ControlToValidate="txtStock"
                                Type="Integer"
                                MinimumValue="0"
                                MaximumValue="999999"
                                ErrorMessage="El stock debe ser mayor o igual a 0"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RangeValidator>
                        </div>
                    </div>

                    <!-- Botones -->
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
                            <asp:LinkButton ID="lkAgregar" runat="server"
                                CssClass="btn-custom"
                                OnClick="lkAgregar_Click"
                                Text="Agregar al Lote">
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <!-- jQuery (requerido por Select2) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script type="text/javascript">
        var preventClear = false; // Variable global para controlar si se debe limpiar

        $(document).ready(function () {
            // Inicializar Select2 en Nombre
            $('#<%= ddlNombrePrenda.ClientID %>').select2({
                placeholder: "-- Seleccione nombre --",
                allowClear: true,
                width: '100%',
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Inicializar Select2 en Color
            $('#<%= ddlColorPrenda.ClientID %>').select2({
                placeholder: "-- Seleccione color --",
                allowClear: true,
                width: '100%',
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Inicializar Select2 en Material
            $('#<%= ddlMaterialPrenda.ClientID %>').select2({
                placeholder: "-- Seleccione material --",
                allowClear: true,
                width: '100%',
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Inicializar Select2 en Talla
            $('#<%= ddlTalla.ClientID %>').select2({
                placeholder: "-- Seleccione talla --",
                allowClear: false,
                width: '100%',
                minimumResultsForSearch: Infinity,
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Limpiar los otros campos cuando se escribe en ID (solo si es manual)
            $('#<%= txtIdPrenda.ClientID %>').on('input', function () {
                // Solo limpiar si el usuario está escribiendo manualmente
                if ($(this).val().trim() !== '' && !preventClear) {
                    $('#<%= ddlNombrePrenda.ClientID %>').val('').trigger('change');
                    $('#<%= ddlColorPrenda.ClientID %>').val('').trigger('change');
                    $('#<%= ddlMaterialPrenda.ClientID %>').val('').trigger('change');
                }
            });

            // Limpiar ID cuando se selecciona algún otro campo (solo si es manual)
            $('#<%= ddlNombrePrenda.ClientID %>, #<%= ddlColorPrenda.ClientID %>, #<%= ddlMaterialPrenda.ClientID %>').on('select2:select', function () {
                // Solo limpiar si no estamos en medio de una actualización automática
                if (!preventClear) {
                    $('#<%= txtIdPrenda.ClientID %>').val('');
                }
            });
        });
    </script>
</asp:Content>