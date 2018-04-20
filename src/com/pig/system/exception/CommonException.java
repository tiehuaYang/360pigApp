package com.pig.system.exception;

public class CommonException extends Exception
{
   private static final long serialVersionUID = 2333140296939932803L;
   String message; //定义String类型变量

   public CommonException(String errorMessagr)
   {  //父类方法
      message = errorMessagr;
   }

   @Override
   public String getMessage()
   {   //覆盖getMessage()方法
      return message;
   }
}
