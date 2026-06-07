<%@ Page Title="Inicio - WearDrop" Language="C#" MasterPageFile="~/WearDrop1.Master" 
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WearDropWA.Home" %>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        /* --- ESTILOS DEL DASHBOARD (Retail Edition) --- */
        .dashboard-container {
            padding: 30px;
            background-color: #f4f6f9; /* Fondo gris muy suave */
            min-height: 90vh;
        }

        /* Banner de Bienvenida */
        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 40px;
            color: white;
            box-shadow: 0 10px 25px rgba(118, 75, 162, 0.25);
            margin-bottom: 35px;
            position: relative;
            overflow: hidden;
        }
        
        .welcome-text h2 { font-weight: 800; margin-bottom: 8px; letter-spacing: -0.5px; }
        .welcome-text p { opacity: 0.95; font-size: 1.1rem; font-weight: 400; }
        
        /* Decoración de fondo (Perchas/Ropa) */
        .banner-decoration {
            position: absolute;
            right: -20px;
            bottom: -40px;
            font-size: 180px;
            opacity: 0.12;
            color: white;
            transform: rotate(-10deg);
        }

        /* Tarjetas de Estadísticas (KPIs) */
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            transition: all 0.3s ease;
            border-bottom: 4px solid transparent; /* Borde abajo en vez de izquierda */
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        }

        .stat-info h3 { font-size: 32px; font-weight: 800; color: #2d3748; margin: 0; line-height: 1.2; }
        .stat-info p { color: #718096; margin-top: 5px; font-size: 13px; text-transform: uppercase; letter-spacing: 0.8px; font-weight: 700; }

        .stat-icon-wrapper {
            width: 64px; height: 64px;
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px;
        }
        
        /* Colores Temáticos */
        .theme-sales { border-bottom-color: #48bb78; } /* Verde Ventas */
        .icon-sales { background-color: #f0fff4; color: #38a169; }

        .theme-stock { border-bottom-color: #ed8936; } /* Naranja Alerta Stock */
        .icon-stock { background-color: #fffaf0; color: #dd6b20; }

        .theme-inventory { border-bottom-color: #4299e1; } /* Azul Inventario */
        .icon-inventory { background-color: #ebf8ff; color: #3182ce; }

        .theme-money { border-bottom-color: #9f7aea; } /* Morado Dinero */
        .icon-money { background-color: #faf5ff; color: #805ad5; }

        /* Títulos de Sección */
        .section-header {
            display: flex; align-items: center; margin-bottom: 20px; margin-top: 10px;
        }
        .section-title {
            font-size: 1.25rem; font-weight: 700; color: #1a202c; margin: 0;
        }
        .section-line {
            flex-grow: 1; height: 2px; background-color: #e2e8f0; margin-left: 15px; border-radius: 2px;
        }

        /* Botones de Acción Rápida */
        .action-card {
            background: white;
            border-radius: 16px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            color: #4a5568;
            display: block;
            border: 1px solid #edf2f7;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .action-card:hover {
            border-color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.15);
        }

        .action-icon {
            font-size: 36px; margin-bottom: 15px; color: #667eea; transition: transform 0.3s;
        }
        .action-card:hover .action-icon { transform: scale(1.1); }
        
        .action-title { font-weight: 700; font-size: 16px; display: block; margin-bottom: 5px; }
        .action-desc { font-size: 12px; color: #a0aec0; display: block; }

    </style>

    <div class="dashboard-container">
        
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Hola, <asp:Label ID="lblUsuario" runat="server" Text="Jefe de Tienda"></asp:Label> 👋</h2>
                <p>Listo para administrar tu tienda. Aquí está el resumen de movimientos de hoy.</p>
                <p style="font-size: 13px; margin-top: 12px; opacity: 0.8;">
                    <i class="far fa-calendar-alt me-2"></i> <asp:Label ID="lblFecha" runat="server"></asp:Label>
                </p>
            </div>
            <div class="banner-decoration">
                <i class="fas fa-store"></i> </div>
        </div>

        <div class="row mb-5 g-4"> <div class="col-12 col-md-6 col-xl-3">
                
            </div>

            <div class="col-12 col-md-6 col-xl-3">
                
            </div>

            <div class="col-12 col-md-6 col-xl-3">
                
            </div>

            <div class="col-12 col-md-6 col-xl-3">
                
            </div>
        </div>

        <div class="section-header">
            <h4 class="section-title">Operaciones Frecuentes</h4>
            <div class="section-line"></div>
        </div>

        <div class="row g-3">
            <div class="col-6 col-md-3">
                <a runat="server" id="lnkNuevaVenta" href="AnnadirProductoVenta.aspx" class="action-card">
                    <i class="fas fa-cart-plus action-icon"></i>
                    <span class="action-title">Nueva Venta</span>
                    <span class="action-desc">Registrar salida de ropa</span>
                </a>
            </div>

            <div class="col-6 col-md-3">
                <a runat="server" id="lnkRecibir" href="AnnadirLineaDeLaCompra.aspx" class="action-card">
                    <i class="fas fa-truck-loading action-icon"></i>
                    <span class="action-title">Recibir Mercadería</span>
                    <span class="action-desc">Ingreso de proveedores</span>
                </a>
            </div>

            <div class="col-6 col-md-3">
                <a href="GestionarPrendas.aspx" class="action-card">
                    <i class="fas fa-shirt action-icon"></i>
                    <span class="action-title">Catálogo</span>
                    <span class="action-desc">Ver modelos y tallas</span>
                </a>
            </div>

            <div class="col-6 col-md-3">
                <a href="GenerarReportes.aspx" class="action-card">
                    <i class="fas fa-chart-pie action-icon"></i>
                    <span class="action-title">Balance</span>
                    <span class="action-desc">Ver ganancias y stock</span>
                </a>
            </div>
        </div>

    </div>

</asp:Content>