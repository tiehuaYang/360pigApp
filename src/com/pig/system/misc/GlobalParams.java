package com.pig.system.misc;

/**
 * 全局参数, 将一次性初始化的参数放到了这里
 * @author kin
 *
 */
public class GlobalParams
{
   private static GlobalParams instance = null;

   private boolean hasAdmin;

   private GlobalParams()
   {
   }

   public static synchronized GlobalParams getInstance()
   {
      if (instance == null)
      {
         instance = new GlobalParams();
      }

      return instance;
   }

   public boolean isHasAdmin()
   {
      return hasAdmin;
   }

   public void setHasAdmin(boolean hasAdmin)
   {
      this.hasAdmin = hasAdmin;
   }

}
