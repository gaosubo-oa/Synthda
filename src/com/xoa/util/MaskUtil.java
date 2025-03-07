package com.xoa.util;

import org.apache.commons.lang3.StringUtils;

/**
 * 敏感信息脱敏工具类
 */
public class MaskUtil {

    /**
     * 手机号脱敏
     * @param phone
     * @return
     */
    public final static String maskPhone(String phone){
        if(phone==null || phone.length()!=11) {
            return phone;
        }
        return StringUtils.join(phone.substring(0,3)+"******"+phone.substring(9));
    }

    /**
     * 身份证号脱敏
     * @param id
     * @return
     */
    public final static String maskIdCard(String id){
        if(id==null || id.length()!=18) {
            return id;
        }
        return StringUtils.join(id.substring(0,6)+"****");
    }

    /**
     *中文姓名脱敏
     * @param fullName
     * @return
     */
    public final static String chineseName(String fullName) {
        if(StringUtils.isBlank(fullName)) {
            return fullName;
        }
        String name = StringUtils.left(fullName, 1);
        return StringUtils.rightPad(name, StringUtils.length(fullName), "*");
    }

    /**
     *家庭住址脱敏
     * @param address
     * @param sensitiveSize 敏感信息长度
     * @return
     */
    public final static String address(String address, int sensitiveSize) {
        if(StringUtils.isBlank(address)) {
            return address;
        }
        int length = StringUtils.length(address);
        return StringUtils.rightPad(StringUtils.left(address, length - sensitiveSize), length - sensitiveSize+4, "*");
    }

    /**
     *邮箱脱敏
     * @param email
     * @return
     */
    public final static String email(String email) {
        if (StringUtils.isBlank(email)) {
            return email;
        }
        int index = StringUtils.indexOf(email, "@");
        if(index <= 1) {
            return email;
        } else {
            return StringUtils.rightPad(StringUtils.left(email, 1), index, "*").concat(StringUtils.mid(email, index, StringUtils.length(email)));
        }
    }

    /**
     *银行卡号脱敏
     * @param cardNum
     * @return
     */
    public final static String bankCard(String cardNum) {
        if(StringUtils.isBlank(cardNum)) {
            return cardNum;
        }
        return StringUtils.left(cardNum, 6).concat(StringUtils.removeStart(StringUtils.leftPad(StringUtils.right(cardNum, 4), StringUtils.length(cardNum), "*"), "******"));
    }

    /**
     *固定电话脱敏
     * @param num
     * @return
     */
    public final static String fixedPhone(String num) {
        if(StringUtils.isBlank(num)) {
            return num;
        }
        return StringUtils.leftPad(StringUtils.right(num, 4), StringUtils.length(num), "*");
    }
}

