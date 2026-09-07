-- MySQL dump 10.13  Distrib 8.0.45, for macos26.3 (arm64)
--
-- Host: localhost    Database: IGKD
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ANNOTATION_SOURCE`
--

DROP TABLE IF EXISTS `ANNOTATION_SOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ANNOTATION_SOURCE` (
  `source_id` int NOT NULL,
  `annotation_id` int NOT NULL,
  PRIMARY KEY (`source_id`,`annotation_id`),
  KEY `ANNSOURCE_ANNOTATION_FK` (`annotation_id`),
  CONSTRAINT `ANNSOURCE_ANNOTATION_FK` FOREIGN KEY (`annotation_id`) REFERENCES `GENE_ANNOTATION` (`annotation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ANNSOURCE_SOURCE_FK` FOREIGN KEY (`source_id`) REFERENCES `SOURCE` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ANNOTATION_SOURCE`
--

LOCK TABLES `ANNOTATION_SOURCE` WRITE;
/*!40000 ALTER TABLE `ANNOTATION_SOURCE` DISABLE KEYS */;
INSERT INTO `ANNOTATION_SOURCE` VALUES (1,1),(2,2),(3,3),(5,5),(6,6);
/*!40000 ALTER TABLE `ANNOTATION_SOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE`
--

DROP TABLE IF EXISTS `GENE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE` (
  `gene_id` int NOT NULL AUTO_INCREMENT,
  `gene_symbol` varchar(20) NOT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `chromosome` varchar(20) NOT NULL,
  `start_position` int NOT NULL,
  `end_position` int NOT NULL,
  `strand` char(1) NOT NULL,
  `organism_id` int NOT NULL,
  PRIMARY KEY (`gene_id`),
  UNIQUE KEY `GENE_SYMBOL_UNIQUE` (`gene_symbol`,`organism_id`),
  KEY `GENE_ORG_FK` (`organism_id`),
  CONSTRAINT `GENE_ORG_FK` FOREIGN KEY (`organism_id`) REFERENCES `ORGANISM` (`organism_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GENE_START_CHECK` CHECK (((`start_position` >= 0) and (`start_position` < `end_position`))),
  CONSTRAINT `GENE_STRAND_CHECK` CHECK ((`strand` in (_utf8mb4'+',_utf8mb4'-')))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE`
--

LOCK TABLES `GENE` WRITE;
/*!40000 ALTER TABLE `GENE` DISABLE KEYS */;
INSERT INTO `GENE` VALUES (1,'TP53',NULL,'17',7668421,7687490,'-',1),(2,'EGFR',NULL,'7',55019017,55211628,'+',1),(3,'APOE',NULL,'19',44905796,44909393,'+',1),(4,'TNF',NULL,'6',31575565,31578336,'+',1),(5,'IL6',NULL,'7',22727200,22731998,'+',1),(6,'VEGFA',NULL,'6',43770211,43786487,'+',1),(7,'TGFB1',NULL,'19',41330323,41353922,'-',1),(8,'MTHFR',NULL,'1',11785723,11805964,'-',1),(9,'BRCA1',NULL,'17',43044295,43170327,'-',1),(10,'ACE',NULL,'17',63477061,63498373,'+',1),(11,'STAT3',NULL,'17',42313324,42388442,'-',1),(12,'Blm',NULL,'3R',11736810,11741783,'-',2),(13,'N',NULL,'X',3134870,3172221,'+',2),(14,'dpp',NULL,'2L',2428372,2459823,'+',2),(15,'PHYB',NULL,'2',8139756,8144461,'+',3),(16,'FLC',NULL,'5',3173382,3179448,'-',3),(17,'PHYA',NULL,'1',3095160,3100819,'-',3),(18,'recA',NULL,'1',2822708,2823769,'-',4),(19,'dnaA',NULL,'1',3882326,3883729,'-',4),(20,'rho',NULL,'1',3966417,3967676,'+',4),(21,'daf-16',NULL,'1',10750498,10776703,'+',5),(22,'daf-2',NULL,'3',2994514,3040846,'-',5),(23,'skn-1',NULL,'4',5651039,5660384,'-',5),(24,'BRCA2',NULL,'13',32315077,32400268,'+',1),(25,'PALB2',NULL,'16',23603165,23641310,'-',1),(26,'TRP53',NULL,'11',69471174,69482699,'+',6),(27,'TRP63',NULL,'16',25502513,25710842,'+',6),(28,'TRP73',NULL,'4',154140706,154224332,'-',6),(29,'TP63',NULL,'3',189596746,189897276,'+',1);
/*!40000 ALTER TABLE `GENE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_ANNOTATION`
--

DROP TABLE IF EXISTS `GENE_ANNOTATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_ANNOTATION` (
  `annotation_id` int NOT NULL AUTO_INCREMENT,
  `gene_product_id` int NOT NULL,
  `go_id` varchar(15) NOT NULL,
  `evidence_code` varchar(3) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_update` datetime NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`annotation_id`),
  UNIQUE KEY `GENEANN_GENE_GO_UNIQUE` (`gene_product_id`,`go_id`),
  KEY `GENEANN_GOTERM_FK` (`go_id`),
  CONSTRAINT `GENEANN_GENE_FK` FOREIGN KEY (`gene_product_id`) REFERENCES `GENE_PRODUCT` (`gene_product_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GENEANN_GOTERM_FK` FOREIGN KEY (`go_id`) REFERENCES `GO_TERM` (`go_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GENEANN_CODE_CHECK` CHECK ((`evidence_code` in (_utf8mb4'EXP',_utf8mb4'IDA',_utf8mb4'IPI',_utf8mb4'IMP',_utf8mb4'IGI',_utf8mb4'IEP',_utf8mb4'HTP',_utf8mb4'HDA',_utf8mb4'HMP',_utf8mb4'HGI',_utf8mb4'HEP',_utf8mb4'IBA',_utf8mb4'IBD',_utf8mb4'IKR',_utf8mb4'IRD',_utf8mb4'ISS',_utf8mb4'ISO',_utf8mb4'ISA',_utf8mb4'ISM',_utf8mb4'IGC',_utf8mb4'RCA',_utf8mb4'TAS',_utf8mb4'NAS',_utf8mb4'IC',_utf8mb4'ND',_utf8mb4'IEA'))),
  CONSTRAINT `GENEANN_UPDATE_CHECK` CHECK ((`date_last_update` >= `date_created`))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_ANNOTATION`
--

LOCK TABLES `GENE_ANNOTATION` WRITE;
/*!40000 ALTER TABLE `GENE_ANNOTATION` DISABLE KEYS */;
INSERT INTO `GENE_ANNOTATION` VALUES (1,1,'GO:0006915','IDA','2026-04-09 16:38:52','2026-04-09 16:38:52','TNF induces apoptosis via TNFR1 signaling'),(2,2,'GO:0007165','IDA','2026-04-09 16:38:52','2026-04-09 16:38:52','ACE catalyzes angiotensin I to II, which activates signaling'),(3,3,'GO:0009987','IDA','2026-04-09 16:38:52','2026-04-09 16:38:52','Rho protein mediates the termination of transcription in E. coli'),(5,8,'GO:0005634','EXP','2026-04-09 16:38:52','2026-04-09 16:56:58','FLC functions as a nuclear transcription factor that represses flowering by regulating the expression of key floral transition genes'),(6,9,'GO:0005737','IEA','2026-04-09 16:38:52','2026-04-09 16:38:52','PHYA is localized in the cytoplasm prior to being activated');
/*!40000 ALTER TABLE `GENE_ANNOTATION` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_gene_annotation_update` BEFORE UPDATE ON `gene_annotation` FOR EACH ROW BEGIN
	SET NEW.date_last_update = NOW();
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_gene_annotation_delete` AFTER DELETE ON `gene_annotation` FOR EACH ROW BEGIN
	/* Checks if the deleted annotation's source_id is used anywhere else. If it isn't, then the source is removed */
    DELETE FROM SOURCE
    WHERE NOT EXISTS (
        SELECT 1
        FROM ANNOTATION_SOURCE a
        WHERE a.source_id = SOURCE.source_id
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `GENE_DISEASE`
--

DROP TABLE IF EXISTS `GENE_DISEASE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_DISEASE` (
  `disease_id` int NOT NULL AUTO_INCREMENT,
  `disease_name` varchar(150) NOT NULL,
  `category` varchar(15) NOT NULL,
  PRIMARY KEY (`disease_id`),
  UNIQUE KEY `GENEDISEASE_NAME_UNIQUE` (`disease_name`),
  CONSTRAINT `GENEDISEASE_CATEGORY_CHECK` CHECK ((`category` in (_utf8mb4'genetic',_utf8mb4'infectious',_utf8mb4'metabolic',_utf8mb4'cancer',_utf8mb4'cardiovascular',_utf8mb4'neurological',_utf8mb4'respiratory',_utf8mb4'autoimmune',_utf8mb4'other',_utf8mb4'unknown')))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_DISEASE`
--

LOCK TABLES `GENE_DISEASE` WRITE;
/*!40000 ALTER TABLE `GENE_DISEASE` DISABLE KEYS */;
INSERT INTO `GENE_DISEASE` VALUES (1,'li-fraumeni syndrome','genetic'),(2,'breast cancer','cancer'),(3,'lung cancer','cancer'),(4,'alzheimer\'s disease','neurological'),(5,'cardiovascular disease','cardiovascular'),(6,'rheumatoid arthritis','autoimmune'),(7,'crohn\'s disease','autoimmune'),(8,'psoriasis','autoimmune');
/*!40000 ALTER TABLE `GENE_DISEASE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_DISEASE_ASSOCIATION`
--

DROP TABLE IF EXISTS `GENE_DISEASE_ASSOCIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_DISEASE_ASSOCIATION` (
  `gene_id` int NOT NULL,
  `disease_id` int NOT NULL,
  PRIMARY KEY (`gene_id`,`disease_id`),
  KEY `GDA_GENEDISEASE_FK` (`disease_id`),
  CONSTRAINT `GDA_GENE_FK` FOREIGN KEY (`gene_id`) REFERENCES `GENE` (`gene_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GDA_GENEDISEASE_FK` FOREIGN KEY (`disease_id`) REFERENCES `GENE_DISEASE` (`disease_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_DISEASE_ASSOCIATION`
--

LOCK TABLES `GENE_DISEASE_ASSOCIATION` WRITE;
/*!40000 ALTER TABLE `GENE_DISEASE_ASSOCIATION` DISABLE KEYS */;
INSERT INTO `GENE_DISEASE_ASSOCIATION` VALUES (1,1),(1,2),(9,2),(24,2),(25,2),(1,3),(3,4),(3,5),(4,6),(4,7),(4,8);
/*!40000 ALTER TABLE `GENE_DISEASE_ASSOCIATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_FAMILY`
--

DROP TABLE IF EXISTS `GENE_FAMILY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_FAMILY` (
  `family_id` int NOT NULL AUTO_INCREMENT,
  `family_name` varchar(150) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `GENEFAMILY_NAME_UNIQUE` (`family_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_FAMILY`
--

LOCK TABLES `GENE_FAMILY` WRITE;
/*!40000 ALTER TABLE `GENE_FAMILY` DISABLE KEYS */;
INSERT INTO `GENE_FAMILY` VALUES (1,'p53 family',NULL),(2,'ErbB family',NULL),(3,'PDGF/VEGF growth factor family',NULL);
/*!40000 ALTER TABLE `GENE_FAMILY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_FAMILY_MEMBER`
--

DROP TABLE IF EXISTS `GENE_FAMILY_MEMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_FAMILY_MEMBER` (
  `gene_id` int NOT NULL,
  `family_id` int NOT NULL,
  PRIMARY KEY (`gene_id`,`family_id`),
  KEY `GFM_FAMILY_FK` (`family_id`),
  CONSTRAINT `GFM_FAMILY_FK` FOREIGN KEY (`family_id`) REFERENCES `GENE_FAMILY` (`family_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GFM_GENE_FK` FOREIGN KEY (`gene_id`) REFERENCES `GENE` (`gene_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_FAMILY_MEMBER`
--

LOCK TABLES `GENE_FAMILY_MEMBER` WRITE;
/*!40000 ALTER TABLE `GENE_FAMILY_MEMBER` DISABLE KEYS */;
INSERT INTO `GENE_FAMILY_MEMBER` VALUES (1,1),(26,1),(27,1),(28,1),(29,1),(2,2),(6,3);
/*!40000 ALTER TABLE `GENE_FAMILY_MEMBER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_PATHWAY`
--

DROP TABLE IF EXISTS `GENE_PATHWAY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_PATHWAY` (
  `pathway_id` int NOT NULL AUTO_INCREMENT,
  `pathway_name` varchar(150) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`pathway_id`),
  UNIQUE KEY `GENEPATH_NAME_UNIQUE` (`pathway_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_PATHWAY`
--

LOCK TABLES `GENE_PATHWAY` WRITE;
/*!40000 ALTER TABLE `GENE_PATHWAY` DISABLE KEYS */;
INSERT INTO `GENE_PATHWAY` VALUES (1,'cell cycle pathway',NULL),(2,'apoptosis pathway',NULL),(3,'MAPK signaling pathway',NULL);
/*!40000 ALTER TABLE `GENE_PATHWAY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_PATHWAY_ASSOCIATION`
--

DROP TABLE IF EXISTS `GENE_PATHWAY_ASSOCIATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_PATHWAY_ASSOCIATION` (
  `gene_id` int NOT NULL,
  `pathway_id` int NOT NULL,
  PRIMARY KEY (`gene_id`,`pathway_id`),
  KEY `GPA_PATHWAY_FK` (`pathway_id`),
  CONSTRAINT `GPA_GENE_FK` FOREIGN KEY (`gene_id`) REFERENCES `GENE` (`gene_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GPA_PATHWAY_FK` FOREIGN KEY (`pathway_id`) REFERENCES `GENE_PATHWAY` (`pathway_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_PATHWAY_ASSOCIATION`
--

LOCK TABLES `GENE_PATHWAY_ASSOCIATION` WRITE;
/*!40000 ALTER TABLE `GENE_PATHWAY_ASSOCIATION` DISABLE KEYS */;
INSERT INTO `GENE_PATHWAY_ASSOCIATION` VALUES (1,1),(9,1),(1,2),(4,2),(7,2),(11,2),(1,3),(4,3),(5,3),(6,3),(7,3),(11,3);
/*!40000 ALTER TABLE `GENE_PATHWAY_ASSOCIATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GENE_PRODUCT`
--

DROP TABLE IF EXISTS `GENE_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GENE_PRODUCT` (
  `gene_product_id` int NOT NULL AUTO_INCREMENT,
  `gene_id` int NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_type` varchar(7) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`gene_product_id`),
  KEY `GENEPRO_GENE_FK` (`gene_id`),
  CONSTRAINT `GENEPRO_GENE_FK` FOREIGN KEY (`gene_id`) REFERENCES `GENE` (`gene_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GENEPRO_PROTYPE_CHECK` CHECK ((`product_type` in (_utf8mb4'dna',_utf8mb4'rna',_utf8mb4'protein',_utf8mb4'other')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GENE_PRODUCT`
--

LOCK TABLES `GENE_PRODUCT` WRITE;
/*!40000 ALTER TABLE `GENE_PRODUCT` DISABLE KEYS */;
INSERT INTO `GENE_PRODUCT` VALUES (1,4,'tumor necrosis factor','protein','cytokine'),(2,10,'ACE protein','protein','angiotensin I converting enzyme'),(3,20,'Rho protein','protein','transcription termination factor'),(4,9,'BRCA1 protein','protein','nuclear phosphoprotein'),(5,24,'BRCA2 protein','protein','nuclear DNA repair protein'),(6,25,'PALB2 protein','protein','partner and localizer of BRCA2 protein'),(7,15,'phytochrome B','protein','a plant photoreceptor that forms a photobody'),(8,16,'FLC protein','protein','a MADS-box transcription factor that represses floral transition and contributes to temperature compensation of the circadian clock'),(9,17,'phytochrome A','protein','a photoreceptor responsible for sensing far-red light');
/*!40000 ALTER TABLE `GENE_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GO_TERM`
--

DROP TABLE IF EXISTS `GO_TERM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GO_TERM` (
  `go_id` varchar(15) NOT NULL,
  `term_name` varchar(200) NOT NULL,
  `ontology` varchar(2) NOT NULL,
  `definition` varchar(500) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_update` datetime NOT NULL,
  PRIMARY KEY (`go_id`),
  UNIQUE KEY `GOTERM_NAME_UNIQUE` (`term_name`),
  CONSTRAINT `GOTERM_ID_CHECK` CHECK (regexp_like(`go_id`,_utf8mb4'^GO:[0-9]{7}$')),
  CONSTRAINT `GOTERM_ONTOLOGY_CHECK` CHECK ((`ontology` in (_utf8mb4'cc',_utf8mb4'mf',_utf8mb4'bp'))),
  CONSTRAINT `GOTERM_UPDATE_CHECK` CHECK ((`date_last_update` >= `date_created`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GO_TERM`
--

LOCK TABLES `GO_TERM` WRITE;
/*!40000 ALTER TABLE `GO_TERM` DISABLE KEYS */;
INSERT INTO `GO_TERM` VALUES ('GO:0005634','nucleus','cc','A membrane bound organelle in eukaryotic cells that contains all of the cell\'s chromosomes','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0005737','cytoplasm','cc','The fluid-like substance that fills the interior of the cell','2026-04-09 16:38:52','2026-04-09 16:42:38'),('GO:0006915','apoptotic process','bp','The process of programmed cell death that occurs when a cell receives an internal or external signal, and proceeds through a sequence of biochemical events which trigger an execution event.','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0007154','cell communication','bp','Any process by which a cell gives and receive interactions between another cell or its surroundings','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0007165','signal transduction','bp','The cellular process where a signal is transmitted from a receptor to elicit a cellular response.','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0007267','cell-cell signaling','bp','Any process that mediates the transfer of information between cells','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0008283','cell proliferation','bp','The process by which cells grow and divide to create more cells.','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0009987','cellular process','bp','Any process that is carried out at the cellular level.','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0010647','positive regulation of cell communication','bp','A process that increases the rate of cell communication','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0012501','programmed cell death','bp','A highly regulated process of cellular self-destruction.','2026-04-09 16:38:52','2026-04-09 16:38:52'),('GO:0035426','extracellular matrix-cell signaling','bp','Any process that mediates the transfer of information between a cell and the extracellular matrix','2026-04-09 16:38:52','2026-04-09 16:38:52');
/*!40000 ALTER TABLE `GO_TERM` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_go_term_update` BEFORE UPDATE ON `go_term` FOR EACH ROW BEGIN
	SET NEW.date_last_update = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `GO_TERM_RELATION`
--

DROP TABLE IF EXISTS `GO_TERM_RELATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GO_TERM_RELATION` (
  `go_relation_id` int NOT NULL AUTO_INCREMENT,
  `parent_go_id` varchar(15) NOT NULL,
  `child_go_id` varchar(15) NOT NULL,
  `relation_term` varchar(9) NOT NULL,
  PRIMARY KEY (`go_relation_id`),
  KEY `GTR_PARENT_FK` (`parent_go_id`),
  KEY `GTR_CHILD_FK` (`child_go_id`),
  CONSTRAINT `GTR_CHILD_FK` FOREIGN KEY (`child_go_id`) REFERENCES `GO_TERM` (`go_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GTR_PARENT_FK` FOREIGN KEY (`parent_go_id`) REFERENCES `GO_TERM` (`go_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `GTR_TERM_CHECK` CHECK ((`relation_term` in (_utf8mb4'is a',_utf8mb4'part of',_utf8mb4'has part',_utf8mb4'regulates',_utf8mb4'occurs in')))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GO_TERM_RELATION`
--

LOCK TABLES `GO_TERM_RELATION` WRITE;
/*!40000 ALTER TABLE `GO_TERM_RELATION` DISABLE KEYS */;
INSERT INTO `GO_TERM_RELATION` VALUES (1,'GO:0009987','GO:0007165','is a'),(2,'GO:0009987','GO:0008283','is a'),(3,'GO:0012501','GO:0006915','is a'),(4,'GO:0007154','GO:0007165','part of'),(5,'GO:0007154','GO:0007267','is a'),(6,'GO:0007154','GO:0035426','is a'),(7,'GO:0007154','GO:0010647','regulates');
/*!40000 ALTER TABLE `GO_TERM_RELATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORGANISM`
--

DROP TABLE IF EXISTS `ORGANISM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORGANISM` (
  `organism_id` int NOT NULL AUTO_INCREMENT,
  `scientific_name` varchar(100) NOT NULL,
  `domain` varchar(8) NOT NULL,
  `genome_size` bigint DEFAULT NULL,
  `chromosome_count` int DEFAULT NULL,
  `taxonomy_id` int DEFAULT NULL,
  PRIMARY KEY (`organism_id`),
  UNIQUE KEY `ORG_SCI_UNIQUE` (`scientific_name`),
  CONSTRAINT `ORG_DOMAIN_CHECK` CHECK ((`domain` in (_utf8mb4'bacteria',_utf8mb4'archaea',_utf8mb4'eukarya')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORGANISM`
--

LOCK TABLES `ORGANISM` WRITE;
/*!40000 ALTER TABLE `ORGANISM` DISABLE KEYS */;
INSERT INTO `ORGANISM` VALUES (1,'Homo sapiens','eukarya',3200000000,46,9606),(2,'Drosophila melanogaster','eukarya',140000000,8,7227),(3,'Arabidopsis thaliana','eukarya',135000000,10,3702),(4,'Escherichia coli','bacteria',4600000,1,562),(5,'Caenorhabditis elegans','eukarya',100000000,12,6239),(6,'Mus musculus','eukarya',2700000000,20,10090);
/*!40000 ALTER TABLE `ORGANISM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SOURCE`
--

DROP TABLE IF EXISTS `SOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SOURCE` (
  `source_id` int NOT NULL AUTO_INCREMENT,
  `source_name` varchar(150) NOT NULL,
  `publish_year` year NOT NULL,
  `url` varchar(2048) NOT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SOURCE`
--

LOCK TABLES `SOURCE` WRITE;
/*!40000 ALTER TABLE `SOURCE` DISABLE KEYS */;
INSERT INTO `SOURCE` VALUES (1,'Reactive Oxygen Species in TNFα-Induced Signaling and Cell Death',2010,'https://www.sciencedirect.com/science/article/pii/S1016847823109988'),(2,'Physiology, Renin Angiotensin System',2026,'https://www.ncbi.nlm.nih.gov/books/NBK470410/'),(3,'Regulation of Rho-Dependent Transcription Termination by NusG Is Specific to the Escherichia coli Elongation Complex',2000,'https://pubs.acs.org/doi/10.1021/bi992658z'),(5,'Light-Regulated Nuclear Import and Degradation of Arabidopsis Phytochrome-A N-Terminal Fragments',2010,'https://pmc.ncbi.nlm.nih.gov/articles/PMC3037077/'),(6,'UniProt',2024,'https://www.uniprot.org/uniprotkb/Q9S7Z8/entry');
/*!40000 ALTER TABLE `SOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'IGKD'
--

--
-- Dumping routines for database 'IGKD'
--
/*!50003 DROP FUNCTION IF EXISTS `count_genes_organism` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `count_genes_organism`(
    scientificName VARCHAR(100)
) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE organismID INT;
    DECLARE result INT;

    SELECT organism_id
    INTO organismID
    FROM ORGANISM o
    WHERE o.scientific_name = scientificName
    LIMIT 1;

    IF organismID IS NULL THEN
        RETURN -1;
    END IF;

    SELECT COUNT(*)
    INTO result
    FROM GENE g
    WHERE g.organism_id = organismID;

    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `gene_annotation_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `gene_annotation_count`(
	geneSymbol VARCHAR(20),
	scientificName VARCHAR(100)
) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE geneID INT;
	DECLARE result INT;
    
    SELECT g.gene_id
    INTO geneID
    FROM GENE g
    JOIN ORGANISM o
		ON o.organism_id = g.organism_id
	WHERE g.gene_symbol = geneSymbol
		AND o.scientific_name = scientificName
	LIMIT 1;
    
    IF geneID IS NULL THEN
        RETURN -1;
    END IF;
    
    SELECT COUNT(*)
    INTO result
	FROM GENE_PRODUCT gp
	JOIN GENE_ANNOTATION ga
		ON gp.gene_product_id = ga.gene_product_id
	WHERE gp.gene_id = geneID;
	RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `gene_organism_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `gene_organism_count`(
    scientificName VARCHAR(100)
) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE organismID INT;
    DECLARE result INT;

    SELECT organism_id
    INTO organismID
    FROM ORGANISM o
    WHERE o.scientific_name = scientificName
    LIMIT 1;

    IF organismID IS NULL THEN
        RETURN -1;
    END IF;

    SELECT COUNT(*)
    INTO result
    FROM GENE g
    WHERE g.organism_id = organismID;

    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `retrieve_gene_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `retrieve_gene_id`(
	geneSymbol VARCHAR(20),
	scientificName VARCHAR(100)
) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE result INT;
    SELECT g.gene_id
	INTO result
    FROM GENE g
    JOIN ORGANISM o
		ON o.organism_id = g.organism_id
	WHERE g.gene_symbol = geneSymbol
		AND o.scientific_name = scientificName
	LIMIT 1;
    RETURN IFNULL(result, -1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `retrieve_gene_product_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `retrieve_gene_product_id`(
	gene_symbol1 VARCHAR(20),
	scientific_name1 VARCHAR(100),
    product_name1 VARCHAR(100)
) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE result INT;
    SELECT gp.gene_product_id
	INTO result
    FROM GENE_PRODUCT gp
    JOIN GENE g
		ON g.gene_id = gp.gene_id
	JOIN ORGANISM o
		ON g.organism_id = o.organism_id
	WHERE g.gene_symbol = gene_symbol1 
		AND o.scientific_name = scientific_name1
        AND gp.product_name = product_name1
	LIMIT 1;
    RETURN IFNULL(result, -1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_additional_source` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_additional_source`(
	/* Name of inputs */
	IN annotation_id1 INT,
    IN source_name1 VARCHAR(150),
    IN publish_year1 YEAR,
    IN url1 VARCHAR(2048)
    )
BEGIN
DECLARE use_source_id INT;
/* First, we check to see if the gene annotation exists. If it does, we know it already has one source. */
IF NOT EXISTS (
	SELECT 1
    FROM GENE_ANNOTATION ga
    WHERE ga.annotation_id = annotation_id1
) THEN 
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Gene annotation does not exist';
END IF;
/* Now, we insert the additional source */
INSERT INTO SOURCE (source_name, publish_year, url)
VALUES (source_name1, publish_year1, url1);
SET use_source_id = LAST_INSERT_ID();
/* We insert the annotation_id and source_id into the associative table linking the two entities */
INSERT INTO ANNOTATION_SOURCE (source_id, annotation_id)
VALUES (use_source_id, annotation_id1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_annotation_with_source` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_annotation_with_source`(
	/* Name of inputs */
	IN go_id1 VARCHAR(15),
	IN gene_product_id1 INT,
	IN evidence_code1 VARCHAR(3),
    IN source_name1 VARCHAR(150),
    IN publish_year1 YEAR,
    IN url1 VARCHAR(2048))
BEGIN
DECLARE use_source_id INT;
DECLARE use_annotation_id INT;
/* Check if the gene product exists */
	IF NOT EXISTS (
		SELECT 1 
		FROM GENE_PRODUCT gp
		WHERE gp.gene_product_id = gene_product_id1
	) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Gene product does not exists';
	END IF;
/* Check if the gene ontology term exists */
	IF NOT EXISTS (
    SELECT 1
    FROM GO_TERM gt
    WHERE gt.go_id = go_id1
    ) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gene ontology term does not exist';
	END IF;
/* We insert the source first then store the source_id */
INSERT INTO SOURCE (source_name, publish_year, url)
VALUES (source_name1, publish_year1, url1);
SET use_source_id = LAST_INSERT_ID();
/*We insert the gene annotation*/
INSERT INTO GENE_ANNOTATION (gene_product_id, go_id, evidence_code, date_created, date_last_update)
VALUES (gene_product_id1, go_id1, evidence_code1, NOW(), NOW());
SET use_annotation_id = LAST_INSERT_ID();
/* We insert the annotation_id and source_id into the associative table linking the two entities */
INSERT INTO ANNOTATION_SOURCE (source_id, annotation_id)
VALUES (use_source_id, use_annotation_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_gene_for_organism` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_gene_for_organism`(
	/* Name of inputs */
    IN organism_id1 INT,
	IN gene_symbol1 VARCHAR(20),
    IN chromosome1 VARCHAR(20),
    IN start_position1 INT,
    IN end_position1 INT,
    IN strand1 CHAR(1)
    )
BEGIN
/* First, we check to see if the organism exists */
IF NOT EXISTS (
	SELECT 1 
    FROM ORGANISM o
    WHERE o.organism_id = organism_id1
) THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Organism does not exist';
END IF;
/* Second, we check to see if the gene already exists */
IF EXISTS (
	SELECT 1 
    FROM GENE g
    WHERE g.gene_symbol = gene_symbol1 
		AND g.organism_id = organism_id1
) THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Gene already exists for this organism';
END IF;
/* Now, we insert the gene */
INSERT INTO GENE (gene_symbol, chromosome, start_position, end_position, strand, organism_id)
VALUES (gene_symbol1, chromosome1, start_position1, end_position1, strand1, organism_id1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_gene_product_for_gene` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_gene_product_for_gene`(
	/* Name of inputs */
    IN gene_id1 INT,
    IN product_name1 VARCHAR(100),
	IN product_type1 VARCHAR(7)
    )
BEGIN
/* First, we check to see if the gene_id exists */
IF NOT EXISTS (
	SELECT 1 
    FROM GENE g
    WHERE g.gene_id = gene_id1
) THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Gene does not exist';
END IF;
/* Second, we check to see if the gene_product_id already exists for the given gene */
IF EXISTS (
	SELECT 1 
    FROM GENE_PRODUCT gp
    WHERE gp.product_name = product_name1 
		AND gp.gene_id = gene_id1
) THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Gene product already exists';
END IF;
/* Now, we insert the gene product */
INSERT INTO GENE_PRODUCT (product_name, product_type, gene_id)
VALUES (product_name1, product_type1, gene_id1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_go_term` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_go_term`(
	/* Name of inputs */
    IN go_id1 VARCHAR(15),
	IN term_name1 VARCHAR(200),
    IN ontology1 VARCHAR(2),
    IN definition1 VARCHAR(500)
    )
BEGIN
/* First, we check to see if the go_id already exists */
IF EXISTS (
	SELECT 1 
    FROM GO_TERM gt
    WHERE gt.go_id = go_id1
) THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Gene ontology term already exists';
END IF;
/* Now, we insert the go term */
INSERT INTO GO_TERM (go_id, term_name, ontology, definition, date_created, date_last_update)
VALUES (go_id1, term_name1, ontology1, definition1, NOW(), NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-11 17:20:28
