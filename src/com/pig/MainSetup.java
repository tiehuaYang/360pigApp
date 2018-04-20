package com.pig;

import org.nutz.dao.Dao;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;

public class MainSetup implements Setup {
   @Override
   public void init(NutConfig conf) {
      Ioc ioc = conf.getIoc();
      Dao dao = ioc.get(Dao.class);
      Daos.createTablesInPackage(dao, "com.pig", false);
      /* // 初始化默认根用户
       if (dao.count(UserVO.class) == 0)
       {
          UserService us = ioc.get(UserService.class);
          us.add("admin", "123456");
       }*/
   }

   @Override
   public void destroy(NutConfig conf) {
   }
}
