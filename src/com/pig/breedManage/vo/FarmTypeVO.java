package com.pig.breedManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_farm_type")
public class FarmTypeVO {
   @Name
   @Column
   private String farmTypeId; //养殖场类型ID
   @Column
   private String farmTypeName;//养殖场类型名称
   @Column
   private int level; //养殖场类型排序

   public String getFarmTypeId() {
      return farmTypeId;
   }

   public void setFarmTypeId(String farmTypeId) {
      this.farmTypeId = farmTypeId;
   }

   public String getFarmTypeName() {
      return farmTypeName;
   }

   public void setFarmTypeName(String farmTypeName) {
      this.farmTypeName = farmTypeName;
   }

   public int getLevel() {
      return level;
   }

   public void setLevel(int level) {
      this.level = level;
   }

}
