package com.pig.authority.vo;

import java.util.List;

import org.nutz.dao.entity.annotation.ColDefine;
import org.nutz.dao.entity.annotation.ColType;
import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_auth_permission_module_breed")
public class PermissionModule {
   @Id
   protected long id;
   @Column
   protected String module;
   @Column
   protected String moduleName;
   @Column("`index`")
   @ColDefine(type = ColType.INT, width = 5)
   protected int index;

   private List<Permission> permissionList;

   public long getId() {
      return id;
   }

   public void setId(long id) {
      this.id = id;
   }

   public String getModule() {
      return module;
   }

   public void setModule(String module) {
      this.module = module;
   }

   public String getModuleName() {
      return moduleName;
   }

   public void setModuleName(String moduleName) {
      this.moduleName = moduleName;
   }

   public List<Permission> getPermissionList() {
      return permissionList;
   }

   public int getIndex() {
      return index;
   }

   public void setIndex(int index) {
      this.index = index;
   }

   public void setPermissionList(List<Permission> permissionList) {
      this.permissionList = permissionList;
   }

}
