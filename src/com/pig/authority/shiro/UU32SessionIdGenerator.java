package com.pig.authority.shiro;

import java.io.Serializable;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionIdGenerator;
import org.nutz.lang.random.R;

/**
 * 使用UU32生成session id, 减少其长度
 * 
 * @author wendal
 */
public class UU32SessionIdGenerator implements SessionIdGenerator {

   @Override
   public Serializable generateId(Session session) {
      return R.UU32();
   }

}
