package com.xoa.model.knowledge;

import java.util.ArrayList;
import java.util.List;

public class KnowledgeColumnExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public KnowledgeColumnExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
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
     * This method corresponds to the database table knowledge_column
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
     * This method corresponds to the database table knowledge_column
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table knowledge_column
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
     * This class corresponds to the database table knowledge_column
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

        public Criteria andColumnIdIsNull() {
            addCriterion("COLUMN_ID is null");
            return (Criteria) this;
        }

        public Criteria andColumnIdIsNotNull() {
            addCriterion("COLUMN_ID is not null");
            return (Criteria) this;
        }

        public Criteria andColumnIdEqualTo(Integer value) {
            addCriterion("COLUMN_ID =", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdNotEqualTo(Integer value) {
            addCriterion("COLUMN_ID <>", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdGreaterThan(Integer value) {
            addCriterion("COLUMN_ID >", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("COLUMN_ID >=", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdLessThan(Integer value) {
            addCriterion("COLUMN_ID <", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdLessThanOrEqualTo(Integer value) {
            addCriterion("COLUMN_ID <=", value, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdIn(List<Integer> values) {
            addCriterion("COLUMN_ID in", values, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdNotIn(List<Integer> values) {
            addCriterion("COLUMN_ID not in", values, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdBetween(Integer value1, Integer value2) {
            addCriterion("COLUMN_ID between", value1, value2, "columnId");
            return (Criteria) this;
        }

        public Criteria andColumnIdNotBetween(Integer value1, Integer value2) {
            addCriterion("COLUMN_ID not between", value1, value2, "columnId");
            return (Criteria) this;
        }

        public Criteria andOrderNoIsNull() {
            addCriterion("ORDER_NO is null");
            return (Criteria) this;
        }

        public Criteria andOrderNoIsNotNull() {
            addCriterion("ORDER_NO is not null");
            return (Criteria) this;
        }

        public Criteria andOrderNoEqualTo(Integer value) {
            addCriterion("ORDER_NO =", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoNotEqualTo(Integer value) {
            addCriterion("ORDER_NO <>", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoGreaterThan(Integer value) {
            addCriterion("ORDER_NO >", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoGreaterThanOrEqualTo(Integer value) {
            addCriterion("ORDER_NO >=", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoLessThan(Integer value) {
            addCriterion("ORDER_NO <", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoLessThanOrEqualTo(Integer value) {
            addCriterion("ORDER_NO <=", value, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoIn(List<Integer> values) {
            addCriterion("ORDER_NO in", values, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoNotIn(List<Integer> values) {
            addCriterion("ORDER_NO not in", values, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoBetween(Integer value1, Integer value2) {
            addCriterion("ORDER_NO between", value1, value2, "orderNo");
            return (Criteria) this;
        }

        public Criteria andOrderNoNotBetween(Integer value1, Integer value2) {
            addCriterion("ORDER_NO not between", value1, value2, "orderNo");
            return (Criteria) this;
        }

        public Criteria andColumnTypeIsNull() {
            addCriterion("COLUMN_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andColumnTypeIsNotNull() {
            addCriterion("COLUMN_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andColumnTypeEqualTo(String value) {
            addCriterion("COLUMN_TYPE =", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeNotEqualTo(String value) {
            addCriterion("COLUMN_TYPE <>", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeGreaterThan(String value) {
            addCriterion("COLUMN_TYPE >", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeGreaterThanOrEqualTo(String value) {
            addCriterion("COLUMN_TYPE >=", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeLessThan(String value) {
            addCriterion("COLUMN_TYPE <", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeLessThanOrEqualTo(String value) {
            addCriterion("COLUMN_TYPE <=", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeLike(String value) {
            addCriterion("COLUMN_TYPE like", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeNotLike(String value) {
            addCriterion("COLUMN_TYPE not like", value, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeIn(List<String> values) {
            addCriterion("COLUMN_TYPE in", values, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeNotIn(List<String> values) {
            addCriterion("COLUMN_TYPE not in", values, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeBetween(String value1, String value2) {
            addCriterion("COLUMN_TYPE between", value1, value2, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnTypeNotBetween(String value1, String value2) {
            addCriterion("COLUMN_TYPE not between", value1, value2, "columnType");
            return (Criteria) this;
        }

        public Criteria andColumnCodeIsNull() {
            addCriterion("COLUMN_CODE is null");
            return (Criteria) this;
        }

        public Criteria andColumnCodeIsNotNull() {
            addCriterion("COLUMN_CODE is not null");
            return (Criteria) this;
        }

        public Criteria andColumnCodeEqualTo(String value) {
            addCriterion("COLUMN_CODE =", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeNotEqualTo(String value) {
            addCriterion("COLUMN_CODE <>", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeGreaterThan(String value) {
            addCriterion("COLUMN_CODE >", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeGreaterThanOrEqualTo(String value) {
            addCriterion("COLUMN_CODE >=", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeLessThan(String value) {
            addCriterion("COLUMN_CODE <", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeLessThanOrEqualTo(String value) {
            addCriterion("COLUMN_CODE <=", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeLike(String value) {
            addCriterion("COLUMN_CODE like", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeNotLike(String value) {
            addCriterion("COLUMN_CODE not like", value, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeIn(List<String> values) {
            addCriterion("COLUMN_CODE in", values, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeNotIn(List<String> values) {
            addCriterion("COLUMN_CODE not in", values, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeBetween(String value1, String value2) {
            addCriterion("COLUMN_CODE between", value1, value2, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnCodeNotBetween(String value1, String value2) {
            addCriterion("COLUMN_CODE not between", value1, value2, "columnCode");
            return (Criteria) this;
        }

        public Criteria andColumnNameIsNull() {
            addCriterion("COLUMN_NAME is null");
            return (Criteria) this;
        }

        public Criteria andColumnNameIsNotNull() {
            addCriterion("COLUMN_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andColumnNameEqualTo(String value) {
            addCriterion("COLUMN_NAME =", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameNotEqualTo(String value) {
            addCriterion("COLUMN_NAME <>", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameGreaterThan(String value) {
            addCriterion("COLUMN_NAME >", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameGreaterThanOrEqualTo(String value) {
            addCriterion("COLUMN_NAME >=", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameLessThan(String value) {
            addCriterion("COLUMN_NAME <", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameLessThanOrEqualTo(String value) {
            addCriterion("COLUMN_NAME <=", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameLike(String value) {
            addCriterion("COLUMN_NAME like", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameNotLike(String value) {
            addCriterion("COLUMN_NAME not like", value, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameIn(List<String> values) {
            addCriterion("COLUMN_NAME in", values, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameNotIn(List<String> values) {
            addCriterion("COLUMN_NAME not in", values, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameBetween(String value1, String value2) {
            addCriterion("COLUMN_NAME between", value1, value2, "columnName");
            return (Criteria) this;
        }

        public Criteria andColumnNameNotBetween(String value1, String value2) {
            addCriterion("COLUMN_NAME not between", value1, value2, "columnName");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdIsNull() {
            addCriterion("PARENT_COLUMN_ID is null");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdIsNotNull() {
            addCriterion("PARENT_COLUMN_ID is not null");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdEqualTo(Integer value) {
            addCriterion("PARENT_COLUMN_ID =", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdNotEqualTo(Integer value) {
            addCriterion("PARENT_COLUMN_ID <>", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdGreaterThan(Integer value) {
            addCriterion("PARENT_COLUMN_ID >", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("PARENT_COLUMN_ID >=", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdLessThan(Integer value) {
            addCriterion("PARENT_COLUMN_ID <", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdLessThanOrEqualTo(Integer value) {
            addCriterion("PARENT_COLUMN_ID <=", value, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdIn(List<Integer> values) {
            addCriterion("PARENT_COLUMN_ID in", values, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdNotIn(List<Integer> values) {
            addCriterion("PARENT_COLUMN_ID not in", values, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdBetween(Integer value1, Integer value2) {
            addCriterion("PARENT_COLUMN_ID between", value1, value2, "parentColumnId");
            return (Criteria) this;
        }

        public Criteria andParentColumnIdNotBetween(Integer value1, Integer value2) {
            addCriterion("PARENT_COLUMN_ID not between", value1, value2, "parentColumnId");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table knowledge_column
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
     * This class corresponds to the database table knowledge_column
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