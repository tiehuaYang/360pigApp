package com.pig.system.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.nutz.dao.Dao;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.mvc.upload.FieldMeta;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.pig.system.bo.PictureBO;
import com.pig.system.dao.PictureDAO;
import com.pig.system.vo.PictureVO;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;

import net.sf.json.JSONObject;

/*
 * 
 * 图片附件管理ACTION层 
 * 
 * 功能模块包括
 *  delPicture          删除图片 
 *  
 *  @author Erick
 */

@InjectName
@IocBean
@Filters(@By(type = CheckSession.class, args = { CommonConstants.SESSION_USER_KEY, "/" }))
public class PictureAction extends BaseAction {
   private static final Log log = Logs.getLog(PictureAction.class);
   @Inject
   private Dao dao;

   /**
    * 保存品类图片
    * 
    * @return Map
    */
   @At("/manage/saveCatePicture")
   @Ok("json")
   @AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/uploadTemp", "8192", "UTF-8", "10" })
   public Map<String, Object> saveCatePicture(HttpServletRequest request, @Param("id") String id,
         ServletContext context, @Param("file") TempFile[] tempFile, @Param("goodId") String goodId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         String contextPath = context.getRealPath(CommonConstants.UPLOAD_IMG_DIR);
         File fileDir = new File(contextPath);
         if (!fileDir.exists()) {
            fileDir.mkdir();
         }
         List<PictureVO> pictureList = new ArrayList<PictureVO>();
         if (tempFile != null && tempFile.length > 0) {
            for (int i = 0; i < tempFile.length; i++) {
               File file = tempFile[i].getFile();
               FieldMeta meta = tempFile[i].getMeta();
               String uuid = goodId;
               String fileName = UUID.randomUUID().toString() + meta.getFileExtension();
               FileUtils.copyFile(file, new File(contextPath, fileName));
               PictureVO pictureVO = new PictureVO();
               pictureVO.setCreateDate(new Date());
               pictureVO.setPicName(meta.getFileLocalName());
               pictureVO.setPicSize((int) file.length());
               pictureVO.setUploadUrl(CommonConstants.UPLOAD_IMG_DIR + "/" + fileName);
               pictureVO.setPicUuid(uuid);
               pictureVO.setIsCover("Y");
               pictureList.add(pictureVO);
            }
         }
         List<PictureVO> resultList = PictureDAO.queryPictureList(dao, goodId);
         map.put("resultList", resultList);

         if (PictureBO.addPictureByList(dao, pictureList)) {
            return success("图片上传成功", map);
         }
         else {
            return failure("图片上传失败", map);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         map.put("msg", "getFailure");
         return map;
      }
   }

   /**
    * 保存图册图片
    * 
    * @return Map
    */
   @At("/manage/saveCatePictureNew")
   @Ok("json")
   @AdaptBy(type = UploadAdaptor.class, args = { "${app.root}/uploadTemp", "8192", "UTF-8", "10", "10485760" })
   public Map<String, Object> saveCatePictureNew(HttpServletRequest request, ServletContext context,
         @Param("file") TempFile[] tempFile) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
/*         String contextPath = context.getRealPath(CommonConstants.UPLOAD_IMG_DIR);
File fileDir = new File(contextPath);
if (!fileDir.exists()) {
   fileDir.mkdir();
}*/
         JSONObject json = new JSONObject();
         if (tempFile != null && tempFile.length > 0) {
            for (int i = 0; i < tempFile.length; i++) {
               File file = tempFile[i].getFile();
               FieldMeta meta = tempFile[i].getMeta();
               String fileName = UUID.randomUUID().toString() + meta.getFileExtension();
               Map<String, Object> configMap = CommonUtils.configByQiNiu(CommonConstants.PQUPLOADIMG,
                     "uploadImg" + "/" + fileName);

               UploadManager uploadManager = (UploadManager) configMap.get("uploadManager");
               Response qresponse = uploadManager.put(tempFile[0].getInputStream(), configMap.get("key").toString(),
                     configMap.get("upToken").toString(), null, null);
               JSONObject returnjson = JSONObject.fromObject(qresponse.bodyString());
               System.out.println(returnjson);
               if (returnjson.get("key") != null && !returnjson.get("key").equals("")) {
                  json.put("picName", meta.getFileLocalName());
                  json.put("picSize", (int) file.length());
                  json.put("uploadUrl", CommonConstants.UPLOAD_IMG_DIR + "/" + fileName);
                  json.put("isCover", "Y");
               }
               else {
                  return failure("图片上传异常！", configMap);
               }

               //FileUtils.copyFile(file, new File(contextPath, fileName));
            }
         }
         map.put("resultList", json.toString());

         return success("图片上传成功", map);

      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         map.put("msg", "getFailure");
         return failure("图片上传失败", map);
      }
   }

   /**
    * 删除图片
    * 
    * @return Map
    */
   @At("/manage/delPicture")
   @Ok("json")
   public Map<String, Object> delPicture(HttpServletRequest request, @Param("pictureId") long id,
         @Param("goodId") String goodId) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         PictureBO.delPicture(dao, id);
         List<PictureVO> resultList = PictureDAO.queryPictureList(dao, goodId);
         map.put("resultList", resultList);
         return success("删除成功", map);
      }
      catch (Exception e) {
         e.printStackTrace();
         log.error(e);
         map.put("msg", "getFailure");
         return map;
      }
   }

}
