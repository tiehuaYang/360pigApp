package com.pig.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.jdom.Attribute;
import org.jdom.DataConversionException;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.pig.common.excelUtils.ExcelVO;
import com.pig.common.excelUtils.PoiReadExcelXls;
import com.pig.common.excelUtils.PoiReadExcelXlsx;
import com.pig.system.vo.MapKeyComparator;
import com.qiniu.common.Zone;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

import net.sf.json.JSONObject;

public class CommonUtils {
   private ServletContext sc;
   private static Random randGen = null;
   private static char[] numbersAndLetters = null;

   public String getPath(String path) {
      return sc.getRealPath(path);
   }

   /**
    * 获取加密之后的用户密码
    * @param originPasswd
    * @return
    */
   public static String getEncodedUserPasswords(String originPasswd, String salt) {
      if (StringUtils.isNotBlank(originPasswd)) {
         return new Sha256Hash(originPasswd, salt).toHex();
      }
      return "";
   }

   public static final String randomString(int length) {
      if (length < 1) {
         return null;
      }
      if (randGen == null) {
         randGen = new Random();
         numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz" + "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
               .toCharArray();
         //numbersAndLetters = ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
      }
      char[] randBuffer = new char[length];
      for (int i = 0; i < randBuffer.length; i++) {
         randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
         //randBuffer[i] = numbersAndLetters[randGen.nextInt(35)];
      }
      return new String(randBuffer);
   }

   public static final boolean makeDir(String uploadPath) {
      File temp = new File(uploadPath);
      //如果文件夹不存在则创建    
      if (!temp.exists() && !temp.isDirectory()) {
         temp.mkdir();
         return true;
      }
      else {
         return false;
      }
   }

   public static final String makeQRCode(String content, String uploadPath, String sign, String picName) {
      CommonUtils.makeDir(uploadPath);
      TwoDimensionCode handler = new TwoDimensionCode();
      String imgPath = uploadPath + "\\" + picName + ".png";
      handler.encoderQRCode(CommonConstants.DOMAIN + content, imgPath, "png");
      return CommonConstants.TWO_DIMENSION_DIR + "/" + sign + "/" + picName + ".png";
   }

   /** 
   * 获取十六进制的颜色代码.例如 "#6E36B4" , For HTML , 
   * @return String 
   */
   public static final String getRandColorCode() {
      String r, g, b;
      int ri, gi, bi;

      Map<String, Integer> result = CommonUtils.getRandomInt();
      ri = result.get("a");
      gi = result.get("b");
      bi = result.get("c");

      while (ri == 255 && bi == 255 && gi == 255) {
         result = CommonUtils.getRandomInt();
         ri = result.get("a");
         gi = result.get("b");
         bi = result.get("c");
      }

      r = Integer.toHexString(ri).toUpperCase();
      g = Integer.toHexString(bi).toUpperCase();
      b = Integer.toHexString(gi).toUpperCase();

      r = r.length() == 1 ? "0" + r : r;
      g = g.length() == 1 ? "0" + g : g;
      b = b.length() == 1 ? "0" + b : b;

      return r + g + b;
   }

   public static final Map<String, Integer> getRandomInt() {
      int a, b, c;
      Map<String, Integer> result = new HashMap<String, Integer>();
      Random random = new Random();
      a = random.nextInt(256);
      b = random.nextInt(256);
      c = random.nextInt(256);
      result.put("a", a);
      result.put("b", b);
      result.put("c", c);
      return result;
   }

   /** 
    * 使用 Map按key进行排序 
    * @param map 
    * @return 
    */
   public static Map<String, Object> sortMapByKey(Map<String, Object> map) {
      if (map == null || map.isEmpty()) {
         return null;
      }
      Map<String, Object> sortMap = new TreeMap<String, Object>(new MapKeyComparator());
      sortMap.putAll(map);
      return sortMap;
   }

   public static void main(String[] args) {
      String test = CommonUtils.getRandColorCode();
      System.out.print(test);
   }

   /**
    * 判断非空
    * 
    * @param par
    */
   public static boolean isNull(Object par) {
      boolean isNull = false;
      if (par == null) {
         isNull = true;
      }
      else {
         if (par == "") {
            isNull = true;
         }
      }
      return isNull;
   }

