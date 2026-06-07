<%@ Page Title="Gestionar Descuentos" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarDescuentos.aspx.cs" Inherits="WearDropWA.GestionarDescuentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Seleccionar Tipo de Descuento a  Gestionar:
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
            background-color: #C5D9C0; /* Verde suave */
            flex: 1.5;
        }

        
        .bar-2 {
            background-color: #95B88F;
            flex: 1.5;
        }
          .selection-container {
            margin-top: 30px;
            padding: 20px;
            border: 3px solid #4CAF50; /* Borde grueso verde */
            border-radius: 8px; /* Bordes redondeados */
            background-color: #F1F9F1; /* Fondo suave */
            text-align: center;
        }
            .selection-container h3 {
            font-size: 1.5rem;
            font-weight: bold;
            color: #4CAF50; /* Verde */
            margin: 0;
        }

        /* Contenedor de botones */
       /* .button-container {
            display: flex;
            gap: 30px;  Aumentamos el espacio entre los botones 
            justify-content: center;
            margin-top: 50px;
        }

         Estilo para los botones 
        .promo-button {
            padding: 20px 40px;   Hacemos los botones más grandes 
            font-size: 1.5rem;     Aumentamos el tamaño del texto 
            border: 2px solid transparent;
            border-radius: 12px;   Bordes redondeados 
            cursor: pointer;
            text-align: center;
            width: 250px;  Asegura que todos los botones tengan el mismo tamaño 
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s ease-in-out;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            opacity: 1;   Aseguramos que los botones sean totalmente opacos 
        }

        .promo-button:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);  Sombra suave al pasar el cursor 
        }

         Colores de los botones 
        .green {
            background-color: #4CAF50;  Verde más brillante 
            border-color: #4CAF50;  Color de borde 
        }

        .blue {
            background-color: #5fa7db;  Azul suave 
            border-color: #5fa7db;  Color de borde 
        }

        .soft-red {
            background-color: #ff6f61;  Rojo suave 
            border-color: #ff6f61;  Color de borde 
        }

         Asegurarse de que el texto esté bien centrado 
        .promo-button i {
            margin-right: 10px;  Espacio entre el icono y el texto 
        }*/
       :root {
            --container-width: 860px;
            --grid-gap: 22px;
            --card-height: 84px;
            --card-padding-y: 12px;
            --card-padding-x: 16px;
            --frame-radius: 14px;
            --card-radius: 5px;
            --frame-green: #9DBD9B;
            --frame-blue:  #9FB6C8;
            --frame-pink:  #C99298;
            --frame-lilac: #B4A6D6;
            --frame-teal:  #9AC5BE;
            --frame-yellow: #EDE28A;
            --frame-light-pink: #C5A0B0;
        }

        .promo-button {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 40px;
            font-size: 1.5rem;
            border-radius: 12px;
            border: 2px solid transparent;
            cursor: pointer;
            width: 250px;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s ease-in-out;
            text-align: center;
        }

        .promo-button i {
            margin-right: 10px;
        }

        .promo-button .inner {
            background-color: white;
            padding: 12px 30px;
            border-radius: 10px;
            color: #333;
        }

        .promo-button:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .green {
            background-color: #9DBD9B;
            border-color: #9DBD9B;
        }

        .blue {
            background-color: #9FB6C8;
            border-color: #9FB6C8;
        }

        .soft-red {
            background-color: #C99298;
            border-color: #C99298;
        }

        .button-container {
            display: flex;
            gap: 30px;
            justify-content: center;
            margin-top: 50px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="container row">
            <div class="row align-items-center">
                <!-- Título de la página con barras decorativas -->
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Seleccionar el Tipo de Descuento a Gestionar: </h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contenedor de los botones de descuento -->
        <div class="container row mt-4">
            <div class="button-container">
               <%--<button id="btnLiquidacion" runat="server" onserverclick="btnLiquidacion_ServerClick" class="promo-button green">
                <i class="fa-solid fa-tags"></i><span>LIQUIDACIÓN</span>
                </button>

                <button id="btnPorcentaje" runat="server" onserverclick="btnPorcentaje_ServerClick" class="promo-button blue">
                <i class="fa-solid fa-percent"></i><span>PORCENTAJE</span>
                  </button>

                <button id="btnMonto" runat="server" onserverclick="btnMonto_ServerClick" class="promo-button soft-red">
                  <i class="fa-solid fa-dollar-sign"></i><span>MONTO</span>
                </button>--%>
                <button id="btnLiquidacion" runat="server" onserverclick="btnLiquidacion_ServerClick" class="promo-button green">
                    <div class="inner"><i class="fa-solid fa-tags"></i><span>LIQUIDACIÓN</span   ></div>
                </button>

                <button id="btnPorcentaje" runat="server" onserverclick="btnPorcentaje_ServerClick" class="promo-button blue">
                    <div class="inner"><i class="fa-solid fa-percent"></i><span>PORCENTAJE</span></div>
                </button>

                <button id="btnMonto" runat="server" onserverclick="btnMonto_ServerClick" class="promo-button soft-red">
                    <div class="inner"><i class="fa-solid fa-dollar-sign"></i><span>MONTO</span></div>
                </button>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
