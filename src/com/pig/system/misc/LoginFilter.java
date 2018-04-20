package com.pig.system.misc;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(dispatcherTypes = { DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.INCLUDE }, urlPatterns = { "/manage/*" })
public class LoginFilter implements Filter
{

   /**
    * Default constructor. 
    */
   public LoginFilter()
   {
      // TODO Auto-generated constructor stub
   }

   /**
    * @see Filter#destroy()
    */
   @Override
   public void destroy()
   {
      // TODO Auto-generated method stub
   }

   /**
    * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
    */
   @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
         ServletException
   {
      HttpServletRequest req = (HttpServletRequest) request;
      HttpServletResponse res = (HttpServletResponse) response;
      UserVO userVO = (UserVO) req.getSession().getAttribute(CommonConstants.SESSION_USER_KEY);
      if (userVO == null)
      {
         res.sendRedirect(request.getServletContext().getContextPath() + "/login");
         return;
      }
//      else
//      {
//         String path = req.getServletPath();
//         if (path.startsWith("/manage/user"))
//         {
//            if (!CommonConstants.DB_CHAR_YES.equals(userVo.getIsadmin()))
//            {
//               res.sendRedirect(request.getServletContext().getContextPath() + "/manage/showIndex");
//               return;
//            }
//         }
//      }

      // pass the request along the filter chain
      chain.doFilter(request, response);
   }

   /**
    * @see Filter#init(FilterConfig)
    */
   @Override
   public void init(FilterConfig fConfig) throws ServletException
   {
      // TODO Auto-generated method stub
   }

}
