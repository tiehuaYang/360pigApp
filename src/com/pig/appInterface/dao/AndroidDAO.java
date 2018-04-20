package com.pig.appInterface.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.pig.breedManage.vo.PigPregnancyVO;
import com.pig.breedManage.vo.PigsVO;
import com.pig.common.CommonConstants;
import com.pig.summryManage.vo.SummryVO;

@IocBean
public class AndroidDAO {
   protected static final Log log = Logs.getLog(AndroidDAO.class);
   @Inject
   private Dao dao;
   
   public QueryResult queryPig(UserVO userVO, int currentPage, int pageSize, String sexType, String state, int day){
      List<PigsVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      Calendar calendar = Calendar.getInstance();
      calendar.set(Calendar.HOUR_OF_DAY, 0);
      calendar.set(Calendar.MINUTE, 0);
      calendar.set(Calendar.SECOND, 0);
      calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - day);
      Criteria cri = Cnd.cri();
      cri.where().andEquals("companyId", userVO.getCompanyId()).andEquals("farmId", userVO.getDefaultFarm());
      cri.where().andEquals("isExit", CommonConstants.DB_CHAR_NO);
      String[] sexTypes = sexType.split(";");
      String[] states = state.split(";");
      cri.where().andIn("sexType", sexTypes).andIn("state", states);
      if(day != 0){
         cri.where().and("lastDate", "<", calendar.getTime());
      }
      cri.getOrderBy().asc("lastDate");
      resultList = dao.query(PigsVO.class, cri, pager);
      int count = dao.count(PigsVO.class, cri);
      pager.setRecordCount(count);
      return new QueryResult(resultList, pager);
   }
   
   public int countPig(UserVO userVO, String sexType, String state, int day, String date){
      Calendar calendar = Calendar.getInstance();
      calendar.set(Calendar.HOUR_OF_DAY, 0);
      calendar.set(Calendar.MINUTE, 0);
      calendar.set(Calendar.SECOND, 0);
      calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) - day);
      Criteria cri = Cnd.cri();
      cri.where().andEquals("companyId", userVO.getCompanyId()).andEquals("farmId", userVO.getDefaultFarm());
      cri.where().andEquals("isExit", CommonConstants.DB_CHAR_NO);
      String[] sexTypes = sexType.split(",");
      cri.where().andIn("sexType", sexTypes);
      if(state != null && state.length() > 0){
         String[] states = state.split(",");
         cri.where().andIn("state", states);
      }
      if(day != 0){
         cri.where().and("lastDate", "<", calendar.getTime());
      }
      if(date != null && date.length() > 0){
         cri.where().and("admissionDate", "<=", date + " 23:59:59");
      }
      int count = dao.count(PigsVO.class, cri);
      return count;
   }
   
   public int countPigIn(UserVO userVO, String startDate, String endDate){
      Criteria cri = Cnd.cri();
      cri.where().andEquals("companyId", userVO.getCompanyId()).andEquals("farmId", userVO.getDefaultFarm());
      cri.where().andBetween("admissionDate", startDate, endDate + " 23:59:59");
      int count = dao.count(PigsVO.class, cri);
      return count;
   }
   
   public List<SummryVO> countPigMating(UserVO userVO, String type, String startDate, String endDate){
      List<SummryVO> summryList = new ArrayList<SummryVO>();
      StringBuffer sb = new StringBuffer();
      sb.append(" SELECT ");
      if(type.equals("finalResult")){
         sb.append(" p.finalResult, ");
      }else if(type.equals("femaleState")){
         sb.append(" p.femaleState, ");
      }
      sb.append(" COUNT(1) count FROM cd_breed_pig_mating m LEFT JOIN cd_breed_pig_mating_pair p ON m.matingId = p.matingId ");
      sb.append(" WHERE m.companyId = @COMPANYID AND m.farmId = @FARMID ");
      sb.append(" AND p.matingDate >= @STARTDATE AND p.matingDate <= @ENDDATE ");
      if(type.equals("finalResult")){
         sb.append(" GROUP BY p.finalResult ");
      }else if(type.equals("femaleState")){
         sb.append(" GROUP BY p.femaleState ");
      }
      Sql sql = Sqls.create(sb.toString());
      sql.params().set("COMPANYID", userVO.getCompanyId());
      sql.params().set("FARMID", userVO.getDefaultFarm());
      sql.params().set("STARTDATE", startDate);
      sql.params().set("ENDDATE", endDate);
      sql.setCallback(Sqls.callback.entities());
      sql.setCallback(new SqlCallback() {
         @Override
         public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
            while (rs.next()) {
               SummryVO summryVO = new SummryVO();
               if(type.equals("finalResult")){
                  summryVO.setStr1(rs.getString("finalResult"));
               }else if(type.equals("femaleState")){
                  summryVO.setStr1(rs.getString("femaleState"));
               }
               summryVO.setInt1(rs.getInt("count"));
               summryList.add(summryVO);
            }
            return summryList;
         }
      });
      sql.setEntity(dao.getEntity(SummryVO.class));
      dao.execute(sql);
      return summryList;
   }
   
   public int countPigPregnancy(UserVO userVO, String state, String startDate, String endDate){
      Criteria cri = Cnd.cri();
      cri.where().andEquals("companyId", userVO.getCompanyId()).andEquals("farmId", userVO.getDefaultFarm());
      cri.where().andBetween("pregnancyDate", startDate, endDate + " 23:59:59");
      if(state != null && state.length() > 0){
         cri.where().andEquals("finalResult", state);
      }
      int count = dao.count(PigPregnancyVO.class, cri);
      return count;
   }
   
   /*..............................................小明部分.....................................................*/

}
