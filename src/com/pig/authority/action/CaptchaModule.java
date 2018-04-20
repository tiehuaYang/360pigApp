package com.pig.authority.action;

import java.awt.image.BufferedImage;

import javax.servlet.http.HttpSession;

import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.pig.common.Toolkit;

import cn.apiclub.captcha.Captcha;
import cn.apiclub.captcha.gimpy.BlockGimpyRenderer;

@IocBean
@At("/captcha")
public class CaptchaModule
{

   @At
   @Ok("raw:png")
   public BufferedImage next(HttpSession session, @Param("w") int w, @Param("h") int h)
   {
      if (w * h < 1)
      { //长或宽为0?重置为默认长宽.
         w = 135;
         h = 60;
      }
/*      Captcha captcha = new Captcha.Builder(w, h).addText().addBackground(new GradiatedBackgroundProducer())
//                                .addNoise(new StraightLineNoiseProducer()).addBorder()
.gimp(new RippleGimpyRenderer()).build();*/
      Captcha captcha = new Captcha.Builder(w, h).addText().gimp(new BlockGimpyRenderer(1)).build();
      String text = captcha.getAnswer();
      session.setAttribute(Toolkit.captcha_attr, text);
      return captcha.getImage();
   }
}
