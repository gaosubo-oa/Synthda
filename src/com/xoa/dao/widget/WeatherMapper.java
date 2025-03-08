package com.xoa.dao.widget;

import com.xoa.model.widget.Weather;
import com.xoa.model.widget.WeatherExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WeatherMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int countByExample(WeatherExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int deleteByExample(WeatherExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer wid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int insert(Weather record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int insertSelective(Weather record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    List<Weather> selectByExample(WeatherExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    Weather selectByPrimaryKey(Integer wid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") Weather record, @Param("example") WeatherExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") Weather record, @Param("example") WeatherExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Weather record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Weather record);

    List<Weather> selectAll();

    /**
     * @作者: 张航宁
     * @时间: 2019/7/9
     * @说明: 根据时间和地区查询当天的天气
     */
    Weather selLocationWeather(@Param("location") String location);

    void insertWeather(Weather weatherModel);
}