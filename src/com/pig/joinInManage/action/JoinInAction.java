package com.pig.joinInManage.action;

import org.nutz.dao.Dao;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.filter.CheckSession;

import com.pig.common.CommonConstants;
import com.pig.system.action.BaseAction;

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
public class JoinInAction extends BaseAction {
   private static final Log log = Logs.getLog(JoinInAction.class);
   @Inject
   private Dao dao;
}
