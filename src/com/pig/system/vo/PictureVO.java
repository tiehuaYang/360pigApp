package com.pig.system.vo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table("cd_pic")
public class PictureVO
{
   @Id
   private int id;
   @Name
   @Column
   private String picUuid;
   @Column
   private String picName;
   @Column
   private String uploadUrl;
   @Column
   private String creator;
   @Column
   private String thumbnailUuid;
   @Column
   private Date createDate;
   @Column
   private int picSize;
   @Column
   private String title;
   @Column
   private String content;
   @Column
   private String isCover;//是否封面

   public int getId()
   {
      return id;
   }

   public void setId(int id)
   {
      this.id = id;
   }

   public String getPicUuid()
   {
      return picUuid;
   }

   public void setPicUuid(String picUuid)
   {
      this.picUuid = picUuid;
   }

   public String getPicName()
   {
      return picName;
   }

   public void setPicName(String picName)
   {
      this.picName = picName;
   }

   public String getCreator()
   {
      return creator;
   }

   public void setCreator(String creator)
   {
      this.creator = creator;
   }

   public String getThumbnailUuid()
   {
      return thumbnailUuid;
   }

   public void setThumbnailUuid(String thumbnailUuid)
   {
      this.thumbnailUuid = thumbnailUuid;
   }

   public Date getCreateDate()
   {
      return createDate;
   }

   public void setCreateDate(Date createDate)
   {
      this.createDate = createDate;
   }

   public int getPicSize()
   {
      return picSize;
   }

   public void setPicSize(int picSize)
   {
      this.picSize = picSize;
   }

   public String getUploadUrl()
   {
      return uploadUrl;
   }

   public void setUploadUrl(String uploadUrl)
   {
      this.uploadUrl = uploadUrl;
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

   public String getIsCover()
   {
      return isCover;
   }

   public void setIsCover(String isCover)
   {
      this.isCover = isCover;
   }

}
