package com.xoa.model.smsSettings;

public class SmsSettings {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.ID
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.NAME
     *
     * @mbggenerated
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.PROTOCOL
     *
     * @mbggenerated
     */
    private String protocol;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.HOST
     *
     * @mbggenerated
     */
    private String host;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.PORT
     *
     * @mbggenerated
     */
    private String port;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.USERNAME
     *
     * @mbggenerated
     */
    private String username;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.PWD
     *
     * @mbggenerated
     */
    private String pwd;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.CONTENT_FIELD
     *
     * @mbggenerated
     */
    private String contentField;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.CODE
     *
     * @mbggenerated
     */
    private String code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.MOBILE
     *
     * @mbggenerated
     */
    private String mobile;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.TIME_CONTENT
     *
     * @mbggenerated
     */

    private String timeContent;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.SIGN
     *
     * @mbggenerated
     */
    private String sign;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.LOCATION
     *
     * @mbggenerated
     */
    private String location;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.EXTEND_1
     *
     * @mbggenerated
     */
    private String extend1;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.EXTEND_2
     *
     * @mbggenerated
     */
    private String extend2;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.EXTEND_3
     *
     * @mbggenerated
     */
    private String extend3;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.EXTEND_4
     *
     * @mbggenerated
     */
    private String extend4;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.EXTEND_5
     *
     * @mbggenerated
     */
    private String extend5;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column sms_settings.STATE
     *
     * @mbggenerated
     */
    private String state;


