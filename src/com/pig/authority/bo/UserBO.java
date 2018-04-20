package com.pig.authority.bo;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.lang.random.R;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.trans.Atom;
import org.nutz.trans.Trans;

import com.pig.authority.dao.AuthorityDAO;
import com.pig.authority.vo.CompanyProfile;
import com.pig.authority.vo.Role;
import com.pig.authority.vo.UserRole;
import com.pig.authority.vo.UserVO;
import com.pig.breedManage.vo.PigCategoryVO;
import com.pig.breedManage.vo.PigStrainVO;
import com.pig.common.CommonConstants;
import com.pig.system.dao.UserDAO;
import com.pig.system.vo.PictureVO;

/**
 * UserBO 系统用户的业务处理类
 * 
 * @author erick
 */
public class UserBO {
   protected static final Log log = Logs.getLog(UserBO.class);

   /**
    * 用户注册
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean registerUser(final Dao dao, final UserVO userVO) {
      try {
         if (StringUtils.isNotBlank(userVO.getUserId()) && StringUtils.isNotBlank(userVO.getPassword())
               && StringUtils.isNotBlank(userVO.getLoginAcount())) {
            Trans.exec(new Atom() {
               @Override
               public void run() {
                  userVO.setSalt(R.UU16());
                  userVO.setPassword(new Sha256Hash(userVO.getPassword(), userVO.getSalt()).toHex());
                  Date today = new Date();
                  userVO.setCreateDate(today);
                  userVO.setLastLoginDate(today);
                  dao.insertWith(userVO, "companyProfile");//同时将用户和企业信息保存

                  //根据新注册的企业id生成对应的一批角色记录
                  AuthorityDAO.createDefaultRole(dao, userVO.getCompanyId());

                  //获得对应的管理员角色
                  Role role = dao.fetch(Role.class, Cnd.where("companyId", "=", userVO.getCompanyId()).and("name", "=",
                        CommonConstants.ROLE.ROLE_ADMIN));
                  //关联到当前注册的用户中，作为管理员帐号
                  dao.insert(UserRole.class, Chain.make("userId", userVO.getUserId()).add("roleId", role.getId()));

                  //根据新注册的管理员帐号生成默认权限（全权限）
                  AuthorityDAO.createDefaultAdminPermission(dao, role.getId());
                  /*StoreVO storeVO = new StoreVO();
                  storeVO.setStoreId(UUID.randomUUID().toString());
                  storeVO.setCompanyId(userVO.getCompanyId());
                  storeVO.setStoreName("默认仓库");
                  storeVO.setStoreIsDefault(CommonConstants.DB_CHAR_YES);
                  dao.insert(storeVO);*/

                  //默认为该公司创建品类品系
                  Map<String, Object> category = new HashMap<String, Object>();
                  category.put("长白", "长白");
                  category.put("大白", "大白");
                  category.put("杜洛克", "杜洛克");
                  category.put("二元", "二元");
                  Map<String, Object> strain = new HashMap<String, Object>();
                  strain.put("长白", "自繁,美系,丹系,加系,法系");
                  strain.put("大白", "自繁,美系,丹系,英系,加系,法系");
                  strain.put("杜洛克", "自繁,美系,丹系,加系,法系");
                  strain.put("二元", "长大,大长,杜长,杜大");

