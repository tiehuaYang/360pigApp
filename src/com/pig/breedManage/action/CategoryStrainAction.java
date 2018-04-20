package com.pig.breedManage.action;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.pig.authority.vo.UserVO;
import com.pig.breedManage.bo.CategoryStrainBO;
import com.pig.breedManage.vo.PigCategoryVO;
import com.pig.breedManage.vo.PigStrainVO;
import com.pig.common.CommonConstants;
import com.pig.system.action.BaseAction;

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
public class CategoryStrainAction extends BaseAction {
   private static final Log log = Logs.getLog(CategoryStrainAction.class);
   @Inject
   private Dao dao;
   @Inject
   private CategoryStrainBO categoryStrainBO;

   @At("/manage/queryPigCategory")
   @Ok("jsp:/manage/breedManage/pigCategoryManage.jsp")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> queryCategory(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);

      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(request.getParameter("currentPage"));
         int currentPage = 1;
         if (currentPageStr.length() > 0) {
            currentPage = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(request.getParameter("pageSize"));
         int pageSize = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSize = Integer.parseInt(pageSizeStr);
         }
         //搜索的字段
         String categoryName = request.getParameter("categoryName");
         if (categoryName != null && categoryName.length() > 0) {
            categoryName = URLDecoder.decode(categoryName, "UTF-8");
         }

         QueryResult result = categoryStrainBO.queryPigCategory(currentPage, pageSize, userVO, categoryName);

         List<PigCategoryVO> pigCategoryList = result.getList(PigCategoryVO.class);

         map.put("pigCategoryList", pigCategoryList);
         map.put("categoryName", categoryName);
         map.put("pageSize", pageSize);
         map.put("currentPage", currentPage);
         map.put("pageCount", result.getPager().getPageCount());
         map.put("recordCount", result.getPager().getRecordCount());

         return goPage(map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   @At("/manage/fetchCategory")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> fetchCategory(HttpServletRequest request, @Param("categoryId") String categoryId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigCategoryVO pigCategoryVO = dao.fetch(PigCategoryVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("categoryId", "=", categoryId));
         map.put("obj", pigCategoryVO);
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   @At("/manage/saveCategory")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> saveCategory(HttpServletRequest request, @Param("categoryId") String categoryId,
         @Param("categoryName") String categoryName, @Param("level") String level) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (!checkNumber(level)) {
            return failure("排序值必须为大于0的正整数，保存失败！", map);
         }
         PigCategoryVO pigCategoryVO = new PigCategoryVO();
         pigCategoryVO.setCategoryId(categoryId);
         pigCategoryVO.setCompanyId(userVO.getCompanyId());
         pigCategoryVO.setCategoryName(categoryName);
         pigCategoryVO.setLevel(Integer.parseInt(level));

         if (pigCategoryVO.getCategoryId() != null && pigCategoryVO.getCategoryId().length() > 0) {
            //校验
            PigCategoryVO pc = dao.fetch(PigCategoryVO.class,
                  Cnd.where("categoryId", "=", pigCategoryVO.getCategoryId()).and("companyId", "=",
                        userVO.getCompanyId()));
            if (!pc.getCategoryName().equals(pigCategoryVO.getCategoryName())) {
               List<PigCategoryVO> pcList = dao.query(PigCategoryVO.class,
                     Cnd.where("categoryName", "=", pigCategoryVO.getCategoryName()).and("companyId", "=",
                           userVO.getCompanyId()));
               if (pcList.size() > 0) {
                  return failure("品类名称已存在，请重新设置品类名称！", map);
               }
            }
            //校验通过
            dao.updateIgnoreNull(pigCategoryVO);
            return success("修改成功", map);
         }
         else {
            //校验
            List<PigCategoryVO> pcList = dao.query(PigCategoryVO.class,
                  Cnd.where("categoryName", "=", pigCategoryVO.getCategoryName()).and("companyId", "=",
                        userVO.getCompanyId()));
            if (pcList.size() > 0) {
               return failure("品类名称已存在，请重新设置品类名称！", map);
            }

            pigCategoryVO.setCategoryId(UUID.randomUUID().toString());
            pigCategoryVO.setCompanyId(userVO.getCompanyId());
            dao.insert(pigCategoryVO);
            return success("新增成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("操作失败", map);
      }
   }

   @At("/manage/deleteCategory")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> deleteCategory(HttpServletRequest request, @Param("categoryId") String categoryId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         PigCategoryVO pc = dao.fetch(PigCategoryVO.class, categoryId);
         if (pc == null) {
            return failure("查无该品类", map);
         }
         //删除对应的品系
         dao.clear(PigStrainVO.class, Cnd.where("categoryId", "=", categoryId));
         //删除品类
         dao.delete(pc);
         return success("删除成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除失败", map);
      }
   }

   @At("/manage/queryPigStrain")
   @Ok("jsp:/manage/breedManage/pigStrainManage.jsp")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> queryStrain(HttpServletRequest request) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);

