<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="VerPrendaSeleccionadaparaVenta.aspx.cs" Inherits="WearDropWA.VerPrendaSeleccionadaparaVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Ver Prenda Seleccionada
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

      <style>
/* -------------------- Caja del título -------------------- */
.header-box {
    border: 1px solid #ddd;
    background-color: #f8f9fa;
    height: 75px;
    display: flex;
    justify-content: space-between;
    align-items: stretch;
    width: 60%;
    padding-left: 20px;
    border-radius: 10px;
    margin-bottom: 30px;
}

.header-box h2 {
    margin: 0;
    color: #333;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    margin-right: 20px;
}

.color-container {
    display: flex;
    align-items: stretch;
}
.color-block {
    width: 100px;
    flex: none;
}
.block-red { background-color: #ff6b6b; }
.block-lred { background-color: #FFA2A2; }

/* -------------------- Contenedores generales -------------------- */
.section-container {
    width: 70%;
    display: flex;
    flex-direction: column;
    gap: 25px;
}

/* 🔹 Fila con varias columnas */
.row-section {
    display: flex;
    justify-content: space-between;
    gap: 20px;
}

.field-box {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.field-box label {
    font-weight: 500;
    color: #333;
    margin-bottom: 6px;
}

.field-box .form-control {
    width: 100%;
}

/* -------------------- Botones medios -------------------- */
.buttons-middle-container {
    width: 70%;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 40px;
    margin-top: 20px;
}

.btn-red {
    background-color: #dc3545;
    color: white;
    border: none;
    border-radius: 12px;
    padding: 10px 25px;
    font-weight: 500;
    transition: all 0.2s ease-in-out;
}

.btn-red:hover {
    background-color: #bb2d3b;
}

/* -------------------- GRIDVIEW -------------------- */
.grid-container {
    width: 70%;
    margin-top: 30px;
    border: 1px solid #dee2e6;
    border-radius: 6px;
    overflow: hidden;
}

.grid-border {
    border: none;
    border-radius: 6px;
    overflow: hidden;
}

.grid-header th {
    background-color: #FFA2A2 !important;
    color: black !important;
    text-align: center;
}

.grid-border td {
    text-align: center;
    vertical-align: middle;
}

/* -------------------- Botón inferior -------------------- */
.buttons-bottom-container {
    width: 70%;
    margin-top: 30px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

.buttons-bottom-container .btn {
    font-weight: 400;
    padding: 10px 25px;
    border-radius: 12px;
    background-color: #dc3545;
    border: none;
    color: white;
    transition: all 0.2s ease-in-out;
}

.buttons-bottom-container .btn:hover {
    background-color: #bb2d3b;
}

.buttons-bottom-container .btn i {
    margin-right: 6px;
}


</style>

<!-- -------------------- TÍTULO -------------------- -->
<div class="header-box">
    <h2>Ver Prenda Seleccionada</h2>
    <div class="color-container">
        <div class="color-block block-red"></div>
        <div class="color-block block-lred"></div>
    </div>
</div>

<!-- -------------------- SECCIÓN PRINCIPAL -------------------- -->
<div class="section-container">

    <!-- 🔹 Primera fila (ID - Nombre - Material) -->
    <div class="row-section">
        <div class="field-box">
            <label for="txtID">ID:</label>
            <asp:TextBox ID="txtID" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="field-box">
            <label for="txtNombre">Nombre:</label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="field-box">
            <label for="txtMaterial">Material:</label>
            <asp:TextBox ID="txtMaterial" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <!-- 🔹 Segunda fila (Color - Precio Unitario - Precio Mayor - Precio Docena) -->
    <div class="row-section">
        <div class="field-box">
            <label for="txtColor">Color:</label>
            <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="field-box">
            <label for="txtPrecioU">Precio Unitario:</label>
            <asp:TextBox ID="txtPrecioU" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="field-box">
            <label for="txtPrecioM">Precio por Mayor:</label>
            <asp:TextBox ID="txtPrecioM" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="field-box">
            <label for="txtPrecioD">Precio por Docena:</label>
            <asp:TextBox ID="txtPrecioD" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <!-- 🔹 Fila extra (Tipo) -->
    <div class="row-section">
        <div class="field-box" style="flex: 1;">
            <label for="txtTipo">Tipo:</label>
            <asp:TextBox ID="txtTipo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

</div>

<!-- 🔹 Botones de promociones y descuentos -->
<div class="buttons-middle-container">
    <asp:Button ID="btnVerDescuentos" runat="server" Text="Visualizar Descuentos" CssClass="btn btn-red" />
    <asp:Button ID="btnVerPromociones" runat="server" Text="Visualizar Promociones" CssClass="btn btn-red" />
</div>

<!-- 🔹 GRIDVIEW -->
<div class="grid-container">
    <asp:GridView 
        ID="dgvTallasStock"
        runat="server"
        AutoGenerateColumns="false"
        CssClass="table table-hover table-striped align-middle grid-border"
        HeaderStyle-CssClass="grid-header"
        ShowHeaderWhenEmpty="true"
        AllowPaging="false"
        UseAccessibleHeader="true">
        <Columns>
            <asp:BoundField DataField="Talla" HeaderText="Talla" />
            <asp:BoundField DataField="Stock" HeaderText="Stock" />
        </Columns>
    </asp:GridView>
</div>

<!-- 🔹 Botón inferior Regresar -->
<div class="buttons-bottom-container">
    <asp:LinkButton 
        ID="btnRegresar" 
        runat="server" 
        CssClass="btn btn-danger rounded shadow-sm"
        OnClick="btnRegresar_Click">
        <i class="fa-solid fa-circle-left"></i> Regresar
    </asp:LinkButton>
</div>




</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