                  int index = 1;
                  for (String key : category.keySet()) {
                     PigCategoryVO pigCategoryVO = new PigCategoryVO();
                     pigCategoryVO.setCategoryId(UUID.randomUUID().toString());
                     pigCategoryVO.setCompanyId(userVO.getCompanyId());
                     pigCategoryVO.setCategoryName(key);
                     pigCategoryVO.setLevel(index);
                     dao.insert(pigCategoryVO);

                     String[] temp = strain.get(key).toString().split(",");
                     for (int i = 0; i < temp.length; i++) {
                        PigStrainVO pigStrainVO = new PigStrainVO();
                        pigStrainVO.setStrainId(UUID.randomUUID().toString());
                        pigStrainVO.setCompanyId(userVO.getCompanyId());
                        pigStrainVO.setCategoryId(pigCategoryVO.getCategoryId());
                        pigStrainVO.setStrainName(temp[i] + key);
                        pigStrainVO.setLevel(i + 1);
                        dao.insert(pigStrainVO);
                     }

                     index++;
                  }
               }
            });
            return true;
         }
         return false;
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    * 修改企业信息
    * 
    * @param dao
    * @param companyProfile
    * @param pictureVO
    * @return
    */
   public static boolean changeProfile(final Dao dao, final CompanyProfile companyProfile, final PictureVO pictureVO) {
      try {
         if (companyProfile != null) {
            Trans.exec(new Atom() {
               @Override
               public void run() {

                  if (pictureVO != null) {
                     PictureVO oldPic = dao.fetch(PictureVO.class, companyProfile.getCompanyId());
                     if (oldPic != null) {
                        dao.delete(oldPic);
                     }
                     dao.update(companyProfile);
                     dao.insert(pictureVO);
                  }
                  else {
                     dao.update(companyProfile);
                  }

               }
            });
            return true;
         }
         return false;
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }

      return false;
   }

   /**
    * 修改用户基本资料
    * 
    * @param dao
    * @param userVO
    * @param pictureVO
    * @return
    */
   public static boolean changeUserInfo(final Dao dao, final UserVO userVO, final PictureVO pictureVO) {
      try {
         if (userVO != null) {
            Trans.exec(new Atom() {
               @Override
               public void run() {

                  if (pictureVO != null) {
                     PictureVO oldPic = dao.fetch(PictureVO.class, userVO.getUserId());
                     if (oldPic != null) {
                        dao.delete(oldPic);
                     }
                     dao.updateIgnoreNull(userVO);
                     dao.insert(pictureVO);
                  }
                  else {
                     dao.updateIgnoreNull(userVO);
                  }

               }
            });
            return true;
         }
         return false;
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }

      return false;
   }

   /**
    * 创建一个用户和权限
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean createUser(final Dao dao, final UserVO userVO, final String[] roleIds) {
      try {
         if (StringUtils.isNotBlank(userVO.getUserId()) && StringUtils.isNotBlank(userVO.getPassword())
               && StringUtils.isNotBlank(userVO.getLoginAcount())) {
            Trans.exec(new Atom() {
               @Override
               public void run() {
                  userVO.setSalt(R.UU16());
                  userVO.setPassword(new Sha256Hash(userVO.getPassword(), userVO.getSalt()).toHex());
                  Date today = new Date();
                  userVO.setCreateDate(today);
                  userVO.setLastLoginDate(today);
                  dao.insert(userVO);

                  if (roleIds != null && roleIds.length > 0) {
                     for (String rId : roleIds) {
                        dao.insert(UserRole.class,
                              Chain.make("userId", userVO.getUserId()).add("roleId", Long.parseLong(rId)));
                     }
                  }

               }
            });
            return true;
         }
         return false;
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }

      return false;
   }

   /**
    * 修改用户信息和权限
    * 
    * @param dao
    * @param userVO
    * @return
    */
   public static boolean modifyUser(final Dao dao, final UserVO userVO, final PictureVO pictureVO,
         final String[] roleIds) {
      try {
         Trans.exec(new Atom() {
            @Override
            public void run() {
               if (pictureVO != null) {
                  PictureVO oldPic = dao.fetch(PictureVO.class, userVO.getUserId());
                  if (oldPic != null) {
                     dao.delete(oldPic);
                  }
                  dao.update(userVO);
                  dao.insert(pictureVO);
               }
               else {
                  dao.update(userVO);
               }

               if (roleIds != null && roleIds.length > 0) {
                  //先清除原有记录
                  dao.clear(UserRole.class, Cnd.where("userId", "=", userVO.getUserId()));

                  //根据id列表循环添加角色
                  for (String rId : roleIds) {
                     dao.insert(UserRole.class,
                           Chain.make("userId", userVO.getUserId()).add("roleId", Long.parseLong(rId)));
                  }
               }

            }
         });
         return true;
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }

      return false;
   }

   /**
    * 查询企业下员工列表
    * 
    * @return
    */
   public static QueryResult queryStuff(Dao dao, int currentPage, int pageSize, UserVO userVO) {
      return UserDAO.queryStuff(dao, currentPage, pageSize, userVO);
   }

//   /**
//    * 根据邮箱判断用户是否已存在
//    * 
//    * @param dao
//    * @param userVO
//    * @return
//    */
//   public static boolean isExistByEmail(Dao dao, UserVO userVO)
//   {
//      try
//      {
//         return UserDAO.isExistByEmail(dao, userVO);
//      }
//      catch (Exception e)
//      {
//         e.printStackTrace();
//         log.error(e);
//      }
//      return false;
//   }

   /**
    * 判断登录名是否已经存在
    * 
    * @param dao
    * @param userVO
    * @return boolean
    */
   public static boolean isExistByAcount(Dao dao, UserVO userVO) {
      try {
         return UserDAO.isExistByAcount(dao, userVO);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    * 获取企业的员工总数
    * 
    * @param dao
    * @param userVO
    * @return boolean
    */
   public static int getCompanyUserCount(Dao dao, UserVO userVO) {
      return UserDAO.getCompanyUserCount(dao, userVO);
   }

   //根据企业名称查找企业信息
   public static CompanyProfile fetchByName(Dao dao, String companyName) {
      return dao.fetch(CompanyProfile.class, Cnd.where("companyName", "=", companyName).and("userType", "=", "SALES"));
   }

   /*public static JSONArray getCompanyUserSystem(Dao dao, UserVO userVO) {
      JSONArray jarray = new JSONArray();
      StringBuffer sb = new StringBuffer();
      try {
         sb.append(
               "SELECT u.`userName`,s.`userId`,s.`parentId` FROM cd_auth_user u LEFT JOIN cd_auth_user_system s ON u.`userId`=s.`userId` WHERE u.companyId = @companyId ORDER BY s.`id` ");
         Sql sql = Sqls.create(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.setCallback(new SqlCallback() {
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               JSONArray jarray = new JSONArray();
               while (rs.next()) {
                  JSONObject json = new JSONObject();
                  json.put("id", rs.getString("userId"));
                  json.put("text", rs.getString("userName"));
                  if (!rs.getString("userId").equals(rs.getObject("parentId"))) {
                     json.put("parentId", rs.getString("parentId"));
                  }
                  jarray.add(json);
               }
               return jarray;
            }
         });
         dao.execute(sql);
         jarray = (JSONArray) sql.getResult();
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return jarray;
   }*/

}
