package com.pig.common.excelUtils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

public class PoiReadExcelXlsx {

   /**
    * POI解析后缀为.xlsx的Excel文件内容
    */
   public static Map<String, Object> createExcelXlsxList(List<ExcelVO> list, String realFileName, String templateName) {
      Map<String, Object> map = new HashMap<String, Object>();
      try {
         String msg = null;
         String result = "OK";

         //创建Excel，读取文件内容
         XSSFWorkbook workbook = new XSSFWorkbook(FileUtils.openInputStream(new File(realFileName)));
         //获取第一个工作表workbook.getSheet("Sheet0");
         //Sheet sheet = workbook.getSheet("Sheet0");
         //读取默认第一个工作表sheet
         Sheet sheet = workbook.getSheetAt(0);

         //获取模板文件
         File file = new File(templateName);

         //解析xml模板文件
         SAXBuilder builder = new SAXBuilder();
         Document parse = builder.build(file);
         Element root = parse.getRootElement();
         Element tbody = root.getChild("tbody");
         Element tr = tbody.getChild("tr");
         List<Element> children = tr.getChildren("td");

         //解析excel开始行，开始列
         int firstRow = tr.getAttribute("firstrow").getIntValue();
         int firstCol = tr.getAttribute("firstcol").getIntValue();
         //获取excel最后一行行号
         int lastRowNum = sheet.getLastRowNum();
         //循环每一行处理数据
         for (int i = firstRow; i <= lastRowNum; i++) {

            //读取某行
            Row row = sheet.getRow(i);
            //判断改行是否为空
            if (isEmptyRow(row)) {
               continue;
            }

            //创建excelVO
            ExcelVO excelVO = new ExcelVO();

            int lastCellNum = row.getLastCellNum();
            //如果非空行，则取所有单元格的值
            for (int j = firstCol; j < lastCellNum; j++) {
               Element td = children.get(j - firstCol);
               Cell cell = row.getCell(j);
               //如果单元格为null,继续处理下一个cell
               if (cell == null) {
                  continue;
               }
               //获取单元格属性值
               String value = getCellValue(cell, td);
               //导入明细实体赋值
               if (StringUtils.isNotBlank(value)) {
                  if (value.indexOf("#000") >= 0) {
                     //错误代码+错误信息+value，前两个暂时没保存
                     String[] info = value.split(",");
                     msg = info[1];
                     result = "FAIL";
                  }
                  else {
                     BeanUtils.setProperty(excelVO, "col" + j, value);
                  }
               }
//               System.out.print(value + "  ");
            }
//            System.out.println();
            list.add(excelVO);
         }
         if(templateName.substring(templateName.lastIndexOf(File.separator) + 1).equals("inventory.xml")){
            tbody = root.getChild("tbody1");
            tr = tbody.getChild("tr");
            children = tr.getChildren("td");
            
            Row row = sheet.getRow(2);
            Element td = children.get(0);
            Cell cell = row.getCell(0);
            String value = getCellValue(cell, td);
            map.put("storeName", value);
         }
         workbook.close();
         map.put("result", result);
         map.put("msg", msg);
         map.put("list", list);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return map;
   }

   /**
    * 判断某行是否为空
    * 
    * @return
    */
   private static boolean isEmptyRow(Row row) {
      boolean flag = true;
      for (int i = 0; i < row.getLastCellNum(); i++) {
         Cell cell = row.getCell(i);
         if (cell != null) {
            if (StringUtils.isNotBlank(cell.toString())) {
               return false;
            }
         }
      }

      return flag;
   }

   /**
    * 获取单元格值，并且进行校验
    * 
    * @param cell
    * @param td
    * @return
    */
   private static String getCellValue(Cell cell, Element td) {
      //首先获取单元格位置
      int i = cell.getRowIndex() + 1;
      int j = cell.getColumnIndex() + 1;
      String returnValue = "";//返回值

      try {
         //获取模板文件对单元格格式限制
         String type = td.getAttribute("type").getValue();
         boolean isNullAble = td.getAttribute("isnullable").getBooleanValue();
         int maxlength = 9999;

         if (td.getAttribute("maxlength") != null) {
            maxlength = td.getAttribute("maxlength").getIntValue();
         }
         String value = null;
         //根据格式取出单元格的值
         switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING: {
               value = cell.getStringCellValue();
               break;
            }
            case Cell.CELL_TYPE_NUMERIC: {
               if ("datetime,date".indexOf(type) >= 0) {
                  Date date = cell.getDateCellValue();
                  SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                  value = df.format(date);
               }
               else {
                  double numericCellValue = cell.getNumericCellValue();
                  value = String.valueOf(numericCellValue);
               }
               break;
            }
         }

         //对非空、长度进行校验
         if (!isNullAble && StringUtils.isBlank(value)) {
            //错误编码,错误位置原因,单位格的值
            returnValue = "#0001,第" + i + "行第" + j + "列不能为空！," + value;
         }
         else if (StringUtils.isNotBlank(value) && (value.length() > maxlength)) {
            returnValue = "#0002,第" + i + "行第" + j + "列长度超过最大长度！," + value;
         }
         else {
            returnValue = value;
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return returnValue;
   }

}
