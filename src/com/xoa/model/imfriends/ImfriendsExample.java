package com.xoa.model.imfriends;

import java.util.ArrayList;
import java.util.List;

public class ImfriendsExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public ImfriendsExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
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
     * This method corresponds to the database table im_friends
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
     * This method corresponds to the database table im_friends
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table im_friends
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
     * This class corresponds to the database table im_friends
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

        public Criteria andFrdIdIsNull() {
            addCriterion("FRD_ID is null");
            return (Criteria) this;
        }

        public Criteria andFrdIdIsNotNull() {
            addCriterion("FRD_ID is not null");
            return (Criteria) this;
        }

        public Criteria andFrdIdEqualTo(Integer value) {
            addCriterion("FRD_ID =", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdNotEqualTo(Integer value) {
            addCriterion("FRD_ID <>", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdGreaterThan(Integer value) {
            addCriterion("FRD_ID >", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("FRD_ID >=", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdLessThan(Integer value) {
            addCriterion("FRD_ID <", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdLessThanOrEqualTo(Integer value) {
            addCriterion("FRD_ID <=", value, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdIn(List<Integer> values) {
            addCriterion("FRD_ID in", values, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdNotIn(List<Integer> values) {
            addCriterion("FRD_ID not in", values, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdBetween(Integer value1, Integer value2) {
            addCriterion("FRD_ID between", value1, value2, "frdId");
            return (Criteria) this;
        }

        public Criteria andFrdIdNotBetween(Integer value1, Integer value2) {
            addCriterion("FRD_ID not between", value1, value2, "frdId");
            return (Criteria) this;
        }

        public Criteria andUidIsNull() {
            addCriterion("UID is null");
            return (Criteria) this;
        }

        public Criteria andUidIsNotNull() {
            addCriterion("UID is not null");
            return (Criteria) this;
        }

        public Criteria andUidEqualTo(Integer value) {
            addCriterion("UID =", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidNotEqualTo(Integer value) {
            addCriterion("UID <>", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidGreaterThan(Integer value) {
            addCriterion("UID >", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidGreaterThanOrEqualTo(Integer value) {
            addCriterion("UID >=", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidLessThan(Integer value) {
            addCriterion("UID <", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidLessThanOrEqualTo(Integer value) {
            addCriterion("UID <=", value, "uid");
            return (Criteria) this;
        }

        public Criteria andUidIn(List<Integer> values) {
            addCriterion("UID in", values, "uid");
            return (Criteria) this;
        }

        public Criteria andUidNotIn(List<Integer> values) {
            addCriterion("UID not in", values, "uid");
            return (Criteria) this;
        }

        public Criteria andUidBetween(Integer value1, Integer value2) {
            addCriterion("UID between", value1, value2, "uid");
            return (Criteria) this;
        }

        public Criteria andUidNotBetween(Integer value1, Integer value2) {
            addCriterion("UID not between", value1, value2, "uid");
            return (Criteria) this;
        }

        public Criteria andFuidIsNull() {
            addCriterion("FUID is null");
            return (Criteria) this;
        }

        public Criteria andFuidIsNotNull() {
            addCriterion("FUID is not null");
            return (Criteria) this;
        }

        public Criteria andFuidEqualTo(Integer value) {
            addCriterion("FUID =", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidNotEqualTo(Integer value) {
            addCriterion("FUID <>", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidGreaterThan(Integer value) {
            addCriterion("FUID >", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidGreaterThanOrEqualTo(Integer value) {
            addCriterion("FUID >=", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidLessThan(Integer value) {
            addCriterion("FUID <", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidLessThanOrEqualTo(Integer value) {
            addCriterion("FUID <=", value, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidIn(List<Integer> values) {
            addCriterion("FUID in", values, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidNotIn(List<Integer> values) {
            addCriterion("FUID not in", values, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidBetween(Integer value1, Integer value2) {
            addCriterion("FUID between", value1, value2, "fuid");
            return (Criteria) this;
        }

        public Criteria andFuidNotBetween(Integer value1, Integer value2) {
            addCriterion("FUID not between", value1, value2, "fuid");
            return (Criteria) this;
        }

        public Criteria andMessageIsNull() {
            addCriterion("MESSAGE is null");
            return (Criteria) this;
        }

        public Criteria andMessageIsNotNull() {
            addCriterion("MESSAGE is not null");
            return (Criteria) this;
        }

        public Criteria andMessageEqualTo(String value) {
            addCriterion("MESSAGE =", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageNotEqualTo(String value) {
            addCriterion("MESSAGE <>", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageGreaterThan(String value) {
            addCriterion("MESSAGE >", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageGreaterThanOrEqualTo(String value) {
            addCriterion("MESSAGE >=", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageLessThan(String value) {
            addCriterion("MESSAGE <", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageLessThanOrEqualTo(String value) {
            addCriterion("MESSAGE <=", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageLike(String value) {
            addCriterion("MESSAGE like", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageNotLike(String value) {
            addCriterion("MESSAGE not like", value, "message");
            return (Criteria) this;
        }

        public Criteria andMessageIn(List<String> values) {
            addCriterion("MESSAGE in", values, "message");
            return (Criteria) this;
        }

        public Criteria andMessageNotIn(List<String> values) {
            addCriterion("MESSAGE not in", values, "message");
            return (Criteria) this;
        }

        public Criteria andMessageBetween(String value1, String value2) {
            addCriterion("MESSAGE between", value1, value2, "message");
            return (Criteria) this;
        }

        public Criteria andMessageNotBetween(String value1, String value2) {
            addCriterion("MESSAGE not between", value1, value2, "message");
            return (Criteria) this;
        }

        public Criteria andPassIsNull() {
            addCriterion("PASS is null");
            return (Criteria) this;
        }

        public Criteria andPassIsNotNull() {
            addCriterion("PASS is not null");
            return (Criteria) this;
        }

        public Criteria andPassEqualTo(Integer value) {
            addCriterion("PASS =", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassNotEqualTo(Integer value) {
            addCriterion("PASS <>", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassGreaterThan(Integer value) {
            addCriterion("PASS >", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassGreaterThanOrEqualTo(Integer value) {
            addCriterion("PASS >=", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassLessThan(Integer value) {
            addCriterion("PASS <", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassLessThanOrEqualTo(Integer value) {
            addCriterion("PASS <=", value, "pass");
            return (Criteria) this;
        }

        public Criteria andPassIn(List<Integer> values) {
            addCriterion("PASS in", values, "pass");
            return (Criteria) this;
        }

        public Criteria andPassNotIn(List<Integer> values) {
            addCriterion("PASS not in", values, "pass");
            return (Criteria) this;
        }

        public Criteria andPassBetween(Integer value1, Integer value2) {
            addCriterion("PASS between", value1, value2, "pass");
            return (Criteria) this;
        }

        public Criteria andPassNotBetween(Integer value1, Integer value2) {
            addCriterion("PASS not between", value1, value2, "pass");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table im_friends
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
     * This class corresponds to the database table im_friends
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