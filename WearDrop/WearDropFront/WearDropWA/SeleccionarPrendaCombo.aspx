<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="SeleccionarPrendaCombo.aspx.cs" Inherits="WearDropWA.SeleccionarPrendaCombo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Seleccionar Prendas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Estilos generales para la página de selección de prendas */
        .prenda-container {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 70%;
        }

        .prenda-container h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-field {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            margin-top: 20px;
        }

        .form-field label {
            font-size: 14px;
            color: #333;
            width: 150px;
        }

        .form-field select {
            background-color: #F5F5F5;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
            width: calc(100% - 160px);
        }
        .color-bar {
    height: 100%;
}

.bar-1 {
    background-color: #DFBCBC;
    flex: 1.5;
}

.bar-2 {
    background-color: #C5A0A0;
    flex: 1.5;
}
        .form-button-container {
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            margin-top: 20px;
        }

        .btn-seleccionar-prendas {
            background-color: #C5A0A0;
            color: white;
            padding: 10px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-seleccionar-prendas:hover {
            background-color: #8698a8;
        }

        /* Estilo para el contenedor de opciones */
        .form-field-options {
            margin-top: 20px;
        }

        .form-field-options label {
            font-size: 14px;
            color: #333;
        }

        .form-field-options select {
            width: 100%;
            background-color: #F5F5F5;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            padding: 10px;
        }

        /* Fondo gris semi-transparente que aparece cuando se selecciona una prenda */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Gris oscuro semitransparente */
            display: none; /* Inicialmente oculto */
            z-index: 999;
        }

        /* Estilo para el contenedor de opciones que aparece sobre el fondo gris */
        .options-container {
            position: relative;
            z-index: 1000; /* Se asegura de que esté por encima del fondo gris */
        }
         .header-title {
     display: flex;
     align-items: stretch;
     height: 60px;
     box-shadow: 0 2px 4px rgba(0,0,0,0.1);
     width: 100%
 }

 .title-section {
     background-color: #FFFFFF;
     padding: 0 25px;
     display: flex;
     align-items: center;
     flex-grow: 1;
 }
 .cuadro-blanco {
    background-color: #FFFFFF;  /* Fondo blanco */
    border-radius: 8px;  /* Bordes redondeados */
    padding: 20px;  /* Espacio interior */
    margin-top: 30px;  /* Separación del título */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);  /* Sombra sutil */
    width: 100%;  /* Asegura que el cuadro ocupe el 100% del ancho disponible */
    height: auto;  /* Permite que el cuadro se agrande según el contenido */
    min-height: 200px;  /* Establece una altura mínima si no hay mucho contenido */
}
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        
            <div class="container row">
    <div class="row align-items-center">
        <!-- Columna del título -->
        <!-- Título con barras decorativas -->
        <div class="col-md-6 p-0">
            <div class="header-title">
                <div class="title-section">
                    <h2>Seleccionar Prenda</h2>
                </div>
                <div class="color-bar bar-1"></div>
                <div class="color-bar bar-2"></div>
            </div>
        </div>

        
</div>
                <div class="container cuadro-blanco">
                    <div class="row mb-4">
    <div class="col-md-12">
        <label class="form-label">
            Falda <span class="required">(*)</span>
        </label>
        <asp:DropDownList ID="ddlFaldas" runat="server" 
            CssClass="form-select"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlIdFalda_SelectedIndex">
        </asp:DropDownList>
         <label class="form-label">
     Blusa <span class="required">(*)</span>
 </label>
         <asp:DropDownList ID="ddlBlusas" runat="server" 
     CssClass="form-select"
     AutoPostBack="true"
     OnSelectedIndexChanged="ddlIdBlusas_SelectedIndex">
 </asp:DropDownList>
        <label class="form-label">
    Gorro <span class="required">(*)</span>
</label>
<asp:DropDownList ID="ddlGorros" runat="server" 
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlIdGorro_SelectedIndex">
</asp:DropDownList>
                <label class="form-label">
    Casaca <span class="required">(*)</span>
</label>
<asp:DropDownList ID="ddlCasaca" runat="server" 
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlIdCasaca_SelectedIndex">
</asp:DropDownList>
                        <label class="form-label">
    Pantalón <span class="required">(*)</span>
</label>
<asp:DropDownList ID="ddlPantalon" runat="server" 
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlPantalon_SelectedIndex">
</asp:DropDownList>
                                <label class="form-label">
    Polo <span class="required">(*)</span>
</label>
<asp:DropDownList ID="ddlPolo" runat="server" 
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlPolo_SelectedIndex">
</asp:DropDownList>
                                <label class="form-label">
    Vestido <span class="required">(*)</span>
</label>
<asp:DropDownList ID="ddlVestido" runat="server" 
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlVestido_SelectedIndex">
</asp:DropDownList>
       <%-- <asp:RequiredFieldValidator ID="rfvFalda" runat="server"
            ControlToValidate="ddlFaldas"
            InitialValue="0"
            ErrorMessage="Debe seleccionar una falda"
            CssClass="text-danger"
            Display="Dynamic">
        </asp:RequiredFieldValidator>--%>
    </div>

            <div class="form-button-container">
                <asp:Button ID="btnSeleccionarPrendas" runat="server" Text="Seleccionar Prendas" CssClass="btn-seleccionar-prendas" OnClick="btnSeleccionarPrendas_Click" />
            </div>
</div>
                 </div>

<%--            <div class="form-button-container">
                <asp:Button ID="btnSeleccionarPrendas" runat="server" Text="Seleccionar Prendas" CssClass="btn-seleccionar-prendas" OnClick="btnSeleccionarPrendas_Click" />
            </div>--%>
        </div>
    </div>
</asp:Content>
