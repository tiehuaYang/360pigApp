package com.pig.authority.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.pig.authority.vo.Role;

public class AuthorityDAO {

   protected static final Log log = Logs.getLog(AuthorityDAO.class);

   /**
    * 获得某企业下的所有角色
    * 
    * @param companyId 对应的企业ID
    */
   public static List<Role> queryAllRoleList(Dao dao, String companyId) {
      List<Role> roleList = dao.query(Role.class, Cnd.where("companyId", "=", companyId));
      return roleList;
   }

   /**
    * 用户完成注册时默认创建的角色列表
    * 
    * @param companyId 对应的企业ID
    */
   public static void createDefaultRole(Dao dao, String companyId) {
      Sql sql = Sqls.create("insert into cd_auth_role_breed(companyId,name,alias,description,sortNum,createTime,updateTime)  "
            + "select @companyId,name,alias,description,sortNum,now(),now() from cd_auth_role_base_breed ");
      sql.params().set("companyId", companyId);
      dao.execute(sql);
   }

   /**
    * 用户完成注册时默认管理员的默认权限
    * 
    * @param companyId 对应的企业ID
    */
   public static void createDefaultAdminPermission(Dao dao, long roleId) {
      Sql sql = Sqls.create("insert into cd_auth_role_permission_breed select @roleId,permissionId from cd_auth_permission_breed ");
      sql.params().set("roleId", roleId);
      dao.execute(sql);
   }
}
