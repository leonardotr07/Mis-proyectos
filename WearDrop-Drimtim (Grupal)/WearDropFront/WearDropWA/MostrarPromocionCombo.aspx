<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="MostrarPromocionCombo.aspx.cs" Inherits="WearDropWA.MostrarPromocionCombo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mostrar Promocion Combo
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

.modal-body {
    margin-bottom: 25px;
}

.info-field {
    margin-bottom: 15px;
}

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
    
    .custom-grid tr:nth-child(even) {
        background-color: #F5F5F5;
    }
    
    .custom-grid tr:hover {
        background-color: #E8F4E5;
    }
    
    .custom-grid a {
        color: #333;
        text-decoration: none;
        margin: 0 5px;
    }
                a, a:visited, a:hover, a:active, .btn-wd { text-decoration:none !important; color:inherit }

.btn-wd {
    background:var(--btn); color:#fff; border:none; padding:8px 18px;
    border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
    box-shadow:0 1px 2px rgba(0,0,0,.08)
}
.btn-outline-success i {
    color: #28a745; /* Verde */
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

.btn-outline-primary i {
    color: #007bff; /* Azul */
}

.btn-outline-danger i {
    color: #dc3545; /* Rojo */
}
.btn-wd:hover { filter:brightness(.95) }
.btn-wd:active { transform:translateY(1px) }
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

 .btn-eliminar:hover {
     background-color: #c82333;
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
                        <h2>Mostrar Promocion</h2>
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
    <asp:TextBox ID="txtIdPromocion" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
    </div>
        <div class="mb-4">
            <asp:Label ID="lblNombre" runat="server" Text="Nombre " CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
        </div>

        <!-- Ubicacion -->
        <div class="mb-4">
            <asp:Label ID="lbCantidadGratis" runat="server" Text="Cantidad Gratis " CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtCantidadGratis" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
        </div>

        <!-- Stock -->
        <div class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <asp:Label ID="lbCantidadRequerida" runat="server" Text="Cantidad Requerida " CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtCantidadRequerida" runat="server" CssClass="form-control" placeholder="Placeholder text"></asp:TextBox>
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
