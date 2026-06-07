-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: weardrop-drimtim.chyrb2lrl41c.us-east-1.rds.amazonaws.com    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Almacen`
--

DROP TABLE IF EXISTS `Almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Almacen` (
  `idAlmacen` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) DEFAULT NULL,
  `ubicacion` varchar(70) DEFAULT NULL,
  `Tienda_idTienda` int NOT NULL,
  `Activo` tinyint NOT NULL,
  PRIMARY KEY (`idAlmacen`),
  KEY `fk_Almacen_Tienda1_idx` (`Tienda_idTienda`),
  CONSTRAINT `fk_Almacen_Tienda1` FOREIGN KEY (`Tienda_idTienda`) REFERENCES `Tienda` (`idTienda`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Almacen`
--

LOCK TABLES `Almacen` WRITE;
/*!40000 ALTER TABLE `Almacen` DISABLE KEYS */;
INSERT INTO `Almacen` VALUES (1,'Depósito Master 401','Galería Generales, 4to Piso, Puesto 401',1,1),(2,'Almacén Jean Sotano','Galería Plaza Horizonte (Jean), Sótano 1, Local C12',1,1),(3,'Puesto Reserva 103A','Galería Guizado, 1er Piso, Pasillo Trasero 103A',1,1),(4,'Local Auxiliar Bazo','Jr. Antonio Bazo 980, Cochera #5 (Volumen de tela)',1,1),(5,'Stock Antiguo 505','Galería Santa Lucía, 5to Piso, Oficina 505',1,1),(6,'Almacen De Prueba 4','Ubicacion de Prueba 4',1,0),(7,'Prueba 2','Prueba',1,0),(8,'Almacen de Prueba 5','Ubicacion de Prueba',1,0),(9,'Almacen de Prueba 9','Ubicacion de Prueba 10',1,0),(10,'Almacen  drimtim 4','Av.  Gamarra 128',1,0),(11,'Almacen Paz','Av. Paz',1,1);
/*!40000 ALTER TABLE `Almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Blusa`
--

DROP TABLE IF EXISTS `Blusa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Blusa` (
  `idPrenda` int NOT NULL,
  `tipo_blusa` enum('Camisera','CropTop','Peplum','OffShoulder','Transparente','Formal','Casual') NOT NULL,
  `tipo_manga` enum('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos') NOT NULL,
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Blusa_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Blusa`
--

LOCK TABLES `Blusa` WRITE;
/*!40000 ALTER TABLE `Blusa` DISABLE KEYS */;
INSERT INTO `Blusa` VALUES (2,'Camisera','MangaLarga'),(9,'Casual','MangaCorta'),(10,'Formal','MangaLarga'),(39,'Formal','SinManga');
/*!40000 ALTER TABLE `Blusa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Boleta`
--

DROP TABLE IF EXISTS `Boleta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Boleta` (
  `idComprobante` int NOT NULL,
  `DNI` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`idComprobante`),
  CONSTRAINT `Boleta_ibfk_1` FOREIGN KEY (`idComprobante`) REFERENCES `ComprobanteDePago` (`idComprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Boleta`
--

LOCK TABLES `Boleta` WRITE;
/*!40000 ALTER TABLE `Boleta` DISABLE KEYS */;
INSERT INTO `Boleta` VALUES (8,'77665533'),(12,'02133123'),(16,'77777777'),(17,'2828123'),(18,'73100016'),(19,'12345539'),(20,'73100014'),(24,'73100015'),(25,'73100016'),(26,'73100016'),(27,'72804145'),(28,'73100016'),(29,'73100016'),(30,'12345539'),(31,'73100016'),(32,'73100015'),(33,'73100011'),(34,'72889228');
/*!40000 ALTER TABLE `Boleta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cargo`
--

DROP TABLE IF EXISTS `Cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cargo` (
  `idCargo` int NOT NULL AUTO_INCREMENT,
  `abreviatura` char(1) DEFAULT NULL,
  `descripcion` varchar(75) DEFAULT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cargo`
--

LOCK TABLES `Cargo` WRITE;
/*!40000 ALTER TABLE `Cargo` DISABLE KEYS */;
INSERT INTO `Cargo` VALUES (1,'G','Gerente General',1),(2,'S','Supervisor de Ventas',1),(3,'A','Asistente Administrativo',1),(4,'C','Contador',1),(5,'T','Técnico de Mantenimiento',1),(9,'X','Auxiliar',1);
/*!40000 ALTER TABLE `Cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Casaca`
--

DROP TABLE IF EXISTS `Casaca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Casaca` (
  `idPrenda` int NOT NULL,
  `tipo_casaca` enum('Bomber','Puffer','Denim','Deportiva','Cuero','Cardigan','Otro') NOT NULL,
  `con_capucha` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Casaca_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Casaca`
--

LOCK TABLES `Casaca` WRITE;
/*!40000 ALTER TABLE `Casaca` DISABLE KEYS */;
INSERT INTO `Casaca` VALUES (3,'Denim',0),(11,'Otro',0),(12,'Otro',1),(38,'Cardigan',0),(102,'Puffer',1);
/*!40000 ALTER TABLE `Casaca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `idCliente` int NOT NULL,
  `tipoCliente` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`idCliente`),
  KEY `fk_Cliente_Persona10_idx` (`idCliente`),
  KEY `fk_Cliente_tipoCliente10_idx` (`tipoCliente`),
  CONSTRAINT `fk_Cliente_Persona10` FOREIGN KEY (`idCliente`) REFERENCES `Persona` (`idPersona`),
  CONSTRAINT `fk_Cliente_tipoCliente10` FOREIGN KEY (`tipoCliente`) REFERENCES `TipoDeCliente` (`tipoCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (20,6,1),(21,6,1),(22,6,0),(23,6,0),(24,7,1),(25,6,1),(26,7,0),(27,7,1),(28,7,0),(29,7,1),(40,6,1),(52,7,1);
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ComprobanteDePago`
--

DROP TABLE IF EXISTS `ComprobanteDePago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ComprobanteDePago` (
  `idComprobante` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `total` double DEFAULT NULL,
  `IGV` double DEFAULT NULL,
  `metodoDePago` varchar(45) DEFAULT NULL,
  `correlativo` varchar(45) DEFAULT NULL,
  `activa` tinyint DEFAULT NULL,
  PRIMARY KEY (`idComprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ComprobanteDePago`
--

LOCK TABLES `ComprobanteDePago` WRITE;
/*!40000 ALTER TABLE `ComprobanteDePago` DISABLE KEYS */;
INSERT INTO `ComprobanteDePago` VALUES (3,'2025-11-12 00:00:00',250.5,18,'Prueba desde Main','TEST-999',1),(4,'2025-11-12 00:00:00',1000,18,'Efectivo','VB2-123',1),(5,'2025-11-12 00:00:00',1000,18,'Efectivo','VB2-123',1),(6,'2025-11-12 00:00:00',100,18,'Efectivo','NVS-213',1),(7,'2025-11-12 00:00:00',500,18,'Tarjeta','VB3-125',1),(8,'2025-11-12 00:00:00',242,18,'Yape','NC-WEB-001',1),(9,'2025-11-11 00:00:00',80,18,'Reversión','NC-WEB-001',1),(10,'2025-11-12 00:00:00',500,18,'Transferencia','ND-WEB-019',1),(11,'2025-11-12 00:00:00',500,18,'Transferencia','ND-WEB-019',0),(12,'2025-11-11 00:00:00',1000,18,'Plin','NC-WEB-001',1),(13,'2025-11-11 00:00:00',1000,18,'Plin','VB2-123',1),(14,'2025-11-12 00:00:00',1000,18,'Reversion','NC-WEB-123',1),(15,'2025-11-11 00:00:00',1000,18,'Deposito','ND-WEB-129',1),(16,'2025-11-17 00:00:00',1000,18,'Tarjeta','ES-123-1SA',1),(17,'2025-11-17 00:00:00',1200,18,'Efectivo','B001-456',0),(18,'2025-11-23 00:00:00',200,36,'Efectivo','B4601-4845253',0),(19,'2025-11-23 00:00:00',325,58.5,'Efectivo','B2830-1248669',1),(20,'2025-11-23 00:00:00',325,58.5,'Efectivo','B3040-1015717',1),(21,'2025-11-23 00:00:00',480,86.39999999999999,'Efectivo','F7646-9740837',1),(22,'2025-11-23 00:00:00',480,86.39999999999999,'Efectivo','F3584-7565455',1),(23,'2025-11-23 00:00:00',480,86.39999999999999,'Efectivo','F6722-4634382',1),(24,'2025-11-24 00:00:00',5760,1036.8,'Efectivo','B1273-8204634',1),(25,'2025-11-24 00:00:00',576,103.67999999999999,'Efectivo','B1366-6241500',1),(26,'2025-11-24 00:00:00',576,103.67999999999999,'Efectivo','B8430-2962369',1),(27,'2025-11-01 00:00:00',20,17,'Yape','Leonardo',0),(28,'2025-11-24 00:00:00',576,103.67999999999999,'Efectivo','B1384-6357586',1),(29,'2025-11-24 00:00:00',576,103.67999999999999,'Efectivo','B5220-5188193',1),(30,'2025-11-24 00:00:00',880,158.4,'Efectivo','B1138-8165334',1),(31,'2025-11-24 00:00:00',840,151.2,'Efectivo','B6224-5639921',0),(32,'2025-11-24 00:00:00',473,85.14,'Efectivo','B6047-9835185',0),(33,'2025-11-24 00:00:00',640,115.19999999999999,'Efectivo','B5785-8342068',0),(34,'2025-11-24 00:00:00',10,18,'Efectivo','KDS-213',1),(35,'2025-11-11 00:00:00',10,18,'Yape','AKA-234',1),(36,'2025-11-05 00:00:00',10,18,'Plin','HOL-231',1),(37,'2025-11-24 00:00:00',10,1.7999999999999998,'Tarjeta','F2345-1793765',1);
/*!40000 ALTER TABLE `ComprobanteDePago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CondicionPago`
--

DROP TABLE IF EXISTS `CondicionPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CondicionPago` (
  `idCondicion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(120) DEFAULT NULL,
  `numDias` int NOT NULL,
  `vigente` tinyint NOT NULL,
  `Proveedor_idProveedor` int NOT NULL,
  PRIMARY KEY (`idCondicion`),
  KEY `fk_Proveedor_idProveedor1_idx` (`Proveedor_idProveedor`),
  CONSTRAINT `fk_Proveedor_idProveedor1` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `Proveedor` (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CondicionPago`
--

LOCK TABLES `CondicionPago` WRITE;
/*!40000 ALTER TABLE `CondicionPago` DISABLE KEYS */;
INSERT INTO `CondicionPago` VALUES (17,'mitad del pago Adelantado',90,0,24),(18,'interes del 3% por cada mes',90,0,24),(19,'wqeqwe',123,1,25),(20,'Condicon nueva',33,1,3),(21,'mitad del pago Adelantado',90,1,24),(22,'interes del 3% por cada mes',90,1,24),(23,'Tengo Sueño',23,1,27);
/*!40000 ALTER TABLE `CondicionPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CuentaUsuario`
--

DROP TABLE IF EXISTS `CuentaUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CuentaUsuario` (
  `idCuenta` int NOT NULL AUTO_INCREMENT,
  `username` varchar(75) DEFAULT NULL,
  `contrasenha` varchar(75) DEFAULT NULL,
  `activo` tinyint NOT NULL,
  `email` varchar(75) DEFAULT NULL,
  `tokenRecuperacion` varchar(255) DEFAULT NULL,
  `tokenExpiracion` datetime DEFAULT NULL,
  `TipoCuenta_idTipoCuenta` int NOT NULL,
  `fid_empleado` int DEFAULT NULL,
  PRIMARY KEY (`idCuenta`,`TipoCuenta_idTipoCuenta`),
  UNIQUE KEY `fid_empleado` (`fid_empleado`),
  KEY `fk_CuentaUsuario_TipoCuenta1_idx` (`TipoCuenta_idTipoCuenta`),
  KEY `idx_token_recuperacion` (`tokenRecuperacion`),
  CONSTRAINT `CuentaUsuario_ibfk_1` FOREIGN KEY (`fid_empleado`) REFERENCES `Empleado` (`idEmpleado`),
  CONSTRAINT `fk_CuentaUsuario_TipoCuenta1` FOREIGN KEY (`TipoCuenta_idTipoCuenta`) REFERENCES `TipoCuenta` (`idTipoCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CuentaUsuario`
--

LOCK TABLES `CuentaUsuario` WRITE;
/*!40000 ALTER TABLE `CuentaUsuario` DISABLE KEYS */;
INSERT INTO `CuentaUsuario` VALUES (6,'admin','81dc9bdb52d04dc20036dbd8313ed055',1,'admin@weardrop.pe',NULL,NULL,4,1),(7,'Pedro','0192023a7bbd73250516f069df18b500',1,'admin_main@empresa.com',NULL,NULL,4,30),(8,'Carlos','d70bdd06cc35fe765d525c8adad3b337',1,'jefe1@empresa.com',NULL,NULL,5,2),(9,'Hercules123','8cac6cee8223173e9c31d814bdf304b7',1,'admin_aux@empresa.com',NULL,NULL,4,3),(10,'ElPresi','5e7ba5ab843cf9d5324c56a10a09d17e',1,'operador@empresa.com',NULL,NULL,5,4),(11,'Leo','f11536bee899541aa233f5c0aa98f625',1,'superadmin@empresa.com',NULL,NULL,4,5),(12,'Aquiles777','f1c1592588411002af340cbaedd6fc33',0,'eyttel777@gamil.com',NULL,NULL,4,19),(13,'KratosGD20YT','024b32a03a2192729ad09574fbc93cfa594cdf9677cfff94dde8e21628b2054e',1,'leonardotr07@gmail.com',NULL,NULL,4,12),(14,'Sacha','202cb962ac59075b964b07152d234b70',0,'sacha@gmail.com',NULL,NULL,4,15),(15,'Jafeth','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'correoweardrop@gmail.com',NULL,NULL,4,7),(17,'ricardo','1721dd7964ef2a90746f42c3efc51797501f9e5cf16f0e0819b6c87f6f71881c',1,'ricardo.l@gmail.com',NULL,NULL,5,9),(18,'PazAdmin','f707fdda7c874ff49ebfb2c88a2860c5ff4ce3d94a21efb76566ad0f92c9ad57',1,'eyttel29@gmail.com',NULL,NULL,4,39),(19,'Mati','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',0,'mati@gmail.com',NULL,NULL,5,11),(20,'sofi','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'sof@gmail.com',NULL,NULL,4,50),(21,'Hectorino','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'etoro@gmail.com',NULL,NULL,4,49),(22,'Luluxd','441b02df090112b0b48b44e9eb6026d2ca1eec0d685c7d5712b59efbb9423a0c',1,'lulu@gmail.com',NULL,NULL,4,48),(23,'PazAlmacen','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'wea@gmail.com',NULL,NULL,5,47),(24,'MatiasV3','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'matiasmarrufo.12@gmail.com',NULL,NULL,4,43),(25,'Maria','49dc52e6bf2abe5ef6e2bb5b0f1ee2d765b922ae6cc8b95d39dc06c21c848f8c',1,'Mary@gmail.com',NULL,NULL,4,42),(26,'Luigiano','caeb62b4dee753bb470d98df7d8751ef934024e00eda227a1ffce94bed8711af',1,'Luigi@gmail.com',NULL,NULL,4,41),(27,'Borrador','b8be1f23a2ccee3417b3c0130aa21a8e5447f74fb64621e9a69a7e55cfc1b46c',0,'borrador@gmail.com',NULL,NULL,5,53),(28,'Borrador','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',1,'bor@gmail.com',NULL,NULL,4,13);
/*!40000 ALTER TABLE `CuentaUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Descuento`
--

DROP TABLE IF EXISTS `Descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Descuento` (
  `idDescuento` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(75) DEFAULT NULL,
  `esAutomatico` tinyint DEFAULT NULL,
  `activo` tinyint DEFAULT NULL,
  `idVigencia` int DEFAULT NULL,
  PRIMARY KEY (`idDescuento`),
  KEY `idVigencia` (`idVigencia`),
  CONSTRAINT `Descuento_ibfk_1` FOREIGN KEY (`idVigencia`) REFERENCES `Vigencia` (`idVigencia`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Descuento`
--

LOCK TABLES `Descuento` WRITE;
/*!40000 ALTER TABLE `Descuento` DISABLE KEYS */;
INSERT INTO `Descuento` VALUES (1,'Liquidacion de fin de mes',1,1,1),(2,'Descuento de Navidad',1,1,1),(3,'Porcentaje de Remate por Navidad',1,1,1),(4,'Descuento de Año Nuevo',1,1,1),(5,'Porcentaje de Remate por AñoNuevo',1,1,1),(6,'Liquidacion de primavera',1,1,1);
/*!40000 ALTER TABLE `Descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DescuentoLiquidacion`
--

DROP TABLE IF EXISTS `DescuentoLiquidacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DescuentoLiquidacion` (
  `idDescuento` int NOT NULL,
  `porcentajeLiquidacion` float DEFAULT NULL,
  `condicionStockMin` int DEFAULT NULL,
  PRIMARY KEY (`idDescuento`),
  CONSTRAINT `DescuentoLiquidacion_ibfk_1` FOREIGN KEY (`idDescuento`) REFERENCES `Descuento` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DescuentoLiquidacion`
--

LOCK TABLES `DescuentoLiquidacion` WRITE;
/*!40000 ALTER TABLE `DescuentoLiquidacion` DISABLE KEYS */;
INSERT INTO `DescuentoLiquidacion` VALUES (1,10,15),(6,11,2);
/*!40000 ALTER TABLE `DescuentoLiquidacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DescuentoMonto`
--

DROP TABLE IF EXISTS `DescuentoMonto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DescuentoMonto` (
  `idDescuento` int NOT NULL,
  `montoEditable` float DEFAULT NULL,
  `montoMaximo` float DEFAULT NULL,
  PRIMARY KEY (`idDescuento`),
  CONSTRAINT `DescuentoMonto_ibfk_1` FOREIGN KEY (`idDescuento`) REFERENCES `Descuento` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DescuentoMonto`
--

LOCK TABLES `DescuentoMonto` WRITE;
/*!40000 ALTER TABLE `DescuentoMonto` DISABLE KEYS */;
INSERT INTO `DescuentoMonto` VALUES (2,10,15),(4,20,25);
/*!40000 ALTER TABLE `DescuentoMonto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DescuentoPorcentaje`
--

DROP TABLE IF EXISTS `DescuentoPorcentaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DescuentoPorcentaje` (
  `idDescuento` int NOT NULL,
  `porcentaje` float DEFAULT NULL,
  PRIMARY KEY (`idDescuento`),
  CONSTRAINT `DescuentoPorcentaje_ibfk_1` FOREIGN KEY (`idDescuento`) REFERENCES `Descuento` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DescuentoPorcentaje`
--

LOCK TABLES `DescuentoPorcentaje` WRITE;
/*!40000 ALTER TABLE `DescuentoPorcentaje` DISABLE KEYS */;
INSERT INTO `DescuentoPorcentaje` VALUES (3,15),(5,30);
/*!40000 ALTER TABLE `DescuentoPorcentaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Devolucion`
--

DROP TABLE IF EXISTS `Devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Devolucion` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `idEmpleado` int NOT NULL,
  `idProveedor` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `cantidad` int NOT NULL,
  `idPrenda` int NOT NULL,
  `talla` varchar(10) DEFAULT NULL,
  `fecha` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_devolucion_empleado` (`idEmpleado`),
  KEY `fk_devolucion_proveedor` (`idProveedor`),
  KEY `fk_devolucion_prenda` (`idPrenda`),
  CONSTRAINT `fk_devolucion_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `Empleado` (`idEmpleado`),
  CONSTRAINT `fk_devolucion_prenda` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`),
  CONSTRAINT `fk_devolucion_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `Proveedor` (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devolucion`
--

LOCK TABLES `Devolucion` WRITE;
/*!40000 ALTER TABLE `Devolucion` DISABLE KEYS */;
INSERT INTO `Devolucion` VALUES (3,'Devolución de prueba',1,1,150.50,3,22,'S','2025-11-23',1),(4,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(5,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(6,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(7,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(8,'Devolución de prueba',1,1,150.50,3,21,'S','2025-11-23',0),(9,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(10,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(11,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(12,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(13,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(14,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-23',0),(15,'ayuda',39,6,56.00,2,33,'L','2025-11-23',1),(16,'Tengo hambre',12,3,43.00,1,37,'L','2025-11-24',0),(18,'Casaca con cierre dañado',2,2,240.00,2,3,'L','2025-11-22',1),(19,'Polo con mancha de fábrica',2,1,50.00,2,1,'M','2025-11-23',1),(20,'Falda con costura abierta',1,1,70.00,1,4,'M','2025-11-23',1),(21,'Tengo sueño',39,8,43.00,1,34,'M','2025-11-24',1),(22,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-24',0),(23,'Devolución modificada',1,1,200.00,5,21,'M','2025-11-24',0);
/*!40000 ALTER TABLE `Devolucion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `trg_descuento_stock_devolucion` AFTER INSERT ON `Devolucion` FOR EACH ROW BEGIN
    -- Solo descontar stock si la devolución está activa
    IF NEW.activo = 1 THEN
        CALL sp_descontar_stock_fifo_prenda(
            NEW.idPrenda,   -- p_idPrenda
            NEW.talla,      -- p_talla
            NEW.cantidad    -- p_cantidad
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Empleado`
--

DROP TABLE IF EXISTS `Empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Empleado` (
  `idEmpleado` int NOT NULL,
  `sueldo` decimal(10,2) DEFAULT NULL,
  `Cargo_idCargo` int NOT NULL,
  `activo` tinyint DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`,`Cargo_idCargo`),
  KEY `fk_Empleado_Cargo1_idx` (`Cargo_idCargo`),
  CONSTRAINT `fk_Empleado_Cargo1` FOREIGN KEY (`Cargo_idCargo`) REFERENCES `Cargo` (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
INSERT INTO `Empleado` VALUES (1,4500.00,1,1),(2,2800.00,2,1),(3,1800.00,3,1),(4,2500.00,4,1),(5,1500.00,1,1),(5,2000.00,5,1),(6,3200.00,2,0),(7,2100.00,5,1),(8,1900.00,3,0),(9,2600.00,4,1),(10,4600.00,1,1),(11,1850.00,3,1),(12,2750.00,2,1),(13,1950.00,5,1),(14,2500.00,4,1),(15,1800.00,3,0),(19,50000.00,1,0),(30,15000.00,1,1),(31,400000.00,1,1),(39,88888.00,9,1),(41,6500.00,1,1),(42,4200.00,2,1),(43,3200.00,3,1),(44,5100.00,4,1),(45,3800.00,5,1),(46,2900.00,9,1),(47,4300.00,2,1),(48,3100.00,3,1),(49,3900.00,5,1),(50,2800.00,9,1),(51,808080.00,4,1),(53,9876432.00,3,1);
/*!40000 ALTER TABLE `Empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Factura`
--

DROP TABLE IF EXISTS `Factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Factura` (
  `idComprobante` int NOT NULL,
  `RUC` varchar(11) DEFAULT NULL,
  `razonSocial` varchar(110) DEFAULT NULL,
  PRIMARY KEY (`idComprobante`),
  CONSTRAINT `Factura_ibfk_1` FOREIGN KEY (`idComprobante`) REFERENCES `ComprobanteDePago` (`idComprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Factura`
--

LOCK TABLES `Factura` WRITE;
/*!40000 ALTER TABLE `Factura` DISABLE KEYS */;
INSERT INTO `Factura` VALUES (3,'99999999999','Empresa de Prueba S.A.C.'),(4,'20123456789','Mi Empresa S.A.C.'),(5,'20123456789','Mi Empresa S.A.C.'),(7,'21020212112','Tu Empresa S.A.C.'),(13,'20123456789','Mi Empresa S.A.C.'),(21,'12345678910','RazonSocial2'),(22,'12345678910','RazonSocial2'),(23,'12345678910','rasdda'),(35,'12345678901','Pedro S.A.C.'),(37,'12345678901','Valery S.A.C.');
/*!40000 ALTER TABLE `Factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Falda`
--

DROP TABLE IF EXISTS `Falda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Falda` (
  `idPrenda` int NOT NULL,
  `tipo_falda` enum('Mini','Midi','Larga','Tubo','Plisada','Cruzada','ShortFalda','Otro') NOT NULL,
  `largo` decimal(6,2) NOT NULL,
  `con_forro` tinyint NOT NULL DEFAULT '0',
  `con_volantes` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Falda_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Falda`
--

LOCK TABLES `Falda` WRITE;
/*!40000 ALTER TABLE `Falda` DISABLE KEYS */;
INSERT INTO `Falda` VALUES (4,'Midi',70.00,1,1),(13,'Midi',85.00,1,0),(14,'Mini',45.00,0,0),(34,'Mini',45.00,0,0);
/*!40000 ALTER TABLE `Falda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Gorro`
--

DROP TABLE IF EXISTS `Gorro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Gorro` (
  `idPrenda` int NOT NULL,
  `tipo_gorra` enum('Bucket','Visera','Tejido','Beanie','Otro') NOT NULL,
  `talla_ajustable` tinyint NOT NULL DEFAULT '0',
  `impermeable` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Gorro_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Gorro`
--

LOCK TABLES `Gorro` WRITE;
/*!40000 ALTER TABLE `Gorro` DISABLE KEYS */;
INSERT INTO `Gorro` VALUES (6,'Bucket',1,0),(17,'Tejido',0,0),(18,'Bucket',1,0),(35,'Visera',1,0);
/*!40000 ALTER TABLE `Gorro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ItemVenta`
--

DROP TABLE IF EXISTS `ItemVenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ItemVenta` (
  `numLinea` int NOT NULL AUTO_INCREMENT,
  `Prenda_idPrenda` int NOT NULL,
  `talla` varchar(10) NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `Venta_idVenta` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`numLinea`),
  KEY `fk_Prenda_idPrenda1_idx` (`Prenda_idPrenda`),
  KEY `fk_Venta_idVenta1_idx` (`Venta_idVenta`),
  CONSTRAINT `fk_Prenda_idPrenda1` FOREIGN KEY (`Prenda_idPrenda`) REFERENCES `Prenda` (`idPrenda`),
  CONSTRAINT `fk_Venta_idVenta1` FOREIGN KEY (`Venta_idVenta`) REFERENCES `Venta` (`idVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ItemVenta`
--

LOCK TABLES `ItemVenta` WRITE;
/*!40000 ALTER TABLE `ItemVenta` DISABLE KEYS */;
INSERT INTO `ItemVenta` VALUES (1,22,'M',8,100.00,1,0),(2,33,'S',5,150.00,1,0),(3,59,'M',3,90.00,1,0),(4,62,'L',4,140.00,1,0),(12,33,'L',20,300.00,16,0),(13,36,'L',50,600.00,16,0),(16,38,'L',30,400.00,16,0),(17,36,'L',50,600.00,16,0),(1001,34,'S',2,92.00,17,0),(1002,36,'M',1,45.00,17,0),(1003,36,'M',3,135.00,18,0),(1004,38,'L',2,70.00,18,0),(1005,39,'M',4,128.00,19,1),(1006,46,'L',5,150.00,19,1),(1007,38,'S',1,35.00,19,1),(1008,46,'L',20,325.00,21,1),(1009,38,'M',60,480.00,22,1),(1010,38,'M',60,480.00,23,0),(1011,38,'M',60,480.00,23,1),(1012,38,'L',1000,5760.00,24,1),(1013,38,'L',100,576.00,25,0),(1014,38,'L',100,576.00,26,1),(1015,38,'L',100,576.00,25,0),(1016,38,'L',100,576.00,25,1),(1017,37,'L',11,473.00,27,1),(1018,38,'M',20,640.00,28,1),(1019,103,'XS',1,10.00,29,1);
/*!40000 ALTER TABLE `ItemVenta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `trg_descontar_stock_fifo` AFTER INSERT ON `ItemVenta` FOR EACH ROW BEGIN
    -- Llamada al procedure para descontar stock FIFO según prenda, talla y cantidad vendida
    CALL sp_descontar_stock_fifo_prenda(NEW.Prenda_idPrenda, NEW.talla, NEW.cantidad);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LineaLoteCompra`
--

DROP TABLE IF EXISTS `LineaLoteCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LineaLoteCompra` (
  `idPrenda` int NOT NULL,
  `numLinea` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL DEFAULT '0',
  `talla` enum('XS','S','M','L','XL','XXL') DEFAULT NULL,
  `lote_idLote` int NOT NULL,
  `precioLote` decimal(10,2) NOT NULL,
  `OrdenCompra_idCompra` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`numLinea`),
  KEY `fk_lote_idLote1_idx` (`lote_idLote`),
  KEY `fk_OrdenCompra_idCompra1_idx` (`OrdenCompra_idCompra`),
  CONSTRAINT `fk_lote_idLote1` FOREIGN KEY (`lote_idLote`) REFERENCES `Lote` (`idLote`),
  CONSTRAINT `fk_OrdenCompra_idCompra1` FOREIGN KEY (`OrdenCompra_idCompra`) REFERENCES `OrdenCompra` (`idCompra`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LineaLoteCompra`
--

LOCK TABLES `LineaLoteCompra` WRITE;
/*!40000 ALTER TABLE `LineaLoteCompra` DISABLE KEYS */;
INSERT INTO `LineaLoteCompra` VALUES (21,1,20,'M',1,45.90,8,0),(21,13,10,'L',1,770.00,11,0),(21,14,30,'S',2,880.00,11,0),(21,15,10,'L',1,770.00,12,1),(21,16,30,'S',2,880.00,12,1),(21,17,10,'L',1,770.00,13,0),(22,18,30,'S',2,880.00,13,0),(38,19,11,'M',1,1111.00,14,0),(38,20,11,'M',1,1111.00,15,0),(38,21,11,'M',1,1111.00,15,0),(38,22,11,'M',1,1111.00,15,0),(38,23,11,'M',1,2000.00,15,0),(34,24,21,'M',1,11111.00,16,0),(34,25,21,'M',1,11111.00,16,0),(34,26,21,'M',1,11111.00,16,0),(38,27,11,'M',1,1111.00,14,0),(34,28,20,'L',1,25.00,14,0),(38,29,20,'M',1,2000.00,14,1),(34,30,20,'L',1,25.00,14,1),(34,31,333,'M',1,20000.00,16,0),(34,32,333,'M',1,20000.00,16,1),(46,33,30,'L',1,3600.00,17,1),(38,34,22,'L',15,4000.00,18,1),(21,35,10,'L',1,770.00,13,1),(22,36,30,'S',2,880.00,13,1),(37,37,500,'L',13,7000.00,19,1),(37,38,123,'L',9,212.00,20,1),(46,39,566,'M',6,1122.00,21,1),(38,40,1111,'L',6,12323.00,21,1),(37,41,111,'L',3,1111.00,22,1),(38,42,998,'M',4,35000.00,23,1),(103,43,10,'XS',17,16.00,24,1);
/*!40000 ALTER TABLE `LineaLoteCompra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `trg_linealotecompra_ai` AFTER INSERT ON `LineaLoteCompra` FOR EACH ROW BEGIN
    DECLARE v_idPrendaLote INT DEFAULT NULL;

    -- Buscamos si ya existe el registro de stock para esa prenda + lote + talla
    SELECT idPrendaLote
      INTO v_idPrendaLote
    FROM PrendaLote
    WHERE Prenda_idPrenda = NEW.idPrenda
      AND Lote_idLote     = NEW.lote_idLote
      AND talla           = NEW.talla
      AND activo          = 1
    LIMIT 1;

    -- Si no existe, lo creamos
    IF v_idPrendaLote IS NULL THEN
        INSERT INTO PrendaLote
            (Prenda_idPrenda, Lote_idLote, stock, activo, talla)
        VALUES
            (NEW.idPrenda, NEW.lote_idLote, NEW.cantidad, 1, NEW.talla);
    ELSE
        -- Si ya existe, solo sumamos al stock
        UPDATE PrendaLote
        SET stock = stock + NEW.cantidad
        WHERE idPrendaLote = v_idPrendaLote;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Lote`
--

DROP TABLE IF EXISTS `Lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lote` (
  `idLote` int NOT NULL AUTO_INCREMENT,
  `Almacen_idAlmacen` int NOT NULL,
  `activo` tinyint NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idLote`),
  KEY `fk_Lote_Almacen1_idx` (`Almacen_idAlmacen`),
  CONSTRAINT `fk_Lote_Almacen1` FOREIGN KEY (`Almacen_idAlmacen`) REFERENCES `Almacen` (`idAlmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lote`
--

LOCK TABLES `Lote` WRITE;
/*!40000 ALTER TABLE `Lote` DISABLE KEYS */;
INSERT INTO `Lote` VALUES (1,1,1,'Polos Algodón Jersey Cuello Redondo - Colores Básico'),(2,1,1,'Pantalones Drill Slim Fit (Producción Nacional)'),(3,1,1,'Blusas Gasa Estampada - Tallas S y M (Liquidación)'),(4,1,1,'Casacas Denim Temporada Otoño-Invierno'),(5,1,1,'Ropa Interior y Medias x Mayor (Caja 1000 und.)'),(6,1,1,'Hilos de Coser y Material de Avío (Botones, Cierres)'),(7,1,1,'Vestidos de Noche (Inventario de Exhibición)'),(8,1,1,'Muestras y Patrones Textiles (Desarrollo Producto)'),(9,2,1,'Jeans Skinny Mujer (Lycra T-32, T-34)'),(10,2,1,'Faldas y Shorts de Mezclilla Desgastados (Stock Nuevo)'),(11,2,1,'Telas de Gabardina y Twill (Rollos Completos)'),(12,2,1,'Ropa Deportiva: Leggings y Tops (Stock Importado)'),(13,2,1,'Polerones con Capucha (Franela Gruesa)'),(14,2,1,'Accesorios de Invierno (Gorros, Bufandas, Guantes)'),(15,2,1,'Overoles y Enterizos de Jean para Producción'),(16,2,1,'Saldos de Polos Publicitarios (Defectos Menores)'),(17,3,1,'Reposición Rápida de Polos de Última Moda (Tallas S-L)'),(18,3,1,'Lote de Seguridad (Mercadería de Alto Valor)'),(19,3,1,'Etiquetas y Empaques de Marca (Bolsas, Cajas)'),(20,3,1,'Ternos y Ropa Formal (Solo Tallas Grandes)'),(21,3,1,'Pijamas y Ropa de Casa (Stock Infantil)'),(22,3,1,'Vestidos de Fiesta y Cóctel (Modelos Exclusivos)'),(23,3,1,'Zapatillas Urbanas y Sandalias (Inventario Verano)'),(24,3,1,'Blusas de Seda y Chiffon (Colores Pasteles)'),(25,4,1,'Stock Masivo de Polos Blancos para Estampar'),(26,4,1,'Rollos de Tela Cruda (Algodón Pima)'),(27,4,1,'Materiales de Limpieza y Mantenimiento del Local'),(28,4,1,'Importación de Zapatos y Botines (Stock Enero)'),(29,4,1,'Buzos y Conjuntos Deportivos de Falla'),(30,4,1,'Mochilas y Carteras (Accesorios de Moda)'),(31,4,1,'Muestras Aprobadas de Proveedores Extranjeros'),(32,4,1,'Uniformes de Personal y Merchandising'),(33,5,1,'Stock Rezago de la Colección 2023 (Próxima Venta Garage)'),(34,5,1,'Prendas con Pequeños Daños de Almacén (Para Retrabajo)'),(35,5,1,'Lanas y Hilos para Tejido (Stock de Temporada Fría)'),(36,5,1,'Exhibidores y Maniquíes Desmontados'),(37,5,1,'Lote de Artículos para Devolución a Taller'),(38,5,1,'Prendas Promocionales (Bajo Costo)'),(39,5,1,'Jeans y Pantalones con Corte Obsoleto (Liquidación Final)'),(40,5,1,'Artículos de Papelería y Oficina (Logística)'),(41,1,1,'Lote de Prueba'),(42,1,1,'Mesi'),(43,1,1,'Lote de Prueba 3'),(44,1,1,'Lote de Prueba 4');
/*!40000 ALTER TABLE `Lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovimientoAlmacen`
--

DROP TABLE IF EXISTS `MovimientoAlmacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovimientoAlmacen` (
  `idMovAlmacen` int NOT NULL AUTO_INCREMENT,
  `Almacen_idAlmacen` int NOT NULL,
  `fecha` datetime NOT NULL,
  `lugarDestino` varchar(100) NOT NULL,
  `lugarOrigen` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `activo` tinyint NOT NULL,
  `CuentaUsuario_idCuenta` int NOT NULL,
  PRIMARY KEY (`idMovAlmacen`,`Almacen_idAlmacen`),
  KEY `fk_MovimientoAlmacen_Almacen1_idx` (`Almacen_idAlmacen`),
  KEY `fk_MovimientoAlmacen_CuentaUsuario` (`CuentaUsuario_idCuenta`),
  CONSTRAINT `fk_MovimientoAlmacen_Almacen1` FOREIGN KEY (`Almacen_idAlmacen`) REFERENCES `Almacen` (`idAlmacen`),
  CONSTRAINT `fk_MovimientoAlmacen_CuentaUsuario` FOREIGN KEY (`CuentaUsuario_idCuenta`) REFERENCES `CuentaUsuario` (`idCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovimientoAlmacen`
--

LOCK TABLES `MovimientoAlmacen` WRITE;
/*!40000 ALTER TABLE `MovimientoAlmacen` DISABLE KEYS */;
INSERT INTO `MovimientoAlmacen` VALUES (1,1,'2025-11-05 00:00:00','Depósito Master 402','Textiles del Norte S.A.','Entrada',1,6),(2,1,'2025-11-05 14:30:00','Depósito Master 402','Taller de Confección Z','Entrada',1,6),(3,1,'2025-11-06 09:15:00','Depósito Master 402','Tienda Principal 1','Entrada',1,6),(4,1,'2025-11-06 16:45:00','Depósito Master 402','Proveedor Accesorios B','Entrada',1,6),(5,1,'2025-11-07 11:30:00','Tienda Principal 1','Depósito Master 402','Salida',1,6),(6,1,'2025-11-07 17:00:00','Tienda Principal 1','Depósito Master 402','Salida',1,6),(7,1,'2025-11-08 10:45:00','Stock Antiguo 505','Depósito Master 402','Mov_Interno',1,6),(8,1,'2025-11-08 15:20:00','Local Auxiliar Bazo','Depósito Master 402','Mov_Interno',1,6),(9,2,'2025-11-05 11:00:00','Almacén Jean Sotano','Fábrica de Jeans','Entrada',1,6),(10,2,'2025-11-05 15:30:00','Almacén Jean Sotano','Proveedor Botones C','Entrada',1,6),(11,2,'2025-11-06 10:00:00','Almacén Jean Sotano','Tienda Principal 1','Entrada',1,6),(12,2,'2025-11-06 17:00:00','Almacén Jean Sotano','Proveedor Cierres D','Entrada',1,6),(13,2,'2025-11-07 12:45:00','Tienda Principal 1','Almacén Jean Sotano','Salida',1,6),(14,2,'2025-11-07 18:00:00','Tienda Principal 1','Almacén Jean Sotano','Salida',1,6),(15,2,'2025-11-08 11:10:00','Depósito Master 402','Almacén Jean Sotano','Mov_Interno',1,6),(16,2,'2025-11-08 16:00:00','Puesto Reserva 103A','Almacén Jean Sotano','Mov_Interno',1,6),(17,3,'2025-11-05 12:15:00','Puesto Reserva 103A','Proveedor de Polos E','Entrada',1,6),(18,3,'2025-11-05 16:30:00','Puesto Reserva 103A','Taller de Estampados','Entrada',1,6),(19,3,'2025-11-06 11:30:00','Puesto Reserva 103A','Tienda Principal 1','Entrada',1,6),(20,3,'2025-11-06 18:15:00','Puesto Reserva 103A','Proveedor Algodón F','Entrada',1,6),(21,3,'2025-11-07 13:00:00','Tienda Principal 1','Puesto Reserva 103A','Salida',1,6),(22,3,'2025-11-07 19:00:00','Tienda Principal 1','Puesto Reserva 103A','Salida',1,6),(23,3,'2025-11-08 12:00:00','Local Auxiliar Bazo','Puesto Reserva 103A','Mov_Interno',1,6),(24,3,'2025-11-08 17:15:00','Almacén Jean Sotano','Puesto Reserva 103A','Mov_Interno',1,6),(25,4,'2025-11-05 13:30:00','Local Auxiliar Bazo','Importador Ropa G','Entrada',1,6),(26,4,'2025-11-05 17:45:00','Local Auxiliar Bazo','Taller de Costura Gamarra','Entrada',1,6),(27,4,'2025-11-06 12:30:00','Local Auxiliar Bazo','Tienda Principal 1','Entrada',1,6),(28,4,'2025-11-06 19:00:00','Local Auxiliar Bazo','Proveedor Hilos H','Entrada',1,6),(29,4,'2025-11-07 14:15:00','Tienda Principal 1','Local Auxiliar Bazo','Salida',1,6),(30,4,'2025-11-07 20:00:00','Tienda Principal 1','Local Auxiliar Bazo','Salida',1,6),(31,4,'2025-11-08 13:00:00','Puesto Reserva 103A','Local Auxiliar Bazo','Mov_Interno',1,6),(32,4,'2025-11-08 18:00:00','Depósito Master 402','Local Auxiliar Bazo','Mov_Interno',1,6),(33,5,'2025-11-05 14:00:00','Stock Antiguo 505','Proveedor Lanas I','Entrada',1,6),(34,5,'2025-11-05 18:30:00','Stock Antiguo 505','Taller de Tejidos','Entrada',1,6),(35,5,'2025-11-06 13:45:00','Stock Antiguo 505','Tienda Principal 1','Entrada',1,6),(36,5,'2025-11-06 20:15:00','Stock Antiguo 505','Proveedor Etiquetas J','Entrada',1,6),(37,5,'2025-11-07 15:30:00','Tienda Principal 1','Stock Antiguo 505','Salida',1,6),(38,5,'2025-11-07 21:00:00','Tienda Principal 1','Stock Antiguo 505','Salida',1,6),(39,5,'2025-11-08 14:00:00','Almacén Jean Sotano','Stock Antiguo 505','Mov_Interno',1,6),(40,5,'2025-11-08 19:00:00','Depósito Master 402','Stock Antiguo 505','Mov_Interno',1,6),(41,1,'2025-11-15 00:00:00','Depósito Master 402','Importadora Mar Azul SAC','Entrada',1,7),(42,1,'2025-11-14 00:00:00','Depósito Master 402','TecnoMundo EIRL','Entrada',1,7),(43,1,'2025-11-08 00:00:00','Depósito Master 402','TextilesCO','Entrada',1,8),(44,1,'2025-10-31 00:00:00','Depósito Master 402','Papelería Universal SRL','Entrada',1,8),(45,1,'2025-11-05 00:00:00','Depósito Master 402','TextilesCO','Entrada',1,11),(46,1,'2025-11-13 00:00:00','Depósito Master 402','TextilesCO','Entrada',1,11),(47,1,'2025-11-06 00:00:00','TextilesCO','Depósito Master 402','Salida',1,11),(48,1,'2025-11-13 00:00:00','Almacén Jean Sotano','Depósito Master 402','Mov_Interno',1,11),(49,1,'2025-11-15 04:05:00','Puesto Reserva 103A','Depósito Master 402','Mov_Interno',1,11),(50,1,'2025-11-08 01:31:00','Depósito Master 402','Local Auxiliar Bazo','Mov_Interno',1,11),(51,1,'2025-11-06 18:20:00','Depósito Master 402','Papelería Universal SRL','Entrada',1,13),(52,1,'2025-11-21 01:03:00','AgroPerú SAC','Depósito Master 401','Salida',1,13);
/*!40000 ALTER TABLE `MovimientoAlmacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovimientoAlmacen_X_Lote`
--

DROP TABLE IF EXISTS `MovimientoAlmacen_X_Lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovimientoAlmacen_X_Lote` (
  `idMovAlmacen_X_Lote` int NOT NULL AUTO_INCREMENT,
  `Lote_idLote` int NOT NULL,
  `MovimientoAlmacen_idMovAlmacen` int NOT NULL,
  `MovimientoAlmacen_Almacen_idAlmacen` int NOT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idMovAlmacen_X_Lote`),
  KEY `fk_Lote_has_MovimientoAlmacen_MovimientoAlmacen1_idx` (`MovimientoAlmacen_idMovAlmacen`,`MovimientoAlmacen_Almacen_idAlmacen`),
  KEY `fk_Lote_has_MovimientoAlmacen_Lote1_idx` (`Lote_idLote`),
  CONSTRAINT `fk_Lote_has_MovimientoAlmacen_Lote1` FOREIGN KEY (`Lote_idLote`) REFERENCES `Lote` (`idLote`),
  CONSTRAINT `fk_Lote_has_MovimientoAlmacen_MovimientoAlmacen1` FOREIGN KEY (`MovimientoAlmacen_idMovAlmacen`, `MovimientoAlmacen_Almacen_idAlmacen`) REFERENCES `MovimientoAlmacen` (`idMovAlmacen`, `Almacen_idAlmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovimientoAlmacen_X_Lote`
--

LOCK TABLES `MovimientoAlmacen_X_Lote` WRITE;
/*!40000 ALTER TABLE `MovimientoAlmacen_X_Lote` DISABLE KEYS */;
INSERT INTO `MovimientoAlmacen_X_Lote` VALUES (1,1,2,1,1),(2,2,2,1,1),(3,3,3,1,1),(4,4,4,1,0),(5,5,5,1,1),(6,6,6,1,1),(7,7,7,1,1),(8,8,8,1,1),(9,9,9,2,1),(10,10,10,2,1),(11,11,11,2,1),(12,12,12,2,1),(13,13,13,2,1),(14,14,14,2,1),(15,15,15,2,1),(16,16,16,2,1),(17,17,17,3,1),(18,18,18,3,1),(19,19,19,3,1),(20,20,20,3,1),(21,21,21,3,1),(22,22,22,3,1),(23,23,23,3,1),(24,24,24,3,1),(25,25,25,4,1),(26,26,26,4,1),(27,27,27,4,1),(28,28,28,4,1),(29,29,29,4,1),(30,30,30,4,1),(31,31,31,4,1),(32,32,32,4,1),(33,33,33,5,1),(34,34,34,5,1),(35,35,35,5,1),(36,36,36,5,1),(37,37,37,5,1),(38,38,38,5,1),(39,39,39,5,1),(40,40,40,5,1),(41,43,4,1,1),(42,44,1,1,1),(43,3,2,1,1);
/*!40000 ALTER TABLE `MovimientoAlmacen_X_Lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NotaDeCredito`
--

DROP TABLE IF EXISTS `NotaDeCredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotaDeCredito` (
  `idComprobante` int NOT NULL,
  `detalleModificacion` varchar(255) DEFAULT NULL,
  `RUC` varchar(11) DEFAULT NULL,
  `razonSocial` varchar(45) DEFAULT NULL,
  `DNI` varchar(8) DEFAULT NULL,
  `motivoEspecifico` varchar(255) DEFAULT NULL,
  `nuevoMonto` double DEFAULT NULL,
  `valorAumentar` double DEFAULT NULL,
  PRIMARY KEY (`idComprobante`),
  CONSTRAINT `NotaDeCredito_ibfk_1` FOREIGN KEY (`idComprobante`) REFERENCES `ComprobanteDePago` (`idComprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NotaDeCredito`
--

LOCK TABLES `NotaDeCredito` WRITE;
/*!40000 ALTER TABLE `NotaDeCredito` DISABLE KEYS */;
INSERT INTO `NotaDeCredito` VALUES (9,'Cliente anula la boleta B-WEB-002 por desistimiento.','','Rosa Flores','77665512','Anulación de la operación',68,12),(14,'Cliente anula la boleta B-WEB-002 por retraso','20220201221','Rosa Lopez','77665500','Anulación de la compra',800,200),(36,'Corrupción','12345678901','Eyttel S.A.C.','73024207','Hambre',10,8);
/*!40000 ALTER TABLE `NotaDeCredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NotaDeDebito`
--

DROP TABLE IF EXISTS `NotaDeDebito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotaDeDebito` (
  `idComprobante` int NOT NULL,
  `detalleModificacion` varchar(255) DEFAULT NULL,
  `RUC` varchar(11) DEFAULT NULL,
  `razonSocial` varchar(45) DEFAULT NULL,
  `motivoEspecifico` varchar(45) DEFAULT NULL,
  `nuevoMonto` double DEFAULT NULL,
  `valorAumentar` double DEFAULT NULL,
  `idPrenda` int DEFAULT NULL,
  PRIMARY KEY (`idComprobante`),
  KEY `idPrenda` (`idPrenda`),
  CONSTRAINT `NotaDeDebito_ibfk_1` FOREIGN KEY (`idComprobante`) REFERENCES `ComprobanteDePago` (`idComprobante`),
  CONSTRAINT `NotaDeDebito_ibfk_2` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NotaDeDebito`
--

LOCK TABLES `NotaDeDebito` WRITE;
/*!40000 ALTER TABLE `NotaDeDebito` DISABLE KEYS */;
INSERT INTO `NotaDeDebito` VALUES (11,'Se aplica cargo por mora a la factura F-WEB-001','10101010101','Prueba Final Web S.A.C.','Intereses por pago tardio',525,25,21),(15,'Se aplica cargo por mora a la factura F-WEB-001','10101010101','Prueba Final Web S.A.C.','Intereses por pago tardio',1200,200,22);
/*!40000 ALTER TABLE `NotaDeDebito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrdenCompra`
--

DROP TABLE IF EXISTS `OrdenCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrdenCompra` (
  `idCompra` int NOT NULL AUTO_INCREMENT,
  `fechaLlegada` datetime NOT NULL,
  `fechaEmision` datetime NOT NULL,
  `deudaPendiente` decimal(10,2) NOT NULL,
  `montoTotal` decimal(10,2) NOT NULL,
  `Proveedor_idProveedor` int NOT NULL,
  `Empleado_idEmpleado` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`idCompra`),
  KEY `fk_Empleado_idEmpleado11_idx` (`Empleado_idEmpleado`),
  KEY `fk_Proveedor_idProveedor2_idx` (`Proveedor_idProveedor`),
  CONSTRAINT `fk_Empleado_idEmpleado11` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`),
  CONSTRAINT `fk_Proveedor_idProveedor2` FOREIGN KEY (`Proveedor_idProveedor`) REFERENCES `Proveedor` (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrdenCompra`
--

LOCK TABLES `OrdenCompra` WRITE;
/*!40000 ALTER TABLE `OrdenCompra` DISABLE KEYS */;
INSERT INTO `OrdenCompra` VALUES (5,'2024-12-15 00:00:00','2024-11-20 00:00:00',1500.00,4500.00,12,1,0),(6,'2024-12-20 00:00:00','2024-11-25 00:00:00',0.00,3200.50,2,1,0),(7,'2024-12-10 00:00:00','2024-11-15 00:00:00',800.75,2800.75,3,1,0),(8,'2024-12-25 00:00:00','2024-11-30 00:00:00',1200.00,5200.00,4,1,0),(9,'2025-10-12 00:00:00','2025-10-08 00:00:00',999.00,10000.00,2,11,0),(10,'2025-10-12 00:00:00','2025-10-08 00:00:00',999.00,10000.00,2,11,0),(11,'2025-10-12 00:00:00','2025-10-08 00:00:00',999.00,10000.00,1,1,0),(12,'2025-10-12 00:00:00','2025-10-08 00:00:00',999.00,10000.00,1,1,1),(13,'2025-10-12 00:00:00','2025-10-08 00:00:00',1650.00,1650.00,5,1,1),(14,'2025-11-27 00:00:00','2025-11-20 00:00:00',2025.00,2025.00,2,1,1),(15,'2025-11-27 00:00:00','2025-11-20 00:00:00',2000.00,2000.00,2,1,0),(16,'2025-11-27 00:00:00','2025-11-20 00:00:00',20000.00,20000.00,2,1,1),(17,'2025-11-28 00:00:00','2025-11-21 00:00:00',3600.00,3600.00,21,1,1),(18,'2025-11-28 00:00:00','2025-11-21 00:00:00',4000.00,4000.00,3,1,1),(19,'2025-11-29 00:00:00','2025-11-22 00:00:00',7000.00,7000.00,9,1,1),(20,'2025-12-01 00:00:00','2025-11-24 00:00:00',212.00,212.00,11,1,1),(21,'2025-12-01 00:00:00','2025-11-24 00:00:00',13445.00,13445.00,8,1,1),(22,'2025-12-01 00:00:00','2025-11-24 00:00:00',1111.00,1111.00,5,43,1),(23,'2025-12-02 00:00:00','2025-11-29 00:00:00',35000.00,35000.00,4,43,1),(24,'2025-12-01 00:00:00','2025-11-24 00:00:00',16.00,16.00,9,39,1);
/*!40000 ALTER TABLE `OrdenCompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pantalon`
--

DROP TABLE IF EXISTS `Pantalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pantalon` (
  `idPrenda` int NOT NULL,
  `tipo_pantalon` enum('Jean','Jogger','Chino','Cargo','Buzo','Leggins','Palazzo','Otro') NOT NULL,
  `largo_pierna` decimal(6,2) NOT NULL,
  `cintura` decimal(6,2) NOT NULL,
  `elasticidad` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Pantalon_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pantalon`
--

LOCK TABLES `Pantalon` WRITE;
/*!40000 ALTER TABLE `Pantalon` DISABLE KEYS */;
INSERT INTO `Pantalon` VALUES (5,'Jean',100.00,72.00,0),(15,'Otro',102.00,72.00,0),(16,'Cargo',100.00,78.00,0),(37,'Cargo',120.00,78.00,0),(46,'Cargo',120.00,78.00,0);
/*!40000 ALTER TABLE `Pantalon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Persona`
--

DROP TABLE IF EXISTS `Persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Persona` (
  `idPersona` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(75) DEFAULT NULL,
  `primerApellido` varchar(75) DEFAULT NULL,
  `segundoApellido` varchar(45) DEFAULT NULL,
  `dni` int DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `genero` char(1) DEFAULT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Persona`
--

LOCK TABLES `Persona` WRITE;
/*!40000 ALTER TABLE `Persona` DISABLE KEYS */;
INSERT INTO `Persona` VALUES (1,'Luis','Ramírez','Torres',73024208,987654321,'M'),(2,'Carla','Sánchez','Mendoza',73011122,912345678,'F'),(3,'Andrés','García','Salas',73033445,978654321,'M'),(4,'Lucía','Vargas','Cruz',73055667,965432187,'F'),(6,'María','López','Fernández',73099001,987654300,'F'),(7,'Jorge','Pérez','Ramírez',73099002,987654301,'M'),(8,'Valeria','Núñez','Gómez',73099003,987654302,'F'),(9,'Ricardo','Huamán','Soto',77724208,987654303,'M'),(10,'Fernanda','Mendoza','Salazar',73099005,987654304,'F'),(11,'Mateo','Torres','Campos',73099006,987654305,'M'),(12,'Daniela','García','León',73099007,987654306,'F'),(13,'Sofía','Rivas','Palacios',73099008,987654307,'F'),(14,'Martín','Vega','Rosales',73099009,987654308,'M'),(15,'Camila','Paredes','Suárez',73099010,987654309,'F'),(19,'Eyttel','Carhuanira','Tarazona',77724888,995345285,'M'),(20,'Jafeth','Campos','Reyes',73100011,987600001,'M'),(21,'Andrea','Salazar','Torres',73100012,987600002,'F'),(22,'José','Ramírez','Mendoza',73100013,987600003,'M'),(23,'Patricia','Gómez','Quispe',73100014,987600004,'F'),(24,'Carlos','Vega','Zapata',73100015,987600005,'M'),(25,'Milagros','Lopez','Soto',73100016,987600006,'F'),(26,'Sebastián','Ruiz','Díaz',73100017,987600007,'M'),(27,'Karla','Castillo','Valdez',73100018,987600008,'F'),(28,'Miguel','Rojas','Palacios',73100019,987600009,'M'),(29,'Cecilia','Núñez','Fernández',73100020,987600010,'F'),(30,'Leonardo','Tueros','Montoya',77724886,995345285,'M'),(31,'Henry','Cavil','Quispe',77724885,995345385,'M'),(32,'Eyttel','Carhuanira','Tarazona',77724884,995345285,'M'),(33,'Eyttel','Carhuanira','Tarazona',73024207,995345285,'M'),(34,'Carlos','Mendoza','Rios',72345678,987654321,'M'),(35,'Ana','Torres','Lopez',73456789,987654322,'F'),(36,'Luis','Garcia','Perez',74567890,987654323,'M'),(37,'Maria','Rodriguez','Silva',75678901,987654324,'F'),(38,'Pedro','Sanchez','Diaz',76789012,987654325,'M'),(39,'Eyttel','Carhuanira','Tarazona',73024207,995345285,'M'),(40,'Lionel','Messi','Cuchitini',12345539,923897458,'M'),(41,'Luis','Gómez','Pérez',80123451,987654321,'M'),(42,'Maria','López','Vargas',80123452,945612378,'F'),(43,'Carlos','Ramírez','Soto',80123453,923456781,'M'),(44,'Ana','Torres','Mendoza',80123454,987123654,'F'),(45,'Jorge','Salazar','Ríos',80123455,954789123,'M'),(46,'Elena','Fernández','Quispe',80123456,912345678,'F'),(47,'Pedro','Cárdenas','Huamán',80123457,974563218,'M'),(48,'Lucía','Morales','Aguilar',80123458,987987321,'F'),(49,'Héctor','Vásquez','Luna',80123459,956741258,'M'),(50,'Sofia','Paredes','Castro',80123460,913579246,'F'),(51,'Rony','Cueva','Tupia',11223217,982374652,'M'),(52,'Valeria','Sanchez','Ferrara',99999999,989999999,'F'),(53,'Dina','Boluarte','Rodriguez',11111114,998812387,'M');
/*!40000 ALTER TABLE `Persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Polo`
--

DROP TABLE IF EXISTS `Polo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Polo` (
  `idPrenda` int NOT NULL AUTO_INCREMENT,
  `tipo_manga` enum('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos') NOT NULL,
  `estampado` varchar(80) DEFAULT NULL,
  `tipo_cuello` enum('Redondo','V','Camisero','Alto','Halter','OffShoulder','Otro') NOT NULL,
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Polo_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Polo`
--

LOCK TABLES `Polo` WRITE;
/*!40000 ALTER TABLE `Polo` DISABLE KEYS */;
INSERT INTO `Polo` VALUES (1,'MangaCorta','Liso','Redondo'),(7,'MangaCorta','Liso','Redondo'),(8,'MangaCorta','Liso','Redondo'),(21,'MangaCorta','Sin estampado','Redondo'),(22,'MangaCorta','Sin estampado','Redondo'),(23,'MangaCorta','Sin estampado','Redondo'),(24,'MangaCorta','Sin estampado','Redondo'),(25,'MangaCorta','Sin estampado','Redondo'),(26,'MangaCorta','Sin estampado','Redondo'),(27,'MangaCorta','Sin estampado','Redondo'),(28,'MangaCorta','Sin estampado','Redondo'),(29,'MangaCorta','Sin estampado','Redondo'),(30,'MangaCorta','pikachu','Redondo'),(31,'MangaCorta','Pikachu','Redondo'),(32,'Campana','','V'),(33,'MangaLarga','Hulk Comics','Alto'),(40,'MangaCorta','Sin estampado','Redondo'),(41,'MangaCorta','Sin estampado','Redondo'),(42,'MangaCorta','Sin estampado','Redondo'),(43,'MangaCorta','Sin estampado','Redondo'),(44,'MangaCorta','Sin estampado','Redondo'),(45,'MangaCorta','Marvel','Redondo'),(47,'MangaCorta','Sin estampado','Redondo'),(48,'MangaCorta','Sin estampado','Redondo'),(49,'MangaCorta','Sin estampado','Redondo'),(50,'MangaCorta','Sin estampado','Redondo'),(51,'MangaCorta','Sin estampado','Redondo'),(52,'MangaCorta','Sin estampado','Redondo'),(53,'MangaCorta','Sin estampado','Redondo'),(54,'MangaCorta','Sin estampado','Redondo'),(55,'MangaCorta','Sin estampado','Redondo'),(56,'MangaCorta','Sin estampado','Redondo'),(57,'MangaCorta','Sin estampado','Redondo'),(58,'MangaCorta','Sin estampado','Redondo'),(59,'MangaCorta','','V'),(60,'MangaCorta','','V'),(61,'MangaCorta','','V'),(62,'MangaLarga','Dua lipa #3','V'),(63,'MangaCorta','Sin estampado','Redondo'),(64,'MangaCorta','Sin estampado','Redondo'),(65,'MangaCorta','Sin estampado','Redondo'),(66,'MangaCorta','Sin estampado','Redondo'),(67,'MangaCorta','Sin estampado','Redondo'),(68,'MangaCorta','Sin estampado','Redondo'),(69,'MangaCorta','Sin estampado','Redondo'),(70,'MangaCorta','Sin estampado','Redondo'),(71,'MangaCorta','Sin estampado','Redondo'),(72,'MangaCorta','Sin estampado','Redondo'),(73,'MangaCorta','Sin estampado','Redondo'),(74,'MangaCorta','Sin estampado','Redondo'),(75,'MangaCorta','Sin estampado','Redondo'),(76,'MangaCorta','Sin estampado','Redondo'),(77,'MangaCorta','Sin estampado','Redondo'),(78,'MangaCorta','Sin estampado','Redondo'),(79,'MangaCorta','Sin estampado','Redondo'),(80,'MangaCorta','Sin estampado','Redondo'),(81,'MangaCorta','Sin estampado','Redondo'),(82,'MangaCorta','Sin estampado','Redondo'),(83,'MangaCorta','Sin estampado','Redondo'),(84,'MangaCorta','Sin estampado','Redondo'),(85,'MangaCorta','Sin estampado','Redondo'),(86,'MangaCorta','Sin estampado','Redondo'),(87,'MangaCorta','Sin estampado','Redondo'),(88,'MangaCorta','Sin estampado','Redondo'),(89,'MangaCorta','Sin estampado','Redondo'),(90,'MangaCorta','Sin estampado','Redondo'),(91,'MangaCorta','Sin estampado','Redondo'),(92,'MangaCorta','Sin estampado','Redondo'),(93,'MangaCorta','Sin estampado','Redondo'),(94,'MangaCorta','Sin estampado','Redondo'),(95,'MangaCorta','Sin estampado','Redondo'),(96,'MangaCorta','Sin estampado','Redondo'),(97,'MangaCorta','Sin estampado','Redondo'),(98,'MangaCorta','Sin estampado','Redondo'),(99,'MangaCorta','NO tiene','V'),(100,'MangaCorta','','OffShoulder'),(101,'SinManga','','Camisero');
/*!40000 ALTER TABLE `Polo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prenda`
--

DROP TABLE IF EXISTS `Prenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prenda` (
  `idPrenda` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `stockPrenda` int NOT NULL DEFAULT '0',
  `alertaMinStock` int NOT NULL,
  `activo` tinyint NOT NULL,
  `precioUnidad` decimal(10,2) NOT NULL DEFAULT '0.00',
  `precioMayor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `precioDocena` decimal(10,2) NOT NULL DEFAULT '0.00',
  `material` enum('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon','Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina','Polar','Franela','Cuero','Cuerina','Saten','Chifon') NOT NULL DEFAULT 'Algodon',
  `total_vendida` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPrenda`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prenda`
--

LOCK TABLES `Prenda` WRITE;
/*!40000 ALTER TABLE `Prenda` DISABLE KEYS */;
INSERT INTO `Prenda` VALUES (1,'Polo básico blanco','Blanco',60,10,1,25.00,20.00,220.00,'Algodon',0),(2,'Blusa chiffon manga larga','Beige',40,8,1,55.00,45.00,480.00,'Chifon',0),(3,'Casaca denim azul','Azul',30,5,1,120.00,100.00,1100.00,'Denim',0),(4,'Falda plisada midi','Rosa',25,5,1,70.00,60.00,650.00,'Lino',0),(5,'Pantalón jean tiro alto','Azul',50,10,1,90.00,75.00,780.00,'Denim',0),(6,'Gorro bucket negro','Negro',35,5,1,35.00,30.00,340.00,'Algodon',0),(7,'Polo básico celeste','Celeste',55,10,1,29.00,25.00,260.00,'Algodon',0),(8,'Polo deportivo gris','Gris',60,12,1,32.00,28.00,300.00,'Poliester',0),(9,'Blusa ligera manga corta','Blanco',45,8,1,58.00,50.00,520.00,'Chifon',0),(10,'Blusa satinada rosa','Rosa pastel',30,6,1,70.00,60.00,680.00,'Saten',0),(11,'Casaca drill beige','Beige',25,5,1,150.00,130.00,1350.00,'Drill',0),(12,'Casaca polar invierno','Gris oscuro',28,5,1,140.00,120.00,1280.00,'Polar',0),(13,'Falda midi lino beige','Beige',32,6,1,90.00,78.00,820.00,'Lino',0),(14,'Falda mini denim negro','Negro',40,7,1,75.00,65.00,700.00,'Denim',0),(15,'Pantalón gabardina beige','Beige',38,7,1,110.00,95.00,900.00,'Gabardina',0),(16,'Pantalón drill negro','Negro',42,8,1,105.00,92.00,880.00,'Drill',0),(17,'Gorro lana tejido','Mostaza',50,8,1,40.00,34.00,330.00,'Lana',0),(18,'Bucket cuerina negro','Negro',48,8,1,45.00,38.00,390.00,'Cuerina',0),(21,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(22,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(23,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(24,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(25,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(26,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(27,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(28,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(29,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(30,'polo pikachu','amarillo',0,3,0,12.00,11.00,10.00,'Algodon',0),(31,'Polo Pokemon','Amarillo',0,3,0,12.00,11.00,10.00,'Algodon',0),(32,'Polo Rosado Lacito','Blanco',0,3,0,15.00,13.00,12.00,'Poliester',0),(33,'Polo Marvel Iron man Estampado','Negro',0,4,1,30.00,28.00,25.00,'Algodon',25),(34,'Falda Cuero Rojizo','Rojo Vino',0,3,1,46.00,43.00,40.00,'Cuero',2),(35,'Gorro Deportivo #3','Negro',0,4,0,36.00,33.00,32.00,'Poliester',0),(36,'Vestido Corto Claro','Denim Claro',0,10,1,45.00,43.00,40.00,'Denim',104),(37,'Pantalon Cargo Dama','Gris',0,5,1,45.00,43.00,40.00,'Drill',11),(38,'Cardigan Taylor Swift Folklore','Blanco',0,4,1,35.00,33.00,32.00,'Lana',1633),(39,'Blusa Mujer #4','Celeste',0,5,1,32.00,31.00,30.00,'Lino',4),(40,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(41,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(42,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(43,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(44,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(45,'Polo niños #3','Rojo',0,4,0,13.00,12.00,11.00,'Algodon',0),(46,'Pantalon Hombre #4','Gris',0,2,1,30.00,28.00,25.00,'Drill',25),(47,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(48,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(49,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(50,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(51,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(52,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(53,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(54,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(55,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(56,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(57,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(58,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(59,'Polo de Undertale','Blanco',0,10,1,100.00,50.00,25.00,'Algodon',3),(60,'Polo de Undertale','Blanco',0,10,0,100.00,50.00,25.00,'Algodon',0),(61,'Polo de Undertale','Blanco',0,10,0,100.00,50.00,25.00,'Algodon',0),(62,'Polo Concierto de Dua Lipa','Negro',0,4,1,55.00,50.00,45.00,'Algodon',4),(63,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(64,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(65,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(66,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(67,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(68,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(69,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(70,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(71,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(72,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(73,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(74,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(75,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(76,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(77,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(78,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(79,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(80,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(81,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(82,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(83,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(84,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(85,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(86,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(87,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(88,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(89,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(90,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(91,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(92,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(93,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(94,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(95,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(96,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(97,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(98,'Polo Premium','Negro',0,15,0,39.90,33.00,330.00,'Algodon',0),(99,'Polo KDA v2','Morado',0,111,1,35.00,33.00,30.00,'Nylon',0),(100,'Polo Alola ','',0,55,0,27.00,23.00,20.00,'Nylon',0),(101,'Polo lumi','mOrAdO',0,45,0,40.00,37.00,34.00,'Denim',0),(102,'Casaca pam','Morado',0,111,1,40.00,37.00,34.00,'Gabardina',0),(103,'Vestido de Gala #11','Celeste',0,20,1,10.00,8.00,7.00,'Algodon',0),(104,'Vestido de Gala #11','Celeste',0,12,0,10.00,8.00,7.00,'Poliester',0);
/*!40000 ALTER TABLE `Prenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrendaDescuento`
--

DROP TABLE IF EXISTS `PrendaDescuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PrendaDescuento` (
  `idPrenda` int NOT NULL,
  `idDescuento` int NOT NULL,
  `activo` tinyint DEFAULT NULL,
  PRIMARY KEY (`idPrenda`,`idDescuento`),
  KEY `idDescuento` (`idDescuento`),
  CONSTRAINT `PrendaDescuento_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`),
  CONSTRAINT `PrendaDescuento_ibfk_2` FOREIGN KEY (`idDescuento`) REFERENCES `Descuento` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrendaDescuento`
--

LOCK TABLES `PrendaDescuento` WRITE;
/*!40000 ALTER TABLE `PrendaDescuento` DISABLE KEYS */;
/*!40000 ALTER TABLE `PrendaDescuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrendaLote`
--

DROP TABLE IF EXISTS `PrendaLote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PrendaLote` (
  `idPrendaLote` int NOT NULL AUTO_INCREMENT,
  `Prenda_idPrenda` int NOT NULL,
  `Lote_idLote` int NOT NULL,
  `stock` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `talla` enum('XS','S','M','L','XL','XXL') NOT NULL,
  PRIMARY KEY (`idPrendaLote`,`Prenda_idPrenda`,`Lote_idLote`),
  UNIQUE KEY `idPrendaLote_UNIQUE` (`idPrendaLote`),
  KEY `fk_Prenda_has_Lote_Lote1_idx` (`Lote_idLote`),
  KEY `fk_Prenda_has_Lote_Prenda1_idx` (`Prenda_idPrenda`),
  CONSTRAINT `fk_Prenda_has_Lote_Lote1` FOREIGN KEY (`Lote_idLote`) REFERENCES `Lote` (`idLote`),
  CONSTRAINT `fk_Prenda_has_Lote_Prenda1` FOREIGN KEY (`Prenda_idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrendaLote`
--

LOCK TABLES `PrendaLote` WRITE;
/*!40000 ALTER TABLE `PrendaLote` DISABLE KEYS */;
INSERT INTO `PrendaLote` VALUES (6,21,1,20,1,'M'),(9,22,1,3,1,'M'),(10,22,2,7,1,'M'),(11,22,1,5,1,'M'),(12,22,2,10,1,'M'),(13,37,44,120,1,'XXL'),(14,33,1,10,1,'XS'),(15,33,1,15,1,'S'),(16,33,1,25,1,'M'),(17,33,1,0,1,'L'),(18,33,1,8,1,'XL'),(19,33,1,10,1,'XS'),(20,33,1,20,1,'S'),(21,33,1,25,1,'M'),(22,33,1,10,1,'L'),(23,33,1,8,1,'XL'),(24,33,1,5,1,'M'),(25,33,1,3,1,'L'),(26,33,2,7,1,'M'),(27,33,2,6,1,'L'),(32,21,1,40,1,'L'),(33,21,2,54,1,'S'),(34,22,2,60,1,'S'),(35,37,1,5,0,'XS'),(36,38,1,0,1,'M'),(37,34,1,728,1,'M'),(38,34,1,40,1,'L'),(39,46,1,5,1,'L'),(40,38,15,0,1,'L'),(41,37,13,478,1,'L'),(42,37,9,123,1,'L'),(43,46,6,566,1,'M'),(44,38,6,0,1,'L'),(45,37,3,111,1,'L'),(46,38,4,958,1,'M'),(47,103,17,9,1,'XS');
/*!40000 ALTER TABLE `PrendaLote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrendaPromocion`
--

DROP TABLE IF EXISTS `PrendaPromocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PrendaPromocion` (
  `idPrenda` int NOT NULL,
  `idPromocion` int NOT NULL,
  `activo` tinyint DEFAULT NULL,
  PRIMARY KEY (`idPrenda`,`idPromocion`),
  KEY `idPromocion` (`idPromocion`),
  CONSTRAINT `PrendaPromocion_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`),
  CONSTRAINT `PrendaPromocion_ibfk_2` FOREIGN KEY (`idPromocion`) REFERENCES `Promocion` (`idPromocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrendaPromocion`
--

LOCK TABLES `PrendaPromocion` WRITE;
/*!40000 ALTER TABLE `PrendaPromocion` DISABLE KEYS */;
/*!40000 ALTER TABLE `PrendaPromocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Promocion`
--

DROP TABLE IF EXISTS `Promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Promocion` (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(75) DEFAULT NULL,
  `esAutomatico` tinyint DEFAULT NULL,
  `activo` tinyint DEFAULT NULL,
  `idVigencia` int DEFAULT NULL,
  PRIMARY KEY (`idPromocion`),
  KEY `idVigencia` (`idVigencia`),
  CONSTRAINT `Promocion_ibfk_1` FOREIGN KEY (`idVigencia`) REFERENCES `Vigencia` (`idVigencia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promocion`
--

LOCK TABLES `Promocion` WRITE;
/*!40000 ALTER TABLE `Promocion` DISABLE KEYS */;
INSERT INTO `Promocion` VALUES (1,'Combo Estrella',1,1,1),(2,'Oferta Noviembre',1,1,1),(3,'Paz',1,0,2);
/*!40000 ALTER TABLE `Promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromocionCombo`
--

DROP TABLE IF EXISTS `PromocionCombo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PromocionCombo` (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `cantidadRequerida` int DEFAULT NULL,
  `cantidadGratis` int DEFAULT NULL,
  PRIMARY KEY (`idPromocion`),
  CONSTRAINT `PromocionCombo_ibfk_1` FOREIGN KEY (`idPromocion`) REFERENCES `Promocion` (`idPromocion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromocionCombo`
--

LOCK TABLES `PromocionCombo` WRITE;
/*!40000 ALTER TABLE `PromocionCombo` DISABLE KEYS */;
INSERT INTO `PromocionCombo` VALUES (1,10,11),(2,10,1),(3,10,1);
/*!40000 ALTER TABLE `PromocionCombo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromocionConjunto`
--

DROP TABLE IF EXISTS `PromocionConjunto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PromocionConjunto` (
  `idPromocion` int NOT NULL AUTO_INCREMENT,
  `porcentajePromocion` float DEFAULT NULL,
  PRIMARY KEY (`idPromocion`),
  CONSTRAINT `PromocionConjunto_ibfk_1` FOREIGN KEY (`idPromocion`) REFERENCES `Promocion` (`idPromocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromocionConjunto`
--

LOCK TABLES `PromocionConjunto` WRITE;
/*!40000 ALTER TABLE `PromocionConjunto` DISABLE KEYS */;
/*!40000 ALTER TABLE `PromocionConjunto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proveedor`
--

DROP TABLE IF EXISTS `Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Proveedor` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `RUC` bigint NOT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  `telefono` int NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proveedor`
--

LOCK TABLES `Proveedor` WRITE;
/*!40000 ALTER TABLE `Proveedor` DISABLE KEYS */;
INSERT INTO `Proveedor` VALUES (1,20123456789,'Distribuidora Andina S.A.',987654321,'Av. Los Olivos 345, Lima',0),(2,20456789123,'TecnoMundo EIRL',956741258,'Jr. Puno 1120, Arequipa',0),(3,20678912345,'AgroPerú SAC',983456789,'Carretera Central Km 12, Chosica',1),(4,20891234567,'Papelería Universal SRL',912345678,'Calle Las Magnolias 45, Trujillo',1),(5,20111222334,'Importadora Mar Azul SAC',921478965,'Av. Grau 560, Piura',1),(6,20567891234,'Insumos Médicos del Sur EIRL',998745632,'Av. La Cultura 789, Cusco',1),(7,20987654321,'Ferretería San Pedro SAC',934567812,'Jr. Ancash 230, Huancayo',0),(8,20234567891,'Textiles del Norte S.A.',965874123,'Av. Túpac Amaru 980, Chiclayo',1),(9,20765432198,'ElectroHouse EIRL',987321654,'Calle Los Laureles 150, Lima',1),(10,20345678912,'Repuestos Industriales R&R SAC',976543210,'Av. Arequipa 890, Lima',0),(11,12345678900,'Proveedor de prueba',999999999,'Dirección X',1),(12,12345678910,'TextilesCO',987655788,'Camino, sector 7',1),(13,12345678910,'Proveedor Modificado',99988877,'fsdfsdf',0),(14,12345678910,'Proveedor Ejemplo2',99988877,'Av. Los Olivos 123',1),(15,12345678910,'Proveedor Ejemplo',99988877,'Av. Los Olivos 123',1),(16,12345678910,'Proveedor Ejemplo1212',99988877,'Av. Los Olivos 123',1),(17,12345678910,'Proveedor Ejemplo222222',99988877,'Av. Los Olivos 123',0),(18,12345678910,'Proveedor Ejemplo234234',99988877,'Av. Los Olivos 123',1),(19,12345678910,'Prvox',99988877,'Av. Los Olivos 123',1),(20,12345678910,'Provvvv',99988877,'Av. Los Olivos 123',1),(21,12345678910,'Preeee',99988877,'Av. Los Olivos 345, Lima',1),(22,12345678910,'Pravx',99988877,'Av. prueba',1),(23,12345678910,'TextilesCO',987655788,'Camino, sector 7',1),(24,12345678910,'TextilesCO',987655788,'Camino, sector 7',1),(25,20456789123,'Prov5',956741258,'Av. Los Olivos 123',1),(26,20456789123,'NuevoProv2',99988877,'Jr. Puno 1120, Arequipa',1),(27,12345678901,'Matias',912837127,'Av. Paz',1);
/*!40000 ALTER TABLE `Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tienda`
--

DROP TABLE IF EXISTS `Tienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tienda` (
  `idTienda` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) DEFAULT NULL,
  `ubicacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTienda`),
  UNIQUE KEY `idTienda_UNIQUE` (`idTienda`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tienda`
--

LOCK TABLES `Tienda` WRITE;
/*!40000 ALTER TABLE `Tienda` DISABLE KEYS */;
INSERT INTO `Tienda` VALUES (1,'WearDrop','Calle 7, Edificio 253 Piso 3'),(2,'WearDrop - Lima Centro','Av. Arequipa 1234, Lima');
/*!40000 ALTER TABLE `Tienda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoCuenta`
--

DROP TABLE IF EXISTS `TipoCuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TipoCuenta` (
  `idTipoCuenta` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) DEFAULT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idTipoCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoCuenta`
--

LOCK TABLES `TipoCuenta` WRITE;
/*!40000 ALTER TABLE `TipoCuenta` DISABLE KEYS */;
INSERT INTO `TipoCuenta` VALUES (4,'Administrador',1),(5,'Jefe de Almacen',1);
/*!40000 ALTER TABLE `TipoCuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TipoDeCliente`
--

DROP TABLE IF EXISTS `TipoDeCliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TipoDeCliente` (
  `tipoCliente` int NOT NULL,
  `abreviatura` char(1) NOT NULL,
  `descripcion` varchar(120) NOT NULL,
  PRIMARY KEY (`tipoCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TipoDeCliente`
--

LOCK TABLES `TipoDeCliente` WRITE;
/*!40000 ALTER TABLE `TipoDeCliente` DISABLE KEYS */;
INSERT INTO `TipoDeCliente` VALUES (6,'M','Mayorista'),(7,'m','Minorista');
/*!40000 ALTER TABLE `TipoDeCliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Venta`
--

DROP TABLE IF EXISTS `Venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venta` (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `Empleado_idEmpleado` int NOT NULL,
  `Cliente_idCliente` int NOT NULL,
  `Comprobante_idComprobante` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`idVenta`),
  KEY `fk_Empleado_idEmpleado10_idx` (`Empleado_idEmpleado`),
  KEY `fk_Cliente_idCliente10_idx` (`Cliente_idCliente`),
  KEY `fk_Comprobante_idComprobante10_idx` (`Comprobante_idComprobante`),
  CONSTRAINT `fk_Cliente_idCliente10` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`),
  CONSTRAINT `fk_Comprobante_idComprobante10` FOREIGN KEY (`Comprobante_idComprobante`) REFERENCES `ComprobanteDePago` (`idComprobante`),
  CONSTRAINT `fk_Empleado_idEmpleado10` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venta`
--

LOCK TABLES `Venta` WRITE;
/*!40000 ALTER TABLE `Venta` DISABLE KEYS */;
INSERT INTO `Venta` VALUES (1,'2025-11-18 22:55:22',200.00,1,26,4,0),(15,'2025-10-01 00:00:00',900.00,2,20,8,0),(16,'2025-09-01 00:00:00',2000.00,2,20,8,0),(17,'2025-11-20 10:00:00',137.00,1,26,8,0),(18,'2025-11-20 16:30:00',205.00,2,20,8,0),(19,'2025-11-21 11:15:00',313.00,1,20,8,1),(21,'2025-11-23 00:00:00',325.00,1,23,20,1),(22,'2025-11-23 00:00:00',480.00,1,24,21,1),(23,'2025-11-23 00:00:00',480.00,1,23,23,1),(24,'2025-11-24 00:00:00',5760.00,1,24,24,1),(25,'2025-11-24 00:00:00',576.00,43,25,29,1),(26,'2025-11-24 00:00:00',576.00,1,25,26,1),(27,'2025-11-24 00:00:00',473.00,43,24,32,1),(28,'2025-11-24 00:00:00',640.00,43,20,33,1),(29,'2025-11-24 00:00:00',10.00,39,52,37,1);
/*!40000 ALTER TABLE `Venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `actualizar_tipo_cliente_despues_insertar` AFTER INSERT ON `Venta` FOR EACH ROW BEGIN
    DECLARE cliente_id INT;
    DECLARE venta_total DECIMAL(10,2);
    
    -- Obtener el ID del cliente y el total de la venta insertada
    SET cliente_id = NEW.Cliente_idCliente;
    SET venta_total = NEW.total;
    
    -- Actualizar el tipo de cliente según el total
    IF venta_total >= 500 THEN
        UPDATE Cliente 
        SET tipoCliente = 6 
        WHERE idCliente = cliente_id;
    ELSE
        UPDATE Cliente 
        SET tipoCliente = 7 
        WHERE idCliente = cliente_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `actualizar_tipo_cliente_despueus_de_modficar` AFTER UPDATE ON `Venta` FOR EACH ROW BEGIN
    DECLARE cliente_id INT;
    DECLARE venta_total DECIMAL(10,2);
    
    -- Solo procesar si el total cambió y la venta está activa
    IF NEW.total != OLD.total AND NEW.activo = 1 THEN
        SET cliente_id = NEW.Cliente_idCliente;
        SET venta_total = NEW.total;
        
        -- Actualizar el tipo de cliente según el total
        IF venta_total >= 500 THEN
            UPDATE Cliente 
            SET tipoCliente = 6 
            WHERE idCliente = cliente_id;
        ELSE
            UPDATE Cliente 
            SET tipoCliente = 7 
            WHERE idCliente = cliente_id;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Vestido`
--

DROP TABLE IF EXISTS `Vestido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vestido` (
  `idPrenda` int NOT NULL,
  `tipo_vestido` enum('Coctel','Fiesta','Gala','Playa','Ejecutivo','Maxi','Mini','Casual') NOT NULL,
  `largo` int NOT NULL,
  `tipo_manga` enum('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos') NOT NULL,
  PRIMARY KEY (`idPrenda`),
  CONSTRAINT `Vestido_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `Prenda` (`idPrenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vestido`
--

LOCK TABLES `Vestido` WRITE;
/*!40000 ALTER TABLE `Vestido` DISABLE KEYS */;
INSERT INTO `Vestido` VALUES (36,'Casual',90,'SinManga'),(103,'Gala',20,'Globo'),(104,'Playa',20,'SinManga');
/*!40000 ALTER TABLE `Vestido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vigencia`
--

DROP TABLE IF EXISTS `Vigencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vigencia` (
  `idVigencia` int NOT NULL AUTO_INCREMENT,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idVigencia`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vigencia`
--

LOCK TABLES `Vigencia` WRITE;
/*!40000 ALTER TABLE `Vigencia` DISABLE KEYS */;
INSERT INTO `Vigencia` VALUES (1,'2025-12-11','2025-12-20',1),(2,'2025-11-24','2025-12-25',1);
/*!40000 ALTER TABLE `Vigencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `ev_desactivar_por_vigencia` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`admin`@`%`*/ /*!50106 EVENT `ev_desactivar_por_vigencia` ON SCHEDULE EVERY 1 DAY STARTS '2025-11-22 22:52:14' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- 1) Desactivar vigencias vencidas
    UPDATE vigencia v
    SET v.activo = 0
    WHERE v.activo = 1
      AND v.fechaFin < CURDATE();

    -- 2) Desactivar promociones asociadas a vigencias vencidas
    UPDATE promocion p
    JOIN vigencia v ON p.idVigencia = v.idVigencia
    SET p.activo = 0
    WHERE p.activo = 1
      AND v.fechaFin < CURDATE();

    -- 3) Desactivar descuentos asociados a vigencias vencidas
    UPDATE descuento d
    JOIN vigencia v ON d.idVigencia = v.idVigencia
    SET d.activo = 0
    WHERE d.activo = 1
      AND v.fechaFin < CURDATE();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `buscar_prenda_por_atributos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `buscar_prenda_por_atributos`(
    IN _nombre VARCHAR(100),
    IN _color VARCHAR(30),
    IN _material VARCHAR(50)
)
BEGIN
    SELECT 
        idPrenda,
        nombre,
        color,
        material,
        precioUnidad,
        precioMayor,
        precioDocena,
        stockPrenda,
        alertaMinStock,
        activo
    FROM Prenda
    WHERE nombre = _nombre 
      AND color = _color 
      AND material = _material 
      AND activo = 1
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_almacen`(
	_idAlmacen int
)
BEGIN 
	UPDATE Almacen
    SET activo=0 
    WHERE idAlmacen=_idAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_blusa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_blusa`(
    IN _idPrenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _idPrenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_boleta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_boleta`(
    IN _id_Comprobante INT
)
BEGIN
    UPDATE ComprobanteDePago
       SET activa = 0
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_cargo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_cargo`(
	IN _idCargo INT
)
BEGIN
	UPDATE Cargo SET activo = 0
    WHERE idCargo=_idCargo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_casaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_casaca`(
    IN _idPrenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _idPrenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_cliente`(
	IN _idCliente INT)
BEGIN
  
  UPDATE Cliente SET activo=0
  WHERE idCliente=_idCliente;
 
  
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_cuentaUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_cuentaUsuario`(
	IN _idCuenta INT
)
BEGIN
	UPDATE CuentaUsuario SET activo = 0
    WHERE idCuenta=_idCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_descuentoLiquidacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_descuentoLiquidacion`(in id int)
BEGIN
		update Descuento 
        set activo=0
        where idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_descuentoMonto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_descuentoMonto`(in id int)
BEGIN
		update Descuento 
        set activo=0
        where idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_descuentoPorcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_descuentoPorcentaje`(in id int)
BEGIN
		update Descuento 
        set activo=0
        where idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_devolucion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_devolucion`(
    IN _idDevolucion INT
)
BEGIN
    UPDATE Devolucion
    SET activo = 0
    WHERE idDevolucion = _idDevolucion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_empleado`(
	IN _idEmpleado INT
)
BEGIN
	UPDATE Empleado SET activo = 0
    WHERE idEmpleado=_idEmpleado;
    UPDATE CuentaUsuario SET activo=0
    WHERE fid_empleado=_idEmpleado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_factura`(
    IN _id_Comprobante INT
)
BEGIN
    UPDATE ComprobanteDePago
       SET activa = 0
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_falda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_falda`(
		IN _idPrenda INT )
BEGIN
  UPDATE Prenda SET activo=0
  WHERE idPrenda=_idPrenda;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_gorro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_gorro`(
    IN _idPrenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _idPrenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_lote`(
	_idLote int
)
BEGIN
	UPDATE Lote SET activo=0
	WHERE idLote=_idLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_mov_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_mov_almacen`(
	_idMovAlmacen INT
)
BEGIN
	UPDATE MovimientoAlmacen
    SET activo=0
    WHERE idMovAlmacen=_idMovAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_mov_X_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_mov_X_lote`(
	_idMovAlmacen_X_Lote int
)
BEGIN
    UPDATE MovimientoAlmacen_X_Lote SET activo=0
	WHERE idMovAlmacen_X_Lote=_idMovAlmacen_X_Lote;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_nota_de_credito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_nota_de_credito`(
    IN _id_Comprobante INT
)
BEGIN
    UPDATE ComprobanteDePago
       SET activa = 0
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_nota_de_debito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_nota_de_debito`(
    IN _id_Comprobante INT
)
BEGIN
    UPDATE ComprobanteDePago
       SET activa = 0
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_orden_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_orden_compra`(
	IN _idCompra INT
)
BEGIN
	UPDATE OrdenCompra SET activo = 0 
    WHERE idCompra = _idCompra ;
    
    UPDATE LineaLoteCompra 
    SET activo = 0 
    WHERE OrdenCompra_idCompra = _idCompra;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_pantalon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_pantalon`(
    IN _idPrenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _idPrenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_polo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_polo`(
    IN _id_prenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_prendadescuento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_prendadescuento`(in indP int, in indDesc int)
begin
update PrendaDescuento
    set activo=0
    where idPrenda=indP and idDescuento=indDesc;    
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_prendapromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_prendapromocion`(in indP int, in indPro int)
begin
    update PrendaPromocion
    set activo=0
    where idPrenda=indP and idPromocion=indPro;
    
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_prenda_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_prenda_lote`(
    IN _id_prenda_lote INT
)
BEGIN
  UPDATE PrendaLote
     SET activo = 0
   WHERE idPrendaLote = _id_prenda_lote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_promocioncombo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_promocioncombo`(in id int)
BEGIN
		update Promocion 
        set activo=0
        where idPromocion=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_promocionconjunto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_promocionconjunto`(in id int)
BEGIN
		update Promocion 
        set activo=0
        where idPromocion=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_proveedor`(
		IN _idProveedor INT )
BEGIN
  UPDATE Proveedor SET activo=0
  WHERE idProveedor=_idProveedor;
  
  
  UPDATE CondicionPago
    SET vigente = 0
    WHERE Proveedor_idProveedor = _idProveedor ;
  
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_tipoCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_tipoCuenta`(
	IN _idTipoCuenta INT
)
BEGIN
	UPDATE TipoCuenta SET activo = 0
    WHERE idTipoCuenta=_idTipoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_venta`(
	IN _idVenta INT
)
BEGIN
	UPDATE Venta SET activo = 0 
    WHERE idVenta = _idVenta ;
    
    UPDATE ItemVenta 
    SET activo = 0 
    WHERE Venta_idVenta = _idVenta;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_vestido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_vestido`(
    IN _idPrenda INT
)
BEGIN
  UPDATE Prenda
     SET activo = 0
   WHERE idPrenda = _idPrenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_vigencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `eliminar_vigencia`(in id int)
BEGIN
		update Vigencia 
        set activo=0
        where idVigencia=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `existe_prenda_talla_en_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `existe_prenda_talla_en_lote`(
    IN _idPrenda INT,
    IN _talla VARCHAR(10),
    IN _idLote INT
)
BEGIN
    SELECT COUNT(*) as cantidad
    FROM PrendaLote
    WHERE Prenda_idPrenda = _idPrenda
      AND talla = _talla
      AND Lote_idLote = _idLote
      AND activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_blusa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_blusa`()
BEGIN
    SELECT
        p.*,
        b.*         -- campos específicos de Blusa
    FROM Prenda p
    JOIN Blusa b ON b.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_casaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_casaca`()
BEGIN
    SELECT
        p.*,
        c.*          -- campos específicos de Casaca
    FROM Prenda p
    JOIN Casaca c ON c.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_falda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_falda`()
BEGIN
    SELECT
        p.*,
        f.*          -- campos específicos de Falda
    FROM Prenda p
    JOIN Falda f ON f.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_gorro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_gorro`()
BEGIN
    SELECT
        p.*,
        g.*          -- campos específicos de Gorro
    FROM Prenda p
    JOIN Gorro g ON g.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_pantalon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_pantalon`()
BEGIN
    SELECT
        p.*,
        pa.*         -- campos específicos de Pantalon
    FROM Prenda p
    JOIN Pantalon pa ON pa.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_polo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_polo`()
BEGIN
    SELECT
        p.*,
        po.*           -- campos específicos de Polo
    FROM Prenda p
    JOIN Polo po ON po.idPrenda = p.idPrenda
	WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filtrar_vestido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `filtrar_vestido`()
BEGIN
    SELECT
        p.*,
        v.*          -- campos específicos de Vestido
    FROM Prenda p
    JOIN Vestido v ON v.idPrenda = p.idPrenda
    WHERE p.activo = 1
    ORDER BY p.total_vendida DESC, p.nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_almacen`(
    OUT _id_almacen INT,
    IN _nombre VARCHAR(70),
    IN _ubicacion VARCHAR(70),
    IN _Tienda_idTienda INT
)
BEGIN
    INSERT INTO Almacen(nombre, ubicacion, Activo, Tienda_idTienda)
    VALUES (_nombre, _ubicacion, 1, _Tienda_idTienda);
    
    SET _id_almacen = @@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_blusa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_blusa`(
    OUT _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_blusa ENUM('Camisera','CropTop','Peplum','OffShoulder','Transparente','Formal','Casual'),
    IN  _tipo_manga ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos')
)
BEGIN
    INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = LAST_INSERT_ID();

    INSERT INTO Blusa(idPrenda, tipo_blusa, tipo_manga)
    VALUES(_id_prenda, _tipo_blusa, _tipo_manga);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_boleta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_boleta`(
	OUT _id_Comprobante INT,
	IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV   DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DNI VARCHAR(8)
)
BEGIN	
	INSERT INTO ComprobanteDePago(
    fecha,total,IGV,metodoDePago,correlativo,activa)
    VALUES (_FECHA,_TOTAL,_IGV,_METODOPAGO,_CORRELATIVO,1);
    SET _id_Comprobante = @@last_insert_id;
	INSERT INTO Boleta(idComprobante,DNI)
    VALUES (_id_Comprobante,_DNI);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_cargo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_cargo`(
	OUT _idCargo INT,
    IN _abreviatura CHAR,
    IN _descripcion VARCHAR(75)
)
BEGIN
	INSERT INTO Cargo (abreviatura,descripcion,activo) VALUES (
		_abreviatura,_descripcion,1);
	SET _idCargo = @@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_casaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_casaca`(
	OUT  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_casaca  ENUM('Bomber','Puffer','Denim','Deportiva','Cuero','Cardigan','Otro'),
    IN  _con_capucha TINYINT    
)
BEGIN
	INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = @@last_insert_id;

    INSERT INTO Casaca(idPrenda, tipo_casaca, con_capucha)
    VALUES(_id_prenda, _tipo_casaca, _con_capucha);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_cliente`(  
	OUT _idCliente INT,     
	IN _nombre VARCHAR(75),
    IN _primerApellido VARCHAR(75),   
	IN _segundoApellido VARCHAR(75),
	IN _dni INT,
	IN _telefono INT, 
	IN _genero CHAR , 
    IN _abreviatura CHAR,
    IN DESCRIPC VARCHAR(75),
    IN _tipoCliente INT
  )
BEGIN  
  
  INSERT INTO Persona(nombre, primerApellido,segundoApellido,
  dni,telefono, genero) 
  VALUES (_nombre, _primerApellido, _segundoApellido, _dni ,
   _telefono  , _genero);  

  SET _idCliente = @@last_insert_id;
  
  INSERT INTO Cliente(idCliente,tipoCliente,activo)
  VALUES (_idCliente,_tipoCliente,1);
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_condicion_de_pago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_condicion_de_pago`( 
  OUT _idCondicion INT,     
  IN _descripcion VARCHAR(120),  
  IN _numDias INT,   
  IN _vigente TINYINT,    
  IN _Proveedor_idProveedor INT)
BEGIN
  
  
  INSERT INTO  CondicionPago (descripcion
  , numDias,
  vigente, 
  Proveedor_idProveedor) 
  VALUES (_descripcion, _numDias,
  1 ,_Proveedor_idProveedor ); 
  
  SET _idCondicion = @@last_insert_id; 
  
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_cuentaUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_cuentaUsuario`(
    OUT _idCuenta INT,
    IN _username VARCHAR(75),
    IN _contrasenha VARCHAR(100), -- Aumentamos a 100 por seguridad (SHA-256 usa 64)
    IN _email VARCHAR(75),
    IN _TipoCuenta_idTipoCuenta INT,
    IN _fid_empleado INT
)
BEGIN
    INSERT INTO CuentaUsuario (
        username,
        contrasenha,
        email,
        TipoCuenta_idTipoCuenta,
        activo,
        fid_empleado
    ) 
    VALUES (
        _username,
        _contrasenha, -- <--- ¡CAMBIO AQUÍ! Quitamos MD5(). Se guarda tal cual llega.
        _email,
        _TipoCuenta_idTipoCuenta,
        1,
        _fid_empleado
    );
    
    SET _idCuenta = last_insert_id();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_descuentoliquidacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_descuentoliquidacion`(out id INT,in nom VARCHAR(75),in porcentaje float,in stock int,in idV int)
begin 
	insert into Descuento (nombre,activo,esAutomatico,idVigencia) values (nom,1,1,idV);
	set id=@@last_insert_id;
    insert into DescuentoLiquidacion(idDescuento,porcentajeLiquidacion,condicionStockMin) values (id,porcentaje,stock);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_descuentomonto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_descuentomonto`(out id INT,in nom VARCHAR(75),in montoE float,in montoM float,in idV int)
begin 
	insert into Descuento (nombre,activo,esAutomatico,idVigencia) values (nom,1,1,idV);
	set id=@@last_insert_id;
    insert into DescuentoMonto(idDescuento,montoEditable,montoMaximo) values (id,montoE,montoM);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_descuentoporcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_descuentoporcentaje`(out id INT,in nom VARCHAR(75),in porcentaje float,in idV int)
begin 
	insert into Descuento (nombre,activo,esAutomatico,idVigencia) values (nom,1,1,idV);
	set id=@@last_insert_id;
    insert into DescuentoPorcentaje(idDescuento,porcentaje) values (id,porcentaje);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_devolucion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_devolucion`(
    OUT _idDevolucion INT,
    IN _descripcion VARCHAR(200),
    IN _idEmpleado INT,
    IN _idProveedor INT,
    IN _monto DECIMAL(10,2),
    IN _cantidad INT,
    IN _idPrenda INT,
    IN _talla VARCHAR(10)
)
BEGIN
    INSERT INTO Devolucion(
        descripcion,
        idEmpleado,
        idProveedor,
        monto,
        cantidad,
        idPrenda,
        talla,
        fecha,
        activo
    )
    VALUES(
        _descripcion,
        _idEmpleado,
        _idProveedor,
        _monto,
        _cantidad,
        _idPrenda,
        _talla,
        DATE(CONVERT_TZ(UTC_TIMESTAMP(), 'UTC', 'America/Lima')),
        1
    );

    SET _idDevolucion = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_empleado`(
	OUT _idEmpleado INT,
    IN _nombre VARCHAR(75),
    IN _primerApellido VARCHAR(75),
    IN _segundoApellido VARCHAR(75),
    IN _dni INT,
    IN _telefono INT,
    IN _genero CHAR,
    IN _Cargo_idCargo INT,
    IN _sueldo DECIMAL(10,2)
)
BEGIN
	INSERT INTO Persona (nombre,primerApellido,segundoApellido,
    dni,telefono,genero)
    VALUES (_nombre,_primerApellido,_segundoApellido,
    _dni,_telefono,_genero);
	SET _idEmpleado = @@last_insert_id;
    INSERT INTO Empleado(idEmpleado,Cargo_idCargo,sueldo,activo)
    VALUES (_idEmpleado,_Cargo_idCargo,_sueldo,1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_factura`(
    OUT _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(110)
)
BEGIN
    INSERT INTO ComprobanteDePago (
        fecha, total, IGV, metodoDePago, correlativo, activa
    )
    VALUES (_FECHA, _TOTAL, _IGV, _METODOPAGO, _CORRELATIVO, 1);

    SET _id_Comprobante =  @@last_insert_id;

    INSERT INTO Factura (idComprobante, RUC, razonSocial)
    VALUES (_id_Comprobante, _RUC, _RAZON_SOCIAL);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_falda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_falda`(
    OUT _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_falda   ENUM('Mini','Midi','Larga','Tubo','Plisada','Cruzada','ShortFalda','Otro'),
    IN  _largo        DECIMAL(6,2),
    IN  _con_forro    TINYINT,
    IN  _con_volantes TINYINT
)
BEGIN
    INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = @@last_insert_id;

    INSERT INTO Falda(idPrenda, tipo_falda, largo, con_forro, con_volantes)
    VALUES(_id_prenda, _tipo_falda, _largo, _con_forro, _con_volantes);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_gorro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_gorro`(
    OUT _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_gorra ENUM('Bucket','Visera','Tejido','Beanie','Otro'),
    IN  _talla_ajustable TINYINT,
    IN  _impermeable     TINYINT
)
BEGIN
    INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = LAST_INSERT_ID();

    INSERT INTO Gorro(idPrenda, tipo_gorra, talla_ajustable, impermeable)
    VALUES(_id_prenda, _tipo_gorra, _talla_ajustable, _impermeable);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_Item_Venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_Item_Venta`(
	OUT _numLinea INT,
    IN _Prenda_idPrenda INT,
    IN _cantidad INT,
    IN _subtotal decimal(10,2),
    IN _Venta_idVenta INT,
    IN _talla varchar(20)
)
BEGIN

	INSERT INTO ItemVenta (Prenda_idPrenda,
    cantidad,subtotal,Venta_idVenta, activo, talla)
    VALUES (_Prenda_idPrenda,_cantidad,
    _subtotal,_Venta_idVenta,  1 , _talla);

    SET _numLinea = @@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_Item__orden_Compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_Item__orden_Compra`(
	OUT _numLinea INT,
    IN _idPrenda INT,
    IN _cantidad INT,
    IN _talla varchar(20),
    IN _lote_idLote INT,
    IN _precioLote decimal(10,2),
    IN _OrdenCompra_idCompra INT,
    IN _activo tinyint
)
BEGIN
	
	INSERT INTO LineaLoteCompra (idPrenda,
    cantidad,talla,lote_idLote,
    precioLote,OrdenCompra_idCompra,
    activo)
    VALUES (_idPrenda , _cantidad,
    _talla,_lote_idLote,
    _precioLote,_OrdenCompra_idCompra, 1 );

    SET _numLinea = @@last_insert_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_lote`(
	OUT _idLote int,
    _Almacen_idAlmacen int,
    _descripcion VARCHAR(255)
)
BEGIN
	INSERT INTO Lote(idLote, Almacen_idAlmacen, activo, descripcion)
    VALUES (_idLote, _Almacen_idAlmacen,  1, _descripcion);
	
	SET _idLote=@@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_mov_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_mov_almacen`(
    OUT _idMovAlmacen int,
    _Almacen_idAlmacen int,
    _CuentaUsuario_idCuenta int, -- Nuevo parámetro
    _fecha DATETIME,
    _lugarDestino VARCHAR(100),
    _lugarOrigen VARCHAR(100),
    _tipo ENUM('Entrada', 'Salida', 'Mov_Interno')
)
BEGIN
    INSERT INTO MovimientoAlmacen(
        Almacen_idAlmacen, 
        CuentaUsuario_idCuenta, -- Nueva columna
        fecha, 
        lugarDestino, 
        lugarOrigen, 
        tipo, 
        activo
    )
    VALUES (
        _Almacen_idAlmacen, 
        _CuentaUsuario_idCuenta, -- Nuevo valor
        _fecha,
        _lugarDestino, 
        _lugarOrigen, 
        _tipo, 
        1
    );
    
    SET _idMovAlmacen = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_mov_X_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_mov_X_lote`(
	OUT _idMovAlmacen_X_Lote int,
    _Lote_idLote int,
    _MovimientoAlmacen_idMov_Almacen int,
    _MovimientoAlmacen_Almacen_idAlmacen int
)
BEGIN
	INSERT INTO MovimientoAlmacen_X_Lote(Lote_idLote, 
        MovimientoAlmacen_idMovAlmacen,
        MovimientoAlmacen_Almacen_idAlmacen, 
        activo)
    VALUES (_Lote_idLote, _MovimientoAlmacen_idMov_Almacen,
	_MovimientoAlmacen_Almacen_idAlmacen,  1);
	
	SET _idMovAlmacen_X_Lote=@@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_nota_de_credito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_nota_de_credito`(
    OUT _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DETALLE_MODIFICACION VARCHAR(255),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(45),
    IN _DNI VARCHAR(8),
    IN _MOTIVO_ESPECIFICO VARCHAR(255),
    IN _NUEVO_MONTO DOUBLE,
    IN _VALOR_AUMENTAR DOUBLE
)
BEGIN
    INSERT INTO ComprobanteDePago(
        fecha, total, IGV, metodoDePago, correlativo, activa
    )
    VALUES (_FECHA, _TOTAL, _IGV, _METODOPAGO, _CORRELATIVO, 1);

    SET _id_Comprobante = @@last_insert_id;

    INSERT INTO NotaDeCredito(
        idComprobante, detalleModificacion, RUC, razonSocial,
        DNI, motivoEspecifico, nuevoMonto, valorAumentar
    )
    VALUES (
        _id_Comprobante, _DETALLE_MODIFICACION, _RUC, _RAZON_SOCIAL,
        _DNI, _MOTIVO_ESPECIFICO, _NUEVO_MONTO, _VALOR_AUMENTAR
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_nota_de_debito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_nota_de_debito`(
    OUT _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DETALLE_MODIFICACION VARCHAR(255),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(45),
    IN _MOTIVO_ESPECIFICO VARCHAR(45),
    IN _NUEVO_MONTO DOUBLE,
    IN _VALOR_AUMENTAR DOUBLE,
    IN _ID_PRENDA INT
)
BEGIN
    INSERT INTO ComprobanteDePago(
        fecha, total, IGV, metodoDePago, correlativo, activa
    )
    VALUES (_FECHA, _TOTAL, _IGV, _METODOPAGO, _CORRELATIVO, 1);

    SET _id_Comprobante = @@last_insert_id;
    

    INSERT INTO NotaDeDebito(
        idComprobante, detalleModificacion, RUC, razonSocial,
        motivoEspecifico, nuevoMonto, valorAumentar, idPrenda
    )
    VALUES (
        _id_Comprobante, _DETALLE_MODIFICACION, _RUC, _RAZON_SOCIAL,
        _MOTIVO_ESPECIFICO, _NUEVO_MONTO, _VALOR_AUMENTAR, _ID_PRENDA
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_orden_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_orden_compra`(
	OUT _idCompra INT,
    IN _fechaLlegada datetime,
    IN _fechaEmision datetime,
    IN _deudaPendiente decimal(10,2),
    IN _montoTotal decimal(10,2),
    IN _Proveedor_idProveedor INT,
    IN _Empleado_idEmpleado INT,
    IN _activo tinyint
)
BEGIN
	
	INSERT INTO OrdenCompra (fechaLlegada,
    fechaEmision,deudaPendiente,montoTotal,
    Proveedor_idProveedor,Empleado_idEmpleado,
    activo)
    VALUES (_fechaLlegada , _fechaEmision,
    _deudaPendiente,_montoTotal,
    _Proveedor_idProveedor,_Empleado_idEmpleado, 1 );

    SET _idCompra = @@last_insert_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_pantalon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_pantalon`(
    OUT _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_pantalon ENUM('Jean','Jogger','Chino','Cargo','Buzo','Leggins','Palazzo','Otro'),
    IN  _largo_pierna DECIMAL(6,2),
    IN  _cintura      DECIMAL(6,2),
    IN  _elasticidad  TINYINT
)
BEGIN
    INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = LAST_INSERT_ID();

    INSERT INTO Pantalon(idPrenda, tipo_pantalon, largo_pierna, cintura, elasticidad)
    VALUES(_id_prenda, _tipo_pantalon, _largo_pierna, _cintura, _elasticidad);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_polo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_polo`(
  OUT _id_prenda INT,
  IN  _nombre VARCHAR(100),
  IN  _precioUnidad DECIMAL(10,2),
  IN  _precioMayor  DECIMAL(10,2),
  IN  _precioDocena DECIMAL(10,2),
  IN  _alertaMinStock INT,
  IN  _color VARCHAR(30),
  IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                     'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                     'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
  IN  _tipo_manga  ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos'),
  IN  _estampado   VARCHAR(80),
  IN  _tipo_cuello ENUM('Redondo','V','Camisero','Alto','Halter','OffShoulder','Otro')
)
BEGIN
  INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                     alertaMinStock, color, material)
  VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
         _alertaMinStock, _color, _material);

  SET _id_prenda = @@last_insert_id;

  INSERT INTO Polo(idPrenda, tipo_manga, estampado, tipo_cuello)
  VALUES(_id_prenda, _tipo_manga, _estampado, _tipo_cuello);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_prendadescuento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_prendadescuento`(in indP int, in indDesc int)
begin
    insert into PrendaDescuento(idPrenda,idDescuento,activo) values(indP,indDesc,1);
    
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_prendapromocion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_prendapromocion`(in indP int, in indPro int)
begin
    insert into PrendaPromocion(idPrenda,idPromocion,activo) values(indP,indPro,1);
    
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_prenda_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_prenda_lote`(
    OUT _id_prenda_lote INT,
    IN  _id_prenda  INT,
    IN  _id_lote    INT,
    IN  _talla      ENUM('XS','S','M','L','XL','XXL'),
    IN  _stock      INT
)
BEGIN
  INSERT INTO PrendaLote(Prenda_idPrenda, Lote_idLote, talla, stock, activo)
  VALUES(_id_prenda, _id_lote, _talla, _stock, 1);
  SET _id_prenda_lote = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_promocioncombo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_promocioncombo`(out id INT,in nom VARCHAR(75),in cantReque INT, in cantGrat int ,in idV int)
begin 
	insert into Promocion (nombre,activo,esAutomatico,idVigencia) values (nom,1,1,idV);
	set id=@@last_insert_id;
    insert into PromocionCombo(idPromocion,cantidadRequerida,cantidadGratis) values (id,cantReque,cantGrat);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_promocionconjunto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_promocionconjunto`(out id INT,in nom VARCHAR(75),in porcentaje float,in idV int)
begin 
	insert into Promocion (nombre,activo,esAutomatico,idVigencia) values (nom,1,1,idV);
	set id=@@last_insert_id;
    insert into PromocionConjunto(idPromocion,porcentajePromocion) values (id,porcentaje);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_proveedor`(  OUT _idProveedor INT,     
IN _RUC BIGINT,     IN _nombre VARCHAR(70),   
  IN _telefono INT,     IN _direccion VARCHAR(150))
BEGIN  
  INSERT INTO Proveedor(RUC, nombre,telefono,     direccion,activo) 
  VALUES (_RUC, _nombre, _telefono, _direccion ,1);  
  SET _idProveedor = @@last_insert_id; 
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_tipoCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_tipoCuenta`(
	OUT _idTipoCuenta INT,
    IN _descripcion VARCHAR(75)
)
BEGIN
	INSERT INTO TipoCuenta (descripcion,activo) VALUES (
		_descripcion,1);
	SET _idTipoCuenta = @@last_insert_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_venta`(
	OUT _idVenta INT,
    IN _fecha datetime,
    IN _total decimal(10,2),
    IN _Comprobante_idComprobante int,
    IN _activo tinyint,
    IN _Cliente_idCliente int,
    IN _Empleado_idEmpleado int
)
BEGIN
	INSERT INTO Venta (fecha,total,
    Empleado_idEmpleado,Cliente_idCliente,
    Comprobante_idComprobante,activo)
    VALUES (_fecha,_total,
    _Empleado_idEmpleado,_Cliente_idCliente,
   _Comprobante_idComprobante,1);
	-- puede que el valor del date se pueda insertar desde acá y se pase 
    -- como parametro de salida
    SET _idVenta = @@last_insert_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_vestido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_vestido`(
    OUT _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_vestido ENUM('Coctel','Fiesta','Gala','Playa','Ejecutivo','Maxi','Mini','Casual'),
    IN  _tipo_manga   ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos'),
    IN  _largo        INT
)
BEGIN
    INSERT INTO Prenda(nombre, activo, precioUnidad, precioMayor, precioDocena,
                       alertaMinStock, color, material)
    VALUES(_nombre, 1, _precioUnidad, _precioMayor, _precioDocena,
           _alertaMinStock, _color, _material);

    SET _id_prenda = LAST_INSERT_ID();

    INSERT INTO Vestido(idPrenda, tipo_vestido, largo, tipo_manga)
    VALUES(_id_prenda, _tipo_vestido, _largo, _tipo_manga);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_vigencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `insertar_vigencia`(out id INT,in fecha1 date,in fecha2 date)
begin 
	insert into Vigencia (fechaInicio,fechaFin,activo) values (fecha1,fecha2,1);
	set id=@@last_insert_id;	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_boletas_todas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_boletas_todas`()
BEGIN
    SELECT 
        b.idComprobante,
        p.correlativo AS Correlativo,
        p.fecha AS fecha,
        p.IGV AS IGV,
        p.metodoDePago AS metodoDePago,
        p.total AS total,
        b.DNI AS DNI,
        p.activa AS activa
    FROM ComprobanteDePago p
    INNER JOIN Boleta b ON p.idComprobante = b.idComprobante
    WHERE p.activa = 1
    ORDER BY p.fecha DESC, b.idComprobante DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_colores_prendas_distintos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_colores_prendas_distintos`()
BEGIN
    SELECT DISTINCT color
    FROM Prenda
    WHERE activo = 1
    ORDER BY color;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_devoluciones_x_id_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_devoluciones_x_id_proveedor`(
    IN _idProveedor INT
)
BEGIN
    SELECT 
        d.idDevolucion,
        d.descripcion,
        d.idEmpleado,
        d.idProveedor,
        d.monto,
        d.cantidad,
        d.idPrenda,
        d.talla,
        d.fecha,
        d.activo,
        pr.nombreProveedor AS nombreProveedor,
        p.nombrePrenda     AS nombrePrenda
    FROM Devolucion d
    INNER JOIN Proveedor pr ON d.idProveedor = pr.idProveedor
    INNER JOIN Prenda    p  ON d.idPrenda    = p.idPrenda
    WHERE d.idProveedor = _idProveedor
      AND d.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_facturas_todas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_facturas_todas`()
BEGIN
    SELECT 
        f.idComprobante,
        p.correlativo AS Correlativo,
        p.fecha AS fecha,
        p.IGV AS IGV,
        p.metodoDePago AS metodoDePago,
        p.total AS total,
        f.RUC AS RUC,
        f.razonSocial AS razonSocial,
        p.activa AS activa
    FROM ComprobanteDePago p
    INNER JOIN Factura f ON p.idComprobante = f.idComprobante
    WHERE p.activa = 1
    ORDER BY p.fecha DESC, f.idComprobante DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_materiales_prendas_distintos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_materiales_prendas_distintos`()
BEGIN
    SELECT DISTINCT material
    FROM Prenda
    WHERE activo = 1
    ORDER BY material;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_nombres_prendas_distintos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_nombres_prendas_distintos`()
BEGIN
    SELECT DISTINCT nombre
    FROM Prenda
    WHERE activo = 1
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_notas_de_credito_todas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_notas_de_credito_todas`()
BEGIN
    SELECT 
        n.idComprobante,
        p.correlativo AS Correlativo,
        p.fecha AS fecha,
        p.IGV AS IGV,
        p.metodoDePago AS metodoDePago,
        p.total AS total,
        n.detalleModificacion AS detalleModificacion,
        n.RUC AS RUC,
        n.razonSocial AS razonSocial,
        n.DNI AS DNI,
        n.motivoEspecifico AS motivoEspecifico,
        n.nuevoMonto AS nuevoMonto,
        n.valorAumentar AS valorAumentar,
        p.activa AS activa
    FROM ComprobanteDePago p
    INNER JOIN NotaDeCredito n ON p.idComprobante = n.idComprobante
    WHERE p.activa = 1
    ORDER BY p.fecha DESC, n.idComprobante DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_notas_de_debito_todas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_notas_de_debito_todas`()
BEGIN
    SELECT 
        n.idComprobante,
        p.correlativo AS Correlativo,
        p.fecha AS fecha,
        p.IGV AS IGV,
        p.metodoDePago AS metodoDePago,
        p.total AS total,
        n.detalleModificacion AS detalleModificacion,
        n.RUC AS RUC,
        n.razonSocial AS razonSocial,
        n.motivoEspecifico AS motivoEspecifico,
        n.nuevoMonto AS nuevoMonto,
        n.valorAumentar AS valorAumentar,
        n.idPrenda AS idPrenda,
        p.activa AS activa
    FROM ComprobanteDePago p
    INNER JOIN NotaDeDebito n ON p.idComprobante = n.idComprobante
    WHERE p.activa = 1
    ORDER BY p.fecha DESC, n.idComprobante DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_prendas_X_idPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_prendas_X_idPrenda`(IN _idPrenda INT)
BEGIN
    SELECT 
        idPrendaLote,
        Prenda_idPrenda AS idPrenda,
        Lote_idLote AS idLote,
        talla,
        stock,
        activo
    FROM PrendaLote
    WHERE Prenda_idPrenda = _idPrenda AND activo = 1
    ORDER BY idPrendaLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_prendas_X_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `listar_prendas_X_lote`(IN _idLote INT)
BEGIN
    SELECT 
        idPrendaLote,
        Prenda_idPrenda AS idPrenda,
        Lote_idLote AS idLote,
        talla,
        stock,
        activo
    FROM PrendaLote
    WHERE Lote_idLote = _idLote AND activo = 1
    ORDER BY idPrendaLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_almacen`(
    IN _id INT,
    IN _nombre VARCHAR(70),
    IN _ubicacion VARCHAR(70),
    IN _activo TINYINT,
    IN _idTienda INT
)
BEGIN
    UPDATE Almacen 
    SET nombre = _nombre, 
        ubicacion = _ubicacion, 
        activo = _activo, 
        Tienda_idTienda = _idTienda
    WHERE idAlmacen = _id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_blusa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_blusa`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_blusa ENUM('Camisera','CropTop','Peplum','OffShoulder','Transparente','Formal','Casual'),
    IN  _tipo_manga ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos')
)
BEGIN
    UPDATE Prenda
       SET nombre        = _nombre,
           precioUnidad  = _precioUnidad,
           precioMayor   = _precioMayor,
           precioDocena  = _precioDocena,
           alertaMinStock= _alertaMinStock,
           color         = _color,
           material      = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Blusa
       SET tipo_blusa = _tipo_blusa,
           tipo_manga = _tipo_manga
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_boleta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_boleta`(
    IN _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DNI VARCHAR(8)
)
BEGIN
    UPDATE ComprobanteDePago
       SET fecha = _FECHA,
           total = _TOTAL,
           IGV = _IGV,
           metodoDePago = _METODOPAGO,
           correlativo = _CORRELATIVO
     WHERE idComprobante = _id_Comprobante;

    UPDATE Boleta
       SET DNI = _DNI
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_cargo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_cargo`(
	IN _idCargo INT,
	IN _abreviatura CHAR,
    IN _descripcion VARCHAR(75)
)
BEGIN
	UPDATE Cargo
    SET abreviatura=_abreviatura,
    descripcion=_descripcion
    WHERE idCargo=_idCargo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_casaca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_casaca`(
	IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_casaca  ENUM('Bomber','Puffer','Denim','Deportiva','Cuero','Cardigan','Otro'),
    IN  _con_capucha TINYINT
)
BEGIN
	UPDATE Prenda
       SET nombre = _nombre,
           precioUnidad = _precioUnidad,
           precioMayor  = _precioMayor,
           precioDocena = _precioDocena,
           alertaMinStock = _alertaMinStock,
           color = _color,
           material = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Casaca
       SET tipo_casaca  = _tipo_casaca,
           con_capucha = _con_capucha
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_cliente`( 
 IN _idCliente INT,     
IN _nombre VARCHAR(75),     
IN _primerApellido VARCHAR(75),   
  IN _segundoApellido VARCHAR(75),  
  IN _dni INT,
  IN _telefono INT,
  IN _genero CHAR , 
  IN _abreviatura CHAR(1),
  IN _descripcion VARCHAR(120),
  IN _tipoCliente INT
  )
BEGIN  
  
  UPDATE Persona SET nombre=_nombre,
  primerApellido=_primerApellido,
  segundoApellido=_segundoApellido,
  dni=_dni,
  telefono=_telefono,
  genero=_genero
  WHERE idPersona=_idCliente;
  
  UPDATE TipoDeCliente SET 
  abreviatura=_abreviatura,
  descripcion=_descripcion
  WHERE tipoCliente=_tipoCliente;
  
  
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_cuentaUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_cuentaUsuario`(
	IN _idCuenta INT,
    IN _username VARCHAR(75),
    IN _contrasenha VARCHAR(75),
    IN _email VARCHAR(75),
    IN _TipoCuenta_idTipoCuenta INT
)
BEGIN
	UPDATE CuentaUsuario
    SET username=_username, contrasenha=_contrasenha, 
    email=_email, 
    TipoCuenta_idTipoCuenta=_TipoCuenta_idTipoCuenta
    WHERE idCuenta=_idCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_descuentoliquidacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_descuentoliquidacion`(in id int, in nomb VARCHAR(75),in porcentaje float,in stock int)
BEGIN
		update Descuento 
        set nombre=nomb
        where idDescuento=id;
        
		update DescuentoLiquidacion 
        set porcentajeLiquidacion=porcentaje, condicionStockMin=stock
        where idDescuento=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_descuentomonto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_descuentomonto`(in id int, in nomb VARCHAR(75),in montoE float,in montoD float)
BEGIN
		update Descuento 
        set nombre=nomb
        where idDescuento=id;
        
		update DescuentoMonto 
        set montoEditable=montoE, montoMaximo=montoD
        where idDescuento=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_descuentoporcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_descuentoporcentaje`(in id int, in nomb VARCHAR(75),in porcen float )
BEGIN
		update Descuento 
        set nombre=nomb
        where idDescuento=id;
        
		update DescuentoPorcentaje 
        set porcentaje=porcen
        where idDescuento=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_devolucion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_devolucion`(
    IN _idDevolucion INT,
    IN _descripcion VARCHAR(200),
    IN _idEmpleado INT,
    IN _idProveedor INT,
    IN _monto DECIMAL(10,2),
    IN _cantidad INT,
    IN _idPrenda INT,
    IN _talla VARCHAR(10)
)
BEGIN
    UPDATE Devolucion
    SET descripcion = _descripcion,
        idEmpleado = _idEmpleado,
        idProveedor = _idProveedor,
        monto = _monto,
        cantidad = _cantidad,
        idPrenda = _idPrenda,
        talla = _talla
    WHERE idDevolucion = _idDevolucion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_empleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_empleado`(
	IN _idEmpleado INT,
    IN _nombre VARCHAR(75),
    IN _primerApellido VARCHAR(75),
    IN _segundoApellido VARCHAR(75),
    IN _dni INT,
    IN _telefono INT,
    IN _genero CHAR,
    IN _Cargo_idCargo INT,
    IN _sueldo DECIMAL(10,2)
)
BEGIN
	UPDATE Persona SET nombre=_nombre,
    primerApellido=_primerApellido,
    segundoApellido=_segundoApellido,
    dni=_dni,telefono=_telefono,genero=_genero
    WHERE idPersona=_idEmpleado;

    UPDATE Empleado SET Cargo_idCargo=_Cargo_idCargo,
    sueldo=_sueldo
    WHERE idEmpleado=_idEmpleado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_factura`(
    IN _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(110)
)
BEGIN
    UPDATE ComprobanteDePago
       SET fecha = _FECHA,
           total = _TOTAL,
           IGV = _IGV,
           metodoDePago = _METODOPAGO,
           correlativo = _CORRELATIVO
     WHERE idComprobante = _id_Comprobante;

    UPDATE Factura
       SET RUC = _RUC,
           razonSocial = _RAZON_SOCIAL
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_falda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_falda`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_falda   ENUM('Mini','Midi','Larga','Tubo','Plisada','Cruzada','ShortFalda','Otro'),
    IN  _largo        DECIMAL(6,2),
    IN  _con_forro    TINYINT,
    IN  _con_volantes TINYINT
)
BEGIN
    UPDATE Prenda
       SET nombre = _nombre,
           precioUnidad = _precioUnidad,
           precioMayor  = _precioMayor,
           precioDocena = _precioDocena,
           alertaMinStock = _alertaMinStock,
           color = _color,
           material = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Falda
       SET tipo_falda   = _tipo_falda,
           largo        = _largo,
           con_forro    = _con_forro,
           con_volantes = _con_volantes
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_gorro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_gorro`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_gorra ENUM('Bucket','Visera','Tejido','Beanie','Otro'),
    IN  _talla_ajustable TINYINT,
    IN  _impermeable     TINYINT
)
BEGIN
    UPDATE Prenda
       SET nombre        = _nombre,
           precioUnidad  = _precioUnidad,
           precioMayor   = _precioMayor,
           precioDocena  = _precioDocena,
           alertaMinStock= _alertaMinStock,
           color         = _color,
           material      = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Gorro
       SET tipo_gorra      = _tipo_gorra,
           talla_ajustable = _talla_ajustable,
           impermeable     = _impermeable
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_lote`(
	_idLote int,
    _Almacen_idAlmacen int,
    _activo TINYINT,
    _descripcion VARCHAR(255)
)
BEGIN
	UPDATE Lote SET Almacen_idAlmacen=_Almacen_idAlmacen, activo=_activo, descripcion=_descripcion
	WHERE idLote=_idLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_mov_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_mov_almacen`(
    _idMovAlmacen int,
    _Almacen_idAlmacen int,
    _CuentaUsuario_idCuenta int, -- Nuevo parámetro
    _fecha DATETIME,
    _lugarDestino VARCHAR(100),
    _lugarOrigen VARCHAR(100),
    _tipo_lote ENUM('Entrada', 'Salida', 'Mov_Interno'),
    _activo TINYINT
)
BEGIN
    UPDATE MovimientoAlmacen
    SET 
        Almacen_idAlmacen = _Almacen_idAlmacen, 
        CuentaUsuario_idCuenta = _CuentaUsuario_idCuenta, -- Actualización del campo
        fecha = _fecha,
        lugarDestino = _lugarDestino, 
        lugarOrigen = _lugarOrigen, 
        tipo = _tipo_lote, 
        activo = _activo
    WHERE idMovAlmacen = _idMovAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_mov_X_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_mov_X_lote`(
	_idMovAlmacen_X_Lote int,
    _Lote_idLote int,
    _MovimientoAlmacen_idMov_Almacen int,
    _MovimientoAlmacen_Almacen_idAlmacen int,
    _activo tinyint
)
BEGIN
    UPDATE MovimientoAlmacen_X_Lote SET Lote_idLote=_Lote_idLote, 
		MovimientoAlmacen_idMovAlmacen=_MovimientoAlmacen_idMov_Almacen,
        MovimientoAlmacen_Almacen_idAlmacen=_MovimientoAlmacen_Almacen_idAlmacen, activo=_activo
	WHERE idMovAlmacen_X_Lote=_idMovAlmacen_X_Lote;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_nota_de_credito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_nota_de_credito`(
    IN _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DETALLE_MODIFICACION VARCHAR(255),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(45),
    IN _DNI VARCHAR(8),
    IN _MOTIVO_ESPECIFICO VARCHAR(255),
    IN _NUEVO_MONTO DOUBLE,
    IN _VALOR_AUMENTAR DOUBLE
)
BEGIN
    UPDATE ComprobanteDePago
       SET fecha = _FECHA,
           total = _TOTAL,
           IGV = _IGV,
           metodoDePago = _METODOPAGO,
           correlativo = _CORRELATIVO
     WHERE idComprobante = _id_Comprobante;

    UPDATE NotaDeCredito
       SET detalleModificacion = _DETALLE_MODIFICACION,
           RUC = _RUC,
           razonSocial = _RAZON_SOCIAL,
           DNI = _DNI,
           motivoEspecifico = _MOTIVO_ESPECIFICO,
           nuevoMonto = _NUEVO_MONTO,
           valorAumentar = _VALOR_AUMENTAR
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_nota_de_debito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_nota_de_debito`(
    IN _id_Comprobante INT,
    IN _FECHA DATETIME,
    IN _TOTAL DOUBLE,
    IN _IGV DOUBLE,
    IN _METODOPAGO VARCHAR(45),
    IN _CORRELATIVO VARCHAR(45),
    IN _DETALLE_MODIFICACION VARCHAR(255),
    IN _RUC VARCHAR(11),
    IN _RAZON_SOCIAL VARCHAR(45),
    IN _MOTIVO_ESPECIFICO VARCHAR(45),
    IN _NUEVO_MONTO DOUBLE,
    IN _VALOR_AUMENTAR DOUBLE,
    IN _ID_PRENDA INT
)
BEGIN
    UPDATE ComprobanteDePago
       SET fecha = _FECHA,
           total = _TOTAL,
           IGV = _IGV,
           metodoDePago = _METODOPAGO,
           correlativo = _CORRELATIVO
     WHERE idComprobante = _id_Comprobante;

    UPDATE NotaDeDebito
       SET detalleModificacion = _DETALLE_MODIFICACION,
           RUC = _RUC,
           razonSocial = _RAZON_SOCIAL,
           motivoEspecifico = _MOTIVO_ESPECIFICO,
           nuevoMonto = _NUEVO_MONTO,
           valorAumentar = _VALOR_AUMENTAR,
           idPrenda = _ID_PRENDA
     WHERE idComprobante = _id_Comprobante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_orden_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_orden_compra`(
	IN _idCompra INT,
    IN _fechaLlegada datetime,
    IN _fechaEmision datetime,
    IN _deudaPendiente decimal(10,2),
    IN _montoTotal decimal(10,2),
    IN _Proveedor_idProveedor INT,
    IN _Empleado_idEmpleado INT,
    IN _activo tinyint
)
BEGIN
	UPDATE LineaLoteCompra
    SET activo = 0
    WHERE OrdenCompra_idCompra = _idCompra ;
    
	UPDATE OrdenCompra 
    SET 
    fechaLlegada = _fechaLlegada,
    fechaEmision = _fechaEmision,
    deudaPendiente = _deudaPendiente,
    montoTotal = _montoTotal,
    Proveedor_idProveedor = _Proveedor_idProveedor,
    Empleado_idEmpleado = _Empleado_idEmpleado
    WHERE idCompra = _idCompra;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_pantalon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_pantalon`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_pantalon ENUM('Jean','Jogger','Chino','Cargo','Buzo','Leggins','Palazzo','Otro'),
    IN  _largo_pierna DECIMAL(6,2),
    IN  _cintura      DECIMAL(6,2),
    IN  _elasticidad  TINYINT
)
BEGIN
    UPDATE Prenda
       SET nombre        = _nombre,
           precioUnidad  = _precioUnidad,
           precioMayor   = _precioMayor,
           precioDocena  = _precioDocena,
           alertaMinStock= _alertaMinStock,
           color         = _color,
           material      = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Pantalon
       SET tipo_pantalon = _tipo_pantalon,
           largo_pierna  = _largo_pierna,
           cintura       = _cintura,
           elasticidad   = _elasticidad
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_polo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_polo`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_manga  ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos'),
    IN  _estampado   VARCHAR(80),
    IN  _tipo_cuello ENUM('Redondo','V','Camisero','Alto','Halter','OffShoulder','Otro')
)
BEGIN
    UPDATE Prenda
       SET nombre = _nombre,
           precioUnidad = _precioUnidad,
           precioMayor  = _precioMayor,
           precioDocena = _precioDocena,
           alertaMinStock = _alertaMinStock,
           color = _color,
           material = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Polo
       SET tipo_manga  = _tipo_manga,
           estampado   = _estampado,
           tipo_cuello = _tipo_cuello
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_prenda_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_prenda_lote`(
    IN _id_prenda_lote INT,
    IN _stock          INT,
    IN _activo         TINYINT,
    IN _talla 			ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL')
)
BEGIN
  UPDATE PrendaLote
     SET stock  = _stock,
		 talla = _talla,
         activo = _activo
   WHERE idPrendaLote = _id_prenda_lote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_promocioncombo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_promocioncombo`(in id int, in nomb VARCHAR(75),in cantReque int , in cantGrat int,in indV int)
BEGIN
		update Promocion 
        set nombre=nomb, idVigencia=indV 
        where idPromocion=id;
        
		update PromocionCombo 
        set cantidadRequerida=cantReque, cantidadGratis=cantGrat 
        where idPromocion=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_promocionconjunto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_promocionconjunto`(in id int, in nomb VARCHAR(75),in promocion float,in indV int)
BEGIN
		update Promocion 
        set nombre=nomb, idVigencia=indV 
        where idPromocion=id;
        
		update PromocionConjunto 
        set porcentajePromocion=promocion 
        where idPromocion=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_proveedor`(  
IN _idProveedor INT,     
IN _RUC BIGINT,   
  IN _nombre VARCHAR(70),   
  IN _telefono INT,   
  IN _direccion VARCHAR(150), 
  IN _activo TINYINT)
BEGIN  
  
  UPDATE CondicionPago
    SET vigente = 0
    WHERE Proveedor_idProveedor = _idProveedor ;
  
  UPDATE Proveedor SET RUC=_RUC,
  nombre=_nombre,telefono=_telefono,direccion=_direccion
  WHERE idProveedor=_idProveedor;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_tipoCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_tipoCuenta`(
	IN _idTipoCuenta INT,
    IN _descripcion VARCHAR(75)
)
BEGIN
	UPDATE TipoCuenta
    SET descripcion=_descripcion
    WHERE idTipoCuenta=_idTipoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_venta`(
	IN _idVenta INT,
    IN _fecha datetime,
    IN _total decimal(10,2),
    IN _Empleado_idEmpleado INT,
    IN _Cliente_idCliente INT,
    IN _Comprobante_idComprobante INT
)
BEGIN
	UPDATE ItemVenta
    SET activo = 0
    WHERE Venta_idVenta = _idVenta;
    
	UPDATE Venta 
    SET fecha = 
    _fecha,
    total = _total, 
    Empleado_idEmpleado = _Empleado_idEmpleado,
    Cliente_idCliente = _Cliente_idCliente,
    Comprobante_idComprobante = _Comprobante_idComprobante
    WHERE idVenta = _idVenta;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_vestido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_vestido`(
    IN  _id_prenda INT,
    IN  _nombre VARCHAR(100),
    IN  _precioUnidad DECIMAL(10,2),
    IN  _precioMayor  DECIMAL(10,2),
    IN  _precioDocena DECIMAL(10,2),
    IN  _alertaMinStock INT,
    IN  _color VARCHAR(30),
    IN  _material ENUM('Algodon','Poliester','Mezcla_algodon_poliester','Lino','Viscosa_rayon',
                       'Lana','Acrilico','Nylon','Elastano_lycra','Denim','Drill','Gabardina',
                       'Polar','Franela','Cuero','Cuerina','Saten','Chifon'),
    IN  _tipo_vestido ENUM('Coctel','Fiesta','Gala','Playa','Ejecutivo','Maxi','Mini','Casual'),
    IN  _tipo_manga   ENUM('MangaCorta','MangaLarga','SinManga','Globo','Campana','TresCuartos'),
    IN  _largo        INT
)
BEGIN
    UPDATE Prenda
       SET nombre        = _nombre,
           precioUnidad  = _precioUnidad,
           precioMayor   = _precioMayor,
           precioDocena  = _precioDocena,
           alertaMinStock= _alertaMinStock,
           color         = _color,
           material      = _material
     WHERE idPrenda = _id_prenda;

    UPDATE Vestido
       SET tipo_vestido = _tipo_vestido,
           largo        = _largo,
           tipo_manga   = _tipo_manga
     WHERE idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modificar_vigencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `modificar_vigencia`(in id INT,in fecha1 date, in fecha2 date)
begin
	update Vigencia 
    set fechaInicio=fecha1,fechaFin=fecha2
    where idVigencia=id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_almacenes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_almacenes`()
BEGIN
	SELECT *FROM Almacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_almacenes_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_almacenes_activos`()
BEGIN
	SELECT *FROM Almacen
    WHERE activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_blusas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_blusas`()
BEGIN
  SELECT *
    FROM Prenda p
    JOIN Blusa  b ON b.idPrenda = p.idPrenda
    WHERE p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_cargos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_cargos`()
BEGIN
	SELECT *
    FROM Cargo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_casacas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_casacas`(
)
BEGIN
    SELECT  p.idPrenda, p.nombre, p.stockPrenda, p.precioUnidad, p.precioMayor, p.precioDocena,
            p.alertaMinStock, p.color, p.material,p.activo,
            c.tipo_casaca, c.con_capucha
      FROM  Prenda p
      JOIN  Casaca c ON c.idPrenda = p.idPrenda
      where p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_clientes`()
BEGIN
  
  
  SELECT c.idCliente, c.activo,p.nombre,
    p.primerApellido,p.segundoApellido,
    p.dni,p.telefono,p.genero,
    t.tipoCliente,t.abreviatura,t.descripcion
    FROM Cliente c INNER JOIN 
	Persona p ON c.idCliente=p.idPersona
	INNER JOIN TipoDeCliente t ON c.tipoCliente = t.tipoCliente WHERE c.activo = 1;
  
  
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_condiciones_de_Pago_X_idproveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_condiciones_de_Pago_X_idproveedor`(
	IN _idProveedor INT
)
BEGIN
	SELECT 
    condicion.idCondicion AS id_condicon,
    condicion.descripcion AS descripcion_condicion,
    condicion.numDias AS num_dias_condicion,
    condicion.vigente AS vigente_condicion,
    condicion.Proveedor_idProveedor AS id_proveedor_condicion
    FROM
    CondicionPago condicion 
    WHERE condicion.Proveedor_idProveedor = _idProveedor;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_condiciones_de_Pago_X_idproveedor_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_condiciones_de_Pago_X_idproveedor_activo`(
	IN _idProveedor INT
)
BEGIN
	SELECT 
    condicion.idCondicion AS id_condicon,
    condicion.descripcion AS descripcion_condicion,
    condicion.numDias AS num_dias_condicion,
    condicion.vigente AS vigente_condicion,
    condicion.Proveedor_idProveedor AS id_proveedor_condicion
    FROM
    CondicionPago condicion 
    WHERE condicion.Proveedor_idProveedor = _idProveedor AND
    condicion.vigente = 1;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_cuentaUsuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_cuentaUsuarios`()
BEGIN
	SELECT c.idCuenta, c.username, c.contrasenha, c.email,
    t.idTipoCuenta, t.descripcion, p.idPersona, p.nombre, p.dni
    FROM CuentaUsuario c
    INNER JOIN TipoCuenta t ON t.idTipoCuenta=c.TipoCuenta_idTipoCuenta
    INNER JOIN Persona p ON p.idPersona = c.fid_empleado
    WHERE c.activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoliquidacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoliquidacion`()
Begin

select d.idDescuento as idDescuento, d.nombre as nombre, dp.porcentajeLiquidacion as porcentajeLiquidacion,dp.condicionStockMin as condicionStockMin,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoLiquidacion dp, Descuento d 
    where dp.idDescuento=d.idDescuento;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoLiquidacionXPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoLiquidacionXPrenda`(in indP int)
BEGIN
	select  d.idDescuento as idDescuento, d.nombre as nombre,dl.porcentajeLiquidacion as porcentajeLiquidacion, dl.condicionStockMin as condicionStockMin
    from PrendaDescuento p , DescuentoLiquidacion dl, Descuento d
    where p.idPrenda=indP and p.idDescuento=d.idDescuento and dl.idDescuento=d.idDescuento and p.activo=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoliquidacion_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoliquidacion_activo`()
Begin

select d.idDescuento as idDescuento, d.nombre as nombre, dp.porcentajeLiquidacion as porcentajeLiquidacion,dp.condicionStockMin as condicionStockMin,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoLiquidacion dp, Descuento d 
    where dp.idDescuento=d.idDescuento and d.activo=1;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentomonto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentomonto`()
Begin

select d.idDescuento as idDescuento, d.nombre as nombre, dp.montoEditable as montoEditable,dp.montoMaximo as montoMaximo,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoMonto dp, Descuento d 
    where dp.idDescuento=d.idDescuento;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoMontoXPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoMontoXPrenda`(in indP int)
BEGIN
	select  d.idDescuento as idDescuento, d.nombre as nombre,dl.montoEditable as Monto_Editable, dl.montoMaximo as Monto_Máximo
    from PrendaDescuento p , DescuentoMonto dl, Descuento d
    where p.idPrenda=indP and p.idDescuento=d.idDescuento and dl.idDescuento=d.idDescuento and p.activo=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentomonto_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentomonto_activo`()
Begin

select d.idDescuento as idDescuento, d.nombre as nombre, dp.montoEditable as montoEditable,dp.montoMaximo as montoMaximo,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoMonto dp, Descuento d 
    where dp.idDescuento=d.idDescuento and d.activo=1;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoporcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoporcentaje`()
Begin

select dp.idDescuento, d.nombre as nombre,dp.porcentaje as porcentaje,d.idVigencia as idVigencia,d.esAutomatico as esAutomatico, d.activo as activo
 from DescuentoPorcentaje dp, Descuento d where d.idDescuento=dp.idDescuento;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoPorcentajeXPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoPorcentajeXPrenda`(in indP int)
BEGIN
	select  d.idDescuento as idDescuento, d.nombre as nombre,dl.porcentaje as porcentaje
    from PrendaDescuento p , DescuentoPorcentaje dl, Descuento d
    where p.idPrenda=indP and p.idDescuento=d.idDescuento and dl.idDescuento=d.idDescuento and p.activo=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_descuentoporcentaje_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_descuentoporcentaje_activos`()
Begin

select dp.idDescuento, d.nombre as nombre,dp.porcentaje as porcentaje,d.idVigencia as idVigencia,d.esAutomatico as esAutomatico, d.activo as activo
 from DescuentoPorcentaje dp, Descuento d where d.idDescuento=dp.idDescuento and d.activo=1;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_devoluciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_devoluciones`()
BEGIN
    SELECT 
        d.idDevolucion,
        d.descripcion,
        d.idEmpleado,
        d.idProveedor,
        d.monto,
        d.cantidad,
        d.idPrenda,
        d.talla,
        d.fecha,
        d.activo,
        pr.nombre AS nombreProveedor,
        p.nombre     AS nombrePrenda
    FROM Devolucion d
    INNER JOIN Proveedor pr ON d.idProveedor = pr.idProveedor
    INNER JOIN Prenda    p  ON d.idPrenda    = p.idPrenda
    WHERE d.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_empleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_empleados`()
BEGIN
	SELECT p.idPersona, p.nombre, p.primerApellido, p.segundoApellido,
    p.dni, p.telefono, p.genero, e.sueldo, c.idCargo, c.abreviatura,
    c.descripcion
    FROM Persona p
    INNER JOIN Empleado e ON p.idPersona=e.idEmpleado
    INNER JOIN Cargo c ON c.idCargo=e.Cargo_idCargo
    WHERE e.activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_faldas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_faldas`()
BEGIN
  SELECT  *
    FROM  Prenda p
    JOIN  Falda  f ON f.idPrenda = p.idPrenda
    WHERE p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_gorros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_gorros`()
BEGIN
  SELECT *
    FROM Prenda p
    JOIN Gorro  g ON g.idPrenda = p.idPrenda
    WHERE p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_items_venta_X_ID_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_items_venta_X_ID_venta`(
	IN _Venta_idVenta INT
)
BEGIN
	SELECT 
    itemVent.numLinea AS  numero_linea,
    itemVent.Prenda_idPrenda AS prendaID,
    itemVent.cantidad AS cantidad_item,
    itemVent.subtotal AS subtotal_item,
    itemVent.Venta_idVenta AS id_venta,
    itemVent.activo AS estado_Item,
    itemVent.talla AS talla_Item
    FROM
    ItemVenta itemVent INNER JOIN  Prenda prend ON
    itemVent.Prenda_idPrenda = prend.idPrenda 
    WHERE itemVent.Venta_idVenta =  _Venta_idVenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_items_venta_X_ID_venta_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_items_venta_X_ID_venta_activos`(
	IN _Venta_idVenta INT
)
BEGIN
	SELECT 
    itemVent.numLinea AS  numero_linea,
    itemVent.Prenda_idPrenda AS prendaID,
    itemVent.cantidad AS cantidad_item,
    itemVent.subtotal AS subtotal_item,
    itemVent.Venta_idVenta AS id_venta,
    itemVent.activo AS estado_Item,
    itemVent.talla AS talla_Item
    FROM
    ItemVenta itemVent INNER JOIN  Prenda prend ON
    itemVent.Prenda_idPrenda = prend.idPrenda 
    WHERE itemVent.Venta_idVenta =  _Venta_idVenta AND 
    itemVent.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_Lineas_Lote_compra_X_ID_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_Lineas_Lote_compra_X_ID_compra`(
	IN _idCompra INT
)
BEGIN
	SELECT 
    lineaLotComp.idPrenda AS id_Prenda_linlote,
    lineaLotComp.numLinea AS num_linea_linlote,
    lineaLotComp.cantidad AS cantidad_linlote,
    lineaLotComp.talla AS talla_linlote,
    
    lineaLotComp.lote_idLote AS id_lote_linlote,
    lot.Almacen_idAlmacen AS almacen_id,
    lot.activo as activo_lote,
    
    
    lineaLotComp.precioLote AS precio_lote_linlote,
    lineaLotComp.OrdenCompra_idCompra AS id_orden_linlote,
    lineaLotComp.activo AS activo_linlote
    
    
    FROM
    LineaLoteCompra lineaLotComp INNER JOIN 
    Lote lot ON
    lineaLotComp.lote_idLote = lot.idLote
    WHERE lineaLotComp.OrdenCompra_idCompra = _idCompra;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_Lineas_Lote_compra_X_ID_compra_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_Lineas_Lote_compra_X_ID_compra_activos`(
	IN _idCompra INT
)
BEGIN
	SELECT 
    lineaLotComp.idPrenda AS id_Prenda_linlote,
    lineaLotComp.numLinea AS num_linea_linlote,
    lineaLotComp.cantidad AS cantidad_linlote,
    lineaLotComp.talla AS talla_linlote,
    
    lineaLotComp.lote_idLote AS id_lote_linlote,
    lot.Almacen_idAlmacen AS almacen_id,
    lot.activo as activo_lote,
    
    
    lineaLotComp.precioLote AS precio_lote_linlote,
    lineaLotComp.OrdenCompra_idCompra AS id_orden_linlote,
    lineaLotComp.activo AS activo_linlote
    
    
    FROM
    LineaLoteCompra lineaLotComp INNER JOIN 
    Lote lot ON
    lineaLotComp.lote_idLote = lot.idLote
    WHERE lineaLotComp.OrdenCompra_idCompra = _idCompra
    AND lineaLotComp.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_lotes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_lotes`()
BEGIN
    SELECT*FROM Lote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_lotes_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_lotes_activos`()
BEGIN
	SELECT* FROM Lote WHERE activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_lote_activo_por_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_lote_activo_por_almacen`(
    IN _idAlmacen INT
)
BEGIN
    -- Validación del parámetro de entrada
    IF _idAlmacen IS NULL OR _idAlmacen <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El ID del almacén debe ser un valor positivo válido';
    END IF;
    
    -- Consulta principal
    SELECT *
    FROM 
        Lote
    WHERE 
        activo = 1 
        AND Almacen_idAlmacen = _idAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_activo_por_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_activo_por_almacen`(
    IN _idAlmacen INT
)
BEGIN
    IF _idAlmacen IS NULL OR _idAlmacen <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El ID del almacén debe ser un valor positivo válido';
    END IF;
    
    SELECT 
        ma.idMovAlmacen,
        ma.Almacen_idAlmacen,
        ma.CuentaUsuario_idCuenta,
        ma.fecha,
        ma.lugarDestino,
        ma.lugarOrigen,
        ma.tipo,
        ma.activo,
        -- ✅ Datos del Almacen
        a.idAlmacen,
        -- ✅ Datos del Usuario
        cu.username
    FROM 
        MovimientoAlmacen ma
    INNER JOIN 
        Almacen a ON ma.Almacen_idAlmacen = a.idAlmacen
    INNER JOIN 
        CuentaUsuario cu ON ma.CuentaUsuario_idCuenta = cu.idCuenta
    WHERE 
        ma.activo = 1 
        AND ma.Almacen_idAlmacen = _idAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_almacenes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_almacenes`()
BEGIN
    SELECT 
        idMovAlmacen, 
        Almacen_idAlmacen, 
        CuentaUsuario_idCuenta, -- Nueva columna
        fecha, 
        lugarDestino,
        lugarOrigen, 
        tipo, 
        activo 
    FROM MovimientoAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_almacenes_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_almacenes_activos`()
BEGIN
    SELECT 
        idMovAlmacen, 
        Almacen_idAlmacen, 
        CuentaUsuario_idCuenta, -- Nueva columna
        fecha, 
        lugarDestino,
        lugarOrigen, 
        tipo, 
        activo 
    FROM MovimientoAlmacen
    WHERE activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_X_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_X_lote`()
BEGIN
    SELECT*FROM MovimientoAlmacen_X_Lote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_X_lote_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_X_lote_activos`()
BEGIN
    SELECT*FROM MovimientoAlmacen_X_Lote WHERE activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_mov_X_lote_activos_por_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_mov_X_lote_activos_por_almacen`(
	_idAlmacen INT
)
BEGIN
	SELECT
        MQL.idMovAlmacen_X_Lote,         -- 1. idMovAlmacen_X_Lote
        L.idLote,                        -- 2. ID Lote
        MA.idMovAlmacen,                 -- 3. ID Movimiento
        MA.Almacen_idAlmacen,            -- 4. ID Almacen del Movimiento
        MA.tipo,                         -- 5. Tipo de Movimiento
        MA.lugarDestino,                 -- 6. Lugar Destino
        MA.lugarOrigen,                  -- 7. Lugar Origen
        L.descripcion,                   -- 8. Descripción Lote
        MQL.activo                       -- 9. Activo (para la relación)
        -- Nota: No necesitamos L.Almacen_idAlmacen ni MA.activo, MA.Almacen_idAlmacen aquí,
        -- pero se pueden añadir si el mapeo Java lo requiere.
    FROM
        MovimientoAlmacen_X_Lote MQL
    INNER JOIN
        MovimientoAlmacen MA ON MQL.MovimientoAlmacen_idMovAlmacen = MA.idMovAlmacen
    INNER JOIN
        Lote L ON MQL.Lote_idLote = L.idLote
    WHERE
        MA.Almacen_idAlmacen = _idAlmacen
        AND L.Almacen_idAlmacen = _idAlmacen
        AND MA.activo = 1
        AND L.activo = 1
        AND MQL.activo = 1
    ORDER BY
        MA.idMovAlmacen, L.idLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_ordenes_de_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_ordenes_de_compra`()
BEGIN
	SELECT 
    ordcomp.idCompra as id_orden_compra,
    ordcomp.fechaLlegada as fecha_llegada_orden_compra,
    ordcomp.fechaEmision as fecha_emision_orden_compra,
    ordcomp.deudaPendiente as deuda_pendiente_orden_compra,
    ordcomp.montoTotal as monto_total_orden_compra,
    ordcomp.activo as activo_orden_compra,
    
    ordcomp.Proveedor_idProveedor as id_proveedor,
    prove.RUC as ruc_proveedor,
    prove.nombre as nombre_proveedor,
    prove.telefono as telefono_proveedor,
    prove.direccion as direccion_proveedor,
    prove.activo as activo_prooveedor,
    
    ordcomp.Empleado_idEmpleado as id_empleado,
    empl.sueldo as sueldo_empleado,
    empl.Cargo_idCargo as empleado_cargoId,
    carg.abreviatura as empleado_abreviatura,
    carg.descripcion as empleado_descripcion,
    carg.activo as cargo_activo,
    
    empl.activo as activo_empleado,
    person_empl.nombre as nombre_empleado,
    person_empl.primerApellido as primer_ape_empleado,
    person_empl.segundoApellido as segun_ape_empleado,
    person_empl.dni as dni_empleado,
    person_empl.telefono as telefono_empleado,
    person_empl.genero as genero_empleado

    FROM
    OrdenCompra ordcomp INNER JOIN Proveedor prove ON
    ordcomp.Proveedor_idProveedor = prove.idProveedor
    INNER JOIN Empleado empl ON
    ordcomp.Empleado_idEmpleado  = empl.idEmpleado
    INNER JOIN Cargo carg ON
    empl.Cargo_idCargo = carg.idCargo
    INNER JOIN Persona person_empl ON
    person_empl.idPersona = empl.idEmpleado;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_ordenes_de_compra_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_ordenes_de_compra_activo`()
BEGIN
	SELECT 
    ordcomp.idCompra as id_orden_compra,
    ordcomp.fechaLlegada as fecha_llegada_orden_compra,
    ordcomp.fechaEmision as fecha_emision_orden_compra,
    ordcomp.deudaPendiente as deuda_pendiente_orden_compra,
    ordcomp.montoTotal as monto_total_orden_compra,
    ordcomp.activo as activo_orden_compra,
    
    ordcomp.Proveedor_idProveedor as id_proveedor,
    prove.RUC as ruc_proveedor,
    prove.nombre as nombre_proveedor,
    prove.telefono as telefono_proveedor,
    prove.direccion as direccion_proveedor,
    prove.activo as activo_prooveedor,
    
    ordcomp.Empleado_idEmpleado as id_empleado,
    empl.sueldo as sueldo_empleado,
    empl.Cargo_idCargo as empleado_cargoId,
    carg.abreviatura as empleado_abreviatura,
    carg.descripcion as empleado_descripcion,
    carg.activo as cargo_activo,
    
    empl.activo as activo_empleado,
    person_empl.nombre as nombre_empleado,
    person_empl.primerApellido as primer_ape_empleado,
    person_empl.segundoApellido as segun_ape_empleado,
    person_empl.dni as dni_empleado,
    person_empl.telefono as telefono_empleado,
    person_empl.genero as genero_empleado

    FROM
    OrdenCompra ordcomp INNER JOIN Proveedor prove ON
    ordcomp.Proveedor_idProveedor = prove.idProveedor
    INNER JOIN Empleado empl ON
    ordcomp.Empleado_idEmpleado  = empl.idEmpleado
    INNER JOIN Cargo carg ON
    empl.Cargo_idCargo = carg.idCargo
    INNER JOIN Persona person_empl ON
    person_empl.idPersona = empl.idEmpleado
    WHERE ordcomp.activo = true;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_pantalones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_pantalones`()
BEGIN
  SELECT *
    FROM Prenda   p
    JOIN Pantalon t ON t.idPrenda = p.idPrenda
	WHERE p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_polos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_polos`()
BEGIN
	SELECT * FROM Prenda INNER JOIN Polo ON Prenda.idPrenda = Polo.idPrenda WHERE Prenda.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_prenda_lote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_prenda_lote`()
BEGIN
    SELECT 
        idPrendaLote,
        Prenda_idPrenda AS idPrenda,
        Lote_idLote AS idLote,
        talla,
        stock,
        activo
    FROM PrendaLote
    WHERE activo = 1
    ORDER BY idPrendaLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocioncomboXPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocioncomboXPrenda`(in indP int)
BEGIN
	select  pc.idPromocion as idPromocion, pp.nombre as nombre, pc.cantidadRequerida as cantidadRequerida, pc.cantidadGratis as cantidadGratis 
    from PrendaPromocion p , PromocionCombo pc, Promocion pp 
    where p.idPrenda=indP and p.idPromocion=pc.idPromocion and pp.idPromocion=pc.idPromocion and p.activo=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocionconjuntoXPrenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocionconjuntoXPrenda`(in indP int)
BEGIN
	select  pc.idPromocion as idPromocion, pp.nombre as nombre, pc.porcentajePromocion as porcentajePromocion
    from PrendaPromocion p , PromocionConjunto pc, Promocion pp 
    where p.idPrenda=indP and p.idPromocion=pc.idPromocion and pp.idPromocion=pc.idPromocion and p.activo=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocionescombo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocionescombo`()
Begin

select p.idPromocion as idPromocion,p.nombre as nombre, pp.cantidadRequerida as cantidadRequerida, pp.cantidadGratis as cantidadGratis,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionCombo pp, Promocion p where p.idPromocion=pp.idPromocion;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocionescombo_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocionescombo_activo`()
Begin

select p.idPromocion as idPromocion,p.nombre as nombre, pp.cantidadRequerida as cantidadRequerida, pp.cantidadGratis as cantidadGratis,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionCombo pp, Promocion p where pp.idPromocion=p.idPromocion and p.activo=1;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocionesconjunto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocionesconjunto`()
Begin
select p.idPromocion as idPromocion,p.nombre as nombre, pp.porcentajePromocion as porcentajePromocion,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionConjunto pp, Promocion p where p.idPromocion=pp.idPromocion;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_promocionesconjunto_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_promocionesconjunto_activo`()
Begin
select p.idPromocion as idPromocion,p.nombre as nombre, pp.porcentajePromocion as porcentajePromocion,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionConjunto pp, Promocion p where p.idPromocion=pp.idPromocion and p.activo=1;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_proveedores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_proveedores`()
BEGIN
  Select idProveedor,RUC,nombre,telefono,direccion,activo
  From Proveedor;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_proveedores_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_proveedores_activos`()
BEGIN
    SELECT 
        idProveedor,
        RUC,
        nombre,
        telefono,
        direccion,
        activo
    FROM Proveedor
    WHERE activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_tipoCuentas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_tipoCuentas`()
BEGIN
	SELECT *
    FROM TipoCuenta
    WHERE activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_ventas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_ventas`()
BEGIN
	SELECT 
    vent.idVenta as id_venta,
    vent.fecha as fecha_venta,
    vent.total as total_venta,
     vent.Comprobante_idComprobante as idComprobante_venta,
	vent.activo as estado_venta ,
    emple.idEmpleado as id_empleado,
    emple.sueldo as sueldo_empleado,
    emple.activo as estado_empleado,
    
    perEmple.nombre as nombre_empleado,
    perEmple.primerApellido as primerApellido_empleado,
    perEmple.segundoApellido as segundoApellido_empleado,
    perEmple.dni as dni_empleado,
    perEmple.telefono as telefono_empleado,
    perEmple.genero as genero_empleado,
    
    
    
    cargoEmple.idCargo as id_cargo_emple,
    cargoEmple.abreviatura as abreviatura_cargo,
    cargoEmple.descripcion as descripcion_emplea,
	cargoEmple.activo as activo_cargo_emple,
    clie.idCliente as id_cliente,
    clie.activo as activo_clie,
    
    tipoClie.tipoCliente as tipo_clie_id,
    tipoClie.abreviatura as abreviatura_clie,
    tipoClie.descripcion as descripcion_clie,
    perClie.dni as dni_clie,
    perClie.genero as genero_clie,
    
    perClie.nombre as nombre_clie,
    perClie.primerApellido as primerApellido_clie,
    perClie.segundoApellido as segundoApellido_clie,
    perClie.telefono as telefono_clie,
    vent.Comprobante_idComprobante as id_comprobante
    
    FROM
    Venta vent INNER JOIN Empleado emple ON
    vent.Empleado_idEmpleado = emple.idEmpleado 
    INNER JOIN Cliente clie 
    ON vent.Cliente_idCliente = clie.idCliente 
    INNER JOIN ComprobanteDePago compPag 
    ON vent.Comprobante_idComprobante = compPag.idComprobante
    INNER JOIN Persona perClie
    ON clie.idCliente = perClie.idPersona
    INNER JOIN Persona perEmple
    ON emple.idEmpleado =  perEmple.idPersona 
    INNER JOIN Cargo cargoEmple
    ON cargoEmple.idCargo = emple.Cargo_idCargo
    INNER JOIN TipoDeCliente tipoClie
    ON clie.tipoCliente = tipoClie.tipoCliente
    ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_ventas_activas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_ventas_activas`()
BEGIN
	SELECT 
    vent.idVenta as id_venta,
    vent.fecha as fecha_venta,
    vent.total as total_venta,
    vent.Comprobante_idComprobante as idComprobante_venta,
	vent.activo as estado_venta ,
    emple.idEmpleado as id_empleado,
    emple.sueldo as sueldo_empleado,
    emple.activo as estado_empleado,
    
    perEmple.nombre as nombre_empleado,
    perEmple.primerApellido as primerApellido_empleado,
    perEmple.segundoApellido as segundoApellido_empleado,
    perEmple.dni as dni_empleado,
    perEmple.telefono as telefono_empleado,
    perEmple.genero as genero_empleado,
  
    
    
    cargoEmple.idCargo as id_cargo_emple,
    cargoEmple.abreviatura as abreviatura_cargo,
    cargoEmple.descripcion as descripcion_emplea,
	cargoEmple.activo as activo_cargo_emple,
    clie.idCliente as id_cliente,
    clie.activo as activo_clie,
    
    tipoClie.tipoCliente as tipo_clie_id,
    tipoClie.abreviatura as abreviatura_clie,
    tipoClie.descripcion as descripcion_clie,
    perClie.dni as dni_clie,
    perClie.genero as genero_clie,
   
    perClie.nombre as nombre_clie,
    perClie.primerApellido as primerApellido_clie,
    perClie.segundoApellido as segundoApellido_clie,
    perClie.telefono as telefono_clie,
    vent.Comprobante_idComprobante as id_comprobante
    
    FROM
    Venta vent INNER JOIN Empleado emple ON
    vent.Empleado_idEmpleado = emple.idEmpleado 
    INNER JOIN Cliente clie 
    ON vent.Cliente_idCliente = clie.idCliente 
    INNER JOIN ComprobanteDePago compPag 
    ON vent.Comprobante_idComprobante = compPag.idComprobante
    INNER JOIN Persona perClie
    ON clie.idCliente = perClie.idPersona
    INNER JOIN Persona perEmple
    ON emple.idEmpleado =  perEmple.idPersona 
    INNER JOIN Cargo cargoEmple
    ON cargoEmple.idCargo = emple.Cargo_idCargo
    INNER JOIN TipoDeCliente tipoClie
    ON clie.tipoCliente = tipoClie.tipoCliente
    WHERE vent.activo = 1;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_vestidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_vestidos`()
BEGIN
  SELECT *
    FROM Prenda  p
    JOIN Vestido v ON v.idPrenda = p.idPrenda
    WHERE p.activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_vigencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_vigencia`()
BEGIN
	select idVigencia,fechaInicio,fechaFin,activo from Vigencia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrar_vigencia_activos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `mostrar_vigencia_activos`()
BEGIN
	select idVigencia,fechaInicio,fechaFin,activo from Vigencia where activo=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerdevolucion_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtenerdevolucion_X_id`(
    IN _idDevolucion INT
)
BEGIN
    SELECT 
        d.idDevolucion,
        d.descripcion,
        d.idEmpleado,
        d.idProveedor,
        d.monto,
        d.cantidad,
        d.idPrenda,
        d.talla,
        d.fecha,
        d.activo,
        pr.nombre AS nombreProveedor,
        p.nombre     AS nombrePrenda
    FROM Devolucion d
    INNER JOIN Proveedor pr ON d.idProveedor = pr.idProveedor
    INNER JOIN Prenda    p  ON d.idPrenda    = p.idPrenda
    WHERE d.idDevolucion = _idDevolucion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerId_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtenerId_cliente`( IN _idCliente INT)
BEGIN
  
	SELECT c.idCliente,c.activo,p.nombre,
    p.primerApellido,p.segundoApellido,
    p.dni,p.telefono,p.genero,
    t.tipoCliente,t.abreviatura,t.descripcion
    FROM Cliente c INNER JOIN 
	Persona p ON c.idCliente=p.idPersona
	INNER JOIN TipoDeCliente t ON c.tipoCliente = t.tipoCliente 
    where c.idCliente=_idCliente;
    
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerId_proveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtenerId_proveedor`( IN _idProveedor INT)
BEGIN
  Select idProveedor,RUC,nombre,telefono,direccion,activo
  From Proveedor 
  WHERE  idProveedor = _idProveedor;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_almacen_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_almacen_X_id`(
    IN _idAlmacen INT
)
BEGIN
    SELECT idAlmacen, nombre, ubicacion, Tienda_idTienda, activo
    FROM Almacen
    WHERE idAlmacen = _idAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_blusa_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_blusa_X_id`(
    IN _id_prenda INT
)
BEGIN
  SELECT *
    FROM Prenda p
    JOIN Blusa  b ON b.idPrenda = p.idPrenda
   WHERE p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_boleta_x_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_boleta_x_id`(
    IN _id_Comprobante INT
)
BEGIN
    SELECT 
        b.idComprobante,
        p.correlativo,
        p.fecha,
        p.IGV,
        p.metodoDePago,
        p.total,
        b.DNI,
        p.activa
    FROM ComprobanteDePago p
    INNER JOIN Boleta b ON p.idComprobante = b.idComprobante
    WHERE b.idComprobante = _id_Comprobante
      AND p.activa = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_cargo_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_cargo_X_id`(
	IN _idCargo INT
)
BEGIN
	SELECT *
    FROM Cargo
    WHERE idCargo=_idCargo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_casaca_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_casaca_X_id`(
    IN _id_prenda INT
)
BEGIN
    SELECT  p.idPrenda, p.nombre, p.stockPrenda, p.precioUnidad, p.precioMayor, p.precioDocena,
            p.alertaMinStock, p.color, p.material,
            c.tipo_casaca, c.con_capucha
      FROM  Prenda p
      JOIN  Casaca c ON c.idPrenda = p.idPrenda
     WHERE  p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_cuentaUsuarios_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_cuentaUsuarios_X_id`(
	IN _idCuenta INT
)
BEGIN
	SELECT c.idCuenta, c.username, c.contrasenha, c.email,
    c.activo, t.idTipoCuenta, t.descripcion, p.idPersona, p.nombre, p.dni, c.fid_empleado
    FROM CuentaUsuario c
    INNER JOIN TipoCuenta t ON t.idTipoCuenta=c.TipoCuenta_idTipoCuenta
    INNER JOIN Persona p ON p.idPersona = c.fid_empleado
    WHERE idCuenta=_idCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_descuentoliquidacion_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_descuentoliquidacion_X_id`(in id int)
BEGIN
	select d.idDescuento as idDescuento, d.nombre as nombre, dp.porcentajeLiquidacion as porcentajeLiquidacion,dp.condicionStockMin as condicionStockMin,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoLiquidacion dp, Descuento d 
    where d.idDescuento=id and dp.idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_descuentomonto_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_descuentomonto_X_id`(in id int)
BEGIN
	select d.idDescuento as idDescuento, d.nombre as nombre, dp.montoEditable as montoEditable,dp.montoMaximo as montoMaximo,
    d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoMonto dp, Descuento d 
    where d.idDescuento=id and dp.idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_descuentoporcentaje_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_descuentoporcentaje_X_id`(in id int)
BEGIN
	select d.idDescuento as idDescuento, d.nombre as nombre, dp.porcentaje as porcentaje,d.activo as activo,
    d.esAutomatico as esAutomatico, d.idVigencia as idVigencia from DescuentoPorcentaje dp, Descuento d 
    where d.idDescuento=id and dp.idDescuento=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_empleado_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_empleado_X_id`(
	IN _idEmpleado INT
)
BEGIN
	SELECT p.idPersona, p.nombre, p.primerApellido, p.segundoApellido,
    p.dni, p.telefono, p.genero, e.activo, e.sueldo, c.idCargo,
    c.abreviatura, c.descripcion
    FROM Persona p
    INNER JOIN Empleado e ON p.idPersona=e.idEmpleado
    INNER JOIN Cargo c ON c.idCargo=e.Cargo_idCargo
    WHERE e.idEmpleado=_idEmpleado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_factura_x_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_factura_x_id`(
    IN _id_Comprobante INT
)
BEGIN
    SELECT 
        f.idComprobante,
        p.correlativo,
        p.fecha,
        p.IGV,
        p.metodoDePago,
        p.total,
        f.RUC,
        f.razonSocial,
        p.activa
    FROM ComprobanteDePago p
    INNER JOIN Factura f ON p.idComprobante = f.idComprobante
    WHERE f.idComprobante = _id_Comprobante
      AND p.activa = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_falda_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_falda_X_id`(
    IN _id_prenda INT
)
BEGIN
    SELECT  p.idPrenda, p.nombre, p.stockPrenda, p.precioUnidad, p.precioMayor, p.precioDocena,
            p.alertaMinStock, p.color, p.material,
            c.tipo_falda, c.largo, c.con_forro, c.con_volantes
      FROM  Prenda p
      JOIN  Falda c ON c.idPrenda = p.idPrenda
     WHERE  p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_gorro_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_gorro_X_id`(
    IN _id_prenda INT
)
BEGIN
  SELECT *
    FROM Prenda p
    JOIN Gorro  g ON g.idPrenda = p.idPrenda
   WHERE p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_lote_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_lote_X_id`(
	_idLote int
)
BEGIN
	SELECT*FROM Lote WHERE _idLote=idLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_mov_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_mov_X_id`(
    _idMovAlmacen int
)
BEGIN
    SELECT 
        idMovAlmacen, 
        Almacen_idAlmacen, 
        CuentaUsuario_idCuenta, -- Nueva columna
        fecha,
        lugarDestino, 
        lugarOrigen, 
        tipo, 
        activo
    FROM MovimientoAlmacen
    WHERE idMovAlmacen = _idMovAlmacen;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_mov_X_lote_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_mov_X_lote_X_id`(
	_idMovAlmacen_X_Lote int
)
BEGIN
    SELECT*FROM MovimientoAlmacen_X_Lote WHERE _idMovAlmacen_X_Lote=idMovAlmacen_X_Lote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_nota_de_credito_x_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_nota_de_credito_x_id`(
    IN _id_Comprobante INT
)
BEGIN
    SELECT 
        n.idComprobante,
        p.correlativo,
        p.fecha,
        p.IGV,
        p.metodoDePago,
        p.total,
        n.detalleModificacion,
        n.RUC,
        n.razonSocial,
        n.DNI,
        n.motivoEspecifico,
        n.nuevoMonto,
        n.valorAumentar,
        p.activa
    FROM ComprobanteDePago p
    INNER JOIN NotaDeCredito n ON p.idComprobante = n.idComprobante
    WHERE n.idComprobante = _id_Comprobante
      AND p.activa = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_nota_de_debito_x_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_nota_de_debito_x_id`(
    IN _id_Comprobante INT
)
BEGIN
    SELECT 
        n.idComprobante,
        p.correlativo,
        p.fecha,
        p.IGV,
        p.metodoDePago,
        p.total,
        n.detalleModificacion,
        n.RUC,
        n.razonSocial,
        n.motivoEspecifico,
        n.nuevoMonto,
        n.valorAumentar,
        n.idPrenda,
        p.activa
    FROM ComprobanteDePago p
    INNER JOIN NotaDeDebito n ON p.idComprobante = n.idComprobante
    WHERE n.idComprobante = _id_Comprobante
      AND p.activa = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_orden_de_compra_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_orden_de_compra_X_id`(
	IN _idCompra INT
)
BEGIN
	SELECT 
    ordcomp.idCompra as id_orden_compra,
    ordcomp.fechaLlegada as fecha_llegada_orden_compra,
    ordcomp.fechaEmision as fecha_emision_orden_compra,
    ordcomp.deudaPendiente as deuda_pendiente_orden_compra,
    ordcomp.montoTotal as monto_total_orden_compra,
    ordcomp.activo as activo_orden_compra,
    
    ordcomp.Proveedor_idProveedor as id_proveedor,
    prove.RUC as ruc_proveedor,
    prove.nombre as nombre_proveedor,
    prove.telefono as telefono_proveedor,
    prove.direccion as direccion_proveedor,
    prove.activo as activo_prooveedor,
    
    ordcomp.Empleado_idEmpleado as id_empleado,
    empl.sueldo as sueldo_empleado,
    empl.Cargo_idCargo as empleado_cargoId,
    carg.abreviatura as empleado_abreviatura,
    carg.descripcion as empleado_descripcion,
    carg.activo as cargo_activo,
    
    empl.activo as activo_empleado,
    person_empl.nombre as nombre_empleado,
    person_empl.primerApellido as primer_ape_empleado,
    person_empl.segundoApellido as segun_ape_empleado,
    person_empl.dni as dni_empleado,
    person_empl.telefono as telefono_empleado,
    person_empl.genero as genero_empleado

    FROM
    OrdenCompra ordcomp INNER JOIN Proveedor prove ON
    ordcomp.Proveedor_idProveedor = prove.idProveedor
    INNER JOIN Empleado empl ON
    ordcomp.Empleado_idEmpleado  = empl.idEmpleado
    INNER JOIN Cargo carg ON
    empl.Cargo_idCargo = carg.idCargo
    INNER JOIN Persona person_empl ON
    person_empl.idPersona = empl.idEmpleado
    WHERE ordcomp.idCompra = _idCompra;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_pantalon_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_pantalon_X_id`(
    IN _id_prenda INT
)
BEGIN
  SELECT *
    FROM Prenda   p
    JOIN Pantalon t ON t.idPrenda = p.idPrenda
   WHERE p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_polo_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_polo_X_id`(
    IN _id_prenda INT
)
BEGIN
    SELECT  
        p.idPrenda, 
        p.nombre, 
        p.stockPrenda, 
        p.precioUnidad, 
        p.precioMayor, 
        p.precioDocena,
        p.alertaMinStock, 
        p.color, 
        p.material,
        p.activo,  -- ✅ AGREGADO
        po.tipo_manga, 
        po.estampado, 
        po.tipo_cuello
    FROM Prenda p
    JOIN Polo po ON po.idPrenda = p.idPrenda
    WHERE p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_prenda_lote_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_prenda_lote_X_id`(IN _idPrendaLote INT)
BEGIN
    SELECT 
        idPrendaLote,
        Prenda_idPrenda AS idPrenda,
        Lote_idLote AS idLote,
        talla,
        stock,
        activo
    FROM PrendaLote
    WHERE idPrendaLote = _idPrendaLote;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_prenda_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_prenda_X_id`(IN _idPrenda INT)
BEGIN
    SELECT 
        idPrenda,
        nombre,
        color,
        material,
        precioUnidad,
        precioMayor,
        precioDocena,
        stockPrenda,
        alertaMinStock,
        activo
    FROM Prenda
    WHERE idPrenda = _idPrenda AND activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_promocioncombo_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_promocioncombo_X_id`(in id int)
Begin 
	select p.idPromocion as idPromocion,p.nombre as nombre, pp.cantidadRequerida as cantidadRequerida, pp.cantidadGratis as cantidadGratis,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionCombo pp, Promocion p where p.idPromocion=id and pp.idPromocion=id;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_promocionconjunto_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_promocionconjunto_X_id`(in id int)
Begin 
	select p.idPromocion as idPromocion,p.nombre as nombre, pp.porcentajePromocion as porcentajePromocion,p.idVigencia as idVigencia,p.activo as activo, p.esAutomatico as esAutomatico
    from PromocionConjunto pp, Promocion p where p.idPromocion=id and pp.idPromocion=id;
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_stock_prenda_talla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_stock_prenda_talla`(
    IN _idPrenda INT,
    IN _talla VARCHAR(10)
)
BEGIN
    SELECT COALESCE(SUM(stock), 0) as stock_total
    FROM PrendaLote
    WHERE Prenda_idPrenda = _idPrenda
      AND talla = _talla
      AND activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_tipoCuenta_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_tipoCuenta_X_id`(
	IN _idTipoCuenta INT
)
BEGIN
	SELECT *
    FROM TipoCuenta
    WHERE idTipoCuenta=_idTipoCuenta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_venta_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_venta_X_id`(
	IN _idVenta INT
)
BEGIN
	SELECT 
    vent.idVenta as id_venta,
    vent.fecha as fecha_venta,
    vent.total as total_venta,
    vent.Comprobante_idComprobante as idComprobante_venta,
	vent.activo as estado_venta ,
    emple.idEmpleado as id_empleado,
    emple.sueldo as sueldo_empleado,
    emple.activo as estado_empleado,
    
    perEmple.nombre as nombre_empleado,
    perEmple.primerApellido as primerApellido_empleado,
    perEmple.segundoApellido as segundoApellido_empleado,
    perEmple.dni as dni_empleado,
    perEmple.telefono as telefono_empleado,
    perEmple.genero as genero_empleado,
    
    
    
    cargoEmple.idCargo as id_cargo_emple,
    cargoEmple.abreviatura as abreviatura_cargo,
    cargoEmple.descripcion as descripcion_emplea,
	cargoEmple.activo as activo_cargo_emple,
    clie.idCliente as id_cliente,
    clie.activo as activo_clie,
    
    
    tipoClie.tipoCliente as tipo_clie_id,
    tipoClie.abreviatura as abreviatura_clie,
    tipoClie.descripcion as descripcion_clie,
    perClie.dni as dni_clie,
    perClie.genero as genero_clie,
    perClie.nombre as nombre_clie,
    perClie.primerApellido as primerApellido_clie,
    perClie.segundoApellido as segundoApellido_clie,
    perClie.telefono as telefono_clie,
    vent.Comprobante_idComprobante as id_comprobante
    
    FROM
    Venta vent INNER JOIN Empleado emple ON
    vent.Empleado_idEmpleado = emple.idEmpleado 
    INNER JOIN Cliente clie 
    ON vent.Cliente_idCliente = clie.idCliente 
    INNER JOIN ComprobanteDePago compPag 
    ON vent.Comprobante_idComprobante = compPag.idComprobante
    INNER JOIN Persona perClie
    ON clie.idCliente = perClie.idPersona
    INNER JOIN Persona perEmple
    ON emple.idEmpleado =  perEmple.idPersona 
    INNER JOIN Cargo cargoEmple
    ON cargoEmple.idCargo = emple.Cargo_idCargo
    INNER JOIN TipoDeCliente tipoClie
    ON clie.tipoCliente = tipoClie.tipoCliente
    WHERE vent.idVenta = _idVenta;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_vestido_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_vestido_X_id`(
    IN _id_prenda INT
)
BEGIN
  SELECT *
    FROM Prenda  p
    JOIN Vestido v ON v.idPrenda = p.idPrenda
   WHERE p.idPrenda = _id_prenda;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_vigencia_X_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `obtener_vigencia_X_id`(in id int)
BEGIN
	select idVigencia,fechaInicio,fechaFin,activo from Vigencia where idVigencia=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_descontar_stock_fifo_prenda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `sp_descontar_stock_fifo_prenda`(
    IN p_idPrenda INT,
    IN p_talla    VARCHAR(10),
    IN p_cantidad INT
)
BEGIN
    DECLARE v_restante      INT DEFAULT p_cantidad;
    DECLARE v_idPrendaLote  INT;
    DECLARE v_stock_lote    INT;

    descontar_loop: WHILE v_restante > 0 DO

        SET v_idPrendaLote = NULL;
        SET v_stock_lote   = 0;

        SELECT idPrendaLote, stock
        INTO v_idPrendaLote, v_stock_lote
        FROM PrendaLote
        WHERE Prenda_idPrenda = p_idPrenda
          AND talla           = p_talla
          AND stock > 0
          AND activo = 1
        ORDER BY idPrendaLote ASC
        LIMIT 1;

        IF v_idPrendaLote IS NULL THEN
            LEAVE descontar_loop;
        END IF;

        IF v_stock_lote >= v_restante THEN
            UPDATE PrendaLote
            SET stock = stock - v_restante
            WHERE idPrendaLote = v_idPrendaLote;

            SET v_restante = 0;
        ELSE
            UPDATE PrendaLote
            SET stock = 0
            WHERE idPrendaLote = v_idPrendaLote;

            SET v_restante = v_restante - v_stock_lote;
        END IF;

    END WHILE descontar_loop;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verificar_cuenta_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `verificar_cuenta_usuario`(
    IN _username VARCHAR(75),
    IN _contrasenha VARCHAR(100) -- Le pongo 100 para ir sobrados (SHA256 usa 64)
)
BEGIN
    SELECT * FROM CuentaUsuario 
    WHERE username = _username
      AND contrasenha = _contrasenha  -- <--- ¡AQUÍ ESTÁ EL CAMBIO! (Sin MD5)
      AND activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-24  6:52:30
