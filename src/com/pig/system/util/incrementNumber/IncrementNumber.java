package com.pig.system.util.incrementNumber;

public abstract class IncrementNumber {
   public IncrementNumber() {
   }

   public IncrementNumber(int interval, int maxNum) {
      this.interval = interval;
      this.maxNum = maxNum;
   }

   public synchronized int cal() throws Exception {

      serialNum = initStartNum(); // 已经使用的序列号一定 小于 缓存的序列号
      if (isNewMonth()) { // 新的月份重置序列号  
         resetSerialNum();
         return serialNum;
      }
      if (isMax(serialNum)) { // 达到预定的最大值  
         resetSerialNum();
         return serialNum;
      }
      updateStartNum(++serialNum);
      return serialNum;
   }

   /**
    * 初始化序列号，从缓存系统中来，比如数据库、文件等
    * 
    * @return 初始序列号
    * @throws Exception
    */
   public abstract int initStartNum() throws Exception;

   /**
    * 更新区间最大值到缓存系统，比如数据库、文件中。
    * 
    * @param intervalMax 区间最大值
    * @throws Exception
    */
   public abstract void updateStartNum(int intervalMax) throws Exception;

   /**
    * 重置序列号，从1开始
    */
   protected void resetSerialNum() throws Exception {
      this.serialNum = 1;
      intervalMax = serialNum;
      updateStartNum(intervalMax);
   }

   /**
    * 判断是否已经跨天
    * 
    * @return 初始序列号
    * @throws Exception
    */
   public abstract boolean isNewDay() throws Exception;

   /**
    * 判断是否已经跨月
    * 
    * @return 初始序列号
    * @throws Exception
    */
   public abstract boolean isNewMonth() throws Exception;

   /**
    * 是否是最大值
    * 
    * @param num
    * @return
    */
   private boolean isMax(int num) {
      return num >= maxNum;
   }

   public int getInterval() {
      return this.interval;
   }

   public int getMaxNum() {
      return this.maxNum;
   }

   /** 区间最大值 */
   protected int intervalMax = 0;

   /** 每次增加量 */
   protected int interval = 1;

   /** 预定的最大值 */
   protected int maxNum = 999;

   /** 序列号 */
   protected int serialNum = -1;

}
