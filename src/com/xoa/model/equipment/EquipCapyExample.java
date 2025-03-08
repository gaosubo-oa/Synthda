package com.xoa.model.equipment;

import java.util.ArrayList;
import java.util.List;

public class EquipCapyExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public EquipCapyExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
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
     * This method corresponds to the database table lims_equip_capy
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
     * This method corresponds to the database table lims_equip_capy
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capy
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
     * This class corresponds to the database table lims_equip_capy
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

        public Criteria andCapyIdIsNull() {
            addCriterion("CAPY_ID is null");
            return (Criteria) this;
        }

        public Criteria andCapyIdIsNotNull() {
            addCriterion("CAPY_ID is not null");
            return (Criteria) this;
        }

        public Criteria andCapyIdEqualTo(Integer value) {
            addCriterion("CAPY_ID =", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdNotEqualTo(Integer value) {
            addCriterion("CAPY_ID <>", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdGreaterThan(Integer value) {
            addCriterion("CAPY_ID >", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("CAPY_ID >=", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdLessThan(Integer value) {
            addCriterion("CAPY_ID <", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdLessThanOrEqualTo(Integer value) {
            addCriterion("CAPY_ID <=", value, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdIn(List<Integer> values) {
            addCriterion("CAPY_ID in", values, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdNotIn(List<Integer> values) {
            addCriterion("CAPY_ID not in", values, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdBetween(Integer value1, Integer value2) {
            addCriterion("CAPY_ID between", value1, value2, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyIdNotBetween(Integer value1, Integer value2) {
            addCriterion("CAPY_ID not between", value1, value2, "capyId");
            return (Criteria) this;
        }

        public Criteria andCapyNameIsNull() {
            addCriterion("CAPY_NAME is null");
            return (Criteria) this;
        }

        public Criteria andCapyNameIsNotNull() {
            addCriterion("CAPY_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andCapyNameEqualTo(String value) {
            addCriterion("CAPY_NAME =", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameNotEqualTo(String value) {
            addCriterion("CAPY_NAME <>", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameGreaterThan(String value) {
            addCriterion("CAPY_NAME >", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameGreaterThanOrEqualTo(String value) {
            addCriterion("CAPY_NAME >=", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameLessThan(String value) {
            addCriterion("CAPY_NAME <", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameLessThanOrEqualTo(String value) {
            addCriterion("CAPY_NAME <=", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameLike(String value) {
            addCriterion("CAPY_NAME like", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameNotLike(String value) {
            addCriterion("CAPY_NAME not like", value, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameIn(List<String> values) {
            addCriterion("CAPY_NAME in", values, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameNotIn(List<String> values) {
            addCriterion("CAPY_NAME not in", values, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameBetween(String value1, String value2) {
            addCriterion("CAPY_NAME between", value1, value2, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyNameNotBetween(String value1, String value2) {
            addCriterion("CAPY_NAME not between", value1, value2, "capyName");
            return (Criteria) this;
        }

        public Criteria andCapyStatusIsNull() {
            addCriterion("CAPY_STATUS is null");
            return (Criteria) this;
        }

        public Criteria andCapyStatusIsNotNull() {
            addCriterion("CAPY_STATUS is not null");
            return (Criteria) this;
        }

        public Criteria andCapyStatusEqualTo(String value) {
            addCriterion("CAPY_STATUS =", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusNotEqualTo(String value) {
            addCriterion("CAPY_STATUS <>", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusGreaterThan(String value) {
            addCriterion("CAPY_STATUS >", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusGreaterThanOrEqualTo(String value) {
            addCriterion("CAPY_STATUS >=", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusLessThan(String value) {
            addCriterion("CAPY_STATUS <", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusLessThanOrEqualTo(String value) {
            addCriterion("CAPY_STATUS <=", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusLike(String value) {
            addCriterion("CAPY_STATUS like", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusNotLike(String value) {
            addCriterion("CAPY_STATUS not like", value, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusIn(List<String> values) {
            addCriterion("CAPY_STATUS in", values, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusNotIn(List<String> values) {
            addCriterion("CAPY_STATUS not in", values, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusBetween(String value1, String value2) {
            addCriterion("CAPY_STATUS between", value1, value2, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andCapyStatusNotBetween(String value1, String value2) {
            addCriterion("CAPY_STATUS not between", value1, value2, "capyStatus");
            return (Criteria) this;
        }

        public Criteria andUnitIdsIsNull() {
            addCriterion("UNIT_IDS is null");
            return (Criteria) this;
        }

        public Criteria andUnitIdsIsNotNull() {
            addCriterion("UNIT_IDS is not null");
            return (Criteria) this;
        }

        public Criteria andUnitIdsEqualTo(String value) {
            addCriterion("UNIT_IDS =", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsNotEqualTo(String value) {
            addCriterion("UNIT_IDS <>", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsGreaterThan(String value) {
            addCriterion("UNIT_IDS >", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsGreaterThanOrEqualTo(String value) {
            addCriterion("UNIT_IDS >=", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsLessThan(String value) {
            addCriterion("UNIT_IDS <", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsLessThanOrEqualTo(String value) {
            addCriterion("UNIT_IDS <=", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsLike(String value) {
            addCriterion("UNIT_IDS like", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsNotLike(String value) {
            addCriterion("UNIT_IDS not like", value, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsIn(List<String> values) {
            addCriterion("UNIT_IDS in", values, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsNotIn(List<String> values) {
            addCriterion("UNIT_IDS not in", values, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsBetween(String value1, String value2) {
            addCriterion("UNIT_IDS between", value1, value2, "unitIds");
            return (Criteria) this;
        }

        public Criteria andUnitIdsNotBetween(String value1, String value2) {
            addCriterion("UNIT_IDS not between", value1, value2, "unitIds");
            return (Criteria) this;
        }

        public Criteria andInputTypeIsNull() {
            addCriterion("INPUT_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andInputTypeIsNotNull() {
            addCriterion("INPUT_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andInputTypeEqualTo(String value) {
            addCriterion("INPUT_TYPE =", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeNotEqualTo(String value) {
            addCriterion("INPUT_TYPE <>", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeGreaterThan(String value) {
            addCriterion("INPUT_TYPE >", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeGreaterThanOrEqualTo(String value) {
            addCriterion("INPUT_TYPE >=", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeLessThan(String value) {
            addCriterion("INPUT_TYPE <", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeLessThanOrEqualTo(String value) {
            addCriterion("INPUT_TYPE <=", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeLike(String value) {
            addCriterion("INPUT_TYPE like", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeNotLike(String value) {
            addCriterion("INPUT_TYPE not like", value, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeIn(List<String> values) {
            addCriterion("INPUT_TYPE in", values, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeNotIn(List<String> values) {
            addCriterion("INPUT_TYPE not in", values, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeBetween(String value1, String value2) {
            addCriterion("INPUT_TYPE between", value1, value2, "inputType");
            return (Criteria) this;
        }

        public Criteria andInputTypeNotBetween(String value1, String value2) {
            addCriterion("INPUT_TYPE not between", value1, value2, "inputType");
            return (Criteria) this;
        }

        public Criteria andOperatModeIsNull() {
            addCriterion("OPERAT_MODE is null");
            return (Criteria) this;
        }

        public Criteria andOperatModeIsNotNull() {
            addCriterion("OPERAT_MODE is not null");
            return (Criteria) this;
        }

        public Criteria andOperatModeEqualTo(String value) {
            addCriterion("OPERAT_MODE =", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeNotEqualTo(String value) {
            addCriterion("OPERAT_MODE <>", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeGreaterThan(String value) {
            addCriterion("OPERAT_MODE >", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeGreaterThanOrEqualTo(String value) {
            addCriterion("OPERAT_MODE >=", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeLessThan(String value) {
            addCriterion("OPERAT_MODE <", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeLessThanOrEqualTo(String value) {
            addCriterion("OPERAT_MODE <=", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeLike(String value) {
            addCriterion("OPERAT_MODE like", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeNotLike(String value) {
            addCriterion("OPERAT_MODE not like", value, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeIn(List<String> values) {
            addCriterion("OPERAT_MODE in", values, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeNotIn(List<String> values) {
            addCriterion("OPERAT_MODE not in", values, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeBetween(String value1, String value2) {
            addCriterion("OPERAT_MODE between", value1, value2, "operatMode");
            return (Criteria) this;
        }

        public Criteria andOperatModeNotBetween(String value1, String value2) {
            addCriterion("OPERAT_MODE not between", value1, value2, "operatMode");
            return (Criteria) this;
        }

        public Criteria andDataSourceIsNull() {
            addCriterion("DATA_SOURCE is null");
            return (Criteria) this;
        }

        public Criteria andDataSourceIsNotNull() {
            addCriterion("DATA_SOURCE is not null");
            return (Criteria) this;
        }

        public Criteria andDataSourceEqualTo(String value) {
            addCriterion("DATA_SOURCE =", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceNotEqualTo(String value) {
            addCriterion("DATA_SOURCE <>", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceGreaterThan(String value) {
            addCriterion("DATA_SOURCE >", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceGreaterThanOrEqualTo(String value) {
            addCriterion("DATA_SOURCE >=", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceLessThan(String value) {
            addCriterion("DATA_SOURCE <", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceLessThanOrEqualTo(String value) {
            addCriterion("DATA_SOURCE <=", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceLike(String value) {
            addCriterion("DATA_SOURCE like", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceNotLike(String value) {
            addCriterion("DATA_SOURCE not like", value, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceIn(List<String> values) {
            addCriterion("DATA_SOURCE in", values, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceNotIn(List<String> values) {
            addCriterion("DATA_SOURCE not in", values, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceBetween(String value1, String value2) {
            addCriterion("DATA_SOURCE between", value1, value2, "dataSource");
            return (Criteria) this;
        }

        public Criteria andDataSourceNotBetween(String value1, String value2) {
            addCriterion("DATA_SOURCE not between", value1, value2, "dataSource");
            return (Criteria) this;
        }

        public Criteria andMemoIsNull() {
            addCriterion("MEMO is null");
            return (Criteria) this;
        }

        public Criteria andMemoIsNotNull() {
            addCriterion("MEMO is not null");
            return (Criteria) this;
        }

        public Criteria andMemoEqualTo(String value) {
            addCriterion("MEMO =", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoNotEqualTo(String value) {
            addCriterion("MEMO <>", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoGreaterThan(String value) {
            addCriterion("MEMO >", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoGreaterThanOrEqualTo(String value) {
            addCriterion("MEMO >=", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoLessThan(String value) {
            addCriterion("MEMO <", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoLessThanOrEqualTo(String value) {
            addCriterion("MEMO <=", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoLike(String value) {
            addCriterion("MEMO like", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoNotLike(String value) {
            addCriterion("MEMO not like", value, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoIn(List<String> values) {
            addCriterion("MEMO in", values, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoNotIn(List<String> values) {
            addCriterion("MEMO not in", values, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoBetween(String value1, String value2) {
            addCriterion("MEMO between", value1, value2, "memo");
            return (Criteria) this;
        }

        public Criteria andMemoNotBetween(String value1, String value2) {
            addCriterion("MEMO not between", value1, value2, "memo");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table lims_equip_capy
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
     * This class corresponds to the database table lims_equip_capy
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