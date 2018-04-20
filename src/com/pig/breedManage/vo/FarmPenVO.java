package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_farm_pen")
public class FarmPenVO {
   @Name
   @Column
   private String penId;
   @Column
   private String penName;
   @Column
   private String penCode;
   @Column
   private String companyId;
   @Column
   private String farmId;
   @Column
   private String penTypeId;
   @Column
   private int penRailing;
   @Column
   private int maxVolume;
   @Column
   private double penWidth;
   @Column
   private double penHeight;
   @Column
   private Date createTime;
   @Column
   private int sucklingNum;//乳猪数量
   @Column
   private double sucklingWeight;//乳猪总重量
   @Column
   private int fattenNum;//育肥数量
   @Column
   private double fattenWeight;
   @Column
   private int conservationNum;//保育数量
   @Column
   private double conservationWeight;

   //养殖场id关联养殖场
   @One(target = FarmVO.class, field = "farmId", key = "farmId")
   protected FarmVO farmVO;

   //养殖场类型id关联养殖场类型表
   @One(target = FarmPenTypeVO.class, field = "penTypeId", key = "penTypeId")
   protected FarmPenTypeVO farmPenTypeVO;

   public String getPenId() {
      return penId;
   }

   public void setPenId(String penId) {
      this.penId = penId;
   }

   public String getPenName() {
      return penName;
   }

   public void setPenName(String penName) {
      this.penName = penName;
   }

   public String getPenCode() {
      return penCode;
   }

   public void setPenCode(String penCode) {
      this.penCode = penCode;
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

   public String getPenTypeId() {
      return penTypeId;
   }

   public void setPenTypeId(String penTypeId) {
      this.penTypeId = penTypeId;
   }

   public int getPenRailing() {
      return penRailing;
   }

   public void setPenRailing(int penRailing) {
      this.penRailing = penRailing;
   }

   public int getMaxVolume() {
      return maxVolume;
   }

   public void setMaxVolume(int maxVolume) {
      this.maxVolume = maxVolume;
   }

   public double getPenWidth() {
      return penWidth;
   }

   public void setPenWidth(double penWidth) {
      this.penWidth = penWidth;
   }

   public double getPenHeight() {
      return penHeight;
   }

   public void setPenHeight(double penHeight) {
      this.penHeight = penHeight;
   }

   public Date getCreateTime() {
      return createTime;
   }

   public void setCreateTime(Date createTime) {
      this.createTime = createTime;
   }

   public FarmVO getFarmVO() {
      return farmVO;
   }

   public void setFarmVO(FarmVO farmVO) {
      this.farmVO = farmVO;
   }

   public FarmPenTypeVO getFarmPenTypeVO() {
      return farmPenTypeVO;
   }

   public void setFarmPenTypeVO(FarmPenTypeVO farmPenTypeVO) {
      this.farmPenTypeVO = farmPenTypeVO;
   }

   public int getSucklingNum() {
      return sucklingNum;
   }

   public void setSucklingNum(int sucklingNum) {
      this.sucklingNum = sucklingNum;
   }

   public double getSucklingWeight() {
      return sucklingWeight;
   }

   public void setSucklingWeight(double sucklingWeight) {
      this.sucklingWeight = sucklingWeight;
   }

   public int getFattenNum() {
      return fattenNum;
   }

   public void setFattenNum(int fattenNum) {
      this.fattenNum = fattenNum;
   }

   public double getFattenWeight() {
      return fattenWeight;
   }

   public void setFattenWeight(double fattenWeight) {
      this.fattenWeight = fattenWeight;
   }

   public int getConservationNum() {
      return conservationNum;
   }

   public void setConservationNum(int conservationNum) {
      this.conservationNum = conservationNum;
   }

   public double getConservationWeight() {
      return conservationWeight;
   }

   public void setConservationWeight(double conservationWeight) {
      this.conservationWeight = conservationWeight;
   }

}
