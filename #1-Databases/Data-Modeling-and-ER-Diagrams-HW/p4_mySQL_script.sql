-- MySQL Script generated by MySQL Workbench
-- 06/26/15 16:54:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`faculties` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`faculty_id`),
  UNIQUE INDEX `faculty_id_UNIQUE` (`faculty_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC),
  INDEX `fk_students_faculties_idx` (`faculty_id` ASC),
  CONSTRAINT `fk_students_faculties`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculties` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`courses_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`courses_students` (
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  INDEX `fk_courses_students_students_idx` (`student_id` ASC),
  INDEX `fk_courses_students_courses_idx` (`course_id` ASC),
  CONSTRAINT `fk_courses_students_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `University`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_students_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `University`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`departments_courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`departments_courses` (
  `department_id` INT NULL,
  `course_id` INT NULL,
  INDEX `fk_departments_courses_departments_idx` (`department_id` ASC),
  INDEX `fk_departments_courses_courses_idx` (`course_id` ASC),
  CONSTRAINT `fk_departments_courses_departments`
    FOREIGN KEY (`department_id`)
    REFERENCES `University`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departments_courses_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `University`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`professors` (
  `professor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`professor_id`),
  UNIQUE INDEX `professor_id_UNIQUE` (`professor_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`departments_professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`departments_professors` (
  `department_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  INDEX `fk_departments_professors_departments_idx` (`department_id` ASC),
  INDEX `fk_departments_professors_professors_idx` (`professor_id` ASC),
  CONSTRAINT `fk_departments_professors_departments`
    FOREIGN KEY (`department_id`)
    REFERENCES `University`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departments_professors_professors`
    FOREIGN KEY (`professor_id`)
    REFERENCES `University`.`professors` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculties_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`faculties_departments` (
  `faculty_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  INDEX `fk_faculties_departments_faculties_idx` (`faculty_id` ASC),
  INDEX `fk_faculties_departments_departments_idx` (`department_id` ASC),
  CONSTRAINT `fk_faculties_departments_faculties`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculties` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_faculties_departments_departments`
    FOREIGN KEY (`department_id`)
    REFERENCES `University`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`professors_courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`professors_courses` (
  `professor_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  INDEX `fk_professors_courses_courses_idx` (`course_id` ASC),
  INDEX `fk_professors_courses_professors_idx` (`professor_id` ASC),
  CONSTRAINT `fk_professors_courses_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `University`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professors_courses_professors`
    FOREIGN KEY (`professor_id`)
    REFERENCES `University`.`professors` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`titles` (
  `title_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`title_id`),
  UNIQUE INDEX `title_id_UNIQUE` (`title_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`professors_titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`professors_titles` (
  `professor_id` INT NOT NULL,
  `title_id` INT NOT NULL,
  INDEX `fk_professors_titles_titles_idx` (`title_id` ASC),
  INDEX `fk_professors_titles_professors_idx` (`professor_id` ASC),
  CONSTRAINT `fk_professors_titles_titles`
    FOREIGN KEY (`title_id`)
    REFERENCES `University`.`titles` (`title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professors_titles_professors`
    FOREIGN KEY (`professor_id`)
    REFERENCES `University`.`professors` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;