   /**
    * 上传excel文件并读取内容
    * 
    * @return map
    */
   public static Map<String, Object> uploadHandle(HttpServletRequest request, HttpServletResponse response,
         String userName, String template) throws ServletException, IOException {
      Map<String, Object> map = new HashMap<String, Object>();
      //得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
      String realSavePath = request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
      File tmpFile = new File(realSavePath);
      if (!tmpFile.exists()) {
         //创建临时目录
         tmpFile.mkdir();
      }
      //读取文件后的文件名称
      String realFileName = null;
      //得到上传文件的扩展名
      String fileExtName = null;
      //把文件数据存放ExcelVO的list列表
      List<ExcelVO> excelList = new ArrayList<ExcelVO>();
      //模板文件位置
      String templateName = request.getSession().getServletContext().getRealPath("/manage/importTemplate")
            + File.separator + template;
      //上传时生成的临时文件保存目录
      String tempPath = request.getSession().getServletContext().getRealPath("/WEB-INF/temp");
      tmpFile = new File(tempPath);
      if (!tmpFile.exists()) {
         //创建临时目录
         tmpFile.mkdir();
      }

      //消息提示
      String msg = "";
      String result = "";
      try {
         //使用Apache文件上传组件处理文件上传步骤：
         //1、创建一个DiskFileItemFactory工厂
         DiskFileItemFactory factory = new DiskFileItemFactory();
         //设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中。
         factory.setSizeThreshold(1024 * 100);//设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
         //设置上传时生成的临时文件的保存目录
         factory.setRepository(tmpFile);
         //2、创建一个文件上传解析器
         ServletFileUpload upload = new ServletFileUpload(factory);
         //监听文件上传进度
         upload.setProgressListener(new ProgressListener() {
            @Override
            public void update(long pBytesRead, long pContentLength, int arg2) {
               System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
               /**
                * 文件大小为：14608,当前已处理：4096
                * 文件大小为：14608,当前已处理：7367
                * 文件大小为：14608,当前已处理：11419
                * 文件大小为：14608,当前已处理：14608
                */
            }
         });
         //解决上传文件名的中文乱码
         upload.setHeaderEncoding("UTF-8");
         //3、判断提交上来的数据是否是上传表单的数据
         if (!ServletFileUpload.isMultipartContent(request)) {
            //按照传统方式获取数据
            map.put("msg", "表单数据错误！");
            map.put("result", "FAIL");
            map.put("list", excelList);
            return map;
         }

         //设置上传单个文件的大小的最大值，目前是设置为1024*1024字节，也就是1MB
         upload.setFileSizeMax(1024 * 1024);
         //设置上传文件总量的最大值，最大值=同时上传的多个文件的大小的最大值的和，目前设置为10MB
         upload.setSizeMax(1024 * 1024 * 10);
         //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
         List<FileItem> list = upload.parseRequest(request);

         //循环文件
         for (FileItem item : list) {
            //如果fileitem中封装的是普通输入项的数据
            if (item.isFormField()) {
               //跳转页面名
               //userName = item.getFieldName();
               //获取模板路径名
               //templateName = templateName + "\\" + item.getString("UTF-8");
               System.out.println(userName + "=" + templateName);
            }
            else {//如果fileitem中封装的是上传文件
                     //得到上传的文件名称，
               String filename = item.getName();
               System.out.println(filename);
               if (filename == null || filename.trim().equals("")) {
                  map.put("msg", "请选择文件！！！");
                  map.put("result", "FAIL");
                  map.put("list", excelList);
                  return map;
                  //continue;
               }
               //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
               //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
               filename = filename.substring(filename.lastIndexOf(File.separator) + 1);
               //得到上传文件的扩展名
               fileExtName = filename.substring(filename.lastIndexOf(".") + 1);
               //如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
               System.out.println("上传的文件的扩展名是：" + fileExtName);

               //如果文件后缀为.xls或者.xlsx
               if (fileExtName.equals("xls") || fileExtName.equals("xlsx")) {
                  //获取item中的上传文件的输入流
                  InputStream in = item.getInputStream();
                  //得到文件保存的名称
                  String saveFilename = makeFileName(filename);
                  //读取文件后的保存目录+文件名称
                  realFileName = realSavePath + File.separator + saveFilename;
                  //创建一个文件输出流
                  FileOutputStream out = new FileOutputStream(realSavePath + File.separator + saveFilename);
                  //创建一个缓冲区
                  byte buffer[] = new byte[1024];
                  //判断输入流中的数据是否已经读完的标识
                  int len = 0;
                  //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                  while ((len = in.read(buffer)) > 0) {
                     //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                     out.write(buffer, 0, len);
                  }
                  //关闭输入流
                  in.close();
                  //关闭输出流
                  out.close();
                  //删除处理文件上传时生成的临时文件
                  item.delete();

                  //读出表格的数据
                  if (fileExtName.equals("xls")) {
                     map = PoiReadExcelXls.createExcelXlsList(excelList, realFileName, templateName);
                     return map;
                  }
                  else if (fileExtName.equals("xlsx")) {
                     map = PoiReadExcelXlsx.createExcelXlsxList(excelList, realFileName, templateName);
                     return map;
                  }
               }
               else {
                  msg = "请导入指定格式的文件！！！";
                  result = "FAIL";
               }
            }
         }
      }
      catch (FileUploadBase.FileSizeLimitExceededException e) {
         msg = "单个文件超出最大值！！！";
         result = "FAIL";
      }
      catch (FileUploadBase.SizeLimitExceededException e) {
         msg = "上传文件的总的大小超出限制的最大值！！！";
         result = "FAIL";
      }
      catch (Exception e) {
         msg = "文件上传失败！";
         result = "FAIL";
         e.printStackTrace();
      }

