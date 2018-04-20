package com.pig.breedManage.bo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.dao.Sqls;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.pig.authority.vo.UserVO;
import com.pig.breedManage.vo.PigCategoryVO;
import com.pig.breedManage.vo.PigStrainVO;

/**
 * 逻辑处理层
 * 
 * @author erick
 */
@IocBean
public class CategoryStrainBO {
   protected static final Log log = Logs.getLog(CategoryStrainBO.class);
   @Inject
   private Dao dao;

   public QueryResult queryPigCategory(int currentPage, int pageSize, UserVO userVO, String categoryName) {
      List<PigCategoryVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      Criteria cri = Cnd.cri();

      cri.where().and("companyId", "=", userVO.getCompanyId());
      cri.getOrderBy().asc("level");
      if (categoryName != null && categoryName.length() > 0) {
         cri.where().andLike("categoryName", categoryName);
      }

      resultList = dao.query(PigCategoryVO.class, cri, pager);
      int count = dao.count(PigCategoryVO.class, cri);

      pager.setRecordCount(count);
      return new QueryResult(resultList, pager);
   }

   public QueryResult queryPigStrain(int currentPage, int pageSize, UserVO userVO, String categoryId,
         String strainName) {
      List<PigStrainVO> resultList = null;
      StringBuffer sb = new StringBuffer();
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         sb.append(
               "SELECT s.* FROM cd_breed_pig_strain s LEFT JOIN cd_breed_pig_category c ON s.`categoryId`=c.`categoryId` WHERE s.companyId=@companyId");
         if (categoryId != null && categoryId.length() > 0) {
            sb.append(" AND s.categoryId = @categoryId");
         }
         if (strainName != null && strainName.length() > 0) {
            sb.append(" AND s.strainName LIKE @strainName");
         }
         sb.append(" ORDER BY c.level ASC,s.level ASC");
         Sql sql = Sqls.create(sb.toString());
         sql.setPager(pager);
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("categoryId", categoryId);
         sql.params().set("strainName", "%" + strainName + "%");
         sql.setCallback(Sqls.callback.entities());
         sql.setCallback(new SqlCallback() {
            @Override
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               List<PigStrainVO> list = new LinkedList<PigStrainVO>();
               while (rs.next()) {
                  PigStrainVO pigStrainVO = new PigStrainVO();
                  pigStrainVO.setStrainId(rs.getString("strainId"));
                  pigStrainVO.setCompanyId(rs.getString("companyId"));
                  pigStrainVO.setCategoryId(rs.getString("categoryId"));
                  pigStrainVO.setStrainName(rs.getString("strainName"));
                  pigStrainVO.setLevel(rs.getInt("level"));
                  list.add(pigStrainVO);
               }
               return list;
            }
         });
         sql.setEntity(dao.getEntity(PigStrainVO.class));
         dao.execute(sql);
         resultList = sql.getList(PigStrainVO.class);

         //统计记录个数
         sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(s.strainId) AS counts FROM cd_breed_pig_strain s LEFT JOIN cd_breed_pig_category c ON s.`categoryId`=c.`categoryId` WHERE s.companyId=@companyId");
         if (categoryId != null && categoryId.length() > 0) {
            sb.append(" AND s.categoryId = @categoryId");
         }
         if (strainName != null && strainName.length() > 0) {
            sb.append(" AND s.strainName LIKE @strainName");
         }
         sb.append(" ORDER BY c.level ASC,s.level ASC");
         sql = Sqls.fetchInt(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("categoryId", categoryId);
         sql.params().set("strainName", "%" + strainName + "%");
         dao.execute(sql);
         pager.setRecordCount(sql.getInt());
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }
}
