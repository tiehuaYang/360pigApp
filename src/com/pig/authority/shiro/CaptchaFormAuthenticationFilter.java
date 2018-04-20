package com.pig.authority.shiro;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.json.Json;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;

import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.system.bo.PictureBO;
import com.pig.system.vo.PictureVO;

/**
 * @author 科技㊣²º¹³ 2014年2月3日 下午4:48:45 http://www.rekoe.com QQ:5382211
 * @author wendal<wendal1985@gmail.com>
 * @author Erick
 */
public class CaptchaFormAuthenticationFilter extends FormAuthenticationFilter implements ActionFilter {

   protected String JsonParams_KEY = "CaptchaFormAuthenticationFilter_JsonParams";

   private String captchaParam = NutShiro.DEFAULT_CAPTCHA_PARAM;

   public String getCaptchaParam() {
      return captchaParam;
   }

   public String getCleanParams(ServletRequest request, String name) {
      HttpServletRequest req = (HttpServletRequest) request;
      NutMap jsonParams = (NutMap) req.getAttribute(JsonParams_KEY);
      if (jsonParams != null && jsonParams.containsKey(name)) {
         return StringUtils.clean(jsonParams.getString(name));
      }
      return WebUtils.getCleanParam(request, name);
   }

   protected String getCaptcha(ServletRequest request) {
      return getCleanParams(request, getCaptchaParam());
   }

   @Override
   protected String getUsername(ServletRequest request) {
      return getCleanParams(request, getUsernameParam());
   }

   @Override
   protected String getPassword(ServletRequest request) {
      return getCleanParams(request, getPasswordParam());
   }

   @Override
   protected boolean isRememberMe(ServletRequest request) {
      String value = getCleanParams(request, getRememberMeParam());
      return value != null && (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("t")
            || value.equalsIgnoreCase("1") || value.equalsIgnoreCase("enabled") || value.equalsIgnoreCase("y")
            || value.equalsIgnoreCase("yes") || value.equalsIgnoreCase("on"));
   }

   @Override
   protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
      String captcha = getCaptcha(request);
      Subject subject = getSubject(request, response);
      Session session = subject.getSession(false);
      if (Strings.isBlank(captcha)) {
         return onCaptchaError(request, response);
      }
      if (session == null) {
         return onCaptchaError(request, response);
      }
      HttpServletRequest req = (HttpServletRequest) request;
      if (req.getHeader("Content-Type") != null && req.getHeader("Content-Type").contains("json")) {
         NutMap jsonParams = Json.fromJson(NutMap.class, req.getReader());
         req.setAttribute(JsonParams_KEY, jsonParams);
      }
      Object _expected = session.getAttribute(captchaParam);
      if (_expected == null) {
         _expected = session.getAttribute("nutz_captcha");
      }
      if (_expected == null) {
         return onCaptchaError(request, response);
      }
      if (!captcha.equalsIgnoreCase(String.valueOf(_expected))) {
         return onCaptchaError(request, response);
      }
      String username = getUsername(request);
      String password = getPassword(request);
      boolean rememberMe = isRememberMe(request);
      String host = getHost(request);
      AuthenticationToken token = new CaptchaUsernamePasswordToken(username, password, rememberMe, host, captcha);
      try {
         //检查是否有登录权限
         Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
         UserVO userVO = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", username));
         if (userVO.getUserName().equals(CommonConstants.USER.ROOTUSERNAME)
               && userVO.getPassword().equals(CommonConstants.USER.ROOTPASSWORD)
               && userVO.getSalt().equals(CommonConstants.USER.ROOTSALT)) {
         }
         else {
            String face = new Sha256Hash(password, userVO.getSalt()).toHex();
            if (!userVO.getPassword().equals(face)) {
               NutMap re = new NutMap().setv("ok", false).setv("msg", "用户名或密码错误");
               NutShiro.rendAjaxResp(request, response, re);
               return false;
            }
            int check = checkPermission(dao, userVO.getUserId(), "system:login");
            if (check <= 0) {
               NutMap re = new NutMap().setv("ok", false).setv("msg", "您没有登录后台管理系统的权限！请联系管理员！");
               NutShiro.rendAjaxResp(request, response, re);
               return false;
            }
         }

         //有登录权限
         subject.login(token);
         return onLoginSuccess(token, subject, request, response);
      }
      catch (AuthenticationException e) {
         return onLoginFailure(token, e, request, response);
      }
   }

   protected boolean onCaptchaError(ServletRequest req, ServletResponse resp) {
      if (NutShiro.isAjax(req)) {
         NutMap re = new NutMap().setv("ok", false).setv("msg", "验证码错误");
         NutShiro.rendAjaxResp(req, resp, re);
         return false;
      }
      else {
         return super.onLoginFailure(null, new AuthenticationException("验证码错误"), req, resp);
      }
   }

   @Override
   protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest req,
         ServletResponse resp) {
      if (NutShiro.isAjax(req)) {
         NutMap re = new NutMap().setv("ok", false).setv("msg", "登陆失败");
         NutShiro.rendAjaxResp(req, resp, re);
         return false;
      }
      return super.onLoginFailure(token, e, req, resp);
   }

   @Override
   protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest req,
         ServletResponse resp) throws Exception {
      subject.getSession().setAttribute(NutShiro.SessionKey, subject.getPrincipal());
      Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
      UserVO user = dao.fetchLinks(dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", getUsername(req))),
            "companyProfile");
      if (user == null) {
         NutMap re = new NutMap().setv("ok", false).setv("msg", "用户名或密码错误");
         NutShiro.rendAjaxResp(req, resp, re);
         return false;
      }
      else {
         user.setLastLoginDate(new Date());
         dao.update(user);//修改用户上次登录时间

         List<PictureVO> picList = PictureBO.queryPictureList(dao, user.getCompanyId());
         if (picList != null && picList.size() > 0) {
            PictureVO pictureVO = picList.get(0);
            user.getCompanyProfile().setPictureVO(pictureVO);
         }
      }

/*      int msgCount = 0;
List<AlarmVO> alarmList = null;
msgCount = TaskBO.msgCount(dao, user);
subject.getSession().setAttribute(CommonConstants.SESSION.ALARM_COUNT, msgCount);//将告警数放入session

QueryResult result = TaskBO.showMsgList(dao, 1, 7, user, null);
alarmList = result.getList(AlarmVO.class);
subject.getSession().setAttribute(CommonConstants.SESSION.ALARM_LIST, alarmList);//将告警列表（最多7条）放入session
*/
      subject.getSession().setAttribute(CommonConstants.SESSION_USER_KEY, user);
      subject.getSession().setAttribute(CommonConstants.SESSION_LOGINNAME, user.getUserName());

      NutMap re = new NutMap();

      if (user.getUserName().equals(CommonConstants.USER.ROOTUSERNAME)
            && user.getPassword().equals(CommonConstants.USER.ROOTPASSWORD)
            && user.getSalt().equals(CommonConstants.USER.ROOTSALT)) {
         re.setv("root", true);
      }

      if (NutShiro.isAjax(req)) {
         NutShiro.rendAjaxResp(req, resp, re.setv("ok", true));
         return false;
      }
      return super.onLoginSuccess(token, subject, req, resp);
   }

   @Override
   public View match(ActionContext ac) {
      HttpServletRequest request = ac.getRequest();
      AuthenticationToken authenticationToken = createToken(request, ac.getResponse());
      request.setAttribute("loginToken", authenticationToken);
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