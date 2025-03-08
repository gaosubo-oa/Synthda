package com.xoa.model.infoCenter;

import java.util.ArrayList;
import java.util.List;

public class InfoCenterExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table info_center
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table info_center
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table info_center
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public InfoCenterExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
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
     * This method corresponds to the database table info_center
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
     * This method corresponds to the database table info_center
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table info_center
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
     * This class corresponds to the database table info_center
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

        public Criteria andInfoIdIsNull() {
            addCriterion("INFO_ID is null");
            return (Criteria) this;
        }

        public Criteria andInfoIdIsNotNull() {
            addCriterion("INFO_ID is not null");
            return (Criteria) this;
        }

        public Criteria andInfoIdEqualTo(Integer value) {
            addCriterion("INFO_ID =", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdNotEqualTo(Integer value) {
            addCriterion("INFO_ID <>", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdGreaterThan(Integer value) {
            addCriterion("INFO_ID >", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("INFO_ID >=", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdLessThan(Integer value) {
            addCriterion("INFO_ID <", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdLessThanOrEqualTo(Integer value) {
            addCriterion("INFO_ID <=", value, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdIn(List<Integer> values) {
            addCriterion("INFO_ID in", values, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdNotIn(List<Integer> values) {
            addCriterion("INFO_ID not in", values, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdBetween(Integer value1, Integer value2) {
            addCriterion("INFO_ID between", value1, value2, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoIdNotBetween(Integer value1, Integer value2) {
            addCriterion("INFO_ID not between", value1, value2, "infoId");
            return (Criteria) this;
        }

        public Criteria andInfoNoIsNull() {
            addCriterion("INFO_NO is null");
            return (Criteria) this;
        }

        public Criteria andInfoNoIsNotNull() {
            addCriterion("INFO_NO is not null");
            return (Criteria) this;
        }

        public Criteria andInfoNoEqualTo(Integer value) {
            addCriterion("INFO_NO =", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoNotEqualTo(Integer value) {
            addCriterion("INFO_NO <>", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoGreaterThan(Integer value) {
            addCriterion("INFO_NO >", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoGreaterThanOrEqualTo(Integer value) {
            addCriterion("INFO_NO >=", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoLessThan(Integer value) {
            addCriterion("INFO_NO <", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoLessThanOrEqualTo(Integer value) {
            addCriterion("INFO_NO <=", value, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoIn(List<Integer> values) {
            addCriterion("INFO_NO in", values, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoNotIn(List<Integer> values) {
            addCriterion("INFO_NO not in", values, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoBetween(Integer value1, Integer value2) {
            addCriterion("INFO_NO between", value1, value2, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoNoNotBetween(Integer value1, Integer value2) {
            addCriterion("INFO_NO not between", value1, value2, "infoNo");
            return (Criteria) this;
        }

        public Criteria andInfoName1IsNull() {
            addCriterion("INFO_NAME1 is null");
            return (Criteria) this;
        }

        public Criteria andInfoName1IsNotNull() {
            addCriterion("INFO_NAME1 is not null");
            return (Criteria) this;
        }

        public Criteria andInfoName1EqualTo(String value) {
            addCriterion("INFO_NAME1 =", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1NotEqualTo(String value) {
            addCriterion("INFO_NAME1 <>", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1GreaterThan(String value) {
            addCriterion("INFO_NAME1 >", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1GreaterThanOrEqualTo(String value) {
            addCriterion("INFO_NAME1 >=", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1LessThan(String value) {
            addCriterion("INFO_NAME1 <", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1LessThanOrEqualTo(String value) {
            addCriterion("INFO_NAME1 <=", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1Like(String value) {
            addCriterion("INFO_NAME1 like", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1NotLike(String value) {
            addCriterion("INFO_NAME1 not like", value, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1In(List<String> values) {
            addCriterion("INFO_NAME1 in", values, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1NotIn(List<String> values) {
            addCriterion("INFO_NAME1 not in", values, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1Between(String value1, String value2) {
            addCriterion("INFO_NAME1 between", value1, value2, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName1NotBetween(String value1, String value2) {
            addCriterion("INFO_NAME1 not between", value1, value2, "infoName1");
            return (Criteria) this;
        }

        public Criteria andInfoName2IsNull() {
            addCriterion("INFO_NAME2 is null");
            return (Criteria) this;
        }

        public Criteria andInfoName2IsNotNull() {
            addCriterion("INFO_NAME2 is not null");
            return (Criteria) this;
        }

        public Criteria andInfoName2EqualTo(String value) {
            addCriterion("INFO_NAME2 =", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2NotEqualTo(String value) {
            addCriterion("INFO_NAME2 <>", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2GreaterThan(String value) {
            addCriterion("INFO_NAME2 >", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2GreaterThanOrEqualTo(String value) {
            addCriterion("INFO_NAME2 >=", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2LessThan(String value) {
            addCriterion("INFO_NAME2 <", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2LessThanOrEqualTo(String value) {
            addCriterion("INFO_NAME2 <=", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2Like(String value) {
            addCriterion("INFO_NAME2 like", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2NotLike(String value) {
            addCriterion("INFO_NAME2 not like", value, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2In(List<String> values) {
            addCriterion("INFO_NAME2 in", values, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2NotIn(List<String> values) {
            addCriterion("INFO_NAME2 not in", values, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2Between(String value1, String value2) {
            addCriterion("INFO_NAME2 between", value1, value2, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName2NotBetween(String value1, String value2) {
            addCriterion("INFO_NAME2 not between", value1, value2, "infoName2");
            return (Criteria) this;
        }

        public Criteria andInfoName3IsNull() {
            addCriterion("INFO_NAME3 is null");
            return (Criteria) this;
        }

        public Criteria andInfoName3IsNotNull() {
            addCriterion("INFO_NAME3 is not null");
            return (Criteria) this;
        }

        public Criteria andInfoName3EqualTo(String value) {
            addCriterion("INFO_NAME3 =", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3NotEqualTo(String value) {
            addCriterion("INFO_NAME3 <>", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3GreaterThan(String value) {
            addCriterion("INFO_NAME3 >", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3GreaterThanOrEqualTo(String value) {
            addCriterion("INFO_NAME3 >=", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3LessThan(String value) {
            addCriterion("INFO_NAME3 <", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3LessThanOrEqualTo(String value) {
            addCriterion("INFO_NAME3 <=", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3Like(String value) {
            addCriterion("INFO_NAME3 like", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3NotLike(String value) {
            addCriterion("INFO_NAME3 not like", value, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3In(List<String> values) {
            addCriterion("INFO_NAME3 in", values, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3NotIn(List<String> values) {
            addCriterion("INFO_NAME3 not in", values, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3Between(String value1, String value2) {
            addCriterion("INFO_NAME3 between", value1, value2, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName3NotBetween(String value1, String value2) {
            addCriterion("INFO_NAME3 not between", value1, value2, "infoName3");
            return (Criteria) this;
        }

        public Criteria andInfoName4IsNull() {
            addCriterion("INFO_NAME4 is null");
            return (Criteria) this;
        }

        public Criteria andInfoName4IsNotNull() {
            addCriterion("INFO_NAME4 is not null");
            return (Criteria) this;
        }

        public Criteria andInfoName4EqualTo(String value) {
            addCriterion("INFO_NAME4 =", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4NotEqualTo(String value) {
            addCriterion("INFO_NAME4 <>", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4GreaterThan(String value) {
            addCriterion("INFO_NAME4 >", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4GreaterThanOrEqualTo(String value) {
            addCriterion("INFO_NAME4 >=", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4LessThan(String value) {
            addCriterion("INFO_NAME4 <", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4LessThanOrEqualTo(String value) {
            addCriterion("INFO_NAME4 <=", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4Like(String value) {
            addCriterion("INFO_NAME4 like", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4NotLike(String value) {
            addCriterion("INFO_NAME4 not like", value, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4In(List<String> values) {
            addCriterion("INFO_NAME4 in", values, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4NotIn(List<String> values) {
            addCriterion("INFO_NAME4 not in", values, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4Between(String value1, String value2) {
            addCriterion("INFO_NAME4 between", value1, value2, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName4NotBetween(String value1, String value2) {
            addCriterion("INFO_NAME4 not between", value1, value2, "infoName4");
            return (Criteria) this;
        }

        public Criteria andInfoName5IsNull() {
            addCriterion("INFO_NAME5 is null");
            return (Criteria) this;
        }

        public Criteria andInfoName5IsNotNull() {
            addCriterion("INFO_NAME5 is not null");
            return (Criteria) this;
        }

        public Criteria andInfoName5EqualTo(String value) {
            addCriterion("INFO_NAME5 =", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5NotEqualTo(String value) {
            addCriterion("INFO_NAME5 <>", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5GreaterThan(String value) {
            addCriterion("INFO_NAME5 >", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5GreaterThanOrEqualTo(String value) {
            addCriterion("INFO_NAME5 >=", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5LessThan(String value) {
            addCriterion("INFO_NAME5 <", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5LessThanOrEqualTo(String value) {
            addCriterion("INFO_NAME5 <=", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5Like(String value) {
            addCriterion("INFO_NAME5 like", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5NotLike(String value) {
            addCriterion("INFO_NAME5 not like", value, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5In(List<String> values) {
            addCriterion("INFO_NAME5 in", values, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5NotIn(List<String> values) {
            addCriterion("INFO_NAME5 not in", values, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5Between(String value1, String value2) {
            addCriterion("INFO_NAME5 between", value1, value2, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoName5NotBetween(String value1, String value2) {
            addCriterion("INFO_NAME5 not between", value1, value2, "infoName5");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdIsNull() {
            addCriterion("INFO_FUNC_ID is null");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdIsNotNull() {
            addCriterion("INFO_FUNC_ID is not null");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdEqualTo(Integer value) {
            addCriterion("INFO_FUNC_ID =", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdNotEqualTo(Integer value) {
            addCriterion("INFO_FUNC_ID <>", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdGreaterThan(Integer value) {
            addCriterion("INFO_FUNC_ID >", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("INFO_FUNC_ID >=", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdLessThan(Integer value) {
            addCriterion("INFO_FUNC_ID <", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdLessThanOrEqualTo(Integer value) {
            addCriterion("INFO_FUNC_ID <=", value, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdIn(List<Integer> values) {
            addCriterion("INFO_FUNC_ID in", values, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdNotIn(List<Integer> values) {
            addCriterion("INFO_FUNC_ID not in", values, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdBetween(Integer value1, Integer value2) {
            addCriterion("INFO_FUNC_ID between", value1, value2, "infoFuncId");
            return (Criteria) this;
        }

        public Criteria andInfoFuncIdNotBetween(Integer value1, Integer value2) {
            addCriterion("INFO_FUNC_ID not between", value1, value2, "infoFuncId");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table info_center
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
     * This class corresponds to the database table info_center
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