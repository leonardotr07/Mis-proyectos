<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="SeleccionarPrendaAnnadirProducto.aspx.cs" Inherits="WearDropWA.SeleccionarPrendaAnnadirProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Seleccionar Prenda
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
.block-red { background-color: #ff6b6b; }
.block-lred { background-color: #FFA2A2; }

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

/* 🔹 Asegura que la tabla ocupe todo el ancho */
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

/* -------------------- Botón circular -------------------- */
.circle-btn {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    border: 2px solid black;
    background-color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.circle-btn.selected {
    background-color: black;
}

/* -------------------- Contenedor de botones inferiores -------------------- */
.buttons-bottom-container {
    width: 100%;
    max-width: 100%;
    border: 1px #dee2e6;
    border-radius: 6px;
    margin-top: 20px;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Botones inferiores */
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

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll(".circle-btn");
        buttons.forEach(btn => {
            btn.addEventListener("click", () => {
                buttons.forEach(b => b.classList.remove("selected"));
                btn.classList.add("selected");

                // Guardar ID seleccionado
                const hiddenField = document.getElementById("<%= hiddenSelectedID.ClientID %>");
            hiddenField.value = btn.getAttribute("data-id");
        });
    });
});
</script>

<!-- -------------------- SECCIÓN SUPERIOR -------------------- -->
<div class="section-container">
    <div class="header-box">
        <h2>Seleccionar una prenda</h2>
        <div class="color-container">
            <div class="color-block block-red"></div>
            <div class="color-block block-lred"></div>
        </div>
    </div>
</div>

<!-- -------------------- GRIDVIEW CON SCROLL -------------------- -->
<div class="container mt-4 scroll-container">
    <asp:GridView
        ID="dgvPrendas"
        runat="server"
        AutoGenerateColumns="false"
        AllowPaging="true"
        PageSize="8"
        CssClass="table table-hover table-striped align-middle grid-border"
        HeaderStyle-CssClass="grid-header"
        PagerStyle-CssClass="custom-pager"
        OnPageIndexChanging="dgvPrendas_PageIndexChanging">

        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
            <asp:BoundField DataField="Color" HeaderText="Color" />
            <asp:BoundField DataField="Material" HeaderText="Material" />
            <asp:BoundField DataField="PU" HeaderText="P/U" DataFormatString="{0:N2}" />
            <asp:BoundField DataField="PM" HeaderText="P/M" DataFormatString="{0:N2}" />
            <asp:BoundField DataField="PD" HeaderText="P/D" DataFormatString="{0:N2}" />

 
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:LinkButton
                        ID="btnVerPrendaParaVenta"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-success"
                         OnClick="btnVerPrendaParaVenta_Click"
                        
                        >
                        <i class="fa-solid fa-eye"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="Seleccionar">
                <ItemTemplate>
                    <div class="d-flex justify-content-center">
                        <div class="circle-btn" data-id='<%# Eval("ID") %>'></div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>

<asp:HiddenField ID="hiddenSelectedID" runat="server" />

<!-- -------------------- DIV BOTONES INFERIORES -------------------- -->
<div class="container buttons-bottom-container">
    <asp:LinkButton 
        ID="btnRegresar"
        runat="server"
        CssClass="btn btn-danger rounded shadow-sm"
        OnClick="btnRegresar_Click">
        <i class="fa-solid fa-circle-left"></i> Regresar
    </asp:LinkButton>

    <asp:Button
        ID="btnSeleccionar"
        runat="server"
        Text="Seleccionar"
        CssClass="btn btn-danger rounded shadow-sm"
        OnClick="btnSeleccionar_Click" />
</div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
