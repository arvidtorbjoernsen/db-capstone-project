-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customers` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `bookings_customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Cuisines` VARCHAR(255) NOT NULL,
  `Courses` VARCHAR(255) NOT NULL,
  `Deserts` VARCHAR(255) NOT NULL,
  `Drinks` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`SelectedMenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`SelectedMenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`SelectedMenuItems` (
  `SelectedMenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Cuisine` VARCHAR(45) NOT NULL,
  `Starter` INT NULL,
  `Course` INT NULL,
  `Desert` INT NULL,
  `Drink` INT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`SelectedMenuItemID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `selected_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` VARCHAR(45) NOT NULL,
  `CustomerID` INT NOT NULL,
  `CelectedMenuItems` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `customerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `selected_menu_items_fk_idx` (`CelectedMenuItems` ASC) VISIBLE,
  CONSTRAINT `orders_customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `selected_menu_items_fk`
    FOREIGN KEY (`CelectedMenuItems`)
    REFERENCES `LittleLemonDB`.`SelectedMenuItems` (`SelectedMenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Roles` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Roles` (
  `RoleID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Staff` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Salary` DECIMAL NOT NULL,
  `RoleID` INT NOT NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `role_id_fk_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `role_id_fk`
    FOREIGN KEY (`RoleID`)
    REFERENCES `LittleLemonDB`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderDeliveryStatus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `OrderDeliveryStatusID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `OrderID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`OrderDeliveryStatusID`),
  INDEX `order_id_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `staff_id_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `order_id_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_staff_id_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`ContactDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`ContactDetails` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ContactDetails` (
  `ContactDetailsID` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `CustomerID` INT NULL,
  `StaffID` INT NULL,
  PRIMARY KEY (`ContactDetailsID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `staff_id_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contacts_staff_id_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Cuisine` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisine` (
  `CuisineID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `MenuID` INT NULL,
  PRIMARY KEY (`CuisineID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `cuisine_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Starters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Starters` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Starters` (
  `StarterID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`StarterID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `starters_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Courses` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Courses` (
  `CoursesID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`CoursesID`),
  INDEX `courses_menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `courses_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deserts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Deserts` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deserts` (
  `DesertID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`DesertID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `deserts_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Drinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Drinks` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Drinks` (
  `DrinksID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`DrinksID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `drinks_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
