package com.pig.authority.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;

import com.pig.authority.vo.Permission;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.RolePermission;
import com.pig.common.page.Pagination;
import com.pig.system.action.BaseService;

/**
 * @author erick
 */
@IocBean(args = { "refer:dao" })
public class PermissionService extends BaseService<Role> {

   public PermissionService(Dao dao) {
      super(dao);
   }

   public List<Role> list() {
      return query(null, null);
   }

   public Permission fetchPermission(long permissionId) {
      return dao().fetch(Permission.class, permissionId);
   }

   public void updateRoleRelation(Role role, List<Permission> perms) {
      dao().clearLinks(role, "permissions");
      role.getPermissions().clear();
      dao().update(role);
      if (!Lang.isEmpty(perms)) {
         role.setPermissions(perms);
         dao().insertRelation(role, "permissions");
      }
   }

   /*
    * 更新角色的权限关联
    */
   public boolean updateRolePermission(Role role, Permission permission, String isCheck) {
      RolePermission rp = dao().fetch(RolePermission.class, Cnd.where("roleId", "=", role.getId()).and("permissionId", "=", permission.getPermissionId()));
      if (isCheck.equals("true"))//若权限被勾选
      {
         if (rp == null) {
            dao().insert(RolePermission.class, Chain.make("roleId", role.getId()).add("permissionId", permission.getPermissionId()));
         }
      }
      else if (isCheck.equals("false")) {//若取消勾选
         if (rp != null) {
            dao().clear(RolePermission.class, Cnd.where("roleId", "=", role.getId()).and("permissionId", "=", permission.getPermissionId()));
         }
      }
      return true;
   }

   /*
    * 根据角色id获取对应的权限id列表
    */
   public List<Long> queryPermissionByRole(Long roleId) {
      List<Long> permissionIdList = new ArrayList<Long>();
      List<RolePermission> rolePermissionList = dao().query(RolePermission.class, Cnd.where("roleId", "=", roleId));
      for (RolePermission rp : rolePermissionList) {
         permissionIdList.add(rp.getPermissionId());
      }
      return permissionIdList;
   }

   /*
    * 根据角色id的列表获取所有的的权限id列表
    */
   public Set<Long> queryPermissionByRole(String[] roleIds) {
      Set<Long> permissionIdList = new HashSet<Long>();

      if (roleIds != null && roleIds.length > 0) {
         for (String roleId : roleIds) {
            List<RolePermission> rolePermissionList = dao().query(RolePermission.class, Cnd.where("roleId", "=", Long.parseLong(roleId)));
            for (RolePermission rp : rolePermissionList) {
               //遍历所有角色，如果权限id不重复就添加到权限id列表中
               if (!permissionIdList.contains(rp.getPermissionId())) {
                  permissionIdList.add(rp.getPermissionId());
               }
            }
         }
      }
      return permissionIdList;
   }

   public Map<Long, String> map() {
      Map<Long, String> map = new HashMap<Long, String>();
      List<Role> roles = query(null, null);
      for (Role role : roles) {
         map.put(role.getId(), role.getName());
      }
      return map;
   }

   public void addPermission(Long roleId, Long permissionId) {
      dao().insert("system_role_permission", Chain.make("roleid", roleId).add("permissionid", permissionId));
   }

   public void removePermission(Long roleId, Long permissionId) {
      dao().clear("system_role_permission", Cnd.where("roleid", "=", roleId).and("permissionid", "=", permissionId));
   }

   public Pagination getRoleListByPager(Integer pageNumber, int pageSize) {
      return getObjListByPager(pageNumber, pageSize, null);
   }

}
