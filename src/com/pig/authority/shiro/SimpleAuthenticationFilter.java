package com.pig.authority.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class SimpleAuthenticationFilter extends org.apache.shiro.web.filter.authc.AuthenticationFilter {

   @Override
   protected boolean isLoginRequest(ServletRequest request, ServletResponse response) {
      return false;
   }

   protected boolean isLoginSubmission(ServletRequest request, ServletResponse response) {
      return false;
   }

   @Override
   protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
      ((HttpServletResponse) response).sendError(403);
      return false;
   }

   @Override
   protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
      if (pathsMatch(getLoginUrl(), request)) {
         return true;
      }
      return super.isAccessAllowed(request, response, mappedValue);
   }
}
