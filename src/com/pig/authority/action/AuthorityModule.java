package com.pig.authority.action;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.mvc.upload.FieldMeta;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import com.pig.authority.bo.UserBO;
import com.pig.authority.dao.AuthorityDAO;
import com.pig.authority.service.PermissionService;
import com.pig.authority.service.UserService;
import com.pig.authority.shiro.realm.NutDaoRealm;
import com.pig.authority.vo.CompanyProfile;
import com.pig.authority.vo.Permission;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserRole;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.pig.system.action.BaseAction;
import com.pig.system.dao.UserDAO;
import com.pig.system.vo.PictureVO;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;

import net.sf.ehcache.CacheManager;
import net.sf.json.JSONObject;

/**
 * 角色/权限管理. 基本假设: 一个用户属于多种角色,拥有多种特许权限. 每种角色拥有多种权限
 * 
 * @author wendal
 */
@InjectName
@IocBean
@Fail("http:500")
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
//避免误写导致敏感信息泄露到服务器外
public class AuthorityModule extends BaseAction {
   private static final Log log = Logs.getLog(AuthorityModule.class);

   @Inject
   private Dao dao;

   @Inject
   protected CacheManager cacheManager;

   @Inject
   protected UserService userService;

   @Inject
   protected PermissionService permissionService;

   @Inject
   protected NutDaoRealm realm;

   @Inject
   protected UserModule userModule;

   /**
    * 用于显示角色-权限修改对话框的信息
    */
   @Ok("json")
   @At("/manage/modifyPermission")
   @RequiresPermissions({ "manage:authority" })
   public Object modifyPermission(@Param("roleId") String roleId, @Param("permissionId") String permissionId,
         @Param("isCheck") String isCheck) {
      Map<String, Object> map = new HashMap<String, Object>();
      Role role = dao.fetch(Role.class, Long.parseLong(StringUtils.trim(roleId)));
      if (role == null) {
         return failure("没有找到对应的角色", map);
      }
      Permission permission = dao.fetch(Permission.class, Long.parseLong(StringUtils.trim(permissionId)));
      if (permission == null) {
         return failure("没有找到对应的权限", map);
      }
      permissionService.updateRolePermission(role, permission, isCheck);
      cacheManager.clearAll();
      return success(null, map);
   }

   @Ok("json")
   @At("/manage/modifyRole")
   @RequiresPermissions({ "manage:authority" })
   public Object modifyRole(HttpServletRequest request, @Param("roleIds") String[] roleIdList) {
      Map<String, Object> map = new HashMap<String, Object>();
      Set<Long> permissionIdList = permissionService.queryPermissionByRole(roleIdList);
      map.put("pidList", permissionIdList);
      return success(null, map);
   }

   //进销存用户进入养殖平台的初始化
   @Ok("json")
   @At("/manage/jxcInti")
   public String jxcInti(HttpServletRequest request, @Param("userId") String userId) throws Exception {
      UserVO userVO = dao.fetch(UserVO.class, userId);
      if (userVO != null) {
         //根据新注册的企业id生成对应的一批角色记录
         AuthorityDAO.createDefaultRole(dao, userVO.getCompanyId());

         //获得对应的管理员角色
         Role role = dao.fetch(Role.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("name", "=", CommonConstants.ROLE.ROLE_ADMIN));
         //关联到当前注册的用户中，作为管理员帐号
         dao.insert(UserRole.class, Chain.make("userId", userVO.getUserId()).add("roleId", role.getId()));

         //根据新注册的管理员帐号生成默认权限（全权限）
         AuthorityDAO.createDefaultAdminPermission(dao, role.getId());
         //userModule.login(request, response, username, password, rememberMe, captcha)
         return "/jsp/user/login.jsp";
      }
      else {
         return "/manage/noAuth.jsp";
      }
   }

