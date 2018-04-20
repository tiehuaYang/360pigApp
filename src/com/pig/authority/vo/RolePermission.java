package com.pig.authority.vo;

import java.io.Serializable;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_auth_role_permission_breed")
public class RolePermission implements Serializable {
   private static final long serialVersionUID = 5063013950203224064L;
   @Id
   protected long roleId;
   @Column
   protected long permissionId;

   public long getRoleId() {
      return roleId;
   }

   public void setRoleId(long roleId) {
      this.roleId = roleId;
   }

   public long getPermissionId() {
      return permissionId;
   }

   public void setPermissionId(long permissionId) {
      this.permissionId = permissionId;
   }

}
