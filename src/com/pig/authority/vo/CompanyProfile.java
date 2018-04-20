package com.pig.authority.vo;

import java.io.Serializable;

import org.nutz.dao.entity.annotation.ColDefine;
import org.nutz.dao.entity.annotation.ColType;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import com.pig.system.vo.PictureVO;

@Table("cd_auth_companyProfile")
public class CompanyProfile implements Serializable {
   private static final long serialVersionUID = -8217588782984213290L;

   /** 关联的企业id */
   @Name
   @Column
   protected String companyId;
   @Column
   private String companyName;//企业名称
   @Column
   private String userType;//企业类型：供应商、经销商
   @Column
   private String companyCode;//企业编码
   @Column
   private String contactName;//联系人名称
   @Column
   private String contactPhone;//联系人电话
   @Column
   private String contactPost;//联系人职位
   @Column
   private String contactQQ;//联系人qq
   @Column
   private String contactEmail;//联系人邮箱
   @Column
   private String province;
   @Column
   private String city;
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 100)
   private String address;
   @Column
   private String zipCode;//邮编
   @Column
   private String phone;//电话
   @Column
   private String tax;//传真
   @Column
   private String mainPage;//网址
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 500)
   private String remark;//公司介绍
   @Column
   private String taxesRemark;//纳税人识别号
   @Column
   private String invoiceTitle;//发票抬头
   @Column
   private String isBreedInit;//是否初始化养殖平台

   @One(target = PictureVO.class, field = "companyId", key = "picUuid")
   private PictureVO pictureVO;//放置logo

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getUserType() {
      return userType;
   }

   public void setUserType(String userType) {
      this.userType = userType;
   }

   public String getCompanyName() {
      return companyName;
   }

   public void setCompanyName(String companyName) {
      this.companyName = companyName;
   }

   public String getCompanyCode() {
      return companyCode;
   }

   public void setCompanyCode(String companyCode) {
      this.companyCode = companyCode;
   }

   public String getContactName() {
      return contactName;
   }

   public void setContactName(String contactName) {
      this.contactName = contactName;
   }

   public String getContactPhone() {
      return contactPhone;
   }

   public void setContactPhone(String contactPhone) {
      this.contactPhone = contactPhone;
   }

   public String getContactPost() {
      return contactPost;
   }

   public void setContactPost(String contactPost) {
      this.contactPost = contactPost;
   }

   public String getContactQQ() {
      return contactQQ;
   }

   public void setContactQQ(String contactQQ) {
      this.contactQQ = contactQQ;
   }

   public String getContactEmail() {
      return contactEmail;
   }

   public void setContactEmail(String contactEmail) {
      this.contactEmail = contactEmail;
   }

   public String getProvince() {
      return province;
   }

   public void setProvince(String province) {
      this.province = province;
   }

   public String getCity() {
      return city;
   }

   public void setCity(String city) {
      this.city = city;
   }

   public String getAddress() {
      return address;
   }

   public void setAddress(String address) {
      this.address = address;
   }

   public String getZipCode() {
      return zipCode;
   }

   public void setZipCode(String zipCode) {
      this.zipCode = zipCode;
   }

   public String getPhone() {
      return phone;
   }

   public void setPhone(String phone) {
      this.phone = phone;
   }

   public String getTax() {
      return tax;
   }

   public void setTax(String tax) {
      this.tax = tax;
   }

   public String getMainPage() {
      return mainPage;
   }

   public void setMainPage(String mainPage) {
      this.mainPage = mainPage;
   }

   public String getRemark() {
      return remark;
   }

   public void setRemark(String remark) {
      this.remark = remark;
   }

   public String getTaxesRemark() {
      return taxesRemark;
   }

   public void setTaxesRemark(String taxesRemark) {
      this.taxesRemark = taxesRemark;
   }

   public String getInvoiceTitle() {
      return invoiceTitle;
   }

   public void setInvoiceTitle(String invoiceTitle) {
      this.invoiceTitle = invoiceTitle;
   }

   public PictureVO getPictureVO() {
      return pictureVO;
   }

   public void setPictureVO(PictureVO pictureVO) {
      this.pictureVO = pictureVO;
   }

   public String getIsBreedInit() {
      return isBreedInit;
   }

   public void setIsBreedInit(String isBreedInit) {
      this.isBreedInit = isBreedInit;
   }

}
