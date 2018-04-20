package com.pig.joinInManage.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_breed_goods")
public class GoodsVO {
   @Name
   @Column
   private String goodId;//物料Id
   @Column
   private String goodName;//物料名称
   @Column
   private String supplierId;//供应商Id
   @Column
   private String pigType;//猪只类型 0.全部/1.种猪/2.肉猪
   @Column
   private String stage;//饲料阶段 0.怀孕料/1.哺乳料/2.后备料/3.空怀料/4.公猪料
   @Column
   private String type;//物料类型 0.饲料/1.兽药2.疫苗/3.猪只精液
   @Column
   private String isUsing;//使用状态
   @Column
   private String isDelete;//是否删除
   @Column
   private String companyId;//企业Id
   @Column
   private String farmId;//猪场Id
   
 //商品和库存一对一
   @One(target = SupplierVO.class, field = "supplierId", key = "supplierId")
   protected SupplierVO supplierVO;
   
   public String getGoodId() {
      return goodId;
   }
   public void setGoodId(String goodId) {
      this.goodId = goodId;
   }
   public String getGoodName() {
      return goodName;
   }
   public void setGoodName(String goodName) {
      this.goodName = goodName;
   }
   public String getSupplierId() {
      return supplierId;
   }
   public void setSupplierId(String supplierId) {
      this.supplierId = supplierId;
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
   public String getPigType() {
      return pigType;
   }
   public void setPigType(String pigType) {
      this.pigType = pigType;
   }
   public String getStage() {
      return stage;
   }
   public void setStage(String stage) {
      this.stage = stage;
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
   public SupplierVO getSupplierVO() {
      return supplierVO;
   }
   public void setSupplierVO(SupplierVO supplierVO) {
      this.supplierVO = supplierVO;
   }
   
}
