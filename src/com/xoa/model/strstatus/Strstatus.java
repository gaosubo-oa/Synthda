package com.xoa.model.strstatus;

public class Strstatus {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column str_status.ID
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column str_status.CONTENT
     *
     * @mbggenerated
     */
    private String content;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column str_status.STATE
     *
     * @mbggenerated
     */
    private String state;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column str_status.STRING_SQL
     *
     * @mbggenerated
     */
    private String stringSql;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column str_status.ID
     *
     * @return the value of str_status.ID
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column str_status.ID
     *
     * @param id the value for str_status.ID
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column str_status.CONTENT
     *
     * @return the value of str_status.CONTENT
     *
     * @mbggenerated
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column str_status.CONTENT
     *
     * @param content the value for str_status.CONTENT
     *
     * @mbggenerated
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column str_status.STATE
     *
     * @return the value of str_status.STATE
     *
     * @mbggenerated
     */
    public String getState() {
        return state;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column str_status.STATE
     *
     * @param state the value for str_status.STATE
     *
     * @mbggenerated
     */
    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column str_status.STRING_SQL
     *
     * @return the value of str_status.STRING_SQL
     *
     * @mbggenerated
     */
    public String getStringSql() {
        return stringSql;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column str_status.STRING_SQL
     *
     * @param stringSql the value for str_status.STRING_SQL
     *
     * @mbggenerated
     */
    public void setStringSql(String stringSql) {
        this.stringSql = stringSql == null ? null : stringSql.trim();
    }
}