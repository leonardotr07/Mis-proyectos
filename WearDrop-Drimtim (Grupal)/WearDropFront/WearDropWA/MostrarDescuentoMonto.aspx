<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="MostrarDescuentoMonto.aspx.cs" Inherits="WearDropWA.MostrarDescuentoMonto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mostrar Descuento Monto
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
              .header-title {
            display: flex; 
            align-items: stretch; height: 60px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); 

        } 
        .title-section {
            background-color: #FFFFFF; padding: 0 25px; display: flex; align-items: center; flex: 0 0 150px; 

        } 
        .title-section h2 {
            margin: 0; font-size: 20px; font-weight: 500; color: #333; white-space: nowrap;

        } 
        .color-bar { 
            height: 100%; 

        } 
        .bar-1 { 
              background-color: #DFBCBC; flex: 1.5; max-width: 150px;

          }
        .bar-2 {
            background-color: #C5A0A0; 
            flex: 1.5; 
            max-width: 150px;
        }

        /* Estilos para el formulario "Registrar Vigencia Previa" */
        .vigencia-previa-container {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 70%;
        }

        .vigencia-previa-container h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-field {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-field label {
            font-size: 14px;
            color: #333;
            width: 150px;
        }

        .form-field input {
            background-color: #F5F5F5;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
            width: calc(100% - 160px); /* Para que ocupe el espacio restante */
        }

        .form-button-container {
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            margin-top: 20px;
        }
        
        .form-button-container-prenda {
            display: flex;
            justify-content: flex-start;
            gap: 20px;
            margin-top: 20px;
        }

        .btn-cancelar, .btn-regresar {
            background-color: #C5A0A0;
            color: white;
            padding: 10px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

         .btn-registrar-vigencia {
    background-color: #C5A0A0;
    color: white;
    padding: 10px 30px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}
        .btn-cancelar:hover, .btn-regresar:hover {
            background-color: #8698a8;
        }

        /* Estilos para "Añadir Prenda" */
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

        /* Estilos para el formulario "Registrar Descuento Porcentaje" */
        .descuento-container {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 70%;
        }

        .descuento-container .form-field {
            margin-bottom: 15px;
        }

/* ===== Tonos ===== */


.theme-scope .bar-1 { background:var(--tone-1); }
.theme-scope .bar-2 { background:var(--tone-2); }
.theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
.theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
.theme-scope .btn-wd:hover { filter:brightness(.95); }
.theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }

/* ===== Botones de acción estilo Bootstrap ===== */
.action-btns i { font-size:1.1em; }
.btn-sm { padding:4px 8px !important; margin-right:4px; }
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
                        <h2>Mostrar Descuento</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>
    </div>
        <div class="container cuadro-blanco">
    <div class="col-md-8">
        <!-- Nombre -->
        <div class="mb-4">
         <asp:Label ID="lblId" runat="server" Text="ID " CssClass="form-label"></asp:Label>
    <asp:TextBox ID="txtIdDescuento" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
    </div>
        <div class="mb-4">
            <asp:Label ID="lblNombre" runat="server" Text="Nombre " CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
        </div>

        <!-- Ubicacion -->
        <div class="mb-4">
            <asp:Label ID="lbMontoEditable" runat="server" Text="Monto Editable " CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtMontoEditable" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
        </div>

        <!-- Stock -->
        <div class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <asp:Label ID="lbMontoMaximo" runat="server" Text="Monto Máximo " CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtMontoMáximo" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- Botones -->
        <div class="mt-5 d-flex justify-content-between">
            <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn-regresar" OnClick="btnRegresar_Click" />
            <!--Los paramétros estan con registrar, por alguna razón corre.-->
        </div>
    </div>
</div>
   </div>
</asp:Content>
