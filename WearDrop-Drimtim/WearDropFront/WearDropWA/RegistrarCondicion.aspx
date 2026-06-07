<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarCondicion.aspx.cs" Inherits="WearDropWA.RegistrarCondicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Condición

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


   <style>
/* ====== Layout base ====== */
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

.color-bar { height: 100%; }
.bar-1 { flex: 1.5; }
.bar-2 { flex: 1.5; }

.top-accent {
    height: 4px;
    margin-top: 10px;
    border-radius: 4px;
}

/* ====== Contenedor principal ====== */
.section-container {
    width: 60%;
    margin-top: 40px;
    display: flex;
    flex-direction: column;
    gap: 30px;
}

/* ====== Subdivisiones ====== */
.subsection {
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 25px 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    width: 100%;
}

/* 🔹 Filas con dos columnas */
.two-columns {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 60px;
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

/* 🔹 TextBox */
.form-control {
    width: 250px;
    text-align: left;
}

/* ====== Botones personalizados ====== */
.btn-wd {
    background: var(--tone-3);
    color: #fff;
    border: none;
    padding: 10px 25px;
    border-radius: 12px;
    cursor: pointer;
    display: inline-block;
    transition: .15s;
    box-shadow: 0 1px 2px rgba(0,0,0,.08);
    font-weight: 500;
}
.btn-wd:hover { filter: brightness(.95); }
.btn-wd i { margin-right: 6px; }

/* ===== Tonos verdes ===== */
.theme-condicion {
    --tone-1: #C6D8C4; /* verde claro */
    --tone-2: #9DBD9B; /* verde medio */
    --tone-3: #7FA07E; /* verde más oscuro */
}
.theme-scope .bar-1 { background: var(--tone-1); }
.theme-scope .bar-2 { background: var(--tone-2); }
.theme-scope .btn-wd { background: var(--tone-3); color: #fff; }
.theme-scope .btn-wd:hover { filter: brightness(.95); }
.theme-scope .top-accent { background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3)); }

/* ===== Botones inferiores ===== */
.buttons-bottom-container {
    width: 60%;
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>

<!-- ======================== ESTRUCTURA PRINCIPAL ======================== -->
<div class="theme-condicion theme-scope">
    <div class="container">
        <div class="top-accent"></div>

        <!-- ====== CABECERA ====== -->
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2 id="lblTituloCondicion" runat="server">Registrar Condición</h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ====== CAMPOS PRINCIPALES ====== -->
        <div class="section-container">
            <!-- Fila 1 -->
            <div class="subsection">
                <div class="two-columns">
                    <div class="field-block">
                        <h3>ID</h3>
                        <asp:TextBox ID="txtIDCondicion" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="field-block">
                        <h3>ID Proveedor</h3>
                        <asp:TextBox ID="txtIDProveedor" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Fila 2 -->
            <div class="subsection">
                <div class="two-columns">
                    <div class="field-block">
                        <h3>Número de días (*)</h3>
                        <asp:TextBox ID="txtNumeroDias" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="field-block">
                        <h3>Descripción (*)</h3>
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!-- ====== BOTONES INFERIORES ====== -->
        <div class="buttons-bottom-container">
            <asp:LinkButton 
                ID="btnRegresar" 
                runat="server" 
                CssClass="btn-wd rounded shadow-sm"
                OnClick="btnRegresar_Click">
                <i class="fa-solid fa-circle-left"></i> Regresar
            </asp:LinkButton>

            <asp:Button 
                ID="btnRegistrarCondicion" 
                runat="server" 
                Text="Registrar"
                CssClass="btn-wd rounded shadow-sm"
                OnClick="btnRegistrarCondicion_Click" />
        </div>
    </div>
</div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
