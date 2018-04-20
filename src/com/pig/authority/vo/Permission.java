package com.pig.authority.vo;

import java.io.Serializable;

import org.nutz.dao.entity.annotation.ColDefine;
import org.nutz.dao.entity.annotation.ColType;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import com.pig.system.vo.BasePojo;

@Table("cd_auth_permission_breed")
public class Permission extends BasePojo implements Serializable {
   private static final long serialVersionUID = 6030002114176950184L;
   @Id
   protected long permissionId;
   @Column
   protected String moduleId;
   @Column
   protected String param;
   @Column
   protected String name;
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 500)
   private String description;

   private String isCheck;

   public long getPermissionId() {
      return permissionId;
   }

   public void setPermissionId(long permissionId) {
      this.permissionId = permissionId;
   }

   public String getModuleId() {
      return moduleId;
   }

   public void setModuleId(String moduleId) {
      this.moduleId = moduleId;
   }

   public String getParam() {
      return param;
   }

   public void setParam(String param) {
      this.param = param;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getDescription() {
      return description;
   }

   public void setDescription(String description) {
      this.description = description;
   }

   public String getIsCheck() {
      return isCheck;
   }

   public void setIsCheck(String isCheck) {
      this.isCheck = isCheck;
   }

}
