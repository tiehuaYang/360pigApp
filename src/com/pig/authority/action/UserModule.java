package com.pig.authority.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.POST;
import org.nutz.mvc.annotation.Param;

import com.pig.authority.bo.UserBO;
import com.pig.authority.service.UserService;
import com.pig.authority.shiro.CaptchaUsernamePasswordToken;
import com.pig.authority.shiro.NutShiro;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.system.action.BaseAction;
import com.pig.system.bo.PictureBO;
import com.pig.system.vo.PictureVO;

@InjectName
@At("/user")
@Ok("json:{locked:'password|salt',ignoreNull:true}")
@IocBean
@Fail("http:500")
public class UserModule extends BaseAction {
   private static final Log log = Logs.getLog(UserModule.class);

   @Inject
   protected UserService userService;

   private String captchaParam = NutShiro.DEFAULT_CAPTCHA_PARAM;

   public String getCaptchaParam() {
      return captchaParam;
   }

   @At
   public int count() {
      return dao.count(UserVO.class);
   }

   @GET
   @At("/login")
   @Ok("jsp:jsp.user.login")
   public void loginPage() {
   }

// 映射 /user/login , 与shiro.ini对应.
   @POST
   @Ok("json")
   @At
   public Object login(ServletRequest request, ServletResponse response, @Param("username") String username,
         @Param("password") String password, @Param("rememberMe") boolean rememberMe,
         @Param("captcha") String captcha) {
      NutMap re = new NutMap().setv("ok", false);
      // 如果已经登陆过,直接返回真
      Subject subject = SecurityUtils.getSubject();
      Session session = subject.getSession(false);
      if (session == null) {
         return re.setv("msg", "验证码错误!");
      }
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);

/*      if (subject.isAuthenticated() && userVO != null)
   return re.setv("ok", true);*/

      // 检查验证码是否正确
      Object _expected = session.getAttribute(captchaParam);
      if (_expected == null) {
         _expected = session.getAttribute("nutz_captcha");
      }
      if (_expected == null) {
         return re.setv("msg", "验证码错误!");
/*      if (!captcha.equalsIgnoreCase(String.valueOf(_expected)))
   return re.setv("msg", "验证码错误!");*/
      }

      // 检查用户名密码
      userVO = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", username));
      if (userVO == null) {
         return re.setv("msg", "用户不存在");
      }

      // 比对密码
      String face = new Sha256Hash(password, userVO.getSalt()).toHex();
      if (!face.equalsIgnoreCase(userVO.getPassword())) {
         return re.setv("msg", "密码错误");
      }
      String host = request.getRemoteAddr();
      AuthenticationToken token = new CaptchaUsernamePasswordToken(username, password, rememberMe, host, captcha);
      subject.login(token);

      //更新用户的上次登录时间
      userVO.setLastLoginDate(new Date());
      dao.update(userVO);//修改用户上次登录时间

      userVO = dao.fetchLinks(userVO, "companyProfile");
      List<PictureVO> picList = PictureBO.queryPictureList(dao, userVO.getCompanyId());
      if (picList != null && picList.size() > 0) {
         PictureVO pictureVO = picList.get(0);
         if (userVO.getCompanyProfile() != null) {
            userVO.getCompanyProfile().setPictureVO(pictureVO);
         }
      }

      //去除用户角色
      //userVO.getCompanyProfile().setUserType(null);

      /*//若新增购物车中的商品，需要更新SESSION
      int msgCount = ShoppingCartBO.summeryAcount(dao, userVO);
      session.setAttribute(CommonConstants.SESSION.SHOPPING_CART_COUNT, msgCount);//将购物车统计放入session
      
      List<ShoppingCartVO> resultList = ShoppingCartBO.queryCartList(dao, userVO);
      for (ShoppingCartVO cartVO : resultList) {
         dao.fetchLinks(cartVO, "goodVO");
         GoodVO goodVO = cartVO.getGoodVO();
         //查询商品的封面图片
         cartVO.setCoverUrl(goodVO.getCoverUrl());
      }*/
      //session.setAttribute(CommonConstants.SESSION.SHOPPING_CART_LIST, resultList);//将购物车列表放入session

      if (userVO.getUserName().equals(CommonConstants.USER.ROOTUSERNAME)
            && userVO.getPassword().equals(CommonConstants.USER.ROOTPASSWORD)
            && userVO.getSalt().equals(CommonConstants.USER.ROOTSALT)) {
         re.setv("root", true);
      }

      subject.getSession().setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
      subject.getSession().setAttribute(CommonConstants.SESSION_LOGINNAME, userVO.getUserName());
      return re.setv("ok", true);
   }

   /**
    * 查询员工列表（带分页）
    * 
    */
   @At
   @RequiresUser
   @Ok("jsp:/manage/stuffManage/stuffManage.jsp")
   public Map<String, Object> showStuff(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         HttpSession session = request.getSession();
         UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (userVO != null) {
            String currentPageStr = StringUtils.trimToEmpty(request.getParameter("currentPage"));
            int currentPage = 1;
            if (currentPageStr.length() > 0) {
               currentPage = Integer.parseInt(currentPageStr);
            }

            String pageSizeStr = StringUtils.trimToEmpty(request.getParameter("pageSize"));
            int pageSize = CommonConstants.DEFAULT_PAGE_SIZE;
            if (pageSizeStr.length() > 0) {
               pageSize = Integer.parseInt(pageSizeStr);
            }

            QueryResult result = UserBO.queryStuff(dao, currentPage, pageSize, userVO);
            List<UserVO> resultList = result.getList(UserVO.class);

            map.put("stuffList", resultList);
            map.put("pageSize", pageSize);
            map.put("currentPage", currentPage);
            map.put("pageCount", result.getPager().getPageCount());
            map.put("recordCount", result.getPager().getRecordCount());
            return goPage(map);
         }
         return failure("获取员工信息失败", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取列表失败", map);
      }
   }

}
