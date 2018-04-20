package com.pig.system.action;

import java.util.List;

import org.nutz.dao.Dao;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.pig.common.CommonConstants;
import com.pig.system.vo.NewsVO;
import com.pig.system.vo.PictureVO;

/**
 * DAO操作助手类
 * 
 * @author kin
 * 
 */
public class DaoHelper
{
   protected static final Log log = Logs.getLog(DaoHelper.class);

   /**
    * 创建动态记录
    * 
    * @param dao
    * @param designerVO
    * @return
    */
   public static boolean createOrModNews(Dao dao, NewsVO newsVO, PictureVO pictureVO)
   {
      try
      {
         if (dao.fetch(NewsVO.class, newsVO.getId()) != null && newsVO.getNewsId() != null)
         {
            PictureVO oldPic = dao.fetch(PictureVO.class, newsVO.getNewsId());
            if (oldPic != null)
            {
               dao.delete(oldPic);
            }
         }

         if (dao.fetch(NewsVO.class, newsVO.getId()) == null)
         {
            dao.insert(newsVO);
            dao.insert(pictureVO);
            return true;
         }
         else
         {
            dao.update(newsVO);
            dao.insert(pictureVO);
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
    * 创建动态记录
    * 
    * @param dao
    * @param newsVO
    * @return
    */
   public static boolean createOrModNews(Dao dao, NewsVO newsVO)
   {
      try
      {
         if (dao.fetch(NewsVO.class, newsVO.getId()) == null)
         {
            dao.insert(newsVO);
            return true;
         }
         else
         {
            dao.update(newsVO);
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

   public static QueryResult queryNewsList(Dao dao, int currentPage)
   {
      List<NewsVO> resultList = null;
      Pager pager = dao.createPager(currentPage, CommonConstants.DEFAULT_PAGE_SIZE);
      try
      {
         resultList = dao.query(NewsVO.class, null, pager);
         pager.setRecordCount(dao.count(NewsVO.class));

      }
      catch (Exception e)
      {
         e.printStackTrace();
         log.error(e);
      }
      return new QueryResult(resultList, pager);
   }

}
