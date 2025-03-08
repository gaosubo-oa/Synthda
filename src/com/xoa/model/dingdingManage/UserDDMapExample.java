package com.xoa.model.dingdingManage;

import java.util.ArrayList;
import java.util.List;

public class UserDDMapExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public UserDDMapExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
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
     * This method corresponds to the database table user_dd_map
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
     * This method corresponds to the database table user_dd_map
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_dd_map
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
     * This class corresponds to the database table user_dd_map
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

        public Criteria andOaUidIsNull() {
            addCriterion("OA_UID is null");
            return (Criteria) this;
        }

        public Criteria andOaUidIsNotNull() {
            addCriterion("OA_UID is not null");
            return (Criteria) this;
        }

        public Criteria andOaUidEqualTo(String value) {
            addCriterion("OA_UID =", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidNotEqualTo(String value) {
            addCriterion("OA_UID <>", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidGreaterThan(String value) {
            addCriterion("OA_UID >", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidGreaterThanOrEqualTo(String value) {
            addCriterion("OA_UID >=", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidLessThan(String value) {
            addCriterion("OA_UID <", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidLessThanOrEqualTo(String value) {
            addCriterion("OA_UID <=", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidLike(String value) {
            addCriterion("OA_UID like", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidNotLike(String value) {
            addCriterion("OA_UID not like", value, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidIn(List<String> values) {
            addCriterion("OA_UID in", values, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidNotIn(List<String> values) {
            addCriterion("OA_UID not in", values, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidBetween(String value1, String value2) {
            addCriterion("OA_UID between", value1, value2, "oaUid");
            return (Criteria) this;
        }

        public Criteria andOaUidNotBetween(String value1, String value2) {
            addCriterion("OA_UID not between", value1, value2, "oaUid");
            return (Criteria) this;
        }

        public Criteria andDdUidIsNull() {
            addCriterion("DD_UID is null");
            return (Criteria) this;
        }

        public Criteria andDdUidIsNotNull() {
            addCriterion("DD_UID is not null");
            return (Criteria) this;
        }

        public Criteria andDdUidEqualTo(String value) {
            addCriterion("DD_UID =", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidNotEqualTo(String value) {
            addCriterion("DD_UID <>", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidGreaterThan(String value) {
            addCriterion("DD_UID >", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidGreaterThanOrEqualTo(String value) {
            addCriterion("DD_UID >=", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidLessThan(String value) {
            addCriterion("DD_UID <", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidLessThanOrEqualTo(String value) {
            addCriterion("DD_UID <=", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidLike(String value) {
            addCriterion("DD_UID like", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidNotLike(String value) {
            addCriterion("DD_UID not like", value, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidIn(List<String> values) {
            addCriterion("DD_UID in", values, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidNotIn(List<String> values) {
            addCriterion("DD_UID not in", values, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidBetween(String value1, String value2) {
            addCriterion("DD_UID between", value1, value2, "ddUid");
            return (Criteria) this;
        }

        public Criteria andDdUidNotBetween(String value1, String value2) {
            addCriterion("DD_UID not between", value1, value2, "ddUid");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table user_dd_map
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
     * This class corresponds to the database table user_dd_map
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