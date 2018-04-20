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
import com.pig.authority.vo.PermissionModule;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.RolePermission;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.common.page.Pagination;
import com.pig.system.action.BaseService;

/**
 * @author erick
 */
@IocBean(args = { "refer:dao" })
public class RoleService extends BaseService<Role> {

   public RoleService(Dao dao) {
      super(dao);
   }

   public List<Role> list() {
      return query(null, null);
   }

   public void insert(Role role) {
      role = dao().insert(role);
      dao().insertRelation(role, "permissions");
   }

   public void delete(Long id) {
      dao().delete(Role.class, id);
      dao().clear("system_role_permission", Cnd.where("roleid", "=", id));
      dao().clear("system_user_role", Cnd.where("roleid", "=", id));
   }

   public Role view(Long id) {
      return dao().fetchLinks(fetch(id), "permissions");
   }

   public void update(Role role) {
      dao().update(role);
   }

   /**
    * 根据企业ID获取管理员角色
    * 
    * @param role 角色
    */
   public Role fetchAdmin(String companyId)//获得企业下的admin帐号
   {
      return fetch(Cnd.where("companyId", "=", companyId).and("name", "=", CommonConstants.ROLE.ROLE_ADMIN));
   }

   public Role fetchById(long id) {
      return dao().fetch(Role.class, id);
   }

   /**
    * 获得某角色下所有的权限的id列表
    * 
    * @param role 角色
    */
   public List<Long> getPermissionList(Role role) {
      List<Long> permissionIdList = new ArrayList<Long>();
      List<RolePermission> rpList = dao().query(RolePermission.class, Cnd.where("roleId", "=", role.getId()));
      if (rpList != null) {
         for (RolePermission rolePermission : rpList) {
            Permission permission = dao().fetch(Permission.class, rolePermission.getPermissionId());
            if (permission != null) {
               permissionIdList.add(permission.getPermissionId());
            }
         }
      }
      return permissionIdList;
   }

   /**
    * 根据用户获得用户的角色和权限列表
    * 
    * @param companyId 对应的企业ID
    * @param userVO 用户
    */
   public Map<String, Object> queryCheckRoleList(Dao dao, String companyId, UserVO userVO) {
      Map<String, Object> result = new HashMap<String, Object>();

      //用于记录已经关联的角色id和权限id列表
      Set<Long> roleIdList = new HashSet<Long>();
      Set<Long> permissionIdList = new HashSet<Long>();

      //根据用户获得用户当前关联的角色和权限
      userVO = dao.fetchLinks(userVO, null);
      if (userVO.getRoles() != null) {
         dao().fetchLinks(userVO.getRoles(), null);
         for (Role role : userVO.getRoles()) {
            roleIdList.add(role.getId());
            if (role.getPermissions() != null) {
               for (Permission p : role.getPermissions()) {
                  permissionIdList.add(p.getPermissionId());
               }
            }
         }
      }

      //根据企业id获取该企业下的所有角色列表
      List<Role> roleList = dao.query(Role.class, Cnd.where("companyId", "=", companyId));
      for (Role r : roleList) {
         //若判断列表中存在记录说明该用户已经拥有该角色权限
         if (roleIdList.contains(r.getId())) {
            r.setIsCheck(CommonConstants.DB_CHAR_YES);
         }
      }
      result.put("roleList", roleList);

      List<PermissionModule> moduleList = dao.query(PermissionModule.class, null);
      for (PermissionModule pm : moduleList) {
         List<Permission> permissionList = dao.query(Permission.class, Cnd.where("moduleId", "=", pm.getId()));
         for (Permission p : permissionList) {
            //若判断列表中存在记录说明已经拥有该权限
            if (permissionIdList.contains(p.getPermissionId())) {
               p.setIsCheck(CommonConstants.DB_CHAR_YES);
            }
         }
         pm.setPermissionList(permissionList);
      }
      result.put("pmList", moduleList);
      return result;
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
