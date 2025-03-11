package com.xoa.model.weather;

/**
 * Created by gsb on 2017/7/13.
 */
public class OneDayWeatherInf {
    private String location;
    private String date;
    private String week;
    private String tempertureOfDay;
    private String tempertureNow;
    private String wind;
    private String weather;
    private String picture;
    private Integer pmTwoPointFive;
    private String weihao ;
    private String tempertureMax;
    private String tempertureMin;
    private String aqi;
    private String cityName;

    public OneDayWeatherInf() {

        location = "";
        date = "";
        week = "";
        tempertureOfDay = "";
        tempertureNow = "";
        wind = "";
        weather = "";
        picture = "undefined";
        pmTwoPointFive = 0;
        tempertureMax = "";
        tempertureMin = "";
        aqi = "";
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getAqi() {
        return aqi;
    }

    public void setAqi(String aqi) {
        this.aqi = aqi;
    }

    public String getTempertureMax() {
        return tempertureMax;
    }

    public void setTempertureMax(String tempertureMax) {
        this.tempertureMax = tempertureMax;
    }

    public String getTempertureMin() {
        return tempertureMin;
    }

    public void setTempertureMin(String tempertureMin) {
        this.tempertureMin = tempertureMin;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getTempertureOfDay() {
        return tempertureOfDay;
    }

    public void setTempertureOfDay(String tempertureOfDay) {
        this.tempertureOfDay = tempertureOfDay;
    }

    public String getTempertureNow() {
        return tempertureNow;
    }

    public void setTempertureNow(String tempertureNow) {
        this.tempertureNow = tempertureNow;
    }

    public String getWind() {
        return wind;
    }

    public void setWind(String wind) {
        this.wind = wind;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getPmTwoPointFive() {
        return pmTwoPointFive;
    }

    public void setPmTwoPointFive(int pmTwoPointFive) {
        this.pmTwoPointFive = pmTwoPointFive;
    }

    public String getWeihao() {
        return weihao;
    }

    public void setWeihao(String weihao) {
        this.weihao = weihao;
    }

}
