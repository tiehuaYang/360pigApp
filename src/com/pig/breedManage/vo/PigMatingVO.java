package com.pig.breedManage.vo;

import java.util.Date;
import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Many;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_pig_mating")
public class PigMatingVO {
   @Name
   @Column
   private String matingId; //配种记录Id
   @Column
   private String companyId; //公司Id
   @Column
   private String farmId; //养殖场Id
   @Column
   private String penId; //养殖舍Id
   @Column
   private String femalePigsId; //母猪Id
   @Column
   private String flowId; //从配种-妊检-分娩的流程Id
   @Column
   private Date createDate; //创建时间
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

   //配对的公猪
   @Many(target = PigMatingPairVO.class, field = "matingId", key = "matingId")
   protected List<PigMatingPairVO> pigMatingPairList;

   public String getMatingId() {
      return matingId;
   }

   public void setMatingId(String matingId) {
      this.matingId = matingId;
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

   public String getFemalePigsId() {
      return femalePigsId;
   }

   public void setFemalePigsId(String femalePigsId) {
      this.femalePigsId = femalePigsId;
   }

   public String getFlowId() {
      return flowId;
   }

   public void setFlowId(String flowId) {
      this.flowId = flowId;
   }

   public Date getCreateDate() {
      return createDate;
   }

   public void setCreateDate(Date createDate) {
      this.createDate = createDate;
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

   public List<PigMatingPairVO> getPigMatingPairList() {
      return pigMatingPairList;
   }

   public void setPigMatingPairList(List<PigMatingPairVO> pigMatingPairList) {
      this.pigMatingPairList = pigMatingPairList;
   }

}
