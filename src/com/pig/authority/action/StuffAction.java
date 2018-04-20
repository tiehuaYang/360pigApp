package com.pig.authority.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.pig.authority.bo.UserBO;
import com.pig.authority.dao.AuthorityDAO;
import com.pig.authority.service.AuthorityService;
import com.pig.authority.service.RoleService;
import com.pig.authority.service.UserService;
import com.pig.authority.vo.PermissionModule;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.system.action.BaseAction;
import com.pig.system.dao.UserDAO;

/*
 * 
 * 经销商管理ACTION层 
 * 
 * 功能模块包括
 *  saveStuff    员工注册 
 *  editStuff     员工编辑 
 *  showStuff   查询员工列表 
 *  delStuff      员工删除
 *  
 *  @author Erick
 */

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
public class StuffAction extends BaseAction {
   private static final Log log = Logs.getLog(StuffAction.class);
   @Inject
   private Dao dao;

   @Inject
   private RoleService roleService;

   @Inject
   private AuthorityService authorityService;

   /**
    * 查询员工列表（带分页）
    */
   @At("/manage/showStuff")
   @Ok("jsp:/manage/stuffManage/stuffManage.jsp")
   public Map<String, Object> showStuff(HttpServletRequest request, @Param("roleId") String roleId,
         @Param("page") String page) {
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

            Role currRole = null;
            if (roleId != null && roleId.length() > 0) {
               currRole = roleService.fetchById(Long.parseLong(roleId));
            }
            else {
               currRole = roleService.fetchAdmin(userVO.getCompanyId());//默认获取admin的角色权限列表
            }
            List<PermissionModule> pmList = authorityService.queryPermissionList(currRole, userVO.getCompanyId());
            map.put("pmList", pmList);

            List<Role> roleList = AuthorityDAO.queryAllRoleList(dao, userVO.getCompanyId());
            map.put("roleList", roleList);

            map.put("page", page);
            map.put("roleId", currRole.getId());
            map.put("isAdmin", currRole.getName().equals(CommonConstants.ROLE.ROLE_ADMIN) ? "Y" : "N");
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

   /**
    * 展示经销商编辑页面
    * 
    * @param userId
    * @return Map
    */
   @At("/manage/editStuff")
   @Ok("jsp:/manage/stuffManage/editStuff.jsp")
   public Map<String, Object> editJoinIn(HttpServletRequest request, @Param("userId") String userId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         if (!StringUtils.isBlank(userId)) {
            UserVO userVO = dao.fetch(UserVO.class, userId);
            if (userVO != null) {
               Map<String, Object> result = roleService.queryCheckRoleList(dao, userVO.getCompanyId(), userVO);
               map.put("roleList", result.get("roleList"));
               map.put("pmList", result.get("pmList"));
               map.put("userVO", userVO);
               return goPage(map);
            }
            else {
               return failure("找不到对应的用户", map);
            }
         }
         else {
            HttpSession session = request.getSession();
            UserVO currUserVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
            List<PermissionModule> pmList = authorityService.queryPermissionList(null, currUserVO.getCompanyId());
            map.put("pmList", pmList);
            List<Role> roleList = AuthorityDAO.queryAllRoleList(dao, currUserVO.getCompanyId());
            map.put("roleList", roleList);

            UserVO userVO = new UserVO();
            userVO.setUserId(UUID.randomUUID().toString());
            map.put("isNew", "Y");
            map.put("userVO", userVO);
            return goPage(map);
         }

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("编辑失败", map);
      }
   }

   /**
    * 新增或编辑经销商
    * 
    * @param userId
    * @param loginAcount
    * @param password
    * @param userName
    * @param cellPhone
    * @param email
    * @param departure
    * @param post
    * @return Map
    */
   @At("/manage/saveStuff")
   @RequiresPermissions({ "manage:authority" })
   @Ok("jsp:/manage/stuffManage/editStuff.jsp")
   public Map<String, Object> saveStuff(HttpServletRequest request, @Param("..") UserVO userVO,
         @Param("roleId") String[] roleIds, ServletContext context) {
      Map<String, Object> map = new HashMap<String, Object>();

      try {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null) {
            UserVO userTemp = dao.fetch(UserVO.class, userVO.getUserId());
            if (userTemp == null) {
               userVO.setIsvalid(CommonConstants.DB_CHAR_YES);
               userVO.setParentId(user.getUserId());
               userVO.setCompanyId(user.getCompanyId());
               map.put("userVO", userVO);
               if (UserDAO.isExistByAcount(dao, userVO)) {
                  return failure("创建失败，该登录帐号已被使用！", map);
               }
               else {
                  UserBO.createUser(dao, userVO, roleIds);
                  return success("创建成功", map);
               }
            }
            else {
               userTemp.setUserName(userVO.getUserName());
               userTemp.setCellPhone(userVO.getCellPhone());
               userTemp.setEmail(userVO.getEmail());
               userTemp.setEmployDate(userVO.getEmployDate());
               userTemp.setDeparture(userVO.getDeparture());
               userTemp.setPost(userVO.getPost());
               map.put("userVO", userTemp);
               UserBO.modifyUser(dao, userTemp, null, roleIds);
               return success("保存成功", map);
            }
         }
         return failure("获取员工信息失败", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("员工保存信息失败", map);
      }
   }

   /**
    * 删除员工
    * 
    * @param userId
    * @return Map
    */
   @At("/manage/delStuff")
   //@RequiresPermissions({ "manage:authority" })
   //@Ok("jsp:/manage/stuffManage/stuffManage.jsp")
   @Ok("json")
   public Map<String, Object> delStuff(HttpServletRequest request, ServletContext context,
         @Param("userId") String userId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Subject subject = SecurityUtils.getSubject();
         if (subject.hasRole("admin")) {

            if (StringUtils.isBlank(userId)) {
               return failure("删除失败，userId不可为空!", map);
            }
            else {
               UserVO stuffVO = dao.fetch(UserVO.class, userId);
               if (stuffVO == null) {
                  return failure("获取实例失败!", map);
               }
               else {
                  dao.delete(UserVO.class, userId);
                  return success("删除成功", map);
               }
            }
         }
         else {
            return failure("您没有该权限，请联系你们的平台管理员进行授权", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除失败", map);
      }
   }

   @Inject
   UserService userService;

   /**
    * 重置员工密码
    * 
    * @param userId
    * @return Map
    */
   @At("/manage/resetpd")
   @Ok("json")
   public Map<String, Object> resetpd(HttpServletRequest request, ServletContext context,
         @Param("userId") String userId, @Param("czhdpd") String czhdpd) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Subject subject = SecurityUtils.getSubject();
         if (subject.hasRole("admin")) {
            HttpSession session = request.getSession();
            UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
            if (userVO.getUserId().equals(userId)) {
               return failure("重置失败，不能重置自己的密码!", map);
            }
            if (StringUtils.isBlank(userId)) {
               return failure("重置失败，userId不可为空!", map);
            }
            else {
               UserVO stuffVO = userService.updatePassword(userId, czhdpd);
               if (stuffVO == null) {
                  return failure("获取实例失败!", map);
               }
               return success("重置成功", map);
            }
         }
         else {
            return failure("您没有该权限，请联系你们的平台管理员进行授权", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("重置失败", map);
      }
   }
}
