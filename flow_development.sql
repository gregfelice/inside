-- MySQL dump 10.13  Distrib 5.5.28, for Linux (x86_64)
--
-- Host: localhost    Database: flow_development
-- ------------------------------------------------------
-- Server version	5.5.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` varchar(255) NOT NULL,
  `resource_type` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) DEFAULT NULL,
  `body` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `namespace` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_notes_on_resource_type_and_resource_id` (`resource_type`,`resource_id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_admin_comments`
--

LOCK TABLES `active_admin_comments` WRITE;
/*!40000 ALTER TABLE `active_admin_comments` DISABLE KEYS */;
INSERT INTO `active_admin_comments` VALUES (1,'2','AdminUser',1,'AdminUser','great!','2012-12-20 20:23:05','2012-12-20 20:23:05','admin');
/*!40000 ALTER TABLE `active_admin_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin@example.com','$2a$10$SNVwUIleTgm9Fh9Dx/paPOFQ10l11WOS22we.40IpShEDo9BR0ene',NULL,NULL,NULL,1,'2012-12-20 20:22:00','2012-12-20 20:22:00','170.149.100.10','170.149.100.10','2012-12-20 20:17:24','2012-12-20 20:22:00'),(2,'gregfelice@gmail.com','$2a$10$m7SD/t2q5YoNVo79NnhALum/oDr8OigGe9KApY/0cpk0xyRs.lpae',NULL,NULL,'2012-12-24 18:55:33',3,'2012-12-25 05:26:31','2012-12-24 18:55:33','69.117.160.83','69.117.160.83','2012-12-20 20:22:57','2012-12-25 05:26:31');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contractor` tinyint(1) DEFAULT NULL,
  `part_time_status` tinyint(1) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (183,0,0,'Marc Frons','CIO, SVP','2012-12-21 15:56:39','2012-12-21 15:56:39'),(184,0,0,'Rajiv Pant','CTO, VP','2012-12-21 15:56:39','2012-12-21 15:56:39'),(185,0,0,'Karim Meddahi','VP Infrastructure','2012-12-21 15:56:39','2012-12-21 15:56:39'),(186,0,0,'Brian Murphy','VP Engineering','2012-12-21 15:56:39','2012-12-21 15:56:39'),(187,0,0,'Mike Higgins','Chief Security Officer, VP','2012-12-21 15:56:39','2012-12-21 15:56:39'),(188,0,0,'Gary Sebel','Director, Security','2012-12-21 15:56:39','2012-12-21 15:56:39'),(189,0,0,'Jill Abramson','Executive Editor','2012-12-21 15:56:39','2012-12-21 15:56:39'),(190,0,0,'Denise Warren','SVP','2012-12-21 15:56:39','2012-12-21 15:56:39'),(191,0,0,'Jim Dryfoos','Associate Director, Project Management','2012-12-21 15:56:39','2012-12-21 15:56:39'),(192,0,0,'Mark O\'Callaghan','Director, Project Management','2012-12-21 15:56:39','2012-12-21 15:56:39'),(193,0,0,'Jagdish Reddy','Director, Quality','2012-12-21 15:56:39','2012-12-21 15:56:39'),(194,0,0,'Cameron Brown','Director, Ecommerce Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(195,0,0,'Deepak Mohite','Managing Director, Advertising Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(196,0,0,'John Tighe','Managing Director, Business Systems','2012-12-21 15:56:39','2012-12-21 15:56:39'),(197,0,0,'Cindy Taibi','Group Director, Advertising & Business Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(198,0,1,'Mike Wilson','Director, Porfolio Management Office','2012-12-21 15:56:39','2012-12-21 15:56:39'),(199,0,0,'Judy Gross','VP, Strategy','2012-12-21 15:56:39','2012-12-21 15:56:39'),(200,0,0,'David Perpich','VP, Product','2012-12-21 15:56:39','2012-12-21 15:56:39'),(201,0,0,'Rob Larson','VP, Search & Digital Production','2012-12-21 15:56:39','2012-12-21 15:56:39'),(202,0,0,'Brian Davenport','Managing Director, Shared Services Center','2012-12-21 15:56:39','2012-12-21 15:56:39'),(203,0,0,'Marguerite Brown-Toohey','Financial Director','2012-12-21 15:56:39','2012-12-21 15:56:39'),(204,0,0,'Karen Schmidt','Office Manager & Executive Assistant','2012-12-21 15:56:39','2012-12-21 15:56:39'),(205,0,0,'Brian Weigler','End User Services','2012-12-21 15:56:39','2012-12-21 15:56:39'),(206,0,0,'Felix Favorito','Enterprise Network & Storage Services','2012-12-21 15:56:39','2012-12-21 15:56:39'),(207,0,0,'Joel Beglieter','Enterprise Hosting & Computing Services','2012-12-21 15:56:39','2012-12-21 15:56:39'),(208,0,0,'Vadim Jelezniakov','Executive Director, nytimes.com Infrastructure','2012-12-21 15:56:39','2012-12-21 15:56:39'),(209,0,0,'Stephen Balducci','Shared Services & Program Management','2012-12-21 15:56:39','2012-12-21 15:56:39'),(210,0,0,'Alex Castro','Network Administration','2012-12-21 15:56:39','2012-12-21 15:56:39'),(211,1,0,'David Wang','Sr. Database Administrator','2012-12-21 15:56:39','2012-12-21 15:56:39'),(212,0,0,'Brian Hamman','Interactive News','2012-12-21 15:56:39','2012-12-21 15:56:39'),(213,0,0,'Tyson Evans','Interactive News','2012-12-21 15:56:39','2012-12-21 15:56:39'),(214,0,0,'Aron Pihofer','Executive Director & Editor, Interactive News','2012-12-21 15:56:39','2012-12-21 15:56:39'),(215,0,0,'Brad Kagawa','VP Technology, Print & Digital Editorial Systems','2012-12-21 15:56:39','2012-12-21 15:56:39'),(216,0,0,'Tahir Khan','Director, Business Intelligence','2012-12-21 15:56:39','2012-12-21 15:56:39'),(217,0,0,'Jason Phelps','Manager','2012-12-21 15:56:39','2012-12-21 15:56:39'),(218,0,0,'Greg Felice','Sr. Manager, Process Architecture','2012-12-21 15:56:39','2012-12-21 15:56:39'),(219,0,0,'Anniesa Singh','Administrative Assitant','2012-12-21 15:56:39','2012-12-21 15:56:39'),(220,0,0,'TBD','VP, Ecommerce Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(221,0,0,'Ian Moore','Group Director','2012-12-21 15:56:39','2012-12-21 15:56:39'),(222,0,0,'Lilia Tovbin','Associate Director','2012-12-21 15:56:39','2012-12-21 15:56:39'),(223,0,0,'Mark Gmunder','Print Publishing, News & Marketing Systems','2012-12-21 15:56:39','2012-12-21 15:56:39'),(224,0,0,'Luke Vnenchak','Director, CMS','2012-12-21 15:56:39','2012-12-21 15:56:39'),(225,0,0,'Rachel Berger','Associate Director, Program Management','2012-12-21 15:56:39','2012-12-21 15:56:39'),(226,0,0,'Chris Utz','Sr. Software Architect','2012-12-21 15:56:39','2012-12-21 15:56:39'),(227,0,0,'Satya','Database Engineer','2012-12-21 15:56:39','2012-12-21 15:56:39'),(228,0,0,'Sharon Sokoloff','Director, Data Warehousing','2012-12-21 15:56:39','2012-12-21 15:56:39'),(229,0,0,'Russ Simpkins','Manager, Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(230,0,0,'Ben Gerst','Executive Director, Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(231,0,0,'Mike Finkel','Executive Director, Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(232,0,0,'Jon Oden','Director, Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(233,0,0,'Scott Heekin-Canedy','President & General Manager, The New York Times','2012-12-21 15:56:39','2012-12-21 15:56:39'),(234,0,0,'Padma Akella','Software Architect','2012-12-21 15:56:39','2012-12-21 15:56:39'),(235,0,0,'Ashwin Singh','Manager, Quality Assurance','2012-12-21 15:56:39','2012-12-21 15:56:39'),(236,0,0,'Julius Sarkozy','Program Manager, Ecommerce Technology','2012-12-21 15:56:39','2012-12-21 15:56:39'),(237,0,0,'Arthur Sulzberger, Jr.','Publisher, Chairman & CEO','2012-12-21 15:56:39','2012-12-21 15:56:39'),(238,0,0,'Marci Windsheimer','Knowledge Manager','2012-12-21 15:56:55','2012-12-21 15:56:55'),(239,0,0,'Brad Stenger','Developer  Advocate','2012-12-21 15:56:55','2012-12-21 15:56:55'),(240,0,0,'Joseph Fiore','Technical Writer','2012-12-21 15:56:55','2012-12-21 15:56:55'),(241,0,0,'Darylin Mclaughhin','Compliance Manager','2012-12-21 15:56:55','2012-12-21 15:56:55'),(242,0,0,'Victor Bonato','Sr. Security Analyst','2012-12-21 15:56:55','2012-12-21 15:56:55'),(243,0,0,'Rustom Dadachanji','Security Analyst','2012-12-21 15:56:55','2012-12-21 15:56:55'),(244,0,0,'OPEN','Jr. Security Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(245,0,0,'Paul Wu','Manager Basis & SAP Security','2012-12-21 15:56:56','2012-12-21 15:56:56'),(246,0,0,'Elvin Torres','Systems Director','2012-12-21 15:56:56','2012-12-21 15:56:56'),(247,0,0,'David Doolittle','BI Tech Architect','2012-12-21 15:56:56','2012-12-21 15:56:56'),(248,0,0,'Tom Demuyt','Development Lead','2012-12-21 15:56:56','2012-12-21 15:56:56'),(249,0,0,'Rachel Goldstein','Manager','2012-12-21 15:56:56','2012-12-21 15:56:56'),(250,0,0,'Susan Chou','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(251,0,0,'Ed Migueles','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(252,0,0,'Tim Gilbert','NY Interface','2012-12-21 15:56:56','2012-12-21 15:56:56'),(253,0,0,'Shui Cho','Adv and FI','2012-12-21 15:56:56','2012-12-21 15:56:56'),(254,0,0,'Ed Koenig','Pricing, Orders and Products','2012-12-21 15:56:56','2012-12-21 15:56:56'),(255,0,0,'Li Yang','BP and Contracts','2012-12-21 15:56:56','2012-12-21 15:56:56'),(256,0,0,'Tina Morales','Classified, OCM and MAMC','2012-12-21 15:56:56','2012-12-21 15:56:56'),(257,0,0,'Donna Fazio','Contract Management','2012-12-21 15:56:56','2012-12-21 15:56:56'),(258,0,0,'Maya Prabhu','ABAP & Java','2012-12-21 15:56:56','2012-12-21 15:56:56'),(259,0,0,'Valerie Lodi','ABAP','2012-12-21 15:56:56','2012-12-21 15:56:56'),(260,0,0,'Raju Indukuru','Java','2012-12-21 15:56:56','2012-12-21 15:56:56'),(261,0,0,'Ganesh Sudaram','ABAP','2012-12-21 15:56:56','2012-12-21 15:56:56'),(262,0,0,'Tina Abad','Portals Function','2012-12-21 15:56:56','2012-12-21 15:56:56'),(263,0,0,'Hiren Parekh','Portals and MAMC','2012-12-21 15:56:56','2012-12-21 15:56:56'),(264,0,0,'Sebin Thomas','XI Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(265,0,0,'Michael Rojas','SFDC','2012-12-21 15:56:56','2012-12-21 15:56:56'),(266,0,0,'Anthony Lo Pomo','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(267,0,0,'Haris Agha','Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(268,0,0,'Dennis Walsh','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(269,0,0,'Mike Glantzberg','Director Single Copy Data & Analytics Systems','2012-12-21 15:56:56','2012-12-21 15:56:56'),(270,0,0,'Ed Scena','Director Single Copy Software Development','2012-12-21 15:56:56','2012-12-21 15:56:56'),(271,0,0,'Stan Seymore','Manager Payroll Systems','2012-12-21 15:56:56','2012-12-21 15:56:56'),(272,0,0,'Steve Bartenope','Manager','2012-12-21 15:56:56','2012-12-21 15:56:56'),(273,0,0,'Brian Hauff','Manager of Financial & Core App','2012-12-21 15:56:56','2012-12-21 15:56:56'),(274,0,0,'Al Pastore','Manager of POS','2012-12-21 15:56:56','2012-12-21 15:56:56'),(275,0,0,'Noel Fuentes','Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(276,0,0,'Sundhar L.','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(277,0,0,'Michael Chu','Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(278,0,0,'Photis Zissimatos','Sr. Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(279,0,0,'Mark Howell','Systems Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(280,0,0,'Tammy Szyba','Financial Manager Pay Model','2012-12-21 15:56:56','2012-12-21 15:56:56'),(281,0,0,'Elaine McWhinney-St. Louis','Financial Manager','2012-12-21 15:56:56','2012-12-21 15:56:56'),(282,0,0,'William Yeung','Financial Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(283,0,0,'Roger Caplan','Software Arch.','2012-12-21 15:56:56','2012-12-21 15:56:56'),(284,1,0,'Sandeep Saran','INFOSYS Onshore Project Manager','2012-12-21 15:56:56','2012-12-21 15:56:56'),(285,0,0,'Brian Lavery','ADX Reporting','2012-12-21 15:56:56','2012-12-21 15:56:56'),(286,1,0,'David Reinke','BI Architect','2012-12-21 15:56:56','2012-12-21 15:56:56'),(287,0,0,'Eric Krangel','Sr. Business Analyst','2012-12-21 15:56:56','2012-12-21 15:56:56'),(288,0,0,'Stephanie Yass','Assistant','2012-12-21 15:56:56','2012-12-21 15:56:56'),(289,0,0,'Saibal Patra','Manager Products / Optimization','2012-12-21 15:56:56','2012-12-21 15:56:56'),(290,0,0,'Rao Dumpeti','Manager Infra / Architecture','2012-12-21 15:56:56','2012-12-21 15:56:56'),(291,0,0,'Kirk Gordon','Lead Video Engineer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(292,0,0,'David Erwin','Lead Technologist Ad Innovation','2012-12-21 15:56:56','2012-12-21 15:56:56'),(293,0,0,'Eric Schorr','Lead Developer, Games','2012-12-21 15:56:56','2012-12-21 15:56:56'),(294,0,0,'Maan Najjar','Games','2012-12-21 15:56:56','2012-12-21 15:56:56'),(295,0,0,'Clint Fisher','Web Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(296,0,0,'Marcin Suterski','Software Arch.','2012-12-21 15:56:56','2012-12-21 15:56:56'),(297,0,0,'Sigfirido Chirinos','Web Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(298,0,0,'Patrick Fontillas','Web Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(299,0,0,'Ezell Burke','Web Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(300,0,0,'Timothy Helck','Software Engineer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(301,0,0,'Joe Williams','Web Developer','2012-12-21 15:56:56','2012-12-21 15:56:56'),(302,0,0,'Wayne Ginion','VP, Strategic Sourcing','2012-12-21 15:56:56','2012-12-21 15:56:56');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter` varchar(255) DEFAULT NULL,
  `description` text,
  `widget_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_parts_on_widget_id` (`widget_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts`
--

LOCK TABLES `parts` WRITE;
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` VALUES (1,'Greg Felice','Octagonal spree',1,'2012-12-19 20:56:31','2012-12-19 20:56:31'),(2,'Greg Felice','Rhomboid flange, indeed.',1,'2012-12-19 20:56:47','2012-12-20 20:32:06');
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_relationships`
--

DROP TABLE IF EXISTS `reporting_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `dotted` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=786 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_relationships`
--

LOCK TABLES `reporting_relationships` WRITE;
/*!40000 ALTER TABLE `reporting_relationships` DISABLE KEYS */;
INSERT INTO `reporting_relationships` VALUES (670,184,183,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(671,185,183,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(672,186,184,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(673,187,183,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(674,188,187,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(675,184,189,1,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(676,183,190,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(677,191,192,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(678,192,184,0,'2012-12-21 20:17:38','2012-12-21 20:17:38'),(679,193,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(680,195,197,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(681,196,197,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(682,197,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(683,198,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(684,199,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(685,200,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(686,201,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(687,202,183,1,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(688,203,183,1,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(689,204,183,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(690,205,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(691,206,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(692,207,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(693,208,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(694,209,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(695,210,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(696,211,185,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(697,212,214,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(698,213,214,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(699,217,218,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(700,214,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(701,215,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(702,216,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(703,218,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(704,219,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(705,194,220,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(706,220,184,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(707,221,220,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(708,227,228,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(709,226,216,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(710,228,216,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(711,229,230,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(712,230,186,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(713,222,220,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(714,231,186,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(715,232,186,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(716,190,233,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(717,234,216,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(718,235,193,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(719,236,220,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(720,233,237,0,'2012-12-21 20:17:39','2012-12-21 20:17:39'),(721,238,230,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(722,239,238,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(723,240,238,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(724,241,187,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(725,242,187,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(726,243,187,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(727,244,187,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(728,245,195,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(729,246,195,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(730,247,195,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(731,248,195,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(732,249,195,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(733,250,245,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(734,251,245,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(735,252,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(736,253,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(737,254,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(738,255,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(739,256,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(740,257,246,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(741,258,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(742,259,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(743,260,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(744,261,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(745,262,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(746,263,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(747,264,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(748,265,248,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(749,266,249,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(750,267,249,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(751,268,249,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(752,269,196,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(753,270,196,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(754,271,196,0,'2012-12-21 20:17:40','2012-12-21 20:17:40'),(755,272,196,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(756,273,270,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(757,274,270,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(758,275,273,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(759,276,274,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(760,277,271,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(761,278,271,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(762,279,272,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(763,280,203,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(764,281,203,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(765,282,281,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(766,283,215,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(767,284,215,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(768,285,216,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(769,286,216,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(770,287,216,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(771,288,186,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(772,289,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(773,290,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(774,291,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(775,292,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(776,293,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(777,294,232,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(778,295,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(779,296,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(780,297,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(781,298,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(782,299,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(783,300,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(784,301,222,0,'2012-12-21 20:17:41','2012-12-21 20:17:41'),(785,302,183,0,'2012-12-21 20:17:41','2012-12-21 20:17:41');
/*!40000 ALTER TABLE `reporting_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20121219200835'),('20121219204133'),('20121220092952'),('20121220194026'),('20121220195345'),('20121220201701'),('20121220201707'),('20121220201708'),('20121220215000'),('20121220221845'),('20121220222853');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,'Greg Felice Widget Owner','Green Widget','This is an amazing Widget. Yes. And, better yet, it\'s green.','2012-12-19 20:26:26','2012-12-20 20:30:53'),(2,'Greg Felice','Glorious Widget #841901000','This widget was created on Fri Dec 21 10:06:29 EST 2012','2012-12-21 15:06:29','2012-12-21 15:06:29'),(3,'Greg Felice','Glorious Widget #108319000','This widget was created on Fri Dec 21 10:09:38 EST 2012','2012-12-21 15:09:38','2012-12-21 15:09:38'),(4,'Greg Felice','Glorious Widget #262447000','This widget was created on Fri Dec 21 10:14:54 EST 2012','2012-12-21 15:14:54','2012-12-21 15:14:54');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-07 11:22:41
