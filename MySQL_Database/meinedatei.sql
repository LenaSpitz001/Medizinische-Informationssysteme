CREATE DATABASE  IF NOT EXISTS `hausarzt_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hausarzt_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: hausarzt_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `aenderungshistorie`
--

DROP TABLE IF EXISTS `aenderungshistorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aenderungshistorie` (
  `aenderung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tabellenname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datensatz_id` bigint unsigned NOT NULL,
  `feldname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alter_wert` text COLLATE utf8mb4_unicode_ci,
  `neuer_wert` text COLLATE utf8mb4_unicode_ci,
  `geaendert_von` bigint unsigned DEFAULT NULL,
  `geaendert_am` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `aenderungsgrund` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`aenderung_id`),
  KEY `idx_audit_objekt` (`tabellenname`,`datensatz_id`),
  KEY `fk_audit_user` (`geaendert_von`),
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`geaendert_von`) REFERENCES `benutzer` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aenderungshistorie`
--

LOCK TABLES `aenderungshistorie` WRITE;
/*!40000 ALTER TABLE `aenderungshistorie` DISABLE KEYS */;
/*!40000 ALTER TABLE `aenderungshistorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arzt`
--

DROP TABLE IF EXISTS `arzt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arzt` (
  `arzt_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `titel` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vorname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nachname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fachrichtung` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`arzt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arzt`
--

LOCK TABLES `arzt` WRITE;
/*!40000 ALTER TABLE `arzt` DISABLE KEYS */;
INSERT INTO `arzt` VALUES (1,'Dr.','Thomas','Berger','Allgemeinmedizin',NULL,NULL,'2026-11-06 11:41:08','2026-11-06 11:41:08'),(2,'Dr.','Miriam','Beispiel','Allgemeinmedizin',NULL,NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18');
/*!40000 ALTER TABLE `arzt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `benutzer`
--

DROP TABLE IF EXISTS `benutzer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `benutzer` (
  `user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `benutzername` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anzeige_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rolle` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aktiv` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_benutzername` (`benutzername`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `benutzer`
--

LOCK TABLES `benutzer` WRITE;
/*!40000 ALTER TABLE `benutzer` DISABLE KEYS */;
INSERT INTO `benutzer` VALUES (1,'studienfall_praxis_2026','Demo Praxispersonal','Praxispersonal',1,'2026-11-20 12:33:18','2026-11-20 12:33:18');
/*!40000 ALTER TABLE `benutzer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blutprobe`
--

DROP TABLE IF EXISTS `blutprobe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blutprobe` (
  `probe_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auftrag_id` bigint unsigned NOT NULL,
  `entnahme_ort_id` bigint unsigned DEFAULT NULL,
  `entnommen_von` bigint unsigned DEFAULT NULL,
  `proben_barcode` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `probenart` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Blut',
  `roehrchentyp` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'entnommen',
  `entnommen_am` datetime NOT NULL,
  `dokumentiert_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`probe_id`),
  UNIQUE KEY `uq_probe_barcode` (`proben_barcode`),
  KEY `fk_probe_auftrag` (`auftrag_id`),
  KEY `fk_probe_ort` (`entnahme_ort_id`),
  KEY `fk_probe_user` (`entnommen_von`),
  CONSTRAINT `fk_probe_auftrag` FOREIGN KEY (`auftrag_id`) REFERENCES `laborauftrag` (`auftrag_id`),
  CONSTRAINT `fk_probe_ort` FOREIGN KEY (`entnahme_ort_id`) REFERENCES `ort` (`ort_id`),
  CONSTRAINT `fk_probe_user` FOREIGN KEY (`entnommen_von`) REFERENCES `benutzer` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blutprobe`
--

LOCK TABLES `blutprobe` WRITE;
/*!40000 ALTER TABLE `blutprobe` DISABLE KEYS */;
INSERT INTO `blutprobe` VALUES (1,1,NULL,1,'DEMO-BLUT-2026-001','Blut',NULL,'uebermittelt','2026-11-20 09:25:00',NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `blutprobe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empfangener_befund`
--

DROP TABLE IF EXISTS `empfangener_befund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empfangener_befund` (
  `befund_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `encounter_id` bigint unsigned NOT NULL,
  `auftrag_id` bigint unsigned NOT NULL,
  `externe_befund_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `labor_name` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gesamtbewertung` text COLLATE utf8mb4_unicode_ci,
  `befund_freitext` text COLLATE utf8mb4_unicode_ci,
  `befundstatus` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `labor_freigegeben_am` datetime DEFAULT NULL,
  `empfangen_am` datetime NOT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`befund_id`),
  UNIQUE KEY `uq_empfangener_befund_extern` (`labor_name`,`externe_befund_id`),
  KEY `fk_empfbef_patient` (`patient_id`),
  KEY `fk_empfbef_encounter` (`encounter_id`),
  KEY `fk_empfbef_auftrag` (`auftrag_id`),
  CONSTRAINT `fk_empfbef_auftrag` FOREIGN KEY (`auftrag_id`) REFERENCES `laborauftrag` (`auftrag_id`),
  CONSTRAINT `fk_empfbef_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `fk_empfbef_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empfangener_befund`
--

LOCK TABLES `empfangener_befund` WRITE;
/*!40000 ALTER TABLE `empfangener_befund` DISABLE KEYS */;
INSERT INTO `empfangener_befund` VALUES (1,9,1,1,'1','Musterlabor','Fiktiver Lehrbefund',NULL,'endgueltig',NULL,'2026-11-20 12:15:00','2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `empfangener_befund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empfangenes_laborergebnis`
--

DROP TABLE IF EXISTS `empfangenes_laborergebnis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empfangenes_laborergebnis` (
  `ergebnis_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `befund_id` bigint unsigned NOT NULL,
  `probe_id` bigint unsigned NOT NULL,
  `auftrag_test_id` bigint unsigned DEFAULT NULL,
  `externe_ergebnis_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `antikoerperart` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `messwert` decimal(14,4) DEFAULT NULL,
  `ergebnis_text` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `einheit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referenz_min` decimal(14,4) DEFAULT NULL,
  `referenz_max` decimal(14,4) DEFAULT NULL,
  `referenz_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bewertung` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messmethode` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gemessen_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ergebnis_id`),
  KEY `fk_empferg_befund` (`befund_id`),
  KEY `fk_empferg_probe` (`probe_id`),
  KEY `fk_empferg_test` (`auftrag_test_id`),
  CONSTRAINT `fk_empferg_befund` FOREIGN KEY (`befund_id`) REFERENCES `empfangener_befund` (`befund_id`),
  CONSTRAINT `fk_empferg_probe` FOREIGN KEY (`probe_id`) REFERENCES `blutprobe` (`probe_id`),
  CONSTRAINT `fk_empferg_test` FOREIGN KEY (`auftrag_test_id`) REFERENCES `laborauftrag_test` (`auftrag_test_id`),
  CONSTRAINT `chk_ergebnis_wert` CHECK (((`messwert` is not null) or (`ergebnis_text` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empfangenes_laborergebnis`
--

LOCK TABLES `empfangenes_laborergebnis` WRITE;
/*!40000 ALTER TABLE `empfangenes_laborergebnis` DISABLE KEYS */;
INSERT INTO `empfangenes_laborergebnis` VALUES (1,1,1,1,'1','MASERN_IGG','Masern-IgG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(2,1,1,2,'2','ROETELN_IGG','Röteln-IgG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(3,1,1,3,'3','VARIZELLEN_IGG','Varizellen-IgG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(4,1,1,4,'4','ANTI_HBS','Hepatitis-B-Anti-HBs',125.0000,NULL,'mIU/mL',NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `empfangenes_laborergebnis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter` (
  `encounter_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `arzt_id` bigint unsigned NOT NULL,
  `ort_id` bigint unsigned DEFAULT NULL,
  `untersuchungsgrund` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beschwerden` text COLLATE utf8mb4_unicode_ci,
  `aktuelle_untersuchung` text COLLATE utf8mb4_unicode_ci,
  `aerztliche_beurteilung` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'offen',
  `begonnen_am` datetime NOT NULL,
  `beendet_am` datetime DEFAULT NULL,
  `dokumentiert_von` bigint unsigned DEFAULT NULL,
  `dokumentiert_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`encounter_id`),
  KEY `fk_encounter_patient` (`patient_id`),
  KEY `fk_encounter_arzt` (`arzt_id`),
  KEY `fk_encounter_ort` (`ort_id`),
  KEY `fk_encounter_user` (`dokumentiert_von`),
  CONSTRAINT `fk_encounter_arzt` FOREIGN KEY (`arzt_id`) REFERENCES `arzt` (`arzt_id`),
  CONSTRAINT `fk_encounter_ort` FOREIGN KEY (`ort_id`) REFERENCES `ort` (`ort_id`),
  CONSTRAINT `fk_encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_encounter_user` FOREIGN KEY (`dokumentiert_von`) REFERENCES `benutzer` (`user_id`),
  CONSTRAINT `chk_encounter_zeiten` CHECK (((`beendet_am` is null) or (`beendet_am` >= `begonnen_am`)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` VALUES (1,9,2,NULL,'Überprüfung des Antikörperstatus','Vorsorgliche Immunitätskontrolle',NULL,NULL,'abgeschlossen','2026-11-20 09:00:00','2026-11-20 09:30:00',1,NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18'),(2,2,1,NULL,'Allgemeine Vorsorgeuntersuchung','Keine akuten Beschwerden',NULL,NULL,'abgeschlossen','2026-11-20 10:00:00',NULL,NULL,NULL,'2026-11-20 12:39:47','2026-11-20 12:39:47');
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborauftrag`
--

DROP TABLE IF EXISTS `laborauftrag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborauftrag` (
  `auftrag_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `encounter_id` bigint unsigned NOT NULL,
  `arzt_id` bigint unsigned NOT NULL,
  `klinische_fragestellung` text COLLATE utf8mb4_unicode_ci,
  `aerztliche_anordnung` text COLLATE utf8mb4_unicode_ci,
  `prioritaet` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'erstellt',
  `angeordnet_am` datetime NOT NULL,
  `ans_labor_uebermittelt_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`auftrag_id`),
  KEY `fk_auftrag_patient` (`patient_id`),
  KEY `fk_auftrag_encounter` (`encounter_id`),
  KEY `fk_auftrag_arzt` (`arzt_id`),
  CONSTRAINT `fk_auftrag_arzt` FOREIGN KEY (`arzt_id`) REFERENCES `arzt` (`arzt_id`),
  CONSTRAINT `fk_auftrag_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `fk_auftrag_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborauftrag`
--

LOCK TABLES `laborauftrag` WRITE;
/*!40000 ALTER TABLE `laborauftrag` DISABLE KEYS */;
INSERT INTO `laborauftrag` VALUES (1,9,1,2,'Überprüfung des Impfschutzes','Antikörperbestimmung','normal','uebermittelt','2026-11-20 09:15:00',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18');
/*!40000 ALTER TABLE `laborauftrag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborauftrag_test`
--

DROP TABLE IF EXISTS `laborauftrag_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborauftrag_test` (
  `auftrag_test_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auftrag_id` bigint unsigned NOT NULL,
  `test_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'angefordert',
  `bemerkung` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`auftrag_test_id`),
  KEY `fk_auftrag_test_auftrag` (`auftrag_id`),
  CONSTRAINT `fk_auftrag_test_auftrag` FOREIGN KEY (`auftrag_id`) REFERENCES `laborauftrag` (`auftrag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborauftrag_test`
--

LOCK TABLES `laborauftrag_test` WRITE;
/*!40000 ALTER TABLE `laborauftrag_test` DISABLE KEYS */;
INSERT INTO `laborauftrag_test` VALUES (1,1,'MASERN_IGG','Masern-IgG','angefordert',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18'),(2,1,'ROETELN_IGG','Röteln-IgG','angefordert',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18'),(3,1,'VARIZELLEN_IGG','Varizellen-IgG','angefordert',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18'),(4,1,'ANTI_HBS','Hepatitis-B-Anti-HBs','angefordert',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18');
/*!40000 ALTER TABLE `laborauftrag_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ort`
--

DROP TABLE IF EXISTS `ort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ort` (
  `ort_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `einrichtungsname` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ort_typ` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `raum` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `strasse` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hausnummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plz` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stadt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ort`
--

LOCK TABLES `ort` WRITE;
/*!40000 ALTER TABLE `ort` DISABLE KEYS */;
/*!40000 ALTER TABLE `ort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `titel` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vorname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zweiter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dritter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vierter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nachname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `geburtsdatum` date NOT NULL,
  `geburtsort` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sozialversicherungsnummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patientenstatus` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aktiv',
  `sterbedatum` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `uq_patient_svnr` (`sozialversicherungsnummer`),
  CONSTRAINT `chk_patient_status` CHECK ((`patientenstatus` in (_utf8mb4'aktiv',_utf8mb4'inaktiv',_utf8mb4'verstorben')))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,NULL,'Paul',NULL,NULL,NULL,'Leitner','2005-05-26',NULL,NULL,'aktiv',NULL,'2026-11-06 11:32:18','2026-11-06 11:32:18'),(2,NULL,'Mara',NULL,NULL,NULL,'Ster','2006-03-15',NULL,NULL,'aktiv',NULL,'2026-11-06 11:32:18','2026-11-06 11:32:18'),(9,NULL,'Lara',NULL,NULL,NULL,'Studienfall','2000-03-15',NULL,NULL,'aktiv',NULL,'2026-11-20 12:33:18','2026-11-20 12:33:18');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_adresse`
--

DROP TABLE IF EXISTS `patient_adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_adresse` (
  `adresse_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `strasse` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hausnummer` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stiege` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stockwerk` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuernummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plz` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stadt` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ort` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bezirk` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bundesland` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Oesterreich',
  `gueltig_ab` datetime DEFAULT NULL,
  `gueltig_bis` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`adresse_id`),
  KEY `idx_adresse_patient` (`patient_id`),
  CONSTRAINT `fk_adresse_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `chk_adresse_gueltigkeit` CHECK (((`gueltig_bis` is null) or (`gueltig_ab` is null) or (`gueltig_bis` >= `gueltig_ab`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_adresse`
--

LOCK TABLES `patient_adresse` WRITE;
/*!40000 ALTER TABLE `patient_adresse` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_adresse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_allergie`
--

DROP TABLE IF EXISTS `patient_allergie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_allergie` (
  `allergie_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `allergen` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reaktion` text COLLATE utf8mb4_unicode_ci,
  `schweregrad` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `festgestellt_am` date DEFAULT NULL,
  `notiz` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`allergie_id`),
  KEY `fk_allergie_patient` (`patient_id`),
  CONSTRAINT `fk_allergie_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_allergie`
--

LOCK TABLES `patient_allergie` WRITE;
/*!40000 ALTER TABLE `patient_allergie` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_allergie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_details`
--

DROP TABLE IF EXISTS `patient_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_details` (
  `details_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `geschlecht` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gueltig_ab` datetime DEFAULT NULL,
  `gueltig_bis` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`details_id`),
  KEY `idx_details_patient` (`patient_id`),
  CONSTRAINT `fk_details_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `chk_details_gueltigkeit` CHECK (((`gueltig_bis` is null) or (`gueltig_ab` is null) or (`gueltig_bis` >= `gueltig_ab`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_details`
--

LOCK TABLES `patient_details` WRITE;
/*!40000 ALTER TABLE `patient_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_impfung`
--

DROP TABLE IF EXISTS `patient_impfung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_impfung` (
  `impfung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `impfstoff` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zielkrankheit` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `impfdatum` date DEFAULT NULL,
  `dosis_nummer` smallint unsigned DEFAULT NULL,
  `chargennummer` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `impfstelle` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dokumentationsquelle` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notiz` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`impfung_id`),
  KEY `fk_impfung_patient` (`patient_id`),
  CONSTRAINT `fk_impfung_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_impfung`
--

LOCK TABLES `patient_impfung` WRITE;
/*!40000 ALTER TABLE `patient_impfung` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_impfung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_kontakt`
--

DROP TABLE IF EXISTS `patient_kontakt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_kontakt` (
  `kontakt_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon_weitere` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bevorzugter_kontaktweg` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gueltig_ab` datetime DEFAULT NULL,
  `gueltig_bis` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kontakt_id`),
  KEY `idx_kontakt_patient` (`patient_id`),
  CONSTRAINT `fk_kontakt_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_kontakt`
--

LOCK TABLES `patient_kontakt` WRITE;
/*!40000 ALTER TABLE `patient_kontakt` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_kontakt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_krankengeschichte`
--

DROP TABLE IF EXISTS `patient_krankengeschichte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_krankengeschichte` (
  `krankengeschichte_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `krankheit` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnosecode` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chronisch` tinyint(1) DEFAULT NULL,
  `diagnose_am` date DEFAULT NULL,
  `krankheitsstatus` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fruehere_operationen` text COLLATE utf8mb4_unicode_ci,
  `krankenhausaufenthalte` text COLLATE utf8mb4_unicode_ci,
  `familiaere_vorgeschichte` text COLLATE utf8mb4_unicode_ci,
  `fruehere_behandlungen` text COLLATE utf8mb4_unicode_ci,
  `medizinische_besonderheiten` text COLLATE utf8mb4_unicode_ci,
  `notiz` text COLLATE utf8mb4_unicode_ci,
  `dokumentiert_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`krankengeschichte_id`),
  KEY `fk_krankengeschichte_patient` (`patient_id`),
  CONSTRAINT `fk_krankengeschichte_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_krankengeschichte`
--

LOCK TABLES `patient_krankengeschichte` WRITE;
/*!40000 ALTER TABLE `patient_krankengeschichte` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_krankengeschichte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_medikament`
--

DROP TABLE IF EXISTS `patient_medikament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_medikament` (
  `medikament_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `medikamentenname` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wirkstoff` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dosierung` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `einnahmehaeufigkeit` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beginn_am` date DEFAULT NULL,
  `ende_am` date DEFAULT NULL,
  `status` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notiz` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`medikament_id`),
  KEY `fk_medikament_patient` (`patient_id`),
  CONSTRAINT `fk_medikament_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_medikament`
--

LOCK TABLES `patient_medikament` WRITE;
/*!40000 ALTER TABLE `patient_medikament` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_medikament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_notfallkontakt`
--

DROP TABLE IF EXISTS `patient_notfallkontakt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_notfallkontakt` (
  `notfallkontakt_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beziehung` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `erreichbarkeit` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`notfallkontakt_id`),
  KEY `fk_notfall_patient` (`patient_id`),
  CONSTRAINT `fk_notfall_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_notfallkontakt`
--

LOCK TABLES `patient_notfallkontakt` WRITE;
/*!40000 ALTER TABLE `patient_notfallkontakt` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_notfallkontakt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_versicherung`
--

DROP TABLE IF EXISTS `patient_versicherung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_versicherung` (
  `versicherung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `versicherungstraeger` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `versicherungsart` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `versicherungsstatus` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anspruch_geprueft_am` datetime DEFAULT NULL,
  `gueltig_ab` date DEFAULT NULL,
  `gueltig_bis` date DEFAULT NULL,
  `mitversichert_bei` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`versicherung_id`),
  KEY `fk_versicherung_patient` (`patient_id`),
  CONSTRAINT `fk_versicherung_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_versicherung`
--

LOCK TABLES `patient_versicherung` WRITE;
/*!40000 ALTER TABLE `patient_versicherung` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_versicherung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_vertretung`
--

DROP TABLE IF EXISTS `patient_vertretung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_vertretung` (
  `vertretung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `vorname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nachname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beziehung` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vertretungsart` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vertretungsumfang` text COLLATE utf8mb4_unicode_ci,
  `strasse` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hausnummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plz` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stadt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gueltig_ab` date DEFAULT NULL,
  `gueltig_bis` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vertretung_id`),
  KEY `fk_vertretung_patient` (`patient_id`),
  CONSTRAINT `fk_vertretung_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_vertretung`
--

LOCK TABLES `patient_vertretung` WRITE;
/*!40000 ALTER TABLE `patient_vertretung` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_vertretung` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-20 13:58:44
CREATE DATABASE  IF NOT EXISTS `buchhaltung_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buchhaltung_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: buchhaltung_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `leistung`
--

DROP TABLE IF EXISTS `leistung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leistung` (
  `leistung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `leistungscode` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beschreibung` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preis` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`leistung_id`),
  CONSTRAINT `chk_leistung_preis` CHECK ((`preis` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leistung`
--

LOCK TABLES `leistung` WRITE;
/*!40000 ALTER TABLE `leistung` DISABLE KEYS */;
INSERT INTO `leistung` VALUES (1,'DEMO-AK-4','Antikörperbestimmung – 4 Parameter',60.00,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `leistung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rechnung`
--

DROP TABLE IF EXISTS `rechnung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rechnung` (
  `rechnung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rechnungsnummer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quellsystem` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hausarzt_db',
  `externe_patient_id` bigint unsigned NOT NULL,
  `externe_encounter_id` bigint unsigned DEFAULT NULL,
  `externe_auftrag_id` bigint unsigned DEFAULT NULL,
  `rechnungsempfaenger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rechnungsanschrift` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'entwurf',
  `rechnungsdatum` date NOT NULL,
  `faellig_am` date DEFAULT NULL,
  `bezahlt_am` datetime DEFAULT NULL,
  `bemerkung` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rechnung_id`),
  UNIQUE KEY `uq_rechnungsnummer` (`rechnungsnummer`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechnung`
--

LOCK TABLES `rechnung` WRITE;
/*!40000 ALTER TABLE `rechnung` DISABLE KEYS */;
INSERT INTO `rechnung` VALUES (1,'DEMO-RE-2026-001','hausarzt_db',9,1,1,'Lara Studienfall',NULL,'entwurf','2026-11-20',NULL,NULL,NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `rechnung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rechnungsposition`
--

DROP TABLE IF EXISTS `rechnungsposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rechnungsposition` (
  `position_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rechnung_id` bigint unsigned NOT NULL,
  `leistung_id` bigint unsigned DEFAULT NULL,
  `beschreibung` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anzahl` decimal(10,2) NOT NULL DEFAULT '1.00',
  `einzelpreis` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`position_id`),
  KEY `fk_pos_rechnung` (`rechnung_id`),
  KEY `fk_pos_leistung` (`leistung_id`),
  CONSTRAINT `fk_pos_leistung` FOREIGN KEY (`leistung_id`) REFERENCES `leistung` (`leistung_id`),
  CONSTRAINT `fk_pos_rechnung` FOREIGN KEY (`rechnung_id`) REFERENCES `rechnung` (`rechnung_id`),
  CONSTRAINT `chk_pos_anzahl` CHECK ((`anzahl` > 0)),
  CONSTRAINT `chk_pos_preis` CHECK ((`einzelpreis` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechnungsposition`
--

LOCK TABLES `rechnungsposition` WRITE;
/*!40000 ALTER TABLE `rechnungsposition` DISABLE KEYS */;
INSERT INTO `rechnungsposition` VALUES (1,1,1,'Fiktive Antikörperuntersuchung',1.00,60.00,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `rechnungsposition` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-20 13:58:48
CREATE DATABASE  IF NOT EXISTS `labor_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `labor_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: labor_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `aenderungshistorie`
--

DROP TABLE IF EXISTS `aenderungshistorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aenderungshistorie` (
  `aenderung_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tabellenname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datensatz_id` bigint unsigned NOT NULL,
  `feldname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alter_wert` text COLLATE utf8mb4_unicode_ci,
  `neuer_wert` text COLLATE utf8mb4_unicode_ci,
  `geaendert_von_laborant_id` bigint unsigned DEFAULT NULL,
  `geaendert_am` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `aenderungsgrund` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`aenderung_id`),
  KEY `fk_lis_audit_laborant` (`geaendert_von_laborant_id`),
  CONSTRAINT `fk_lis_audit_laborant` FOREIGN KEY (`geaendert_von_laborant_id`) REFERENCES `laborant` (`laborant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aenderungshistorie`
--

LOCK TABLES `aenderungshistorie` WRITE;
/*!40000 ALTER TABLE `aenderungshistorie` DISABLE KEYS */;
/*!40000 ALTER TABLE `aenderungshistorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `befund_ergebnis`
--

DROP TABLE IF EXISTS `befund_ergebnis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `befund_ergebnis` (
  `befund_id` bigint unsigned NOT NULL,
  `ergebnis_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`befund_id`,`ergebnis_id`),
  KEY `fk_befunderg_ergebnis` (`ergebnis_id`),
  CONSTRAINT `fk_befunderg_befund` FOREIGN KEY (`befund_id`) REFERENCES `laborbefund` (`befund_id`),
  CONSTRAINT `fk_befunderg_ergebnis` FOREIGN KEY (`ergebnis_id`) REFERENCES `laborergebnis` (`ergebnis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `befund_ergebnis`
--

LOCK TABLES `befund_ergebnis` WRITE;
/*!40000 ALTER TABLE `befund_ergebnis` DISABLE KEYS */;
INSERT INTO `befund_ergebnis` VALUES (1,1),(1,2),(1,3),(1,4);
/*!40000 ALTER TABLE `befund_ergebnis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labor`
--

DROP TABLE IF EXISTS `labor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labor` (
  `labor_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `strasse` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hausnummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plz` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stadt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`labor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labor`
--

LOCK TABLES `labor` WRITE;
/*!40000 ALTER TABLE `labor` DISABLE KEYS */;
INSERT INTO `labor` VALUES (1,'Musterlabor',NULL,NULL,NULL,'Musterstadt',NULL,NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `labor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labor_patient`
--

DROP TABLE IF EXISTS `labor_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labor_patient` (
  `labor_patient_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quellsystem` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hausarzt_db',
  `externe_patient_id` bigint unsigned NOT NULL,
  `vorname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zweiter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dritter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vierter_vorname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nachname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `geburtsdatum` date NOT NULL,
  `geschlecht` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`labor_patient_id`),
  UNIQUE KEY `uq_labor_patient_extern` (`quellsystem`,`externe_patient_id`),
  UNIQUE KEY `uq_patient_quellsystem` (`quellsystem`,`externe_patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labor_patient`
--

LOCK TABLES `labor_patient` WRITE;
/*!40000 ALTER TABLE `labor_patient` DISABLE KEYS */;
INSERT INTO `labor_patient` VALUES (1,'hausarzt_db',9,'Lara',NULL,NULL,NULL,'Studienfall','2000-03-15',NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `labor_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborant`
--

DROP TABLE IF EXISTS `laborant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborant` (
  `laborant_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_id` bigint unsigned NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`laborant_id`),
  KEY `fk_laborant_labor` (`labor_id`),
  CONSTRAINT `fk_laborant_labor` FOREIGN KEY (`labor_id`) REFERENCES `labor` (`labor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborant`
--

LOCK TABLES `laborant` WRITE;
/*!40000 ALTER TABLE `laborant` DISABLE KEYS */;
INSERT INTO `laborant` VALUES (1,1,'Alex Muster',NULL,NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborauftrag_lis`
--

DROP TABLE IF EXISTS `laborauftrag_lis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborauftrag_lis` (
  `labor_auftrag_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_patient_id` bigint unsigned NOT NULL,
  `labor_id` bigint unsigned NOT NULL,
  `quellsystem` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hausarzt_db',
  `externe_auftrag_id` bigint unsigned NOT NULL,
  `externe_arzt_id` bigint unsigned DEFAULT NULL,
  `anfordernder_arzt_name` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anfordernde_praxis` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anfordernde_praxis_kontakt` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aerztliche_anordnung` text COLLATE utf8mb4_unicode_ci,
  `klinische_angaben` text COLLATE utf8mb4_unicode_ci,
  `prioritaet` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'eingegangen',
  `angeordnet_am` datetime DEFAULT NULL,
  `im_labor_eingegangen_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`labor_auftrag_id`),
  UNIQUE KEY `uq_laborauftrag_extern` (`quellsystem`,`externe_auftrag_id`),
  KEY `fk_lisauftrag_patient` (`labor_patient_id`),
  KEY `fk_lisauftrag_labor` (`labor_id`),
  CONSTRAINT `fk_lisauftrag_labor` FOREIGN KEY (`labor_id`) REFERENCES `labor` (`labor_id`),
  CONSTRAINT `fk_lisauftrag_patient` FOREIGN KEY (`labor_patient_id`) REFERENCES `labor_patient` (`labor_patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborauftrag_lis`
--

LOCK TABLES `laborauftrag_lis` WRITE;
/*!40000 ALTER TABLE `laborauftrag_lis` DISABLE KEYS */;
INSERT INTO `laborauftrag_lis` VALUES (1,1,1,'hausarzt_db',1,2,'Dr. Miriam Beispiel',NULL,NULL,NULL,NULL,'normal','eingegangen',NULL,'2026-11-20 10:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborauftrag_lis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborauftrag_test_lis`
--

DROP TABLE IF EXISTS `laborauftrag_test_lis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborauftrag_test_lis` (
  `labor_test_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_auftrag_id` bigint unsigned NOT NULL,
  `externe_auftrag_test_id` bigint unsigned DEFAULT NULL,
  `test_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'angefordert',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`labor_test_id`),
  KEY `fk_listest_auftrag` (`labor_auftrag_id`),
  CONSTRAINT `fk_listest_auftrag` FOREIGN KEY (`labor_auftrag_id`) REFERENCES `laborauftrag_lis` (`labor_auftrag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborauftrag_test_lis`
--

LOCK TABLES `laborauftrag_test_lis` WRITE;
/*!40000 ALTER TABLE `laborauftrag_test_lis` DISABLE KEYS */;
INSERT INTO `laborauftrag_test_lis` VALUES (1,1,1,'MASERN_IGG','Masern-IgG','angefordert','2026-11-20 12:33:19','2026-11-20 12:33:19'),(2,1,2,'ROETELN_IGG','Röteln-IgG','angefordert','2026-11-20 12:33:19','2026-11-20 12:33:19'),(3,1,3,'VARIZELLEN_IGG','Varizellen-IgG','angefordert','2026-11-20 12:33:19','2026-11-20 12:33:19'),(4,1,4,'ANTI_HBS','Hepatitis-B-Anti-HBs','angefordert','2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborauftrag_test_lis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborbefund`
--

DROP TABLE IF EXISTS `laborbefund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborbefund` (
  `befund_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_auftrag_id` bigint unsigned NOT NULL,
  `labor_id` bigint unsigned NOT NULL,
  `befundnummer` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gesamtbewertung` text COLLATE utf8mb4_unicode_ci,
  `befund_freitext` text COLLATE utf8mb4_unicode_ci,
  `freigabestatus` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'vorlaeufig',
  `freigegeben_von` bigint unsigned DEFAULT NULL,
  `freigegeben_am` datetime DEFAULT NULL,
  `an_hausarzt_gesendet_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`befund_id`),
  UNIQUE KEY `uq_befundnummer` (`befundnummer`),
  KEY `fk_befund_lisauftrag` (`labor_auftrag_id`),
  KEY `fk_befund_labor` (`labor_id`),
  KEY `fk_befund_freigabe` (`freigegeben_von`),
  CONSTRAINT `fk_befund_freigabe` FOREIGN KEY (`freigegeben_von`) REFERENCES `laborant` (`laborant_id`),
  CONSTRAINT `fk_befund_labor` FOREIGN KEY (`labor_id`) REFERENCES `labor` (`labor_id`),
  CONSTRAINT `fk_befund_lisauftrag` FOREIGN KEY (`labor_auftrag_id`) REFERENCES `laborauftrag_lis` (`labor_auftrag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborbefund`
--

LOCK TABLES `laborbefund` WRITE;
/*!40000 ALTER TABLE `laborbefund` DISABLE KEYS */;
INSERT INTO `laborbefund` VALUES (1,1,1,'DEMO-BEF-2026-001','Fiktive Ergebnisse ohne klinische Bewertung','Vier simulierte Antikörperuntersuchungen.','endgueltig',1,'2026-11-20 12:00:00',NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborbefund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborergebnis`
--

DROP TABLE IF EXISTS `laborergebnis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborergebnis` (
  `ergebnis_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_probe_id` bigint unsigned NOT NULL,
  `labor_test_id` bigint unsigned NOT NULL,
  `laborant_id` bigint unsigned DEFAULT NULL,
  `antikoerperart` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messwert` decimal(14,4) DEFAULT NULL,
  `ergebnis_text` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `einheit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referenz_min` decimal(14,4) DEFAULT NULL,
  `referenz_max` decimal(14,4) DEFAULT NULL,
  `referenz_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bewertung` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messmethode` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ergebnis_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'vorlaeufig',
  `gemessen_am` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ergebnis_id`),
  KEY `fk_laborergebnis_probe` (`labor_probe_id`),
  KEY `fk_laborergebnis_test` (`labor_test_id`),
  KEY `fk_laborergebnis_laborant` (`laborant_id`),
  CONSTRAINT `fk_laborergebnis_laborant` FOREIGN KEY (`laborant_id`) REFERENCES `laborant` (`laborant_id`),
  CONSTRAINT `fk_laborergebnis_probe` FOREIGN KEY (`labor_probe_id`) REFERENCES `laborprobe` (`labor_probe_id`),
  CONSTRAINT `fk_laborergebnis_test` FOREIGN KEY (`labor_test_id`) REFERENCES `laborauftrag_test_lis` (`labor_test_id`),
  CONSTRAINT `chk_laborergebnis_wert` CHECK (((`messwert` is not null) or (`ergebnis_text` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborergebnis`
--

LOCK TABLES `laborergebnis` WRITE;
/*!40000 ALTER TABLE `laborergebnis` DISABLE KEYS */;
INSERT INTO `laborergebnis` VALUES (1,1,1,1,'Masern-IgG','MASERN_IGG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','endgueltig','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(2,1,2,1,'Röteln-IgG','ROETELN_IGG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','endgueltig','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(3,1,3,1,'Varizellen-IgG','VARIZELLEN_IGG',NULL,'positiv (Demowert)',NULL,NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','endgueltig','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19'),(4,1,4,1,'Hepatitis-B-Anti-HBs','ANTI_HBS',125.0000,NULL,'mIU/mL',NULL,NULL,'Nur Demonstration, kein klinischer Referenzwert','Nicht medizinisch bewertet','Synthetische Testdaten','endgueltig','2026-11-20 11:00:00','2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborergebnis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laborprobe`
--

DROP TABLE IF EXISTS `laborprobe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laborprobe` (
  `labor_probe_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `labor_auftrag_id` bigint unsigned NOT NULL,
  `externe_probe_id` bigint unsigned NOT NULL,
  `proben_barcode` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `probenart` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roehrchentyp` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entnommen_am` datetime NOT NULL,
  `eingegangen_am` datetime DEFAULT NULL,
  `probenzustand` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'eingegangen',
  `ablehnungsgrund` text COLLATE utf8mb4_unicode_ci,
  `geprueft_von` bigint unsigned DEFAULT NULL,
  `geprueft_am` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`labor_probe_id`),
  UNIQUE KEY `uq_laborprobe_barcode` (`proben_barcode`),
  KEY `fk_laborprobe_auftrag` (`labor_auftrag_id`),
  KEY `fk_laborprobe_laborant` (`geprueft_von`),
  CONSTRAINT `fk_laborprobe_auftrag` FOREIGN KEY (`labor_auftrag_id`) REFERENCES `laborauftrag_lis` (`labor_auftrag_id`),
  CONSTRAINT `fk_laborprobe_laborant` FOREIGN KEY (`geprueft_von`) REFERENCES `laborant` (`laborant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laborprobe`
--

LOCK TABLES `laborprobe` WRITE;
/*!40000 ALTER TABLE `laborprobe` DISABLE KEYS */;
INSERT INTO `laborprobe` VALUES (1,1,1,'DEMO-BLUT-2026-001','Blut',NULL,'2026-11-20 09:25:00','2026-11-20 10:00:00',NULL,'analysiert',NULL,NULL,NULL,'2026-11-20 12:33:19','2026-11-20 12:33:19');
/*!40000 ALTER TABLE `laborprobe` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-20 13:58:52
