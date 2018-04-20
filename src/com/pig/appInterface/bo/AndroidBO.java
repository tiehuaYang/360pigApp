package com.pig.appInterface.bo;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.nutz.trans.Atom;
import org.nutz.trans.Trans;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.pig.appInterface.dao.AndroidDAO;
import com.pig.authority.vo.UserVO;
import com.pig.breedManage.vo.FarmPenVO;
import com.pig.breedManage.vo.PigChildBirthVO;
import com.pig.breedManage.vo.PigMatingPairVO;
import com.pig.breedManage.vo.PigMatingVO;
import com.pig.breedManage.vo.PigPregnancyVO;
import com.pig.breedManage.vo.PigsVO;
import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.pig.summryManage.vo.SummryVO;

@IocBean
public class AndroidBO {
   protected static final Log log = Logs.getLog(AndroidBO.class);
   @Inject
   private Dao dao;
   @Inject
   protected AndroidDAO androidDAO;

   public QueryResult queryPig(UserVO userVO, int currentPage, int pageSize, String sexType, String state, int day) {
      return androidDAO.queryPig(userVO, currentPage, pageSize, sexType, state, day);
   }

   public int countPig(UserVO userVO, String sexType, String state, int day, String date) {
      return androidDAO.countPig(userVO, sexType, state, day, date);
   }

   public int countPigIn(UserVO userVO, String startDate, String endDate) {
      return androidDAO.countPigIn(userVO, startDate, endDate);
   }

   public List<SummryVO> countPigMating(UserVO userVO, String state, String startDate, String endDate) {
      return androidDAO.countPigMating(userVO, state, startDate, endDate);
   }

   public int countPigPregnancy(UserVO userVO, String state, String startDate, String endDate) {
      return androidDAO.countPigPregnancy(userVO, state, startDate, endDate);
   }

   /*..............................................小明部分.....................................................*/

