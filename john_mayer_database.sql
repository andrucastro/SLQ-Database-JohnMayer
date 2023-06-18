-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: john_mayer
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(60) NOT NULL,
  `admin_last_name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'Andres','Castro','guevaracastroandres@gmail.com','andres12345678'),(2,'Roberto','Gomez','roberto1234@gmail.com','roberto12345678'),(3,'maria','smith','maria1234@gmail.com','maria12345678');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `album_id` int NOT NULL AUTO_INCREMENT,
  `album_name` varchar(50) NOT NULL,
  `album_number_of_songs` int NOT NULL DEFAULT '0',
  `album_length` time NOT NULL DEFAULT '00:00:00',
  `album_year` year NOT NULL,
  `album_cover` text NOT NULL,
  PRIMARY KEY (`album_id`),
  UNIQUE KEY `album_id_UNIQUE` (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'Paradise Valley ',1,'00:04:09',2013,'https://en.wikipedia.org/wiki/File:Paradise_Valley_cover,_by_John_Mayer.jpg'),(2,'Continuum',1,'00:04:50',2006,'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FJohn-Mayer%2Fdp%2FB0014VPFTA&psig=AOvVaw1Q9ukoTQH1eTMlyMYShDV4&ust=1647386539632000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLj32Z7fxvYCFQAAAAAdAAAAABAD'),(3,'Sob Rock ',0,'00:00:00',2021,'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2F-%2Fes%2FJohn-Mayer%2Fdp%2FB0014VPFTA&psig=AOvVaw1Q9ukoTQH1eTMlyMYShDV4&ust=1647386539632000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLj32Z7fxvYCFQAAAAAdAAAAABAD');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `awards` (
  `award_id` int NOT NULL AUTO_INCREMENT,
  `award_name` varchar(45) NOT NULL,
  `award_year` year NOT NULL,
  `song_id` int DEFAULT NULL,
  `album_id` int DEFAULT NULL,
  PRIMARY KEY (`award_id`),
  KEY `fk_awards_songs1_idx` (`song_id`),
  KEY `fk_awards_albumes1_idx` (`album_id`),
  CONSTRAINT `award_album_id` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`),
  CONSTRAINT `award_song_id` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colaborations`
--

DROP TABLE IF EXISTS `colaborations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colaborations` (
  `colaboration_id` int NOT NULL AUTO_INCREMENT,
  `invited_artist_name` varchar(45) NOT NULL,
  `invited_artist_last_name` varchar(45) DEFAULT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`colaboration_id`),
  UNIQUE KEY `colaboration_id_UNIQUE` (`colaboration_id`),
  KEY `fk_colaborations_songs1_idx` (`song_id`),
  CONSTRAINT `song_colaboration` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colaborations`
--

