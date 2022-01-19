SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `BD_ES2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `BD_ES2` ;

-- -----------------------------------------------------
-- Table `BD_ES2`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(250) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Conta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Conta` (
  `idConta` INT NOT NULL AUTO_INCREMENT,
  `saldo` FLOAT NOT NULL DEFAULT 0.0,
  `limite` FLOAT NOT NULL DEFAULT -1000.0,
  `agencia` VARCHAR(25) NOT NULL,
  `banco` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idConta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Cliente_has_Conta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Cliente_has_Conta` (
  `Cliente_idCliente` INT NOT NULL,
  `Conta_idConta` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Conta_idConta`),
  INDEX `fk_Cliente_has_Conta_Conta1_idx` (`Conta_idConta` ASC),
  INDEX `fk_Cliente_has_Conta_Cliente_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Cliente_has_Conta_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `BD_ES2`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cliente_has_Conta_Conta1`
    FOREIGN KEY (`Conta_idConta`)
    REFERENCES `BD_ES2`.`Conta` (`idConta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Cartao` (
  `idCartao` INT NOT NULL,
  `Cliente_has_Conta_Cliente_idCliente` INT NOT NULL,
  `Cliente_has_Conta_Conta_idConta` INT NOT NULL,
  `validade` DATE NOT NULL,
  PRIMARY KEY (`idCartao`, `Cliente_has_Conta_Cliente_idCliente`, `Cliente_has_Conta_Conta_idConta`),
  INDEX `fk_Cartao_Cliente_has_Conta1_idx` (`Cliente_has_Conta_Cliente_idCliente` ASC, `Cliente_has_Conta_Conta_idConta` ASC),
  CONSTRAINT `fk_Cartao_Cliente_has_Conta1`
    FOREIGN KEY (`Cliente_has_Conta_Cliente_idCliente` , `Cliente_has_Conta_Conta_idConta`)
    REFERENCES `BD_ES2`.`Cliente_has_Conta` (`Cliente_idCliente` , `Conta_idConta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Deposito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Deposito` (
  `idDeposito` INT NOT NULL AUTO_INCREMENT,
  `Cliente_has_Conta_Cliente_idCliente` INT NOT NULL,
  `Cliente_has_Conta_Conta_idConta` INT NOT NULL,
  `data` TIMESTAMP NOT NULL,
  `valor` FLOAT NULL,
  `validacao` TINYINT(1) NULL,
  PRIMARY KEY (`idDeposito`),
  INDEX `fk_Deposito_Cliente_has_Conta1_idx` (`Cliente_has_Conta_Cliente_idCliente` ASC, `Cliente_has_Conta_Conta_idConta` ASC),
  CONSTRAINT `fk_Deposito_Cliente_has_Conta1`
    FOREIGN KEY (`Cliente_has_Conta_Cliente_idCliente` , `Cliente_has_Conta_Conta_idConta`)
    REFERENCES `BD_ES2`.`Cliente_has_Conta` (`Cliente_idCliente` , `Conta_idConta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Saque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Saque` (
  `data` INT NOT NULL,
  `Cliente_has_Conta_Cliente_idCliente` INT NOT NULL,
  `Cliente_has_Conta_Conta_idConta` INT NOT NULL,
  PRIMARY KEY (`data`, `Cliente_has_Conta_Cliente_idCliente`, `Cliente_has_Conta_Conta_idConta`),
  INDEX `fk_Saque_Cliente_has_Conta1_idx` (`Cliente_has_Conta_Cliente_idCliente` ASC, `Cliente_has_Conta_Conta_idConta` ASC),
  CONSTRAINT `fk_Saque_Cliente_has_Conta1`
    FOREIGN KEY (`Cliente_has_Conta_Cliente_idCliente` , `Cliente_has_Conta_Conta_idConta`)
    REFERENCES `BD_ES2`.`Cliente_has_Conta` (`Cliente_idCliente` , `Conta_idConta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Transferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Transferencia` (
  `data` TIMESTAMP NOT NULL,
  `Cliente_has_Conta_Cliente_idCliente` INT NOT NULL,
  `Cliente_has_Conta_Conta_idConta` INT NOT NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`data`, `Cliente_has_Conta_Cliente_idCliente`, `Cliente_has_Conta_Conta_idConta`),
  INDEX `fk_Transferencia_Cliente_has_Conta1_idx` (`Cliente_has_Conta_Cliente_idCliente` ASC, `Cliente_has_Conta_Conta_idConta` ASC),
  CONSTRAINT `fk_Transferencia_Cliente_has_Conta1`
    FOREIGN KEY (`Cliente_has_Conta_Cliente_idCliente` , `Cliente_has_Conta_Conta_idConta`)
    REFERENCES `BD_ES2`.`Cliente_has_Conta` (`Cliente_idCliente` , `Conta_idConta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`CaixaEletronico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`CaixaEletronico` (
  `idCaixaEletronico` INT NOT NULL,
  `nota2` INT NULL DEFAULT 0,
  `nota5` INT NULL DEFAULT 0,
  `nota10` INT NULL DEFAULT 0,
  `nota20` INT NULL DEFAULT 0,
  `nota50` INT NULL DEFAULT 0,
  `nota100` INT NULL DEFAULT 0,
  `cheque` INT NULL DEFAULT 0,
  `papelComprovante` INT NULL DEFAULT 0,
  PRIMARY KEY (`idCaixaEletronico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Gerente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_ES2`.`Gerente` (
  `idGerente` INT NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idGerente`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
