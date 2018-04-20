package com.pig.authority.shiro.realm;

import org.apache.shiro.SecurityUtils;
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
import org.apache.shiro.util.ByteSource;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.Mvcs;

import com.pig.authority.shiro.CaptchaUsernamePasswordToken;
import com.pig.authority.vo.Permission;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserVO;

/**
 * 用NutDao来实现Shiro的Realm
 * <p/> 在Web环境中通过Ioc来获取NutDao
 * 
 * @author Erick
 */
@IocBean
public class NutDaoRealm extends AuthorizingRealm {
   @Inject
   protected Dao dao;

   @Override
   protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

      if (principals == null) {
         throw new AuthorizationException("PrincipalCollection method  argument cannot  be  null.");
      }
      String loginAcount = (String) principals.getPrimaryPrincipal();
      UserVO user = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", loginAcount));
      if (user == null) {
         return null;
      }
      if (user.isLocked()) {
         throw new LockedAccountException("Account [" + user.getUserName() + "]  is  locked.");
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

      CaptchaUsernamePasswordToken upToken = (CaptchaUsernamePasswordToken) token;
      UserVO userVO = dao().fetch(UserVO.class, Cnd.where("loginAcount", "=", upToken.getUsername()));
      if (userVO == null) {
         return null;
      }
      if (userVO.isLocked()) {
         throw new LockedAccountException("Account [" + upToken.getUsername() + "]  is  locked.");
      }
      SimpleAccount account = new SimpleAccount(userVO.getLoginAcount(), userVO.getPassword(), getName());
      account.setCredentialsSalt(ByteSource.Util.bytes(userVO.getSalt()));
      return account;
   }

   public NutDaoRealm() {
      this(null, null);
   }

   public NutDaoRealm(CacheManager cacheManager, CredentialsMatcher matcher) {
      super(cacheManager, matcher);
      setAuthenticationTokenClass(CaptchaUsernamePasswordToken.class);
   }

   public void clearCached() {
      PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
      super.clearCache(principals);
   }

   public NutDaoRealm(CacheManager cacheManager) {
      this(cacheManager, null);
   }

   public NutDaoRealm(CredentialsMatcher matcher) {
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
