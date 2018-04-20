package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_mating_pair")
public class PigMatingPairVO {
   @Name
   @Column
   private String pairId; //配对记录的Id
   @Column
   private String matingId; //配种记录Id
   @Column
   private String femalePigsId; //母猪Id
   @Column
   private String malePigsId; //公猪Id
   @Column
   private String spermId; //外购精液Id
   @Column
   private int pairType; //以哪种方式配种（1.公猪 2.外购精液）
   @Column
   private String finalResult; //配对的结果
   @Column
   private Date matingDate; //配种日期
   @Column
   private String femaleState;//配种前母猪状态
   @Column
   private String maleState;//配种前公猪状态
   @Column
   private Date femaleLastDate;//配种前母猪最近事件时间
   @Column
   private Date maleLastDate;//配种前公猪最近事件时间

   //配种记录
   @One(target = PigMatingVO.class, field = "matingId", key = "matingId")
   protected PigMatingVO PigMatingVO;

   //母猪
   @One(target = PigsVO.class, field = "femalePigsId", key = "pigsId")
   protected PigsVO femalePigsVO;

   //公猪
   @One(target = PigsVO.class, field = "malePigsId", key = "pigsId")
   protected PigsVO malePigsVO;

   public String getPairId() {
      return pairId;
   }

   public void setPairId(String pairId) {
      this.pairId = pairId;
   }

   public String getMatingId() {
      return matingId;
   }

   public void setMatingId(String matingId) {
      this.matingId = matingId;
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

   public Date getMatingDate() {
      return matingDate;
   }

   public void setMatingDate(Date matingDate) {
      this.matingDate = matingDate;
   }

   public PigMatingVO getPigMatingVO() {
      return PigMatingVO;
   }

   public void setPigMatingVO(PigMatingVO pigMatingVO) {
      PigMatingVO = pigMatingVO;
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

   public String getFemaleState() {
      return femaleState;
   }

   public void setFemaleState(String femaleState) {
      this.femaleState = femaleState;
   }

   public String getMaleState() {
      return maleState;
   }

   public void setMaleState(String maleState) {
      this.maleState = maleState;
   }

   public Date getFemaleLastDate() {
      return femaleLastDate;
   }

   public void setFemaleLastDate(Date femaleLastDate) {
      this.femaleLastDate = femaleLastDate;
   }

   public Date getMaleLastDate() {
      return maleLastDate;
   }

   public void setMaleLastDate(Date maleLastDate) {
      this.maleLastDate = maleLastDate;
   }

}
