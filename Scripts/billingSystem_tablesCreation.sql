
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema billingSystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `billingSystem` DEFAULT CHARACTER SET utf8 ;
USE `billingSystem` ;

-- -----------------------------------------------------
-- Table Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Branch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `employees_quantity` INT NULL,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(255) NOT NULL,
  `user_type` ENUM("empleado", "administrador") NOT NULL DEFAULT 'empleado',
  `branch` INT NOT NULL,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `branch_idx` (`branch` ASC) VISIBLE,
  CONSTRAINT `branch`
    FOREIGN KEY (`branch`)
    REFERENCES `mydb`.`Branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fiscal_Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Fiscal_Condition` (
  `code` TINYINT(15) NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'consumidor final',
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Location` (
  `zip_code` CHAR(4) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`zip_code`),
  UNIQUE INDEX `zip_code_UNIQUE` (`zip_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `location` CHAR(4) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `fiscal_condition` TINYINT(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fiscal_condition_idx` (`fiscal_condition` ASC) VISIBLE,
  INDEX `location_idx` (`location` ASC) VISIBLE,
  CONSTRAINT `fiscal_condition`
    FOREIGN KEY (`fiscal_condition`)
    REFERENCES `mydb`.`Fiscal_Condition` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location`
    FOREIGN KEY (`location`)
    REFERENCES `mydb`.`Location` (`zip_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Brand` (
  `id` TINYINT(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `supplier_contact` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Category` (
  `id` TINYINT(50) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Products` (
  `code` VARCHAR(255) NOT NULL,
  `brand` TINYINT(255) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `description` TINYTEXT NULL,
  `category` TINYINT(50) NOT NULL,
  `stock` SMALLINT(30000) NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `brand_idx` (`brand` ASC) VISIBLE,
  INDEX `category_idx` (`category` ASC) VISIBLE,
  INDEX `created_by_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `brand`
    FOREIGN KEY (`brand`)
    REFERENCES `mydb`.`Brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category`
    FOREIGN KEY (`category`)
    REFERENCES `mydb`.`Category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `mydb`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Payment_Method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Payment_Method` (
  `id` TINYINT(10) NOT NULL DEFAULT 1,
  `name` VARCHAR(30) NOT NULL DEFAULT 'cash',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Invoice` (
  `invoice_number` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `registered_by` INT NOT NULL,
  `payment_method` TINYINT(10) NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`invoice_number`),
  UNIQUE INDEX `invoice_number_UNIQUE` (`invoice_number` ASC) VISIBLE,
  INDEX `payment_method_idx` (`payment_method` ASC) VISIBLE,
  INDEX `registered_by_idx` (`registered_by` ASC) VISIBLE,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `payment_method`
    FOREIGN KEY (`payment_method`)
    REFERENCES `mydb`.`Payment_Method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `registered_by`
    FOREIGN KEY (`registered_by`)
    REFERENCES `mydb`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Invoice_products_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Invoice_products_detail` (
  `product_code` VARCHAR(255) NOT NULL,
  `invoice_number` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`product_code`, `invoice_number`),
  INDEX `fk_Products_has_Invoice_Invoice1_idx` (`invoice_number` ASC) VISIBLE,
  INDEX `fk_Products_has_Invoice_Products1_idx` (`product_code` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Invoice_Products1`
    FOREIGN KEY (`product_code`)
    REFERENCES `mydb`.`Products` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Invoice_Invoice1`
    FOREIGN KEY (`invoice_number`)
    REFERENCES `mydb`.`Invoice` (`invoice_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Products_stored`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billingSystem`.`Products_stored` (
  `product_code` VARCHAR(255) NOT NULL,
  `branch_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`product_code`, `branch_id`),
  INDEX `fk_Products_has_Branch_Branch1_idx` (`branch_id` ASC) VISIBLE,
  INDEX `fk_Products_has_Branch_Products1_idx` (`product_code` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Branch_Products1`
    FOREIGN KEY (`product_code`)
    REFERENCES `mydb`.`Products` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Branch_Branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `mydb`.`Branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
