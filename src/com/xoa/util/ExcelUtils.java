package com.xoa.util;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @program: xoa
 * @Date: 2018/8/31 18:03
 * @Author: 邱建鹏
 * @Description:
 */
public class ExcelUtils {

        public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");



    public static <T> void exportExcel(String head, String[] secondTitle , String[] beanPropertys, List<T> t, HttpServletResponse response) {
        try {
            HSSFWorkbook workbook = ExcelUtil.makeExcelHead(head, secondTitle.length);
            HSSFWorkbook workbook1 = ExcelUtil.makeSecondHead(workbook, secondTitle);
            HSSFWorkbook workbook2 = ExcelUtil.exportExcelData( workbook1, t, beanPropertys);
            String fileName = new String(head.getBytes(), "ISO8859_1");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xls");
            ServletOutputStream outputStream = response.getOutputStream();
            workbook2.write(outputStream);
            outputStream.flush();
            outputStream.close();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     *  bean属性数组转换成数据库列名
     * @param columns bean属性数组
     * @return
     */
    public static  List<Object> getDBColumn(String[] columns){
        List<Object> columnList =new ArrayList<>();
        for (String s : columns) {
            StringBuffer sb = new StringBuffer(s);
            int j = 0;
            for(int i=0; i<s.length(); i++){
                char c = s.charAt(i);
                if(c >= 65 && c <= 90) {
                    sb.insert(i+j,"_");
                    j+=1;
                }
            }
            columnList.add(sb.toString().toUpperCase());
        }
        return columnList;
    }


        /**
         * 动态导出excel
         * @param head 导出文件标题
         * @param secondTitle 列名
         * @param formatBeanProperty 需要格式化的属性数组
         * @param beanPropertys 列名对应属性
         * @param t 要导出的数据集合
         * @param response
         * @param <T>
         */
        public static <T> void dynamicExportExcel(String head, String[] secondTitle, String[] formatBeanProperty, String[] beanPropertys, List<T> t, HttpServletResponse response) {
            try {
                HSSFWorkbook workbook = makeExcelHead(head, secondTitle.length-1);
                HSSFWorkbook workbook1 = makeSecondHead(workbook, secondTitle);
                HSSFWorkbook workbook2 = exportExcelData( formatBeanProperty ,workbook1, t, beanPropertys);
                String fileName = new String(head.getBytes(), "ISO8859_1");
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xls");
                ServletOutputStream outputStream = response.getOutputStream();
                workbook2.write(outputStream);
                outputStream.flush();
                outputStream.close();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    /**
     *  设置标题
     * @param title 标题
     * @param cellRangeAddressLength 跨列长度
     * @return
     */
        public static HSSFWorkbook makeExcelHead(String title, int cellRangeAddressLength) {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFCellStyle styleTitle = createStyle(workbook, (short)16);
            HSSFSheet sheet = workbook.createSheet(title);
            sheet.setDefaultColumnWidth(25);
            CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, cellRangeAddressLength);
            sheet.addMergedRegion(cellRangeAddress);
            HSSFRow rowTitle = sheet.createRow(0);
            HSSFCell cellTitle = rowTitle.createCell(0);
            styleTitle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            styleTitle.setFillForegroundColor((short)22);
            cellTitle.setCellValue(title);
            cellTitle.setCellStyle(styleTitle);
            return workbook;
        }

        public static HSSFWorkbook makeSecondHead(HSSFWorkbook workbook, String[] secondTitles) {
            HSSFSheet sheet = workbook.getSheetAt(0);
            HSSFRow rowField = sheet.createRow(1);
            HSSFCellStyle styleField = createStyle(workbook, (short)13);

            for(int i = 0; i < secondTitles.length; ++i) {
                HSSFCell cell = rowField.createCell(i);
                cell.setCellValue(secondTitles[i]);
                cell.setCellStyle(styleField);
            }

            return workbook;
        }


    /**
     *  写入excel
     * @param formatBean 需要格式化的property(只能转换 0 ，1为---》是,否)
     * @param workbook
     * @param dataList 数据集合
     * @param beanPropertys 属性集合
     * @param <T>
     * @return
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws NoSuchMethodException
     */
        public static <T> HSSFWorkbook exportExcelData(String[] formatBean,HSSFWorkbook workbook, List<T> dataList, String[] beanPropertys) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
            HSSFSheet sheet = workbook.getSheetAt(0);
            HSSFCellStyle styleData = workbook.createCellStyle();
            styleData.setAlignment(HorizontalAlignment.CENTER);
            styleData.setVerticalAlignment(VerticalAlignment.CENTER);

            for(int j = 0; j < dataList.size(); ++j) {
                HSSFRow rowData = sheet.createRow(j + 2);
                T t = dataList.get(j);

                for(int k = 0; k < beanPropertys.length; ++k) {
                    Object value = PropertyUtils.getSimpleProperty(t, beanPropertys[k]);
                    HSSFCell cellData = rowData.createCell(k);

                    try {
                        if (!"".equals(value) && value != null) {
                            if (value.getClass().getName().equals("java.util.Date")){
                                String date = sdf.format(value);
                                cellData.setCellValue(date.toString());
                            }else if(beanPropertys[k].equals("sex")){
                                cellData.setCellValue(Integer.parseInt(value.toString())==0 ? "男":"女");
                            }else if (formatBean!=null ){
                                if(Arrays.asList(formatBean).contains(beanPropertys[k])){
                                    cellData.setCellValue(Integer.parseInt(value.toString())==0 ? "是":"否");
                                }
                            }else {
                                cellData.setCellValue(value.toString());
                            }
                        } else {
                            cellData.setCellValue("");
                        }
                        cellData.setCellStyle(styleData);
                    } catch (Exception var12) {
                        var12.printStackTrace();
                    }
                }
            }

            return workbook;
        }

    private static HSSFCellStyle createStyle(HSSFWorkbook workbook, short fontSize) {
        HSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints(fontSize);
        font.setBold(true);
        style.setFont(font);
        return style;
    }

}








    /**
     *
     * @param dataList 数据集合
     * @param title 表头
     * @param secondTitle  列名
     * @param mapList  经过处理的数据集合
     * @param beanPropertys  实体类属性集合
     * @param response
     * @param <T>
     */
    /*public static <T> void exportExcel(List<T> dataList, String title , String[] secondTitle, List<Map<String,Object>> mapList, String[] beanPropertys, HttpServletResponse response){
        try {
            HSSFWorkbook workbook = ExcelUtil.makeExcelHead(title, 14);
            HSSFWorkbook workbook1 = ExcelUtil.makeSecondHead(workbook, secondTitle);
            HSSFSheet sheet = workbook1.getSheetAt(0);
            HSSFCellStyle cellStyle = workbook1.createCellStyle();
            cellStyle.setAlignment((short) 2);
            cellStyle.setVerticalAlignment((short) 2);
            for (int i = 0; i < dataList.size(); i++) {
                HSSFRow row = sheet.createRow(i + 2);  //创建行
                for (int j = 0; j <beanPropertys.length ; j++) {
                    Object value = mapList.get(i).get(beanPropertys[j]);
                    HSSFCell cell = row.createCell(j);
                    try {
                        if (!"".equals(value) && value!=null){
                            cell.setCellValue(value.toString());
                        }else {
                            cell.setCellValue("");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
            String fileName = new String(title.getBytes(),"ISO8859_1");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition" ,"attachment;filename="+fileName+".xls");
            try {
                ServletOutputStream outputStream = response.getOutputStream();
                workbook1.write(outputStream);
                outputStream.flush();
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }*/


   /* //上传附件
    public static  <T> void upload(MultipartFile[ ] files, T t) {
        try {
            if (files.length!=0){
                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        ResourceBundle rb = ResourceBundle.getBundle("upload");
                        String os = System.getProperty("os.name");
                        StringBuffer sb = new StringBuffer();
                        if (os.toLowerCase().startsWith("win")) {
                            sb = sb.append(rb.getString("upload.win"));
                        } else {
                            sb = sb.append(rb.getString("upload.linux"));
                        }
                        String ym = new SimpleDateFormat("yyMM").format(new Date());
                        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                        String path;
                        if (StringUtils.checkNull(sb.toString())) {
                            path = request.getSession().getServletContext().getRealPath("");
                            sb.append(path);
                            sb.append(System.getProperty("file.separator")).append("attach").append(System.getProperty("file.separator")).append("xmxoa").append(System.getProperty("file.separator")).append("eduPersonalInformation").append(System.getProperty("file.separator")).append(ym);
                        } else {
                            sb.append(System.getProperty("file.separator")).append("attach").append(System.getProperty("file.separator")).append("xmxoa").append(System.getProperty("file.separator")).append("eduPersonalInformation").append(System.getProperty("file.separator")).append(ym);
                        }
                        path = sb.toString();
                        String fileName = file.getOriginalFilename();
                        String endWith = fileName.substring(fileName.lastIndexOf("."));
                        String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
                        String newFileName = uuid + endWith.toString();
                        StringBuffer buffer = new StringBuffer();
                        if (os.toLowerCase().startsWith("win")) {
                            buffer.append(newFileName);
                        } else {
                            try {
                                buffer.append(new String(newFileName.getBytes(), "UTF-8"));
                            } catch (UnsupportedEncodingException e) {
                                e.printStackTrace();
                            }
                        }

                        if (!(new File(path, newFileName)).exists()) {
                            (new File(path, newFileName)).mkdirs();
                        }
                        file.transferTo(new File(path, newFileName));

                        Field[] fields = t.getClass().getDeclaredFields();
                        for (Field attribute:fields){
                            attribute.setAccessible(true);
                            String attributeName = attribute.getName();
                                switch (attributeName){
                                    case "attachmentId":
                                        attribute.set(t, ym);
                                        break;
                                    case "attachmentName":
                                        attribute.set(t, newFileName);
                                        break;
                                }
                        }

                    }
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

    }*/



