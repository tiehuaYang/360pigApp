package com.pig.joinInManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_supplier")
public class SupplierVO {
   @Name
   @Column
   private String supplierId;//供应商Id
   @Column
   private String supplierName;//供应商名称
   @Column
   private String contactsName;//联系人
   @Column
   private String contactsNum;//联系电话
   @Column
   private String type;//供应类别 0.饲料/1.兽药2.疫苗/3.猪只精液/4.其他
   @Column
   private String isUsing;//使用状态 0.开启/1.关闭
   @Column
   private String remarks;//备注
   @Column
   private String isDelete;//是否删除
   @Column
   private String companyId;//企业Id
   @Column
   private String farmId;//猪场Id
   
   public String getSupplierId() {
      return supplierId;
   }
   public void setSupplierId(String supplierId) {
      this.supplierId = supplierId;
   }
   public String getSupplierName() {
      return supplierName;
   }
   public void setSupplierName(String supplierName) {
      this.supplierName = supplierName;
   }
   public String getContactsName() {
      return contactsName;
   }
   public void setContactsName(String contactsName) {
      this.contactsName = contactsName;
   }
   public String getContactsNum() {
      return contactsNum;
   }
   public void setContactsNum(String contactsNum) {
      this.contactsNum = contactsNum;
   }
   public String getType() {
      return type;
   }
   public void setType(String type) {
      this.type = type;
   }
   public String getIsUsing() {
      return isUsing;
   }
   public void setIsUsing(String isUsing) {
      this.isUsing = isUsing;
   }
   public String getRemarks() {
      return remarks;
   }
   public void setRemarks(String remarks) {
      this.remarks = remarks;
   }
   public String getIsDelete() {
      return isDelete;
   }
   public void setIsDelete(String isDelete) {
      this.isDelete = isDelete;
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
   
}
