package com.pig.system.vo;

import java.util.Calendar;
import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_news")
public class NewsVO
{
   @Id
   private int id;
   @Column
   private String newsId;
   @Column
   private String creator;
   @Column
   private String company;
   @Column
   private String title;
   @Column
   private String content;
   @Column
   private Date publicDate;

   private PictureVO pictureVO;

   public int getId()
   {
      return id;
   }

   public void setId(int id)
   {
      this.id = id;
   }

   public String getNewsId()
   {
      return newsId;
   }

   public void setNewsId(String newsId)
   {
      this.newsId = newsId;
   }

   public String getCreator()
   {
      return creator;
   }

   public void setCreator(String creator)
   {
      this.creator = creator;
   }

   public String getTitle()
   {
      return title;
   }

   public void setTitle(String title)
   {
      this.title = title;
   }

   public String getContent()
   {
      return content;
   }

   public void setContent(String content)
   {
      this.content = content;
   }

   public Date getPublicDate()
   {
      return publicDate;
   }

   public void setPublicDate(Date publicDate)
   {
      this.publicDate = publicDate;
   }

   public PictureVO getPictureVO()
   {
      return pictureVO;
   }

   public void setPictureVO(PictureVO pictureVO)
   {
      this.pictureVO = pictureVO;
   }

   public String getCompany()
   {
      return company;
   }

   public void setCompany(String company)
   {
      this.company = company;
   }

   public String getPublicDateStr()
   {
      if (publicDate == null) {
         return "";
      }
      else {
         return String.format("%tY", publicDate) + "-" + String.format("%tm", publicDate) + "-"
               + String.format("%td", publicDate);
      }
   }

   public String getMonth()
   {
      Calendar cal = Calendar.getInstance();
      cal.setTime(publicDate);
      return String.format("%02d", cal.get(Calendar.MONTH) + 1);
   }

   public String getDay()
   {
      Calendar cal = Calendar.getInstance();
      cal.setTime(publicDate);
      return String.format("%02d", cal.get(Calendar.DAY_OF_MONTH));
   }

}
