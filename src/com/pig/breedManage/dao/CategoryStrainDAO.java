package com.pig.breedManage.dao;

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
public class CategoryStrainDAO {
   protected static final Log log = Logs.getLog(CategoryStrainDAO.class);
   @Inject
   private Dao dao;

}
