package com.pig.authority.service;

import java.util.Date;

import org.apache.shiro.crypto.hash.Sha256Hash;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.random.R;
import org.nutz.service.IdNameEntityService;

import com.pig.authority.vo.UserVO;

//需要注入父类的dao属性
@IocBean(fields = "dao")
public class UserService extends IdNameEntityService<UserVO> {

//   public UserService(Dao dao)
//   {
//      super(dao);
//   }
//
//   public List<UserVO> list()
//   {
//      return query(null, null);
//   }
//
//   public void update(UserVO user)
//   {
//      dao().update(user);
//   }
//
//   public void update(long uid, String password, boolean isLocked, Integer[] ids)
//   {
//      UserVO user = fetch(uid);
//      dao().clearLinks(user, "roles");
//      if (!Lang.isEmptyArray(ids))
//      {
//         user.setRoles(dao().query(Role.class, Cnd.where("id", "in", ids)));
//      }
//      if (StringUtils.isNotBlank(password))
//      {
//         String salt = new SecureRandomNumberGenerator().nextBytes().toBase64();
//         user.setSalt(salt);
//         user.setPassword(new Sha256Hash(password, salt, 1024).toBase64());
//      }
//      user.setLocked(isLocked);
//      dao().update(user);
//      if (!Lang.isEmpty(user.getRoles()))
//      {
//         dao().insertRelation(user, "roles");
//      }
//   }
//
//   public void updatePwd(Object uid, String password)
//   {
//      String salt = new SecureRandomNumberGenerator().nextBytes().toBase64();
//      dao().update(UserVO.class,
//            Chain.make("password", new Sha256Hash(password, salt, 1024).toBase64()).add("salt", salt),
//            Cnd.where("id", "=", uid));
//   }
//
//   public void insert(UserVO user)
//   {
//      user = dao().insert(user);
//      dao().insertRelation(user, "roles");
//   }
//
//   public boolean save(String username, String password, boolean isEnabled, String addr, int[] roleIds)
//   {
//      UserVO user = new UserVO();
//      user.setCreateDate(Times.now());
//      user.setLocked(!isEnabled);
//      user.setRoles(dao().query(Role.class, Cnd.where("id", "in", roleIds)));
//      String salt = new SecureRandomNumberGenerator().nextBytes().toBase64();
//      user.setSalt(salt);
//      user.setPassword(new Sha256Hash(password, salt, 1024).toBase64());
//      insert(user);
//      return true;
//   }
//
//   public UserVO view(Long id)
//   {
//      return dao().fetchLinks(fetch(id), "roles");
//   }
//
//   public UserVO fetchByName(String name)
//   {
//      return fetch(Cnd.where("name", "=", name));
//   }
//
//   public List<String> getRoleNameList(UserVO user)
//   {
//      dao().fetchLinks(user, "roles");
//      List<String> roleNameList = new ArrayList<String>();
//      for (Role role : user.getRoles())
//      {
//         roleNameList.add(role.getName());
//      }
//      return roleNameList;
//   }
//
//   public void addRole(Long userId, Long roleId)
//   {
//      UserVO user = fetch(userId);
//      Role role = new Role();
//      role.setId(roleId);
//      user.setRoles(Lang.list(role));
//      dao().insertRelation(user, "roles");
//   }
//
//   public void removeRole(Long userId, Long roleId)
//   {
//      dao().clear("system_user_role", Cnd.where("userid", "=", userId).and("roleid", "=", roleId));
//   }
//
//   public UserVO initUser(String name, String openid, String providerid, String addr)
//   {
//      UserVO user = new UserVO();
//      user.setCreateDate(Times.now());
//      user.setLocked(false);
//      return dao().insert(user);
//   }
//
//
//   public UserVO fetchByOpenID(String openid)
//   {
//      UserVO user = fetch(Cnd.where("openid", "=", openid));
//      if (!Lang.isEmpty(user) && !user.isLocked())
//      {
//         dao().fetchLinks(user, "servers");
//         dao().fetchLinks(user, "roles");
//      }
//      return user;
//   }

   public UserVO updatePassword(String userId, String password) {
      UserVO user = fetch(Cnd.where("userId", "=", userId));
      if (user == null) {
         return null;
      }
      user.setSalt(R.UU16());
      user.setPassword(new Sha256Hash(password, user.getSalt()).toHex());
      user.setLastLoginDate(new Date());
      dao().update(user, "^(password|salt|updateTime)$");
      return user;
   }

   /*public UserVO updateSalesIdPassword(String userId, String password, JoinInVO joinInVO) {
      UserVO user = fetch(Cnd.where("userId", "=", userId));
      if (user == null) {
         return null;
      }
      user.setSalt(R.UU16());
      user.setPassword(new Sha256Hash(password, user.getSalt()).toHex());
      user.setLastLoginDate(new Date());
      joinInVO.setOriginalsalespd(new Sha256Hash(password, user.getSalt()).toHex());
      dao().update(joinInVO);
      dao().update(user, "^(password|salt|updateTime)$");
      return user;
   }*/

   public UserVO add(String name, String password) {
      UserVO user = new UserVO();
      user.setUserName(name.trim());
      user.setSalt(R.UU16());
      user.setPassword(new Sha256Hash(password, user.getSalt()).toHex());
      user.setCreateDate(new Date());
      user.setLastLoginDate(new Date());
      return dao().insert(user);
   }

   public UserVO authUser(String loginAcount, String passwd) {
      UserVO userVO = dao().fetch(UserVO.class, Cnd.where("loginAcount", "=", loginAcount));
      if (userVO == null) {
         return null;
      }
      String _pass = new Sha256Hash(passwd, userVO.getSalt()).toHex();
      if (_pass.equalsIgnoreCase(userVO.getPassword())) {
         return userVO;
      }
      return null;
   }

   public int checkPermission(Dao dao, String userId, String permission) {
      int count = 0;
      try {
         StringBuffer sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(permissionId) AS counts FROM cd_auth_role_permission_breed WHERE roleId IN (SELECT roleId FROM cd_auth_user_role_breed WHERE userId = @userId) AND permissionId = (SELECT permissionId FROM cd_auth_permission_breed WHERE param = @permission )");
         Sql sql = Sqls.fetchInt(sb.toString());
         sql.params().set("userId", userId);
         sql.params().set("permission", permission);
         dao.execute(sql);
         count = sql.getInt();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return count;
   }
}