    /**
    * 创建人: 刘伯儒
    * 创建时间: 2021/6/7 16:25
    * 属性介绍：页面新家字段
    * signValue: 签名参数值
    * signPosition: 短信内容中加入签名的位置
    */
    private String signValue;
    private String signPosition;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.ID
     *
     * @return the value of sms_settings.ID
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.ID
     *
     * @param id the value for sms_settings.ID
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.NAME
     *
     * @return the value of sms_settings.NAME
     *
     * @mbggenerated
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.NAME
     *
     * @param name the value for sms_settings.NAME
     *
     * @mbggenerated
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.PROTOCOL
     *
     * @return the value of sms_settings.PROTOCOL
     *
     * @mbggenerated
     */
    public String getProtocol() {
        return protocol;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.PROTOCOL
     *
     * @param protocol the value for sms_settings.PROTOCOL
     *
     * @mbggenerated
     */
    public void setProtocol(String protocol) {
        this.protocol = protocol == null ? null : protocol.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.HOST
     *
     * @return the value of sms_settings.HOST
     *
     * @mbggenerated
     */
    public String getHost() {
        return host;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.HOST
     *
     * @param host the value for sms_settings.HOST
     *
     * @mbggenerated
     */
    public void setHost(String host) {
        this.host = host == null ? null : host.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.PORT
     *
     * @return the value of sms_settings.PORT
     *
     * @mbggenerated
     */
    public String getPort() {
        return port;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.PORT
     *
     * @param port the value for sms_settings.PORT
     *
     * @mbggenerated
     */
    public void setPort(String port) {
        this.port = port == null ? null : port.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.USERNAME
     *
     * @return the value of sms_settings.USERNAME
     *
     * @mbggenerated
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.USERNAME
     *
     * @param username the value for sms_settings.USERNAME
     *
     * @mbggenerated
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.PWD
     *
     * @return the value of sms_settings.PWD
     *
     * @mbggenerated
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.PWD
     *
     * @param pwd the value for sms_settings.PWD
     *
     * @mbggenerated
     */
    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.CONTENT_FIELD
     *
     * @return the value of sms_settings.CONTENT_FIELD
     *
     * @mbggenerated
     */
    public String getContentField() {
        return contentField;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.CONTENT_FIELD
     *
     * @param contentField the value for sms_settings.CONTENT_FIELD
     *
     * @mbggenerated
     */
    public void setContentField(String contentField) {
        this.contentField = contentField == null ? null : contentField.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.CODE
     *
     * @return the value of sms_settings.CODE
     *
     * @mbggenerated
     */
    public String getCode() {
        return code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.CODE
     *
     * @param code the value for sms_settings.CODE
     *
     * @mbggenerated
     */
    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.MOBILE
     *
     * @return the value of sms_settings.MOBILE
     *
     * @mbggenerated
     */
    public String getMobile() {
        return mobile;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.MOBILE
     *
     * @param mobile the value for sms_settings.MOBILE
     *
     * @mbggenerated
     */
    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }


    public String getTimeContent() {
        return timeContent;
    }

    public void setTimeContent(String timeContent) {
        this.timeContent = timeContent;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.SIGN
     *
     * @return the value of sms_settings.SIGN
     *
     * @mbggenerated
     */
    public String getSign() {
        return sign;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.SIGN
     *
     * @param sign the value for sms_settings.SIGN
     *
     * @mbggenerated
     */
    public void setSign(String sign) {
        this.sign = sign == null ? null : sign.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.LOCATION
     *
     * @return the value of sms_settings.LOCATION
     *
     * @mbggenerated
     */
    public String getLocation() {
        return location;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.LOCATION
     *
     * @param location the value for sms_settings.LOCATION
     *
     * @mbggenerated
     */
    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.EXTEND_1
     *
     * @return the value of sms_settings.EXTEND_1
     *
     * @mbggenerated
     */
    public String getExtend1() {
        return extend1;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.EXTEND_1
     *
     * @param extend1 the value for sms_settings.EXTEND_1
     *
     * @mbggenerated
     */
    public void setExtend1(String extend1) {
        this.extend1 = extend1 == null ? null : extend1.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.EXTEND_2
     *
     * @return the value of sms_settings.EXTEND_2
     *
     * @mbggenerated
     */
    public String getExtend2() {
        return extend2;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.EXTEND_2
     *
     * @param extend2 the value for sms_settings.EXTEND_2
     *
     * @mbggenerated
     */
    public void setExtend2(String extend2) {
        this.extend2 = extend2 == null ? null : extend2.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.EXTEND_3
     *
     * @return the value of sms_settings.EXTEND_3
     *
     * @mbggenerated
     */
    public String getExtend3() {
        return extend3;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.EXTEND_3
     *
     * @param extend3 the value for sms_settings.EXTEND_3
     *
     * @mbggenerated
     */
    public void setExtend3(String extend3) {
        this.extend3 = extend3 == null ? null : extend3.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.EXTEND_4
     *
     * @return the value of sms_settings.EXTEND_4
     *
     * @mbggenerated
     */
    public String getExtend4() {
        return extend4;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.EXTEND_4
     *
     * @param extend4 the value for sms_settings.EXTEND_4
     *
     * @mbggenerated
     */
    public void setExtend4(String extend4) {
        this.extend4 = extend4 == null ? null : extend4.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.EXTEND_5
     *
     * @return the value of sms_settings.EXTEND_5
     *
     * @mbggenerated
     */
    public String getExtend5() {
        return extend5;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.EXTEND_5
     *
     * @param extend5 the value for sms_settings.EXTEND_5
     *
     * @mbggenerated
     */
    public void setExtend5(String extend5) {
        this.extend5 = extend5 == null ? null : extend5.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms_settings.STATE
     *
     * @return the value of sms_settings.STATE
     *
     * @mbggenerated
     */
    public String getState() {
        return state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms_settings.STATE
     *
     * @param state the value for sms_settings.STATE
     *
     * @mbggenerated
     */
    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }


    public String getSignValue() {
        return signValue;
    }

    public void setSignValue(String signValue) {
        this.signValue = signValue;
    }

    public String getSignPosition() {
        return signPosition;
    }

    public void setSignPosition(String signPosition) {
        this.signPosition = signPosition;
    }
}