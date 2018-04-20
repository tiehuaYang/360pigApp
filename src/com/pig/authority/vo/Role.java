package com.pig.authority.vo;

import java.io.Serializable;
import java.util.List;

import org.nutz.dao.entity.annotation.ColDefine;
import org.nutz.dao.entity.annotation.ColType;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Table;

import com.pig.system.vo.BasePojo;

@Table("cd_auth_role_breed")
public class Role extends BasePojo implements Serializable {
   private static final long serialVersionUID = 7990747359942605936L;

   @Id
   protected long id;
   @Column
   protected String name;
   @Column
   protected String companyId;
   @Column
   protected String alias;
   @Column
   @ColDefine(type = ColType.VARCHAR, width = 500)
   private String description;
   @Column
   private int sortNum;

   @ManyMany(from = "roleId", relation = "cd_auth_role_permission_breed", target = Permission.class, to = "permissionId")
   protected List<Permission> permissions;

   //用于临时记录某项权限是否被勾选
   private String isCheck;

   public long getId() {
      return id;
   }

   public void setId(long id) {
      this.id = id;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getCompanyId() {
      return companyId;
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public String getAlias() {
      return alias;
   }

   public void setAlias(String alias) {
      this.alias = alias;
   }

   public String getDescription() {
      return description;
   }

   public void setDescription(String description) {
      this.description = description;
   }

   public List<Permission> getPermissions() {
      return permissions;
   }

   public void setPermissions(List<Permission> permissions) {
      this.permissions = permissions;
   }

   public String getIsCheck() {
      return isCheck;
   }

   public void setIsCheck(String isCheck) {
      this.isCheck = isCheck;
   }

}
