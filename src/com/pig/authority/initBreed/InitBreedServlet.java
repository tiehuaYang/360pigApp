package com.pig.authority.initBreed;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.impl.NutDao;
import org.nutz.dao.impl.SimpleDataSource;

import com.pig.authority.dao.AuthorityDAO;
import com.pig.authority.vo.CompanyProfile;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserRole;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;

public class InitBreedServlet extends HttpServlet {

   @Override
   public void init() throws ServletException {

   }

   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      process(request, response);
   }

   @Override
   public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String fanhuizhi = process(request, response);
      //生成HTTP响应结果
      PrintWriter out;
      //set content type
      response.setContentType("text/html;charset=GB2312");
      //write html page
      out = response.getWriter();
      out.print(fanhuizhi);

      out.close();
   }

   @SuppressWarnings("unused")
   private String process(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      String result = "";
      Map<String, Object> param = null;

      try {
         // 创建一个数据源
         SimpleDataSource dataSource = new SimpleDataSource();
         dataSource.setJdbcUrl(CommonConstants.BREED_data);
         dataSource.setUsername(CommonConstants.BREED_DATA_USERNAME);
         dataSource.setPassword(CommonConstants.BREED_DATA_PASSWORD);

         // 创建一个NutDao实例,在真实项目中, NutDao通常由ioc托管, 使用注入的方式获得.
         Dao dao = new NutDao(dataSource);
         String userId = request.getParameter("userId");
         //String password = request.getParameter("password");
         param = jxcInit(request, dao, userId);
         return (String) param.get("msg");
      }
      catch (Exception e) {
         e.printStackTrace();
         System.err.println(e);
      }
      return "初始化失败";
   }

   //进销存用户进入养殖平台的初始化
   public Map<String, Object> jxcInit(HttpServletRequest request, Dao dao, String userId) throws Exception {
      Map<String, Object> map = new HashMap<>();
      UserVO userVO = dao.fetch(UserVO.class, userId);
      if (userVO != null) {
         /*String face = new Sha256Hash(password, userVO.getSalt()).toHex();
         if (!face.equalsIgnoreCase(userVO.getPassword())) {
            map.put("msg", "密码错误");
            return map;
         }*/
         //dao.fetchLinks(userVO, "roles");
         //dao.fetchLinks(userVO, "permissions");
         CompanyProfile company = dao.fetch(CompanyProfile.class, userVO.getCompanyId());
         if (!company.getIsBreedInit().equals("Y")) {
            //根据新注册的企业id生成对应的一批角色记录
            AuthorityDAO.createDefaultRole(dao, userVO.getCompanyId());

            //获得对应的管理员角色
            Role role = dao.fetch(Role.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("name", "=", CommonConstants.ROLE.ROLE_ADMIN));
            //关联到当前注册的用户中，作为管理员帐号
            dao.insert(UserRole.class, Chain.make("userId", userVO.getUserId()).add("roleId", role.getId()));

            //根据新注册的管理员帐号生成默认权限（全权限）
            AuthorityDAO.createDefaultAdminPermission(dao, role.getId());

            /*ServletContext context2 = context.getContext("/userS");
            HttpSession session = (HttpSession) context2.getAttribute("/userS");*/

            /*Subject subject = SecurityUtils.getSubject();
            String host = request.getRemoteHost();
            AuthenticationToken token = new CaptchaUsernamePasswordToken(userVO.getLoginAcount(), password, true, host, null);
            subject.login(token);
            boolean shishi = subject.isAuthenticated();
            
            HttpSession session = request.getSession();
            session.setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
            session.setAttribute(CommonConstants.SESSION_LOGINNAME, userVO.getUserName());*/
            company.setIsBreedInit("Y");
            dao.update(company);

            map.put("msg", "初始化成功");
            return map;
         }
         /*Subject subject = SecurityUtils.getSubject();
         String host = request.getRemoteHost();
         AuthenticationToken token = new CaptchaUsernamePasswordToken(userVO.getLoginAcount(), password, true, host, null);
         subject.login(token);
         //PrincipalCollection pc = subject.getPrincipals();
         boolean shishi = subject.isAuthenticated();
         subject.logout();
         boolean shishi2 = subject.isAuthenticated();
         
         HttpSession session = request.getSession();
         session.setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
         session.setAttribute(CommonConstants.SESSION_LOGINNAME, userVO.getUserName());*/
         map.put("msg", "成功");
         return map;
      }
      else {
         map.put("msg", "初始化失败");
         return map;
      }
   }

}
