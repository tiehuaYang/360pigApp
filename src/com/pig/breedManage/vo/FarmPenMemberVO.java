package com.pig.breedManage.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import com.pig.authority.vo.UserVO;

@Table("cd_breed_farm_pen_member")
public class FarmPenMemberVO {
   @Name
   @Column
   private String id;
   @Column
   private String penId;
   @Column
   private String userId;
   @Column
   private int memberType;
   @Column
   private Date createTime;

   @One(target = UserVO.class, field = "userId", key = "userId")
   protected UserVO userVO;

   private String memberTypeStr;

   public String getId() {
      return id;
   }

   public void setId(String id) {
      this.id = id;
   }

   public String getPenId() {
      return penId;
   }

   public void setPenId(String penId) {
      this.penId = penId;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public int getMemberType() {
      return memberType;
   }

   public void setMemberType(int memberType) {
      this.memberType = memberType;
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

   public String getMemberTypeStr() {
      return memberTypeStr;
   }

   public void setMemberTypeStr(String memberTypeStr) {
      this.memberTypeStr = memberTypeStr;
   }

}
