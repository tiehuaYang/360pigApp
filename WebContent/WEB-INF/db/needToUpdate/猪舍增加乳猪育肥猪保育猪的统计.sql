ALTER TABLE `cd_breed_farm_pen`
ADD COLUMN `sucklingNum`  INT(10) NULL AFTER `createTime`,
ADD COLUMN `sucklingWeight`  decimal(10,2) NULL AFTER `sucklingNum`,
ADD COLUMN `fattenNum`  INT(10) NULL AFTER `sucklingWeight`,
ADD COLUMN `fattenWeight`  decimal(10,2) NULL AFTER `fattenNum`,
ADD COLUMN `conservationNum`  INT(10) NULL AFTER `fattenWeight`,
ADD COLUMN `conservationWeight`  decimal(10,2) NULL AFTER `conservationNum`;