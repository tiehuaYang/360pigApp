package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import com.pig.authority.vo.UserVO;

@Table("cd_breed_farm")
public class FarmVO {
   @Name
   @Column
   private String farmId; //养殖场ID
   @Column
   private String companyId;//企业ID
   @Column
   private String farmName; //养殖场名称
   @Column
   private String farmCode;//养殖场编码
   @Column
   private String farmAddress;//养殖场地址
   @Column
   private String farmTypeId;//养殖场类型Id 0.育肥猪场/1.二元猪场/2.种猪场/3.商品猪场
   @Column
   private String farmManager;//养殖场负责人
   @Column
   private Date createTime;
   @Column
   private String province;//省份
   @Column
   private String phoneNum;//手机号码
   @Column
   private String email;//邮箱

   //养殖场负责人对应用户 
   @One(target = UserVO.class, field = "farmManager", key = "userId")
   protected UserVO userVO;

   //养殖场类型对应养殖场类型表
   @One(target = FarmTypeVO.class, field = "farmTypeId", key = "farmTypeId")
   protected FarmTypeVO farmTypeVO;

   public String getFarmId() {
      return farmId;
   }

   public void setFarmId(String farmId) {
      this.farmId = farmId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getFarmName() {
      return farmName;
   }

   public void setFarmName(String farmName) {
      this.farmName = farmName;
   }

   public String getFarmCode() {
      return farmCode;
   }

   public void setFarmCode(String farmCode) {
      this.farmCode = farmCode;
   }

   public String getFarmAddress() {
      return farmAddress;
   }

   public void setFarmAddress(String farmAddress) {
      this.farmAddress = farmAddress;
   }

   public String getFarmTypeId() {
      return farmTypeId;
   }

   public void setFarmTypeId(String farmTypeId) {
      this.farmTypeId = farmTypeId;
   }

   public String getFarmManager() {
      return farmManager;
   }

   public void setFarmManager(String farmManager) {
      this.farmManager = farmManager;
   }

   public Date getCreateTime() {
      return createTime;
   }

   public void setCreateTime(Date createTime) {
      this.createTime = createTime;
   }

   public UserVO getUserVO() {
      return userVO;
   }

   public void setUserVO(UserVO userVO) {
      this.userVO = userVO;
   }

   public FarmTypeVO getFarmTypeVO() {
      return farmTypeVO;
   }

   public void setFarmTypeVO(FarmTypeVO farmTypeVO) {
      this.farmTypeVO = farmTypeVO;
   }

   public String getProvince() {
      return province;
   }

   public void setProvince(String province) {
      this.province = province;
   }

   public String getPhoneNum() {
      return phoneNum;
   }

   public void setPhoneNum(String phoneNum) {
      this.phoneNum = phoneNum;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

}