   public Map<String, Object> addPigMating(UserVO userVO, PigMatingVO pigMatingVO, PigMatingPairVO pigMatingPairVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               dao.insert(pigMatingVO);
               dao.insert(pigMatingPairVO);

               //更改母猪相关
               PigsVO female = dao.fetch(PigsVO.class, pigMatingPairVO.getFemalePigsId());
               female.setState(CommonConstants.PIG.PIG_STATE_PREGNANT);
               female.setLastDate(pigMatingPairVO.getMatingDate());
               female.setLastEvent(CommonConstants.PIG.PIG_EVENT_BREEDING);
               female.setFlowId(pigMatingVO.getFlowId());
               dao.updateIgnoreNull(female);

               //更改公猪相关
               PigsVO male = dao.fetch(PigsVO.class, pigMatingPairVO.getMalePigsId());
               male.setState(CommonConstants.PIG.PIG_STATE_MALE);
               male.setLastDate(pigMatingPairVO.getMatingDate());
               male.setLastEvent(CommonConstants.PIG.PIG_EVENT_BREEDING);
               male.setFlowId(pigMatingVO.getFlowId());
               dao.updateIgnoreNull(male);

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> editPigMating(UserVO userVO, PigMatingVO pigMatingVO, String matingPairList) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               dao.updateIgnoreNull(pigMatingVO);

               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               JSONArray jarray = JSONArray.parseArray(matingPairList);
               for (int i = 0; i < jarray.size(); i++) {
                  JSONObject json = jarray.getJSONObject(i);

                  Date date = new Date();
                  try {
                     date = sdf.parse(json.get("matingDate").toString());
                  }
                  catch (ParseException e) {
                     e.printStackTrace();
                  }
//                  System.out.println(json.get("pairId"));
//                  System.out.println(json.get("matingId"));
//                  System.out.println(json.get("femalePigsId"));
//                  System.out.println(json.get("malePigsId"));
//                  System.out.println(json.get("spermId"));
//                  System.out.println(json.get("pairType"));
//                  System.out.println(json.get("matingDate"));

                  PigMatingPairVO pigMatingPairVO = new PigMatingPairVO();
                  pigMatingPairVO.setPairId(CommonUtils.valueFormat(json.get("pairId")));
                  pigMatingPairVO.setMatingId(json.get("matingId").toString());
                  pigMatingPairVO.setFemalePigsId(json.get("femalePigsId").toString());
                  pigMatingPairVO.setMalePigsId(json.get("malePigsId").toString());
                  pigMatingPairVO.setSpermId(CommonUtils.valueFormat(json.get("spermId")));
                  pigMatingPairVO.setPairType(Integer.parseInt(json.get("pairType").toString()));
                  pigMatingPairVO.setMatingDate(date);

                  if (pigMatingPairVO.getPairId() != null) {
                     dao.updateIgnoreNull(pigMatingPairVO);
                  }
                  else {
                     pigMatingPairVO.setPairId(UUID.randomUUID().toString());
                     pigMatingPairVO.setFinalResult(CommonConstants.PIG.PIG_STATE_PREGNANT);

                     PigsVO female = dao.fetch(PigsVO.class, json.get("femalePigsId").toString());
                     pigMatingPairVO.setFemaleState(female.getState());
                     pigMatingPairVO.setFemaleLastDate(female.getLastDate());

                     PigsVO male = dao.fetch(PigsVO.class, json.get("malePigsId").toString());
                     pigMatingPairVO.setMaleState(male.getState());
                     pigMatingPairVO.setMaleLastDate(male.getLastDate());

//                     //更改妊检记录的公猪字段为新的公猪
//                     PigMatingVO pm = dao.fetch(PigMatingVO.class,
//                           Cnd.where("matingId", "=", pigMatingVO.getMatingId()));
//
//                     PigPregnancyVO pigPregnancyVO = dao.fetch(PigPregnancyVO.class,
//                           Cnd.where("flowId", "=", pm.getFlowId()));
//                     if (pigPregnancyVO != null) {
//                        pigPregnancyVO.setPairId(pigMatingPairVO.getPairId());
//                        pigPregnancyVO.setMalePigsId(pigMatingPairVO.getMalePigsId());
//                        pigPregnancyVO.setLastEventDate(date);
//                        dao.update(pigPregnancyVO);
//                     }

                     //将所有的妊检记录状态改为1，表示已经失效无法修改，只能再新增一条妊检记录
                     PigMatingVO pm = dao.fetch(PigMatingVO.class,
                           Cnd.where("matingId", "=", pigMatingVO.getMatingId()));
                     List<PigPregnancyVO> pigPregnancyList = dao.query(PigPregnancyVO.class,
                           Cnd.where("flowId", "=", pm.getFlowId()));
                     for (int j = 0; j < pigPregnancyList.size(); j++) {
                        pigPregnancyList.get(j).setState("1");
                     }
                     dao.update(pigPregnancyList);

                     //新增配种公猪
                     dao.insert(pigMatingPairVO);
                  }

                  if (i == jarray.size() - 1) {
                     PigMatingVO p = dao.fetch(PigMatingVO.class, pigMatingVO.getMatingId());

                     PigsVO female = dao.fetch(PigsVO.class, json.get("femalePigsId").toString());
                     //判断当前记录的flowId 与 母猪的flowId 是否一致
                     if (p.getFlowId().equals(female.getFlowId())) {
                        //更改母猪相关
                        female.setState(CommonConstants.PIG.PIG_STATE_PREGNANT);
                        female.setLastDate(date);
                        female.setLastEvent(CommonConstants.PIG.PIG_EVENT_BREEDING);
                        dao.update(female);

                        //更改公猪相关
                        PigsVO male = dao.fetch(PigsVO.class, json.get("malePigsId").toString());
                        if (male.getFlowId().equals(p.getFlowId())) {
                           male.setState(CommonConstants.PIG.PIG_STATE_MALE);
                           male.setLastDate(date);
                           male.setLastEvent(CommonConstants.PIG.PIG_EVENT_BREEDING);
                           dao.update(male);
                        }
                     }

                  }

               }

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> delPigMating(UserVO userVO, String matingId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               //回滚数据
               PigMatingVO pigMatingVO = dao.fetch(PigMatingVO.class, Cnd.where("matingId", "=", matingId));

               //删除分娩记录
               PigChildBirthVO pigChildBirthVO = dao.fetch(PigChildBirthVO.class,
                     Cnd.where("flowId", "=", pigMatingVO.getFlowId()));
               if (pigChildBirthVO != null) {
                  //先还原以前舍的乳猪数量
                  FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", pigChildBirthVO.getPenId()));
                  int sucklingNum = farmPenVO.getSucklingNum();
                  sucklingNum = sucklingNum - Integer.parseInt(pigChildBirthVO.getTotalChild());
                  farmPenVO.setSucklingNum(sucklingNum);

                  //先还原以前舍的乳猪总重量
                  double sucklingWeight = farmPenVO.getSucklingWeight();
                  sucklingWeight = sucklingWeight - Double.parseDouble(pigChildBirthVO.getTotalChildWeight());
                  farmPenVO.setSucklingWeight(sucklingWeight);

                  dao.update(farmPenVO);

                  dao.clear(PigChildBirthVO.class, Cnd.where("flowId", "=", pigChildBirthVO.getFlowId()));
               }

               //删除妊检记录
               dao.clear(PigPregnancyVO.class, Cnd.where("flowId", "=", pigMatingVO.getFlowId()));

               //删除子表
               List<PigMatingPairVO> pigMatingPairList = dao.query(PigMatingPairVO.class,
                     Cnd.where("matingId", "=", pigMatingVO.getMatingId()).asc("matingDate"));
               PigsVO pigsVO = dao.fetch(PigsVO.class, Cnd.where("pigsId", "=", pigMatingVO.getFemalePigsId()));
               for (int i = 0; i < pigMatingPairList.size(); i++) {
                  if (i == 0) {
                     if (pigMatingVO.getFlowId().equals(pigsVO.getFlowId())) {
                        pigsVO.setState(pigMatingPairList.get(i).getFemaleState());
                        pigsVO.setLastDate(pigMatingPairList.get(i).getFemaleLastDate());
                        pigsVO.setLastEvent(getLastEvent(pigMatingPairList.get(i).getFemaleState()));
                        dao.update(pigsVO);
                     }
                     dao.clear(PigMatingPairVO.class, Cnd.where("pairId", "=", pigMatingPairList.get(i).getPairId()));
                  }
                  else {
                     dao.clear(PigMatingPairVO.class, Cnd.where("pairId", "=", pigMatingPairList.get(i).getPairId()));
                  }
               }

               //先删除子表再删除主表
               dao.clear(PigMatingVO.class, Cnd.where("matingId", "=", pigMatingVO.getMatingId()));

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public String getLastEvent(String state) {
      String event = "";
      if ("1".equals(state)) {
         event = "1";
      }
      else if ("3".equals(state)) {
         event = "3";
      }
      return event;
   }

   public QueryResult queryLegalMatingFemalePigs(int currentPage, int pageSize, UserVO userVO, String earTag) {
      List<PigsVO> resultList = null;
      StringBuffer sb = new StringBuffer();
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         sb.append(
               "SELECT d.* FROM (SELECT *,CASE WHEN k.state = '1' THEN DATEDIFF(NOW(), k.lastDate) WHEN k.state = '3' THEN DATEDIFF(NOW(), k.childbirthDate) END AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT childbirthDate FROM cd_breed_pig_childbirth WHERE matingId = m.`matingId` ORDER BY childbirthDate DESC LIMIT 0,1) AS childbirthDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId` LEFT JOIN `cd_breed_pig_childbirth` c ON p.`flowId`=c.`flowId` ) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND (d.state = '1' OR d.state = '3') ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sb.append(" ORDER BY d.dayCount DESC");
         Sql sql = Sqls.create(sb.toString());
         sql.setPager(pager);
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         sql.setCallback(Sqls.callback.entities());
         sql.setCallback(new SqlCallback() {
            @Override
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               List<PigsVO> list = new LinkedList<PigsVO>();
               while (rs.next()) {
                  PigsVO pigsVO = new PigsVO();
                  pigsVO.setPigsId(rs.getString("pigsId"));
                  pigsVO.setEarTag(rs.getString("earTag"));
                  pigsVO.setPenId(rs.getString("penId"));
                  pigsVO.setCategoryId(rs.getString("categoryId"));
                  pigsVO.setState(rs.getString("state"));
                  pigsVO.setDayCount(rs.getInt("dayCount"));
                  list.add(pigsVO);
               }
               return list;
            }
         });
         sql.setEntity(dao.getEntity(PigsVO.class));
         dao.execute(sql);
         resultList = sql.getList(PigsVO.class);

         //统计记录个数
         sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(d.pigsId) AS counts FROM (SELECT *,CASE WHEN k.state = '1' THEN DATEDIFF(NOW(), k.lastDate) WHEN k.state = '3' THEN DATEDIFF(NOW(), k.childbirthDate) END AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT childbirthDate FROM cd_breed_pig_childbirth WHERE matingId = m.`matingId` ORDER BY childbirthDate DESC LIMIT 0,1) AS childbirthDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId` LEFT JOIN `cd_breed_pig_childbirth` c ON p.`flowId`=c.`flowId` ) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND (d.state = '1' OR d.state = '3') ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sql = Sqls.fetchInt(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         dao.execute(sql);
         pager.setRecordCount(sql.getInt());
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   public QueryResult queryLegalMatingMalePigs(int currentPage, int pageSize, UserVO userVO, String earTag) {
      List<PigsVO> resultList = null;
      StringBuffer sb = new StringBuffer();
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         sb.append(
               "SELECT d.* FROM (SELECT *,CASE WHEN k.state = '1' THEN DATEDIFF(NOW(), k.lastDate) WHEN k.state = '7' THEN DATEDIFF(NOW(), k.matingDate) END AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0,1 ) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId`) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '0' AND (d.state = 1 OR d.state = 7) ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sb.append(" ORDER BY d.dayCount DESC");
         Sql sql = Sqls.create(sb.toString());
         sql.setPager(pager);
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         sql.setCallback(Sqls.callback.entities());
         sql.setCallback(new SqlCallback() {
            @Override
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               List<PigsVO> list = new LinkedList<PigsVO>();
               while (rs.next()) {
                  PigsVO pigsVO = new PigsVO();
                  pigsVO.setPigsId(rs.getString("pigsId"));
                  pigsVO.setEarTag(rs.getString("earTag"));
                  pigsVO.setPenId(rs.getString("penId"));
                  pigsVO.setCategoryId(rs.getString("categoryId"));
                  pigsVO.setState(rs.getString("state"));
                  pigsVO.setDayCount(rs.getInt("dayCount"));
                  list.add(pigsVO);
               }
               return list;
            }
         });
         sql.setEntity(dao.getEntity(PigsVO.class));
         dao.execute(sql);
         resultList = sql.getList(PigsVO.class);

         //统计记录个数
         sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(d.pigsId) AS counts FROM (SELECT *,CASE WHEN k.state = '1' THEN DATEDIFF(NOW(), k.lastDate) WHEN k.state = '7' THEN DATEDIFF(NOW(), k.matingDate) END AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0,1 ) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId`) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '0' AND (d.state = 1 OR d.state = 7) ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sql = Sqls.fetchInt(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         dao.execute(sql);
         pager.setRecordCount(sql.getInt());
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   public QueryResult queryMating(int currentPage, int pageSize, UserVO userVO, String femalePigsId, String startDate,
         String endDate, String penId) {
      List<PigMatingVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      Criteria cri = Cnd.cri();

      cri.where().and("companyId", "=", userVO.getCompanyId());
      cri.where().and("farmId", "=", userVO.getDefaultFarm());

      cri.getOrderBy().desc("createDate");

      if (penId != null && penId.length() > 0) {
         cri.where().and("penId", "=", penId);
      }

      if (femalePigsId != null && femalePigsId.length() > 0) {
         cri.where().andLike("femalePigsId", femalePigsId);
      }

      if (startDate != null && endDate != null) {
         cri.where().andBetween("DATE_FORMAT(createDate,'%Y-%m-%d')", startDate, endDate);
      }

      resultList = dao.query(PigMatingVO.class, cri, pager);
      int count = dao.count(PigMatingVO.class, cri);

      pager.setRecordCount(count);
      return new QueryResult(resultList, pager);
   }

   public Map<String, Object> addPigPregnancy(UserVO userVO, PigPregnancyVO pigPregnancyVO, PigsVO pigsVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               dao.insert(pigPregnancyVO);

               //更新配种子表的finalResult
               PigMatingPairVO pigMatingPairVO = dao.fetch(PigMatingPairVO.class, pigPregnancyVO.getPairId());
               pigMatingPairVO.setFinalResult(pigPregnancyVO.getFinalResult());
               dao.update(pigMatingPairVO);

               //更改猪的状态
               pigsVO.setState(pigPregnancyVO.getFinalResult());
               pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_TEST);
               pigsVO.setLastDate(pigPregnancyVO.getPregnancyDate());
               dao.update(pigsVO);

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> editPigPregnancy(UserVO userVO, PigPregnancyVO pigPregnancyVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               dao.updateIgnoreNull(pigPregnancyVO);

               //更新配种子表的finalResult
               PigMatingPairVO pigMatingPairVO = dao.fetch(PigMatingPairVO.class, pigPregnancyVO.getPairId());
               pigMatingPairVO.setFinalResult(pigPregnancyVO.getFinalResult());
               dao.update(pigMatingPairVO);

               //更改猪的状态
               PigsVO pigsVO = dao.fetch(PigsVO.class, pigPregnancyVO.getFemalePigsId());

               if (pigsVO.getFlowId().equals(pigPregnancyVO.getFlowId())) {
                  pigsVO.setState(pigPregnancyVO.getFinalResult());
                  pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_TEST);
                  pigsVO.setLastDate(pigPregnancyVO.getPregnancyDate());
                  dao.update(pigsVO);
               }

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> delPigPregnancy(UserVO userVO, PigPregnancyVO pigPregnancyVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               //数据回滚（分娩的记录回滚）
               PigChildBirthVO pigChildBirthVO = dao.fetch(PigChildBirthVO.class, Cnd
                     .where("flowId", "=", pigPregnancyVO.getFlowId()).and("pairId", "=", pigPregnancyVO.getPairId()));
               if (pigChildBirthVO != null) {
                  //先还原以前舍的乳猪数量
                  FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", pigChildBirthVO.getPenId()));
                  int sucklingNum = farmPenVO.getSucklingNum();
                  sucklingNum = sucklingNum - Integer.parseInt(pigChildBirthVO.getTotalChild());
                  farmPenVO.setSucklingNum(sucklingNum);

                  //先还原以前舍的乳猪总重量
                  double sucklingWeight = farmPenVO.getSucklingWeight();
                  sucklingWeight = sucklingWeight - Double.parseDouble(pigChildBirthVO.getTotalChildWeight());
                  farmPenVO.setSucklingWeight(sucklingWeight);

                  dao.update(farmPenVO);

                  //删除分娩记录
                  dao.clear(PigChildBirthVO.class, Cnd.where("childbirthId", "=", pigChildBirthVO.getChildbirthId()));
               }

               //删除记录之前先把状态还原回怀孕状态
               PigsVO pigsVO = dao.fetch(PigsVO.class, pigPregnancyVO.getFemalePigsId());
               if (pigPregnancyVO.getFlowId().equals(pigsVO.getFlowId())) {
                  pigsVO.setState(CommonConstants.PIG.PIG_STATE_PREGNANT);
                  pigsVO.setLastDate(pigPregnancyVO.getLastEventDate());
                  pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_BREEDING);
                  dao.update(pigsVO);
               }

               //删除妊检记录
               dao.clear(PigPregnancyVO.class, Cnd.where("pregnancyId", "=", pigPregnancyVO.getPregnancyId()));
               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public QueryResult queryLegalPregnancyFemalePigs(int currentPage, int pageSize, UserVO userVO, String earTag) {
      List<PigsVO> resultList = null;
      StringBuffer sb = new StringBuffer();
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         sb.append(
               "SELECT d.* FROM (SELECT *,DATEDIFF(NOW(), k.matingDate) AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0,1 ) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId`) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND d.state = '2' AND d.matingDate IS NOT NULL AND DATEDIFF(DATE_FORMAT(NOW(),'%Y-%m-%d'), DATE_FORMAT(d.matingDate,'%Y-%m-%d')) >= 5");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sb.append(" ORDER BY d.dayCount DESC");
         Sql sql = Sqls.create(sb.toString());
         sql.setPager(pager);
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         sql.setCallback(Sqls.callback.entities());
         sql.setCallback(new SqlCallback() {
            @Override
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               List<PigsVO> list = new LinkedList<PigsVO>();
               while (rs.next()) {
                  PigsVO pigsVO = new PigsVO();
                  pigsVO.setPigsId(rs.getString("pigsId"));
                  pigsVO.setEarTag(rs.getString("earTag"));
                  pigsVO.setPenId(rs.getString("penId"));
                  pigsVO.setCategoryId(rs.getString("categoryId"));
                  pigsVO.setState(rs.getString("state"));
                  pigsVO.setDayCount(rs.getInt("dayCount"));
                  list.add(pigsVO);
               }
               return list;
            }
         });
         sql.setEntity(dao.getEntity(PigsVO.class));
         dao.execute(sql);
         resultList = sql.getList(PigsVO.class);

         //统计记录个数
         sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(d.pigsId) AS counts FROM (SELECT *,DATEDIFF(NOW(), k.matingDate) AS dayCount FROM (SELECT * FROM (SELECT p.*,(SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0,1 ) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId`=m.`flowId`) s ) k ) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND d.state = '2' AND d.matingDate IS NOT NULL AND DATEDIFF(DATE_FORMAT(NOW(),'%Y-%m-%d'), DATE_FORMAT(d.matingDate,'%Y-%m-%d')) >= 5 ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sql = Sqls.fetchInt(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         dao.execute(sql);
         pager.setRecordCount(sql.getInt());
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   public QueryResult queryPregnancy(int currentPage, int pageSize, UserVO userVO, String femalePigsId,
         String startDate, String endDate, String penId) {
      List<PigPregnancyVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      Criteria cri = Cnd.cri();

      cri.where().and("companyId", "=", userVO.getCompanyId());
      cri.where().and("farmId", "=", userVO.getDefaultFarm());

      cri.getOrderBy().desc("pregnancyDate");

      if (penId != null && penId.length() > 0) {
         cri.where().and("penId", "=", penId);
      }

      if (femalePigsId != null && femalePigsId.length() > 0) {
         cri.where().andLike("femalePigsId", femalePigsId);
      }

      if (startDate != null && endDate != null) {
         cri.where().andBetween("DATE_FORMAT(pregnancyDate,'%Y-%m-%d')", startDate, endDate);
      }

      resultList = dao.query(PigPregnancyVO.class, cri, pager);
      int count = dao.count(PigPregnancyVO.class, cri);

      pager.setRecordCount(count);
      return new QueryResult(resultList, pager);
   }

   public Map<String, Object> addPigChildBirth(UserVO userVO, PigChildBirthVO pigChildBirthVO, PigsVO pigsVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               dao.insert(pigChildBirthVO);

               //更改猪舍的乳猪数量
               FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", pigChildBirthVO.getPenId()));
               int sucklingNum = farmPenVO.getSucklingNum();
               sucklingNum = sucklingNum + Integer.parseInt(pigChildBirthVO.getTotalChild());
               farmPenVO.setSucklingNum(sucklingNum);

               //更改猪舍的乳猪总重量
               double sucklingWeight = farmPenVO.getSucklingWeight();
               sucklingWeight = sucklingWeight + Double.parseDouble(pigChildBirthVO.getTotalChildWeight());
               farmPenVO.setSucklingWeight(sucklingWeight);

               dao.update(farmPenVO);

               //更改猪的状态
               pigsVO.setState(CommonConstants.PIG.PIG_STATE_CHILDBIRTH);
               pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_CHILDBIRTH);
               pigsVO.setLastDate(pigChildBirthVO.getChildbirthDate());
               dao.update(pigsVO);

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> editPigChildBirth(UserVO userVO, PigChildBirthVO pigChildBirthVO, FarmPenVO farmPenVO) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               //还原以前的数据
               dao.update(farmPenVO);

               //更改猪舍的乳猪数量
               FarmPenVO farmPenVOS = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", pigChildBirthVO.getPenId()));
               int sucklingNum = farmPenVOS.getSucklingNum();
               sucklingNum = sucklingNum + Integer.parseInt(pigChildBirthVO.getTotalChild());
               farmPenVOS.setSucklingNum(sucklingNum);

               //更改猪舍的乳猪总重量
               double sucklingWeight = farmPenVOS.getSucklingWeight();
               sucklingWeight = sucklingWeight + Double.parseDouble(pigChildBirthVO.getTotalChildWeight());
               farmPenVOS.setSucklingWeight(sucklingWeight);

               dao.update(farmPenVOS);

               //更新分娩记录
               dao.updateIgnoreNull(pigChildBirthVO);

               //更改猪的lastDate
               PigChildBirthVO pigcb = dao.fetch(PigChildBirthVO.class,
                     Cnd.where("childbirthId", "=", pigChildBirthVO.getChildbirthId()));
               PigsVO pigsVO = dao.fetch(PigsVO.class, Cnd.where("pigsId", "=", pigcb.getFemalePigsId()));
               pigsVO.setLastDate(pigChildBirthVO.getChildbirthDate());
               dao.update(pigsVO);

               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public Map<String, Object> delPigChildBirth(UserVO userVO, String childbirthId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         Trans.exec(new Atom() {

            @Override
            public void run() {
               //删除记录之前先把状态还原回怀孕状态
               PigChildBirthVO pigChildBirthVO = dao.fetch(PigChildBirthVO.class, childbirthId);
               PigsVO pigsVO = dao.fetch(PigsVO.class, pigChildBirthVO.getFemalePigsId());
               if (pigChildBirthVO.getFlowId().equals(pigsVO.getFlowId())) {
                  pigsVO.setState(CommonConstants.PIG.PIG_STATE_PREGNANT);
                  pigsVO.setLastDate(pigChildBirthVO.getLastEventDate());
                  pigsVO.setLastEvent(CommonConstants.PIG.PIG_EVENT_TEST);
                  dao.update(pigsVO);
               }

               //先还原以前舍的乳猪数量
               FarmPenVO farmPenVO = dao.fetch(FarmPenVO.class, Cnd.where("penId", "=", pigChildBirthVO.getPenId()));
               int sucklingNum = farmPenVO.getSucklingNum();
               sucklingNum = sucklingNum - Integer.parseInt(pigChildBirthVO.getTotalChild());
               farmPenVO.setSucklingNum(sucklingNum);

               //先还原以前舍的乳猪总重量
               double sucklingWeight = farmPenVO.getSucklingWeight();
               sucklingWeight = sucklingWeight - Double.parseDouble(pigChildBirthVO.getTotalChildWeight());
               farmPenVO.setSucklingWeight(sucklingWeight);

               dao.update(farmPenVO);

               //删除分娩记录
               dao.clear(PigChildBirthVO.class, Cnd.where("childbirthId", "=", childbirthId));
               map.put("result", "true");
            }

         });
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "false");
         map.put("msg", "");
      }
      return map;
   }

   public QueryResult queryLegalChildBirthFemalePigs(int currentPage, int pageSize, UserVO userVO, String earTag) {
      List<PigsVO> resultList = null;
      StringBuffer sb = new StringBuffer();
      Pager pager = dao.createPager(currentPage, pageSize);
      try {
         sb.append(
               "SELECT d.* FROM (SELECT *, DATEDIFF(NOW(), k.matingDate) AS dayCount, DATE_FORMAT(DATE_ADD(k.matingDate, INTERVAL 115 DAY),'%Y-%m-%d') AS preChildbirthDate FROM (SELECT * FROM (SELECT p.*, (SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0, 1) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId` = m.`flowId`) s) k) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND d.state = '2' AND d.lastEvent = '4' AND d.matingDate IS NOT NULL AND d.dayCount >= 105 ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sb.append(" ORDER BY d.dayCount DESC");
         Sql sql = Sqls.create(sb.toString());
         sql.setPager(pager);
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         sql.setCallback(Sqls.callback.entities());
         sql.setCallback(new SqlCallback() {
            @Override
            public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
               List<PigsVO> list = new LinkedList<PigsVO>();
               while (rs.next()) {
                  PigsVO pigsVO = new PigsVO();
                  pigsVO.setPigsId(rs.getString("pigsId"));
                  pigsVO.setEarTag(rs.getString("earTag"));
                  pigsVO.setPenId(rs.getString("penId"));
                  pigsVO.setCategoryId(rs.getString("categoryId"));
                  pigsVO.setState(rs.getString("state"));
                  pigsVO.setDayCount(rs.getInt("dayCount"));
                  pigsVO.setPreChildbirthDate(rs.getDate("preChildbirthDate"));
                  list.add(pigsVO);
               }
               return list;
            }
         });
         sql.setEntity(dao.getEntity(PigsVO.class));
         dao.execute(sql);
         resultList = sql.getList(PigsVO.class);

         //统计记录个数
         sb = new StringBuffer();
         sb.append(
               "SELECT COUNT(d.pigsId) as counts FROM (SELECT *, DATEDIFF(NOW(), k.matingDate) AS dayCount, DATE_FORMAT(DATE_ADD(k.matingDate, INTERVAL 115 DAY),'%Y-%m-%d') AS preChildbirthDate FROM (SELECT * FROM (SELECT p.*, (SELECT matingDate FROM cd_breed_pig_mating_pair WHERE `finalResult` = '2' AND matingId = m.`matingId` ORDER BY matingDate DESC LIMIT 0, 1) AS matingDate FROM `cd_breed_pigs` p LEFT JOIN `cd_breed_pig_mating` m ON p.`flowId` = m.`flowId`) s) k) d WHERE d.companyId = @companyId AND d.farmId = @farmId AND d.isExit = 'N' AND d.sexType = '1' AND d.state = '2' AND d.lastEvent = '4' AND d.matingDate IS NOT NULL AND d.dayCount >= 105 ");
         if (earTag != null && earTag.length() > 0) {
            sb.append(" AND d.earTag LIKE @earTag");
         }
         sql = Sqls.fetchInt(sb.toString());
         sql.params().set("companyId", userVO.getCompanyId());
         sql.params().set("farmId", userVO.getDefaultFarm());
         sql.params().set("earTag", "%" + earTag + "%");
         dao.execute(sql);
         pager.setRecordCount(sql.getInt());
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

   public QueryResult queryChildBirth(int currentPage, int pageSize, UserVO userVO, String femalePigsId,
         String startDate, String endDate, String penId) {
      List<PigChildBirthVO> resultList = null;
      Pager pager = dao.createPager(currentPage, pageSize);
      Criteria cri = Cnd.cri();

      cri.where().and("companyId", "=", userVO.getCompanyId());
      cri.where().and("farmId", "=", userVO.getDefaultFarm());

      cri.getOrderBy().desc("childbirthDate");

      if (penId != null && penId.length() > 0) {
         cri.where().and("penId", "=", penId);
      }

      if (femalePigsId != null && femalePigsId.length() > 0) {
         cri.where().andLike("femalePigsId", femalePigsId);
      }

      if (startDate != null && endDate != null) {
         cri.where().andBetween("DATE_FORMAT(childbirthDate,'%Y-%m-%d')", startDate, endDate);
      }

      resultList = dao.query(PigChildBirthVO.class, cri, pager);
      int count = dao.count(PigChildBirthVO.class, cri);

      pager.setRecordCount(count);
      return new QueryResult(resultList, pager);
   }
}
