var ioc = {
        cacheManager : {
            type : "net.sf.ehcache.CacheManager",
            factory : "net.sf.ehcache.CacheManager#getCacheManager",
            args : ["mtooncache"] // 对应shiro.ini中指定的ehcache.xml中定义的name
        }
       
};