Create database john_mayer;
use john_mayer;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema john_mayer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `albums` ;

CREATE TABLE IF NOT EXISTS `albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `album_name` VARCHAR(50) NOT NULL,
  `album_number_of_songs` INT NOT NULL DEFAULT 0,
  `album_length` TIME NOT NULL DEFAULT '00:00:00',
  `album_year` YEAR NOT NULL,
  `album_cover` TEXT NOT NULL,
  PRIMARY KEY (`album_id`),
  UNIQUE INDEX `album_id_UNIQUE` (`album_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genres` ;

CREATE TABLE IF NOT EXISTS `genres` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE INDEX `genre_name_UNIQUE` (`genre_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `songs` ;

CREATE TABLE IF NOT EXISTS `songs` (
  `song_id` INT NOT NULL AUTO_INCREMENT,
  `song_title` VARCHAR(60) NOT NULL,
  `song_length` TIME NOT NULL,
  `single` TINYINT NULL,
  `album_id` INT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`song_id`),
  INDEX `album_id_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_songs_gender1_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gender_gender_id`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genres` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `song_writers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `song_writers` ;

CREATE TABLE IF NOT EXISTS `song_writers` (
  `writer_id` INT NOT NULL AUTO_INCREMENT,
  `sw_name` VARCHAR(45) NOT NULL,
  `sw_lastname` VARCHAR(45) NULL,
  PRIMARY KEY (`writer_id`),
  UNIQUE INDEX `song_writer_id_UNIQUE` (`writer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `awards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `awards` ;

CREATE TABLE IF NOT EXISTS `awards` (
  `award_id` INT NOT NULL AUTO_INCREMENT,
  `award_name` VARCHAR(45) NOT NULL,
  `award_year` YEAR NOT NULL,
  `song_id` INT NULL,
  `album_id` INT NULL,
  INDEX `fk_awards_songs1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_awards_albumes1_idx` (`album_id` ASC) VISIBLE,
  PRIMARY KEY (`award_id`),
  CONSTRAINT `award_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `award_album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colaborations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `colaborations` ;

CREATE TABLE IF NOT EXISTS `colaborations` (
  `colaboration_id` INT NOT NULL AUTO_INCREMENT,
  `invited_artist_name` VARCHAR(45) NOT NULL,
  `invited_artist_last_name` VARCHAR(45) NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`colaboration_id`),
  UNIQUE INDEX `colaboration_id_UNIQUE` (`colaboration_id` ASC) VISIBLE,
  INDEX `fk_colaborations_songs1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `song_colaboration`
    FOREIGN KEY (`song_id`)
    REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `music_videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `music_videos` ;

CREATE TABLE IF NOT EXISTS `music_videos` (
  `music_videos_id` INT NOT NULL AUTO_INCREMENT,
  `song_id` INT NOT NULL,
  `youtube_url` TEXT NULL,
  `length` TIME NULL,
  PRIMARY KEY (`music_videos_id`),
  UNIQUE INDEX `music_videos_id_UNIQUE` (`music_videos_id` ASC) VISIBLE,
  INDEX `song.id_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `music_video_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_services_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `streaming_services_list` ;

CREATE TABLE IF NOT EXISTS `streaming_services_list` (
  `streaming_id` INT NOT NULL AUTO_INCREMENT,
  `streaming_service_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`streaming_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `song_has_streaming_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `song_has_streaming_services` ;

CREATE TABLE IF NOT EXISTS `song_has_streaming_services` (
  `streaming_group_id` INT NOT NULL AUTO_INCREMENT,
  `song_id` INT NOT NULL,
  `streaming_id` INT NOT NULL,
  `steaming_url` TEXT NULL,
  INDEX `song_id_idx` (`song_id` ASC) VISIBLE,
  PRIMARY KEY (`streaming_group_id`),
  INDEX `streaming_id_idx` (`streaming_id` ASC) VISIBLE,
  CONSTRAINT `streaming_song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `streaming_id_list`
    FOREIGN KEY (`streaming_id`)
    REFERENCES `streaming_services_list` (`streaming_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admins` ;

CREATE TABLE IF NOT EXISTS `admins` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `admin_name` VARCHAR(60) NOT NULL,
  `admin_last_name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `songs_has_song_writers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `songs_has_song_writers` ;

CREATE TABLE IF NOT EXISTS `songs_has_song_writers` (
  `song_id` INT NOT NULL,
  `writer_id` INT NOT NULL,
  PRIMARY KEY (`song_id`, `writer_id`),
  INDEX `fk_songs_has_song_writers_song_writers1_idx` (`writer_id` ASC) VISIBLE,
  INDEX `fk_songs_has_song_writers_songs1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_has_song_writers_songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_songs_has_song_writers_song_writers1`
    FOREIGN KEY (`writer_id`)
    REFERENCES `song_writers` (`writer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