      //跳转回显示页面
      map.put("msg", msg);
      map.put("result", result);
      return map;
   }

   /**
    * 生成上传文件的文件名
    * 
    * @return String
    */
   private static String makeFileName(String filename) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
      java.util.Date date = new java.util.Date();
      //为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名(上传时间+原文件名)
      return sdf.format(date) + "_" + filename;
   }

   @SuppressWarnings("unchecked")
   public static void downloadHandle(Map<String, Object> paramMap, HttpServletResponse response, String templateName,
         String realName) throws ServletException, IOException {
      //模板文件
      File file = new File(templateName);
      SAXBuilder builder = new SAXBuilder();
      try {
         //解析xml文件
         Document parse = builder.build(file);
         //创建Excel`
         HSSFWorkbook wb = new HSSFWorkbook();
         //创建sheet
         HSSFSheet sheet = wb.createSheet("Sheet0");

         //获取xml文件根节点
         Element root = parse.getRootElement();

         int i = 0;
         int rowNum = 0;
         //设置列宽
         Element colgroup = root.getChild("colgroup");
         setColumnWidth(sheet, colgroup);
         Element rowgroup = root.getChild("rowgroup");
         List<Element> rows = rowgroup.getChildren("row");
         for (i = 0; i < rows.size(); i++) {
            Element row = rows.get(i);
            Attribute indexAttr = row.getAttribute("index");
            Attribute styleAttr = row.getAttribute("style");
            Attribute dataKeyAttr = row.getAttribute("dataKey");
            Attribute isMutiAttr = row.getAttribute("isMuti");
            String index = indexAttr.getValue();
            String style = styleAttr.getValue();
            String dataKey = dataKeyAttr == null ? "" : dataKeyAttr.getValue();
            String isMuti = isMutiAttr == null ? "" : isMutiAttr.getValue();
            Element element = root.getChild(index);
            if (style.equals("title")) {
               rowNum = setTitle(wb, sheet, element, rowNum);
            }
            else if (style.equals("header")) {
               rowNum = setHeader(wb, sheet, element, rowNum);
            }
            else if (style.equals("body")) {
               List<ExcelVO> dataList = (List<ExcelVO>) paramMap.get(dataKey);
               if (isMuti.equals("Y")) {
                  rowNum = setDataIfMuti(element, wb, sheet, dataList, rowNum);
               }
               else {
                  rowNum = setDataIfNotMuti(element, wb, sheet, dataList, rowNum);
               }
               rowNum++;
            }
         }
         //处理文件名
         realName = realName + ".xls";
         //设置响应头，控制浏览器下载该文件
         response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realName, "UTF-8"));
         //创建输出流
         OutputStream stream = response.getOutputStream();
         wb.write(stream);
         stream.close();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   /**
    * 设置标题
    * 
    * @param wb
    * @param cell
    * @param head
    * @throws DataConversionException
    */
   @SuppressWarnings("unused")
   private static int setTitle(HSSFWorkbook wb, HSSFSheet sheet, Element title, int rownum)
         throws DataConversionException {
      List<Element> trs = title.getChildren("tr");
      for (int i = 0; i < trs.size(); i++) {
         Element tr = trs.get(i);
         List<Element> tds = tr.getChildren("td");
         HSSFRow row = sheet.createRow(rownum);
         HSSFCellStyle cellStyle = wb.createCellStyle();
         cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
         cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
         for (int column = 0; column < tds.size(); column++) {
            Element td = tds.get(column);
            HSSFCell cell = row.createCell(column);
            Attribute rowSpan = td.getAttribute("rowspan");
            Attribute colSpan = td.getAttribute("colspan");
            int cspan = colSpan == null ? 1 : colSpan.getIntValue() - 1;
            int rspan = rowSpan == null ? 1 : rowSpan.getIntValue() - 1;
            Attribute value = td.getAttribute("value");
            if (value != null) {
               String val = value.getValue();
               cell.setCellValue(val);
               // int rspan = rowSpan.getIntValue() - 1;
               // int cspan = colSpan.getIntValue() - 1;
               //设置字体
               HSSFFont font = wb.createFont();
               font.setFontName("仿宋_GB2312");
               font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//字体加粗
//                    font.setFontHeight((short)1 2);
               font.setFontHeightInPoints((short) 12);
               cellStyle.setFont(font);
               //合并单元格居中
               sheet.addMergedRegion(new CellRangeAddress(rspan, rspan, 0, cspan));
               cell.setCellStyle(cellStyle);
            }
         }
         rownum++;
      }
      return rownum;
   }

   /**
    * 设置表头
    * 
    * @param wb
    * @param cell
    * @param head
    * @throws DataConversionException
    */
   @SuppressWarnings("unused")
   private static int setHeader(HSSFWorkbook wb, HSSFSheet sheet, Element thead, int rownum)
         throws DataConversionException {
      List<Element> trs = thead.getChildren("tr");
      int wsize = trs.size();
      int column = 0;
      String align = null;
      HSSFRow row = sheet.createRow(rownum);
      for (int i = 0; i < wsize; i++) {
         Element tr = trs.get(i);
         List<Element> ths = tr.getChildren("td");
         int nsize = ths.size();
         for (int k = 0; k < nsize; k++) {
            Element th = ths.get(k);
            Attribute value = th.getAttribute("value");
            HSSFCell cell = row.createCell(column);
            Attribute colspanAttr = th.getAttribute("colspan");
            int colspan = colspanAttr == null ? 1 : colspanAttr.getIntValue();
            Attribute alignAttr = th.getAttribute("align");
            align = alignAttr == null ? "" : alignAttr.getValue();
            if (value != null) {
               cell.setCellValue(value.getValue());
               sheet.addMergedRegion(new CellRangeAddress(rownum, rownum, column, column + colspan - 1));
               HSSFCellStyle cellStyle = wb.createCellStyle();
               cellStyle.setFillForegroundColor((short) 13);// 设置背景色    
               cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
               cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
               cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
               cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
               cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
               cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框   
               cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
               cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
               cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
               cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
               cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  
               if (align.equals("right")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
               }
               else if (align.equals("center")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
               }
               else {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
               }
               CellRangeAddress region = new CellRangeAddress(rownum, rownum, column, column + colspan - 1);
               setRegionStyle(cellStyle, region, sheet);
               sheet.addMergedRegion(region);
            }
            column += colspan;
         }
      }
      rownum++;
      return rownum;
   }

   /**
    * 读取数据到excel表格中
    * 
    * @param wb
    * @param cell
    * @param sheet
    * @throws DataConversionException
    */
   @SuppressWarnings("unused")
   private static int setDataIfNotMuti(Element tbody, HSSFWorkbook wb, HSSFSheet sheet, List<ExcelVO> list, int rownum)
         throws DataConversionException {

      //把list里面的数据读取到表格里
      if (list != null && list.size() > 0) {
         //设置数据区域样式
         Element tr = tbody.getChild("tr");
         int listSize = list.size();
         String align = null;
         List<Element> tds = tr.getChildren("td");

         HSSFCellStyle cellStyle = wb.createCellStyle();
         cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
         cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
         cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
         cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框   
         cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
         cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
         cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
         cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
         cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中  

         for (int i = 0; i < listSize; i++) {
            int column = 0;
            HSSFRow row = sheet.createRow(rownum);
            for (int k = 0; k < tds.size(); k++) {
               Element td = tds.get(k);
               HSSFCell cell = row.createCell(column);
               Attribute colspanAttr = td.getAttribute("colspan");
               int colspan = colspanAttr == null ? 1 : colspanAttr.getIntValue();
               Attribute alignAttr = td.getAttribute("align");
               align = alignAttr == null ? "" : alignAttr.getValue();
               setType(wb, cell, td, cellStyle);
               if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
                  try {
                     cell.setCellValue(Double.parseDouble(list.get(i).getValueToNum(k)));
                  }
                  catch (Exception e) {
                     cell.setCellValue(list.get(i).getValueToNum(k));
                  }
               }
               else {
                  cell.setCellValue(list.get(i).getValueToNum(k));
               }
               if (align.equals("right")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
               }
               else if (align.equals("center")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
               }
               else {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
               }

               CellRangeAddress region = new CellRangeAddress(rownum, rownum, column, column + colspan - 1);
               setRegionStyle(cellStyle, region, sheet);
               sheet.addMergedRegion(region);

               column += colspan;
            }
            rownum++;
         }
      }
      return rownum;
   }

   private static int setDataIfMuti(Element tbody, HSSFWorkbook wb, HSSFSheet sheet, List<ExcelVO> list, int rownum)
         throws DataConversionException, ClassNotFoundException {

      //把list里面的数据读取到表格里
      if (list != null && list.size() > 0) {
         //设置数据区域样式

         Element tr = tbody.getChild("tr");
         int listSize = list.size();
         List<Element> tds = tr.getChildren("td");
         String isSub = null;
         String fieldName = null;
         String align = null;
         Object result;
         int rowSize = 1;
         int j = 0;
         HSSFRow row;

         HSSFCellStyle cellStyle = wb.createCellStyle();
         cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
         cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
         cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
         cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框   
         cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
         cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
         cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
         cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
         cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直居中

         for (int i = 0; i < listSize; i++) {
            int column = 0;
            row = sheet.getRow(rownum);
            if (row == null) {
               row = sheet.createRow(rownum);
            }
            List<?> subList = list.get(i).getSubList();
            if (subList != null && subList.size() > 0) {
               rowSize = subList.size();
            }

            for (int k = 0; k < tds.size(); k++) {
               Element td = tds.get(k);
               Attribute colspanAttr = td.getAttribute("colspan");
               Attribute alignAttr = td.getAttribute("align");
               align = alignAttr == null ? "" : alignAttr.getValue();
               Attribute isSubAttr = td.getAttribute("isSub");
               isSub = isSubAttr == null ? "" : isSubAttr.getValue();

               if (align.equals("right")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
               }
               else if (align.equals("center")) {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
               }
               else {
                  cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
               }
               int colspan = colspanAttr == null ? 1 : colspanAttr.getIntValue();
               // setType(wb, cell, td);

               if (isSub.equals(CommonConstants.DB_CHAR_YES)) {
                  sheet.addMergedRegion(new CellRangeAddress(rownum, rownum, column, column + colspan - 1));
                  if (subList != null && subList.size() > 0) {
                     HSSFCell cell = row.createCell(column);
                     int tempRowNum = (rownum);
                     Iterator<?> it = subList.iterator();
                     while (it.hasNext()) {
                        HSSFRow tempRow = sheet.getRow(tempRowNum);
                        if (tempRow == null) {
                           tempRow = sheet.createRow(tempRowNum);
                        }
                        cell = tempRow.createCell(column);
                        setType(wb, cell, td, cellStyle);
                        fieldName = td.getAttribute("field").getValue();
                        result = invokeMethod(it.next(), fieldName, new Object[0]);
                        if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
                           try {
                              cell.setCellValue(Double.parseDouble(result + ""));
                           }
                           catch (Exception e) {
                              cell.setCellValue(result + "");
                           }
                        }
                        else {
                           cell.setCellValue(result + "");
                        }

                        cell.setCellStyle(cellStyle);
                        tempRowNum++;
                     }
                  }
               }
               else {
                  HSSFCell cell = row.createCell(column);
                  setType(wb, cell, td, cellStyle);
                  if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
                     try {
                        cell.setCellValue(Double.parseDouble(list.get(i).getValueToNum(k)));
                     }
                     catch (Exception e) {
                        cell.setCellValue(list.get(i).getValueToNum(k));
                     }
                  }
                  else {
                     cell.setCellValue(list.get(i).getValueToNum(k));
                  }
                  CellRangeAddress region = new CellRangeAddress(rownum, rownum + rowSize - 1, column,
                        column + colspan - 1);
                  setRegionStyle(cellStyle, region, sheet);
                  sheet.addMergedRegion(region);
               }
               column += colspan;
            }
            rownum += rowSize;
         }
      }
      return rownum;
   }

   /**
    * 设置列宽
    * 
    * @param sheet
    * @param colgroup
    */
   private static void setColumnWidth(HSSFSheet sheet, Element colgroup) {
      // TODO Auto-generated method stub
      List<Element> cols = colgroup.getChildren("col");
      for (int i = 0; i < cols.size(); i++) {
         Element col = cols.get(i);
         Attribute width = col.getAttribute("width");
         String unit = width.getValue().replaceAll("[0-9,\\.]", "");
         String value = width.getValue().replaceAll(unit, "");
         int v = 0;
         if (StringUtils.isBlank(unit) || "px".endsWith(unit)) {
            v = Math.round(Float.parseFloat(value) * 37F);
         }
         else if ("em".endsWith(unit)) {
            v = Math.round(Float.parseFloat(value) * 267.5F);
         }
         sheet.setColumnWidth(i, v);
      }
   }

   //合并单元格
   private static void setRegionStyle(HSSFCellStyle cellStyle, CellRangeAddress region, HSSFSheet sheet) {

      for (int i = region.getFirstRow(); i <= region.getLastRow(); i++) {

         Row row = sheet.getRow(i);
         if (row == null) {
            row = sheet.createRow(i);
         }
         for (int j = region.getFirstColumn(); j <= region.getLastColumn(); j++) {
            Cell cell = row.getCell(j);
            if (cell == null) {
               cell = row.createCell(j);
               cell.setCellValue("");
            }
            cell.setCellStyle(cellStyle);
         }
      }
   }

   /**
    * 测试单元格样式
    * 
    * @param wb
    * @param cell
    * @param td
    * @param cellStyle
    */
   private static void setType(HSSFWorkbook wb, HSSFCell cell, Element td, HSSFCellStyle cellStyle) {
      Attribute typeAttr = td.getAttribute("type");
      String type = typeAttr.getValue();
      HSSFDataFormat format = wb.createDataFormat();
      if ("NUMERIC".equalsIgnoreCase(type)) {
         cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
         Attribute formatAttr = td.getAttribute("format");
         String formatValue = formatAttr.getValue();
         formatValue = StringUtils.isNotBlank(formatValue) ? formatValue : "#,##0.00";
         cellStyle.setDataFormat(format.getFormat(formatValue));
      }
      else if ("STRING".equalsIgnoreCase(type)) {
         cell.setCellValue("");
         cell.setCellType(HSSFCell.CELL_TYPE_STRING);
         cellStyle.setDataFormat(format.getFormat("@"));
      }
      else if ("DATE".equalsIgnoreCase(type)) {
         cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
         cellStyle.setDataFormat(format.getFormat("yyyy-m-d"));
      }
      else if ("ENUM".equalsIgnoreCase(type)) {
         CellRangeAddressList regions = new CellRangeAddressList(cell.getRowIndex(), cell.getRowIndex(),
               cell.getColumnIndex(), cell.getColumnIndex());
         Attribute enumAttr = td.getAttribute("format");
         String enumValue = enumAttr.getValue();
         //加载下拉列表内容
         DVConstraint constraint = DVConstraint.createExplicitListConstraint(enumValue.split(","));
         //数据有效性对象
         HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);
         wb.getSheetAt(0).addValidationData(dataValidation);
      }
      cell.setCellStyle(cellStyle);
   }

   private static <T> Object invokeMethod(T obj, String methodName, Object[] args) {
      Object object = null;
      @SuppressWarnings("rawtypes")
      Class ownerClass = obj.getClass();
      @SuppressWarnings("rawtypes")
      Class[] argsClass = new Class[args.length];
      for (int i = 0, j = args.length; i < j; i++) {
         argsClass[i] = args[i].getClass();
      }
      Method method;
      try {
         methodName = "get" + methodName;
         method = ownerClass.getMethod(methodName, argsClass);
         object = method.invoke(obj, args);
      }
      catch (SecurityException e) {
         e.printStackTrace();
      }
      catch (NoSuchMethodException e) {
         e.printStackTrace();
      }
      catch (IllegalArgumentException e) {
         e.printStackTrace();
      }
      catch (IllegalAccessException e) {
         e.printStackTrace();
      }
      catch (InvocationTargetException e) {
         e.printStackTrace();
      }
      finally {
      }
      return object;
   }

   /**
    *短信验证码
    *
    */
   public static Map<String, Object> sendVerificationCode(JSONObject json, String RecNum) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         TaobaoClient client = new DefaultTaobaoClient(CommonConstants.ALIDAYU_URL, CommonConstants.ALIDAYU_APPKEY,
               CommonConstants.ALIDAYU_SECRET);
         AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
         req.setExtend("123456");
         req.setSmsType("normal");
         req.setSmsFreeSignName(CommonConstants.ALIDAYU_SIGNNAME);
         req.setSmsParam(json.toString());
         req.setRecNum(RecNum);
         req.setSmsTemplateCode(CommonConstants.ALIDAYU_TEMPLATECODE);
         AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);    //回调函数
         System.out.println(rsp.getBody());
         map.put("result", "OK");
      }
      catch (Exception e) {
         e.printStackTrace();
         map.put("result", "FAIL");
      }
      return map;
   }

   /**
    *6位随机数
    *
    */
   public static String randomNum6() {
      String num = "";
      for (int i = 0; i < 6; i++) {
         Random random = new Random();
         int j = random.nextInt(10);
         num += j;
      }
      return num;
   }

   /** 
   *字符串的日期格式的计算 
   */
   public static int daysBetween(String smdate, String bdate) throws ParseException {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Calendar cal = Calendar.getInstance();
      cal.setTime(sdf.parse(smdate));
      long time1 = cal.getTimeInMillis();
      cal.setTime(sdf.parse(bdate));
      long time2 = cal.getTimeInMillis();
      long between_days = (time2 - time1) / (1000 * 3600 * 24);

      return Integer.parseInt(String.valueOf(between_days)) + 1;
   }

   public static Date getMonthStart(Date date) {
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(date);
      int index = calendar.get(Calendar.DAY_OF_MONTH);
      calendar.add(Calendar.DATE, (1 - index));
      return calendar.getTime();
   }

   public static Date getMonthEnd(Date date) {
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(date);
      calendar.add(Calendar.MONTH, 1);
      int index = calendar.get(Calendar.DAY_OF_MONTH);
      calendar.add(Calendar.DATE, (-index));
      return calendar.getTime();
   }

   public static String valueFormat(Object obj) {
      if (obj == null || obj.equals("")) {
         return null;
      }
      else {
         return obj.toString();
      }
   }

   public static Map<String, Object> configByQiNiu(String bucket, String key) {
      Map<String, Object> map = new HashMap<String, Object>();

      //构造一个带指定Zone对象的配置类
      Configuration cfg = new Configuration(Zone.zone2());
      //...其他参数参考类注释
      UploadManager uploadManager = new UploadManager(cfg);
      //...生成上传凭证，然后准备上传
      String accessKey = CommonConstants.ACCESSKEY;
      String secretKey = CommonConstants.SECRETKEY;
      //默认不指定key的情况下，以文件内容的hash值作为文件名
      Auth auth = Auth.create(accessKey, secretKey);

      long expires = 6000;
      StringMap putPolicy = new StringMap();
      putPolicy.put("returnBody",
            "{\"key\":\"$(key)\",\"hash\":\"$(etag)\",\"bucket\":\"$(bucket)\",\"fsize\":$(fsize)}");
      String upToken = auth.uploadToken(bucket, key, expires, putPolicy);
      map.put("uploadManager", uploadManager);
      map.put("upToken", upToken);
      map.put("key", key);
      return map;
   }
}
