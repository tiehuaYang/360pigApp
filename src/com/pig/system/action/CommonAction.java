package com.pig.system.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.adaptor.JsonAdaptor;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.system.bo.PictureBO;
import com.pig.system.dao.PictureDAO;
import com.pig.system.dao.UserDAO;
import com.pig.system.vo.PictureVO;

/*
 * 
 * 图片附件管理ACTION层 
 * 
 * 功能模块包括
 *  delPicture          删除图片 
 *  
 *  @author Erick
 */

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
public class CommonAction extends BaseAction {
   private static final Log log = Logs.getLog(CommonAction.class);
   @Inject
   private Dao dao;

   /**
    * 删除图片
    * 
    * @return Map
    */
   @At("/manage/delPicture")
   @Ok("json")
   public Map<String, Object> delPicture(HttpServletRequest request, @Param("pictureId") long id,
         @Param("billId") String billId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         PictureBO.delPicture(dao, id);
         List<PictureVO> resultList = PictureDAO.queryPictureList(dao, billId);
         map.put("resultList", resultList);
         return success("删除成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         map.put("msg", "getFailure");
         return map;
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
   @At("/manage/showIndex")
   @Ok("jsp:/manage/index.jsp")
   public Map<String, Object> showIndex(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      if (userVO != null) {
         int userCount = 0;
         int taskCount = 0;
         int hisTaskCount = 0;
         int msgCount = 0;
         try {
            userCount = dao.count(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()));
         }
         catch (Exception e) {
            e.printStackTrace();
            log.error(e);
         }
         map.put("userCount", userCount);
         map.put("taskCount", taskCount);
         map.put("hisTaskCount", hisTaskCount);
         map.put("msgCount", msgCount);
      }
      return goPage(map);
   }

   /**
    * 品类信息查询--用于子页面查询品类信息时使用
    * 引用模块：养殖计划
    * 
    * @return Map
    */
   @At("/manage/queryPeopleList")
   @Ok("jsp:/manage/common/queryPeopleList.jsp")
   public Map<String, Object> queryPeopleList(HttpServletRequest request, @Param("type") String type) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         if (user != null) {
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
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取列表失败", map);
      }
   }

   /**
    * 动态更新当前通知
    * 
    * @param alarmId 告警ID
    * 
    * @return Map
    */
   @At("/manage/updateMessage")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> updateMessage(HttpServletRequest request, ServletContext context) {
      Map<String, Object> map = new HashMap<String, Object>();
      int msgCount = 0;
      /*List<AlarmVO> alarmList = null;*/
      try {
         /*HttpSession session = request.getSession();
         UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
         msgCount = TaskBO.msgCount(dao, userVO);
         session.setAttribute(CommonConstants.SESSION.ALARM_COUNT, msgCount);//将告警数放入session
         
         QueryResult result = TaskBO.showMsgList(dao, 1, 7, userVO, null);
         alarmList = result.getList(AlarmVO.class);
         session.setAttribute(CommonConstants.SESSION.ALARM_LIST, alarmList);//将告警列表（最多7条）放入session
         */ return success("列表更新成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("告警列表查询失败", map);
      }
   }

   public void setDao(Dao dao) {
      this.dao = dao;
   }

}
