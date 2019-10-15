-- MySQL dump 10.17  Distrib 10.3.17-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: SS_html
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `SS_html`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `SS_html` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `SS_html`;

--
-- Table structure for table `ChangeSet`
--

DROP TABLE IF EXISTS `ChangeSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChangeSet` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Versioned\\ChangeSet') DEFAULT 'SilverStripe\\Versioned\\ChangeSet',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `State` enum('open','published','reverted') DEFAULT 'open',
  `IsInferred` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Description` mediumtext,
  `PublishDate` datetime DEFAULT NULL,
  `LastSynced` datetime DEFAULT NULL,
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `State` (`State`),
  KEY `ID` (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `OwnerID` (`OwnerID`),
  KEY `PublisherID` (`PublisherID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChangeSet`
--

LOCK TABLES `ChangeSet` WRITE;
/*!40000 ALTER TABLE `ChangeSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `ChangeSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ChangeSetItem`
--

DROP TABLE IF EXISTS `ChangeSetItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChangeSetItem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Versioned\\ChangeSetItem') DEFAULT 'SilverStripe\\Versioned\\ChangeSetItem',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `VersionBefore` int(11) NOT NULL DEFAULT '0',
  `VersionAfter` int(11) NOT NULL DEFAULT '0',
  `Added` enum('explicitly','implicitly') DEFAULT 'implicitly',
  `ChangeSetID` int(11) NOT NULL DEFAULT '0',
  `ObjectID` int(11) NOT NULL DEFAULT '0',
  `ObjectClass` enum('SilverStripe\\Assets\\File','SilverStripe\\SiteConfig\\SiteConfig','SilverStripe\\Versioned\\ChangeSet','SilverStripe\\Versioned\\ChangeSetItem','SilverStripe\\Assets\\Shortcodes\\FileLink','SilverStripe\\CMS\\Model\\SiteTree','SilverStripe\\CMS\\Model\\SiteTreeLink','SilverStripe\\Security\\Group','SilverStripe\\Security\\LoginAttempt','SilverStripe\\Security\\Member','SilverStripe\\Security\\MemberPassword','SilverStripe\\Security\\Permission','SilverStripe\\Security\\PermissionRole','SilverStripe\\Security\\PermissionRoleCode','SilverStripe\\Security\\RememberLoginHash','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'SilverStripe\\Assets\\File',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ObjectUniquePerChangeSet` (`ObjectID`,`ObjectClass`,`ChangeSetID`),
  KEY `ClassName` (`ClassName`),
  KEY `ChangeSetID` (`ChangeSetID`),
  KEY `Object` (`ObjectID`,`ObjectClass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChangeSetItem`
--

LOCK TABLES `ChangeSetItem` WRITE;
/*!40000 ALTER TABLE `ChangeSetItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `ChangeSetItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ChangeSetItem_ReferencedBy`
--

DROP TABLE IF EXISTS `ChangeSetItem_ReferencedBy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChangeSetItem_ReferencedBy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ChangeSetItemID` int(11) NOT NULL DEFAULT '0',
  `ChildID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ChangeSetItemID` (`ChangeSetItemID`),
  KEY `ChildID` (`ChildID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChangeSetItem_ReferencedBy`
--

LOCK TABLES `ChangeSetItem_ReferencedBy` WRITE;
/*!40000 ALTER TABLE `ChangeSetItem_ReferencedBy` DISABLE KEYS */;
/*!40000 ALTER TABLE `ChangeSetItem_ReferencedBy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage`
--

DROP TABLE IF EXISTS `ErrorPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage`
--

LOCK TABLES `ErrorPage` WRITE;
/*!40000 ALTER TABLE `ErrorPage` DISABLE KEYS */;
INSERT INTO `ErrorPage` VALUES (4,404),(5,500);
/*!40000 ALTER TABLE `ErrorPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage_Live`
--

DROP TABLE IF EXISTS `ErrorPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage_Live`
--

LOCK TABLES `ErrorPage_Live` WRITE;
/*!40000 ALTER TABLE `ErrorPage_Live` DISABLE KEYS */;
INSERT INTO `ErrorPage_Live` VALUES (4,404),(5,500);
/*!40000 ALTER TABLE `ErrorPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage_Versions`
--

DROP TABLE IF EXISTS `ErrorPage_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage_Versions`
--

LOCK TABLES `ErrorPage_Versions` WRITE;
/*!40000 ALTER TABLE `ErrorPage_Versions` DISABLE KEYS */;
INSERT INTO `ErrorPage_Versions` VALUES (1,4,1,404),(2,4,2,404),(3,5,1,500),(4,5,2,500);
/*!40000 ALTER TABLE `ErrorPage_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Assets\\File','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image') DEFAULT 'SilverStripe\\Assets\\File',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  `FileHash` varchar(255) DEFAULT NULL,
  `FileFilename` varchar(255) DEFAULT NULL,
  `FileVariant` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Name` (`Name`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `OwnerID` (`OwnerID`),
  KEY `FileHash` (`FileHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FileLink`
--

DROP TABLE IF EXISTS `FileLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FileLink` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Assets\\Shortcodes\\FileLink') DEFAULT 'SilverStripe\\Assets\\Shortcodes\\FileLink',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `LinkedID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `ParentClass` enum('SilverStripe\\Assets\\File','SilverStripe\\SiteConfig\\SiteConfig','SilverStripe\\Versioned\\ChangeSet','SilverStripe\\Versioned\\ChangeSetItem','SilverStripe\\Assets\\Shortcodes\\FileLink','SilverStripe\\CMS\\Model\\SiteTree','SilverStripe\\CMS\\Model\\SiteTreeLink','SilverStripe\\Security\\Group','SilverStripe\\Security\\LoginAttempt','SilverStripe\\Security\\Member','SilverStripe\\Security\\MemberPassword','SilverStripe\\Security\\Permission','SilverStripe\\Security\\PermissionRole','SilverStripe\\Security\\PermissionRoleCode','SilverStripe\\Security\\RememberLoginHash','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'SilverStripe\\Assets\\File',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `LinkedID` (`LinkedID`),
  KEY `Parent` (`ParentID`,`ParentClass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FileLink`
--

LOCK TABLES `FileLink` WRITE;
/*!40000 ALTER TABLE `FileLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `FileLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_EditorGroups`
--

DROP TABLE IF EXISTS `File_EditorGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_EditorGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FileID` (`FileID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_EditorGroups`
--

LOCK TABLES `File_EditorGroups` WRITE;
/*!40000 ALTER TABLE `File_EditorGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `File_EditorGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_Live`
--

DROP TABLE IF EXISTS `File_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Assets\\File','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image') DEFAULT 'SilverStripe\\Assets\\File',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  `FileHash` varchar(255) DEFAULT NULL,
  `FileFilename` varchar(255) DEFAULT NULL,
  `FileVariant` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Name` (`Name`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `OwnerID` (`OwnerID`),
  KEY `FileHash` (`FileHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_Live`
--

LOCK TABLES `File_Live` WRITE;
/*!40000 ALTER TABLE `File_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `File_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_Versions`
--

DROP TABLE IF EXISTS `File_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `WasPublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `WasDeleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `WasDraft` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `AuthorID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  `ClassName` enum('SilverStripe\\Assets\\File','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image') DEFAULT 'SilverStripe\\Assets\\File',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  `FileHash` varchar(255) DEFAULT NULL,
  `FileFilename` varchar(255) DEFAULT NULL,
  `FileVariant` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AuthorID` (`AuthorID`),
  KEY `PublisherID` (`PublisherID`),
  KEY `Name` (`Name`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `OwnerID` (`OwnerID`),
  KEY `FileHash` (`FileHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_Versions`
--

LOCK TABLES `File_Versions` WRITE;
/*!40000 ALTER TABLE `File_Versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `File_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File_ViewerGroups`
--

DROP TABLE IF EXISTS `File_ViewerGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File_ViewerGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FileID` (`FileID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File_ViewerGroups`
--

LOCK TABLES `File_ViewerGroups` WRITE;
/*!40000 ALTER TABLE `File_ViewerGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `File_ViewerGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group`
--

DROP TABLE IF EXISTS `Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\Group') DEFAULT 'SilverStripe\\Security\\Group',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Description` mediumtext,
  `Code` varchar(255) DEFAULT NULL,
  `Locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HtmlEditorConfig` mediumtext,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group`
--

LOCK TABLES `Group` WRITE;
/*!40000 ALTER TABLE `Group` DISABLE KEYS */;
INSERT INTO `Group` VALUES (1,'SilverStripe\\Security\\Group','2019-10-16 05:15:47','2019-10-16 05:15:47','Content Authors',NULL,'content-authors',0,1,NULL,0),(2,'SilverStripe\\Security\\Group','2019-10-16 05:15:48','2019-10-16 05:15:48','Administrators',NULL,'administrators',0,0,NULL,0);
/*!40000 ALTER TABLE `Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_Members`
--

DROP TABLE IF EXISTS `Group_Members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_Members` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `GroupID` (`GroupID`),
  KEY `MemberID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_Members`
--

LOCK TABLES `Group_Members` WRITE;
/*!40000 ALTER TABLE `Group_Members` DISABLE KEYS */;
INSERT INTO `Group_Members` VALUES (1,2,1);
/*!40000 ALTER TABLE `Group_Members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_Roles`
--

DROP TABLE IF EXISTS `Group_Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_Roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  `PermissionRoleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `GroupID` (`GroupID`),
  KEY `PermissionRoleID` (`PermissionRoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_Roles`
--

LOCK TABLES `Group_Roles` WRITE;
/*!40000 ALTER TABLE `Group_Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginAttempt`
--

DROP TABLE IF EXISTS `LoginAttempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoginAttempt` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\LoginAttempt') DEFAULT 'SilverStripe\\Security\\LoginAttempt',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `EmailHashed` varchar(255) DEFAULT NULL,
  `Status` enum('Success','Failure') DEFAULT 'Success',
  `IP` varchar(255) DEFAULT NULL,
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `MemberID` (`MemberID`),
  KEY `EmailHashed` (`EmailHashed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginAttempt`
--

LOCK TABLES `LoginAttempt` WRITE;
/*!40000 ALTER TABLE `LoginAttempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginAttempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Member` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\Member') DEFAULT 'SilverStripe\\Security\\Member',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `Surname` varchar(255) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  `TempIDHash` varchar(160) DEFAULT NULL,
  `TempIDExpired` datetime DEFAULT NULL,
  `Password` varchar(160) DEFAULT NULL,
  `AutoLoginHash` varchar(160) DEFAULT NULL,
  `AutoLoginExpired` datetime DEFAULT NULL,
  `PasswordEncryption` varchar(50) DEFAULT NULL,
  `Salt` varchar(50) DEFAULT NULL,
  `PasswordExpiry` date DEFAULT NULL,
  `LockedOutUntil` datetime DEFAULT NULL,
  `Locale` varchar(6) DEFAULT NULL,
  `FailedLoginCount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Surname` (`Surname`),
  KEY `FirstName` (`FirstName`),
  KEY `ClassName` (`ClassName`),
  KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
INSERT INTO `Member` VALUES (1,'SilverStripe\\Security\\Member','2019-10-16 05:15:48','2019-10-16 05:15:48','Default Admin',NULL,'root',NULL,NULL,NULL,NULL,NULL,'none',NULL,NULL,NULL,'en_US',0);
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MemberPassword`
--

DROP TABLE IF EXISTS `MemberPassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MemberPassword` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\MemberPassword') DEFAULT 'SilverStripe\\Security\\MemberPassword',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Password` varchar(160) DEFAULT NULL,
  `Salt` varchar(50) DEFAULT NULL,
  `PasswordEncryption` varchar(50) DEFAULT NULL,
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `MemberID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MemberPassword`
--

LOCK TABLES `MemberPassword` WRITE;
/*!40000 ALTER TABLE `MemberPassword` DISABLE KEYS */;
INSERT INTO `MemberPassword` VALUES (1,'SilverStripe\\Security\\MemberPassword','2019-10-16 05:15:48','2019-10-16 05:15:48',NULL,NULL,'none',1);
/*!40000 ALTER TABLE `MemberPassword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permission`
--

DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Permission` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\Permission') DEFAULT 'SilverStripe\\Security\\Permission',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Arg` int(11) NOT NULL DEFAULT '0',
  `Type` int(11) NOT NULL DEFAULT '1',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `GroupID` (`GroupID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permission`
--

LOCK TABLES `Permission` WRITE;
/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` VALUES (1,'SilverStripe\\Security\\Permission','2019-10-16 05:15:47','2019-10-16 05:15:47','CMS_ACCESS_CMSMain',0,1,1),(2,'SilverStripe\\Security\\Permission','2019-10-16 05:15:48','2019-10-16 05:15:48','CMS_ACCESS_AssetAdmin',0,1,1),(3,'SilverStripe\\Security\\Permission','2019-10-16 05:15:48','2019-10-16 05:15:48','CMS_ACCESS_ReportAdmin',0,1,1),(4,'SilverStripe\\Security\\Permission','2019-10-16 05:15:48','2019-10-16 05:15:48','SITETREE_REORGANISE',0,1,1),(5,'SilverStripe\\Security\\Permission','2019-10-16 05:15:48','2019-10-16 05:15:48','ADMIN',0,1,2);
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PermissionRole`
--

DROP TABLE IF EXISTS `PermissionRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PermissionRole` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\PermissionRole') DEFAULT 'SilverStripe\\Security\\PermissionRole',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `OnlyAdminCanApply` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Title` (`Title`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PermissionRole`
--

LOCK TABLES `PermissionRole` WRITE;
/*!40000 ALTER TABLE `PermissionRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `PermissionRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PermissionRoleCode`
--

DROP TABLE IF EXISTS `PermissionRoleCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PermissionRoleCode` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\PermissionRoleCode') DEFAULT 'SilverStripe\\Security\\PermissionRoleCode',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `RoleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `RoleID` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PermissionRoleCode`
--

LOCK TABLES `PermissionRoleCode` WRITE;
/*!40000 ALTER TABLE `PermissionRoleCode` DISABLE KEYS */;
/*!40000 ALTER TABLE `PermissionRoleCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage`
--

DROP TABLE IF EXISTS `RedirectorPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage`
--

LOCK TABLES `RedirectorPage` WRITE;
/*!40000 ALTER TABLE `RedirectorPage` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage_Live`
--

DROP TABLE IF EXISTS `RedirectorPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage_Live`
--

LOCK TABLES `RedirectorPage_Live` WRITE;
/*!40000 ALTER TABLE `RedirectorPage_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage_Versions`
--

DROP TABLE IF EXISTS `RedirectorPage_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage_Versions`
--

LOCK TABLES `RedirectorPage_Versions` WRITE;
/*!40000 ALTER TABLE `RedirectorPage_Versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RememberLoginHash`
--

DROP TABLE IF EXISTS `RememberLoginHash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RememberLoginHash` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\Security\\RememberLoginHash') DEFAULT 'SilverStripe\\Security\\RememberLoginHash',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `DeviceID` varchar(40) DEFAULT NULL,
  `Hash` varchar(160) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `MemberID` (`MemberID`),
  KEY `DeviceID` (`DeviceID`),
  KEY `Hash` (`Hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RememberLoginHash`
--

LOCK TABLES `RememberLoginHash` WRITE;
/*!40000 ALTER TABLE `RememberLoginHash` DISABLE KEYS */;
/*!40000 ALTER TABLE `RememberLoginHash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SilverStripe_Example_ArticlePage`
--

DROP TABLE IF EXISTS `SilverStripe_Example_ArticlePage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SilverStripe_Example_ArticlePage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `Teaser` mediumtext,
  `ArticleAuthor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SilverStripe_Example_ArticlePage`
--

LOCK TABLES `SilverStripe_Example_ArticlePage` WRITE;
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage` DISABLE KEYS */;
INSERT INTO `SilverStripe_Example_ArticlePage` VALUES (10,'1776-07-04','Teaser of sample article 1','Manuel Thalmann'),(11,'1840-02-06',NULL,'John Doe'),(12,'2000-08-01',NULL,'Jane Doe');
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SilverStripe_Example_ArticlePage_Live`
--

DROP TABLE IF EXISTS `SilverStripe_Example_ArticlePage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SilverStripe_Example_ArticlePage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `Teaser` mediumtext,
  `ArticleAuthor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SilverStripe_Example_ArticlePage_Live`
--

LOCK TABLES `SilverStripe_Example_ArticlePage_Live` WRITE;
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage_Live` DISABLE KEYS */;
INSERT INTO `SilverStripe_Example_ArticlePage_Live` VALUES (10,'1776-07-04','Teaser of sample article 1','Manuel Thalmann'),(11,'1840-02-06',NULL,'John Doe'),(12,'2000-08-01',NULL,'Jane Doe');
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SilverStripe_Example_ArticlePage_Versions`
--

DROP TABLE IF EXISTS `SilverStripe_Example_ArticlePage_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SilverStripe_Example_ArticlePage_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `Date` date DEFAULT NULL,
  `Teaser` mediumtext,
  `ArticleAuthor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SilverStripe_Example_ArticlePage_Versions`
--

LOCK TABLES `SilverStripe_Example_ArticlePage_Versions` WRITE;
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage_Versions` DISABLE KEYS */;
INSERT INTO `SilverStripe_Example_ArticlePage_Versions` VALUES (1,10,7,'1776-07-04','Teaser of sample article 1','Manuel Thalmann'),(2,11,7,'1840-02-06',NULL,'John Doe'),(3,12,7,'2000-08-01',NULL,'Jane Doe');
/*!40000 ALTER TABLE `SilverStripe_Example_ArticlePage_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig`
--

DROP TABLE IF EXISTS `SiteConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\SiteConfig\\SiteConfig') DEFAULT 'SilverStripe\\SiteConfig\\SiteConfig',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Tagline` varchar(255) DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers') DEFAULT 'Anyone',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers') DEFAULT 'LoggedInUsers',
  `CanCreateTopLevelType` enum('LoggedInUsers','OnlyTheseUsers') DEFAULT 'LoggedInUsers',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig`
--

LOCK TABLES `SiteConfig` WRITE;
/*!40000 ALTER TABLE `SiteConfig` DISABLE KEYS */;
INSERT INTO `SiteConfig` VALUES (1,'SilverStripe\\SiteConfig\\SiteConfig','2019-10-16 05:15:47','2019-10-16 05:15:47','Your Site Name','your tagline here','Anyone','LoggedInUsers','LoggedInUsers');
/*!40000 ALTER TABLE `SiteConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_CreateTopLevelGroups`
--

DROP TABLE IF EXISTS `SiteConfig_CreateTopLevelGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_CreateTopLevelGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_CreateTopLevelGroups`
--

LOCK TABLES `SiteConfig_CreateTopLevelGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_CreateTopLevelGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_CreateTopLevelGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_EditorGroups`
--

DROP TABLE IF EXISTS `SiteConfig_EditorGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_EditorGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_EditorGroups`
--

LOCK TABLES `SiteConfig_EditorGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_EditorGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_EditorGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_ViewerGroups`
--

DROP TABLE IF EXISTS `SiteConfig_ViewerGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_ViewerGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_ViewerGroups`
--

LOCK TABLES `SiteConfig_ViewerGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_ViewerGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_ViewerGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree`
--

DROP TABLE IF EXISTS `SiteTree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\CMS\\Model\\SiteTree','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'Page',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Version` int(11) NOT NULL DEFAULT '0',
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(255) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Sort` (`Sort`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree`
--

LOCK TABLES `SiteTree` WRITE;
/*!40000 ALTER TABLE `SiteTree` DISABLE KEYS */;
INSERT INTO `SiteTree` VALUES (1,'Page','2019-10-15 05:07:36','2019-10-15 05:07:36','Inherit','Inherit',2,'home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>.</p><p>You can now access the <a href=\"http://docs.silverstripe.org\">developer documentation</a>, or begin the <a href=\"http://www.silverstripe.org/learn/lessons\">SilverStripe lessons</a>.</p>',NULL,NULL,1,1,1,0,0,NULL,0),(2,'Page','2019-10-15 09:51:18','2019-10-15 05:07:36','Inherit','Inherit',4,'about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,6,0,0,NULL,0),(3,'Page','2019-10-15 09:52:33','2019-10-15 05:07:37','Inherit','Inherit',6,'contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,7,0,0,NULL,0),(4,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit',2,'page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,8,0,0,NULL,0),(5,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit',2,'server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,9,0,0,NULL,0),(6,'Page','2019-10-15 05:58:41','2019-10-15 05:51:22','Inherit','Inherit',5,'find-a-rental','Find a Rental',NULL,NULL,NULL,NULL,1,1,2,0,0,NULL,0),(7,'Page','2019-10-15 05:59:28','2019-10-15 05:53:30','Inherit','Inherit',5,'list-your-rental','List Your Rental',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,0),(8,'Page','2019-10-15 09:49:10','2019-10-15 05:55:16','Inherit','Inherit',5,'regions','Regions',NULL,NULL,NULL,NULL,1,1,4,0,0,NULL,0),(9,'SilverStripe\\Example\\ArticleHolder','2019-10-15 10:28:48','2019-10-15 06:00:25','Inherit','Inherit',7,'travel-guides','Travel Guides',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,0),(10,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:44:22','2019-10-15 09:58:45','Inherit','Inherit',7,'sample-article-1','Sample Article 1',NULL,'<p><span>This is sample article 1.</span></p>',NULL,NULL,1,1,1,0,0,NULL,9),(11,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:00','2019-10-15 10:01:16','Inherit','Inherit',7,'sample-article-2','Sample Article 2',NULL,'<p><span>This is sample article 2.</span></p>',NULL,NULL,1,1,2,0,0,NULL,9),(12,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:28','2019-10-15 10:05:04','Inherit','Inherit',7,'sample-article-3','Sample Article 3',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,9);
/*!40000 ALTER TABLE `SiteTree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTreeLink`
--

DROP TABLE IF EXISTS `SiteTreeLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTreeLink` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\CMS\\Model\\SiteTreeLink') DEFAULT 'SilverStripe\\CMS\\Model\\SiteTreeLink',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `LinkedID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `ParentClass` enum('SilverStripe\\Assets\\File','SilverStripe\\SiteConfig\\SiteConfig','SilverStripe\\Versioned\\ChangeSet','SilverStripe\\Versioned\\ChangeSetItem','SilverStripe\\Assets\\Shortcodes\\FileLink','SilverStripe\\CMS\\Model\\SiteTree','SilverStripe\\CMS\\Model\\SiteTreeLink','SilverStripe\\Security\\Group','SilverStripe\\Security\\LoginAttempt','SilverStripe\\Security\\Member','SilverStripe\\Security\\MemberPassword','SilverStripe\\Security\\Permission','SilverStripe\\Security\\PermissionRole','SilverStripe\\Security\\PermissionRoleCode','SilverStripe\\Security\\RememberLoginHash','SilverStripe\\Assets\\Folder','SilverStripe\\Assets\\Image','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'SilverStripe\\Assets\\File',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `LinkedID` (`LinkedID`),
  KEY `Parent` (`ParentID`,`ParentClass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTreeLink`
--

LOCK TABLES `SiteTreeLink` WRITE;
/*!40000 ALTER TABLE `SiteTreeLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTreeLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_EditorGroups`
--

DROP TABLE IF EXISTS `SiteTree_EditorGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_EditorGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_EditorGroups`
--

LOCK TABLES `SiteTree_EditorGroups` WRITE;
/*!40000 ALTER TABLE `SiteTree_EditorGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_EditorGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_Live`
--

DROP TABLE IF EXISTS `SiteTree_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SilverStripe\\CMS\\Model\\SiteTree','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'Page',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Version` int(11) NOT NULL DEFAULT '0',
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(255) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Sort` (`Sort`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_Live`
--

LOCK TABLES `SiteTree_Live` WRITE;
/*!40000 ALTER TABLE `SiteTree_Live` DISABLE KEYS */;
INSERT INTO `SiteTree_Live` VALUES (1,'Page','2019-10-15 05:07:36','2019-10-15 05:07:36','Inherit','Inherit',2,'home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>.</p><p>You can now access the <a href=\"http://docs.silverstripe.org\">developer documentation</a>, or begin the <a href=\"http://www.silverstripe.org/learn/lessons\">SilverStripe lessons</a>.</p>',NULL,NULL,1,1,1,0,0,NULL,0),(2,'Page','2019-10-15 09:51:18','2019-10-15 05:07:36','Inherit','Inherit',4,'about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,6,0,0,NULL,0),(3,'Page','2019-10-15 09:52:33','2019-10-15 05:07:37','Inherit','Inherit',6,'contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,7,0,0,NULL,0),(4,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit',2,'page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,8,0,0,NULL,0),(5,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit',2,'server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,9,0,0,NULL,0),(6,'Page','2019-10-15 05:58:41','2019-10-15 05:51:22','Inherit','Inherit',5,'find-a-rental','Find a Rental',NULL,NULL,NULL,NULL,1,1,2,0,0,NULL,0),(7,'Page','2019-10-15 05:59:28','2019-10-15 05:53:30','Inherit','Inherit',5,'list-your-rental','List Your Rental',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,0),(8,'Page','2019-10-15 09:49:10','2019-10-15 05:55:16','Inherit','Inherit',5,'regions','Regions',NULL,NULL,NULL,NULL,1,1,4,0,0,NULL,0),(9,'SilverStripe\\Example\\ArticleHolder','2019-10-15 10:28:48','2019-10-15 06:00:25','Inherit','Inherit',7,'travel-guides','Travel Guides',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,0),(10,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:44:22','2019-10-15 09:58:45','Inherit','Inherit',7,'sample-article-1','Sample Article 1',NULL,'<p><span>This is sample article 1.</span></p>',NULL,NULL,1,1,1,0,0,NULL,9),(11,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:00','2019-10-15 10:01:16','Inherit','Inherit',7,'sample-article-2','Sample Article 2',NULL,'<p><span>This is sample article 2.</span></p>',NULL,NULL,1,1,2,0,0,NULL,9),(12,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:28','2019-10-15 10:05:04','Inherit','Inherit',7,'sample-article-3','Sample Article 3',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,9);
/*!40000 ALTER TABLE `SiteTree_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_Versions`
--

DROP TABLE IF EXISTS `SiteTree_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `WasPublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `WasDeleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `WasDraft` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `AuthorID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  `ClassName` enum('SilverStripe\\CMS\\Model\\SiteTree','Page','SilverStripe\\Example\\ArticleHolder','SilverStripe\\Example\\ArticlePage','SilverStripe\\Example\\HomePage','SilverStripe\\ErrorPage\\ErrorPage','SilverStripe\\CMS\\Model\\RedirectorPage','SilverStripe\\CMS\\Model\\VirtualPage') DEFAULT 'Page',
  `LastEdited` datetime DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(255) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AuthorID` (`AuthorID`),
  KEY `PublisherID` (`PublisherID`),
  KEY `Sort` (`Sort`),
  KEY `ClassName` (`ClassName`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_Versions`
--

LOCK TABLES `SiteTree_Versions` WRITE;
/*!40000 ALTER TABLE `SiteTree_Versions` DISABLE KEYS */;
INSERT INTO `SiteTree_Versions` VALUES (1,1,1,0,0,1,0,0,'Page','2019-10-15 05:07:36','2019-10-15 05:07:36','Inherit','Inherit','home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>.</p><p>You can now access the <a href=\"http://docs.silverstripe.org\">developer documentation</a>, or begin the <a href=\"http://www.silverstripe.org/learn/lessons\">SilverStripe lessons</a>.</p>',NULL,NULL,1,1,1,0,0,NULL,0),(2,1,2,1,0,1,0,0,'Page','2019-10-15 05:07:36','2019-10-15 05:07:36','Inherit','Inherit','home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>.</p><p>You can now access the <a href=\"http://docs.silverstripe.org\">developer documentation</a>, or begin the <a href=\"http://www.silverstripe.org/learn/lessons\">SilverStripe lessons</a>.</p>',NULL,NULL,1,1,1,0,0,NULL,0),(3,2,1,0,0,1,0,0,'Page','2019-10-15 05:07:36','2019-10-15 05:07:36','Inherit','Inherit','about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,2,0,0,NULL,0),(4,2,2,1,0,1,0,0,'Page','2019-10-15 05:07:37','2019-10-15 05:07:36','Inherit','Inherit','about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,2,0,0,NULL,0),(5,3,1,0,0,1,0,0,'Page','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,0),(6,3,2,1,0,1,0,0,'Page','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,0),(7,4,1,0,0,1,0,0,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,4,0,0,NULL,0),(8,4,2,1,0,1,0,0,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,4,0,0,NULL,0),(9,5,1,0,0,1,0,0,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,5,0,0,NULL,0),(10,5,2,1,0,1,0,0,'SilverStripe\\ErrorPage\\ErrorPage','2019-10-15 05:07:37','2019-10-15 05:07:37','Inherit','Inherit','server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,5,0,0,NULL,0),(11,6,5,1,0,1,1,1,'Page','2019-10-15 05:58:41','2019-10-15 05:51:22','Inherit','Inherit','find-a-rental','Find a Rental',NULL,NULL,NULL,NULL,1,1,2,0,0,NULL,0),(12,7,5,1,0,1,1,1,'Page','2019-10-15 05:59:28','2019-10-15 05:53:30','Inherit','Inherit','list-your-rental','List Your Rental',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,0),(13,8,5,1,0,1,1,1,'Page','2019-10-15 09:49:10','2019-10-15 05:55:16','Inherit','Inherit','regions','Regions',NULL,NULL,NULL,NULL,1,1,4,0,0,NULL,0),(14,2,4,1,0,1,1,1,'Page','2019-10-15 09:51:18','2019-10-15 05:07:36','Inherit','Inherit','about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,6,0,0,NULL,0),(15,3,6,1,0,1,1,1,'Page','2019-10-15 09:52:33','2019-10-15 05:07:37','Inherit','Inherit','contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,7,0,0,NULL,0),(16,9,7,1,0,1,1,1,'SilverStripe\\Example\\ArticleHolder','2019-10-15 10:28:48','2019-10-15 06:00:25','Inherit','Inherit','travel-guides','Travel Guides',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,0),(17,10,7,1,0,1,1,1,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:44:22','2019-10-15 09:58:45','Inherit','Inherit','sample-article-1','Sample Article 1',NULL,'<p><span>This is sample article 1.</span></p>',NULL,NULL,1,1,1,0,0,NULL,9),(18,11,7,1,0,1,1,1,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:00','2019-10-15 10:01:16','Inherit','Inherit','sample-article-2','Sample Article 2',NULL,'<p><span>This is sample article 2.</span></p>',NULL,NULL,1,1,2,0,0,NULL,9),(19,12,7,1,0,1,1,1,'SilverStripe\\Example\\ArticlePage','2019-10-16 07:46:28','2019-10-15 10:05:04','Inherit','Inherit','sample-article-3','Sample Article 3',NULL,NULL,NULL,NULL,1,1,3,0,0,NULL,9);
/*!40000 ALTER TABLE `SiteTree_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_ViewerGroups`
--

DROP TABLE IF EXISTS `SiteTree_ViewerGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_ViewerGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_ViewerGroups`
--

LOCK TABLES `SiteTree_ViewerGroups` WRITE;
/*!40000 ALTER TABLE `SiteTree_ViewerGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_ViewerGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage`
--

DROP TABLE IF EXISTS `VirtualPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage`
--

LOCK TABLES `VirtualPage` WRITE;
/*!40000 ALTER TABLE `VirtualPage` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage_Live`
--

DROP TABLE IF EXISTS `VirtualPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage_Live`
--

LOCK TABLES `VirtualPage_Live` WRITE;
/*!40000 ALTER TABLE `VirtualPage_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage_Versions`
--

DROP TABLE IF EXISTS `VirtualPage_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage_Versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage_Versions`
--

LOCK TABLES `VirtualPage_Versions` WRITE;
/*!40000 ALTER TABLE `VirtualPage_Versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage_Versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-15 19:17:11
