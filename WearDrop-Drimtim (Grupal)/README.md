# WearDrop - Sistema de Gestión para Tienda de Ropa

> *"Automatización de procesos transaccionales para el Emporio Comercial de Gamarra"*

---
## Colaboradores

Proyecto desarrollado por un equipo de 6 estudiantes de la PUCP como parte del curso de Programación 3. Cada miembro contribuyó en diferentes módulos del sistema como por ejemplo: descuentos, promociones, ventas, productos, etc. Siguiendo metodologías ágiles y buenas prácticas de trabajo colaborativo.

Mi aporte respecto a este proyecto académico fue todo lo relacionado con el package Almacen en donde se trabajan con las clases Almacen, MovimientoAlmacen, Lotes, MovimientoAlmacenXLote y AlmacenXMovimientoAlmacen (tanto Front como Back). Además fui el encargado de desplegar la aplicación mediante un servidor en AWS en donde se configuro todo lo necesario.

## Descripción del Proyecto

**WearDrop** es un sistema web transaccional desarrollado en colaboración con un equipo de compañeros de la universidad. El proyecto aborda la problemática real de la falta de digitalización en las tiendas de ropa del **Emporio Comercial de Gamarra (Lima)**, un entorno de negocio caracterizado por su alta rotación de productos, ventas por mayor y menor, y una constante renovación de inventario.

**El sistema automatiza procesos clave** que tradicionalmente se realizaban de forma manual o empírica:
- Registro de Ventas con emisión de comprobantes electrónicos.
- Control de Compras a Proveedores y gestión de deudas.
- Gestión de Stock en tiempo real con actualizaciones automáticas.
- Módulo de Devoluciones y control de lotes de inventario.
- Generación de Reportes Estratégicos para la toma de decisiones.

---

## Stack Tecnológico

| Capa / Componente | Tecnología | Versión |
| :--- | :--- | :--- |
| **Backend (Lógica de negocio)** | Java (JAX-WS) | Java 8+ |
| **Frontend (Interfaz web)** | C# (.NET Framework / ASP.NET) | .NET 4.5+ |
| **Base de Datos** | MySQL | 5.7+ |
| **Comunicación** | Servicios Web SOAP |
| **Arquitectura** | Cliente–Servidor / Monolítica por capas | - |

---

### Requisitos Funcionales (RF)

