package com.pig.authority.shiro;

import org.apache.shiro.authc.HostAuthenticationToken;
import org.apache.shiro.authc.RememberMeAuthenticationToken;

public class SimpleShiroToken implements HostAuthenticationToken, RememberMeAuthenticationToken {

   private static final long serialVersionUID = -1L;

   protected Object principal;

   protected boolean rememberMe;

   protected String host;

   @Override
   public Object getPrincipal() {
      return principal;
   }

   @Override
   public Object getCredentials() {
      return null;
   }

   @Override
   public boolean isRememberMe() {
      return rememberMe;
   }

   @Override
   public String getHost() {
      return host;
   }

   public void setHost(String host) {
      this.host = host;
   }

   public void setRememberMe(boolean rememberMe) {
      this.rememberMe = rememberMe;
   }

   public SimpleShiroToken() {
   }

   public SimpleShiroToken(Object principal) {
      this.principal = principal;
   }

   public SimpleShiroToken(Object principal, boolean rememberMe, String host) {
      this.principal = principal;
      this.rememberMe = rememberMe;
      this.host = host;
   }
}
