package com.pig.breedManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_category")
public class PigCategoryVO {
   @Name
   @Column
   private String categoryId;//猪品Id
   @Column
   private String companyId;//公司Id
   @Column
   private String categoryName;//猪品名称
   @Column
   private int level;//排序值

   public String getCategoryId() {
      return categoryId;
   }

   public void setCategoryId(String categoryId) {
      this.categoryId = categoryId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getCategoryName() {
      return categoryName;
   }

   public void setCategoryName(String categoryName) {
      this.categoryName = categoryName;
   }

   public int getLevel() {
      return level;
   }

   public void setLevel(int level) {
      this.level = level;
   }

}
