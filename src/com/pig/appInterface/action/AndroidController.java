package com.pig.appInterface.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.sql.Criteria;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.pig.appInterface.bo.AndroidBO;
import com.pig.authority.service.UserService;
import com.pig.authority.vo.UserVO;
import com.pig.breedManage.vo.FarmPenVO;
import com.pig.breedManage.vo.FarmVO;
import com.pig.breedManage.vo.PigCategoryVO;
import com.pig.breedManage.vo.PigChildBirthVO;
import com.pig.breedManage.vo.PigMatingPairVO;
import com.pig.breedManage.vo.PigMatingVO;
import com.pig.breedManage.vo.PigPregnancyVO;
import com.pig.breedManage.vo.PigStrainVO;
import com.pig.breedManage.vo.PigsVO;
import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.pig.common.DateUtils;
import com.pig.joinInManage.vo.GoodsVO;
import com.pig.joinInManage.vo.SupplierVO;
import com.pig.summryManage.vo.SummryMatingVO;
import com.pig.summryManage.vo.SummryVO;
import com.pig.system.action.BaseAction;
import com.pig.system.dao.UserDAO;

/*
 * 
 * 统一管理安卓端应用请求
 * 
 * 功能模块包括
 *  appLogin                           登录 
 *  appLogout                        注销
 *  getUserInfo                       获取当前用户信息
 *  showPendingTaskList     养殖任务待办任务列表 
 *  showReportTask              展示每日反馈页面，查询需要填写的细项列表 
 *  createTask                         创建养殖任务
 *  saveSubTask                     每日任务反馈
 *  queryCategoryForTask   查询可以生成任务的品类列表
 *  
 *  @author Erick
 */

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/app/error.html" }))
public class AndroidController extends BaseAction {
   private static final Log log = Logs.getLog(AndroidController.class);
   @Inject
   private Dao dao;

   @Inject
   protected UserService userService;
   @Inject
   protected AndroidBO androidBO;

