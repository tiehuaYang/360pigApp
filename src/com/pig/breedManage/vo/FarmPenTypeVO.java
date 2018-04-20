package com.pig.breedManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_farm_pen_type")
public class FarmPenTypeVO {
   @Name
   @Column
   private String penTypeId;
   @Column
   private String penTypeName;
   @Column
   private int level;
   @Column
   private String farmTypeId;

   public String getPenTypeId() {
      return penTypeId;
   }

   public void setPenTypeId(String penTypeId) {
      this.penTypeId = penTypeId;
   }

   public String getPenTypeName() {
      return penTypeName;
   }

   public void setPenTypeName(String penTypeName) {
      this.penTypeName = penTypeName;
   }

   public int getLevel() {
      return level;
   }

   public void setLevel(int level) {
      this.level = level;
   }

   public String getFarmTypeId() {
      return farmTypeId;
   }

   public void setFarmTypeId(String farmTypeId) {
      this.farmTypeId = farmTypeId;
   }

}
