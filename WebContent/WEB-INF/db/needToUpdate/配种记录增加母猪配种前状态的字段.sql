ALTER TABLE `cd_breed_pig_mating_pair`
ADD COLUMN `femaleState`  varchar(50) NULL COMMENT '配种前母猪状态' AFTER `matingDate`;

ALTER TABLE `pig`.`cd_breed_pig_mating_pair`   
  ADD COLUMN `maleState` VARCHAR(50) NULL  COMMENT '配种前公猪状态' AFTER `femaleState`,
  ADD COLUMN `femaleLastDate` DATETIME NULL  COMMENT '配种前母猪最近事件时间' AFTER `maleState`,
  ADD COLUMN `maleLastDate` DATETIME NULL  COMMENT '配种前公猪最近事件时间' AFTER `femaleLastDate`;