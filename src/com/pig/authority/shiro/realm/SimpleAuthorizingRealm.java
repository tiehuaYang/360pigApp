package com.pig.authority.shiro.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAccount;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.mvc.Mvcs;

import com.pig.authority.shiro.SimpleShiroToken;
import com.pig.authority.vo.Permission;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserVO;

public class SimpleAuthorizingRealm extends AuthorizingRealm {

   protected Dao dao;

   @Override
   protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
      // null usernames are invalid
      if (principals == null) {
         throw new AuthorizationException("PrincipalCollection method argument cannot be null.");
      }
      String userId = (String) principals.getPrimaryPrincipal();
      UserVO user = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", userId));
      if (user == null) {
         return null;
      }
      if (user.isLocked()) {
         throw new LockedAccountException("Account [" + user.getUserName() + "] is locked.");
      }

      SimpleAuthorizationInfo auth = new SimpleAuthorizationInfo();
      user = dao().fetchLinks(user, null);
      if (user.getRoles() != null) {
         dao().fetchLinks(user.getRoles(), null);
         for (Role role : user.getRoles()) {
            auth.addRole(role.getName());
            if (role.getPermissions() != null) {
               for (Permission p : role.getPermissions()) {
                  auth.addStringPermission(p.getParam());
               }
            }
         }
      }
      if (user.getPermissions() != null) {
         for (Permission p : user.getPermissions()) {
            auth.addStringPermission(p.getParam());
         }
      }
      return auth;
   }

   @Override
   protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
      SimpleShiroToken upToken = (SimpleShiroToken) token;

      UserVO user = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", ((String) upToken.getPrincipal())));
      if (user == null) {
         return null;
      }
      if (user.isLocked()) {
         throw new LockedAccountException("Account [" + user.getUserName() + "] is locked.");
      }
      return new SimpleAccount(user.getUserId(), user.getPassword(), getName());
   }

   /**
    * 覆盖父类的验证,直接pass. 在shiro内做验证的话, 出错了都不知道哪里错
    */
   @Override
   protected void assertCredentialsMatch(AuthenticationToken token, AuthenticationInfo info)
         throws AuthenticationException {
   }

   public SimpleAuthorizingRealm() {
      this(null, null);
   }

   public SimpleAuthorizingRealm(CacheManager cacheManager, CredentialsMatcher matcher) {
      super(cacheManager, matcher);
      setAuthenticationTokenClass(SimpleShiroToken.class);
   }

   public SimpleAuthorizingRealm(CacheManager cacheManager) {
      this(cacheManager, null);
   }

   public SimpleAuthorizingRealm(CredentialsMatcher matcher) {
      this(null, matcher);
   }

   public Dao dao() {
      if (dao == null) {
         dao = Mvcs.ctx().getDefaultIoc().get(Dao.class, "dao");
         return dao;
      }
      return dao;
   }

   public void setDao(Dao dao) {
      this.dao = dao;
   }

}
