package com.xoa.model.position;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserJobDutyHistoryExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public UserJobDutyHistoryExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
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
     * This method corresponds to the database table user_job_duty_history
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
     * This method corresponds to the database table user_job_duty_history
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_job_duty_history
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
     * This class corresponds to the database table user_job_duty_history
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

        public Criteria andHistoryIdIsNull() {
            addCriterion("HISTORY_ID is null");
            return (Criteria) this;
        }

        public Criteria andHistoryIdIsNotNull() {
            addCriterion("HISTORY_ID is not null");
            return (Criteria) this;
        }

        public Criteria andHistoryIdEqualTo(Integer value) {
            addCriterion("HISTORY_ID =", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdNotEqualTo(Integer value) {
            addCriterion("HISTORY_ID <>", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdGreaterThan(Integer value) {
            addCriterion("HISTORY_ID >", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("HISTORY_ID >=", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdLessThan(Integer value) {
            addCriterion("HISTORY_ID <", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdLessThanOrEqualTo(Integer value) {
            addCriterion("HISTORY_ID <=", value, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdIn(List<Integer> values) {
            addCriterion("HISTORY_ID in", values, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdNotIn(List<Integer> values) {
            addCriterion("HISTORY_ID not in", values, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdBetween(Integer value1, Integer value2) {
            addCriterion("HISTORY_ID between", value1, value2, "historyId");
            return (Criteria) this;
        }

        public Criteria andHistoryIdNotBetween(Integer value1, Integer value2) {
            addCriterion("HISTORY_ID not between", value1, value2, "historyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdIsNull() {
            addCriterion("DUTY_ID is null");
            return (Criteria) this;
        }

        public Criteria andDutyIdIsNotNull() {
            addCriterion("DUTY_ID is not null");
            return (Criteria) this;
        }

        public Criteria andDutyIdEqualTo(Integer value) {
            addCriterion("DUTY_ID =", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdNotEqualTo(Integer value) {
            addCriterion("DUTY_ID <>", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdGreaterThan(Integer value) {
            addCriterion("DUTY_ID >", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("DUTY_ID >=", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdLessThan(Integer value) {
            addCriterion("DUTY_ID <", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdLessThanOrEqualTo(Integer value) {
            addCriterion("DUTY_ID <=", value, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdIn(List<Integer> values) {
            addCriterion("DUTY_ID in", values, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdNotIn(List<Integer> values) {
            addCriterion("DUTY_ID not in", values, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdBetween(Integer value1, Integer value2) {
            addCriterion("DUTY_ID between", value1, value2, "dutyId");
            return (Criteria) this;
        }

        public Criteria andDutyIdNotBetween(Integer value1, Integer value2) {
            addCriterion("DUTY_ID not between", value1, value2, "dutyId");
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

        public Criteria andCreateTimeIsNull() {
            addCriterion("CREATE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNotNull() {
            addCriterion("CREATE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeEqualTo(Date value) {
            addCriterion("CREATE_TIME =", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotEqualTo(Date value) {
            addCriterion("CREATE_TIME <>", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThan(Date value) {
            addCriterion("CREATE_TIME >", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME >=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThan(Date value) {
            addCriterion("CREATE_TIME <", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME <=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIn(List<Date> values) {
            addCriterion("CREATE_TIME in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotIn(List<Date> values) {
            addCriterion("CREATE_TIME not in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME not between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andDutyNameIsNull() {
            addCriterion("DUTY_NAME is null");
            return (Criteria) this;
        }

        public Criteria andDutyNameIsNotNull() {
            addCriterion("DUTY_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andDutyNameEqualTo(String value) {
            addCriterion("DUTY_NAME =", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameNotEqualTo(String value) {
            addCriterion("DUTY_NAME <>", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameGreaterThan(String value) {
            addCriterion("DUTY_NAME >", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameGreaterThanOrEqualTo(String value) {
            addCriterion("DUTY_NAME >=", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameLessThan(String value) {
            addCriterion("DUTY_NAME <", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameLessThanOrEqualTo(String value) {
            addCriterion("DUTY_NAME <=", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameLike(String value) {
            addCriterion("DUTY_NAME like", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameNotLike(String value) {
            addCriterion("DUTY_NAME not like", value, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameIn(List<String> values) {
            addCriterion("DUTY_NAME in", values, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameNotIn(List<String> values) {
            addCriterion("DUTY_NAME not in", values, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameBetween(String value1, String value2) {
            addCriterion("DUTY_NAME between", value1, value2, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyNameNotBetween(String value1, String value2) {
            addCriterion("DUTY_NAME not between", value1, value2, "dutyName");
            return (Criteria) this;
        }

        public Criteria andDutyVersionIsNull() {
            addCriterion("DUTY_VERSION is null");
            return (Criteria) this;
        }

        public Criteria andDutyVersionIsNotNull() {
            addCriterion("DUTY_VERSION is not null");
            return (Criteria) this;
        }

        public Criteria andDutyVersionEqualTo(String value) {
            addCriterion("DUTY_VERSION =", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionNotEqualTo(String value) {
            addCriterion("DUTY_VERSION <>", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionGreaterThan(String value) {
            addCriterion("DUTY_VERSION >", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionGreaterThanOrEqualTo(String value) {
            addCriterion("DUTY_VERSION >=", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionLessThan(String value) {
            addCriterion("DUTY_VERSION <", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionLessThanOrEqualTo(String value) {
            addCriterion("DUTY_VERSION <=", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionLike(String value) {
            addCriterion("DUTY_VERSION like", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionNotLike(String value) {
            addCriterion("DUTY_VERSION not like", value, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionIn(List<String> values) {
            addCriterion("DUTY_VERSION in", values, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionNotIn(List<String> values) {
            addCriterion("DUTY_VERSION not in", values, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionBetween(String value1, String value2) {
            addCriterion("DUTY_VERSION between", value1, value2, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyVersionNotBetween(String value1, String value2) {
            addCriterion("DUTY_VERSION not between", value1, value2, "dutyVersion");
            return (Criteria) this;
        }

        public Criteria andDutyTypeIsNull() {
            addCriterion("DUTY_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andDutyTypeIsNotNull() {
            addCriterion("DUTY_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andDutyTypeEqualTo(String value) {
            addCriterion("DUTY_TYPE =", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeNotEqualTo(String value) {
            addCriterion("DUTY_TYPE <>", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeGreaterThan(String value) {
            addCriterion("DUTY_TYPE >", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeGreaterThanOrEqualTo(String value) {
            addCriterion("DUTY_TYPE >=", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeLessThan(String value) {
            addCriterion("DUTY_TYPE <", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeLessThanOrEqualTo(String value) {
            addCriterion("DUTY_TYPE <=", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeLike(String value) {
            addCriterion("DUTY_TYPE like", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeNotLike(String value) {
            addCriterion("DUTY_TYPE not like", value, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeIn(List<String> values) {
            addCriterion("DUTY_TYPE in", values, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeNotIn(List<String> values) {
            addCriterion("DUTY_TYPE not in", values, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeBetween(String value1, String value2) {
            addCriterion("DUTY_TYPE between", value1, value2, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyTypeNotBetween(String value1, String value2) {
            addCriterion("DUTY_TYPE not between", value1, value2, "dutyType");
            return (Criteria) this;
        }

        public Criteria andDutyParentIsNull() {
            addCriterion("DUTY_PARENT is null");
            return (Criteria) this;
        }

        public Criteria andDutyParentIsNotNull() {
            addCriterion("DUTY_PARENT is not null");
            return (Criteria) this;
        }

        public Criteria andDutyParentEqualTo(Integer value) {
            addCriterion("DUTY_PARENT =", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentNotEqualTo(Integer value) {
            addCriterion("DUTY_PARENT <>", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentGreaterThan(Integer value) {
            addCriterion("DUTY_PARENT >", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentGreaterThanOrEqualTo(Integer value) {
            addCriterion("DUTY_PARENT >=", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentLessThan(Integer value) {
            addCriterion("DUTY_PARENT <", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentLessThanOrEqualTo(Integer value) {
            addCriterion("DUTY_PARENT <=", value, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentIn(List<Integer> values) {
            addCriterion("DUTY_PARENT in", values, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentNotIn(List<Integer> values) {
            addCriterion("DUTY_PARENT not in", values, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentBetween(Integer value1, Integer value2) {
            addCriterion("DUTY_PARENT between", value1, value2, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDutyParentNotBetween(Integer value1, Integer value2) {
            addCriterion("DUTY_PARENT not between", value1, value2, "dutyParent");
            return (Criteria) this;
        }

        public Criteria andDeptIdIsNull() {
            addCriterion("DEPT_ID is null");
            return (Criteria) this;
        }

        public Criteria andDeptIdIsNotNull() {
            addCriterion("DEPT_ID is not null");
            return (Criteria) this;
        }

        public Criteria andDeptIdEqualTo(Integer value) {
            addCriterion("DEPT_ID =", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotEqualTo(Integer value) {
            addCriterion("DEPT_ID <>", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdGreaterThan(Integer value) {
            addCriterion("DEPT_ID >", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("DEPT_ID >=", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdLessThan(Integer value) {
            addCriterion("DEPT_ID <", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdLessThanOrEqualTo(Integer value) {
            addCriterion("DEPT_ID <=", value, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdIn(List<Integer> values) {
            addCriterion("DEPT_ID in", values, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotIn(List<Integer> values) {
            addCriterion("DEPT_ID not in", values, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdBetween(Integer value1, Integer value2) {
            addCriterion("DEPT_ID between", value1, value2, "deptId");
            return (Criteria) this;
        }

        public Criteria andDeptIdNotBetween(Integer value1, Integer value2) {
            addCriterion("DEPT_ID not between", value1, value2, "deptId");
            return (Criteria) this;
        }

        public Criteria andDutyGradeIsNull() {
            addCriterion("DUTY_GRADE is null");
            return (Criteria) this;
        }

        public Criteria andDutyGradeIsNotNull() {
            addCriterion("DUTY_GRADE is not null");
            return (Criteria) this;
        }

        public Criteria andDutyGradeEqualTo(String value) {
            addCriterion("DUTY_GRADE =", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeNotEqualTo(String value) {
            addCriterion("DUTY_GRADE <>", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeGreaterThan(String value) {
            addCriterion("DUTY_GRADE >", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeGreaterThanOrEqualTo(String value) {
            addCriterion("DUTY_GRADE >=", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeLessThan(String value) {
            addCriterion("DUTY_GRADE <", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeLessThanOrEqualTo(String value) {
            addCriterion("DUTY_GRADE <=", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeLike(String value) {
            addCriterion("DUTY_GRADE like", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeNotLike(String value) {
            addCriterion("DUTY_GRADE not like", value, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeIn(List<String> values) {
            addCriterion("DUTY_GRADE in", values, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeNotIn(List<String> values) {
            addCriterion("DUTY_GRADE not in", values, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeBetween(String value1, String value2) {
            addCriterion("DUTY_GRADE between", value1, value2, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andDutyGradeNotBetween(String value1, String value2) {
            addCriterion("DUTY_GRADE not between", value1, value2, "dutyGrade");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeIsNull() {
            addCriterion("IS_FINAL_NODE is null");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeIsNotNull() {
            addCriterion("IS_FINAL_NODE is not null");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeEqualTo(String value) {
            addCriterion("IS_FINAL_NODE =", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeNotEqualTo(String value) {
            addCriterion("IS_FINAL_NODE <>", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeGreaterThan(String value) {
            addCriterion("IS_FINAL_NODE >", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeGreaterThanOrEqualTo(String value) {
            addCriterion("IS_FINAL_NODE >=", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeLessThan(String value) {
            addCriterion("IS_FINAL_NODE <", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeLessThanOrEqualTo(String value) {
            addCriterion("IS_FINAL_NODE <=", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeLike(String value) {
            addCriterion("IS_FINAL_NODE like", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeNotLike(String value) {
            addCriterion("IS_FINAL_NODE not like", value, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeIn(List<String> values) {
            addCriterion("IS_FINAL_NODE in", values, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeNotIn(List<String> values) {
            addCriterion("IS_FINAL_NODE not in", values, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeBetween(String value1, String value2) {
            addCriterion("IS_FINAL_NODE between", value1, value2, "isFinalNode");
            return (Criteria) this;
        }

        public Criteria andIsFinalNodeNotBetween(String value1, String value2) {
            addCriterion("IS_FINAL_NODE not between", value1, value2, "isFinalNode");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table user_job_duty_history
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
     * This class corresponds to the database table user_job_duty_history
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