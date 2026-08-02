<h1 align="center">Mi Portafolio de Ingeniería Informática</h1>

---

## Sobre Mí

Soy un apasionado de la ingeniería informática con un enfoque que abarca **desde la memoria y los punteros en C/C++ hasta la arquitectura empresarial con Java y el análisis de datos con Power BI**. 

Mi formación en pregrado me ha dado una base sólida en ciencias de la computación, pero mi interés es la **curiosidad por construir sistemas robustos, eficientes y que resuelvan problemas del mundo real**.

Este repositorio centraliza tres líneas de trabajo principales:

1.  **Fundamentos de Sistemas** (Algoritmos y Estructuras de Datos en C/C++).
2.  **Desarrollo Empresarial** (Sistema transaccional con Java + Dashboard BI).
3.  **Trabajo Colaborativo** (Proyecto grupal WearDrop).

---

## Navegación Principal del repositorio

### Programas Independientes (C / C++) - *Fundamentos Sólidos*

Esta sección trata sobre algoritmos, estructuras de datos y elementos útiles que he aprendido durante mi pregrado de mi carrera. Aquí subo mis implementaciones puras de **Ciencias de la Computación** para demostrar que entiendo cómo funciona realmente una máquina, más allá de los frameworks modernos.

**¿Qué encontrarás aquí?**
- **Estructuras de Datos:** Implementaciones manuales de árboles binarios, grafos, listas enlazadas, pilas, colas y tablas hash en C++.
- **Algoritmos Avanzados:** Algunos algoritmos GRASP, Voraz y Backtracking para resolver problemas de optimización.
- **Programación en Bajo Nivel:** Pequeños scripts en C y ejecutados en entorno Linux, demostrando manejo de memoria, punteros y llamadas al sistema (syscalls). Además se muestra sobre el conocimiento de concurrencia entre hilos y procesos.

---

### Proyecto Propio: SIV-Tienda (Java + C# + Power BI) - *Visión Empresarial*

**SIV-Tienda** es mi proyecto propio de desarrollo de software. Es un sistema integral de gestión de inventario, compras a proveedores y sobre ventas para el rubro textil, construido con una **arquitectura moderna y políglota**.

**Características técnicas destacadas:**
- **Backend:** Java 21 con Spring Boot 3, siguiendo una **Arquitectura Hexagonal (Puertos y Adaptadores)** para aislar la lógica de negocio.
- **Frontend (UI):** C# con Blazor Server (.NET 8), consumiendo la API vía un cliente HTTP tipado generado automáticamente con NSwag a partir del contrato OpenAPI/Swagger del backend.
- **Base de Datos:** PostgreSQL 16, con un modelo relacional optimizado.
- **Inteligencia de Negocios (BI):** Gráficos interactivo y tablas en **Power BI** conectado directamente a la BD, mostrando KPIs de stock crítico.
- **Bonus :** Integración con un script en Python para seeding de datos.
- **Despligue:** Se piensa usar Docker (Aún no realizado)
---

### Proyecto Grupal: WearDrop - *Trabajo en Equipo y Metodologías Ágiles*

**WearDrop** es un sistema web transaccional desarrollado en colaboración con un equipo de compañeros de la universidad como parte del curso de **Programación 3**. En este proyecto se debió trabajar sobre un entorno colaborativo, manejar Git y aplicar metodologías ágiles en un contexto académico con entregables progresivos.

**Enfoque del proyecto:**
El sistema está orientado a la **gestión integral de una tienda de ropa ubicada en el Emporio Comercial de Gamarra (Lima)**, un entorno de negocio caracterizado por su alta rotación de productos, ventas por mayor y menor, y una constante renovación de inventario. 

El proyecto aborda la problemática real de la falta de digitalización en este tipo de comercios, automatizando procesos clave que tradicionalmente se realizaban de forma manual o empírica:

- **Registro de Ventas** con emisión de comprobantes electrónicos (boletas, facturas, notas de crédito/débito).
- **Control de Compras a Proveedores**, incluyendo el manejo de deudas y lotes de inventario.
- **Gestión de Stock en tiempo real**, con actualizaciones automáticas por cada venta o entrada de mercadería.
- **Módulo de Devoluciones** (de clientes y hacia proveedores por productos defectuosos).
- **Generación de Reportes Estratégicos** (productos más vendidos, márgenes de ganancia, y estadísticas por períodos).

**Stack Tecnológico utilizado:**
- **Backend:** Java (lógica de negocio y persistencia).
- **Frontend:** C# (interfaz web).
- **Base de Datos:** MySQL.
- **Comunicación:** Servicios web SOAP (arquitectura cliente–servidor).

**Mis contribuciones en este proyecto:**
1. **Implementación de requisitos**
Realice al completo los siguientes requisitos:
RF6: El sistema deberá registrar, modificar y mostrar un almacén que utiliza la tienda para guardar sus productos.

RF9: El sistema debe registrar un historial completo de todos los movimientos de inventario (entradas, salidas, devoluciones) con fecha, hora y el usuario responsable por Almacén. Permite revertir un cambio incorrecto si es necesario.

Y realice la sección de sobre Lote de Inventario sobre este requisito:
RF7:  El software deberá permitir asignar un número de lote de inventario en grupo recibido de un proveedor, para facilitar la búsqueda y organización del inventario. (Un "lote" es un conjunto de productos que llegan juntos en una misma compra. El sistema debe permitir que, al registrar la entrada de mercadería, se genere o asigne un identificador único (número de lote) a ese grupo.)

2. **BackEnd y FrontEnd completa sobre el package Almacen**
He aportado al proyecto sobre la implementación completa sobre el lado de los Almacenes: Esto incluye el BackEnd (Clases, DAO's, Business, Web o SOAP, Procedures guardados en la Base de Datos, Creación de Tablas de Almacen, MovimientoAlmacen, Lotes, MovimientoAlmacenXLotes), FrontEnd (Páginas Web y Programación de la página en C#)

3. **Software Despliegue en un servidor AWS**
Una vez con el software realizado. Me encargue del despliegue de la aplicación en un servidor AWS con cuentas de AWS academy que se nos habian otorgado para el curso. El despligue del BackEnd y FrontEnd fue en un mismo servidor. Donde se tuvo que realizar las configuraciones necesarias para que el servidor pueda soportar y desplegar la aplicación. (El manual de despliegue tambien se adjunta en este repositorio)

---

## Habilidades Técnicas Globales

| Categoría | Tecnologías / Herramientas |
| :--- | :--- |
| **Lenguajes (Alto y Bajo Nivel)** | C, C++, Java, C#, Python |
| **Frameworks y Plataformas** | Spring Boot 3, .NET 8 (Blazor), JPA/Hibernate |
| **Bases de Datos** | PostgreSQL y MySQL|
| **BI y Analítica** | Power BI (DAX, Modelado Estrella) |
| **Herramientas y DevOps** | Git, GitHub Actions (CI/CD), Docker, Linux (Bash/Sh) |
| **Metodologías** | Arquitectura Hexagonal, TDD |

---

##  ¿Qué estoy buscando?

Estoy en la búsqueda de una experiencia profesional en el área de desarrollo de software. Me interesan particularmente los roles donde pueda aportar tanto a nivel de **arquitectura de sistemas** (Backend o Frontend) como en la **optimización de rendimiento**, sin dejar de lado el análisis de datos para la toma de decisiones.

**Contáctame:**
- **LinkedIn:** [linkedin.com/in/tu-perfil](https://www.linkedin.com/in/leonardo-julio-tueros-rodriguez-a845b7342/).
- **Correo:** leonardotr07@gmail.com
