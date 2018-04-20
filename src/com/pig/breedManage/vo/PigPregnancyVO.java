package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_pregnancy")
public class PigPregnancyVO {
   @Name
   @Column
   private String pregnancyId; //妊检记录Id
   @Column
   private String companyId; //公司Id
   @Column
   private String farmId; //养殖场Id
   @Column
   private String penId; //养殖舍Id
   @Column
   private String matingId; //配种记录Id
   @Column
   private String pairId; //配对记录的Id
   @Column
   private String flowId; //从配种-妊检-分娩的流程Id
   @Column
   private String femalePigsId; //母猪Id
   @Column
   private String malePigsId; //公猪Id
   @Column
   private String spermId; //外购精液Id
   @Column
   private int pairType; //以哪种方式配种（1.公猪 2.外购精液）
   @Column
   private String finalResult; //妊检的结果
   @Column
   private Date pregnancyDate; //妊检时间
   @Column
   private String state; //妊检记录状态（0:有效 1:失效无法修改）
   @Column
   private Date lastEventDate; //妊检前母猪的状态时间（用于回滚）
   @Column
   private String remark; //备注

   //养殖场
   @One(target = FarmVO.class, field = "farmId", key = "farmId")
   protected FarmVO farmVO;

   //养殖舍
   @One(target = FarmPenVO.class, field = "penId", key = "penId")
   protected FarmPenVO farmPenVO;

   //母猪
   @One(target = PigsVO.class, field = "femalePigsId", key = "pigsId")
   protected PigsVO femalePigsVO;

   //公猪
   @One(target = PigsVO.class, field = "malePigsId", key = "pigsId")
   protected PigsVO malePigsVO;

   public String getPregnancyId() {
      return pregnancyId;
   }

   public void setPregnancyId(String pregnancyId) {
      this.pregnancyId = pregnancyId;
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

   public String getMatingId() {
      return matingId;
   }

   public void setMatingId(String matingId) {
      this.matingId = matingId;
   }

   public String getPairId() {
      return pairId;
   }

   public void setPairId(String pairId) {
      this.pairId = pairId;
   }

   public String getFlowId() {
      return flowId;
   }

   public void setFlowId(String flowId) {
      this.flowId = flowId;
   }

   public String getFemalePigsId() {
      return femalePigsId;
   }

   public void setFemalePigsId(String femalePigsId) {
      this.femalePigsId = femalePigsId;
   }

   public String getMalePigsId() {
      return malePigsId;
   }

   public void setMalePigsId(String malePigsId) {
      this.malePigsId = malePigsId;
   }

   public String getSpermId() {
      return spermId;
   }

   public void setSpermId(String spermId) {
      this.spermId = spermId;
   }

   public int getPairType() {
      return pairType;
   }

   public void setPairType(int pairType) {
      this.pairType = pairType;
   }

   public String getFinalResult() {
      return finalResult;
   }

   public void setFinalResult(String finalResult) {
      this.finalResult = finalResult;
   }

   public Date getPregnancyDate() {
      return pregnancyDate;
   }

   public void setPregnancyDate(Date pregnancyDate) {
      this.pregnancyDate = pregnancyDate;
   }

   public String getState() {
      return state;
   }

   public void setState(String state) {
      this.state = state;
   }

   public Date getLastEventDate() {
      return lastEventDate;
   }

   public void setLastEventDate(Date lastEventDate) {
      this.lastEventDate = lastEventDate;
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

   public PigsVO getFemalePigsVO() {
      return femalePigsVO;
   }

   public void setFemalePigsVO(PigsVO femalePigsVO) {
      this.femalePigsVO = femalePigsVO;
   }

   public PigsVO getMalePigsVO() {
      return malePigsVO;
   }

   public void setMalePigsVO(PigsVO malePigsVO) {
      this.malePigsVO = malePigsVO;
   }

}
