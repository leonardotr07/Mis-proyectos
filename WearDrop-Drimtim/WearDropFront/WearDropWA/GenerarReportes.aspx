<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GenerarReportes.aspx.cs" Inherits="WearDropWA.GenerarReportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Generación de Reportes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Define un nuevo tema de colores para Reportes, usando tonos serios como el de Ordenes de Compra (Azules/Grises) */
        .theme-reportes {
            --tone-1: #34495E; /* Azul oscuro */
            --tone-2: #2C3E50; /* Azul muy oscuro */
            --tone-3: #95A5A6; /* Gris */
        }
        /* Aplica los estilos comunes de tu código base */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            margin-bottom: 40px;
            border-radius: 10px;
            overflow: hidden;
        }

        .title-section {
            background: #fff;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 350px; /* Ancho ajustado para título de Reporte */
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
            flex: 1.5;
        }

        .bar-2 {
            flex: 1.5;
        }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            margin-bottom: 30px;
            border-radius: 4px;
        }

        /* Colores específicos del tema de Reportes */
        .theme-scope .bar-1 {
            background: var(--tone-3);
        }

        .theme-scope .bar-2 {
            background: var(--tone-2);
        }

        .theme-scope .top-accent {
            background: linear-gradient(90deg, var(--tone-3), var(--tone-2), var(--tone-1));
        }

        /* Contenedor Principal */
        .section-container {
            width: 100%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Subsecciones generales */
        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 18px 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
        }
        
        /* 🔹 Diseño de FILTROS (2 Columnas) */
        .two-columns {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* Dos columnas iguales */
            gap: 20px;
            width: 100%;
        }
        
        .field-block {
            display: flex;
            flex-direction: column;
        }

        .field-block h3 {
            font-size: 0.95rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }

        .required {
            color: #dc3545;
        }

        /* Estilos de input (tomados de tu código) */
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            box-sizing: border-box;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--tone-2);
            box-shadow: 0 0 0 3px rgba(52, 73, 94, 0.1); /* Sombra basada en tone-1 */
        }
        
        /* Contenedor de Botón (Alineación a la derecha) */
        .buttons-bottom-container {
            width: 100%;
            display: flex;
            justify-content: flex-end; /* Alineación a la derecha */
            margin-top: 25px;
            padding: 15px 0;
        }

        /* Botón principal (Generar) */
        .theme-scope .btn-wd {
            background: var(--tone-1); /* Usamos el azul oscuro para el botón principal */
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: .15s;
            box-shadow: 0 2px 4px rgba(0,0,0,.15);
            text-decoration: none;
        }

        .theme-scope .btn-wd:hover {
            filter: brightness(1.1);
            color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="theme-reportes">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>
                <div class="container row">
                    <div class="col-md-6 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <h2>Generación de Reportes</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                </div>

                <div class="section-container">
                    
                    <div class="subsection">
                        <h3>📈 Reporte de Margen de Ganancia Bruto</h3>
                        <p style="color:#777; font-size:13px; margin-bottom:15px;">Filtre la información para generar el reporte detallado. Todos los filtros son opcionales.</p>

                        <div class="two-columns">
                            <div class="field-block">
                                <h3>Período de Tiempo (Opcional)</h3>
                                <div style="display:flex; gap:15px;">
                                    <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date" placeholder="Fecha Inicio"></asp:TextBox>
                                    <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date" placeholder="Fecha Fin"></asp:TextBox>
                                </div>
                                </div>

                            <div class="field-block">
                                <h3>Filtros Adicionales (Opcionales)</h3>
                                <div style="display:flex; flex-direction:column; gap:8px;">
                                    <asp:TextBox ID="txtFiltroProducto" runat="server" CssClass="form-control" placeholder="Nombre del Producto"></asp:TextBox>
                                    <asp:TextBox ID="txtFiltroLinea" runat="server" CssClass="form-control" placeholder="Línea de Ropa (ej. Pantalon)"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="buttons-bottom-container">
                            <asp:Button ID="btnGenerarMargenPDF" runat="server"
                                Text="Generar PDF"
                                CssClass="btn-wd"
                                OnClick="btnGenerarMargenPDF_Click" />
                        </div>
                    </div>
                    <!-- 🔹 Reporte de Ventas por Prenda -->
                    <div class="subsection">
                        <h3>🧾 Reporte de Ventas por Prenda</h3>
                        <p style="color: #777; font-size: 13px; margin-bottom: 15px;">
                            Seleccione el tipo de período y la fecha base para generar el reporte de ventas por prenda.
                        </p>

                        <div class="two-columns">
                            <!-- Columna 1: Tipo de período -->
                            <div class="field-block">
                                <h3>Tipo de Período <span class="required">(*)</span></h3>
                                <asp:DropDownList ID="ddlTipoPeriodoVP" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Mensual" Value="MENSUAL" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Semanal" Value="SEMANAL"></asp:ListItem>
                                    <asp:ListItem Text="Diario" Value="DIARIO"></asp:ListItem>
                                </asp:DropDownList>

                                <h3 style="margin-top: 14px;">Empleado solicitante</h3>
                                <asp:Label ID="lblEmpleadoVP" runat="server" CssClass="form-control" />
                            </div>

                            <!-- Columna 2: Parámetros según el tipo de período -->
                            <div class="field-block">
                                <h3>Parámetros de Fecha <span class="required">(*)</span></h3>

                                <!-- Para MENSUAL: mes y año -->
                                <div style="margin-bottom: 8px;">
                                    <span style="font-size: 12px; color: #555;">Si el período es mensual, seleccione mes y año:</span>
                                    <div style="display: flex; gap: 10px; margin-top: 5px;">
                                        <asp:DropDownList ID="ddlMesVP" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Enero" Value="1" />
                                            <asp:ListItem Text="Febrero" Value="2" />
                                            <asp:ListItem Text="Marzo" Value="3" />
                                            <asp:ListItem Text="Abril" Value="4" />
                                            <asp:ListItem Text="Mayo" Value="5" />
                                            <asp:ListItem Text="Junio" Value="6" />
                                            <asp:ListItem Text="Julio" Value="7" />
                                            <asp:ListItem Text="Agosto" Value="8" />
                                            <asp:ListItem Text="Setiembre" Value="9" />
                                            <asp:ListItem Text="Octubre" Value="10" />
                                            <asp:ListItem Text="Noviembre" Value="11" />
                                            <asp:ListItem Text="Diciembre" Value="12" />
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtAnioVP" runat="server" CssClass="form-control" placeholder="Año (ej. 2025)"></asp:TextBox>
                                    </div>
                                </div>

                                <!-- Para DIARIO / SEMANAL: un solo día -->
                                <div>
                                    <span style="font-size: 12px; color: #555;">Si el período es diario o semanal, seleccione el día base:
                                    </span>
                                    <asp:TextBox ID="txtFechaDiaVP" runat="server" CssClass="form-control"
                                        TextMode="Date" placeholder="Seleccione una fecha"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="buttons-bottom-container">
                            <asp:Button ID="btnGenerarVentasPrendaPDF" runat="server"
                                Text="Generar PDF"
                                CssClass="btn-wd"
                                OnClick="btnGenerarVentasPrendaPDF_Click" />
                        </div>
                </div>
                

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
                function GenerarReportePDF() {
                    var fechaInicio = document.getElementById('<%= txtFechaInicio.ClientID %>').value.trim();
            var fechaFin = document.getElementById('<%= txtFechaFin.ClientID %>').value.trim();
            var producto = document.getElementById('<%= txtFiltroProducto.ClientID %>').value.trim();
            var linea = document.getElementById('<%= txtFiltroLinea.ClientID %>').value.trim();

            if (fechaInicio === '' || fechaFin === '') {
                alert('Debe ingresar el Período de Tiempo (Fecha Inicio y Fecha Fin).');
                return false;
            }

            // 🔹 CAMBIA AQUÍ: URL completa al servidor Java
            var servletUrl = "http://localhost:8080/WearDropWS/ReporteMargenGanancias";

            var params = [];
            params.push("fechaInicio=" + encodeURIComponent(fechaInicio));
            params.push("fechaFin=" + encodeURIComponent(fechaFin));

            if (producto) {
                params.push("producto=" + encodeURIComponent(producto));
            }
            if (linea) {
                params.push("linea=" + encodeURIComponent(linea));
            }

            var fullUrl = servletUrl + "?" + params.join("&");
            window.open(fullUrl, '_blank');

            return false;
        }
    </script>
</asp:Content>