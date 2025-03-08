package com.xoa.model.verification.MobileVerify;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MobileVerifyExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public MobileVerifyExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
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
     * This method corresponds to the database table mobile_verify
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
     * This method corresponds to the database table mobile_verify
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table mobile_verify
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
     * This class corresponds to the database table mobile_verify
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

        public Criteria andVerifyIdIsNull() {
            addCriterion("VERIFY_ID is null");
            return (Criteria) this;
        }

        public Criteria andVerifyIdIsNotNull() {
            addCriterion("VERIFY_ID is not null");
            return (Criteria) this;
        }

        public Criteria andVerifyIdEqualTo(Integer value) {
            addCriterion("VERIFY_ID =", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdNotEqualTo(Integer value) {
            addCriterion("VERIFY_ID <>", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdGreaterThan(Integer value) {
            addCriterion("VERIFY_ID >", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("VERIFY_ID >=", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdLessThan(Integer value) {
            addCriterion("VERIFY_ID <", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdLessThanOrEqualTo(Integer value) {
            addCriterion("VERIFY_ID <=", value, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdIn(List<Integer> values) {
            addCriterion("VERIFY_ID in", values, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdNotIn(List<Integer> values) {
            addCriterion("VERIFY_ID not in", values, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdBetween(Integer value1, Integer value2) {
            addCriterion("VERIFY_ID between", value1, value2, "verifyId");
            return (Criteria) this;
        }

        public Criteria andVerifyIdNotBetween(Integer value1, Integer value2) {
            addCriterion("VERIFY_ID not between", value1, value2, "verifyId");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNull() {
            addCriterion("USER_ID is null");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNotNull() {
            addCriterion("USER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andUserIdEqualTo(String value) {
            addCriterion("USER_ID =", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotEqualTo(String value) {
            addCriterion("USER_ID <>", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThan(String value) {
            addCriterion("USER_ID >", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThanOrEqualTo(String value) {
            addCriterion("USER_ID >=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThan(String value) {
            addCriterion("USER_ID <", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThanOrEqualTo(String value) {
            addCriterion("USER_ID <=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLike(String value) {
            addCriterion("USER_ID like", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotLike(String value) {
            addCriterion("USER_ID not like", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdIn(List<String> values) {
            addCriterion("USER_ID in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotIn(List<String> values) {
            addCriterion("USER_ID not in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdBetween(String value1, String value2) {
            addCriterion("USER_ID between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotBetween(String value1, String value2) {
            addCriterion("USER_ID not between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andMobilNoIsNull() {
            addCriterion("MOBIL_NO is null");
            return (Criteria) this;
        }

        public Criteria andMobilNoIsNotNull() {
            addCriterion("MOBIL_NO is not null");
            return (Criteria) this;
        }

        public Criteria andMobilNoEqualTo(String value) {
            addCriterion("MOBIL_NO =", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoNotEqualTo(String value) {
            addCriterion("MOBIL_NO <>", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoGreaterThan(String value) {
            addCriterion("MOBIL_NO >", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoGreaterThanOrEqualTo(String value) {
            addCriterion("MOBIL_NO >=", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoLessThan(String value) {
            addCriterion("MOBIL_NO <", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoLessThanOrEqualTo(String value) {
            addCriterion("MOBIL_NO <=", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoLike(String value) {
            addCriterion("MOBIL_NO like", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoNotLike(String value) {
            addCriterion("MOBIL_NO not like", value, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoIn(List<String> values) {
            addCriterion("MOBIL_NO in", values, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoNotIn(List<String> values) {
            addCriterion("MOBIL_NO not in", values, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoBetween(String value1, String value2) {
            addCriterion("MOBIL_NO between", value1, value2, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andMobilNoNotBetween(String value1, String value2) {
            addCriterion("MOBIL_NO not between", value1, value2, "mobilNo");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeIsNull() {
            addCriterion("VERIFY_CODE is null");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeIsNotNull() {
            addCriterion("VERIFY_CODE is not null");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeEqualTo(String value) {
            addCriterion("VERIFY_CODE =", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeNotEqualTo(String value) {
            addCriterion("VERIFY_CODE <>", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeGreaterThan(String value) {
            addCriterion("VERIFY_CODE >", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeGreaterThanOrEqualTo(String value) {
            addCriterion("VERIFY_CODE >=", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeLessThan(String value) {
            addCriterion("VERIFY_CODE <", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeLessThanOrEqualTo(String value) {
            addCriterion("VERIFY_CODE <=", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeLike(String value) {
            addCriterion("VERIFY_CODE like", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeNotLike(String value) {
            addCriterion("VERIFY_CODE not like", value, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeIn(List<String> values) {
            addCriterion("VERIFY_CODE in", values, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeNotIn(List<String> values) {
            addCriterion("VERIFY_CODE not in", values, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeBetween(String value1, String value2) {
            addCriterion("VERIFY_CODE between", value1, value2, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andVerifyCodeNotBetween(String value1, String value2) {
            addCriterion("VERIFY_CODE not between", value1, value2, "verifyCode");
            return (Criteria) this;
        }

        public Criteria andCodeTimeIsNull() {
            addCriterion("CODE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andCodeTimeIsNotNull() {
            addCriterion("CODE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andCodeTimeEqualTo(Date value) {
            addCriterion("CODE_TIME =", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeNotEqualTo(Date value) {
            addCriterion("CODE_TIME <>", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeGreaterThan(Date value) {
            addCriterion("CODE_TIME >", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("CODE_TIME >=", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeLessThan(Date value) {
            addCriterion("CODE_TIME <", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeLessThanOrEqualTo(Date value) {
            addCriterion("CODE_TIME <=", value, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeIn(List<Date> values) {
            addCriterion("CODE_TIME in", values, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeNotIn(List<Date> values) {
            addCriterion("CODE_TIME not in", values, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeBetween(Date value1, Date value2) {
            addCriterion("CODE_TIME between", value1, value2, "codeTime");
            return (Criteria) this;
        }

        public Criteria andCodeTimeNotBetween(Date value1, Date value2) {
            addCriterion("CODE_TIME not between", value1, value2, "codeTime");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table mobile_verify
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
     * This class corresponds to the database table mobile_verify
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