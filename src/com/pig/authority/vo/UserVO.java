package com.pig.authority.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.nutz.dao.entity.annotation.ColDefine;
import org.nutz.dao.entity.annotation.ColType;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import com.pig.system.vo.PictureVO;

@Table("cd_auth_user")
public class UserVO implements Serializable {
   private static final long serialVersionUID = 2894377814677682662L;

   @Name
   @Column
   private String userId;
   @Column
   private String parentId;
   @Column
   private String companyId;
   @Column
   private String loginAcount;
   @Column
   private String userName;
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 80)
   private String password;
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 80)
   protected String salt;
   @Column
   private boolean locked;
   @Column
   private String cellPhone;
   @Column
   private String post; //职位
   @Column
   private String departure;//部门
   @Column
   private String level;//等级
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 10)
   private String isvalid;
   @Column
   private String email;
   @Column
   private Date createDate;
   @Column
   private Date employDate;//入职时间
   @Column
   private Date lastLoginDate;
   @Column
   private String isCreateBySupplyer;//是否由供应商创建的标识，是的就为"Y",不是的就为空
   @Column
   private String defaultFarm;//默认猪场

   @ManyMany(from = "userId", relation = "cd_auth_user_role_breed", target = Role.class, to = "roleId")
   protected List<Role> roles;

   @ManyMany(from = "userId", relation = "cd_auth_user_permission_breed", target = Permission.class, to = "permissionId")
   protected List<Permission> permissions;

   //一个用户对应一个企业
   @One(target = CompanyProfile.class, field = "companyId")
   protected CompanyProfile companyProfile;

   //用户头像
   @One(target = PictureVO.class, field = "userId", key = "picUuid")
   private PictureVO pictureVO;//放置头像

   public String getIsCreateBySupplyer() {
      return isCreateBySupplyer;
   }

   public void setIsCreateBySupplyer(String isCreateBySupplyer) {
      this.isCreateBySupplyer = isCreateBySupplyer;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public String getParentId() {
      return parentId;
   }

   public void setParentId(String parentId) {
      this.parentId = parentId;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getLoginAcount() {
      return loginAcount;
   }

   public void setLoginAcount(String loginAcount) {
      this.loginAcount = loginAcount;
   }

   public String getUserName() {
      return userName;
   }

   public void setUserName(String userName) {
      this.userName = userName;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getSalt() {
      return salt;
   }

   public void setSalt(String salt) {
      this.salt = salt;
   }

   public boolean isLocked() {
      return locked;
   }

   public void setLocked(boolean locked) {
      this.locked = locked;
   }

   public String getCellPhone() {
      return cellPhone;
   }

   public void setCellPhone(String cellPhone) {
      this.cellPhone = cellPhone;
   }

   public String getPost() {
      return post;
   }

   public void setPost(String post) {
      this.post = post;
   }

   public String getDeparture() {
      return departure;
   }

   public void setDeparture(String departure) {
      this.departure = departure;
   }

   public String getIsvalid() {
      return isvalid;
   }

   public void setIsvalid(String isvalid) {
      this.isvalid = isvalid;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public Date getCreateDate() {
      return createDate;
   }

   public void setCreateDate(Date createDate) {
      this.createDate = createDate;
   }

   public Date getEmployDate() {
      return employDate;
   }

   public void setEmployDate(Date employDate) {
      this.employDate = employDate;
   }

   public Date getLastLoginDate() {
      return lastLoginDate;
   }

   public void setLastLoginDate(Date lastLoginDate) {
      this.lastLoginDate = lastLoginDate;
   }

   public List<Role> getRoles() {
      return roles;
   }

   public void setRoles(List<Role> roles) {
      this.roles = roles;
   }

   public List<Permission> getPermissions() {
      return permissions;
   }

   public void setPermissions(List<Permission> permissions) {
      this.permissions = permissions;
   }

   public CompanyProfile getCompanyProfile() {
      return companyProfile;
   }

   public void setCompanyProfile(CompanyProfile companyProfile) {
      this.companyProfile = companyProfile;
   }

   public PictureVO getPictureVO() {
      return pictureVO;
   }

   public void setPictureVO(PictureVO pictureVO) {
      this.pictureVO = pictureVO;
   }

   public String getEmployDateStr() {
      if (employDate == null) {
         return "";
      }
      else {
         return String.format("%tY", employDate) + "-" + String.format("%tm", employDate) + "-"
               + String.format("%td", employDate);
      }
   }

   public String getLastLoginDateStr() {
      if (lastLoginDate == null) {
         return "";
      }
      else {
         return String.format("%tY", lastLoginDate) + "-" + String.format("%tm", lastLoginDate) + "-"
               + String.format("%td", lastLoginDate);
      }
   }

   public String getLevel() {
      return level;
   }

   public void setLevel(String level) {
      this.level = level;
   }

   public String getDefaultFarm() {
      return defaultFarm;
   }

   public void setDefaultFarm(String defaultFarm) {
      this.defaultFarm = defaultFarm;
   }

}
