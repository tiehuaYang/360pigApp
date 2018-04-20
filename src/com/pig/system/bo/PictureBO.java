package com.pig.system.bo;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.pig.system.dao.PictureDAO;
import com.pig.system.vo.PictureVO;

/**
 * PictureBO 针对图片类附件的业务处理类
 * 
 * @author erick
 * 
 */
public class PictureBO
{
   protected static final Log log = Logs.getLog(PictureBO.class);

   /**
    *根据ID获取相关图片
    * 
    * @param dao
    * @param String billId
    * @return
    */
   public static List<PictureVO> queryPictureList(Dao dao, String billId)
   {
      List<PictureVO> resultList = null;
      try
      {
         resultList = dao.query(PictureVO.class, Cnd.where("picUuid", "=", billId), null);
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
      }
      return resultList;
   }

   /**
    *批量新增图片
    * 
    * @param dao
    * @param List<PictureVO> pictureList
    * @return
    */
   public static boolean addPictureByList(Dao dao, List<PictureVO> pictureList)
   {
      try
      {
         if (pictureList != null)
         {
            return PictureDAO.addPictureByList(dao, pictureList);
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    *删除图片
    * 
    * @param dao
    * @param List<PictureVO> pictureList
    * @return
    */
   public static boolean delPicture(Dao dao, long id)
   {
      try
      {
         PictureVO pictureVO = dao.fetch(PictureVO.class, id);

         if (pictureVO != null)
         {
            dao.delete(pictureVO);
            return true;
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }

   /**
    *批量删除图片
    * 
    * @param dao
    * @param List<PictureVO> pictureList
    * @return
    */
   public static boolean delPictureByBillId(Dao dao, String billId)
   {
      try
      {
         dao.clear(PictureVO.class, Cnd.where("picUuid", "=", billId));
         return true;
      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
      }
      return false;
   }
}
