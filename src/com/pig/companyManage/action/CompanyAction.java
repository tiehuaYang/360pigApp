package com.pig.companyManage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.pig.authority.bo.UserBO;
import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.system.action.BaseAction;
import com.pig.system.dao.UserDAO;

/*
 * 
 * 企业管理ACTION层 
 * 
 * 功能模块包括
 *  saveUser    用户注册 
 *  editUser     用户编辑 
 *  showUser   查询用户列表 
 *  delUser      用户删除
 *  
 *  @author Erick
 */

@InjectName
@IocBean
public class CompanyAction extends BaseAction
{
   private static final Log log = Logs.getLog(CompanyAction.class);
   @Inject
   private Dao dao;

   /**
    * 用户资料编辑
    * 
    * @param userId
    * 
    * @return Map
    */
   @At("/manage/editUser")
   @Ok("jsp:/manage/companyManage/editUser.jsp")
   public Map<String, Object> editUser(@Param("userId")
   String userId)
   {
      Map<String, Object> map = new HashMap<String, Object>();
      try
      {
         UserVO userVO = new UserVO();
         if (!StringUtils.isBlank(userId)) {
            userVO = dao.fetch(UserVO.class, userId);
         }
         map.put("userVO", userVO);
         return goPage(map);

      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
         return failure("编辑失败", map);
      }
   }

   /**
    * 新增用户
    * 
    * @param userId
    * @param loginAcount
    * @param password
    * @param userName
    * @param cellPhone
    * @param email
    * @param departure
    * @param post
    * 
    * @return Map
    */
   @At("/manage/saveUser")
   @Ok("jsp:/manage/companyManage/editUser.jsp")
   public Map<String, Object> saveUser(HttpServletRequest request, @Param("..")
   UserVO userVO, @Param("roleId")
   String[] roleIds, ServletContext context)
   {
      Map<String, Object> map = new HashMap<String, Object>();

      try
      {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null)
         {
            UserVO userTemp = dao.fetch(UserVO.class, userVO.getUserId());
            if (userTemp == null)
            {
               userVO.setUserId(UUID.randomUUID().toString());
               userVO.setIsvalid(CommonConstants.DB_CHAR_YES);
               userVO.setParentId(user.getUserId());
               // userVO.setLevel(CommonConstants.USER.USER_LEVEL_PERSONAL);
               userVO.setCompanyId(user.getCompanyId());
               map.put("userVO", userVO);
               if (UserDAO.isExistByAcount(dao, userVO)) {
                  return failure("注册失败，该登录帐号已被使用！", map);
               }
               else
               {
                  UserBO.createUser(dao, userVO, roleIds);
                  return success("保存成功", map);
               }
            }
            else
            {
               userTemp.setUserName(userVO.getUserName());
               userTemp.setCellPhone(userVO.getCellPhone());
               userTemp.setEmail(userVO.getEmail());
               userTemp.setDeparture(userVO.getDeparture());
               userTemp.setPost(userVO.getPost());
               map.put("userVO", userTemp);
               UserDAO.modifyUser(dao, userTemp, null);
               return success("保存成功", map);
            }
         }
         return failure("获取用户信息失败", map);
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
         return failure("用户保存信息失败", map);
      }
   }

   @At("/manage/showUser")
   @Ok("jsp:/manage/companyManage/userManage.jsp")
   public Map<String, Object> showUser(HttpServletRequest request)
   {
      Map<String, Object> map = new HashMap<String, Object>();
      try
      {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null)
         {
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

            Map<String, String> queryMap = new HashMap<String, String>();
            queryMap.put("acount", StringUtils.trimToEmpty(request.getParameter("acount")));
            queryMap.put("userName", StringUtils.trimToEmpty(request.getParameter("userName")));
            queryMap.put("dep", StringUtils.trimToEmpty(request.getParameter("dep")));
            queryMap.put("cellPhone", StringUtils.trimToEmpty(request.getParameter("cellPhone")));
            map.put("queryMap", queryMap);

            QueryResult result = UserDAO.querySubUserList(dao, user.getUserId(), currentPage, pageSize, user, queryMap);
            List<UserVO> resultList = result.getList(UserVO.class);

            map.put("userList", resultList);
            map.put("pageSize", pageSize);
            map.put("currentPage", currentPage);
            map.put("pageCount", result.getPager().getPageCount());
            map.put("recordCount", result.getPager().getRecordCount());
            return goPage(map);
         }
         return failure("获取用户信息失败", map);
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
         return failure("获取列表失败", map);
      }
   }

   @At("/manage/delUser")
   @Ok("jsp:/manage/companyManage/userManage.jsp")
   public Map<String, Object> delUser(HttpServletRequest request, ServletContext context, @Param("userId")
   String userId)
   {
      Map<String, Object> map = new HashMap<String, Object>();
      try
      {
         if (StringUtils.isBlank(userId)) {
            return failure("删除失败，userId不可为空!", map);
         }
         else
         {
            UserVO userVO = dao.fetch(UserVO.class, userId);
            if (userVO == null) {
               return failure("获取实例失败!", map);
            }
            else
            {
               dao.delete(UserVO.class, userId);
               return success("删除成功", map);
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
         return failure("删除失败", map);
      }
   }

   @At("/manage/queryUserForTask")
   @Ok("jsp:/manage/taskManage/subPage/peopleList.jsp")
   public Map<String, Object> queryUserForTask(HttpServletRequest request)
   {
      Map<String, Object> map = new HashMap<String, Object>();
      try
      {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null)
         {
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

            QueryResult result = UserDAO.querySubUserList(dao, user.getUserId(), currentPage, pageSize, user, null);
            List<UserVO> resultList = result.getList(UserVO.class);

            map.put("userList", resultList);
            map.put("pageSize", pageSize);
            map.put("currentPage", currentPage);
            map.put("pageCount", result.getPager().getPageCount());
            map.put("recordCount", result.getPager().getRecordCount());
            return goPage(map);
         }
         return failure("获取用户信息失败", map);
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
         return failure("获取列表失败", map);
      }
   }

}
