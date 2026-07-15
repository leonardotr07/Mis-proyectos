<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="VerVentaResumen.aspx.cs" Inherits="WearDropWA.VerVentaResumen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    Detalles de la Venta

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

/* -------------------- Contenedor principal -------------------- */
.section-container {
    width: 60%;
    display: flex;
    flex-direction: column;
    gap: 30px;
}

/* -------------------- Subdivisiones -------------------- */
.subsection {
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 25px 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    width: 100%;
}

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

/* 🔹 Campos de texto */
.form-control {
    width: 250px;
    text-align: left;
}

/* 🔹 Botones */
.btn {
    font-weight: 400;
    padding: 10px 25px;
    border-radius: 12px;
    background-color: #dc3545;
    border: none;
    color: white;
    transition: all 0.2s ease-in-out;
}

.btn:hover {
    background-color: #bb2d3b;
}

.btn i {
    margin-right: 6px;
}

/* 🔹 Contenedores de botones */
.buttons-bottom-container {
    width: 60%;
    margin-top: 30px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 20px;
}
/* 🔹 Coloca el botón al mismo nivel que el header */
.header-actions {
    position: absolute;
    top: 0; /* Se alineará con la parte superior de la página */
    left: 0;
    margin-top: 20px; /* Ajusta según necesites para igualar la altura del h2 */
    margin-left: 50px; /* Alinea con el borde izquierdo del contenido */
}

/* Mantiene el diseño rojo del botón */
.header-actions .btn {
    font-weight: 500;
    padding: 10px 25px;
    border-radius: 12px;
    background-color: #dc3545;
    border: none;
    color: white;
    transition: all 0.2s ease-in-out;
}

.header-actions .btn:hover {
    backgro



</style>

<!-- 🔻 ENCABEZADO -->
<div class="header-box">
    <h2>Detalles de la Venta</h2>
    <div class="color-container">
        <div class="color-block block-red"></div>
        <div class="color-block block-lred"></div>
    </div>
</div>

<!-- 🔻 CONTENIDO PRINCIPAL -->
<div class="section-container">

    <!-- 🟥 FILA 1 -->
    <div class="subsection">
        <div class="two-columns">
            <div class="field-block">
                <h3>ID Venta</h3>
                <asp:TextBox ID="txtIDVenta" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="field-block">
                <h3>DNI del Cliente</h3>
                <asp:TextBox ID="txtDNICliente" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
    </div>

    <!-- 🟥 FILA 2 -->
    <div class="subsection">
        <div class="two-columns">
            <div class="field-block">
                <h3>ID Empleado</h3>
                <asp:TextBox ID="txtIDEmpleado" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="field-block">
                <h3>Usuario del Empleado</h3>
                <asp:TextBox ID="txtUsuarioEmpleado" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
    </div>

    <!-- 🟥 FILA 3 -->
    <div class="subsection">
        <div class="two-columns">
            <div class="field-block">
                <h3>Fecha</h3>
                <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="field-block">
                <h3>Monto Total</h3>
                <asp:TextBox ID="txtMontoTotal" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
    </div>

    <!-- 🟥 TIPO DE COMPROBANTE -->
    <div class="subsection">
        <div class="two-columns">
            <div class="field-block">
                <h3>Tipo de Comprobante</h3>
                <asp:TextBox ID="txtTipoComprobante" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="field-block" style="display:flex; align-items:end;">
                <asp:Button 
                    ID="btnVerComprobante"
                    runat="server"
                    Text="Ver Comprobante"
                    CssClass="btn btn-danger rounded shadow-sm"
                    OnClick="btnVerComprobante_Click" />
            </div>
        </div>
    </div>

    <!-- 🟥 ITEMS COMPRADOS -->
    <div class="subsection">
        <div class="two-columns">
            <div class="field-block">
                <h3>Items Comprados:</h3>
            </div>
            <div class="field-block" style="display:flex; align-items:end;">
                <asp:Button 
    ID="btnVerItemsVenta" 
    runat="server" 
    Text="Ver Items de Venta"
    CssClass="btn btn-danger rounded shadow-sm"
    OnClick="btnVerItemsVenta_Click" />
            </div>
        </div>
    </div>

</div>

<!-- 🔹 BOTÓN INFERIOR -->
<div class="buttons-bottom-container">
    <asp:LinkButton 
        ID="btnRegresarVenta" 
        runat="server" 
        CssClass="btn btn-danger rounded shadow-sm"
        OnClick="btnRegresarVenta_Click">
        <i class="fa-solid fa-circle-left"></i> Regresar
    </asp:LinkButton>
</div>



</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
