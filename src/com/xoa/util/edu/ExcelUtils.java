package com.xoa.util.edu;

import com.xoa.util.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * @program: xoa
 * @Date: 2018/8/31 18:03
 * @Author: 邱建鹏
 * @Description:
 */
public class ExcelUtils {

    /**
     * 导出封装方法
     * @param title 导出文件标题
     * @param secondTitle 列名
     * @param beanPropertys 列名对应属性
     * @param t 要导出的数据集合
     * @param response
     * @param <T>
     */
    public static <T> void exportExcel(String title, String[] secondTitle, String[] beanPropertys, List<T> t, HttpServletResponse response) {
        try {
            HSSFWorkbook workbook = ExcelUtil.makeExcelHead(title, secondTitle.length);
            HSSFWorkbook workbook1 = ExcelUtil.makeSecondHead(workbook, secondTitle);
            HSSFWorkbook workbook2 = ExcelUtil.exportExcelData(workbook1, t, beanPropertys);
            String fileName = new String(title.getBytes(), "ISO8859_1");
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



