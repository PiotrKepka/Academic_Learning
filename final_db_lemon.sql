-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: final_db_lemon
-- ------------------------------------------------------
-- Server version	8.0.33

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

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `Booking_ID` int NOT NULL AUTO_INCREMENT,
  `Table_Number` int NOT NULL,
  `Booking_Date` date NOT NULL,
  `Customer_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  `Menu_ID` int NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `Customer_ID_idx` (`Customer_ID`),
  KEY `Order_ID_idx` (`Order_ID`),
  KEY `Menu_ID_idx` (`Menu_ID`),
  CONSTRAINT `Customer_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `customers_details` (`Customer_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Menu_ID` FOREIGN KEY (`Menu_ID`) REFERENCES `menu` (`Menu_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_ID` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,'2023-08-10',1,1,1),(2,2,'2023-08-11',2,2,2),(3,3,'2023-08-12',3,3,3);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_details`
--

DROP TABLE IF EXISTS `customers_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_details` (
  `Customer_ID` int NOT NULL,
  `Full_Name` varchar(100) DEFAULT NULL,
  `Contact_Number` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Staff_Information_ID` int DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  KEY `Staff_Information_ID_idx` (`Staff_Information_ID`),
  CONSTRAINT `Staff_Information_ID` FOREIGN KEY (`Staff_Information_ID`) REFERENCES `staff_information` (`Staff_Information_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_details`
--

LOCK TABLES `customers_details` WRITE;
/*!40000 ALTER TABLE `customers_details` DISABLE KEYS */;
INSERT INTO `customers_details` VALUES (1,'Mario','New York','Mario@littlelemon.com',1),(2,'Hagen','Berlin','Hagen@littlelemon.com',2),(3,'Piotr','Poznan','Piter@littlelemon.com',3);
/*!40000 ALTER TABLE `customers_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `Menu_ID` int NOT NULL,
  `Cuisine` varchar(45) DEFAULT NULL,
  `Menu_Item_ID` int DEFAULT NULL,
  PRIMARY KEY (`Menu_ID`),
  KEY `Menu_Item_ID_idx` (`Menu_Item_ID`),
  CONSTRAINT `Menu_Item_ID` FOREIGN KEY (`Menu_Item_ID`) REFERENCES `menu_items` (`Menu_Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Greek',1),(2,'German',2),(3,'Poland',3);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `Menu_Item_ID` int NOT NULL,
  `Starter_Name` varchar(45) DEFAULT NULL,
  `Course_Name` varchar(45) DEFAULT NULL,
  `Dessert_Name` varchar(45) DEFAULT NULL,
  `Drink_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Menu_Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,'Olives&Bread','Greek Salad','Bacla','Sambuca'),(2,'Apertif','Bawarian Sousage','Apple Cake','Snapchs'),(3,'Red herring','Russian Dumplings','Poppy Seed','Owner');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_delivery_status`
--

DROP TABLE IF EXISTS `order_delivery_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_delivery_status` (
  `Order_Delivery_status_ID` int NOT NULL,
  `Delivery_Date` date DEFAULT NULL,
  `Delivery_Status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Order_Delivery_status_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_delivery_status`
--

LOCK TABLES `order_delivery_status` WRITE;
/*!40000 ALTER TABLE `order_delivery_status` DISABLE KEYS */;
INSERT INTO `order_delivery_status` VALUES (1,'2023-08-09','Done'),(2,'2023-08-10','Waiting'),(3,'2023-08-08','Done');
/*!40000 ALTER TABLE `order_delivery_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL,
  `Date` date DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Cost` decimal(10,0) DEFAULT NULL,
  `Order_Delivery_Status_ID` int DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Order_Delivery_Status_ID_idx` (`Order_Delivery_Status_ID`),
  CONSTRAINT `Order_Delivery_Status_ID` FOREIGN KEY (`Order_Delivery_Status_ID`) REFERENCES `order_delivery_status` (`Order_Delivery_status_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2023-08-09',1,500,1),(2,'2023-08-10',2,350,2),(3,'2023-08-11',3,420,3);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_information`
--

DROP TABLE IF EXISTS `staff_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_information` (
  `Staff_Information_ID` int NOT NULL,
  `Role` varchar(100) DEFAULT NULL,
  `Salary` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`Staff_Information_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_information`
--

LOCK TABLES `staff_information` WRITE;
/*!40000 ALTER TABLE `staff_information` DISABLE KEYS */;
INSERT INTO `staff_information` VALUES (1,'Technician',6000),(2,'Planner',4500),(3,'Accountant',5100);
/*!40000 ALTER TABLE `staff_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-13 15:14:39
