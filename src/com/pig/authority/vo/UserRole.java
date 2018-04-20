package com.pig.authority.vo;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_auth_user_role_breed")
public class UserRole {
   @Column
   protected String userId;
   @Column
   protected long roleId;

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public long getRoleId() {
      return roleId;
   }

   public void setRoleId(long roleId) {
      this.roleId = roleId;
   }

}
