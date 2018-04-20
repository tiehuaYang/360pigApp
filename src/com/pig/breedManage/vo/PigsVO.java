package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pigs")
public class PigsVO {
   @Name
   @Column
   private String pigsId;//猪只Id
   @Column
   private String companyId;//公司Id
   @Column
   private String earTag;//猪耳标
   @Column
   private String categoryId;//猪品
   @Column
   private String strainId;//猪系
   @Column
   private Date birthday;//出生日期
   @Column
   private Date admissionDate;//入场日期
   @Column
   private String farmId;//所在猪场
   @Column
   private String penId;//所在猪舍
   @Column
   private int childbirthTimes;//分娩次数
   @Column
   private String sexType;//猪只类型：0.公猪、1.母猪、2.公仔猪、3.母仔猪
   @Column
   private String state;//当前状态
   @Column
   private String sourceType;//来源类型
   @Column
   private Date lastDate;//最近活动日期
   @Column
   private String lastEvent;//最近活动
   @Column
   private String flowId; //从配种-妊检-分娩的流程Id 针对母猪
   @Column
   private String isExit;//是否离开

   private int dayCount;//状态对应的天数

   private Date preChildbirthDate;//预产期

   //养殖舍
   @One(target = FarmPenVO.class, field = "penId", key = "penId")
   protected FarmPenVO farmPenVO;

   //品类
   @One(target = PigCategoryVO.class, field = "categoryId", key = "categoryId")
   protected PigCategoryVO pigCategoryVO;

   //养殖场
   @One(target = FarmVO.class, field = "farmId", key = "farmId")
   protected FarmVO farmVO;

   //品系
   @One(target = PigStrainVO.class, field = "strainId", key = "strainId")
   protected PigStrainVO pigStrainVO;

   public String getPigsId() {
      return pigsId;
   }

   public void setPigsId(String pigsId) {
      this.pigsId = pigsId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getEarTag() {
      return earTag;
   }

   public void setEarTag(String earTag) {
      this.earTag = earTag;
   }

   public String getCategoryId() {
      return categoryId;
   }

   public void setCategoryId(String categoryId) {
      this.categoryId = categoryId;
   }

   public String getStrainId() {
      return strainId;
   }

   public void setStrainId(String strainId) {
      this.strainId = strainId;
   }

   public Date getBirthday() {
      return birthday;
   }

   public void setBirthday(Date birthday) {
      this.birthday = birthday;
   }

   public Date getAdmissionDate() {
      return admissionDate;
   }

   public void setAdmissionDate(Date admissionDate) {
      this.admissionDate = admissionDate;
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

   public int getChildbirthTimes() {
      return childbirthTimes;
   }

   public void setChildbirthTimes(int childbirthTimes) {
      this.childbirthTimes = childbirthTimes;
   }

   public String getSexType() {
      return sexType;
   }

   public void setSexType(String sexType) {
      this.sexType = sexType;
   }

   public String getState() {
      return state;
   }

   public void setState(String state) {
      this.state = state;
   }

   public String getSourceType() {
      return sourceType;
   }

   public void setSourceType(String sourceType) {
      this.sourceType = sourceType;
   }

   public Date getLastDate() {
      return lastDate;
   }

   public void setLastDate(Date lastDate) {
      this.lastDate = lastDate;
   }

   public String getLastEvent() {
      return lastEvent;
   }

   public void setLastEvent(String lastEvent) {
      this.lastEvent = lastEvent;
   }

   public String getFlowId() {
      return flowId;
   }

   public void setFlowId(String flowId) {
      this.flowId = flowId;
   }

   public String getIsExit() {
      return isExit;
   }

   public void setIsExit(String isExit) {
      this.isExit = isExit;
   }

   public int getDayCount() {
      return dayCount;
   }

   public void setDayCount(int dayCount) {
      this.dayCount = dayCount;
   }

   public Date getPreChildbirthDate() {
      return preChildbirthDate;
   }

   public void setPreChildbirthDate(Date preChildbirthDate) {
      this.preChildbirthDate = preChildbirthDate;
   }

   public FarmPenVO getFarmPenVO() {
      return farmPenVO;
   }

   public void setFarmPenVO(FarmPenVO farmPenVO) {
      this.farmPenVO = farmPenVO;
   }

   public PigCategoryVO getPigCategoryVO() {
      return pigCategoryVO;
   }

   public void setPigCategoryVO(PigCategoryVO pigCategoryVO) {
      this.pigCategoryVO = pigCategoryVO;
   }

   public FarmVO getFarmVO() {
      return farmVO;
   }

   public void setFarmVO(FarmVO farmVO) {
      this.farmVO = farmVO;
   }

   public PigStrainVO getPigStrainVO() {
      return pigStrainVO;
   }

   public void setPigStrainVO(PigStrainVO pigStrainVO) {
      this.pigStrainVO = pigStrainVO;
   }

}
