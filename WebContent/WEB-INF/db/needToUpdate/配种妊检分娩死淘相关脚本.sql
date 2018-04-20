ALTER TABLE `pig`.`cd_breed_pig_mating`   
  ADD COLUMN `flowId` VARCHAR(50) NULL AFTER `penId`;
  
ALTER TABLE `pig`.`cd_breed_pig_mating_pair`   
  ADD COLUMN `finalResult` VARCHAR(2) NULL AFTER `pairType`;

ALTER TABLE `pig`.`cd_breed_pig_mating`   
  ADD COLUMN `createDate` DATETIME NULL AFTER `flowId`;

ALTER TABLE `pig`.`cd_breed_pig_mating`   
  ADD COLUMN `femalePigsId` VARCHAR(50) NULL AFTER `penId`;

ALTER TABLE `pig`.`cd_breed_pigs`   
  ADD COLUMN `flowId` VARCHAR(50) NULL AFTER `lastEvent`;

 
CREATE TABLE `pig`.`cd_breed_pig_pregnancy`(  
  `pregnancyId` VARCHAR(50) NOT NULL,
  `companyId` VARCHAR(50),
  `farmId` VARCHAR(50),
  `penId` VARCHAR(50),
  `flowId` VARCHAR(50),
  `femalePigsId` VARCHAR(50),
  `malePigsId` VARCHAR(50),
  `spermId` VARCHAR(50),
  `pairType` INT(2),
  `finalResult` VARCHAR(2),
  `pregnancyDate` DATETIME,
  `remark` VARCHAR(200),
  PRIMARY KEY (`pregnancyId`)
) CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `pig`.`cd_breed_pig_pregnancy`   
  ADD COLUMN `matingId` VARCHAR(50) NULL AFTER `penId`,
  ADD COLUMN `pairId` VARCHAR(50) NULL AFTER `matingId`;
  
 ALTER TABLE `pig`.`cd_breed_pig_pregnancy` 
  ADD COLUMN `lastEventDate` DATETIME NULL AFTER `pregnancyDate`; 

CREATE TABLE `cd_breed_pig_childbirth` (
  `childbirthId` VARCHAR(50) NOT NULL,
  `companyId` VARCHAR(50) DEFAULT NULL,
  `farmId` VARCHAR(50) DEFAULT NULL,
  `penId` VARCHAR(50) DEFAULT NULL,
  `matingId` VARCHAR(50) DEFAULT NULL,
  `pairId` VARCHAR(50) DEFAULT NULL,
  `flowId` VARCHAR(50) DEFAULT NULL,
  `femalePigsId` VARCHAR(50) DEFAULT NULL,
  `malePigsId` VARCHAR(50) DEFAULT NULL,
  `spermId` VARCHAR(50) DEFAULT NULL,
  `pairType` INT(2) DEFAULT NULL,
  `totalChild` VARCHAR(5) DEFAULT NULL,
  `totalChildWeight` VARCHAR(5) DEFAULT NULL,
  `childbirthDate` DATETIME DEFAULT NULL,
  `lastEventDate` DATETIME DEFAULT NULL,
  `remark` VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (`childbirthId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8

ALTER TABLE `pig`.`cd_breed_pig_childbirth`   
  ADD COLUMN `matingDate` DATETIME NULL AFTER `lastEventDate`;
  
ALTER TABLE `pig`.`cd_breed_pig_pregnancy`   
  ADD COLUMN `state` VARCHAR(2) NULL AFTER `pregnancyDate`;

  
CREATE TABLE `pig`.`cd_breed_pig_death`(  
  `deathId` VARCHAR(50) NOT NULL,
  `companyId` VARCHAR(50),
  `farmId` VARCHAR(50),
  `penId` VARCHAR(50),
  `pigsId` VARCHAR(50),
  `deathType` VARCHAR(2),
  `deathReason` VARCHAR(200),
  `deathDate` DATETIME,
  `remark` VARCHAR(200),
  PRIMARY KEY (`deathId`)
) CHARSET=utf8 COLLATE=utf8_general_ci;
