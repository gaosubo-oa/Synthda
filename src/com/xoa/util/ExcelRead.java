package com.xoa.util;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
/** 
 * 读取Excel 
 * @author zlf
 * 
 */  
public class ExcelRead {      
    public int totalRows; //sheet中总行数  
    public static int totalCells; //每一行总单元格数


    /**
     * read the Excel .xlsx,.xls
     * @param file jsp中的上传文件
     * @return
     * @throws IOException
     */
    public List<Map<String, Object>> readExcel(MultipartFile file) throws IOException{
        if(file==null||EMPTY.equals(file.getOriginalFilename().trim())){
            return null;
        }else{
            String postfix = getPostfix(file.getOriginalFilename());
            if(!EMPTY.equals(postfix)){
                if(OFFICE_EXCEL_2003_POSTFIX.equals(postfix)){
                    return readXls(file);
                }else if(OFFICE_EXCEL_2010_POSTFIX.equals(postfix)){
                    return readXlsx(file);
                }else{
                    return null;
                }
            }
        }
        return null;
    }

    public List<Map<String, Object>> readXlsx(MultipartFile file){
        List<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
        List<Map<String, Object>> maps = new ArrayList<>();
        // IO流读取文件  
        InputStream input = null;  
        XSSFWorkbook wb = null;  
        ArrayList<String> rowList = null;  
        try {  
            input = file.getInputStream();  
            // 创建文档  
            wb = new XSSFWorkbook(input);                         
            //读取sheet(页)  
            for(int numSheet=0;numSheet<wb.getNumberOfSheets();numSheet++){  
                XSSFSheet xssfSheet = wb.getSheetAt(numSheet);  
                if(xssfSheet == null){  
                    continue;  
                }  
                totalRows = xssfSheet.getLastRowNum();
                //读取Row,从第二行开始  
                for(int rowNum = 0;rowNum <= totalRows;rowNum++){
                    XSSFRow xssfRow = xssfSheet.getRow(rowNum);
                    //第一行
                    XSSFRow xssfRow1 = xssfSheet.getRow(0);
                    if(xssfRow!=null){  
                        rowList = new ArrayList<String>();
                        Map<String, Object> map = new HashMap<String, Object>();
                        totalCells = xssfRow.getLastCellNum();  
                        //读取列，从第一列开始  
                        for(int c=0;c<totalCells;c++){
                            XSSFCell cell = xssfRow.getCell(c);
                            if (cell!=null){
                                map.put(getXValue(xssfRow1.getCell(c)).trim(), getXValue(cell).trim());
                            }
                            if(cell==null){
                                map.put(getXValue(xssfRow1.getCell(c)).trim(), "");
                                rowList.add(EMPTY);
                                continue;
                            }
                            rowList.add(getXValue(cell).trim());
                        }     
                    list.add(rowList);
                        maps.add(map);
                    }  
                }  
            }  
            return maps;
        } catch (IOException e) {             
            e.printStackTrace();  
        } finally{  
            try {  
                input.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
        return null;  
          
    }  

    public List<Map<String, Object>> readXls(MultipartFile file){
        List<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
        List<Map<String, Object>> maps = new ArrayList<>();
        // IO流读取文件  
        InputStream input = null;  
        HSSFWorkbook wb = null;
        ArrayList<String> rowList = null;  
        try {  
            input = file.getInputStream();  
            // 创建文档  
            wb = new HSSFWorkbook(input);                         
            //读取sheet(页)  
            for(int numSheet=0;numSheet<wb.getNumberOfSheets();numSheet++){
                HSSFSheet hssfSheet = wb.getSheetAt(numSheet);  
                if(hssfSheet == null){  
                    continue;  
                }  
                totalRows = hssfSheet.getLastRowNum();
                totalCells = hssfSheet.getRow(0).getLastCellNum();

                //读取Row,从第二行开始  
                for(int rowNum = 1;rowNum <= totalRows;rowNum++){
                    //第一行
                    HSSFRow hssfRow1 = hssfSheet.getRow(0);
                    HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                    if(hssfRow!=null){  
                        rowList = new ArrayList<String>();  
                        Map<String, Object> map = new HashMap<String, Object>();
                        //读取列，从第一列开始
                        for(int c=0;c<totalCells;c++){
                            HSSFCell cell = hssfRow.getCell(c);
                            if (cell!=null){
                                map.put(getHValue(hssfRow1.getCell(c)).trim(), getHValue(cell).trim());
                            }
                            if(cell==null){
                                map.put(getHValue(hssfRow1.getCell(c)).trim(), "");
                                rowList.add(EMPTY);
                                continue;
                            }
                            rowList.add(getHValue(cell).trim());

                        }
                        maps.add(map);
                        list.add(rowList);
                    }                     
                }  
            }  
            return maps;
        } catch (IOException e) {             
            e.printStackTrace();  
        } finally{  
            try {  
                input.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
        return null;  
    }



    public static final String OFFICE_EXCEL_2003_POSTFIX = "xls";
    public static final String OFFICE_EXCEL_2010_POSTFIX = "xlsx";
    public static final String EMPTY = "";
    public static final String POINT = ".";
    public static SimpleDateFormat sdf =   new SimpleDateFormat("yyyy/MM/dd");
    /**
     * 获得path的后缀名
     * @param path
     * @return
     */
    public static String getPostfix(String path){
        if(path==null || EMPTY.equals(path.trim())){
            return EMPTY;
        }
        if(path.contains(POINT)){
            return path.substring(path.lastIndexOf(POINT)+1,path.length());
        }
        return EMPTY;
    }
    /**
     * 单元格格式
     * @param hssfCell
     * @return
     */
    @SuppressWarnings({ "static-access", "deprecation" })
    public static String getHValue(HSSFCell hssfCell){
        if (hssfCell.getCellType() == CellType.BOOLEAN) {
            return String.valueOf(hssfCell.getBooleanCellValue());
        } else if (hssfCell.getCellType() == CellType.NUMERIC) {
            String cellValue = "";
            if(HSSFDateUtil.isCellDateFormatted(hssfCell)){
                Date date = HSSFDateUtil.getJavaDate(hssfCell.getNumericCellValue());
                cellValue = sdf.format(date);
            }else{
                DecimalFormat df = new DecimalFormat("#.##");
                cellValue = df.format(hssfCell.getNumericCellValue());
                String strArr = cellValue.substring(cellValue.lastIndexOf(POINT)+1,cellValue.length());
                if(strArr.equals("00")){
                    cellValue = cellValue.substring(0, cellValue.lastIndexOf(POINT));
                }
            }
            return cellValue;
        } else {
            return String.valueOf(hssfCell.getStringCellValue());
        }
    }
    /**
     * 单元格格式
     * @param xssfCell
     * @return
     */
    public static String getXValue(XSSFCell xssfCell){
        if (xssfCell.getCellType() == CellType.BOOLEAN) {
            return String.valueOf(xssfCell.getBooleanCellValue());
        } else if (xssfCell.getCellType() ==CellType.NUMERIC) {
            String cellValue = "";
            if(DateUtil.isCellDateFormatted(xssfCell)){
                Date date = DateUtil.getJavaDate(xssfCell.getNumericCellValue());
                cellValue = sdf.format(date);
            }else{
                DecimalFormat df = new DecimalFormat("#.##");
                cellValue = df.format(xssfCell.getNumericCellValue());
                String strArr = cellValue.substring(cellValue.lastIndexOf(POINT)+1,cellValue.length());
                if(strArr.equals("00")){
                    cellValue = cellValue.substring(0, cellValue.lastIndexOf(POINT));
                }
            }
            return cellValue;
        } else {
            return String.valueOf(xssfCell.getStringCellValue());
        }
    }

}  
