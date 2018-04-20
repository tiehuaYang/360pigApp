package com.pig.common;

import java.text.DateFormat;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtils
{

   public static final String getTodayStr(String formatStr)
   {
      return dateToString(new Date(), formatStr);
   }

   /**
    * 将java.util.Date 格式转换为字符串格式 默认为'yyyy-MM-dd HH:mm:ss'(24小时制)
    * 如Sat May 11 17:24:21 CST 2002 to '2002-05-11 17:24:21'
    * @param time Date 日期
    * @return String   字符串
    */
   public static final String dateToString(Date time, String formatStr)
   {
      SimpleDateFormat formatter;
      if (formatStr == null || formatStr.length() <= 0) {
         formatStr = "yyyy-MM-dd  HH:mm:ss";
      }
      formatter = new SimpleDateFormat(formatStr);
      return formatter.format(time);

   }

   /**
    * 字符串转换为java.util.Date
    * 支持格式为 yyyy.MM.dd G 'at' hh:mm:ss z 如 '2002-1-1 AD at 22:10:59 PSD'
    * yy/MM/dd HH:mm:ss 如 '2002/1/1 17:55:00'
    * yy/MM/dd HH:mm:ss pm 如 '2002/1/1 17:55:00 pm'
    * yy-MM-dd HH:mm:ss 如 '2002-1-1 17:55:00' 
    * yy-MM-dd HH:mm:ss am 如 '2002-1-1 17:55:00 am' 
    * @param time String 字符串
    * @return Date 日期
    */
   public static final Date stringToDate(String time)
   {
      SimpleDateFormat formatter;
      int tempPos = time.indexOf("AD");
      time = time.trim();
      formatter = new SimpleDateFormat("yyyy.MM.dd G 'at' hh:mm:ss z");
      if (tempPos > -1)
      {
         time = time.substring(0, tempPos) + "公元" + time.substring(tempPos + "AD".length());//china
         formatter = new SimpleDateFormat("yyyy.MM.dd G 'at' hh:mm:ss z");
      }
      tempPos = time.indexOf("-");
      if (tempPos > -1 && (time.indexOf(" ") < 0))
      {
         formatter = new SimpleDateFormat("yyyyMMddHHmmssZ");
      }
      else if ((time.indexOf("/") > -1) && (time.indexOf(" ") > -1))
      {
         formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      }
      else if ((time.indexOf("-") > -1) && (time.indexOf(" ") > -1))
      {
         formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      }
      else if ((time.indexOf("/") > -1) && (time.indexOf("am") > -1) || (time.indexOf("pm") > -1))
      {
         formatter = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss a");
      }
      else if ((time.indexOf("-") > -1) && (time.indexOf("am") > -1) || (time.indexOf("pm") > -1))
      {
         formatter = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss a");
      }
      ParsePosition pos = new ParsePosition(0);
      java.util.Date ctime = formatter.parse(time, pos);

      return ctime;
   }

   public static String getHour()
   {
      SimpleDateFormat formatter;
      formatter = new SimpleDateFormat("H");
      String ctime = formatter.format(new Date());
      return ctime;
   }

   public static String getDay(Date date)
   {
      SimpleDateFormat formatter;
      formatter = new SimpleDateFormat("d");
      String ctime = formatter.format(date);
      return ctime;
   }

   public static String getMonth(Date date)
   {
      SimpleDateFormat formatter;
      formatter = new SimpleDateFormat("M");
      String ctime = formatter.format(date);
      return ctime;
   }

   public static String getYear(Date date)
   {
      SimpleDateFormat formatter;
      formatter = new SimpleDateFormat("yyyy");
      String ctime = formatter.format(date);
      return ctime;
   }

   public static String getWeek(Date date)
   {
      SimpleDateFormat formatter;
      formatter = new SimpleDateFormat("E");
      String ctime = formatter.format(date);
      return ctime;
   }

   /**
    * 得到二个日期间的间隔天数
    */
   public static String getTwoDay(String sj1, String sj2) {
      SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
      long day = 0;
      try {
         java.util.Date date = myFormatter.parse(sj1);
         java.util.Date mydate = myFormatter.parse(sj2);
         day = (date.getTime() - mydate.getTime()) / (24 * 60 * 60 * 1000);
      }
      catch (Exception e) {
         return "";
      }
      return day + "";
   }

   /**
    * 根据一个日期，返回是星期几的字符串
    * 
    * @param sdate
    * @return
    */
   public static String getWeek(String sdate) {
      // 再转换为时间  
      Date date = DateUtils.strToDate(sdate);
      Calendar c = Calendar.getInstance();
      c.setTime(date);
      // int hour=c.get(Calendar.DAY_OF_WEEK);  
      // hour中存的就是星期几了，其范围 1~7  
      // 1=星期日 7=星期六，其他类推  
      return new SimpleDateFormat("EEEE").format(c.getTime());
   }

   /**
    * 将短时间格式字符串转换为时间 yyyy-MM-dd
    * 
    * @param strDate
    * @return
    */
   public static Date strToDate(String strDate) {
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
      ParsePosition pos = new ParsePosition(0);
      Date strtodate = formatter.parse(strDate, pos);
      return strtodate;
   }

   /**
    * 两个时间之间的天数
    * 
    * @param date1
    * @param date2
    * @return
    */
   public static long getDays(String date1, String date2) {
      if (date1 == null || date1.equals("")) {
         return 0;
      }
      if (date2 == null || date2.equals("")) {
         return 0;
      }
      // 转换为标准时间  
      SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
      java.util.Date date = null;
      java.util.Date mydate = null;
      try {
         date = myFormatter.parse(date1);
         mydate = myFormatter.parse(date2);
      }
      catch (Exception e) {
      }
      long day = (date.getTime() - mydate.getTime()) / (24 * 60 * 60 * 1000);
      return day;
   }

// 计算当月最后一天,返回字符串  
   public static String getDefaultDay() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.set(Calendar.DATE, 1);//设为当前月的1号  
      lastDate.add(Calendar.MONTH, 1);//加一个月，变为下月的1号  
      lastDate.add(Calendar.DATE, -1);//减去一天，变为当月最后一天  

      str = sdf.format(lastDate.getTime());
      return str;
   }

