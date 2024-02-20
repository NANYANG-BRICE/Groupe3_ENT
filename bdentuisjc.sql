CREATE DATABASE  IF NOT EXISTS `bdentuisjc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bdentuisjc`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: bdentuisjc
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `apllicationid` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`apllicationid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,'gestionote');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `droit`
--

DROP TABLE IF EXISTS `droit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `droit` (
  `droitid` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `ecriture` tinyint(1) DEFAULT '0',
  `lecture` tinyint(1) DEFAULT '0',
  `modification` tinyint(1) DEFAULT '0',
  `suppression` tinyint(1) DEFAULT '0',
  `codeapplicationid` bigint DEFAULT NULL,
  PRIMARY KEY (`droitid`),
  KEY `codeapplicationid` (`codeapplicationid`),
  CONSTRAINT `droit_ibfk_1` FOREIGN KEY (`codeapplicationid`) REFERENCES `application` (`apllicationid`)
) ENGINE=InnoDB AUTO_INCREMENT=102855 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `droit`
--

LOCK TABLES `droit` WRITE;
/*!40000 ALTER TABLE `droit` DISABLE KEYS */;
INSERT INTO `droit` VALUES (102852,'Releve','juste le releve',1,1,1,1,1),(102854,'lecture','juste le releve',0,1,0,0,1);
/*!40000 ALTER TABLE `droit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleid` bigint NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=103103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (102755,'Admin','rien que le user'),(103102,'User','rien que le user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_droit`
--

DROP TABLE IF EXISTS `role_droit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_droit` (
  `code_roleid` bigint NOT NULL,
  `code_droitid` bigint NOT NULL,
  KEY `code_roleid` (`code_roleid`),
  KEY `code_droitid` (`code_droitid`),
  CONSTRAINT `role_droit_ibfk_1` FOREIGN KEY (`code_roleid`) REFERENCES `role` (`roleid`),
  CONSTRAINT `role_droit_ibfk_2` FOREIGN KEY (`code_droitid`) REFERENCES `droit` (`droitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_droit`
--

LOCK TABLES `role_droit` WRITE;
/*!40000 ALTER TABLE `role_droit` DISABLE KEYS */;
INSERT INTO `role_droit` VALUES (103102,102852),(102755,102854);
/*!40000 ALTER TABLE `role_droit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `matricule` varchar(50) DEFAULT NULL,
  `filiere` varchar(50) DEFAULT NULL,
  `classe` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (101,'Nounamo','nounamoestrella@gmail.com','$2a$10$gB2hhZQl9xOFQi9q6rhA6eesRlxuptaYldrkp2mBq7PMMP8prbfW2','2','51','33602','/photo/2021i074.jpg'),(204,'TAGNE','Elohim237@gmail.com','$2a$10$gB2hhZQl9xOFQi9q6rhA6eesRlxuptaYldrkp2mBq7PMMP8prbfW2',NULL,NULL,NULL,'/photo/2021i074.jpg'),(205,'nkot','francine@gmail.com','$2a$10$gB2hhZQl9xOFQi9q6rhA6eesRlxuptaYldrkp2mBq7PMMP8prbfW2',NULL,NULL,NULL,'/photo/2021i075.jpg'),(207,'nkot','etiennenkot2@gmail.com','$2a$10$gB2hhZQl9xOFQi9q6rhA6eesRlxuptaYldrkp2mBq7PMMP8prbfW2','1',NULL,NULL,'/photo/2021i074.jpg'),(208,'nkot','etiennenkot3@gmail.com','$2a$10$gB2hhZQl9xOFQi9q6rhA6eesRlxuptaYldrkp2mBq7PMMP8prbfW2','2',NULL,NULL,'/photo/2021i075.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `id` bigint NOT NULL,
  `passwordhash` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `code_userid` bigint NOT NULL,
  `code_role` bigint NOT NULL,
  PRIMARY KEY (`code_userid`,`code_role`),
  KEY `code_role` (`code_role`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`code_userid`) REFERENCES `user` (`userid`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`code_role`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (204,102755),(205,102755),(207,102755),(208,102755),(101,103102);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_id_seq`
--

DROP TABLE IF EXISTS `users_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_id_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_id_seq`
--

LOCK TABLES `users_id_seq` WRITE;
/*!40000 ALTER TABLE `users_id_seq` DISABLE KEYS */;
INSERT INTO `users_id_seq` VALUES (1);
/*!40000 ALTER TABLE `users_id_seq` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-20  2:12:32