   @At("/manage/changePasswd")
   @Ok("raw")
   public String changePasswd(HttpServletRequest request, ServletContext context, @Param("oldpasswd") String oldpasswd,
         @Param("newpasswd") String newpasswd, @Param("newpasswd2") String newpasswd2) throws Exception {
      HttpSession session = request.getSession();
      UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      if (user != null && newpasswd.equals(newpasswd2)) {
         String oldEncPasswd = CommonUtils.getEncodedUserPasswords(oldpasswd, user.getSalt());
         if (user.getPassword().equalsIgnoreCase(oldEncPasswd)) {
            UserVO userVO = userService.updatePassword(user.getUserId(), newpasswd);
            if (userVO != null) {
               userVO = dao.fetchLinks(userVO, "companyProfile");
               session.setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
               return "OK";
            }
         }
      }

      return "ERROR";
   }

   @GET
   @At("/login")
   @Ok("jsp:jsp.user.login")
   public void loginPage() {
   }

   @At("/register")
   //@Ok("jsp:/register.jsp")
   @Ok("json")
   public Map<String, Object> register(HttpServletRequest request, ServletContext context,
         @Param("..") CompanyProfile companyProfile, @Param("loginAcount") String loginAcount,
         @Param("password") String password) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();

      HttpSession session = request.getSession();
      UserVO root = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      if (!root.getUserName().equals(CommonConstants.USER.ROOTUSERNAME)
            && !root.getPassword().equals(CommonConstants.USER.ROOTPASSWORD)
            && !root.getSalt().equals(CommonConstants.USER.ROOTSALT)) {
         return failure("注册失败!,您没有权限!", map);
      }