// 上月第一天  
   public static String getPreviousMonthFirst() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.set(Calendar.DATE, 1);//设为当前月的1号  
      lastDate.add(Calendar.MONTH, -1);//减一个月，变为下月的1号  
      //lastDate.add(Calendar.DATE,-1);//减去一天，变为当月最后一天  

      str = sdf.format(lastDate.getTime());
      return str;
   }

//获取当月第一天  
   public static String getFirstDayOfMonth() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.set(Calendar.DATE, 1);//设为当前月的1号  
      str = sdf.format(lastDate.getTime());
      return str;
   }

//获取当天时间   
   public static String getNowTime(String dateformat) {
      Date now = new Date();
      SimpleDateFormat dateFormat = new SimpleDateFormat(dateformat);//可以方便地修改日期格式     
      String hehe = dateFormat.format(now);
      return hehe;
   }

//获得上月最后一天的日期  
   public static String getPreviousMonthEnd() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.add(Calendar.MONTH, -1);//减一个月  
      lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天   
      lastDate.roll(Calendar.DATE, -1);//日期回滚一天，也就是本月最后一天   
      str = sdf.format(lastDate.getTime());
      return str;
   }

//获得下个月第一天的日期  
   public static String getNextMonthFirst() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.add(Calendar.MONTH, 1);//减一个月  
      lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天   
      str = sdf.format(lastDate.getTime());
      return str;
   }

//获得下个月最后一天的日期  
   public static String getNextMonthEnd() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.add(Calendar.MONTH, 1);//加一个月  
      lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天   
      lastDate.roll(Calendar.DATE, -1);//日期回滚一天，也就是本月最后一天   
      str = sdf.format(lastDate.getTime());
      return str;
   }

//获得明年最后一天的日期  
   public static String getNextYearEnd() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.add(Calendar.YEAR, 1);//加一个年  
      lastDate.set(Calendar.DAY_OF_YEAR, 1);
      lastDate.roll(Calendar.DAY_OF_YEAR, -1);
      str = sdf.format(lastDate.getTime());
      return str;
   }

//获得明年第一天的日期  
   public static String getNextYearFirst() {
      String str = "";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar lastDate = Calendar.getInstance();
      lastDate.add(Calendar.YEAR, 1);//加一个年  
      lastDate.set(Calendar.DAY_OF_YEAR, 1);
      str = sdf.format(lastDate.getTime());
      return str;

   }

//获得本年有多少天  
   public static int getMaxYear() {
      Calendar cd = Calendar.getInstance();
      cd.set(Calendar.DAY_OF_YEAR, 1);//把日期设为当年第一天  
      cd.roll(Calendar.DAY_OF_YEAR, -1);//把日期回滚一天。  
      int MaxYear = cd.get(Calendar.DAY_OF_YEAR);
      return MaxYear;
   }

   public static int getYearPlus() {
      Calendar cd = Calendar.getInstance();
      int yearOfNumber = cd.get(Calendar.DAY_OF_YEAR);//获得当天是一年中的第几天  
      cd.set(Calendar.DAY_OF_YEAR, 1);//把日期设为当年第一天  
      cd.roll(Calendar.DAY_OF_YEAR, -1);//把日期回滚一天。  
      int MaxYear = cd.get(Calendar.DAY_OF_YEAR);
      if (yearOfNumber == 1) {
         return -MaxYear;
      }
      else {
         return 1 - yearOfNumber;
      }
   }

