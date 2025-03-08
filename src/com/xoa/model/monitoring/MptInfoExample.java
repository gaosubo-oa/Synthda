package com.xoa.model.monitoring;

import java.util.ArrayList;
import java.util.List;

public class MptInfoExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public MptInfoExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
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
     * This method corresponds to the database table mpt_info
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
     * This method corresponds to the database table mpt_info
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mpt_info
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
     * This class corresponds to the database table mpt_info
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

        public Criteria andMptIdIsNull() {
            addCriterion("MPT_ID is null");
            return (Criteria) this;
        }

        public Criteria andMptIdIsNotNull() {
            addCriterion("MPT_ID is not null");
            return (Criteria) this;
        }

        public Criteria andMptIdEqualTo(Integer value) {
            addCriterion("MPT_ID =", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdNotEqualTo(Integer value) {
            addCriterion("MPT_ID <>", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdGreaterThan(Integer value) {
            addCriterion("MPT_ID >", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("MPT_ID >=", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdLessThan(Integer value) {
            addCriterion("MPT_ID <", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdLessThanOrEqualTo(Integer value) {
            addCriterion("MPT_ID <=", value, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdIn(List<Integer> values) {
            addCriterion("MPT_ID in", values, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdNotIn(List<Integer> values) {
            addCriterion("MPT_ID not in", values, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdBetween(Integer value1, Integer value2) {
            addCriterion("MPT_ID between", value1, value2, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptIdNotBetween(Integer value1, Integer value2) {
            addCriterion("MPT_ID not between", value1, value2, "mptId");
            return (Criteria) this;
        }

        public Criteria andMptNameIsNull() {
            addCriterion("MPT_NAME is null");
            return (Criteria) this;
        }

        public Criteria andMptNameIsNotNull() {
            addCriterion("MPT_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andMptNameEqualTo(String value) {
            addCriterion("MPT_NAME =", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameNotEqualTo(String value) {
            addCriterion("MPT_NAME <>", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameGreaterThan(String value) {
            addCriterion("MPT_NAME >", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameGreaterThanOrEqualTo(String value) {
            addCriterion("MPT_NAME >=", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameLessThan(String value) {
            addCriterion("MPT_NAME <", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameLessThanOrEqualTo(String value) {
            addCriterion("MPT_NAME <=", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameLike(String value) {
            addCriterion("MPT_NAME like", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameNotLike(String value) {
            addCriterion("MPT_NAME not like", value, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameIn(List<String> values) {
            addCriterion("MPT_NAME in", values, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameNotIn(List<String> values) {
            addCriterion("MPT_NAME not in", values, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameBetween(String value1, String value2) {
            addCriterion("MPT_NAME between", value1, value2, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNameNotBetween(String value1, String value2) {
            addCriterion("MPT_NAME not between", value1, value2, "mptName");
            return (Criteria) this;
        }

        public Criteria andMptNoIsNull() {
            addCriterion("MPT_NO is null");
            return (Criteria) this;
        }

        public Criteria andMptNoIsNotNull() {
            addCriterion("MPT_NO is not null");
            return (Criteria) this;
        }

        public Criteria andMptNoEqualTo(String value) {
            addCriterion("MPT_NO =", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoNotEqualTo(String value) {
            addCriterion("MPT_NO <>", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoGreaterThan(String value) {
            addCriterion("MPT_NO >", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoGreaterThanOrEqualTo(String value) {
            addCriterion("MPT_NO >=", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoLessThan(String value) {
            addCriterion("MPT_NO <", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoLessThanOrEqualTo(String value) {
            addCriterion("MPT_NO <=", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoLike(String value) {
            addCriterion("MPT_NO like", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoNotLike(String value) {
            addCriterion("MPT_NO not like", value, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoIn(List<String> values) {
            addCriterion("MPT_NO in", values, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoNotIn(List<String> values) {
            addCriterion("MPT_NO not in", values, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoBetween(String value1, String value2) {
            addCriterion("MPT_NO between", value1, value2, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptNoNotBetween(String value1, String value2) {
            addCriterion("MPT_NO not between", value1, value2, "mptNo");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeIsNull() {
            addCriterion("MPT_LONGITUDE is null");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeIsNotNull() {
            addCriterion("MPT_LONGITUDE is not null");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeEqualTo(String value) {
            addCriterion("MPT_LONGITUDE =", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeNotEqualTo(String value) {
            addCriterion("MPT_LONGITUDE <>", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeGreaterThan(String value) {
            addCriterion("MPT_LONGITUDE >", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeGreaterThanOrEqualTo(String value) {
            addCriterion("MPT_LONGITUDE >=", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeLessThan(String value) {
            addCriterion("MPT_LONGITUDE <", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeLessThanOrEqualTo(String value) {
            addCriterion("MPT_LONGITUDE <=", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeLike(String value) {
            addCriterion("MPT_LONGITUDE like", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeNotLike(String value) {
            addCriterion("MPT_LONGITUDE not like", value, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeIn(List<String> values) {
            addCriterion("MPT_LONGITUDE in", values, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeNotIn(List<String> values) {
            addCriterion("MPT_LONGITUDE not in", values, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeBetween(String value1, String value2) {
            addCriterion("MPT_LONGITUDE between", value1, value2, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLongitudeNotBetween(String value1, String value2) {
            addCriterion("MPT_LONGITUDE not between", value1, value2, "mptLongitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeIsNull() {
            addCriterion("MPT_LATITUDE is null");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeIsNotNull() {
            addCriterion("MPT_LATITUDE is not null");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeEqualTo(String value) {
            addCriterion("MPT_LATITUDE =", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeNotEqualTo(String value) {
            addCriterion("MPT_LATITUDE <>", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeGreaterThan(String value) {
            addCriterion("MPT_LATITUDE >", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeGreaterThanOrEqualTo(String value) {
            addCriterion("MPT_LATITUDE >=", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeLessThan(String value) {
            addCriterion("MPT_LATITUDE <", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeLessThanOrEqualTo(String value) {
            addCriterion("MPT_LATITUDE <=", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeLike(String value) {
            addCriterion("MPT_LATITUDE like", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeNotLike(String value) {
            addCriterion("MPT_LATITUDE not like", value, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeIn(List<String> values) {
            addCriterion("MPT_LATITUDE in", values, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeNotIn(List<String> values) {
            addCriterion("MPT_LATITUDE not in", values, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeBetween(String value1, String value2) {
            addCriterion("MPT_LATITUDE between", value1, value2, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptLatitudeNotBetween(String value1, String value2) {
            addCriterion("MPT_LATITUDE not between", value1, value2, "mptLatitude");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionIsNull() {
            addCriterion("MPT_BELONG_REGION is null");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionIsNotNull() {
            addCriterion("MPT_BELONG_REGION is not null");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionEqualTo(String value) {
            addCriterion("MPT_BELONG_REGION =", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionNotEqualTo(String value) {
            addCriterion("MPT_BELONG_REGION <>", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionGreaterThan(String value) {
            addCriterion("MPT_BELONG_REGION >", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionGreaterThanOrEqualTo(String value) {
            addCriterion("MPT_BELONG_REGION >=", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionLessThan(String value) {
            addCriterion("MPT_BELONG_REGION <", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionLessThanOrEqualTo(String value) {
            addCriterion("MPT_BELONG_REGION <=", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionLike(String value) {
            addCriterion("MPT_BELONG_REGION like", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionNotLike(String value) {
            addCriterion("MPT_BELONG_REGION not like", value, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionIn(List<String> values) {
            addCriterion("MPT_BELONG_REGION in", values, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionNotIn(List<String> values) {
            addCriterion("MPT_BELONG_REGION not in", values, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionBetween(String value1, String value2) {
            addCriterion("MPT_BELONG_REGION between", value1, value2, "mptBelongRegion");
            return (Criteria) this;
        }

        public Criteria andMptBelongRegionNotBetween(String value1, String value2) {
            addCriterion("MPT_BELONG_REGION not between", value1, value2, "mptBelongRegion");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table mpt_info
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
     * This class corresponds to the database table mpt_info
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