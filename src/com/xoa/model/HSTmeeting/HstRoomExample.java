package com.xoa.model.HSTmeeting;

import java.util.ArrayList;
import java.util.List;

public class HstRoomExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public HstRoomExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
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
     * This method corresponds to the database table hst_room
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
     * This method corresponds to the database table hst_room
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hst_room
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
     * This class corresponds to the database table hst_room
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

        public Criteria andRoomIdIsNull() {
            addCriterion("ROOM_ID is null");
            return (Criteria) this;
        }

        public Criteria andRoomIdIsNotNull() {
            addCriterion("ROOM_ID is not null");
            return (Criteria) this;
        }

        public Criteria andRoomIdEqualTo(Integer value) {
            addCriterion("ROOM_ID =", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdNotEqualTo(Integer value) {
            addCriterion("ROOM_ID <>", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdGreaterThan(Integer value) {
            addCriterion("ROOM_ID >", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("ROOM_ID >=", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdLessThan(Integer value) {
            addCriterion("ROOM_ID <", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdLessThanOrEqualTo(Integer value) {
            addCriterion("ROOM_ID <=", value, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdIn(List<Integer> values) {
            addCriterion("ROOM_ID in", values, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdNotIn(List<Integer> values) {
            addCriterion("ROOM_ID not in", values, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdBetween(Integer value1, Integer value2) {
            addCriterion("ROOM_ID between", value1, value2, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomIdNotBetween(Integer value1, Integer value2) {
            addCriterion("ROOM_ID not between", value1, value2, "roomId");
            return (Criteria) this;
        }

        public Criteria andRoomNameIsNull() {
            addCriterion("ROOM_NAME is null");
            return (Criteria) this;
        }

        public Criteria andRoomNameIsNotNull() {
            addCriterion("ROOM_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andRoomNameEqualTo(String value) {
            addCriterion("ROOM_NAME =", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameNotEqualTo(String value) {
            addCriterion("ROOM_NAME <>", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameGreaterThan(String value) {
            addCriterion("ROOM_NAME >", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameGreaterThanOrEqualTo(String value) {
            addCriterion("ROOM_NAME >=", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameLessThan(String value) {
            addCriterion("ROOM_NAME <", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameLessThanOrEqualTo(String value) {
            addCriterion("ROOM_NAME <=", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameLike(String value) {
            addCriterion("ROOM_NAME like", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameNotLike(String value) {
            addCriterion("ROOM_NAME not like", value, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameIn(List<String> values) {
            addCriterion("ROOM_NAME in", values, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameNotIn(List<String> values) {
            addCriterion("ROOM_NAME not in", values, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameBetween(String value1, String value2) {
            addCriterion("ROOM_NAME between", value1, value2, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNameNotBetween(String value1, String value2) {
            addCriterion("ROOM_NAME not between", value1, value2, "roomName");
            return (Criteria) this;
        }

        public Criteria andRoomNoIsNull() {
            addCriterion("ROOM_NO is null");
            return (Criteria) this;
        }

        public Criteria andRoomNoIsNotNull() {
            addCriterion("ROOM_NO is not null");
            return (Criteria) this;
        }

        public Criteria andRoomNoEqualTo(String value) {
            addCriterion("ROOM_NO =", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoNotEqualTo(String value) {
            addCriterion("ROOM_NO <>", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoGreaterThan(String value) {
            addCriterion("ROOM_NO >", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoGreaterThanOrEqualTo(String value) {
            addCriterion("ROOM_NO >=", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoLessThan(String value) {
            addCriterion("ROOM_NO <", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoLessThanOrEqualTo(String value) {
            addCriterion("ROOM_NO <=", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoLike(String value) {
            addCriterion("ROOM_NO like", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoNotLike(String value) {
            addCriterion("ROOM_NO not like", value, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoIn(List<String> values) {
            addCriterion("ROOM_NO in", values, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoNotIn(List<String> values) {
            addCriterion("ROOM_NO not in", values, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoBetween(String value1, String value2) {
            addCriterion("ROOM_NO between", value1, value2, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomNoNotBetween(String value1, String value2) {
            addCriterion("ROOM_NO not between", value1, value2, "roomNo");
            return (Criteria) this;
        }

        public Criteria andRoomPwdIsNull() {
            addCriterion("ROOM_PWD is null");
            return (Criteria) this;
        }

        public Criteria andRoomPwdIsNotNull() {
            addCriterion("ROOM_PWD is not null");
            return (Criteria) this;
        }

        public Criteria andRoomPwdEqualTo(String value) {
            addCriterion("ROOM_PWD =", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdNotEqualTo(String value) {
            addCriterion("ROOM_PWD <>", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdGreaterThan(String value) {
            addCriterion("ROOM_PWD >", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdGreaterThanOrEqualTo(String value) {
            addCriterion("ROOM_PWD >=", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdLessThan(String value) {
            addCriterion("ROOM_PWD <", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdLessThanOrEqualTo(String value) {
            addCriterion("ROOM_PWD <=", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdLike(String value) {
            addCriterion("ROOM_PWD like", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdNotLike(String value) {
            addCriterion("ROOM_PWD not like", value, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdIn(List<String> values) {
            addCriterion("ROOM_PWD in", values, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdNotIn(List<String> values) {
            addCriterion("ROOM_PWD not in", values, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdBetween(String value1, String value2) {
            addCriterion("ROOM_PWD between", value1, value2, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andRoomPwdNotBetween(String value1, String value2) {
            addCriterion("ROOM_PWD not between", value1, value2, "roomPwd");
            return (Criteria) this;
        }

        public Criteria andServerAddrIsNull() {
            addCriterion("SERVER_ADDR is null");
            return (Criteria) this;
        }

        public Criteria andServerAddrIsNotNull() {
            addCriterion("SERVER_ADDR is not null");
            return (Criteria) this;
        }

        public Criteria andServerAddrEqualTo(String value) {
            addCriterion("SERVER_ADDR =", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrNotEqualTo(String value) {
            addCriterion("SERVER_ADDR <>", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrGreaterThan(String value) {
            addCriterion("SERVER_ADDR >", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrGreaterThanOrEqualTo(String value) {
            addCriterion("SERVER_ADDR >=", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrLessThan(String value) {
            addCriterion("SERVER_ADDR <", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrLessThanOrEqualTo(String value) {
            addCriterion("SERVER_ADDR <=", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrLike(String value) {
            addCriterion("SERVER_ADDR like", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrNotLike(String value) {
            addCriterion("SERVER_ADDR not like", value, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrIn(List<String> values) {
            addCriterion("SERVER_ADDR in", values, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrNotIn(List<String> values) {
            addCriterion("SERVER_ADDR not in", values, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrBetween(String value1, String value2) {
            addCriterion("SERVER_ADDR between", value1, value2, "serverAddr");
            return (Criteria) this;
        }

        public Criteria andServerAddrNotBetween(String value1, String value2) {
            addCriterion("SERVER_ADDR not between", value1, value2, "serverAddr");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table hst_room
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
     * This class corresponds to the database table hst_room
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