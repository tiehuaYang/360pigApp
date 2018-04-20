package com.pig.system.action;

import java.util.Map;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

public class BaseAction
{
   /** 注入同名的一个ioc对象 */
   @Inject
   protected Dao dao;

   /**
    * 只完成页面跳转，不返回任何执行结果
    * 
    * @param successMsg
    * @param map
    * @return
    */
   public Map<String, Object> goPage(Map<String, Object> map)
   {
      map.put("result", "");
      return map;
   }

   /**
    * 返回错误结果
    * 
    * @param errorMsg
    * @param map
    * @return
    */
   public Map<String, Object> failure(String errorMsg, Map<String, Object> map)
   {
      map.put("result", "FAIL");
      map.put("msg", errorMsg);
      return map;
   }

   /**
    * 返回成功结果
    * 
    * @param successMsg
    * @param map
    * @return
    */
   public Map<String, Object> success(String successMsg, Map<String, Object> map)
   {
      map.put("result", "OK");
      map.put("msg", successMsg);
      return map;
   }

}
