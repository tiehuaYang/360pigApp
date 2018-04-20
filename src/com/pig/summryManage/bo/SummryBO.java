package com.pig.summryManage.bo;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;

/**
 * 逻辑处理层
 * 
 * @author erick
 */
@IocBean
public class SummryBO {
   protected static final Log log = Logs.getLog(SummryBO.class);
   @Inject
   private Dao dao;

}
