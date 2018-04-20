package com.pig.authority.service;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.entity.Record;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.ContinueLoop;
import org.nutz.lang.Each;
import org.nutz.lang.ExitLoop;
import org.nutz.lang.LoopException;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.resource.Scans;

import com.pig.authority.vo.Permission;
import com.pig.authority.vo.PermissionModule;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;

@IocBean(name = "authorityService")
public class AuthorityServiceImpl implements AuthorityService {

   private static final Log log = Logs.get();

   @Inject
   Dao dao;

   @Inject
   protected RoleService roleService;

   @Override
   public void initFormPackage(String pkg) {
      // 搜索@RequiresPermissions注解, 初始化权限表
      // 搜索@RequiresRoles注解, 初始化角色表
      final Set<String> permissions = new HashSet<String>();
      final Set<String> roles = new HashSet<String>();
      for (Class<?> klass : Scans.me().scanPackage(pkg)) {
         for (Method method : klass.getMethods()) {
            RequiresPermissions rp = method.getAnnotation(RequiresPermissions.class);
            if (rp != null && rp.value() != null) {
               for (String permission : rp.value()) {
                  if (permission != null && !permission.endsWith("*")) {
                     permissions.add(permission);
                  }
               }
            }
            RequiresRoles rr = method.getAnnotation(RequiresRoles.class);
            if (rr != null && rr.value() != null) {
               for (String role : rr.value()) {
                  roles.add(role);
               }
            }
         }
      }
      log.debugf("found %d permission", permissions.size());
      log.debugf("found %d role", roles.size());

      // 把全部权限查出来一一检查
      dao.each(Permission.class, null, new Each<Permission>() {
         @Override
         public void invoke(int index, Permission ele, int length) throws ExitLoop, ContinueLoop, LoopException {
            permissions.remove(ele.getParam());
         }
      });
      dao.each(Role.class, null, new Each<Role>() {
         @Override
         public void invoke(int index, Role ele, int length) throws ExitLoop, ContinueLoop, LoopException {
            roles.remove(ele.getName());
         }
      });
      for (String permission : permissions) {
         addPermission(permission);
      }
      for (String role : roles) {
         addRole(role);
      }
   }

   @Override
   public void checkBasicRoles(UserVO admin) {
      // 检查一下admin的权限
      Role adminRole = dao.fetch(Role.class, "admin");
      if (adminRole == null) {
         adminRole = addRole("admin");
      }
      // admin账号必须存在与admin组
      if (0 == dao.count("cd_auth_user_role_breed", Cnd.where("userId", "=", admin.getUserId()).and("roleId", "=", adminRole.getId()))) {
         dao.insert("cd_auth_user_role_breed", Chain.make("userId", admin.getUserId()).add("roleId", adminRole.getId()));
      }
      // admin组必须有authority:* 也就是权限管理相关的权限
      List<Record> res = dao.query("cd_auth_role_permission_breed", Cnd.where("roleId", "=", adminRole.getId()));
      OUT: for (Permission permission : dao.query(Permission.class, Cnd.where("name", "like", "authority:%").or("name", "like", "user:%").or("name", "like", "topic:%"), null)) {
         for (Record re : res) {
            if (re.getInt("permissionId") == permission.getPermissionId()) {
               continue OUT;
            }
         }
         dao.insert("cd_auth_role_permission_breed", Chain.make("roleId", adminRole.getId()).add("permissionId", permission.getPermissionId()));
      }
   }

   @Override
   public void addPermission(String permission) {
      Permission p = new Permission();
      p.setParam(permission);
      p.setUpdateTime(new Date());
      p.setCreateTime(new Date());
      dao.insert(p);
   }

   @Override
   public Role addRole(String role) {
      Role r = new Role();
      r.setName(role);
      r.setUpdateTime(new Date());
      r.setCreateTime(new Date());
      return dao.insert(r);
   }

   /**
    * 扫描Module表中的记录，并遍历出对应的所有权限因子，并根据当前角色获取权限状态
    * 
    * @param companyId 对应的企业ID
    */
   @Override
   public List<PermissionModule> queryPermissionList(Role role, String companyId) {
      List<PermissionModule> moduleList = dao.query(PermissionModule.class, Cnd.orderBy().asc("index"));
      if (role != null) {
         //先根据角色获得该角色对应
         List<Long> pIdList = roleService.getPermissionList(role);
         for (PermissionModule pm : moduleList) {
            List<Permission> permissionList = dao.query(Permission.class, Cnd.where("moduleId", "=", pm.getId()));
            for (Permission p : permissionList) {
               if (pIdList.contains(p.getPermissionId())) {
                  p.setIsCheck(CommonConstants.DB_CHAR_YES);
               }
            }
            pm.setPermissionList(permissionList);
         }
      }
      else {
         for (PermissionModule pm : moduleList) {
            List<Permission> permissionList = dao.query(Permission.class, Cnd.where("moduleId", "=", pm.getId()));
            pm.setPermissionList(permissionList);
         }
      }
      return moduleList;
   }
}