      if (UserDAO.isExistByLoginAcount(dao, loginAcount)) {
         map.put("companyProfile", companyProfile);
         return failure("注册失败，用户名已被使用！若你曾经注册过帐号请直接登录！", map);
      }
      else {

         companyProfile.setCompanyId(UUID.randomUUID().toString());
         companyProfile.setUserType(CommonConstants.USER.USER_TYPE_SALES);

         UserVO userVO = new UserVO();
         userVO.setUserId(UUID.randomUUID().toString());
         userVO.setIsvalid(CommonConstants.DB_CHAR_YES);
         userVO.setLoginAcount(loginAcount);
         userVO.setPassword(password);
         userVO.setLevel(CommonConstants.USER.USER_LEVEL_ENTERPRISE);
         userVO.setUserName(companyProfile.getContactName());
         userVO.setCellPhone(companyProfile.getContactPhone());
         userVO.setEmail(companyProfile.getContactEmail());
         userVO.setCompanyId(companyProfile.getCompanyId());
         userVO.setCompanyProfile(companyProfile);
         if (UserBO.registerUser(dao, userVO)) {
            return success("注册成功", map);
         }
         else {
            return failure("注册失败,请联系管理员!", map);
         }

      }
   }

   @At("/registerVerificationCode")
   @Filters
   @Ok("json")
   public Map<String, Object> registerVerificationCode(HttpServletRequest request, ServletContext context,
         @Param("phoneNum") String phoneNum, @Param("type") String type) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      if (type.equals("forget")) {
         if (!UserDAO.isExistByLoginAcount(dao, phoneNum)) {
            return failure("该手机号码尚未使用！", map);
         }
      }
      else {
         if (UserDAO.isExistByLoginAcount(dao, phoneNum)) {
            return failure("该手机号码已被使用！", map);
         }
      }
      String verificationCode = CommonUtils.randomNum6();
      JSONObject json = new JSONObject();
      json.put("name", "");
      json.put("OrderEmail", verificationCode);
      json.put("orderContact", "");
      json.put("orderPhone", "");
      HttpSession session = request.getSession();
      session.setAttribute(CommonConstants.SESSION.SESSION_PHONE, phoneNum);
      session.setAttribute(CommonConstants.SESSION.SESSION_VERIFICATIONCODE, verificationCode);
      session.setAttribute("type", type);
      map = CommonUtils.sendVerificationCode(json, phoneNum);
      return map;
   }

   @At("/registerVCode")
   @Filters
   @Ok("json")
   public Map<String, Object> registerVCode(HttpServletRequest request, ServletContext context,
         @Param("phoneNum") String phoneNum, @Param("vCode") String vCode, @Param("type") String type)
         throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         if (type.equals("forget")) {
            if (!UserDAO.isExistByLoginAcount(dao, phoneNum)) {
               return failure("该手机号码尚未使用！", map);
            }
         }
         else {
            if (UserDAO.isExistByLoginAcount(dao, phoneNum)) {
               return failure("该手机号码已被使用！", map);
            }
         }
         HttpSession session = request.getSession();
         String sessionPhone = (String) session.getAttribute(CommonConstants.SESSION.SESSION_PHONE);
         String sessionVCode = (String) session.getAttribute(CommonConstants.SESSION.SESSION_VERIFICATIONCODE);
         String sessionType = (String) session.getAttribute("type");
         if (phoneNum.equals(sessionPhone) && vCode.equals(sessionVCode) && type.equals(sessionType)) {
            return success("", map);
         }
         else {
            return failure("验证码错误", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("验证码错误", map);
      }
   }

   @At("/forgetPasswd")
   @Filters
   @Ok("json")
   public Map<String, Object> forgetPasswd(HttpServletRequest request, ServletContext context,
         @Param("phoneNum") String phoneNum, @Param("newpasswd") String newpasswd) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      if (UserDAO.isExistByLoginAcount(dao, phoneNum)) {
         userService.updatePassword(phoneNum, newpasswd);
         return success("修改成功", map);
      }
      else {
         return failure("该手机号码尚未使用！", map);
      }
   }

   /**
    * 获取随机UUID
    * 
    * @return Map
    */
   @At("/manage/getRandomUUID")
   @Ok("json")
   public Map<String, Object> getRandomUUID(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      String uuid = UUID.randomUUID().toString();
      map.put("uuid", uuid);
      return goPage(map);
   }

   /**
    * 展示首页
    * 
    * @return Map
    */
   /*@At("/manage/showIndex")
   @Ok("jsp:/manage/index.jsp")
   public Map<String, Object> showIndex(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      if (userVO != null) {
         //统计当天数据
         Map<String, Object> countMap = OrderBO.orderSummery(dao, userVO);
         map.put("todayCount", countMap.get("todayCount"));
         map.put("todayAcount", countMap.get("todayAcount"));
         map.put("weekCount", countMap.get("weekCount"));
         map.put("weekAcount", countMap.get("weekAcount"));
         map.put("monthCount", countMap.get("monthCount"));
         map.put("monthAcount", countMap.get("monthAcount"));
         map.put("orderSummeryList", countMap.get("orderSummeryList"));
         map.put("customSummeryList", countMap.get("customSummeryList"));
         map.put("goodSummeryList", countMap.get("goodSummeryList"));
         int userCount = UserBO.getCompanyUserCount(dao, userVO);
   
         map.put("userCount", userCount);
      }
      return goPage(map);
   }*/

   /**
    * 修改企业信息
    * 
    * @return Map
    */
   @At("/manage/changeProfile")
   @Ok("jsp:/manage/myProfile.jsp")
   @AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/uploadTemp", "8192", "UTF-8", "10" })
   public Map<String, Object> changeProfile(HttpServletRequest request, ServletContext context,
         @Param("file") TempFile[] tempFile, @Param("..") CompanyProfile companyProfile) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null) {
            //更新session中的企业资料
            //user.setCompanyProfile(companyProfile);

/*            String contextPath = context.getRealPath(CommonConstants.UPLOAD_IMG_DIR);
File fileDir = new File(contextPath);
if (!fileDir.exists()) {
   fileDir.mkdir();
}*/
            PictureVO pictureVO = null;
            if (tempFile != null && tempFile.length > 0) {
               File file = tempFile[0].getFile();
               FieldMeta meta = tempFile[0].getMeta();
               String uuid = companyProfile.getCompanyId();
               String fileName = UUID.randomUUID().toString() + meta.getFileExtension();

               Map<String, Object> configMap = CommonUtils.configByQiNiu(CommonConstants.PQUPLOADIMG,
                     "uploadImg" + "/" + fileName);
               try {
                  UploadManager uploadManager = (UploadManager) configMap.get("uploadManager");
                  Response qresponse = uploadManager.put(tempFile[0].getInputStream(), configMap.get("key").toString(),
                        configMap.get("upToken").toString(), null, null);
                  JSONObject json = JSONObject.fromObject(qresponse.bodyString());
                  System.out.println(json);
                  if (json.get("key") != null && !json.get("key").equals("")) {
                     pictureVO = new PictureVO();
                     pictureVO.setCreateDate(new Date());
                     pictureVO.setPicName(meta.getFileLocalName());
                     pictureVO.setPicSize((int) file.length());
                     pictureVO.setUploadUrl(CommonConstants.UPLOAD_IMG_DIR + "/" + fileName);
                     pictureVO.setPicUuid(uuid);
                     pictureVO.setIsCover("Y");
                  }
                  else {
                     return failure("头像上传失败！", configMap);
                  }
               }
               catch (Exception e) {
                  System.out.println("头像上传异常！");
                  return failure("头像上传异常！", configMap);
               }

               //FileUtils.copyFile(file, new File(contextPath, fileName));

            }

            if (UserBO.changeProfile(dao, companyProfile, pictureVO)) {
               if (pictureVO != null) {
                  companyProfile.setPictureVO(pictureVO);
                  user.setCompanyProfile(companyProfile);
               }
               else {
                  //更新session中的企业资料
                  companyProfile.setPictureVO(user.getCompanyProfile().getPictureVO());
                  user.setCompanyProfile(companyProfile);
               }

               session.setAttribute(CommonConstants.SESSION_USER_KEY, user);
               return success("保存成功", map);
            }
            else {
               return failure("保存信息失败", map);
            }
         }
         return failure("找不到用户信息", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("用户保存信息失败", map);
      }
   }

   /**
    * 编辑个人信息
    * 
    * @return Map
    */
   @At("/manage/changeUserInfo")
   @Ok("jsp:/manage/myProfile.jsp")
   public Map<String, Object> changeUserInfo(HttpServletRequest request, ServletContext context,
         @Param("file") TempFile[] tempFile, @Param("..") UserVO userVO) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null) {
            user.setCellPhone(userVO.getCellPhone());
            user.setEmail(userVO.getEmail());
            user.setUserName(userVO.getUserName());
            user.setDeparture(userVO.getDeparture());
            user.setPost(userVO.getPost());

            String contextPath = context.getRealPath(CommonConstants.UPLOAD_IMG_DIR);
            File fileDir = new File(contextPath);
            if (!fileDir.exists()) {
               fileDir.mkdir();
            }
            PictureVO pictureVO = null;
            if (tempFile != null && tempFile.length > 0) {
               File file = tempFile[0].getFile();
               FieldMeta meta = tempFile[0].getMeta();
               String uuid = user.getUserId();
               String fileName = UUID.randomUUID().toString() + meta.getFileExtension();
               FileUtils.copyFile(file, new File(contextPath, fileName));
               pictureVO = new PictureVO();
               pictureVO.setCreateDate(new Date());
               pictureVO.setPicName(meta.getFileLocalName());
               pictureVO.setPicSize((int) file.length());
               pictureVO.setUploadUrl(CommonConstants.UPLOAD_IMG_DIR + "/" + fileName);
               pictureVO.setPicUuid(uuid);
               pictureVO.setIsCover("Y");
            }

            if (UserBO.changeUserInfo(dao, userVO, pictureVO)) {
               if (pictureVO != null) {
                  user.setPictureVO(pictureVO);
               }
               session.setAttribute(CommonConstants.SESSION_USER_KEY, user);
               return success("保存成功", map);
            }
            else {
               return failure("保存信息失败", map);
            }
         }
         return failure("找不到用户信息", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("用户保存信息失败", map);
      }
   }

   /**
    * 展示首页
    * 
    * @return Map
    */
   @At("/manage/showProfile")
   @Ok("jsp:/manage/myProfile.jsp")
   public Map<String, Object> showProfile(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      return goPage(map);
   }

   /**
    * 展示首页
    * 
    * @return Map
    */
   @At("/manage/showNoAuth")
   @Ok("jsp:/manage/noAuth.jsp")
   public Map<String, Object> showNoAuth(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      return goPage(map);
   }
}
