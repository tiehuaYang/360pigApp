package com.pig.system.util.incrementNumber;

import java.util.Date;

import org.nutz.dao.Dao;
import org.nutz.mvc.Mvcs;

import com.pig.common.CommonConstants;
import com.pig.common.DateUtils;

public class SerialNumManager extends IncrementNumber {

   public SerialNumManager() {
      super(1, 99999999);
   }

   @Override
   public int initStartNum() throws Exception {
      Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
      SerialNum serialNum = SerialNumDAO.fetch(dao, companyId, type);
      return (int) serialNum.getMaxNum();
   }

   @Override
   public void updateStartNum(int intervalMax) throws Exception {
      Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
      SerialNum serialNum = SerialNumDAO.fetch(dao, companyId, type);
      serialNum.setUpdateTime(new Date());
      serialNum.setMaxNum(intervalMax);
      SerialNumDAO.update(dao, serialNum);
   }

   /**
    * 判断是否已经跨天
    * 
    * @return 初始序列号
    * @throws Exception
    */
   @Override
   public boolean isNewDay() throws Exception {
      Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
      if (type == null || type.length() <= 0)
       {
         type = CommonConstants.Serial.TYPE_TASK_CODE;//默认类型为订单编码
      }
      SerialNum serialNum = SerialNumDAO.fetch(dao, companyId, type);
      if (DateUtils.getDay(new Date()).compareTo(DateUtils.getDay(serialNum.getUpdateTime())) != 0) {
         // 表示当前序列号已经是跨天，需要重置
//         serialNum.setMaxNum(0);
//         serialNum.setUpdateTime(new Date());
//         SerialNumDAO.update(dao, serialNum);
         return true;
      }
      return false;
   }

   /**
    * 判断是否已经跨天
    * 
    * @return 初始序列号
    * @throws Exception
    */
   @Override
   public boolean isNewMonth() throws Exception {
      Dao dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
      if (type == null || type.length() <= 0)
       {
         type = CommonConstants.Serial.TYPE_ORDER_CODE;//默认类型为订单编码
      }
      SerialNum serialNum = SerialNumDAO.fetch(dao, companyId, type);
      if (DateUtils.getMonth(new Date()).compareTo(DateUtils.getMonth(serialNum.getUpdateTime())) != 0) {
         // 表示当前序列号已经是跨月，需要重置
//         serialNum.setMaxNum(0);
//         serialNum.setUpdateTime(new Date());
//         SerialNumDAO.update(dao, serialNum);
         return true;
      }
      return false;
   }

   public String getNum() {
      try {
         int temp = cal();
         return DateUtils.getTodayStr("yyyyMMdd") + String.format("%03d", temp);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      throw new RuntimeException("生成序列号错误");
   }

   public String getNums() {
      try {
         int temp = cal();
         return String.format("%08d", temp);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      throw new RuntimeException("生成序列号错误");
   }

   public void setCompanyId(String companyId) {
      this.companyId = companyId;
   }

   public void setType(String type) {
      this.type = type;
   }

   private String companyId;
   private String type;

   public static void main(String[] args) {
      for (int i = 0; i < 10; i++) {
         SerialNumManager serial = new SerialNumManager();
         System.out.println(serial.getNum());
      }

   }

}
