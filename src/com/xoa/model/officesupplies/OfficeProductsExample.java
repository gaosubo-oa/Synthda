package com.xoa.model.officesupplies;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OfficeProductsExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table office_products
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table office_products
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table office_products
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public OfficeProductsExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
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
     * This method corresponds to the database table office_products
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
     * This method corresponds to the database table office_products
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_products
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
     * This class corresponds to the database table office_products
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

        public Criteria andProIdIsNull() {
            addCriterion("PRO_ID is null");
            return (Criteria) this;
        }

        public Criteria andProIdIsNotNull() {
            addCriterion("PRO_ID is not null");
            return (Criteria) this;
        }

        public Criteria andProIdEqualTo(Integer value) {
            addCriterion("PRO_ID =", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdNotEqualTo(Integer value) {
            addCriterion("PRO_ID <>", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdGreaterThan(Integer value) {
            addCriterion("PRO_ID >", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("PRO_ID >=", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdLessThan(Integer value) {
            addCriterion("PRO_ID <", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdLessThanOrEqualTo(Integer value) {
            addCriterion("PRO_ID <=", value, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdIn(List<Integer> values) {
            addCriterion("PRO_ID in", values, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdNotIn(List<Integer> values) {
            addCriterion("PRO_ID not in", values, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdBetween(Integer value1, Integer value2) {
            addCriterion("PRO_ID between", value1, value2, "proId");
            return (Criteria) this;
        }

        public Criteria andProIdNotBetween(Integer value1, Integer value2) {
            addCriterion("PRO_ID not between", value1, value2, "proId");
            return (Criteria) this;
        }

        public Criteria andProNameIsNull() {
            addCriterion("PRO_NAME is null");
            return (Criteria) this;
        }

        public Criteria andProNameIsNotNull() {
            addCriterion("PRO_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andProNameEqualTo(String value) {
            addCriterion("PRO_NAME =", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameNotEqualTo(String value) {
            addCriterion("PRO_NAME <>", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameGreaterThan(String value) {
            addCriterion("PRO_NAME >", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameGreaterThanOrEqualTo(String value) {
            addCriterion("PRO_NAME >=", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameLessThan(String value) {
            addCriterion("PRO_NAME <", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameLessThanOrEqualTo(String value) {
            addCriterion("PRO_NAME <=", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameLike(String value) {
            addCriterion("PRO_NAME like", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameNotLike(String value) {
            addCriterion("PRO_NAME not like", value, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameIn(List<String> values) {
            addCriterion("PRO_NAME in", values, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameNotIn(List<String> values) {
            addCriterion("PRO_NAME not in", values, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameBetween(String value1, String value2) {
            addCriterion("PRO_NAME between", value1, value2, "proName");
            return (Criteria) this;
        }

        public Criteria andProNameNotBetween(String value1, String value2) {
            addCriterion("PRO_NAME not between", value1, value2, "proName");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeIsNull() {
            addCriterion("OFFICE_PROTYPE is null");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeIsNotNull() {
            addCriterion("OFFICE_PROTYPE is not null");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeEqualTo(String value) {
            addCriterion("OFFICE_PROTYPE =", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeNotEqualTo(String value) {
            addCriterion("OFFICE_PROTYPE <>", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeGreaterThan(String value) {
            addCriterion("OFFICE_PROTYPE >", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeGreaterThanOrEqualTo(String value) {
            addCriterion("OFFICE_PROTYPE >=", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeLessThan(String value) {
            addCriterion("OFFICE_PROTYPE <", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeLessThanOrEqualTo(String value) {
            addCriterion("OFFICE_PROTYPE <=", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeLike(String value) {
            addCriterion("OFFICE_PROTYPE like", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeNotLike(String value) {
            addCriterion("OFFICE_PROTYPE not like", value, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeIn(List<String> values) {
            addCriterion("OFFICE_PROTYPE in", values, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeNotIn(List<String> values) {
            addCriterion("OFFICE_PROTYPE not in", values, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeBetween(String value1, String value2) {
            addCriterion("OFFICE_PROTYPE between", value1, value2, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andOfficeProtypeNotBetween(String value1, String value2) {
            addCriterion("OFFICE_PROTYPE not between", value1, value2, "officeProtype");
            return (Criteria) this;
        }

        public Criteria andProCodeIsNull() {
            addCriterion("PRO_CODE is null");
            return (Criteria) this;
        }

        public Criteria andProCodeIsNotNull() {
            addCriterion("PRO_CODE is not null");
            return (Criteria) this;
        }

        public Criteria andProCodeEqualTo(String value) {
            addCriterion("PRO_CODE =", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeNotEqualTo(String value) {
            addCriterion("PRO_CODE <>", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeGreaterThan(String value) {
            addCriterion("PRO_CODE >", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeGreaterThanOrEqualTo(String value) {
            addCriterion("PRO_CODE >=", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeLessThan(String value) {
            addCriterion("PRO_CODE <", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeLessThanOrEqualTo(String value) {
            addCriterion("PRO_CODE <=", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeLike(String value) {
            addCriterion("PRO_CODE like", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeNotLike(String value) {
            addCriterion("PRO_CODE not like", value, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeIn(List<String> values) {
            addCriterion("PRO_CODE in", values, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeNotIn(List<String> values) {
            addCriterion("PRO_CODE not in", values, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeBetween(String value1, String value2) {
            addCriterion("PRO_CODE between", value1, value2, "proCode");
            return (Criteria) this;
        }

        public Criteria andProCodeNotBetween(String value1, String value2) {
            addCriterion("PRO_CODE not between", value1, value2, "proCode");
            return (Criteria) this;
        }

        public Criteria andProUnitIsNull() {
            addCriterion("PRO_UNIT is null");
            return (Criteria) this;
        }

        public Criteria andProUnitIsNotNull() {
            addCriterion("PRO_UNIT is not null");
            return (Criteria) this;
        }

        public Criteria andProUnitEqualTo(String value) {
            addCriterion("PRO_UNIT =", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitNotEqualTo(String value) {
            addCriterion("PRO_UNIT <>", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitGreaterThan(String value) {
            addCriterion("PRO_UNIT >", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitGreaterThanOrEqualTo(String value) {
            addCriterion("PRO_UNIT >=", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitLessThan(String value) {
            addCriterion("PRO_UNIT <", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitLessThanOrEqualTo(String value) {
            addCriterion("PRO_UNIT <=", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitLike(String value) {
            addCriterion("PRO_UNIT like", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitNotLike(String value) {
            addCriterion("PRO_UNIT not like", value, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitIn(List<String> values) {
            addCriterion("PRO_UNIT in", values, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitNotIn(List<String> values) {
            addCriterion("PRO_UNIT not in", values, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitBetween(String value1, String value2) {
            addCriterion("PRO_UNIT between", value1, value2, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProUnitNotBetween(String value1, String value2) {
            addCriterion("PRO_UNIT not between", value1, value2, "proUnit");
            return (Criteria) this;
        }

        public Criteria andProPriceIsNull() {
            addCriterion("PRO_PRICE is null");
            return (Criteria) this;
        }

        public Criteria andProPriceIsNotNull() {
            addCriterion("PRO_PRICE is not null");
            return (Criteria) this;
        }

        public Criteria andProPriceEqualTo(BigDecimal value) {
            addCriterion("PRO_PRICE =", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceNotEqualTo(BigDecimal value) {
            addCriterion("PRO_PRICE <>", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceGreaterThan(BigDecimal value) {
            addCriterion("PRO_PRICE >", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("PRO_PRICE >=", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceLessThan(BigDecimal value) {
            addCriterion("PRO_PRICE <", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceLessThanOrEqualTo(BigDecimal value) {
            addCriterion("PRO_PRICE <=", value, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceIn(List<BigDecimal> values) {
            addCriterion("PRO_PRICE in", values, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceNotIn(List<BigDecimal> values) {
            addCriterion("PRO_PRICE not in", values, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PRO_PRICE between", value1, value2, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProPriceNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PRO_PRICE not between", value1, value2, "proPrice");
            return (Criteria) this;
        }

        public Criteria andProLowstockIsNull() {
            addCriterion("PRO_LOWSTOCK is null");
            return (Criteria) this;
        }

        public Criteria andProLowstockIsNotNull() {
            addCriterion("PRO_LOWSTOCK is not null");
            return (Criteria) this;
        }

        public Criteria andProLowstockEqualTo(Integer value) {
            addCriterion("PRO_LOWSTOCK =", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockNotEqualTo(Integer value) {
            addCriterion("PRO_LOWSTOCK <>", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockGreaterThan(Integer value) {
            addCriterion("PRO_LOWSTOCK >", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockGreaterThanOrEqualTo(Integer value) {
            addCriterion("PRO_LOWSTOCK >=", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockLessThan(Integer value) {
            addCriterion("PRO_LOWSTOCK <", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockLessThanOrEqualTo(Integer value) {
            addCriterion("PRO_LOWSTOCK <=", value, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockIn(List<Integer> values) {
            addCriterion("PRO_LOWSTOCK in", values, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockNotIn(List<Integer> values) {
            addCriterion("PRO_LOWSTOCK not in", values, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockBetween(Integer value1, Integer value2) {
            addCriterion("PRO_LOWSTOCK between", value1, value2, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProLowstockNotBetween(Integer value1, Integer value2) {
            addCriterion("PRO_LOWSTOCK not between", value1, value2, "proLowstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockIsNull() {
            addCriterion("PRO_MAXSTOCK is null");
            return (Criteria) this;
        }

        public Criteria andProMaxstockIsNotNull() {
            addCriterion("PRO_MAXSTOCK is not null");
            return (Criteria) this;
        }

        public Criteria andProMaxstockEqualTo(Integer value) {
            addCriterion("PRO_MAXSTOCK =", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockNotEqualTo(Integer value) {
            addCriterion("PRO_MAXSTOCK <>", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockGreaterThan(Integer value) {
            addCriterion("PRO_MAXSTOCK >", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockGreaterThanOrEqualTo(Integer value) {
            addCriterion("PRO_MAXSTOCK >=", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockLessThan(Integer value) {
            addCriterion("PRO_MAXSTOCK <", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockLessThanOrEqualTo(Integer value) {
            addCriterion("PRO_MAXSTOCK <=", value, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockIn(List<Integer> values) {
            addCriterion("PRO_MAXSTOCK in", values, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockNotIn(List<Integer> values) {
            addCriterion("PRO_MAXSTOCK not in", values, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockBetween(Integer value1, Integer value2) {
            addCriterion("PRO_MAXSTOCK between", value1, value2, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProMaxstockNotBetween(Integer value1, Integer value2) {
            addCriterion("PRO_MAXSTOCK not between", value1, value2, "proMaxstock");
            return (Criteria) this;
        }

        public Criteria andProStockIsNull() {
            addCriterion("PRO_STOCK is null");
            return (Criteria) this;
        }

        public Criteria andProStockIsNotNull() {
            addCriterion("PRO_STOCK is not null");
            return (Criteria) this;
        }

        public Criteria andProStockEqualTo(Integer value) {
            addCriterion("PRO_STOCK =", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockNotEqualTo(Integer value) {
            addCriterion("PRO_STOCK <>", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockGreaterThan(Integer value) {
            addCriterion("PRO_STOCK >", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockGreaterThanOrEqualTo(Integer value) {
            addCriterion("PRO_STOCK >=", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockLessThan(Integer value) {
            addCriterion("PRO_STOCK <", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockLessThanOrEqualTo(Integer value) {
            addCriterion("PRO_STOCK <=", value, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockIn(List<Integer> values) {
            addCriterion("PRO_STOCK in", values, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockNotIn(List<Integer> values) {
            addCriterion("PRO_STOCK not in", values, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockBetween(Integer value1, Integer value2) {
            addCriterion("PRO_STOCK between", value1, value2, "proStock");
            return (Criteria) this;
        }

        public Criteria andProStockNotBetween(Integer value1, Integer value2) {
            addCriterion("PRO_STOCK not between", value1, value2, "proStock");
            return (Criteria) this;
        }

        public Criteria andProCreatorIsNull() {
            addCriterion("PRO_CREATOR is null");
            return (Criteria) this;
        }

        public Criteria andProCreatorIsNotNull() {
            addCriterion("PRO_CREATOR is not null");
            return (Criteria) this;
        }

        public Criteria andProCreatorEqualTo(String value) {
            addCriterion("PRO_CREATOR =", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorNotEqualTo(String value) {
            addCriterion("PRO_CREATOR <>", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorGreaterThan(String value) {
            addCriterion("PRO_CREATOR >", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorGreaterThanOrEqualTo(String value) {
            addCriterion("PRO_CREATOR >=", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorLessThan(String value) {
            addCriterion("PRO_CREATOR <", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorLessThanOrEqualTo(String value) {
            addCriterion("PRO_CREATOR <=", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorLike(String value) {
            addCriterion("PRO_CREATOR like", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorNotLike(String value) {
            addCriterion("PRO_CREATOR not like", value, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorIn(List<String> values) {
            addCriterion("PRO_CREATOR in", values, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorNotIn(List<String> values) {
            addCriterion("PRO_CREATOR not in", values, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorBetween(String value1, String value2) {
            addCriterion("PRO_CREATOR between", value1, value2, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProCreatorNotBetween(String value1, String value2) {
            addCriterion("PRO_CREATOR not between", value1, value2, "proCreator");
            return (Criteria) this;
        }

        public Criteria andProOrderIsNull() {
            addCriterion("PRO_ORDER is null");
            return (Criteria) this;
        }

        public Criteria andProOrderIsNotNull() {
            addCriterion("PRO_ORDER is not null");
            return (Criteria) this;
        }

        public Criteria andProOrderEqualTo(String value) {
            addCriterion("PRO_ORDER =", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderNotEqualTo(String value) {
            addCriterion("PRO_ORDER <>", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderGreaterThan(String value) {
            addCriterion("PRO_ORDER >", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderGreaterThanOrEqualTo(String value) {
            addCriterion("PRO_ORDER >=", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderLessThan(String value) {
            addCriterion("PRO_ORDER <", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderLessThanOrEqualTo(String value) {
            addCriterion("PRO_ORDER <=", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderLike(String value) {
            addCriterion("PRO_ORDER like", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderNotLike(String value) {
            addCriterion("PRO_ORDER not like", value, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderIn(List<String> values) {
            addCriterion("PRO_ORDER in", values, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderNotIn(List<String> values) {
            addCriterion("PRO_ORDER not in", values, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderBetween(String value1, String value2) {
            addCriterion("PRO_ORDER between", value1, value2, "proOrder");
            return (Criteria) this;
        }

        public Criteria andProOrderNotBetween(String value1, String value2) {
            addCriterion("PRO_ORDER not between", value1, value2, "proOrder");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeIsNull() {
            addCriterion("OFFICE_PRODUCT_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeIsNotNull() {
            addCriterion("OFFICE_PRODUCT_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeEqualTo(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE =", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeNotEqualTo(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE <>", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeGreaterThan(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE >", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE >=", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeLessThan(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE <", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeLessThanOrEqualTo(Integer value) {
            addCriterion("OFFICE_PRODUCT_TYPE <=", value, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeIn(List<Integer> values) {
            addCriterion("OFFICE_PRODUCT_TYPE in", values, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeNotIn(List<Integer> values) {
            addCriterion("OFFICE_PRODUCT_TYPE not in", values, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeBetween(Integer value1, Integer value2) {
            addCriterion("OFFICE_PRODUCT_TYPE between", value1, value2, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andOfficeProductTypeNotBetween(Integer value1, Integer value2) {
            addCriterion("OFFICE_PRODUCT_TYPE not between", value1, value2, "officeProductType");
            return (Criteria) this;
        }

        public Criteria andAllocationIsNull() {
            addCriterion("ALLOCATION is null");
            return (Criteria) this;
        }

        public Criteria andAllocationIsNotNull() {
            addCriterion("ALLOCATION is not null");
            return (Criteria) this;
        }

        public Criteria andAllocationEqualTo(Boolean value) {
            addCriterion("ALLOCATION =", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationNotEqualTo(Boolean value) {
            addCriterion("ALLOCATION <>", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationGreaterThan(Boolean value) {
            addCriterion("ALLOCATION >", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationGreaterThanOrEqualTo(Boolean value) {
            addCriterion("ALLOCATION >=", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationLessThan(Boolean value) {
            addCriterion("ALLOCATION <", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationLessThanOrEqualTo(Boolean value) {
            addCriterion("ALLOCATION <=", value, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationIn(List<Boolean> values) {
            addCriterion("ALLOCATION in", values, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationNotIn(List<Boolean> values) {
            addCriterion("ALLOCATION not in", values, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationBetween(Boolean value1, Boolean value2) {
            addCriterion("ALLOCATION between", value1, value2, "allocation");
            return (Criteria) this;
        }

        public Criteria andAllocationNotBetween(Boolean value1, Boolean value2) {
            addCriterion("ALLOCATION not between", value1, value2, "allocation");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table office_products
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
     * This class corresponds to the database table office_products
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