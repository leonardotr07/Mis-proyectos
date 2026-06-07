<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="VerItemsVenta.aspx.cs" Inherits="WearDropWA.VerItemsVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <span id="tituloPagina" runat="server">Ver Items Venta</span>
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
}
.header-box h2 {
    margin: 0;
    color: #333;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    margin-right: 20px;
}

/* -------------------- Bloques de color -------------------- */
.color-container {
    display: flex;
    align-items: stretch;
    gap: 0;
}
.color-block {
    width: 100px;
    flex: none;
}
.block-red {
    background-color: #ff6b6b;
}
.block-lred {
    background-color: #FFA2A2;
}

/* -------------------- Contenedores superiores -------------------- */
.section-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 40px;
}
.buttons-container {
    display: flex;
    gap: 10px;
    padding-right: 50px;
}

/* -------------------- Estilos de la grilla -------------------- */
.grid-border {
    border: 1px solid #dee2e6;
    border-radius: 6px;
    overflow: hidden;
}

/* 🔹 Contenedor con scroll */
.scroll-container {
    max-height: 325px;
    overflow-y: auto;
    overflow-x: hidden;
    border: 1px solid #dee2e6;
    border-radius: 6px;
}

.scroll-container table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed;
}

.scroll-container thead th {
    position: sticky;
    top: 0;
    z-index: 2;
    background-color: #FFA2A2 !important;
    color: black !important;
    text-align: center;
}

/* Encabezado */
.grid-header th {
    background-color: #FFA2A2 !important;
    color: black !important;
    text-align: center;
}

/* Celdas del cuerpo */
.grid-border td {
    vertical-align: middle;
    text-align: center;
}

/* -------------------- Sección Total -------------------- */
.total-container {
    width: 100%;
    max-width: 100%;
    border: 1px solid #dee2e6;
    border-radius: 6px;
    margin-top: 20px;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #FFA2A2;
    box-sizing: border-box;
}
.total-container label {
    font-weight: 600;
    color: #333;
    font-size: 1rem;
}
.total-right {
    display: flex;
    align-items: center;
    gap: 8px;
}
.total-right h2 {
    margin: 0;
    color: #333;
    font-size: 1.5rem;
    font-weight: 600;
}
.total-container .total-box {
    width: 150px;
    text-align: right;
    font-weight: bold;
    background-color: #FFA2A2;
    border: none;
    border-radius: 8px;
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
    cursor: default;
    color: #000;
}

/* -------------------- Contenedor de botones inferiores -------------------- */
.buttons-bottom-container {
    width: 100%;
    max-width: 100%;
    border: 1px  #dee2e6;
    border-radius: 6px;
    margin-top: 20px;
    padding: 15px 30px;
    display: flex;
    justify-content: flex-start; /* 🔹 Alinear a la izquierda */
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

<!-- -------------------- SECCIÓN SUPERIOR -------------------- -->
<div class="section-container">
    <div class="header-box">
        <h2 id="lblTitulo" runat="server">Ver Items de Venta</h2>
        <div class="color-container">
            <div class="color-block block-red"></div>
            <div class="color-block block-lred"></div>
        </div>
    </div>
</div>

<!-- -------------------- GRIDVIEW CON SCROLL -------------------- -->
<div class="container mt-4 scroll-container">
    <asp:GridView ID="dgvProductosVenta" 
        runat="server"
        AutoGenerateColumns="false"
        CssClass="table table-hover table-striped align-middle grid-border"
        HeaderStyle-CssClass="grid-header"
        ShowHeaderWhenEmpty="true"
        AllowPaging="false"
        UseAccessibleHeader="true"
        >
        <Columns>
            <asp:BoundField DataField="Nº" HeaderText="Nº" />
            <asp:BoundField DataField="Prenda" HeaderText="Prenda" />
            <asp:BoundField DataField="Talla" HeaderText="Talla" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
            <asp:BoundField DataField="Promociones" HeaderText="Promociones" />
            <asp:BoundField DataField="Descuentos" HeaderText="Descuentos" />
            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:N2}" HtmlEncode="false" ItemStyle-CssClass="align-middle text-center"/>
        </Columns>
    </asp:GridView>
</div>

<!-- -------------------- DIV TOTAL PAGADO -------------------- -->
<div class="container total-container">
    <label>Total pagado:</label>
    <div class="total-right">
        <h2>S/</h2>
        <asp:TextBox ID="txtTotalPagado" runat="server" CssClass="form-control total-box" ReadOnly="true"></asp:TextBox>
    </div>
</div>

<!-- -------------------- DIV BOTONES INFERIORES -------------------- -->
<div class="container buttons-bottom-container">
    <asp:LinkButton 
        ID="btnRegresarVentaProducto" 
        runat="server" 
        CssClass="btn btn-danger rounded shadow-sm"
        OnClick="btnRegresarVentaProducto_Click">
        <i class="fa-solid fa-circle-left"></i> Regresar
    </asp:LinkButton>
</div>




</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
