package com.pig.breedManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_strain")
public class PigStrainVO {
   @Name
   @Column
   private String strainId;//猪系Id
   @Column
   private String companyId;//公司Id
   @Column
   private String categoryId;//猪品Id
   @Column
   private String strainName;//猪系名称
   @Column
   private int level;//排序值

   //品系对应品类
   @One(target = PigCategoryVO.class, field = "categoryId", key = "categoryId")
   protected PigCategoryVO pigCategoryVO;

   public String getStrainId() {
      return strainId;
   }

   public void setStrainId(String strainId) {
      this.strainId = strainId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getCategoryId() {
      return categoryId;
   }

   public void setCategoryId(String categoryId) {
      this.categoryId = categoryId;
   }

   public String getStrainName() {
      return strainName;
   }

   public void setStrainName(String strainName) {
      this.strainName = strainName;
   }

   public int getLevel() {
      return level;
   }

   public void setLevel(int level) {
      this.level = level;
   }

   public PigCategoryVO getPigCategoryVO() {
      return pigCategoryVO;
   }

   public void setPigCategoryVO(PigCategoryVO pigCategoryVO) {
      this.pigCategoryVO = pigCategoryVO;
   }

}
