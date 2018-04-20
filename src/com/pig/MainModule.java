package com.pig;

import org.nutz.mvc.annotation.ChainBy;
import org.nutz.mvc.annotation.IocBy;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.SessionBy;
import org.nutz.mvc.annotation.SetupBy;
import org.nutz.mvc.ioc.provider.ComboIocProvider;

import com.pig.authority.shiro.ShiroSessionProvider;

@SetupBy(value = MainSetup.class)
@Modules(scanPackage = true)
@SessionBy(ShiroSessionProvider.class)
//引入freemarker的视图
//@Views(value = { FreemarkerViewMaker.class })
@IocBy(type = ComboIocProvider.class, args = { "*js", "ioc/", "*anno", "com.pig", "*tx" })
//引入动作链注解
@ChainBy(args = "mvc/chain.js")
public class MainModule {

}
