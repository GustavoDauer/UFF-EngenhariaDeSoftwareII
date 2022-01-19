SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `BD_ES2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `BD_ES2` ;

-- -----------------------------------------------------
-- Table `BD_ES2`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(250) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT true,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Conta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`Conta` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`Conta` (
  `idConta` INT NOT NULL AUTO_INCREMENT,
  `saldo` INT NULL DEFAULT 0,
  `saldo_centavos` TINYINT NULL DEFAULT 0,
  `limite` INT NULL DEFAULT -1000,
  `agencia` VARCHAR(25) NULL,
  `banco` VARCHAR(250) NULL,
  `status` TINYINT(1) NULL DEFAULT true,
  `poupanca_status` TINYINT(1) NULL DEFAULT true,
  `poupanca_saldo` INT NULL DEFAULT 0,
  `poupanca_saldo_centavos` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idConta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`CaixaEletronico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`CaixaEletronico` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`CaixaEletronico` (
  `idCaixaEletronico` INT NOT NULL,
  `nota50` INT NULL DEFAULT 0,
  `nota100` INT NULL DEFAULT 0,
  `cheque` INT NULL DEFAULT 0,
  `papelComprovante` INT NULL DEFAULT 0,
  `dataDoCaixa` DATE NOT NULL,
  PRIMARY KEY (`idCaixaEletronico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Gerente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`Gerente` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`Gerente` (
  `idGerente` INT NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  `senha` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idGerente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_ES2`.`Cliente_has_Conta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`Cliente_has_Conta` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`Cliente_has_Conta` (
  `Cliente_idCliente` INT NOT NULL,
  `Conta_idConta` INT NOT NULL,
  `numeroCartao` VARCHAR(25) NOT NULL,
  `senha` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Conta_idConta`),
  INDEX `fk_Cliente_has_Conta_Conta1_idx` (`Conta_idConta` ASC),
  INDEX `fk_Cliente_has_Conta_Cliente_idx` (`Cliente_idCliente` ASC),
  UNIQUE INDEX `numeroCartao_UNIQUE` (`numeroCartao` ASC),
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
-- Table `BD_ES2`.`Transacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_ES2`.`Transacao` ;

CREATE TABLE IF NOT EXISTS `BD_ES2`.`Transacao` (
  `data` TIMESTAMP NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Conta_idConta` INT NOT NULL,
  `valor` INT NOT NULL DEFAULT 0,
  `valor_centavos` TINYINT NOT NULL DEFAULT 0,
  `tipoTransacao` VARCHAR(250) NOT NULL,
  `Transferencia_Conta_idConta` INT NULL,
  PRIMARY KEY (`data`, `Cliente_idCliente`, `Conta_idConta`),
  INDEX `fk_Transacao_Cliente_has_Conta1_idx` (`Cliente_idCliente` ASC, `Conta_idConta` ASC),
  INDEX `fk_Transacao_Conta1_idx` (`Transferencia_Conta_idConta` ASC),
  CONSTRAINT `fk_Transacao_Cliente_has_Conta1`
    FOREIGN KEY (`Cliente_idCliente` , `Conta_idConta`)
    REFERENCES `BD_ES2`.`Cliente_has_Conta` (`Cliente_idCliente` , `Conta_idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Conta1`
    FOREIGN KEY (`Transferencia_Conta_idConta`)
    REFERENCES `BD_ES2`.`Conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
