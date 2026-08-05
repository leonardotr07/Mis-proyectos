<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ModificarMonto.aspx.cs" Inherits="WearDropWA.ModificarMonto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Monto
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
            .header-title {
        display: flex;
        align-items: stretch;
        height: 60px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
    .custom-grid {
    border-collapse: collapse;
    width: 100%;
}

        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            background-color: #F5F5F5;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            padding: 10px 15px;
        }

        .btn-cancelar {
            background-color: #C5A0A0;
            color: #FFFFFF;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-modificar {
            background-color: #C5A0A0;
            color: #FFFFFF;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-cancelar:hover, .btn-modificar:hover {
            background-color: #5f6f5a;
            color: #FFFFFF;
        }
              .btn-anadir-prenda {
           background-color: #C5A0A0;
color: white;
padding: 10px 30px;
border: none;
border-radius: 4px;
cursor: pointer;
font-size: 14px;
      }

      .btn-anadir-prenda:hover {
          background-color: #8698a8;
      }
       .form-button-container-prenda {
     display: flex;
     justify-content: flex-start;
     gap: 20px;
     margin-top: 20px;
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
            <!-- Header con barras decorativas -->
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Modificar Descuento</h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Formulario -->
        <div class="container cuadro-blanco">
        <div class="row mt-5">
            <div class="col-md-8">
                <!-- Nombre -->
           <div class="col-md-4">
    <label class="form-label" for="txtNombre">
        Nombre <span id="spanReqNombreMonto" runat="server">(*)</span>
    </label>
    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: PROM1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombreMonto" runat="server"
    ControlToValidate="txtNombre"
    ErrorMessage="El nombre es Obligatorio"
    CssClass="text-danger"
    Display="Dynamic">
</asp:RequiredFieldValidator>
                    </div>
                <!-- Ubicacion -->
               
                <div class="col-md-4">
    <label class="form-label" for="txtMontoMaximo">
        Monto Máximo <span id="spanMontoMax" runat="server">(*)</span>
    </label>
    <asp:TextBox ID="txtMontoMaximo" runat="server" CssClass="form-control" placeholder="Ej: 100"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvMonto" runat="server"
    ControlToValidate="txtMontoMaximo"
    ErrorMessage="El campo de monto máximo es Obligatorio"
    CssClass="text-danger"
    Display="Dynamic">
</asp:RequiredFieldValidator>
</div>

                <!-- Stock -->
                
                <div class="col-md-4">
    <label class="form-label" for="txtMontoEditable">
        Monto Editable <span id="spanMontoEditable" runat="server">(*)</span>
    </label>
    <asp:TextBox ID="txtMontoEditable" runat="server" CssClass="form-control" placeholder="Ej: 100"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="rfvMontoEditable" runat="server"
    ControlToValidate="txtMontoEditable"
    ErrorMessage="El campo de monto editable es Obligatorio"
    CssClass="text-danger"
    Display="Dynamic">
</asp:RequiredFieldValidator>
</div>
                                <div class="form-button-container-prenda
    ">
    <asp:Button ID="btnAñadirPrenda" runat="server" Text="Añadir Prenda" CssClass="btn-anadir-prenda" OnClick="btnAñadirPrenda_Click"/>
</div>
                <!-- Botones -->
                <div class="mt-5 d-flex justify-content-between">
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-cancelar" OnClick="btnCancelar_Click" />
                    <asp:Button ID="btnModi" runat="server" Text="Modificar" CssClass="btn-modificar" OnClick="btnModificar_Click" />
                </div>
            </div>
        </div>
    </div>
        </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
