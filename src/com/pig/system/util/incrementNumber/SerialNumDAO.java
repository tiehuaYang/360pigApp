package com.pig.system.util.incrementNumber;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.log.Log;
import org.nutz.log.Logs;

/**
 * TableKeyDAO操作助手类。
 * 
 * @author erick
 */
public class SerialNumDAO {
   protected static final Log log = Logs.getLog(SerialNumDAO.class);

   public static SerialNum fetch(Dao dao, String companyId, String type) {

      List<SerialNum> serialNumList = dao.query(SerialNum.class, Cnd.where("companyId", "=", companyId).and("type", "=", type));
      if (serialNumList != null && serialNumList.size() > 0)
         return serialNumList.get(0);
      else {
         SerialNum serialNum = new SerialNum();
         serialNum.setCompanyId(companyId);
         serialNum.setType(type);
         serialNum.setKeyId(UUID.randomUUID().toString());
         serialNum.setMaxNum(0);
         Date today = new Date();
         serialNum.setCreateTime(today);
         serialNum.setUpdateTime(today);
         dao.insert(serialNum);
         return serialNum;
      }

   }

   /**
    * 修改序列号当前信息
    * 
    * @param dao
    * @param serialNum
    * @return
    */
   public static boolean update(Dao dao, SerialNum serialNum) {
      try {
         if (serialNum != null) {
            dao.update(serialNum);
            return true;
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

}
