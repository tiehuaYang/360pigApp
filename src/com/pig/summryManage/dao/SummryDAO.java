package com.pig.summryManage.dao;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;

/**
 * DAO层。
 * 
 * @author erick
 */
@IocBean
public class SummryDAO {
   protected static final Log log = Logs.getLog(SummryDAO.class);
   @Inject
   private Dao dao;

}