//获得本年第一天的日期  
   public static String getCurrentYearFirst() {
      int yearPlus = DateUtils.getYearPlus();
      GregorianCalendar currentDate = new GregorianCalendar();
      currentDate.add(GregorianCalendar.DATE, yearPlus);
      Date yearDay = currentDate.getTime();
      DateFormat df = DateFormat.getDateInstance();
      String preYearDay = df.format(yearDay);
      return preYearDay;
   }

//获得本年最后一天的日期 *  
   public static String getCurrentYearEnd() {
      Date date = new Date();
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");//可以方便地修改日期格式     
      String years = dateFormat.format(date);
      return years + "-12-31";
   }

//获得上年第一天的日期 *  
   public static String getPreviousYearFirst() {
      Date date = new Date();
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");//可以方便地修改日期格式     
      String years = dateFormat.format(date);
      int years_value = Integer.parseInt(years);
      years_value--;
      return years_value + "-1-1";
   }

//获得本季度  
   public static String getThisSeasonTime(int month) {
      int array[][] = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }, { 10, 11, 12 } };
      int season = 1;
      if (month >= 1 && month <= 3) {
         season = 1;
      }
      if (month >= 4 && month <= 6) {
         season = 2;
      }
      if (month >= 7 && month <= 9) {
         season = 3;
      }
      if (month >= 10 && month <= 12) {
         season = 4;
      }
      int start_month = array[season - 1][0];
      int end_month = array[season - 1][2];

      Date date = new Date();
      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");//可以方便地修改日期格式     
      String years = dateFormat.format(date);
      int years_value = Integer.parseInt(years);

      int start_days = 1;//years+"-"+String.valueOf(start_month)+"-1";//getLastDayOfMonth(years_value,start_month);  
      int end_days = getLastDayOfMonth(years_value, end_month);
      String seasonDate = years_value + "-" + start_month + "-" + start_days + ";" + years_value + "-" + end_month + "-"
            + end_days;
      return seasonDate;

   }

   /**
    * 获取某年某月的最后一天
    * 
    * @param year 年
    * @param month 月
    * @return 最后一天
    */
   public static int getLastDayOfMonth(int year, int month) {
      if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
         return 31;
      }
      if (month == 4 || month == 6 || month == 9 || month == 11) {
         return 30;
      }
      if (month == 2) {
         if (isLeapYear(year)) {
            return 29;
         }
         else {
            return 28;
         }
      }
      return 0;
   }

   /**
    * 是否闰年
    * 
    * @param year 年
    * @return
    */
   public static boolean isLeapYear(int year) {
      return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
   }

// 获得当前日期与本周日相差的天数  
   public static int getMondayPlus() {
      Calendar cd = Calendar.getInstance();
      // 获得今天是一周的第几天，星期日是第一天，星期二是第二天......  
      int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK) - 1;         //因为按中国礼拜一作为第一天所以这里减1  
      if (dayOfWeek == 1) {
         return 0;
      }
      else {
         return 1 - dayOfWeek;
      }
   }

// 获得本周星期日的日期    
   public static String getSundayOfThisWeek() {
      Calendar c = Calendar.getInstance();
      int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
      if (day_of_week == 0) {
         day_of_week = 7;
      }
      c.add(Calendar.DATE, -day_of_week + 7);
      return DateUtils.dateToString(c.getTime(), "yyyy-MM-dd");
   }

   //获得本周一的日期  
   public static String getMondayOfThisWeek() {
      Calendar c = Calendar.getInstance();
      int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
      if (day_of_week == 0) {
         day_of_week = 7;
      }
      c.add(Calendar.DATE, -day_of_week + 1);
      return DateUtils.dateToString(c.getTime(), "yyyy-MM-dd");
   }

// 获得上周星期日的日期  
   public static String getLastWeekSunday(Date date) {
      Date a = org.apache.commons.lang.time.DateUtils.addDays(date, -1);
      Calendar cal = Calendar.getInstance();
      cal.setTime(a);
      cal.set(Calendar.DAY_OF_WEEK, 1);
      return DateUtils.dateToString(cal.getTime(), "yyyy-MM-dd");
   }

// 获得上周星期一的日期
   public static String getLastWeekMonday(Date date) {
      Date a = org.apache.commons.lang.time.DateUtils.addDays(date, -1);
      Calendar cal = Calendar.getInstance();
      cal.setTime(a);
      cal.add(Calendar.WEEK_OF_YEAR, -1);// 一周    
      cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
      return DateUtils.dateToString(cal.getTime(), "yyyy-MM-dd");
   }

// 获得下周星期日的日期  
   public String getNextSunday() {

      int mondayPlus = DateUtils.getMondayPlus();
      GregorianCalendar currentDate = new GregorianCalendar();
      currentDate.add(GregorianCalendar.DATE, mondayPlus + 7 + 6);
      Date monday = currentDate.getTime();
      DateFormat df = DateFormat.getDateInstance();
      String preMonday = df.format(monday);
      return preMonday;
   }
}
