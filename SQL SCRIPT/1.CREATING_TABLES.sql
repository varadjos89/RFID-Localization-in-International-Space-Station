-- MySQL Script generated by MySQL Workbench
-- Wed Nov 28 20:06:42 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ISS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ISS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ISS` DEFAULT CHARACTER SET utf8 ;
USE `ISS` ;

-- -----------------------------------------------------
-- Table `ISS`.`GROUND_UNIT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`GROUND_UNIT` (
  `unit_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `headquarter` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `country_code` INT NOT NULL,
  PRIMARY KEY (`unit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`ASTRONAUT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`ASTRONAUT` (
  `astronaut_id` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `ground_unit_id` INT NOT NULL,
  PRIMARY KEY (`astronaut_id`),
  INDEX `fk_Astronaut_Space_Agency_idx` (`ground_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_Astronaut_Space_Agency`
    FOREIGN KEY (`ground_unit_id`)
    REFERENCES `ISS`.`GROUND_UNIT` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`MODULE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`MODULE` (
  `module_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `ground_unit_id` INT NOT NULL,
  PRIMARY KEY (`module_id`),
  INDEX `fk_Module_Space_Agency1_idx` (`ground_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_Module_Space_Agency1`
    FOREIGN KEY (`ground_unit_id`)
    REFERENCES `ISS`.`GROUND_UNIT` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`MODULE_BACKUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`MODULE_BACKUP` (
  `module_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `ground_unit_id` INT NOT NULL,
  PRIMARY KEY (`module_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`RFID_SCANNER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`RFID_SCANNER` (
  `scanner_id` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `range` DOUBLE NOT NULL,
  `height` DOUBLE NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`scanner_id`),
  INDEX `fk_RFID_Scanner_Module1_idx` (`module_id` ASC) VISIBLE,
  CONSTRAINT `fk_RFID_Scanner_Module1`
    FOREIGN KEY (`module_id`)
    REFERENCES `ISS`.`MODULE` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`DEVICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`DEVICE` (
  `device_id` INT NOT NULL,
  `starting_date` DATE NOT NULL,
  `ending_date` DATE NOT NULL,
  `astronaut_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `fk_Device_Astronaut1_idx` (`astronaut_id` ASC) VISIBLE,
  CONSTRAINT `fk_Device_Astronaut1`
    FOREIGN KEY (`astronaut_id`)
    REFERENCES `ISS`.`ASTRONAUT` (`astronaut_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`LABORATORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`LABORATORY` (
  `lab_code` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lab_code`),
  INDEX `fk_Laboratory_Module1_idx` (`module_id` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratory_Module1`
    FOREIGN KEY (`module_id`)
    REFERENCES `ISS`.`MODULE` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ISS`.`SYSTEMS`.BACKUP
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`SYSTEMS_BACKUP` (
  `system_tag_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
   PRIMARY KEY (`system_tag_id`));


-- -----------------------------------------------------
-- Table `ISS`.`SYSTEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`SYSTEMS` (
  `system_tag_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  INDEX `fk_System_Module1_idx` (`module_id` ASC) VISIBLE,
  PRIMARY KEY (`system_tag_id`),
  CONSTRAINT `fk_System_Module1`
    FOREIGN KEY (`module_id`)
    REFERENCES `ISS`.`MODULE` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`DRAWER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`DRAWER` (
  `drawer_id` VARCHAR(45) NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  `drawer_location` VARCHAR(45) NOT NULL,
  INDEX `fk_Drawer_Module1_idx` (`module_id` ASC) VISIBLE,
  PRIMARY KEY (`drawer_id`),
  CONSTRAINT `fk_Drawer_Module1`
    FOREIGN KEY (`module_id`)
    REFERENCES `ISS`.`MODULE` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ISS`.`DRAWER_COMPONENTS_BACKUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`DRAWER_COMPONENTS_BACKUP` (
  `component_tag` VARCHAR(45) NOT NULL,
  `drawer_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`component_tag`));


-- -----------------------------------------------------
-- Table `ISS`.`DRAWER_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`DRAWER_COMPONENTS` (
  `component_tag` VARCHAR(45) NOT NULL,
  `drawer_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_DRAWER_COMPONENTS_DRAWER1_idx` (`drawer_id` ASC) VISIBLE,
  CONSTRAINT `fk_DRAWER_COMPONENTS_DRAWER1`
    FOREIGN KEY (`drawer_id`)
    REFERENCES `ISS`.`DRAWER` (`drawer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`SECTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`SECTION` (
  `section_id` VARCHAR(45) NOT NULL,
  `lab_code` VARCHAR(45) NOT NULL,
  `section_name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_Section_LABORATORY1_idx` (`lab_code` ASC) VISIBLE,
  CONSTRAINT `fk_Section_LABORATORY1`
    FOREIGN KEY (`lab_code`)
    REFERENCES `ISS`.`LABORATORY` (`lab_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`LAB_COMPONENTS_BACKUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`LAB_COMPONENTS_BACKUP` (
  `component_tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  `section_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`component_tag`));

-- -----------------------------------------------------
-- Table `ISS`.`LAB_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`LAB_COMPONENTS` (
  `component_tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  `section_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_LAB_COMPONENTS_SECTION1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_LAB_COMPONENTS_SECTION1`
    FOREIGN KEY (`section_id`)
    REFERENCES `ISS`.`SECTION` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`SEARCH_HISTORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`SEARCH_HISTORY` (
  `search_index` INT NOT NULL,
  `device_id` INT NOT NULL,
  `search_component` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`search_index`),
  INDEX `fk_Search_History_Device1_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `fk_Search_History_Device1`
    FOREIGN KEY (`device_id`)
    REFERENCES `ISS`.`DEVICE` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`PREDEFINED_SYSTEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`PREDEFINED_SYSTEMS` (
  `system_tag_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`system_tag_id`),
  INDEX `fk_Predefined_system_GROUND_UNIT1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_Predefined_system_GROUND_UNIT1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `ISS`.`GROUND_UNIT` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`PREDEFINED_LAB_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`PREDEFINED_LAB_COMPONENTS` (
  `component_tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `section_locatiion` VARCHAR(45) NULL,
  `section` VARCHAR(45) NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_PREDEFINED_LAB_COMPONENTS_GROUND_UNIT1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_PREDEFINED_LAB_COMPONENTS_GROUND_UNIT1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `ISS`.`GROUND_UNIT` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`PREDEFINED_DRAWER_COMPONENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`PREDEFINED_DRAWER_COMPONENT` (
  `component_tag` VARCHAR(45) NOT NULL,
  `drawer_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `drawer_location` VARCHAR(45) NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_PREDEFINED_DRAWER_COMPONENT_GROUND_UNIT1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_PREDEFINED_DRAWER_COMPONENT_GROUND_UNIT1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `ISS`.`GROUND_UNIT` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`ASTRO_BEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`ASTRO_BEE` (
  `bee_id` VARCHAR(45) NOT NULL,
  `component_tag` VARCHAR(45) NOT NULL,
  `component_name` VARCHAR(45) NOT NULL,
  `predefined_location` VARCHAR(45) NOT NULL,
  `device_id` INT NOT NULL,
  PRIMARY KEY (`bee_id`),
  INDEX `fk_ASTRO_BEE_DEVICE1_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `fk_ASTRO_BEE_DEVICE1`
    FOREIGN KEY (`device_id`)
    REFERENCES `ISS`.`DEVICE` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`DRAWER_RFID`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`DRAWER_RFID` (
  `scanner_id` INT NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `drawer_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`scanner_id`),
  INDEX `fk_DRAWER_RFID_DRAWER1_idx` (`drawer_id` ASC) VISIBLE,
  CONSTRAINT `fk_DRAWER_RFID_DRAWER1`
    FOREIGN KEY (`drawer_id`)
    REFERENCES `ISS`.`DRAWER` (`drawer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`BEE_SYSTEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`BEE_SYSTEMS` (
  `systems_tag_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `module_location` VARCHAR(45) NOT NULL,
  `bee_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`systems_tag_id`),
  INDEX `fk_BEE_SYSTEMS_ASTRO_BEE1_idx` (`bee_id` ASC) VISIBLE,
  CONSTRAINT `fk_BEE_SYSTEMS_ASTRO_BEE1`
    FOREIGN KEY (`bee_id`)
    REFERENCES `ISS`.`ASTRO_BEE` (`bee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`BEE_DRAWER_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`BEE_DRAWER_COMPONENTS` (
  `component_tag` VARCHAR(45) NOT NULL,
  `drawer_location` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `bee_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_BEE_DRAWER_COMPONENTS_ASTRO_BEE1_idx` (`bee_id` ASC) VISIBLE,
  CONSTRAINT `fk_BEE_DRAWER_COMPONENTS_ASTRO_BEE1`
    FOREIGN KEY (`bee_id`)
    REFERENCES `ISS`.`ASTRO_BEE` (`bee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`BEE_LAB_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`BEE_LAB_COMPONENTS` (
  `component_tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `section_location` VARCHAR(45) NOT NULL,
  `bee_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`component_tag`),
  INDEX `fk_BEE_LAB_COMPONENTS_ASTRO_BEE1_idx` (`bee_id` ASC) VISIBLE,
  CONSTRAINT `fk_BEE_LAB_COMPONENTS_ASTRO_BEE1`
    FOREIGN KEY (`bee_id`)
    REFERENCES `ISS`.`ASTRO_BEE` (`bee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ISS`.`COMPONENT_CONDITION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ISS`.`COMPONENT_CONDITION` (
  `component_tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `condition` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`component_tag`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- drop database iss;