package com.pig.authority.shiro;

import java.util.Collection;
import java.util.List;
import java.util.concurrent.Callable;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.Permission;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.ExecutionException;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

public class ShiroProxy implements Subject {

   protected Subject proxy() {
      return SecurityUtils.getSubject();
   }

   @Override
   public Object getPrincipal() {
      return proxy().getPrincipal();
   }

   @Override
   public PrincipalCollection getPrincipals() {
      return proxy().getPrincipals();
   }

   @Override
   public boolean isPermitted(String permission) {
      return proxy().isPermitted(permission);
   }

   @Override
   public boolean isPermitted(Permission permission) {
      return proxy().isPermitted(permission);
   }

   @Override
   public boolean[] isPermitted(String... permissions) {
      return proxy().isPermitted(permissions);
   }

   @Override
   public boolean[] isPermitted(List<Permission> permissions) {
      return proxy().isPermitted(permissions);
   }

   @Override
   public boolean isPermittedAll(String... permissions) {
      return proxy().isPermittedAll(permissions);
   }

   @Override
   public boolean isPermittedAll(Collection<Permission> permissions) {
      return proxy().isPermittedAll(permissions);
   }

   @Override
   public void checkPermission(String permission) throws AuthorizationException {
      proxy().checkPermission(permission);
   }

   @Override
   public void checkPermission(Permission permission) throws AuthorizationException {
      proxy().checkPermission(permission);
   }

   @Override
   public void checkPermissions(String... permissions) throws AuthorizationException {
      proxy().checkPermissions(permissions);
   }

   @Override
   public void checkPermissions(Collection<Permission> permissions) throws AuthorizationException {
      proxy().checkPermissions(permissions);
   }

   @Override
   public boolean hasRole(String roleIdentifier) {
      return proxy().hasRole(roleIdentifier);
   }

   @Override
   public boolean[] hasRoles(List<String> roleIdentifiers) {
      return proxy().hasRoles(roleIdentifiers);
   }

   @Override
   public boolean hasAllRoles(Collection<String> roleIdentifiers) {
      return proxy().hasAllRoles(roleIdentifiers);
   }

   @Override
   public void checkRole(String roleIdentifier) throws AuthorizationException {
      proxy().checkRole(roleIdentifier);
   }

   @Override
   public void checkRoles(Collection<String> roleIdentifiers) throws AuthorizationException {
      proxy().checkRoles(roleIdentifiers);
   }

   @Override
   public void checkRoles(String... roleIdentifiers) throws AuthorizationException {
      proxy().checkRoles(roleIdentifiers);
   }

   @Override
   public void login(AuthenticationToken token) throws AuthenticationException {
      proxy().login(token);
   }

   @Override
   public boolean isAuthenticated() {
      return proxy().isAuthenticated();
   }

   @Override
   public boolean isRemembered() {
      return proxy().isRemembered();
   }

   @Override
   public Session getSession() {
      return proxy().getSession();
   }

   @Override
   public Session getSession(boolean create) {
      return proxy().getSession(create);
   }

   @Override
   public void logout() {
      proxy().logout();
   }

   @Override
   public <V> V execute(Callable<V> callable) throws ExecutionException {
      return proxy().execute(callable);
   }

   @Override
   public void execute(Runnable runnable) {
      proxy().execute(runnable);
   }

   @Override
   public <V> Callable<V> associateWith(Callable<V> callable) {
      return proxy().associateWith(callable);
   }

   @Override
   public Runnable associateWith(Runnable runnable) {
      return proxy().associateWith(runnable);
   }

   @Override
   public void runAs(PrincipalCollection principals) throws NullPointerException, IllegalStateException {
      proxy().runAs(principals);
   }

   @Override
   public boolean isRunAs() {
      return proxy().isRunAs();
   }

   @Override
   public PrincipalCollection getPreviousPrincipals() {
      return proxy().getPreviousPrincipals();
   }

   @Override
   public PrincipalCollection releaseRunAs() {
      return proxy().releaseRunAs();
   }

   //-------------------------------------------

   public boolean isGuest() {
      return isAuthenticated();
   }

   public boolean hasPermit(String permission) {
      return proxy().isPermitted(permission);
   }
}
