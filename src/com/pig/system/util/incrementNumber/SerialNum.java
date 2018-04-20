package com.pig.system.util.incrementNumber;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_table_key")
public class SerialNum {
   @Name
   @Column
   private String keyId;
   @Column
   private String companyId;
   @Column
   private String type;
   @Column
   private Date updateTime;
   @Column
   private Date createTime;
   @Column
   private int maxNum;

   public String getKeyId() {
      return keyId;
   }

   public void setKeyId(String keyId) {
      this.keyId = keyId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getType() {
      return type;
   }

   public void setType(String type) {
      this.type = type;
   }

   public Date getUpdateTime() {
      return updateTime;
   }

   public void setUpdateTime(Date updateTime) {
      this.updateTime = updateTime;
   }

   public Date getCreateTime() {
      return createTime;
   }

   public void setCreateTime(Date createTime) {
      this.createTime = createTime;
   }

   public int getMaxNum() {
      return maxNum;
   }

   public void setMaxNum(int maxNum) {
      this.maxNum = maxNum;
   }

}
