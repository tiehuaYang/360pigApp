package com.pig.system.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.nutz.ioc.annotation.InjectName;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

import com.pig.common.CommonConstants;
import com.pig.common.CommonUtils;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;

import net.sf.json.JSONObject;

@InjectName
@IocBean
public class ImgUploadAction {

   /**
    * 图片上传
    * 
    * @return
    * @throws IOException
    */
   @SuppressWarnings({ "unchecked", "rawtypes" })
   @At("/manage/uploadPic")
   @Ok("json")
   public String uploadPic(HttpServletRequest request, HttpServletResponse response, ServletContext context)
         throws IOException {
      FileItem item;
      String localFileName = "";

      // CKEditor提交的很重要的一个参数
      String callback = request.getParameter("CKEditorFuncNum");
      String expandedName = ""; // 文件扩展名

      int size = 10 * 600 * 1024; // 最大上传文件，不超过600k
      DiskFileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      PrintWriter out = response.getWriter();
      try {
         List<FileItem> items = upload.parseRequest(request);
         Iterator iter = items.iterator(); // 枚举方法

         while (iter.hasNext()) {
            item = (FileItem) iter.next(); // 获取FileItem对象
            localFileName = item.getName(); // 获取文件名
            int ii = localFileName.lastIndexOf(".");
            String sExt = localFileName.substring(ii, localFileName.length());//取文件名的后缀
            long upFileSize = item.getSize(); // 上传文件大小
            if (upFileSize > size) {
               out.println("<script type=\"text/javascript\">");
               out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",''," + "'文件大小不得大于600k');");
               out.println("</script>");
               return null;
            }
            else {
               if (!sExt.equals(".jpg") && !sExt.equals(".png") && !sExt.equals(".gif") && !sExt.equals(".bmp")) {
                  out.println("<script type=\"text/javascript\">");
                  out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'',"
                        + "'文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）');");
                  out.println("</script>");
                  return null;
               }
               else {
                  InputStream is = item.getInputStream();
                  //图片上传路径
                  //String uploadPath = context.getRealPath("/img/uploadImg");
                  String fileName = java.util.UUID.randomUUID().toString(); // 采用时间+UUID的方式随即命名
                  fileName += sExt;

                  Map<String, Object> configMap = CommonUtils.configByQiNiu(CommonConstants.PQIMGS,
                        "img/uploadImg" + "/" + fileName);

                  UploadManager uploadManager = (UploadManager) configMap.get("uploadManager");
                  Response qresponse = uploadManager.put(is, configMap.get("key").toString(),
                        configMap.get("upToken").toString(), null, null);
                  JSONObject returnjson = JSONObject.fromObject(qresponse.bodyString());
                  System.out.println(returnjson);
                  is.close();
/*                  File file = new File(uploadPath);
if (!file.exists()) { // 如果路径不存在，创建
   file.mkdirs();
}
File toFile = new File(uploadPath, fileName);
OutputStream os = new FileOutputStream(toFile);
byte[] buffer = new byte[1024];
int length = 0;
while ((length = is.read(buffer)) > 0) {
   os.write(buffer, 0, length);
}
is.close();
os.close();*/

                  // 返回"图像"选项卡并显示图片  request.getContextPath()为web项目名 
                  out.println("<script type=\"text/javascript\">");
/*                  out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + request.getContextPath()
      + "/img/uploadImg/" + fileName + "','')");*/
                  out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + CommonConstants.QIMGS
                        + "/img/uploadImg/" + fileName + "','')");
                  out.println("</script>");
                  out.flush();
                  out.close();
                  return null;
               }
            }
         }
      }
      catch (FileUploadException e) {
         e.printStackTrace();
      }
      return null;
   }

}