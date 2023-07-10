-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tagliafico
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tagliafico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tagliafico` DEFAULT CHARACTER SET utf8mb4 ;
USE `tagliafico` ;

-- -----------------------------------------------------
-- Table `tagliafico`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`direccion` (
  `id_direccion` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `altura` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(45) NULL DEFAULT NULL,
  `provincia` VARCHAR(45) NULL DEFAULT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `dpto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`cliente` (
  `id_cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `id_direccion` INT(11) NOT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `dni` INT(11) NOT NULL,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_direccion1` (`id_direccion` ASC),
  CONSTRAINT `fk_cliente_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `tagliafico`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`producto` (
  `id_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`sucursal` (
  `id_sucursal` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`deposito_has_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`deposito_has_producto` (
  `id_producto` INT(11) NOT NULL,
  `Stock` DOUBLE NULL DEFAULT NULL,
  `id_sucursal` INT(11) NOT NULL,
  INDEX `fk_deposito_has_producto_producto1` (`id_producto` ASC),
  INDEX `fk_deposito_has_producto_sucursal1_idx` (`id_sucursal` ASC),
  CONSTRAINT `fk_deposito_has_producto_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `tagliafico`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deposito_has_producto_sucursal1`
    FOREIGN KEY (`id_sucursal`)
    REFERENCES `tagliafico`.`sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`puesto` (
  `id_puesto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_puesto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_puesto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`empleado` (
  `id_empleado` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `id_sucursal` INT(11) NOT NULL,
  `id_puesto` INT(11) NOT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `cuil` VARCHAR(11) NULL DEFAULT NULL,
  `dni` VARCHAR(8) NULL DEFAULT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `id_direccion` INT(11) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `fk_empleado_sucursal1` (`id_sucursal` ASC),
  INDEX `fk_empleado_puesto1` (`id_puesto` ASC),
  INDEX `fk_empleado_direccion1` (`id_direccion` ASC),
  CONSTRAINT `fk_empleado_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `tagliafico`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_puesto1`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `tagliafico`.`puesto` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_sucursal1`
    FOREIGN KEY (`id_sucursal`)
    REFERENCES `tagliafico`.`sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`proveedor` (
  `id_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NULL DEFAULT NULL,
  `cuit` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`materia_prima`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`materia_prima` (
  `id_materia_prima` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `id_proveedor` INT(11) NOT NULL,
  PRIMARY KEY (`id_materia_prima`),
  INDEX `fk_materia_prima_proveedor1` (`id_proveedor` ASC),
  CONSTRAINT `fk_materia_prima_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `tagliafico`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`materia_prima_has_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`materia_prima_has_producto` (
  `id_materia_prima` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `cantidad` DOUBLE NULL DEFAULT NULL,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  INDEX `fk_materia_prima_has_producto_materia_prima1` (`id_materia_prima` ASC),
  INDEX `fk_materia_prima_has_producto_producto1` (`id_producto` ASC),
  CONSTRAINT `fk_materia_prima_has_producto_materia_prima1`
    FOREIGN KEY (`id_materia_prima`)
    REFERENCES `tagliafico`.`materia_prima` (`id_materia_prima`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_prima_has_producto_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `tagliafico`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`pedido` (
  `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `descuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_cliente` INT(11) NOT NULL,
  `id_empleado` INT(11) NOT NULL,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_cliente1` (`id_cliente` ASC),
  INDEX `fk_pedido_empleado1` (`id_empleado` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `tagliafico`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `tagliafico`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tagliafico`.`producto_has_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagliafico`.`producto_has_pedido` (
  `id_producto` INT(11) NOT NULL,
  `id_pedido` INT(11) NOT NULL,
  `cantidad` DOUBLE NULL DEFAULT NULL,
  INDEX `fk_producto_has_pedido_producto1` (`id_producto` ASC),
  INDEX `fk_producto_has_pedido_pedido1` (`id_pedido` ASC),
  CONSTRAINT `fk_producto_has_pedido_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `tagliafico`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_pedido_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `tagliafico`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