LOCK TABLES `colaborations` WRITE;
/*!40000 ALTER TABLE `colaborations` DISABLE KEYS */;
INSERT INTO `colaborations` VALUES (1,'Katy','Perry',1);
/*!40000 ALTER TABLE `colaborations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(45) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `genre_name_UNIQUE` (`genre_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (5,'blues'),(9,'country'),(8,'folk'),(3,'jazz'),(6,'Opera'),(1,'Pop'),(4,'pop rock'),(7,'punk'),(2,'rock');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_videos`
--

DROP TABLE IF EXISTS `music_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `music_videos` (
  `music_videos_id` int NOT NULL AUTO_INCREMENT,
  `song_id` int NOT NULL,
  `youtube_url` text,
  `length` time DEFAULT NULL,
  PRIMARY KEY (`music_videos_id`),
  UNIQUE KEY `music_videos_id_UNIQUE` (`music_videos_id`),
  KEY `song.id_idx` (`song_id`),
  CONSTRAINT `music_video_song_id` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_videos`
--

LOCK TABLES `music_videos` WRITE;
/*!40000 ALTER TABLE `music_videos` DISABLE KEYS */;
INSERT INTO `music_videos` VALUES (1,1,'https://youtu.be/nSRCpertZn8','00:04:11'),(2,2,'https://www.youtube.com/watch?v=Fo4746XZgw8','00:09:43');
/*!40000 ALTER TABLE `music_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_has_streaming_services`
--

DROP TABLE IF EXISTS `song_has_streaming_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_has_streaming_services` (
  `streaming_group_id` int NOT NULL AUTO_INCREMENT,
  `song_id` int NOT NULL,
  `streaming_id` int NOT NULL,
  `steaming_url` text,
  PRIMARY KEY (`streaming_group_id`),
  KEY `song_id_idx` (`song_id`),
  KEY `streaming_id_idx` (`streaming_id`),
  CONSTRAINT `streaming_id_list` FOREIGN KEY (`streaming_id`) REFERENCES `streaming_services_list` (`streaming_id`),
  CONSTRAINT `streaming_song_id` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_has_streaming_services`
--

LOCK TABLES `song_has_streaming_services` WRITE;
/*!40000 ALTER TABLE `song_has_streaming_services` DISABLE KEYS */;
INSERT INTO `song_has_streaming_services` VALUES (1,1,1,'https://open.spotify.com/track/7IByJvSqRFltGyiiIiL4wn?si=610130e5eb48467a'),(2,2,1,'https://open.spotify.com/track/3SktMqZmo3M9zbB7oKMIF7?si=8721c0d881764675');
/*!40000 ALTER TABLE `song_has_streaming_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_writers`
--

DROP TABLE IF EXISTS `song_writers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_writers` (
  `writer_id` int NOT NULL AUTO_INCREMENT,
  `sw_name` varchar(45) NOT NULL,
  `sw_lastname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`writer_id`),
  UNIQUE KEY `song_writer_id_UNIQUE` (`writer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_writers`
--

LOCK TABLES `song_writers` WRITE;
/*!40000 ALTER TABLE `song_writers` DISABLE KEYS */;
INSERT INTO `song_writers` VALUES (1,'Pino','Palladino'),(2,'John','Mayer'),(3,'Steve','jordan'),(4,'Charlie','Hunter');
/*!40000 ALTER TABLE `song_writers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `song_title` varchar(60) NOT NULL,
  `song_length` time NOT NULL,
  `single` tinyint DEFAULT NULL,
  `album_id` int DEFAULT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`song_id`),
  KEY `album_id_idx` (`album_id`),
  KEY `fk_songs_gender1_idx` (`genre_id`),
  CONSTRAINT `album_id` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`),
  CONSTRAINT `gender_gender_id` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES (1,'Who you love','00:04:09',0,1,1),(2,'Gravity','00:04:50',0,2,5);
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs_has_song_writers`
--

DROP TABLE IF EXISTS `songs_has_song_writers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs_has_song_writers` (
  `song_id` int NOT NULL,
  `writer_id` int NOT NULL,
  PRIMARY KEY (`song_id`,`writer_id`),
  KEY `fk_songs_has_song_writers_song_writers1_idx` (`writer_id`),
  KEY `fk_songs_has_song_writers_songs1_idx` (`song_id`),
  CONSTRAINT `fk_songs_has_song_writers_song_writers1` FOREIGN KEY (`writer_id`) REFERENCES `song_writers` (`writer_id`),
  CONSTRAINT `fk_songs_has_song_writers_songs1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs_has_song_writers`
--

LOCK TABLES `songs_has_song_writers` WRITE;
/*!40000 ALTER TABLE `songs_has_song_writers` DISABLE KEYS */;
INSERT INTO `songs_has_song_writers` VALUES (1,2),(2,2);
/*!40000 ALTER TABLE `songs_has_song_writers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streaming_services_list`
--

DROP TABLE IF EXISTS `streaming_services_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streaming_services_list` (
  `streaming_id` int NOT NULL AUTO_INCREMENT,
  `streaming_service_name` varchar(60) NOT NULL,
  PRIMARY KEY (`streaming_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streaming_services_list`
--

LOCK TABLES `streaming_services_list` WRITE;
/*!40000 ALTER TABLE `streaming_services_list` DISABLE KEYS */;
INSERT INTO `streaming_services_list` VALUES (1,'Spotify'),(2,'Deezer'),(3,'Tidal'),(4,'Apple Music'),(5,'Amazon Music');
/*!40000 ALTER TABLE `streaming_services_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-02 21:07:59
