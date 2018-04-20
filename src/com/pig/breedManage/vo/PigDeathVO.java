package com.pig.breedManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_death")
public class PigDeathVO {
   @Name
   @Column
   private String deathId; //死淘记录Id
   @Column
   private String companyId; //公司Id
   @Column
   private String farmId; //养殖场Id
   @Column
   private String penId; //养殖舍Id
   @Column
   private String pigsId; //种猪Id
   @Column
   private String deathType; //死淘类型（1.死亡 2.淘汰 3.其他）
   @Column
   private String deathReason; //死淘原因 （直接存中文）
   @Column
   private String deathDate; //离场日期
   @Column
   private String remark; //备注

   //养殖场
   @One(target = FarmVO.class, field = "farmId", key = "farmId")
   protected FarmVO farmVO;

   //养殖舍
   @One(target = FarmPenVO.class, field = "penId", key = "penId")
   protected FarmPenVO farmPenVO;

   //公母猪
   @One(target = PigsVO.class, field = "pigsId", key = "pigsId")
   protected PigsVO pigsVO;

   public String getDeathId() {
      return deathId;
   }

   public void setDeathId(String deathId) {
      this.deathId = deathId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getFarmId() {
      return farmId;
   }

   public void setFarmId(String farmId) {
      this.farmId = farmId;
   }

   public String getPenId() {
      return penId;
   }

   public void setPenId(String penId) {
      this.penId = penId;
   }

   public String getPigsId() {
      return pigsId;
   }

   public void setPigsId(String pigsId) {
      this.pigsId = pigsId;
   }

   public String getDeathType() {
      return deathType;
   }

   public void setDeathType(String deathType) {
      this.deathType = deathType;
   }

   public String getDeathReason() {
      return deathReason;
   }

   public void setDeathReason(String deathReason) {
      this.deathReason = deathReason;
   }

   public String getDeathDate() {
      return deathDate;
   }

   public void setDeathDate(String deathDate) {
      this.deathDate = deathDate;
   }

   public String getRemark() {
      return remark;
   }

   public void setRemark(String remark) {
      this.remark = remark;
   }

   public FarmVO getFarmVO() {
      return farmVO;
   }

   public void setFarmVO(FarmVO farmVO) {
      this.farmVO = farmVO;
   }

   public FarmPenVO getFarmPenVO() {
      return farmPenVO;
   }

   public void setFarmPenVO(FarmPenVO farmPenVO) {
      this.farmPenVO = farmPenVO;
   }

   public PigsVO getPigsVO() {
      return pigsVO;
   }

   public void setPigsVO(PigsVO pigsVO) {
      this.pigsVO = pigsVO;
   }

}
