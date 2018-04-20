package com.pig.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.sql.Criteria;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.pig.authority.vo.UserVO;
import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.pig.system.vo.PictureVO;

/**
 * UserDAO操作助手类。
 * 
 * @author erick
 * 
 */
public class UserDAO {
   protected static final Log log = Logs.getLog(UserDAO.class);

   /**
    * 查询用户列表
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static QueryResult queryUserList(Dao dao, int currentPage, UserVO userVO) {
      List<UserVO> resultList = null;
      Pager pager = dao.createPager(currentPage, CommonConstants.DEFAULT_PAGE_SIZE);
      try {
         resultList = dao.query(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()), pager);
         pager.setRecordCount(dao.count(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())));
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   /**
    * 根据邮箱判断用户是否已存在
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean isExistByEmail(Dao dao, UserVO userVO) {
      if (dao.count(UserVO.class, Cnd.where("email", "=", userVO.getEmail())) > 0) {
         return true;
      }
      else {
         return false;
      }
   }

   /**
    * 判断登录名是否已经存在
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean isExistByAcount(Dao dao, UserVO userVO) {
      if (dao.count(UserVO.class, Cnd.where("loginAcount", "=", userVO.getLoginAcount())) > 0) {
         return true;
      }
      else {
         return false;
      }
   }

   /**
    * 判断登录名是否已经存在
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static int getCompanyUserCount(Dao dao, UserVO userVO) {
      return dao.count(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()));
   }

   /**
    * 修改用户基本资料
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean modifyUser(Dao dao, UserVO userVO, PictureVO pictureVO) {
      try {
         if (pictureVO != null) {
            PictureVO oldPic = dao.fetch(PictureVO.class, userVO.getUserId());
            if (oldPic != null) {
               dao.delete(oldPic);
            }
            dao.update(userVO);
            dao.insert(pictureVO);
            return true;
         }
         else {
            dao.update(userVO);
            return true;
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    * 修改用户密码
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean modifyUserPwd(Dao dao, UserVO userVO) {
      try {
         if (StringUtils.isNotBlank(userVO.getUserId()) && StringUtils.isNotBlank(userVO.getLoginAcount())) {
            String passwdStr = CommonUtils.getEncodedUserPasswords(userVO.getPassword(), userVO.getSalt());
            userVO.setPassword(passwdStr);
            dao.update(userVO);
            return true;
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    * 根据登录帐号判断用户是否已存在
    * 
    * @param dao
    * @param String loginAcount
    * @return
    */
   public static boolean isExistByLoginAcount(Dao dao, String loginAcount) {
      if (dao.count(UserVO.class, Cnd.where("loginAcount", "=", loginAcount)) > 0) {
         return true;
      }
      else {
         return false;
      }
   }

   /**
    * 检查用户ID和密码，如果验证成功，返回相应的 UserVo, 否则返回 null
    * 
    * @param dao
    * @param userId
    * @param passwd
    * @return
    */
   public static UserVO authUser(Dao dao, String loginAcount, String passwd) {
      try {
         if (StringUtils.isNotBlank(loginAcount) && StringUtils.isNotBlank(passwd)) {
            UserVO userVO = dao.fetch(UserVO.class, Cnd.where("loginAcount", "=", loginAcount));
            if (userVO != null && CommonConstants.DB_CHAR_YES.equals(userVO.getIsvalid())) {
               String passwdStr = CommonUtils.getEncodedUserPasswords(passwd, userVO.getSalt());
               if (userVO.getPassword().equalsIgnoreCase(passwdStr)) {
                  return userVO;
               }
            }
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }

      return null;
   }

   /**
    * 获取企业下的用户记录列表
    * 
    * @param dao
    * @param userId
    * @param passwd
    * @return
    */
   public static QueryResult querySubUserList(Dao dao, String parentId, int currentPage, int pageSize, UserVO userVO,
         Map<String, String> queryMap) {
      List<UserVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         // 创建一个 Criteria 接口实例
         Criteria cri = Cnd.cri();

         cri.where().andEquals("companyId", userVO.getCompanyId());

         //查询条件附加
         if (queryMap != null) {
            String acount = queryMap.get("acount");
            String userName = queryMap.get("userName");
            String dep = queryMap.get("dep");
            String cellPhone = queryMap.get("cellPhone");

            if (!StringUtils.isEmpty(acount) || !StringUtils.isEmpty(userName) || !StringUtils.isEmpty(dep)
                  || !StringUtils.isEmpty(cellPhone)) {
               if (!StringUtils.isEmpty(acount)) {
                  cri.where().andLike("acount", acount);
               }
               if (!StringUtils.isEmpty(userName)) {
                  cri.where().andLike("userName", userName);
               }
               if (!StringUtils.isEmpty(dep)) {
                  cri.where().andLike("departure", dep);
               }
               if (!StringUtils.isEmpty(cellPhone)) {
                  cri.where().andLike("cellPhone", cellPhone);
               }
            }
         }

         //根据拼装条件进行查询
         resultList = dao.query(UserVO.class, cri, pager);
         pager.setRecordCount(dao.count(UserVO.class, cri));

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   /**
    * 查询企业下员工列表
    * 
    * @return
    */
   public static QueryResult queryStuff(Dao dao, int currentPage, int pageSize, UserVO userVO) {
      List<UserVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         resultList = dao.query(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId()), pager);
         pager.setRecordCount(dao.count(UserVO.class, Cnd.where("companyId", "=", userVO.getCompanyId())));
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }
}
