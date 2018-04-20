ALTER TABLE `cd_breed_pigs`
ADD COLUMN `isExit`  varchar(50) NULL COMMENT '是否离场' AFTER `lastEvent`;

UPDATE cd_breed_pigs set isExit = "N";

ALTER TABLE cd_breed_pigs MODIFY sexType varchar(50);
ALTER TABLE cd_breed_pigs MODIFY state varchar(50);
ALTER TABLE cd_breed_pigs MODIFY sourceType varchar(50);
ALTER TABLE cd_breed_pigs MODIFY lastEvent varchar(50);