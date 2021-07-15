-- --------------------------------------------------------
-- Host:                         msm.hopto.org
-- Server version:               10.3.27-MariaDB-0+deb10u1 - Raspbian 10
-- Server OS:                    debian-linux-gnueabihf
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for msmDB
CREATE DATABASE IF NOT EXISTS `msmDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `msmDB`;

-- Dumping structure for table msmDB.area
CREATE TABLE IF NOT EXISTS `area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `designacao` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.area_componentes
CREATE TABLE IF NOT EXISTS `area_componentes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` bigint(20) DEFAULT NULL,
  `componentes_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `area_componentes_fk1` (`area_id`),
  KEY `area_componentes_fk2` (`componentes_id`),
  CONSTRAINT `area_componentes_fk1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`),
  CONSTRAINT `area_componentes_fk2` FOREIGN KEY (`componentes_id`) REFERENCES `componentes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.area_frigorifica
CREATE TABLE IF NOT EXISTS `area_frigorifica` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `designacao` varchar(512) NOT NULL,
  `fabricante` varchar(512) NOT NULL,
  `d_t_adicao` datetime DEFAULT NULL,
  `tem_min` float NOT NULL,
  `tem_max` float NOT NULL,
  `d_t_limpeza` timestamp NULL DEFAULT NULL,
  `user_limpeza` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `User_Limpeza` (`user_limpeza`),
  CONSTRAINT `FK_area_frigorifica_user` FOREIGN KEY (`user_limpeza`) REFERENCES `user` (`num_interno`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.area_limpeza
CREATE TABLE IF NOT EXISTS `area_limpeza` (
  `area_id` bigint(20) NOT NULL,
  `limpeza_id` bigint(20) NOT NULL,
  PRIMARY KEY (`limpeza_id`),
  KEY `area_limpeza_fk1` (`area_id`),
  CONSTRAINT `area_limpeza_fk1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`),
  CONSTRAINT `area_limpeza_fk2` FOREIGN KEY (`limpeza_id`) REFERENCES `limpeza` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.componentes
CREATE TABLE IF NOT EXISTS `componentes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `designacao` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.fornecedor
CREATE TABLE IF NOT EXISTS `fornecedor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identificador` varchar(512) NOT NULL,
  `nome` varchar(512) NOT NULL,
  `contacto` bigint(20) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `morada` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identificador` (`identificador`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.limpeza
CREATE TABLE IF NOT EXISTS `limpeza` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_componentes_id` bigint(20) NOT NULL DEFAULT 0,
  `data` date NOT NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) NOT NULL,
  `assinatura` bigint(20) DEFAULT NULL,
  `data_assinatura` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `limpeza_fk1` (`user_id`),
  KEY `area_componentes_fk` (`area_componentes_id`),
  KEY `assinatura_fk` (`assinatura`),
  CONSTRAINT `area_componentes_fk` FOREIGN KEY (`area_componentes_id`) REFERENCES `area_componentes` (`id`),
  CONSTRAINT `assinatura_fk` FOREIGN KEY (`assinatura`) REFERENCES `user` (`id`),
  CONSTRAINT `limpeza_fk1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `n_interno` bigint(20) NOT NULL,
  `nome` varchar(512) NOT NULL,
  `fresco` tinyint(1) NOT NULL,
  `preco` float NOT NULL,
  `venda` float DEFAULT NULL,
  `ean` varchar(50) NOT NULL DEFAULT '-1',
  `marca` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique` (`n_interno`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.rastreabilidade
CREATE TABLE IF NOT EXISTS `rastreabilidade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lote` varchar(512) NOT NULL,
  `d_t_entrada` datetime NOT NULL DEFAULT current_timestamp(),
  `origem` varchar(512) DEFAULT NULL,
  `assinado_user` bigint(20) DEFAULT NULL,
  `produto_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `fornecedor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rastreabilidade_fk1` (`produto_id`),
  KEY `rastreabilidade_fk2` (`user_id`),
  KEY `rastreabilidade_fk3` (`fornecedor_id`),
  CONSTRAINT `rastreabilidade_fk1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`),
  CONSTRAINT `rastreabilidade_fk2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `rastreabilidade_fk3` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.temperatura
CREATE TABLE IF NOT EXISTS `temperatura` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `temperatura` float NOT NULL,
  `data_hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` bigint(20) NOT NULL,
  `area_frigorifica_id` int(11) NOT NULL,
  `assinado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `temperatura_fk1` (`user_id`),
  KEY `FK_temperatura_area_frigorifica` (`area_frigorifica_id`),
  CONSTRAINT `FK_temperatura_area_frigorifica` FOREIGN KEY (`area_frigorifica_id`) REFERENCES `area_frigorifica` (`numero`),
  CONSTRAINT `temperatura_fk1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(1) NOT NULL,
  `nome` varchar(512) NOT NULL,
  `num_interno` bigint(20) NOT NULL,
  `password` varchar(512) NOT NULL,
  `email` varchar(512) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  `token_cration` datetime DEFAULT NULL,
  `token_expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `num_interno` (`num_interno`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table msmDB.validade
CREATE TABLE IF NOT EXISTS `validade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ean` varchar(50) NOT NULL DEFAULT '-1',
  `validade` date NOT NULL DEFAULT current_timestamp(),
  `n_interno` bigint(20) NOT NULL,
  `nome` varchar(512) NOT NULL,
  `offset` int(11) NOT NULL DEFAULT 20,
  `markdown` tinyint(1) NOT NULL DEFAULT 0,
  `produto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `validade_fk1` (`produto_id`),
  KEY `Index 3` (`n_interno`),
  CONSTRAINT `FK_validade_produto` FOREIGN KEY (`n_interno`) REFERENCES `produto` (`n_interno`),
  CONSTRAINT `validade_fk1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
