-- MySQL Script generated by MySQL Workbench
-- Wed Aug  9 15:45:12 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema billingSystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema billingSystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `billingSystem` DEFAULT CHARACTER SET utf8 ;
USE `billingSystem` ;

-- -----------------------------------------------------
-- Table `billingSystem`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Branch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `employees_quantity` INT NULL,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(255) NOT NULL,
  `user_type` ENUM("empleado", "administrador") NOT NULL DEFAULT 'empleado',
  `branch` INT NOT NULL,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  PRIMARY KEY (`id`),
  INDEX `branch_idx` (`branch` ASC),
  CONSTRAINT `branch`
    FOREIGN KEY (`branch`)
    REFERENCES `billingSystem`.`Branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Fiscal_Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Fiscal_Condition` (
  `code` TINYINT(15) NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'consumidor final',
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zip_code` CHAR(4) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `location` INT NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `fiscal_condition` TINYINT(15) NOT NULL,
  `dni` VARCHAR(15) NULL,
  `cuit` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fiscal_condition_idx` (`fiscal_condition` ASC),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) ,
  UNIQUE INDEX `cuit_UNIQUE` (`cuit` ASC),
  INDEX `location_idx` (`location` ASC),
  CONSTRAINT `fiscal_condition`
    FOREIGN KEY (`fiscal_condition`)
    REFERENCES `billingSystem`.`Fiscal_Condition` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location`
    FOREIGN KEY (`location`)
    REFERENCES `billingSystem`.`Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Brand` (
  `id` TINYINT(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `supplier_contact` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Category` (
  `id` TINYINT(50) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Products` (
  `code` VARCHAR(255) NOT NULL,
  `brand` TINYINT(255) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `description` TINYTEXT NULL,
  `category` TINYINT(50) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) ,
  INDEX `brand_idx` (`brand` ASC) ,
  INDEX `category_idx` (`category` ASC) ,
  INDEX `created_by_idx` (`created_by` ASC),
  CONSTRAINT `brand`
    FOREIGN KEY (`brand`)
    REFERENCES `billingSystem`.`Brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category`
    FOREIGN KEY (`category`)
    REFERENCES `billingSystem`.`Category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `billingSystem`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Payment_Method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Payment_Method` (
  `id` TINYINT(20) NOT NULL DEFAULT 1,
  `name` VARCHAR(30) NOT NULL DEFAULT 'cash',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Invoice` (
  `invoice_number` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `registered_by` INT NOT NULL,
  `payment_method` TINYINT(10) NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`invoice_number`),
  UNIQUE INDEX `invoice_number_UNIQUE` (`invoice_number` ASC) ,
  INDEX `payment_method_idx` (`payment_method` ASC) ,
  INDEX `registered_by_idx` (`registered_by` ASC) ,
  INDEX `client_id_idx` (`client_id` ASC) ,
  CONSTRAINT `payment_method`
    FOREIGN KEY (`payment_method`)
    REFERENCES `billingSystem`.`Payment_Method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `registered_by`
    FOREIGN KEY (`registered_by`)
    REFERENCES `billingSystem`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `billingSystem`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Invoice_products_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Invoice_products_detail` (
  `product_code` VARCHAR(255) NOT NULL,
  `invoice_number` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`product_code`, `invoice_number`),
  INDEX `fk_Products_has_Invoice_Invoice1_idx` (`invoice_number` ASC) ,
  INDEX `fk_Products_has_Invoice_Products1_idx` (`product_code` ASC) ,
  CONSTRAINT `fk_Products_has_Invoice_Products1`
    FOREIGN KEY (`product_code`)
    REFERENCES `billingSystem`.`Products` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Invoice_Invoice1`
    FOREIGN KEY (`invoice_number`)
    REFERENCES `billingSystem`.`Invoice` (`invoice_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingSystem`.`Products_stored`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Products_stored` (
  `product_code` VARCHAR(255) NOT NULL,
  `branch_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`product_code`, `branch_id`),
  INDEX `fk_Products_has_Branch_Branch1_idx` (`branch_id` ASC) ,
  INDEX `fk_Products_has_Branch_Products1_idx` (`product_code` ASC) ,
  CONSTRAINT `fk_Products_has_Branch_Products1`
    FOREIGN KEY (`product_code`)
    REFERENCES `billingSystem`.`Products` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Branch_Branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `billingSystem`.`Branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
