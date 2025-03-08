package com.xoa.model.widget;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class WeatherExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table weather
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table weather
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table weather
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public WeatherExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table weather
     *
     * @mbggenerated
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table weather
     *
     * @mbggenerated
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andWidIsNull() {
            addCriterion("wid is null");
            return (Criteria) this;
        }

        public Criteria andWidIsNotNull() {
            addCriterion("wid is not null");
            return (Criteria) this;
        }

        public Criteria andWidEqualTo(Integer value) {
            addCriterion("wid =", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidNotEqualTo(Integer value) {
            addCriterion("wid <>", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidGreaterThan(Integer value) {
            addCriterion("wid >", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidGreaterThanOrEqualTo(Integer value) {
            addCriterion("wid >=", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidLessThan(Integer value) {
            addCriterion("wid <", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidLessThanOrEqualTo(Integer value) {
            addCriterion("wid <=", value, "wid");
            return (Criteria) this;
        }

        public Criteria andWidIn(List<Integer> values) {
            addCriterion("wid in", values, "wid");
            return (Criteria) this;
        }

        public Criteria andWidNotIn(List<Integer> values) {
            addCriterion("wid not in", values, "wid");
            return (Criteria) this;
        }

        public Criteria andWidBetween(Integer value1, Integer value2) {
            addCriterion("wid between", value1, value2, "wid");
            return (Criteria) this;
        }

        public Criteria andWidNotBetween(Integer value1, Integer value2) {
            addCriterion("wid not between", value1, value2, "wid");
            return (Criteria) this;
        }

        public Criteria andDateIsNull() {
            addCriterion("date is null");
            return (Criteria) this;
        }

        public Criteria andDateIsNotNull() {
            addCriterion("date is not null");
            return (Criteria) this;
        }

        public Criteria andDateEqualTo(Date value) {
            addCriterion("date =", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateNotEqualTo(Date value) {
            addCriterion("date <>", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateGreaterThan(Date value) {
            addCriterion("date >", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateGreaterThanOrEqualTo(Date value) {
            addCriterion("date >=", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateLessThan(Date value) {
            addCriterion("date <", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateLessThanOrEqualTo(Date value) {
            addCriterion("date <=", value, "date");
            return (Criteria) this;
        }

        public Criteria andDateIn(List<Date> values) {
            addCriterion("date in", values, "date");
            return (Criteria) this;
        }

        public Criteria andDateNotIn(List<Date> values) {
            addCriterion("date not in", values, "date");
            return (Criteria) this;
        }

        public Criteria andDateBetween(Date value1, Date value2) {
            addCriterion("date between", value1, value2, "date");
            return (Criteria) this;
        }

        public Criteria andDateNotBetween(Date value1, Date value2) {
            addCriterion("date not between", value1, value2, "date");
            return (Criteria) this;
        }

        public Criteria andDatecomenIsNull() {
            addCriterion("dateComen is null");
            return (Criteria) this;
        }

        public Criteria andDatecomenIsNotNull() {
            addCriterion("dateComen is not null");
            return (Criteria) this;
        }

        public Criteria andDatecomenEqualTo(Date value) {
            addCriterion("dateComen =", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenNotEqualTo(Date value) {
            addCriterion("dateComen <>", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenGreaterThan(Date value) {
            addCriterion("dateComen >", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenGreaterThanOrEqualTo(Date value) {
            addCriterion("dateComen >=", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenLessThan(Date value) {
            addCriterion("dateComen <", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenLessThanOrEqualTo(Date value) {
            addCriterion("dateComen <=", value, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenIn(List<Date> values) {
            addCriterion("dateComen in", values, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenNotIn(List<Date> values) {
            addCriterion("dateComen not in", values, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenBetween(Date value1, Date value2) {
            addCriterion("dateComen between", value1, value2, "datecomen");
            return (Criteria) this;
        }

        public Criteria andDatecomenNotBetween(Date value1, Date value2) {
            addCriterion("dateComen not between", value1, value2, "datecomen");
            return (Criteria) this;
        }

        public Criteria andLocationIsNull() {
            addCriterion("location is null");
            return (Criteria) this;
        }

        public Criteria andLocationIsNotNull() {
            addCriterion("location is not null");
            return (Criteria) this;
        }

        public Criteria andLocationEqualTo(String value) {
            addCriterion("location =", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationNotEqualTo(String value) {
            addCriterion("location <>", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationGreaterThan(String value) {
            addCriterion("location >", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationGreaterThanOrEqualTo(String value) {
            addCriterion("location >=", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationLessThan(String value) {
            addCriterion("location <", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationLessThanOrEqualTo(String value) {
            addCriterion("location <=", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationLike(String value) {
            addCriterion("location like", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationNotLike(String value) {
            addCriterion("location not like", value, "location");
            return (Criteria) this;
        }

        public Criteria andLocationIn(List<String> values) {
            addCriterion("location in", values, "location");
            return (Criteria) this;
        }

        public Criteria andLocationNotIn(List<String> values) {
            addCriterion("location not in", values, "location");
            return (Criteria) this;
        }

        public Criteria andLocationBetween(String value1, String value2) {
            addCriterion("location between", value1, value2, "location");
            return (Criteria) this;
        }

        public Criteria andLocationNotBetween(String value1, String value2) {
            addCriterion("location not between", value1, value2, "location");
            return (Criteria) this;
        }

        public Criteria andWeatherIsNull() {
            addCriterion("weather is null");
            return (Criteria) this;
        }

        public Criteria andWeatherIsNotNull() {
            addCriterion("weather is not null");
            return (Criteria) this;
        }

        public Criteria andWeatherEqualTo(String value) {
            addCriterion("weather =", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherNotEqualTo(String value) {
            addCriterion("weather <>", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherGreaterThan(String value) {
            addCriterion("weather >", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherGreaterThanOrEqualTo(String value) {
            addCriterion("weather >=", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherLessThan(String value) {
            addCriterion("weather <", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherLessThanOrEqualTo(String value) {
            addCriterion("weather <=", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherLike(String value) {
            addCriterion("weather like", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherNotLike(String value) {
            addCriterion("weather not like", value, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherIn(List<String> values) {
            addCriterion("weather in", values, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherNotIn(List<String> values) {
            addCriterion("weather not in", values, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherBetween(String value1, String value2) {
            addCriterion("weather between", value1, value2, "weather");
            return (Criteria) this;
        }

        public Criteria andWeatherNotBetween(String value1, String value2) {
            addCriterion("weather not between", value1, value2, "weather");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveIsNull() {
            addCriterion("pmTwoPointFive is null");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveIsNotNull() {
            addCriterion("pmTwoPointFive is not null");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveEqualTo(String value) {
            addCriterion("pmTwoPointFive =", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveNotEqualTo(String value) {
            addCriterion("pmTwoPointFive <>", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveGreaterThan(String value) {
            addCriterion("pmTwoPointFive >", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveGreaterThanOrEqualTo(String value) {
            addCriterion("pmTwoPointFive >=", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveLessThan(String value) {
            addCriterion("pmTwoPointFive <", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveLessThanOrEqualTo(String value) {
            addCriterion("pmTwoPointFive <=", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveLike(String value) {
            addCriterion("pmTwoPointFive like", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveNotLike(String value) {
            addCriterion("pmTwoPointFive not like", value, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveIn(List<String> values) {
            addCriterion("pmTwoPointFive in", values, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveNotIn(List<String> values) {
            addCriterion("pmTwoPointFive not in", values, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveBetween(String value1, String value2) {
            addCriterion("pmTwoPointFive between", value1, value2, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andPmtwopointfiveNotBetween(String value1, String value2) {
            addCriterion("pmTwoPointFive not between", value1, value2, "pmtwopointfive");
            return (Criteria) this;
        }

        public Criteria andTemperturenowIsNull() {
            addCriterion("tempertureNow is null");
            return (Criteria) this;
        }

        public Criteria andTemperturenowIsNotNull() {
            addCriterion("tempertureNow is not null");
            return (Criteria) this;
        }

        public Criteria andTemperturenowEqualTo(String value) {
            addCriterion("tempertureNow =", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowNotEqualTo(String value) {
            addCriterion("tempertureNow <>", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowGreaterThan(String value) {
            addCriterion("tempertureNow >", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowGreaterThanOrEqualTo(String value) {
            addCriterion("tempertureNow >=", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowLessThan(String value) {
            addCriterion("tempertureNow <", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowLessThanOrEqualTo(String value) {
            addCriterion("tempertureNow <=", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowLike(String value) {
            addCriterion("tempertureNow like", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowNotLike(String value) {
            addCriterion("tempertureNow not like", value, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowIn(List<String> values) {
            addCriterion("tempertureNow in", values, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowNotIn(List<String> values) {
            addCriterion("tempertureNow not in", values, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowBetween(String value1, String value2) {
            addCriterion("tempertureNow between", value1, value2, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTemperturenowNotBetween(String value1, String value2) {
            addCriterion("tempertureNow not between", value1, value2, "temperturenow");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayIsNull() {
            addCriterion("tempertureOfDay is null");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayIsNotNull() {
            addCriterion("tempertureOfDay is not null");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayEqualTo(String value) {
            addCriterion("tempertureOfDay =", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayNotEqualTo(String value) {
            addCriterion("tempertureOfDay <>", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayGreaterThan(String value) {
            addCriterion("tempertureOfDay >", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayGreaterThanOrEqualTo(String value) {
            addCriterion("tempertureOfDay >=", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayLessThan(String value) {
            addCriterion("tempertureOfDay <", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayLessThanOrEqualTo(String value) {
            addCriterion("tempertureOfDay <=", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayLike(String value) {
            addCriterion("tempertureOfDay like", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayNotLike(String value) {
            addCriterion("tempertureOfDay not like", value, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayIn(List<String> values) {
            addCriterion("tempertureOfDay in", values, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayNotIn(List<String> values) {
            addCriterion("tempertureOfDay not in", values, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayBetween(String value1, String value2) {
            addCriterion("tempertureOfDay between", value1, value2, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andTempertureofdayNotBetween(String value1, String value2) {
            addCriterion("tempertureOfDay not between", value1, value2, "tempertureofday");
            return (Criteria) this;
        }

        public Criteria andWeekIsNull() {
            addCriterion("week is null");
            return (Criteria) this;
        }

        public Criteria andWeekIsNotNull() {
            addCriterion("week is not null");
            return (Criteria) this;
        }

        public Criteria andWeekEqualTo(String value) {
            addCriterion("week =", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekNotEqualTo(String value) {
            addCriterion("week <>", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekGreaterThan(String value) {
            addCriterion("week >", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekGreaterThanOrEqualTo(String value) {
            addCriterion("week >=", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekLessThan(String value) {
            addCriterion("week <", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekLessThanOrEqualTo(String value) {
            addCriterion("week <=", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekLike(String value) {
            addCriterion("week like", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekNotLike(String value) {
            addCriterion("week not like", value, "week");
            return (Criteria) this;
        }

        public Criteria andWeekIn(List<String> values) {
            addCriterion("week in", values, "week");
            return (Criteria) this;
        }

        public Criteria andWeekNotIn(List<String> values) {
            addCriterion("week not in", values, "week");
            return (Criteria) this;
        }

        public Criteria andWeekBetween(String value1, String value2) {
            addCriterion("week between", value1, value2, "week");
            return (Criteria) this;
        }

        public Criteria andWeekNotBetween(String value1, String value2) {
            addCriterion("week not between", value1, value2, "week");
            return (Criteria) this;
        }

        public Criteria andWindIsNull() {
            addCriterion("wind is null");
            return (Criteria) this;
        }

        public Criteria andWindIsNotNull() {
            addCriterion("wind is not null");
            return (Criteria) this;
        }

        public Criteria andWindEqualTo(String value) {
            addCriterion("wind =", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindNotEqualTo(String value) {
            addCriterion("wind <>", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindGreaterThan(String value) {
            addCriterion("wind >", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindGreaterThanOrEqualTo(String value) {
            addCriterion("wind >=", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindLessThan(String value) {
            addCriterion("wind <", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindLessThanOrEqualTo(String value) {
            addCriterion("wind <=", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindLike(String value) {
            addCriterion("wind like", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindNotLike(String value) {
            addCriterion("wind not like", value, "wind");
            return (Criteria) this;
        }

        public Criteria andWindIn(List<String> values) {
            addCriterion("wind in", values, "wind");
            return (Criteria) this;
        }

        public Criteria andWindNotIn(List<String> values) {
            addCriterion("wind not in", values, "wind");
            return (Criteria) this;
        }

        public Criteria andWindBetween(String value1, String value2) {
            addCriterion("wind between", value1, value2, "wind");
            return (Criteria) this;
        }

        public Criteria andWindNotBetween(String value1, String value2) {
            addCriterion("wind not between", value1, value2, "wind");
            return (Criteria) this;
        }

        public Criteria andWeihaoIsNull() {
            addCriterion("weihao is null");
            return (Criteria) this;
        }

        public Criteria andWeihaoIsNotNull() {
            addCriterion("weihao is not null");
            return (Criteria) this;
        }

        public Criteria andWeihaoEqualTo(String value) {
            addCriterion("weihao =", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoNotEqualTo(String value) {
            addCriterion("weihao <>", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoGreaterThan(String value) {
            addCriterion("weihao >", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoGreaterThanOrEqualTo(String value) {
            addCriterion("weihao >=", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoLessThan(String value) {
            addCriterion("weihao <", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoLessThanOrEqualTo(String value) {
            addCriterion("weihao <=", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoLike(String value) {
            addCriterion("weihao like", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoNotLike(String value) {
            addCriterion("weihao not like", value, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoIn(List<String> values) {
            addCriterion("weihao in", values, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoNotIn(List<String> values) {
            addCriterion("weihao not in", values, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoBetween(String value1, String value2) {
            addCriterion("weihao between", value1, value2, "weihao");
            return (Criteria) this;
        }

        public Criteria andWeihaoNotBetween(String value1, String value2) {
            addCriterion("weihao not between", value1, value2, "weihao");
            return (Criteria) this;
        }

        public Criteria andPictureIsNull() {
            addCriterion("picture is null");
            return (Criteria) this;
        }

        public Criteria andPictureIsNotNull() {
            addCriterion("picture is not null");
            return (Criteria) this;
        }

        public Criteria andPictureEqualTo(String value) {
            addCriterion("picture =", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureNotEqualTo(String value) {
            addCriterion("picture <>", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureGreaterThan(String value) {
            addCriterion("picture >", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureGreaterThanOrEqualTo(String value) {
            addCriterion("picture >=", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureLessThan(String value) {
            addCriterion("picture <", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureLessThanOrEqualTo(String value) {
            addCriterion("picture <=", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureLike(String value) {
            addCriterion("picture like", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureNotLike(String value) {
            addCriterion("picture not like", value, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureIn(List<String> values) {
            addCriterion("picture in", values, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureNotIn(List<String> values) {
            addCriterion("picture not in", values, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureBetween(String value1, String value2) {
            addCriterion("picture between", value1, value2, "picture");
            return (Criteria) this;
        }

        public Criteria andPictureNotBetween(String value1, String value2) {
            addCriterion("picture not between", value1, value2, "picture");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table weather
     *
     * @mbggenerated do_not_delete_during_merge
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table weather
     *
     * @mbggenerated
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}