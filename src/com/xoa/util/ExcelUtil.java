package com.xoa.util;

import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionException;
import com.xoa.util.common.session.SessionUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelUtil {
    private ExcelUtil() {
    }
    /**
     * 导出excel头部标题
     * @param title
     * @param cellRangeAddressLength
     * @return
     */
    public static HSSFWorkbook makeExcelHead(String title, int cellRangeAddressLength){
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFCellStyle styleTitle = createStyle(workbook, (short)16);
        HSSFSheet sheet = workbook.createSheet(title);
        sheet.setDefaultColumnWidth(25);
        CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, cellRangeAddressLength);
        sheet.addMergedRegion(cellRangeAddress);
        HSSFRow rowTitle = sheet.createRow(0);
        HSSFCell cellTitle = rowTitle.createCell(0);
        // 为标题设置背景颜色
        styleTitle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        styleTitle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
        cellTitle.setCellValue(title);
        cellTitle.setCellStyle(styleTitle);
        return workbook;
    }
    /**
     * 设定二级标题
     * @param workbook
     * @param secondTitles
     * @return
     */
    public static HSSFWorkbook makeSecondHead(HSSFWorkbook workbook, String[] secondTitles){
        // 创建用户属性栏
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow rowField = sheet.createRow(1);
        HSSFCellStyle styleField = createStyle(workbook, (short)13);
        for (int i = 0; i < secondTitles.length; i++) {
            HSSFCell cell = rowField.createCell(i);
            cell.setCellValue(secondTitles[i]);
            cell.setCellStyle(styleField);
        }
        return workbook;
    }
    /**
     * 插入数据
     * @param workbook
     * @param dataList
     * @param beanPropertys
     * @return
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static <T> HSSFWorkbook exportExcelData(HSSFWorkbook workbook, List<T> dataList, String[] beanPropertys) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        HSSFSheet sheet = workbook.getSheetAt(0);
        // 填充数据
        HSSFCellStyle styleData = workbook.createCellStyle();
        styleData.setAlignment(HorizontalAlignment.CENTER);
        styleData.setVerticalAlignment(VerticalAlignment.CENTER);
        styleData.setWrapText(true);//填充数据自动换行

        for (int j = 0; j < dataList.size(); j++) {
            HSSFRow rowData = sheet.createRow(j + 2);
            T t = dataList.get(j);
            for(int k=0; k<beanPropertys.length; k++){
                String className = t.getClass().getName();
                Object value = null;
                if ( className.equals("java.util.HashMap") ){
                    Map map = (HashMap) t;
                    value = map.get(beanPropertys[k]);
                }else {
                    value = PropertyUtils.getSimpleProperty(t, beanPropertys[k]);
                }

                HSSFCell cellData = rowData.createCell(k);
                try {
                    if (!value.equals("")&&value!=null) {
                        cellData.setCellValue(value.toString());
                    }else {
                        cellData.setCellValue("");
                    }
                    cellData.setCellStyle(styleData);
                } catch (Exception e) {

                }

            }
        }
        return workbook;
    }
    /*
    * 王辰
    * 自动转换Date格式到String的
    * */
    public static <T> HSSFWorkbook exportExcelData2(HSSFWorkbook workbook, List<T> dataList, String[] beanPropertys) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        HSSFSheet sheet = workbook.getSheetAt(0);
        // 填充数据
        HSSFCellStyle styleData = workbook.createCellStyle();
        styleData.setAlignment(HorizontalAlignment.CENTER);
        styleData.setVerticalAlignment(VerticalAlignment.CENTER);

        for (int j = 0; j < dataList.size(); j++) {
            HSSFRow rowData = sheet.createRow(j + 2);
            T t = dataList.get(j);
            for(int k=0; k<beanPropertys.length; k++){
                String className = t.getClass().getName();
                Object value = null;
                if ( className.equals("java.util.HashMap") ){
                    Map map = (HashMap) t;
                    value = map.get(beanPropertys[k]);
                }else {
                    value = PropertyUtils.getSimpleProperty(t, beanPropertys[k]);
                }

                HSSFCell cellData = rowData.createCell(k);
                try {
                    if (!value.equals("")&&value!=null) {
                        if(value instanceof Date){
                            Date date = (Date) value;
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            cellData.setCellValue(sdf.format(date));
                        }else{
                            cellData.setCellValue(value.toString());
                        }
                    }else {
                        cellData.setCellValue("");
                    }
                    cellData.setCellStyle(styleData);
                } catch (Exception e) {

                }

            }
        }
        return workbook;
    }

    /**
     * 插入数据 自定义开始列  用于复杂表头
     * @param workbook
     * @param dataList
     * @param beanPropertys
     * @return
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static <T> HSSFWorkbook exportExcelDatafirs(HSSFWorkbook workbook, List<T> dataList, String[] beanPropertys,int firs) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        HSSFSheet sheet = workbook.getSheetAt(0);
        // 填充数据
        HSSFCellStyle styleData = workbook.createCellStyle();
        styleData.setAlignment(HorizontalAlignment.CENTER);
        styleData.setVerticalAlignment(VerticalAlignment.CENTER);

        for (int j = 0; j < dataList.size(); j++) {
            HSSFRow rowData = sheet.createRow(j + firs);
            T t = dataList.get(j);
            for(int k=0; k<beanPropertys.length; k++){
                String className = t.getClass().getName();
                Object value = null;
                if ( className.equals("java.util.HashMap") ){
                    Map map = (HashMap) t;
                    value = map.get(beanPropertys[k]);
                }else {
                    value = PropertyUtils.getSimpleProperty(t, beanPropertys[k]);
                }

                HSSFCell cellData = rowData.createCell(k);
                try {
                    if (!value.equals("")&&value!=null) {
                        cellData.setCellValue(value.toString());
                    }else {
                        cellData.setCellValue("");
                    }
                    cellData.setCellStyle(styleData);
                } catch (Exception e) {

                }

            }
        }
        return workbook;
    }



    /**
     * 提取公共的样式
     * @param workbook
     * @param fontSize
     * @return
     */
    public static HSSFCellStyle createStyle(HSSFWorkbook workbook, short fontSize){
        HSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        // 创建一个字体样式
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints(fontSize);
        //字体加粗
        font.setBold(true);
        style.setFont(font);
        return style;
    }

    /**
     * 将excel中的每列对应到相应的实体类中
     * @param row
     * @param clazz
     * @param deffault
     * @param param
     * @param <T>
     * @return
     */
    public static <T> T setCellInfoToModel(Row row, Class<T> clazz,
                                           T deffault, Map<String,Integer> param) {

        T ret = null;
        if (deffault == null)
            return null;
        try {
            Field[] fields = Class.forName(clazz.getName()).getDeclaredFields();
            ret = clazz.cast(deffault);//转换当前类型或其子类下的对象
            for (int i = 0; i < fields.length; i++) {
                fields[i].setAccessible(true);
                String methodName="";
                if(fields[i].getName().equals("eMail")){
                    methodName="eMail";
                }else{
                    methodName=SessionUtils.getMethodName(fields[i].getName());
                }
                Method set_Method = clazz.getMethod("set"+ methodName,fields[i].getType());
                set_Method.setAccessible(true);
                for(int j=0;j<param.size();j++){
                    Cell cell = row.getCell(j);
                    if(cell==null) continue;
                    if(param.get(fields[i].getName())!=null&&j==param.get(fields[i].getName())){
                        Object value=null;
                        switch (cell.getCellType()){
                            case STRING:
                                if (fields[i].getGenericType().toString().equals("class java.util.Date")) {
                                    value=DateFormat.DateToStr(cell.getStringCellValue());
                                }else if(fields[i].getGenericType().toString().equals("class java.lang.Integer")){
                                   value=Integer.valueOf(cell.getStringCellValue());
                                }else{
                                    value = cell.getStringCellValue();
                                }
                                break;
                            case NUMERIC:
                                //对日期进行判断和解析
                                if(HSSFDateUtil.isCellDateFormatted(cell)){
                                    double cellValue = cell.getNumericCellValue();
                                    value = HSSFDateUtil.getJavaDate(cellValue);
                                }else{
                                    value=(long)cell.getNumericCellValue();
                                }
                                break;
                            case BOOLEAN:
                                value = cell.getBooleanCellValue();
                                break;
                            case FORMULA:
                                value = cell.getCellFormula();
                                break;
                            case ERROR:
                                value = cell.getErrorCellValue();
                                value=DateFormat.DateToStr(String.valueOf(value));
                                break;
                            case BLANK:
                                break;
                            default:
                                break;
                        }
                        if (value != null) {
                            try{
                                set_Method.invoke(ret, value);
                            }catch (Exception e) {
                                set_Method.invoke(ret, String.valueOf(value));
                            }
                        }
                    }
                }

            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            throw new SessionException("value is null");
        }
        return ret;

    }

    /**
     * 陈东虎 包含单元格合并
     * 插入数据
     * @param workbook
     * @param dataList
     * @param beanPropertys
     * @return
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public static <T> HSSFWorkbook exportExcelDataCellRange(HSSFWorkbook workbook, List<T> dataList, String[] beanPropertys,List<CellRangeAddress> rangeAddressList) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
        HSSFSheet sheet = workbook.getSheetAt(0);
        // 填充数据
        HSSFCellStyle styleData = workbook.createCellStyle();
        styleData.setAlignment(HorizontalAlignment.CENTER);
        styleData.setVerticalAlignment(VerticalAlignment.CENTER);
        if(rangeAddressList!=null&&!rangeAddressList.isEmpty()){
            for(CellRangeAddress cellAddresses : rangeAddressList){
                sheet.addMergedRegion(cellAddresses);
            }
        }
        for (int j = 0; j < dataList.size(); j++) {
            HSSFRow rowData = sheet.createRow(j + 2);
            T t = dataList.get(j);
            for(int k=0; k<beanPropertys.length; k++){
                String className = t.getClass().getName();
                Object value = null;
                if ( className.equals("java.util.HashMap") ){
                    Map map = (HashMap) t;
                    value = map.get(beanPropertys[k]);
                }else {
                    value = PropertyUtils.getSimpleProperty(t, beanPropertys[k]);
                }

                HSSFCell cellData = rowData.createCell(k);
                try {
                    if (!value.equals("")&&value!=null) {
                        cellData.setCellValue(value.toString());
                    }else {
                        cellData.setCellValue("");
                    }
                    cellData.setCellStyle(styleData);
                } catch (Exception e) {

                }

            }
        }
        return workbook;
    }


    /**
     *  判断单元格类型是否为时间类型（支持多种时间格式）
     */
    public static boolean isCellDateFormatted(Cell cell) {
        if (cell == null) {
            return false;
        }
        boolean bDate = false;

        double d = cell.getNumericCellValue();
        if (isValidExcelDate(d)) {
            CellStyle style = cell.getCellStyle();
            if (style == null) {
                return false;
            }
            int i = style.getDataFormat();
            String f = style.getDataFormatString();
            bDate = isADateFormat(i, f);
        }
        return bDate;
    }

    public static boolean isADateFormat(int formatIndex, String formatString) {
        if (isInternalDateFormat(formatIndex)) {
            return true;
        }

        if ((formatString == null) || (formatString.length() == 0)) {
            return false;
        }

        String fs = formatString;
        //下面这一行是自己手动添加的 以支持汉字格式wingzing
        fs = fs.replaceAll("[\"|\']","").replaceAll("[年|月|日|时|分|秒|毫秒|微秒]", "");

        fs = fs.replaceAll("\\\\-", "-");

        fs = fs.replaceAll("\\\\,", ",");

        fs = fs.replaceAll("\\\\.", ".");

        fs = fs.replaceAll("\\\\ ", " ");

        fs = fs.replaceAll(";@", "");

        fs = fs.replaceAll("^\\[\\$\\-.*?\\]", "");

        fs = fs.replaceAll("^\\[[a-zA-Z]+\\]", "");

        return (fs.matches("^[yYmMdDhHsS\\-/,. :]+[ampAMP/]*$"));
    }

    public static boolean isInternalDateFormat(int format) {
        switch (format) { case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 45:
            case 46:
            case 47:
                return true;
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
            case 33:
            case 34:
            case 35:
            case 36:
            case 37:
            case 38:
            case 39:
            case 40:
            case 41:
            case 42:
            case 43:
            case 44: } return false;
    }

    public static boolean isValidExcelDate(double value) {
        return (value > -4.940656458412465E-324D);
    }

    /**
     * 通用样式 插入List类型数据
     * @param workbooks
     * @param title
     * @param secondTitles
     * @param data
     * @return HSSFWorkbook
     */
    public static <T> HSSFWorkbook createSheet(HSSFWorkbook workbooks, String title, String[] secondTitles, List<List> data) throws Exception {
        HSSFCellStyle style = workbooks.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        // 创建一个字体样式
        HSSFFont font = workbooks.createFont();
        font.setFontHeightInPoints((short) 16);
        font.setBold(true);
        style.setFont(font);
        HSSFSheet sheet = workbooks.createSheet(title);
        sheet.setDefaultColumnWidth(25);
        sheet.setDefaultRowHeightInPoints(25);
        //不需要表头情况
        int num = 0;
        if (!"noTitle".equals(title)) {
        CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, data.size()-1);
        sheet.addMergedRegion(cellRangeAddress);
        HSSFRow rowTitle = sheet.createRow(0);
        HSSFCell cellTitle = rowTitle.createCell(0);
        //为标题设置背景颜色
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
        cellTitle.setCellValue(title);
        cellTitle.setCellStyle(style);
        num +=1;
        }

        HSSFCellStyle styleData = workbooks.createCellStyle();
        styleData.setAlignment(HorizontalAlignment.CENTER);
        styleData.setVerticalAlignment(VerticalAlignment.CENTER);
        styleData.setWrapText(true);//填充数据自动换行
        //没有二级标题情况
        if (secondTitles!=null||secondTitles.length >0) {
        HSSFRow rowField = sheet.createRow(num);
            HSSFCellStyle styleField = createStyle(workbooks, (short) 13);
            for (int j = 0; j < secondTitles.length; j++) {
                HSSFCell cell = rowField.createCell(j);
                cell.setCellValue(secondTitles[j]);
                cell.setCellStyle(styleField);
            }
            num +=1;
        }
        //写入数据
        if (data != null) {
            for (int i = 0; i < data.size(); i++) {
                List list = data.get(i);
                if (list != null) {
                    for (int k = 0; k < list.size(); k++) {
                        HSSFRow rowData = sheet.getRow(k + num);
                        if (rowData == null) {
                            rowData = sheet.createRow(k+num);
                        }
                        HSSFCell datacell = rowData.createCell(i);
                        if (list.get(k) != null) {
                            String value = list.get(k).toString();
                            datacell.setCellValue(value);
                        }else {
                            datacell.setCellValue("");
                        }
                        datacell.setCellStyle(styleData);
                    }
                }

            }
        }
        return workbooks;
    }

}