   @At("/appLogin")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   @Filters
   public Map<String, Object> appLogin(HttpServletRequest request, HttpServletResponse response,
         @Param("userAccount") String userAccount, @Param("passwd") String passwd) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      UserVO user = UserDAO.authUser(dao, userAccount, passwd);
      if (user != null) {
         log.info(user.getUserName() + " logged in.");
         HttpSession session = request.getSession();
         session.setAttribute(CommonConstants.SESSION_USER_KEY, user);
         session.setAttribute(CommonConstants.SESSION_LOGINNAME, user.getUserName());
         String sessionId = session.getId();
         map.put("sessionId", sessionId);
         map.put("userId", user.getUserId());
         map.put("userName", user.getUserName());
         return success("登录成功", map);
      }
      return failure("登录失败，请输入正确的帐号密码", map);
   }

   @At("/appLogout")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> doLogout(HttpServletRequest request, ServletContext context) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         HttpSession session = request.getSession();
         session.invalidate();
         return success("注销成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("注销失败", map);
      }
   }

   @At("/app/getUserInfo")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> getUserInfo(HttpServletRequest request) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO user = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      if (user != null) {
         //user.setPassword(null);
         //user.setSalt(null);
         //图片域名
         map.put("QIMGS", CommonConstants.QIMGS);
         map.put("userVO", user);
         return success("获取成功", map);
      }
      else {
         return failure("获取失败，请重新登录", map);
      }

   }

   /*..............................................新的部分.....................................................*/

   /**
    * 查询默认猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/queryDefaultFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryDefaultFarm(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         FarmVO farmVO = dao.fetch(FarmVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm()));
         map.put("farmVO", farmVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/queryFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryFarm(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<FarmVO> farmVO = dao.query(FarmVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()));
         map.put("farmVO", farmVO);
         map.put("defaultFarm", userVO.getDefaultFarm());
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询指定猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/fetchFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> fetchFarm(HttpServletRequest request, @Param("farmId") String farmId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         FarmVO farmVO = dao.fetch(FarmVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", farmId));
         map.put("farmVO", farmVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 创建猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/saveFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> saveFarm(HttpServletRequest request, @Param("..") FarmVO farmVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (farmVO.getFarmId() != null && farmVO.getFarmId().length() > 0) {
            FarmVO temp = dao.fetch(FarmVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
                  .and("farmId", "!=", farmVO.getFarmId()).and("farmName", "=", farmVO.getFarmName()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               dao.updateIgnoreNull(farmVO);
               return success("修改成功", map);
            }
         }
         else {
            FarmVO temp = dao.fetch(FarmVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmName", "=", farmVO.getFarmName()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               farmVO.setFarmId(UUID.randomUUID().toString());
               farmVO.setCompanyId(userVO.getCompanyId());
               farmVO.setCreateTime(new Date());
               dao.insert(farmVO);
               userVO.setDefaultFarm(farmVO.getFarmId());
               dao.update(userVO);
               session.setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
               return success("保存成功", map);
            }
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("保存失败", map);
      }
   }

   /**
    * 删除猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/deleteFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> deleteFarm(HttpServletRequest request, @Param("farmId") String farmId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<PigsVO> pigsVOs = dao.query(PigsVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", farmId));
         if (pigsVOs != null && pigsVOs.size() > 0) {
            return failure("不能删除存在猪只的猪场", map);
         }
         else {
            dao.update(UserVO.class, Chain.make("defaultFarm", null), Cnd.where("defaultFarm", "=", farmId));
            dao.clear(FarmVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", farmId));
            dao.clear(FarmPenVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", farmId));
            return success("删除成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("删除失败", map);
      }
   }

   /**
    * 选择使用猪场
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/usingFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> usingFarm(HttpServletRequest request, @Param("farmId") String farmId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         userVO.setDefaultFarm(farmId);
         dao.update(userVO);
         session.setAttribute(CommonConstants.SESSION_USER_KEY, userVO);
         return success("选择成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("选择失败", map);
      }
   }

   /**
    * 查询猪舍
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/queryPen")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPen(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<FarmPenVO> farmVO = dao.query(FarmPenVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm()));
         map.put("farmVO", farmVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询指定猪舍
    * 
    * @param FarmVO 猪舍详细信息
    * @return Map
    */
   @At("/app/fetchPen")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> fetchPen(HttpServletRequest request, @Param("farmPenId") String farmPenId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
               .and("farmId", "=", userVO.getDefaultFarm()).and("farmPenId", "=", farmPenId));
         map.put("farmPenVO", farmPenVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 创建猪舍
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/savePen")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> savePen(HttpServletRequest request, @Param("..") FarmPenVO farmPenVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (farmPenVO.getPenId() != null && farmPenVO.getPenId().length() > 0) {
            FarmPenVO temp = dao.fetch(FarmPenVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm())
                        .and("penId", "!=", farmPenVO.getPenId()).and("penName", "=", farmPenVO.getPenName()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               dao.updateIgnoreNull(farmPenVO);
               return success("修改成功", map);
            }
         }
         else {
            FarmPenVO temp = dao.fetch(FarmPenVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
                  .and("farmId", "=", userVO.getDefaultFarm()).and("penName", "=", farmPenVO.getPenName()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               farmPenVO.setPenId(UUID.randomUUID().toString());
               farmPenVO.setCompanyId(userVO.getCompanyId());
               farmPenVO.setFarmId(userVO.getDefaultFarm());
               farmPenVO.setCreateTime(new Date());
               dao.insert(farmPenVO);
               return success("保存成功", map);
            }
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("保存失败", map);
      }
   }

   /**
    * 删除猪舍
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/deletePen")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> deletePen(HttpServletRequest request, @Param("penId") String penId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<PigsVO> pigsVOs = dao.query(PigsVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("penId", "=", penId));
         if (pigsVOs != null && pigsVOs.size() > 0) {
            return failure("不能删除存在猪只的猪舍", map);
         }
         else {
            dao.clear(FarmPenVO.class, Cnd.where("penId", "=", penId));
            return success("删除成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("删除失败", map);
      }
   }

   /**
    * 查询猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/queryPig")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPig(HttpServletRequest request, @Param("earTag") String earTag,
         @Param("sexType") String sexType, @Param("state") String state, @Param("currentPage") String currentPage) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      List<PigsVO> pigsList = null;
      int countPig = 0;
      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm());
         /*if (sexType != null && sexType.length() > 0) {
            if (sexType.equals(CommonConstants.PIG.PIG_SEX_PIGLET_MALE)) {
               cri.where().andIn("sexType", CommonConstants.PIG.PIG_SEX_PIGLET_FEMALE,
                     CommonConstants.PIG.PIG_SEX_PIGLET_MALE);
            }
            cri.where().and("sexType", "=", sexType);
         }*/
         if (sexType != null && sexType.length() > 0) {
            String[] sexTypes = sexType.split(";");
            cri.where().andIn("sexType", sexTypes);
         }
         if (state != null && state.length() > 0) {
            cri.where().and("state", "=", state);
         }
         if (earTag != null && earTag.length() > 0) {
            cri.where().and("earTag", "LIKE", "%" + earTag + "%");
         }
         if (currentPage != null && currentPage.length() > 0) {
            Pager pager = dao.createPager(Integer.parseInt(currentPage), 10);
            pigsList = dao.query(PigsVO.class, cri, pager);
            map.put("currentPage", currentPage);
         }
         else {
            pigsList = dao.query(PigsVO.class, cri);
         }
         for (PigsVO pigsVO : pigsList) {
            Date date1 = new Date();
            Date date2 = pigsVO.getLastDate();
            int dayCount = (int) ((date1.getTime() - date2.getTime()) / (1000 * 3600 * 24));
            pigsVO.setDayCount(dayCount);
            dao.fetchLinks(pigsVO, "farmPenVO");
         }
         
         countPig = dao.count(PigsVO.class, cri);
         map.put("pigsList", pigsList);
         map.put("countPig", countPig);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询指定猪
    * 
    * @param FarmVO 猪舍详细信息
    * @return Map
    */
   @At("/app/fetchPig")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> fetchPig(HttpServletRequest request, @Param("pigsId") String pigsId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigsVO pigsVO = dao.fetch(PigsVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
               .and("farmId", "=", userVO.getDefaultFarm()).and("pigsId", "=", pigsId));
         map.put("pigsVO", pigsVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 创建猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/savePig")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> savePig(HttpServletRequest request, @Param("..") PigsVO pigsVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (pigsVO.getPigsId() != null && pigsVO.getPigsId().length() > 0) {
            PigsVO temp = dao.fetch(PigsVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm())
                        .and("pigsId", "!=", pigsVO.getPigsId()).and("earTag", "=", pigsVO.getEarTag()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               dao.updateIgnoreNull(pigsVO);
               return success("修改成功", map);
            }
         }
         else {
            PigsVO temp = dao.fetch(PigsVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
                  .and("farmId", "=", userVO.getDefaultFarm()).and("earTag", "=", pigsVO.getEarTag()));
            if (temp != null) {
               return failure("该名称已被使用", map);
            }
            else {
               pigsVO.setPigsId(UUID.randomUUID().toString());
               pigsVO.setCompanyId(userVO.getCompanyId());
               pigsVO.setFarmId(userVO.getDefaultFarm());
               pigsVO.setState(CommonConstants.PIG.PIG_STATE_RESERVE);
               pigsVO.setSourceType(CommonConstants.PIG.PIG_SOURCE_IN);
               pigsVO.setLastDate(pigsVO.getAdmissionDate());
               pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_IN);
               pigsVO.setIsExit(CommonConstants.DB_CHAR_NO);
               dao.insert(pigsVO);
               return success("保存成功", map);
            }
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("保存失败", map);
      }
   }

   /**
    * 删除猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/deletePig")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> deletePig(HttpServletRequest request, @Param("pigsId") String pigsId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (false) {
            return failure("不能删除存在记录的猪", map);
         }
         else {
            dao.clear(PigsVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
                  .and("farmId", "=", userVO.getDefaultFarm()).and("pigsId", "=", pigsId));
            return success("删除成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("删除失败", map);
      }
   }

   /**
    * 查询供应商
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/querySupplier")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> querySupplier(HttpServletRequest request, @Param("supplierName") String supplierName,
         @Param("type") String type) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm());
         if (supplierName != null && supplierName.length() > 0) {
            cri.where().and("supplierName", "LIKE", "%" + supplierName + "%");
         }
         if (type != null && type.length() > 0) {
            cri.where().and("type", "LIKE", "%" + type + "%");
         }
         List<SupplierVO> supplierVOs = dao.query(SupplierVO.class, cri);
         map.put("supplierVOs", supplierVOs);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询指定供应商
    * 
    * @param FarmVO 猪舍详细信息
    * @return Map
    */
   @At("/app/fetchSupplier")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> fetchSupplier(HttpServletRequest request, @Param("supplierId") String supplierId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         SupplierVO supplierVO = dao.fetch(SupplierVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
               .and("farmId", "=", userVO.getDefaultFarm()).and("supplierId", "=", supplierId));
         map.put("supplierVO", supplierVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 创建供应商
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/saveSupplier")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> saveSupplier(HttpServletRequest request, @Param("..") SupplierVO supplierVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (supplierVO.getSupplierId() != null && supplierVO.getSupplierId().length() > 0) {
            dao.updateIgnoreNull(supplierVO);
            return success("修改成功", map);
         }
         else {
            supplierVO.setSupplierId(UUID.randomUUID().toString());
            supplierVO.setCompanyId(userVO.getCompanyId());
            supplierVO.setFarmId(userVO.getDefaultFarm());
            supplierVO.setIsDelete(CommonConstants.DB_CHAR_NO);
            supplierVO.setIsUsing(CommonConstants.DB_CHAR_YES);
            dao.insert(supplierVO);
            return success("保存成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("保存失败", map);
      }
   }

   /**
    * 删除供应商
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/deleteSupplier")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> deleteSupplier(HttpServletRequest request, @Param("supplierId") String supplierId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<GoodsVO> goodsVOs = dao.query(GoodsVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
               .and("farmId", "=", userVO.getDefaultFarm()).and("supplierId", "=", supplierId));
         if (goodsVOs != null && goodsVOs.size() > 0) {
            SupplierVO supplierVO = dao.fetch(SupplierVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("supplierId", "=", supplierId));
            supplierVO.setIsDelete(CommonConstants.DB_CHAR_YES);
            dao.updateIgnoreNull(supplierVO);
            return success("删除成功", map);
         }
         else {
            dao.clear(SupplierVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("supplierId", "=", supplierId));
            return success("删除成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("删除失败", map);
      }
   }

   /**
    * 查询物料
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/queryGoods")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryGoods(HttpServletRequest request, @Param("type") String type,
         @Param("goodName") String goodName) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm());
         /*if (type.equals(CommonConstants.GOODS.GOODS_TYPE_VETERINARY)) {
            cri.where().andIn("type", CommonConstants.GOODS.GOODS_TYPE_VETERINARY,
                  CommonConstants.GOODS.GOODS_TYPE_VACCINE);
         }
         else {
            cri.where().and("type", "=", type);
         }*/
         if (type != null && type.length() > 0) {
            String[] types = type.split(";");
            cri.where().andIn("type", types);
         }
         if (goodName != null && goodName.length() > 0) {
            cri.where().and("goodName", "LIKE", "%" + goodName + "%");
         }
         List<GoodsVO> goodsVOs = dao.query(GoodsVO.class, cri);
         dao.fetchLinks(goodsVOs, "supplierVO");
         map.put("goodsVOs", goodsVOs);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 查询指定物料
    * 
    * @param FarmVO 猪舍详细信息
    * @return Map
    */
   @At("/app/fetchGoods")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> fetchGoods(HttpServletRequest request, @Param("goodId") String goodId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         GoodsVO goodsVO = dao.fetch(GoodsVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())
               .and("farmId", "=", userVO.getDefaultFarm()).and("goodId", "=", goodId));
         map.put("goodsVO", goodsVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("查询失败", map);
      }
   }

   /**
    * 创建物料
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/saveGoods")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> saveGoods(HttpServletRequest request, @Param("..") GoodsVO goodsVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (goodsVO.getGoodId() != null && goodsVO.getGoodId().length() > 0) {
            dao.updateIgnoreNull(goodsVO);
            return success("修改成功", map);
         }
         else {
            goodsVO.setGoodId(UUID.randomUUID().toString());
            goodsVO.setCompanyId(userVO.getCompanyId());
            goodsVO.setFarmId(userVO.getDefaultFarm());
            goodsVO.setIsUsing(CommonConstants.DB_CHAR_YES);
            goodsVO.setIsDelete(CommonConstants.DB_CHAR_NO);
            dao.insert(goodsVO);
            return success("保存成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("保存失败", map);
      }
   }

   /**
    * 删除物料
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/deleteGoods")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> deleteGoods(HttpServletRequest request, @Param("goodId") String goodId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (false) {
            GoodsVO goodsVO = dao.fetch(GoodsVO.class,
                  Cnd.where("companyId", "=", userVO.getCompanyId()).and("goodId", "=", goodId));
            goodsVO.setIsDelete(CommonConstants.DB_CHAR_YES);
            dao.updateIgnoreNull(goodsVO);
            return success("删除成功", map);
         }
         else {
            dao.clear(GoodsVO.class, Cnd.where("goodId", "=", goodId));
            return success("删除成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         return failure("删除失败", map);
      }
   }

   @At("/app/queryPigCategory")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryCategory(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);

      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId());
         cri.getOrderBy().asc("level");
         List<PigCategoryVO> pigCategoryList = dao.query(PigCategoryVO.class, cri);
         map.put("pigCategoryList", pigCategoryList);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   @At("/app/queryPigStrain")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryStrain(HttpServletRequest request, @Param("categoryId") String categoryId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId()).and("categoryId", "=", categoryId);
         cri.getOrderBy().asc("level");
         List<PigStrainVO> pigStrainList = dao.query(PigStrainVO.class, cri);
         map.put("pigStrainList", pigStrainList);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 统计母猪数量
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryFemale")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryFemale(HttpServletRequest request, @Param("date") String date) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (date == null || date.length() == 0) {
         date = sdf.format(new Date());
      }
      try {
         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         int femaleNum = androidBO.countPig(userVO, sexType, null, 0, date);
         map.put("femaleNum", femaleNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 统计公猪数量
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryMale")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryMale(HttpServletRequest request, @Param("date") String date) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (date == null || date.length() == 0) {
         date = sdf.format(new Date());
      }
      try {
         String sexType = CommonConstants.PIG.PIG_SEX_MALE;
         int maleNum = androidBO.countPig(userVO, sexType, null, 0, date);
         map.put("maleNum", maleNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 统计肉猪数量
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryPorker")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryPorker(HttpServletRequest request, @Param("date") String date) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (date == null || date.length() == 0) {
         date = sdf.format(new Date());
      }
      try {
         Criteria cri = Cnd.cri();
         cri.where().and("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm());
         int porkerNum = dao.func(FarmPenVO.class, "sum", "sucklingNum", cri)
               + dao.func(FarmPenVO.class, "sum", "fattenNum", cri)
               + dao.func(FarmPenVO.class, "sum", "conservationNum", cri);
         map.put("porkerNum", porkerNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 统计怀孕母猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryFemalePregnant")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryFemalePregnant(HttpServletRequest request, @Param("date") String date) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (date == null || date.length() == 0) {
         date = sdf.format(new Date());
      }
      try {
         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_PREGNANT;
         int femaleNum = androidBO.countPig(userVO, sexType, state, 0, date);
         map.put("femaleNum", femaleNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 统计空怀母猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryFemaleNonpregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryFemaleNonpregnancy(HttpServletRequest request, @Param("date") String date) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (date == null || date.length() == 0) {
         date = sdf.format(new Date());
      }
      try {
         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_RESERVE + "," + CommonConstants.PIG.PIG_STATE_CHILDBIRTH + ","
               + CommonConstants.PIG.PIG_STATE_RETURN + "," + CommonConstants.PIG.PIG_STATE_ABORTION + ","
               + CommonConstants.PIG.PIG_STATE_EMPTY;
         int femaleNum = androidBO.countPig(userVO, sexType, state, 0, date);
         map.put("femaleNum", femaleNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 待办：待产母猪列表
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryWait")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryWait(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_RESERVE + "," + CommonConstants.PIG.PIG_STATE_CHILDBIRTH
               + "," + CommonConstants.PIG.PIG_STATE_RETURN + "," + CommonConstants.PIG.PIG_STATE_ABORTION + ","
               + CommonConstants.PIG.PIG_STATE_EMPTY;
         int matingNum = androidBO.countPig(userVO, sexType, state, 0, null);

         state = CommonConstants.PIG.PIG_STATE_PREGNANT;
         int expectantNum = androidBO.countPig(userVO, sexType, state, 107, null);

         map.put("matingNum", matingNum);
         map.put("expectantNum", expectantNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 待办：返情待配母猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryWaitMatingReturn")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryWaitMatingReturn(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_RETURN;

         QueryResult result = androidBO.queryPig(userVO, currentPages, pageSizes, sexType, state, 0);
         List<PigsVO> PigsList = result.getList(PigsVO.class);

         map.put("PigsList", PigsList);
         map.put("countNum", result.getPager().getPageCount());
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 待办：空胎待配母猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryWaitMatingEmpty")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryWaitMatingEmpty(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_EMPTY;

         QueryResult result = androidBO.queryPig(userVO, currentPages, pageSizes, sexType, state, 0);
         List<PigsVO> PigsList = result.getList(PigsVO.class);

         map.put("PigsList", PigsList);
         map.put("countNum", result.getPager().getPageCount());
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 待办：流产后待配母猪
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryWaitMatingAbortion")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryWaitMatingAbortion(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_ABORTION;

         QueryResult result = androidBO.queryPig(userVO, currentPages, pageSizes, sexType, state, 0);
         List<PigsVO> PigsList = result.getList(PigsVO.class);

         map.put("PigsList", PigsList);
         map.put("countNum", result.getPager().getPageCount());
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 待办：待产母猪列表
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryWaitExpectant")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryWaitExpectant(HttpServletRequest request, @Param("currentPage") String currentPage,
         @Param("pageSize") String pageSize) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         String sexType = CommonConstants.PIG.PIG_SEX_FEMALE;
         String state = CommonConstants.PIG.PIG_STATE_PREGNANT;

         QueryResult result = androidBO.queryPig(userVO, currentPages, pageSizes, sexType, state, 107);
         List<PigsVO> PigsList = result.getList(PigsVO.class);

         int overNum = androidBO.countPig(userVO, sexType, state, 125, null);

         map.put("PigsList", PigsList);
         map.put("countNum", result.getPager().getPageCount());
         map.put("overNum", overNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 指定时间段种猪入群数
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryPigIn")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryPigIn(HttpServletRequest request, @Param("startDate") String startDate,
         @Param("endDate") String endDate, @Param("dateType") String dateType) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (null == dateType || dateType.equals(CommonConstants.Summery.DATE_TYPE_MONTH)) {
            dateType = CommonConstants.Summery.DATE_TYPE_MONTH;
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getFirstDayOfMonth();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }
         else if (dateType.equals(CommonConstants.Summery.DATE_TYPE_WEEK)) {
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getMondayOfThisWeek();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }

         int pigInNum = androidBO.countPigIn(userVO, startDate, endDate);

         map.put("pigInNum", pigInNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 指定时间段种猪配种头数
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryPigMating")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryPigMating(HttpServletRequest request, @Param("startDate") String startDate,
         @Param("endDate") String endDate, @Param("dateType") String dateType) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SummryMatingVO summryMatingVO = new SummryMatingVO();
      try {
         if (null == dateType || dateType.equals(CommonConstants.Summery.DATE_TYPE_MONTH)) {
            dateType = CommonConstants.Summery.DATE_TYPE_MONTH;
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getFirstDayOfMonth();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }
         else if (dateType.equals(CommonConstants.Summery.DATE_TYPE_WEEK)) {
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getMondayOfThisWeek();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }

         List<SummryVO> summryList = androidBO.countPigMating(userVO, "femaleState", startDate, endDate);
         for (SummryVO summryVO : summryList) {
            if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_RESERVE)) {
               summryMatingVO.setReserveNum(summryVO.getInt1());
            }
            else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_CHILDBIRTH)) {
               summryMatingVO.setChildbirthNum(summryVO.getInt1());
            }
            else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_RETURN)) {
               summryMatingVO.setReturnNum(summryVO.getInt1());
            }
            else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_ABORTION)) {
               summryMatingVO.setAbortionNum(summryVO.getInt1());
            }
            else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_EMPTY)) {
               summryMatingVO.setEmptyNum(summryVO.getInt1());
            }
         }

         map.put("summryMatingVO", summryMatingVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 指定时间段种猪空返流头数
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryPigPregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryPigPregnancy(HttpServletRequest request, @Param("startDate") String startDate,
         @Param("endDate") String endDate, @Param("dateType") String dateType) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (null == dateType || dateType.equals(CommonConstants.Summery.DATE_TYPE_MONTH)) {
            dateType = CommonConstants.Summery.DATE_TYPE_MONTH;
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getFirstDayOfMonth();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }
         else if (dateType.equals(CommonConstants.Summery.DATE_TYPE_WEEK)) {
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getMondayOfThisWeek();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }

         int allNum = androidBO.countPigPregnancy(userVO, null, startDate, endDate);
         int returnNum = androidBO.countPigPregnancy(userVO, CommonConstants.PIG.PIG_STATE_RETURN, startDate, endDate);
         int abortionNum = androidBO.countPigPregnancy(userVO, CommonConstants.PIG.PIG_STATE_ABORTION, startDate,
               endDate);
         int emptyNum = androidBO.countPigPregnancy(userVO, CommonConstants.PIG.PIG_STATE_EMPTY, startDate, endDate);

         map.put("allNum", allNum);
         map.put("returnNum", returnNum);
         map.put("abortionNum", abortionNum);
         map.put("emptyNum", emptyNum);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 繁殖：配种：月配种跟踪图
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryBreedingTrackByMonth")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryBreedingTrackByMonth(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      String startDate = "";
      String endDate = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Calendar calendar = Calendar.getInstance();
      try {
         for (int i = 11; i >= 0; i--) {
            calendar = Calendar.getInstance();
            calendar.set(Calendar.DATE, 1);//设为当前月的1号  
            calendar.add(Calendar.MONTH, -i);//减i个月，变为下i个月的1号  
            startDate = sdf.format(calendar.getTime());
            calendar.roll(Calendar.DATE, -1);//日期回滚一天，也就是i月最后一天   
            endDate = sdf.format(calendar.getTime());

            List<SummryVO> summryList = androidBO.countPigMating(userVO, "finalResult", startDate, endDate);
            SummryMatingVO summryMatingVO = new SummryMatingVO();
            for (SummryVO summryVO : summryList) {
               if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_PREGNANT)) {
                  summryMatingVO.setPregnantNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_CHILDBIRTH)) {
                  summryMatingVO.setChildbirthNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_RETURN)) {
                  summryMatingVO.setReturnNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_ABORTION)) {
                  summryMatingVO.setAbortionNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_EMPTY)) {
                  summryMatingVO.setEmptyNum(summryVO.getInt1());
               }
            }
            map.put(calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1), summryMatingVO);
         }
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   /**
    * 繁殖：配种：周配种跟踪图
    * 
    * @param FarmVO 猪场详细信息
    * @return Map
    */
   @At("/app/summaryBreedingTrackByWeek")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> summaryBreedingTrackByWeek(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      String startDate = "";
      String endDate = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Calendar calendar = Calendar.getInstance();
      try {
         for (int i = 25; i >= 0; i--) {
            calendar = Calendar.getInstance();
            calendar.setFirstDayOfWeek(Calendar.MONDAY);
            calendar.add(Calendar.WEEK_OF_YEAR, -i);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
            startDate = sdf.format(calendar.getTime());
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            endDate = sdf.format(calendar.getTime());

            List<SummryVO> summryList = androidBO.countPigMating(userVO, "finalResult", startDate, endDate);
            SummryMatingVO summryMatingVO = new SummryMatingVO();
            for (SummryVO summryVO : summryList) {
               if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_PREGNANT)) {
                  summryMatingVO.setPregnantNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_CHILDBIRTH)) {
                  summryMatingVO.setChildbirthNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_RETURN)) {
                  summryMatingVO.setReturnNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_ABORTION)) {
                  summryMatingVO.setAbortionNum(summryVO.getInt1());
               }
               else if (summryVO.getStr1().equals(CommonConstants.PIG.PIG_STATE_EMPTY)) {
                  summryMatingVO.setEmptyNum(summryVO.getInt1());
               }
            }
            map.put(calendar.get(Calendar.YEAR) + "-" + calendar.get(Calendar.WEEK_OF_YEAR), summryMatingVO);
         }
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }
   /*..............................................小明部分.....................................................*/

   @At("/app/getTotalChildByCompanyAndFarm")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> getTotalChildByCompanyAndFarm(HttpServletRequest request,
         @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("dateType") String dateType) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);

      try {
         if (null == dateType || dateType.equals(CommonConstants.Summery.DATE_TYPE_MONTH)) {
            dateType = CommonConstants.Summery.DATE_TYPE_MONTH;
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getFirstDayOfMonth();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }
         else if (dateType.equals(CommonConstants.Summery.DATE_TYPE_WEEK)) {
            if (startDate == null || startDate.length() <= 0) {
               startDate = DateUtils.getMondayOfThisWeek();
            }
            if (endDate == null || endDate.length() <= 0) {
               endDate = DateUtils.getTodayStr("yyyy-MM-dd");
            }
         }
         int total = dao.func(PigChildBirthVO.class, "sum", "totalChild",
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm())
                     .and("childbirthDate", ">=", startDate).and("childbirthDate", "<=", endDate));

         map.put("total", total);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }

      return success("查询成功", map);
   }

   /*..............................................小明部分.....................................................*/

   @At("/app/addPigMating")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> addPigMating(HttpServletRequest request, @Param("..") PigMatingVO pigMatingVO,
         @Param("..") PigMatingPairVO pigMatingPairVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         pigMatingVO.setFarmId(userVO.getDefaultFarm());
         pigMatingVO.setMatingId(UUID.randomUUID().toString());
         pigMatingVO.setCompanyId(userVO.getCompanyId());
         pigMatingVO.setFlowId(UUID.randomUUID().toString());
         pigMatingVO.setCreateDate(new Date());

         pigMatingPairVO.setPairId(UUID.randomUUID().toString());
         pigMatingPairVO.setMatingId(pigMatingVO.getMatingId());
         pigMatingPairVO.setFinalResult(CommonConstants.PIG.PIG_STATE_PREGNANT);
         PigsVO female = dao.fetch(PigsVO.class, pigMatingPairVO.getFemalePigsId());
         pigMatingPairVO.setFemaleState(female.getState());
         pigMatingPairVO.setFemaleLastDate(female.getLastDate());
         PigsVO male = dao.fetch(PigsVO.class, pigMatingPairVO.getMalePigsId());
         pigMatingPairVO.setMaleState(male.getState());
         pigMatingPairVO.setMaleLastDate(male.getLastDate());

         if (sdf.parse(sdf.format(pigMatingPairVO.getMatingDate()))
               .before(sdf.parse(sdf.format(female.getAdmissionDate())))) {
            return failure("配种时间有误，不能小于母猪的入场时间！", map);
         }

         Map<String, Object> result = androidBO.addPigMating(userVO, pigMatingVO, pigMatingPairVO);
         if (result.get("result").equals("true")) {
            return success("新增成功！", map);
         }
         else {
            return failure("新增失败！", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("新增异常！", map);
      }
   }

   @At("/app/editPigMating")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> editPigMating(HttpServletRequest request, @Param("..") PigMatingVO pigMatingVO,
         @Param("matingPairList") String matingPairList) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      pigMatingVO.setFarmId(userVO.getDefaultFarm());
      try {
         PigsVO female = dao.fetch(PigsVO.class, pigMatingVO.getFemalePigsId());
         JSONArray jarray = JSONArray.parseArray(matingPairList);
         for (int i = 0; i < jarray.size(); i++) {
            JSONObject json = jarray.getJSONObject(i);

            if (sdf.parse(json.get("matingDate").toString()).before(sdf.parse(sdf.format(female.getAdmissionDate())))) {
               return failure("配种时间有误，不能小于母猪的入场时间！", map);
            }

            if (json.get("pairId") != null) {
               PigPregnancyVO tp = dao.fetch(PigPregnancyVO.class, Cnd.where("pairId", "=", json.get("pairId")));
               if (tp != null) {
                  int day = CommonUtils.daysBetween(json.getString("matingDate"), sdf.format(tp.getPregnancyDate()));
                  if (day < 4) {
                     return failure("错误，配种5天后才可以妊检，与目前的妊检记录的日期冲突！", map);
                  }
               }
            }
         }

         Map<String, Object> result = androidBO.editPigMating(userVO, pigMatingVO, matingPairList);
         if (result.get("result").equals("true")) {
            return success("修改成功！", map);
         }
         else {
            return failure("修改失败！", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("修改异常！", map);
      }
   }

   @At("/app/delPigMating")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> delPigMating(HttpServletRequest request, @Param("matingId") String matingId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         Map<String, Object> result = androidBO.delPigMating(userVO, matingId);
         if (result.get("result").equals("true")) {
            return success("删除成功！", map);
         }
         else {
            return failure("删除失败！", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除异常！", map);
      }
   }

   @At("/app/queryPigMatingById")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPigMatingById(HttpServletRequest request, @Param("matingId") String matingId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigMatingVO pigMatingVO = dao.fetch(PigMatingVO.class, matingId);
         List<FarmPenVO> farmPenList = dao.query(FarmPenVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm()));
         List<PigMatingPairVO> pigMatingPairList = dao.query(PigMatingPairVO.class,
               Cnd.where("matingId", "=", pigMatingVO.getMatingId()));
         for (PigMatingPairVO p : pigMatingPairList) {
            dao.fetchLinks(p, "femalePigsVO");
            dao.fetchLinks(p, "malePigsVO");
         }

         map.put("pigMatingVO", pigMatingVO);
         map.put("pigMatingPairList", pigMatingPairList);
         map.put("farmPenList", farmPenList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryLegalMatingFemalePigs")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryLegalMatingFemalePigs(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize, @Param("earTag") String earTag) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         QueryResult result = androidBO.queryLegalMatingFemalePigs(currentPages, pageSizes, userVO, earTag);
         List<PigsVO> PigsList = result.getList(PigsVO.class);
         for (PigsVO p : PigsList) {
//            p.setDayCount(CommonUtils.daysBetween(sdf.format(p.getLastDate()), sdf.format(new Date())));
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "pigCategoryVO");
         }
         map.put("PigsList", PigsList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryLegalMatingMalePigs")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryLegalMatingMalePigs(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize, @Param("earTag") String earTag) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         QueryResult result = androidBO.queryLegalMatingMalePigs(currentPages, pageSizes, userVO, earTag);
         List<PigsVO> PigsList = result.getList(PigsVO.class);
         for (PigsVO p : PigsList) {
//            p.setDayCount(CommonUtils.daysBetween(sdf.format(p.getLastDate()), sdf.format(new Date())));
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "pigCategoryVO");
         }
         map.put("PigsList", PigsList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/getPigByEarTag")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> getPigByEarTag(HttpServletRequest request, @Param("earTag") String earTag) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         List<PigsVO> pigsList = dao.query(PigsVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm())
                     .and("isExit", "=", "N").and("earTag", "LIKE", "%" + earTag + "%"));
         map.put("pigsList", pigsList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryMating")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryMating(HttpServletRequest request, @Param("currentPage") String currentPage,
         @Param("pageSize") String pageSize, @Param("femalePigsId") String femalePigsId,
         @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("penId") String penId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date d = new Date();
         String startDateStr = StringUtils.trimToEmpty(startDate);
         String startDates = sdf.format(CommonUtils.getMonthStart(d));
         if (startDateStr.length() > 0) {
            startDates = startDate;
         }

         String endDateStr = StringUtils.trimToEmpty(endDate);
         String endDates = sdf.format(CommonUtils.getMonthEnd(d));
         if (endDateStr.length() > 0) {
            endDates = endDate;
         }

         QueryResult result = androidBO.queryMating(currentPages, pageSizes, userVO, femalePigsId, startDates, endDates,
               penId);
         List<PigMatingVO> pigMatingList = result.getList(PigMatingVO.class);
         for (PigMatingVO p : pigMatingList) {
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "femalePigsVO");
            dao.fetchLinks(p, "pigMatingPairList");
            List<PigMatingPairVO> pmList = p.getPigMatingPairList();
            for (PigMatingPairVO pm : pmList) {
               dao.fetchLinks(pm, "malePigsVO");
            }
         }

         map.put("pigMatingList", pigMatingList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/checkAddOrUpdate")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> checkAddOrUpdate(HttpServletRequest request, @Param("pigsId") String pigsId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      String method = "";
      String message = "";
      try {
         PigsVO pigsVO = dao.fetch(PigsVO.class, pigsId);
         if (pigsVO.getState().equals("1") || pigsVO.getState().equals("3")) {
            method = "add";
         }
         else if (pigsVO.getState().equals("2")) {
            method = "";
            message = "该母猪已经怀孕,请帮该母猪做妊检,等待母猪分娩！";
         }
         else if (Integer.parseInt(pigsVO.getState()) >= 4 && Integer.parseInt(pigsVO.getState()) <= 6) {
            method = "update";
            List<PigMatingVO> PigMatingList = dao.query(PigMatingVO.class,
                  Cnd.where("femalePigsId", "=", pigsId).desc("createDate"));
            if (PigMatingList.size() > 0) {
               List<PigMatingPairVO> PigMatingPairList = dao.query(PigMatingPairVO.class,
                     Cnd.where("matingId", "=", PigMatingList.get(0).getMatingId()).asc("matingDate"));
               map.put("PigMatingPairList", PigMatingPairList);
            }
            else {
               System.out.println("该母猪状态不是1或者3，但是却没有配种记录，这里是不合理的");
            }
         }
         map.put("method", method);
         map.put("message", message);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/addPigPregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> addPigPregnancy(HttpServletRequest request, @Param("..") PigPregnancyVO pigPregnancyVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         PigsVO pigsVO = dao.fetch(PigsVO.class, pigPregnancyVO.getFemalePigsId());
         PigMatingVO pigMatingVO = dao.fetch(PigMatingVO.class, Cnd.where("flowId", "=", pigsVO.getFlowId()));
         List<PigMatingPairVO> pigMatingPairList = dao.query(PigMatingPairVO.class,
               Cnd.where("matingId", "=", pigMatingVO.getMatingId()).desc("matingDate"));
         PigMatingPairVO pigMatingPairVO = pigMatingPairList.get(0);

         int day = CommonUtils.daysBetween(sdf.format(pigMatingPairVO.getMatingDate()),
               sdf.format(pigPregnancyVO.getPregnancyDate()));
         if (day < 4) {
            return failure("错误，配种5天后才可以妊检，与目前的配种记录的日期冲突！", map);
         }

         PigPregnancyVO pp = dao.fetch(PigPregnancyVO.class, Cnd.where("matingId", "=", pigMatingPairVO.getMatingId())
               .and("pairId", "=", pigMatingPairVO.getPairId()));
         if (pp == null) {
            pigPregnancyVO.setPregnancyId(UUID.randomUUID().toString());
            pigPregnancyVO.setCompanyId(userVO.getCompanyId());
            pigPregnancyVO.setFarmId(userVO.getDefaultFarm());
            pigPregnancyVO.setMatingId(pigMatingVO.getMatingId());
            pigPregnancyVO.setPairId(pigMatingPairVO.getPairId());
            pigPregnancyVO.setFlowId(pigMatingVO.getFlowId());
            pigPregnancyVO.setFemalePigsId(pigMatingPairVO.getFemalePigsId());
            pigPregnancyVO.setMalePigsId(pigMatingPairVO.getMalePigsId());
            pigPregnancyVO.setSpermId(pigMatingPairVO.getSpermId());
            pigPregnancyVO.setPairType(pigMatingPairVO.getPairType());
            pigPregnancyVO.setState("0");
            pigPregnancyVO.setLastEventDate(pigsVO.getLastDate());

            Map<String, Object> result = androidBO.addPigPregnancy(userVO, pigPregnancyVO, pigsVO);
            if (result.get("result").equals("true")) {
               return success("新增成功！", map);
            }
            else {
               return failure("新增失败！", map);
            }
         }
         else {
            return failure("该母猪已有妊检记录，不能再添加！", map);
         }

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("新增异常！", map);
      }
   }

   @At("/app/editPigPregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> editPigPregnancy(HttpServletRequest request, @Param("..") PigPregnancyVO pigPregnancyVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         PigPregnancyVO p = dao.fetch(PigPregnancyVO.class, pigPregnancyVO.getPregnancyId());
         if (p.getState().equals("1")) {
            return failure("该记录已经失效，无法修改！", map);
         }

         PigMatingPairVO pigMatingPairVO = dao.fetch(PigMatingPairVO.class, Cnd.where("pairId", "=", p.getPairId()));
         int day = CommonUtils.daysBetween(sdf.format(pigMatingPairVO.getMatingDate()),
               sdf.format(pigPregnancyVO.getPregnancyDate()));
         if (day < 4) {
            return failure("错误，配种5天后才可以妊检，与目前的配种记录的日期冲突！", map);
         }
         PigChildBirthVO pp = dao.fetch(PigChildBirthVO.class,
               Cnd.where("matingId", "=", p.getMatingId()).and("pairId", "=", p.getPairId()));
         if (pp != null) {
            if (!pigPregnancyVO.getFinalResult().equals("2")) {
               return failure("错误，该妊检(返情/流产/空胎)之后存在分娩，不符合事件逻辑要求！", map);
            }
            int days = CommonUtils.daysBetween(sdf.format(pigPregnancyVO.getPregnancyDate()),
                  sdf.format(pp.getChildbirthDate()));
            if (days > 100) {
               return failure("错误，妊检日期不能在分娩日期之后！", map);
            }
         }

         p.setPregnancyDate(pigPregnancyVO.getPregnancyDate());
         p.setPenId(pigPregnancyVO.getPenId());
         p.setFinalResult(pigPregnancyVO.getFinalResult());
         p.setRemark(pigPregnancyVO.getRemark());
         if (p != null && !p.getPregnancyId().equals("")) {
            Map<String, Object> result = androidBO.editPigPregnancy(userVO, p);
            if (result.get("result").equals("true")) {
               return success("修改成功！", map);
            }
            else {
               return failure("修改失败！", map);
            }
         }
         else {
            return failure("修改失败！无该记录！", map);
         }

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("修改异常！", map);
      }
   }

   @At("/app/delPigPregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> delPigPregnancy(HttpServletRequest request, @Param("pregnancyId") String pregnancyId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigPregnancyVO pigPregnancyVO = dao.fetch(PigPregnancyVO.class, pregnancyId);
         if (pigPregnancyVO.getState().equals("0")) {
            System.out.println("该记录可以删除，并且要回滚数据");
         }
         else if (pigPregnancyVO.getState().equals("1")) {
            return failure("此记录不能删除！", map);
         }
         Map<String, Object> result = androidBO.delPigPregnancy(userVO, pigPregnancyVO);
         if (result.get("result").equals("true")) {
            return success("删除成功！", map);
         }
         else {
            return failure("删除失败！", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除异常！", map);
      }
   }

   @At("/app/queryPigPregnancyById")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPigPregnancyById(HttpServletRequest request,
         @Param("pregnancyId") String pregnancyId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigPregnancyVO pigPregnancyVO = dao.fetch(PigPregnancyVO.class, pregnancyId);
         List<FarmPenVO> farmPenList = dao.query(FarmPenVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm()));

         map.put("pigPregnancyVO", pigPregnancyVO);
         map.put("farmPenList", farmPenList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryLegalPregnancyFemalePigs")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryLegalPregnancyFemalePigs(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize, @Param("earTag") String earTag) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         QueryResult result = androidBO.queryLegalPregnancyFemalePigs(currentPages, pageSizes, userVO, earTag);
         List<PigsVO> PigsList = result.getList(PigsVO.class);
         for (PigsVO p : PigsList) {
//            if (p.getMatingDate() != null) {
//               p.setDayCount(CommonUtils.daysBetween(sdf.format(p.getMatingDate()), sdf.format(new Date())));
//            }
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "pigCategoryVO");
         }
         map.put("PigsList", PigsList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryPregnancy")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPregnancy(HttpServletRequest request, @Param("currentPage") String currentPage,
         @Param("pageSize") String pageSize, @Param("femalePigsId") String femalePigsId,
         @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("penId") String penId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date d = new Date();
         String startDateStr = StringUtils.trimToEmpty(startDate);
         String startDates = sdf.format(CommonUtils.getMonthStart(d));
         if (startDateStr.length() > 0) {
            startDates = startDate;
         }

         String endDateStr = StringUtils.trimToEmpty(endDate);
         String endDates = sdf.format(CommonUtils.getMonthEnd(d));
         if (endDateStr.length() > 0) {
            endDates = endDate;
         }

         QueryResult result = androidBO.queryPregnancy(currentPages, pageSizes, userVO, femalePigsId, startDates,
               endDates, penId);
         List<PigPregnancyVO> pigPregnancyList = result.getList(PigPregnancyVO.class);
         for (PigPregnancyVO p : pigPregnancyList) {
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "femalePigsVO");
         }

         map.put("pigPregnancyList", pigPregnancyList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/addPigChildBirth")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> addPigChildBirth(HttpServletRequest request,
         @Param("..") PigChildBirthVO pigChildBirthVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         PigsVO pigsVO = dao.fetch(PigsVO.class, pigChildBirthVO.getFemalePigsId());
         PigMatingVO pigMatingVO = dao.fetch(PigMatingVO.class, Cnd.where("flowId", "=", pigsVO.getFlowId()));
         List<PigMatingPairVO> pigMatingPairList = dao.query(PigMatingPairVO.class,
               Cnd.where("matingId", "=", pigMatingVO.getMatingId()).desc("matingDate"));
         PigMatingPairVO pigMatingPairVO = pigMatingPairList.get(0);

         if (!pigMatingPairVO.getFinalResult().equals("2")) {
            return failure("错误，所选母猪妊检后不是怀孕状态，不能分娩！", map);
         }

         int day = CommonUtils.daysBetween(sdf.format(pigMatingPairVO.getMatingDate()),
               sdf.format(pigChildBirthVO.getChildbirthDate()));
         if (day < 105 || day > 125) {
            return failure("错误，所选母猪在该日期不能分娩,怀孕天数不在106-125天之间！", map);
         }

         if (sdf.parse(sdf.format(pigChildBirthVO.getChildbirthDate())).after(sdf.parse(sdf.format(new Date())))) {
            return failure("错误，分娩日期不能是未来的时间！", map);
         }

         PigChildBirthVO pp = dao.fetch(PigChildBirthVO.class, Cnd.where("matingId", "=", pigMatingPairVO.getMatingId())
               .and("pairId", "=", pigMatingPairVO.getPairId()));
         if (pp == null) {
            pigChildBirthVO.setChildbirthId(UUID.randomUUID().toString());
            pigChildBirthVO.setCompanyId(userVO.getCompanyId());
            pigChildBirthVO.setFarmId(userVO.getDefaultFarm());
            pigChildBirthVO.setMatingId(pigMatingVO.getMatingId());
            pigChildBirthVO.setPairId(pigMatingPairVO.getPairId());
            pigChildBirthVO.setFlowId(pigMatingVO.getFlowId());
            pigChildBirthVO.setFemalePigsId(pigMatingPairVO.getFemalePigsId());
            pigChildBirthVO.setMalePigsId(pigMatingPairVO.getMalePigsId());
            pigChildBirthVO.setSpermId(pigMatingPairVO.getSpermId());
            pigChildBirthVO.setPairType(pigMatingPairVO.getPairType());
            pigChildBirthVO.setLastEventDate(pigsVO.getLastDate());
            pigChildBirthVO.setMatingDate(pigMatingPairVO.getMatingDate());

            Map<String, Object> result = androidBO.addPigChildBirth(userVO, pigChildBirthVO, pigsVO);
            if (result.get("result").equals("true")) {
               return success("新增成功！", map);
            }
            else {
               return failure("新增失败！", map);
            }
         }
         else {
            return failure("该母猪已有分娩记录，不能再添加！", map);
         }

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("新增异常！", map);
      }
   }

   @At("/app/editPigChildBirth")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> editPigChildBirth(HttpServletRequest request,
         @Param("..") PigChildBirthVO pigChildBirthVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         PigChildBirthVO p = dao.fetch(PigChildBirthVO.class, pigChildBirthVO.getChildbirthId());

         //校验
         PigMatingPairVO pigMatingPairVO = dao.fetch(PigMatingPairVO.class, Cnd.where("parId", "=", p.getPairId()));

         int day = CommonUtils.daysBetween(sdf.format(pigMatingPairVO.getMatingDate()),
               sdf.format(pigChildBirthVO.getChildbirthDate()));
         if (day < 105 || day > 125) {
            return failure("错误，所选母猪在该日期不能分娩,怀孕天数不在106-125天之间！", map);
         }

         //先还原以前舍的乳猪数量
         FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", p.getPenId()));
         int sucklingNum = farmPenVO.getSucklingNum();
         sucklingNum = sucklingNum - Integer.parseInt(p.getTotalChild());
         farmPenVO.setSucklingNum(sucklingNum);

         //先还原以前舍的乳猪总重量
         double sucklingWeight = farmPenVO.getSucklingWeight();
         sucklingWeight = sucklingWeight - Double.parseDouble(p.getTotalChildWeight());
         farmPenVO.setSucklingWeight(sucklingWeight);

         p.setChildbirthDate(pigChildBirthVO.getChildbirthDate());
         p.setPenId(pigChildBirthVO.getPenId());
         p.setTotalChild(pigChildBirthVO.getTotalChild());
         p.setTotalChildWeight(pigChildBirthVO.getTotalChildWeight());
         p.setRemark(pigChildBirthVO.getRemark());
         if (p != null && !p.getChildbirthId().equals("")) {
            Map<String, Object> result = androidBO.editPigChildBirth(userVO, p, farmPenVO);
            if (result.get("result").equals("true")) {
               return success("修改成功！", map);
            }
            else {
               return failure("修改失败！", map);
            }
         }
         else {
            return failure("修改失败！无该记录！", map);
         }

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("修改异常！", map);
      }
   }

   @At("/app/delPigChildBirth")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> delPigChildBirth(HttpServletRequest request, @Param("childbirthId") String childbirthId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         Map<String, Object> result = androidBO.delPigChildBirth(userVO, childbirthId);
         if (result.get("result").equals("true")) {
            return success("删除成功！", map);
         }
         else {
            return failure("删除失败！", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除异常！", map);
      }
   }

   @At("/app/queryPigChildBirthById")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryPigChildBirthById(HttpServletRequest request,
         @Param("childbirthId") String childbirthId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigChildBirthVO pigChildBirthVO = dao.fetch(PigChildBirthVO.class, childbirthId);
         List<FarmPenVO> farmPenList = dao.query(FarmPenVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("farmId", "=", userVO.getDefaultFarm()));

         map.put("pigChildBirthVO", pigChildBirthVO);
         map.put("farmPenList", farmPenList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryLegalChildBirthFemalePigs")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryLegalChildBirthFemalePigs(HttpServletRequest request,
         @Param("currentPage") String currentPage, @Param("pageSize") String pageSize, @Param("earTag") String earTag) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         QueryResult result = androidBO.queryLegalChildBirthFemalePigs(currentPages, pageSizes, userVO, earTag);
         List<PigsVO> PigsList = result.getList(PigsVO.class);
         for (PigsVO p : PigsList) {
            //p.setDayCount(CommonUtils.daysBetween(sdf.format(p.getLastDate()), sdf.format(new Date())));
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "pigCategoryVO");
         }
         map.put("PigsList", PigsList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }

   @At("/app/queryChildBirth")
   @AdaptBy(type = JsonAdaptor.class)
   @Ok("json")
   public Map<String, Object> queryChildBirth(HttpServletRequest request, @Param("currentPage") String currentPage,
         @Param("pageSize") String pageSize, @Param("femalePigsId") String femalePigsId,
         @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("penId") String penId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(currentPage);
         int currentPages = 1;
         if (currentPageStr.length() > 0) {
            currentPages = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(pageSize);
         int pageSizes = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSizes = Integer.parseInt(pageSizeStr);
         }

         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date d = new Date();
         String startDateStr = StringUtils.trimToEmpty(startDate);
         String startDates = sdf.format(CommonUtils.getMonthStart(d));
         if (startDateStr.length() > 0) {
            startDates = startDate;
         }

         String endDateStr = StringUtils.trimToEmpty(endDate);
         String endDates = sdf.format(CommonUtils.getMonthEnd(d));
         if (endDateStr.length() > 0) {
            endDates = endDate;
         }

         QueryResult result = androidBO.queryChildBirth(currentPages, pageSizes, userVO, femalePigsId, startDates,
               endDates, penId);
         List<PigChildBirthVO> pigChildBirthList = result.getList(PigChildBirthVO.class);
         for (PigChildBirthVO p : pigChildBirthList) {
            dao.fetchLinks(p, "farmPenVO");
            dao.fetchLinks(p, "femalePigsVO");
         }

         map.put("pigChildBirthList", pigChildBirthList);
         return success("获取成功！", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("获取信息异常！", map);
      }
   }
}