| ID | Descripción | Prioridad |
| :--- | :--- | :--- |
| **RF1** | El sistema deberá permitir al usuario ingresar al sistema identificándose como administrador o vendedor de la tienda. Para ingresar necesitará introducir una contraseña. Además podrán recuperar su contraseña mediante una solicitud de cambio mediante su correo electrónico. | 1 |
| **RF2** | El sistema debe registrar, modificar, mostrar y eliminar a una cuenta de usuario. Este debe tener: ID Cuenta, nombre de cuenta, contraseña, correo, estado de la cuenta. | 1 |
| **RF3** | El sistema web permitirá a los comerciantes registrar, modificar, eliminar y consultar las prendas (por ejemplo: polos, jeans, casacas, faldas, pantalones, gorros, blusas y vestidos) asociadas a su negocio, asegurando que cada línea esté organizada para facilitar la gestión de ventas. | 1 |
| **RF4** | El sistema permitirá registrar, modificar, visualizar proveedores colocando su ID, Nombre, Teléfono, Correo, Dirección, Estado, Condición de pago, RUC. | 2 |
| **RF5** | El sistema deberá registrar, modificar y mostrar un almacén que utiliza la tienda para guardar sus productos. | 2 |
| **RF6** | El sistema web permitirá registrar y consultar las compras realizadas a proveedores, incluyendo el detalle de productos adquiridos, montos pagados y deudas pendientes, con el fin de mantener un control de abastecimiento y obligaciones financieras. | 1 |
| **RF7** | El software deberá permitir asignar un número de lote de inventario en grupo recibido de un proveedor, para facilitar la búsqueda y organización del inventario. | 1 |
| **RF8** | El sistema deberá permitir la devolución del inventario a los proveedores en caso de que el lote de productos recibidos estén dañados. | 3 |
| **RF9** | El sistema debe registrar un historial completo de todos los movimientos de inventario (entradas, salidas, devoluciones) con fecha, hora y el usuario responsable por Almacén. Permite revertir un cambio incorrecto si es necesario. | 1 |
| **RF10** | El sistema web permitirá registrar, modificar, visualizar y eliminar promociones y descuentos y visualizar los descuentos y promociones de una prenda, y a la hora de registrar, añadirle su vigencia de la promoción o descuento. | 2 |
| **RF11** | El sistema web permitirá registrar datos básicos de los clientes (nombre, número de contacto, historial de compras) para implementar estrategias de fidelización y facilitar la comunicación de promociones. | 2 |
| **RF12** | El sistema debe permitir a los usuarios registrar las ventas de productos a los clientes. Cada venta debe incluir detalles como los productos adquiridos, las cantidades, los precios, el método de pago, el monto total pagado y el documento de boleta o factura generado por la venta. El sistema también debe permitir la consulta de las ventas realizadas, con la posibilidad de buscar y filtrar por fecha o número de boleta. | 1 |
| **RF13** | El sistema deberá generar comprobantes de pago (boletas, notas de crédito, notas de débito y facturas). Deberá almacenar: Fecha de emisión, monto, RUC, razón social, IGV, forma de pago. | 1 |
| **RF14** | El sistema deberá diferenciar entre clientes que compran por menor y por mayor, registrando esta información para aplicar precios diferenciados y reconocer a los clientes con mayor volumen de compras. | 2 |
| **RF15** | El sistema web permitirá a los comerciantes registrar, modificar y consultar el stock de cada prenda, actualizándose automáticamente con cada venta realizada y con cada nueva entrada de mercadería, además de generar alertas cuando un producto llegue a su último stock disponible, evitando quiebres de inventario y facilitando la reposición oportuna. | 1 |
| **RF16** | El sistema deberá mostrar un listado de las prendas más vendidas y las menos vendidas, basado en las ventas registradas. Este listado se actualizará automáticamente y permitirá al usuario visualizar las prendas con mayor y menor demanda en tiempo real. | 3 |
| **RF17** | El sistema web generará reportes automáticos de ventas en períodos seleccionados (diario, semanal, mensual), mostrando estadísticas como productos más vendidos. | 1 |
| **RF18** | El sistema debe permitir a los usuarios generar un reporte detallado del margen de ganancia bruto. Este reporte mostrará los ingresos totales por ventas, el costo de la mercancía vendida, la ganancia bruta y el margen bruto (%). El usuario podrá filtrar la información para generar el reporte basado en un producto específico, una línea de ropa y un período de tiempo definido. | 1 |

### Requisitos No Funcionales (RNF)

| ID | Descripción | Prioridad |
| :--- | :--- | :--- |
| **RNF1** | El sistema deberá ofrecer una interfaz intuitiva, de fácil uso y con navegación clara, de manera que los comerciantes puedan registrar ventas, consultar inventario y aplicar precios sin requerir conocimientos técnicos avanzados. | 2 |
| **RNF2** | El sistema deberá garantizar la seguridad de la información mediante autenticación de usuario con credenciales únicas y cifrado de datos sensibles (como contraseñas y registros financieros), evitando accesos no autorizados. | 1 |
| **RNF3** | El sistema debe realizar cada operación (registrar ventas, consultar inventario y aplicar precios) en un promedio de 10 segundos. | 1 |
| **RNF4** | La página debe ser compatible con los navegadores más comunes, como Google Chrome y Mozilla Firefox. | 3 |
| **RNF5** | El software deberá ser modular y estar diseñado siguiendo principios de arquitectura limpia y buenas prácticas de programación, de manera que permita incorporar nuevas funcionalidades y corregir errores en un tiempo no mayor a 5 horas por módulo. | 2 |
| **RNF6** | El sistema deberá contar con un mecanismo de respaldo y recuperación automática de datos, de manera que, ante una caída del sistema o pérdida de conexión, la información registrada se conserve íntegra y pueda ser restaurada sin afectar las operaciones del negocio. | 1 |

---

| Tipo | Total | Prioridad Alta (1) | Prioridad Media (2) | Prioridad Baja (3) |
| :--- | :--- | :--- | :--- | :--- |
| **Funcionales (RF)** | 18 | 12 | 5 | 2 |
| **No Funcionales (RNF)** | 6 | 3 | 2 | 1 |
| **Total** | **24** | **15** | **7** | **3** |

## Arquitectura del Sistema

El sistema sigue una **arquitectura cliente–servidor** con una **comunicación basada en servicios web SOAP**:

```plaintext
[ Cliente (C# / ASP.NET) ]
         (SOAP / XML)
[ Servidor (Java / JAX-WS) ]
         (JDBC)
[ Base de Datos (MySQL) ]