      try {
         //分页固定格式
         String currentPageStr = StringUtils.trimToEmpty(request.getParameter("currentPage"));
         int currentPage = 1;
         if (currentPageStr.length() > 0) {
            currentPage = Integer.parseInt(currentPageStr);
         }

         String pageSizeStr = StringUtils.trimToEmpty(request.getParameter("pageSize"));
         int pageSize = CommonConstants.DEFAULT_PAGE_SIZE;
         if (pageSizeStr.length() > 0 && !pageSizeStr.equals("undefined")) {
            pageSize = Integer.parseInt(pageSizeStr);
         }
         //搜索的字段
         String categoryId = request.getParameter("categoryId");
         if (categoryId != null && categoryId.length() > 0) {
            categoryId = URLDecoder.decode(categoryId, "UTF-8");
         }

         String strainName = request.getParameter("strainName");
         if (strainName != null && strainName.length() > 0) {
            strainName = URLDecoder.decode(strainName, "UTF-8");
         }

         QueryResult result = categoryStrainBO.queryPigStrain(currentPage, pageSize, userVO, categoryId, strainName);

         List<PigStrainVO> pigStrainList = result.getList(PigStrainVO.class);
         for (PigStrainVO ps : pigStrainList) {
            dao.fetchLinks(ps, "pigCategoryVO");
         }

         List<PigCategoryVO> pigCategoryList = dao.query(PigCategoryVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).asc("level"));

         map.put("pigStrainList", pigStrainList);
         map.put("pigCategoryList", pigCategoryList);
         map.put("categoryId", categoryId);
         map.put("strainName", strainName);
         map.put("pageSize", pageSize);
         map.put("currentPage", currentPage);
         map.put("pageCount", result.getPager().getPageCount());
         map.put("recordCount", result.getPager().getRecordCount());

         return goPage(map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   @At("/manage/fetchStrain")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> fetchStrain(HttpServletRequest request, @Param("strainId") String strainId) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         PigStrainVO pigStrainVO = dao.fetch(PigStrainVO.class,
               Cnd.where("companyId", "=", userVO.getCompanyId()).and("strainId", "=", strainId));
         dao.fetchLinks(pigStrainVO, "pigCategoryVO");
         map.put("obj", pigStrainVO);
/*         List<PigCategoryVO> pigCategoryVO = dao.query(PigCategoryVO.class,
      Cnd.where("companyId", "=", userVO.getCompanyId()));
map.put("pigCategoryVO", pigCategoryVO);*/
         return success("查询成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("查询失败", map);
      }
   }

   @At("/manage/saveStrain")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> saveStrain(HttpServletRequest request, @Param("strainId") String strainId,
         @Param("strainName") String strainName, @Param("categoryId") String categoryId, @Param("level") String level) {
      Map<String, Object> map = new HashMap<String, Object>();
      HttpSession session = request.getSession();
      UserVO userVO = (UserVO) session.getAttribute(CommonConstants.SESSION_USER_KEY);
      try {
         if (!checkNumber(level)) {
            return failure("排序值必须为大于0的正整数，保存失败！", map);
         }
         PigStrainVO pigStrainVO = new PigStrainVO();
         pigStrainVO.setStrainId(strainId);
         pigStrainVO.setCompanyId(userVO.getCompanyId());
         pigStrainVO.setCategoryId(categoryId);
         pigStrainVO.setStrainName(strainName);
         pigStrainVO.setLevel(Integer.parseInt(level));

         if (pigStrainVO.getStrainId() != null && pigStrainVO.getStrainId().length() > 0) {
            //校验
            PigStrainVO ps = dao.fetch(PigStrainVO.class,
                  Cnd.where("strainId", "=", pigStrainVO.getStrainId()).and("companyId", "=", userVO.getCompanyId()));
            if (!ps.getStrainName().equals(pigStrainVO.getStrainName())) {
               List<PigStrainVO> psList = dao.query(PigStrainVO.class,
                     Cnd.where("strainName", "=", pigStrainVO.getStrainName()).and("companyId", "=",
                           userVO.getCompanyId()));
               if (psList.size() > 0) {
                  return failure("品系名称已存在，请重新设置品系名称！", map);
               }
            }
            //校验通过
            dao.updateIgnoreNull(pigStrainVO);
            return success("修改成功", map);
         }
         else {
            //校验
            List<PigStrainVO> psList = dao.query(PigStrainVO.class, Cnd
                  .where("strainName", "=", pigStrainVO.getStrainName()).and("companyId", "=", userVO.getCompanyId()));
            if (psList.size() > 0) {
               return failure("品系名称已存在，请重新设置品系名称！", map);
            }

            pigStrainVO.setStrainId(UUID.randomUUID().toString());
            pigStrainVO.setCompanyId(userVO.getCompanyId());
            dao.insert(pigStrainVO);
            return success("新增成功", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("操作失败", map);
      }
   }

   @At("/manage/deleteStrain")
   @Ok("json")
   /*@RequiresPermissions({ "raise:editCategory" })*/
   public Map<String, Object> deleteStrain(HttpServletRequest request, @Param("strainId") String strainId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         PigStrainVO ps = dao.fetch(PigStrainVO.class, strainId);
         if (ps == null) {
            return failure("查无该品系", map);
         }
         dao.delete(ps);
         return success("删除成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         return failure("删除失败", map);
      }
   }

   public boolean checkNumber(String value) {
      String str = String.valueOf(value);
      String regex = "^[1-9]+[0-9]*$";
      return str.matches(regex);
   }
}
