package com.xoa.util;

import java.math.BigDecimal;
import java.util.Map;

public class ConvertMoney {

    private static Double fenJiao=0.0;

    private static Map<String,Double> seriesMap;
    private static Map<String,Double> unitsMap;

    /**
     * 数字转换为汉语中人民币的大写<br>
     *
     * @author lr
     * @contact hongtenzone@foxmail.com
     * @create 2018-08-30
     */

    /**
     * 汉语中数字大写
     */
    private static final String[] CN_UPPER_NUMBER = { "零", "壹", "贰", "叁", "肆",
            "伍", "陆", "柒", "捌", "玖" };
    /**
     * 汉语中货币单位大写，这样的设计类似于占位符
     */
    private static final String[] CN_UPPER_MONETRAY_UNIT = { "分", "角", "元",
            "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "兆", "拾",
            "佰", "仟" };
    /**
     * 特殊字符：整
     */
    private static final String CN_FULL = "整";
    /**
     * 特殊字符：负
     */
    private static final String CN_NEGATIVE = "负";
    /**
     * 金额的精度，默认值为2
     */
    private static final int MONEY_PRECISION = 2;
    /**
     * 特殊字符：零元整
     */
    private static final String CN_ZEOR_FULL = "零元" + CN_FULL;

    /**
     * 把输入的金额转换为汉语中人民币的大写
     *
     * @param numberOfMoney
     *            输入的金额
     * @return 对应的汉语大写
     */
    public static String number2CNMontrayUnit(BigDecimal numberOfMoney) {
        StringBuffer sb = new StringBuffer();
        // -1, 0,
        int signum = numberOfMoney.signum();
        // 零元整的情况
        if (signum == 0) {
            return CN_ZEOR_FULL;
        }
        //这里会进行金额的四舍五入
        long number = numberOfMoney.movePointRight(MONEY_PRECISION)
                .setScale(0, 4).abs().longValue();
        // 得到小数点后两位值
        long scale = number % 100;
        int numUnit = 0;
        int numIndex = 0;
        boolean getZero = false;
        // 判断最后两位数，一共有四中情况：00 = 0, 01 = 1, 10, 11
        if (!(scale > 0)) {
            numIndex = 2;
            number = number / 100;
            getZero = true;
        }
        if ((scale > 0) && (!(scale % 10 > 0))) {
            numIndex = 1;
            number = number / 10;
            getZero = true;
        }
        int zeroSize = 0;
        while (true) {
            if (number <= 0) {
                break;
            }
            // 每次获取到最后一个数
            numUnit = (int) (number % 10);
            if (numUnit > 0) {
                if ((numIndex == 9) && (zeroSize >= 3)) {
                    sb.insert(0, CN_UPPER_MONETRAY_UNIT[6]);
                }
                if ((numIndex == 13) && (zeroSize >= 3)) {
                    sb.insert(0, CN_UPPER_MONETRAY_UNIT[10]);
                }
                sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]);
                sb.insert(0, CN_UPPER_NUMBER[numUnit]);
                getZero = false;
                zeroSize = 0;
            } else {
                ++zeroSize;
                if (!(getZero)) {
                    sb.insert(0, CN_UPPER_NUMBER[numUnit]);
                }
                if (numIndex == 2) {
                    if (number > 0) {
                        sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]);
                    }
                } else if (((numIndex - 2) % 4 == 0) && (number % 1000 > 0)) {
                    sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]);
                }
                getZero = true;
            }
            // 让number每次都去掉最后一个数
            number = number / 10;
            ++numIndex;
        }
        // 如果signum == -1，则说明输入的数字为负数，就在最前面追加特殊字符：负
        if (signum == -1) {
            sb.insert(0, CN_NEGATIVE);
        }
        // 输入的数字小数点后两位为"00"的情况，则要在最后追加特殊字符：整
        if (!(scale > 0)) {
            sb.append(CN_FULL);
        }
        return sb.toString();
    }

    private static long result = 0;
    // HashMap
    private static Map<String, Long> unitMap = new java.util.HashMap<String, Long>();
    private static Map<String, Long> numMap = new java.util.HashMap<String, Long>();

    // 字符串分离
    private static String stryi = new String();
    private static String stryiwan = new String();
    private static String stryione = new String();
    private static String strwan = new String();
    private static String strone = new String();


    public static void ChangeChnString(String chnStr) {
        // unit
        unitMap.put("元", 1L);
        unitMap.put("拾", 10L);
        unitMap.put("佰", 100L);
        unitMap.put("仟", 1000L);
        unitMap.put("万", 10000L);
        unitMap.put("亿", 100000000L);
        // num
        numMap.put("零", 0L);
        numMap.put("壹", 1L);
        numMap.put("贰", 2L);
        numMap.put("叁", 3L);
        numMap.put("肆", 4L);
        numMap.put("伍", 5L);
        numMap.put("陆", 6L);
        numMap.put("柒", 7L);
        numMap.put("捌", 8L);
        numMap.put("玖", 9L);
        Double fen=0.0;
        Double jiao=0.0;
        //优先处理角，分
        if(chnStr.charAt(chnStr.length()-1)=='分'){
            if(numMap.get(chnStr.charAt(chnStr.length()-2)+"")!=null){
                fen=numMap.get(chnStr.charAt(chnStr.length()-2)+"")*0.01;
                chnStr=chnStr.substring(0,chnStr.length()-2);
            }
            if(chnStr.charAt(chnStr.length()-1)=='角'){
                if(numMap.get(chnStr.charAt(chnStr.length()-2)+"")!=null){
                    jiao=numMap.get(chnStr.charAt(chnStr.length()-2)+"")*0.1;
                    chnStr=chnStr.substring(0,chnStr.length()-2);
                }
            }

        }
        //假如只有角
        if(chnStr.charAt(chnStr.length()-1)=='角'){
            if(numMap.get(chnStr.charAt(chnStr.length()-2)+"")!=null){
                jiao=numMap.get(chnStr.charAt(chnStr.length()-2)+"")*0.1;
                chnStr=chnStr.substring(0,chnStr.length()-2);
            }
        }
        //得出分角总值
        fenJiao=fen+jiao;

        // 去零
        for (int i = 0; i < chnStr.length(); i++) {
            if ('零' == (chnStr.charAt(i))) {
                chnStr = chnStr.substring(0, i) + chnStr.substring(i + 1);
            }
        }
        // 分切成三部分
        int index = 0;
        boolean yiflag = true;
        boolean yiwanflag = true; //亿字节中存在万
        boolean wanflag = true;
        for (int i = 0; i < chnStr.length(); i++) {
            if ('亿' == (chnStr.charAt(i))) {
                // 存在亿前面也有小节的情况
                stryi = chnStr.substring(0, i);
                if (chnStr.indexOf('亿' + "") > chnStr.indexOf('万' + "")) {
                    stryi = chnStr.substring(0, i);
                    for (int j = 0; j < stryi.length(); j++) {
                        if ('万' == (stryi.charAt(j))) {
                            yiwanflag = false;
                            stryiwan = stryi.substring(0, j);
                            stryione = stryi.substring(j + 1);
                        }
                    }
                }
                if(yiwanflag){//亿字节中没有万，直接赋值
                    stryione = stryi;
                }
                index = i + 1;
                yiflag = false;// 分节完毕
                strone = chnStr.substring(i + 1);

            }
            if ('万' == (chnStr.charAt(i)) && chnStr.indexOf('亿' + "") < chnStr.indexOf('万' + "")) {
                strwan = chnStr.substring(index, i);
                strone = chnStr.substring(i + 1);
                wanflag = false;// 分节完毕
            }
        }
        if (yiflag && wanflag) {// 没有处理
            strone = chnStr;
        }
    }

    // 字符串转换为数字
    public static long chnStrToNum(String str) {
        long strreuslt = 0;
        long value1 = 0;
        long value2 = 0;
        long value3 = 0;
        if (str.isEmpty()) {
            return 0;
        }
        for (int i = 0; i < str.length(); i++) {
            char bit = str.charAt(i);
            // 数字
            if (numMap.containsKey(bit + "")) {
                value1 = numMap.get(bit + "");
                if (i == str.length() - 1) {
                    strreuslt += value1;
                }

            }
            // 单位
            else if (unitMap.containsKey(bit + "")) {
                value2 = unitMap.get(bit + "");
                if (value1 == 0 && value2 == 10L) {
                    value3 = 1 * value2;
                } else {
                    value3 = value1 * value2;
                    // 清零避免重复读取
                    value1 = 0;
                }
                strreuslt += value3;
            }
        }
        return strreuslt;
    }

    // 组合数字
    public static Double ComputeResult(String chnStr) {
        ChangeChnString(chnStr);
        long stryiwanresult = chnStrToNum(stryiwan);
        long stryioneresult = chnStrToNum(stryione);
        long strwanresult = chnStrToNum(strwan);
        long stroneresult = chnStrToNum(strone);
        result = (stryiwanresult + stryioneresult) * 100000000 + strwanresult * 10000 + stroneresult;
        // 重置
        stryi = "";
        strwan = "";
        strone = "";
        return result+fenJiao;
    }

}
