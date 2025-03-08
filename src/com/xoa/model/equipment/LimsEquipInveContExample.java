package com.xoa.model.equipment;

import java.util.ArrayList;
import java.util.List;

public class LimsEquipInveContExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public LimsEquipInveContExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
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
     * This method corresponds to the database table lims_equip_inve_cont
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
     * This method corresponds to the database table lims_equip_inve_cont
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_inve_cont
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
     * This class corresponds to the database table lims_equip_inve_cont
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

        public Criteria andContIdIsNull() {
            addCriterion("CONT_ID is null");
            return (Criteria) this;
        }

        public Criteria andContIdIsNotNull() {
            addCriterion("CONT_ID is not null");
            return (Criteria) this;
        }

        public Criteria andContIdEqualTo(Integer value) {
            addCriterion("CONT_ID =", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdNotEqualTo(Integer value) {
            addCriterion("CONT_ID <>", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdGreaterThan(Integer value) {
            addCriterion("CONT_ID >", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("CONT_ID >=", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdLessThan(Integer value) {
            addCriterion("CONT_ID <", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdLessThanOrEqualTo(Integer value) {
            addCriterion("CONT_ID <=", value, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdIn(List<Integer> values) {
            addCriterion("CONT_ID in", values, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdNotIn(List<Integer> values) {
            addCriterion("CONT_ID not in", values, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdBetween(Integer value1, Integer value2) {
            addCriterion("CONT_ID between", value1, value2, "contId");
            return (Criteria) this;
        }

        public Criteria andContIdNotBetween(Integer value1, Integer value2) {
            addCriterion("CONT_ID not between", value1, value2, "contId");
            return (Criteria) this;
        }

        public Criteria andInveIdIsNull() {
            addCriterion("INVE_ID is null");
            return (Criteria) this;
        }

        public Criteria andInveIdIsNotNull() {
            addCriterion("INVE_ID is not null");
            return (Criteria) this;
        }

        public Criteria andInveIdEqualTo(Integer value) {
            addCriterion("INVE_ID =", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdNotEqualTo(Integer value) {
            addCriterion("INVE_ID <>", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdGreaterThan(Integer value) {
            addCriterion("INVE_ID >", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("INVE_ID >=", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdLessThan(Integer value) {
            addCriterion("INVE_ID <", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdLessThanOrEqualTo(Integer value) {
            addCriterion("INVE_ID <=", value, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdIn(List<Integer> values) {
            addCriterion("INVE_ID in", values, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdNotIn(List<Integer> values) {
            addCriterion("INVE_ID not in", values, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdBetween(Integer value1, Integer value2) {
            addCriterion("INVE_ID between", value1, value2, "inveId");
            return (Criteria) this;
        }

        public Criteria andInveIdNotBetween(Integer value1, Integer value2) {
            addCriterion("INVE_ID not between", value1, value2, "inveId");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnIsNull() {
            addCriterion("EQUIP_NO_YN is null");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnIsNotNull() {
            addCriterion("EQUIP_NO_YN is not null");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnEqualTo(String value) {
            addCriterion("EQUIP_NO_YN =", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnNotEqualTo(String value) {
            addCriterion("EQUIP_NO_YN <>", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnGreaterThan(String value) {
            addCriterion("EQUIP_NO_YN >", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnGreaterThanOrEqualTo(String value) {
            addCriterion("EQUIP_NO_YN >=", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnLessThan(String value) {
            addCriterion("EQUIP_NO_YN <", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnLessThanOrEqualTo(String value) {
            addCriterion("EQUIP_NO_YN <=", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnLike(String value) {
            addCriterion("EQUIP_NO_YN like", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnNotLike(String value) {
            addCriterion("EQUIP_NO_YN not like", value, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnIn(List<String> values) {
            addCriterion("EQUIP_NO_YN in", values, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnNotIn(List<String> values) {
            addCriterion("EQUIP_NO_YN not in", values, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnBetween(String value1, String value2) {
            addCriterion("EQUIP_NO_YN between", value1, value2, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andEquipNoYnNotBetween(String value1, String value2) {
            addCriterion("EQUIP_NO_YN not between", value1, value2, "equipNoYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnIsNull() {
            addCriterion("DEPT_ID_YN is null");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnIsNotNull() {
            addCriterion("DEPT_ID_YN is not null");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnEqualTo(Integer value) {
            addCriterion("DEPT_ID_YN =", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnNotEqualTo(Integer value) {
            addCriterion("DEPT_ID_YN <>", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnGreaterThan(Integer value) {
            addCriterion("DEPT_ID_YN >", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnGreaterThanOrEqualTo(Integer value) {
            addCriterion("DEPT_ID_YN >=", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnLessThan(Integer value) {
            addCriterion("DEPT_ID_YN <", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnLessThanOrEqualTo(Integer value) {
            addCriterion("DEPT_ID_YN <=", value, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnIn(List<Integer> values) {
            addCriterion("DEPT_ID_YN in", values, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnNotIn(List<Integer> values) {
            addCriterion("DEPT_ID_YN not in", values, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnBetween(Integer value1, Integer value2) {
            addCriterion("DEPT_ID_YN between", value1, value2, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andDeptIdYnNotBetween(Integer value1, Integer value2) {
            addCriterion("DEPT_ID_YN not between", value1, value2, "deptIdYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnIsNull() {
            addCriterion("EQUIP_STATUAS_CODE_YN is null");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnIsNotNull() {
            addCriterion("EQUIP_STATUAS_CODE_YN is not null");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnEqualTo(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN =", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnNotEqualTo(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN <>", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnGreaterThan(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN >", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnGreaterThanOrEqualTo(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN >=", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnLessThan(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN <", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnLessThanOrEqualTo(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN <=", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnLike(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN like", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnNotLike(String value) {
            addCriterion("EQUIP_STATUAS_CODE_YN not like", value, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnIn(List<String> values) {
            addCriterion("EQUIP_STATUAS_CODE_YN in", values, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnNotIn(List<String> values) {
            addCriterion("EQUIP_STATUAS_CODE_YN not in", values, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnBetween(String value1, String value2) {
            addCriterion("EQUIP_STATUAS_CODE_YN between", value1, value2, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andEquipStatuasCodeYnNotBetween(String value1, String value2) {
            addCriterion("EQUIP_STATUAS_CODE_YN not between", value1, value2, "equipStatuasCodeYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnIsNull() {
            addCriterion("MODEL_NO_YN is null");
            return (Criteria) this;
        }

        public Criteria andModelNoYnIsNotNull() {
            addCriterion("MODEL_NO_YN is not null");
            return (Criteria) this;
        }

        public Criteria andModelNoYnEqualTo(Integer value) {
            addCriterion("MODEL_NO_YN =", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnNotEqualTo(Integer value) {
            addCriterion("MODEL_NO_YN <>", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnGreaterThan(Integer value) {
            addCriterion("MODEL_NO_YN >", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnGreaterThanOrEqualTo(Integer value) {
            addCriterion("MODEL_NO_YN >=", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnLessThan(Integer value) {
            addCriterion("MODEL_NO_YN <", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnLessThanOrEqualTo(Integer value) {
            addCriterion("MODEL_NO_YN <=", value, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnIn(List<Integer> values) {
            addCriterion("MODEL_NO_YN in", values, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnNotIn(List<Integer> values) {
            addCriterion("MODEL_NO_YN not in", values, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnBetween(Integer value1, Integer value2) {
            addCriterion("MODEL_NO_YN between", value1, value2, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andModelNoYnNotBetween(Integer value1, Integer value2) {
            addCriterion("MODEL_NO_YN not between", value1, value2, "modelNoYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnIsNull() {
            addCriterion("ASSETS_COST_YN is null");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnIsNotNull() {
            addCriterion("ASSETS_COST_YN is not null");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnEqualTo(String value) {
            addCriterion("ASSETS_COST_YN =", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnNotEqualTo(String value) {
            addCriterion("ASSETS_COST_YN <>", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnGreaterThan(String value) {
            addCriterion("ASSETS_COST_YN >", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnGreaterThanOrEqualTo(String value) {
            addCriterion("ASSETS_COST_YN >=", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnLessThan(String value) {
            addCriterion("ASSETS_COST_YN <", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnLessThanOrEqualTo(String value) {
            addCriterion("ASSETS_COST_YN <=", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnLike(String value) {
            addCriterion("ASSETS_COST_YN like", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnNotLike(String value) {
            addCriterion("ASSETS_COST_YN not like", value, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnIn(List<String> values) {
            addCriterion("ASSETS_COST_YN in", values, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnNotIn(List<String> values) {
            addCriterion("ASSETS_COST_YN not in", values, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnBetween(String value1, String value2) {
            addCriterion("ASSETS_COST_YN between", value1, value2, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andAssetsCostYnNotBetween(String value1, String value2) {
            addCriterion("ASSETS_COST_YN not between", value1, value2, "assetsCostYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnIsNull() {
            addCriterion("MANUFACTURER_YN is null");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnIsNotNull() {
            addCriterion("MANUFACTURER_YN is not null");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnEqualTo(String value) {
            addCriterion("MANUFACTURER_YN =", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnNotEqualTo(String value) {
            addCriterion("MANUFACTURER_YN <>", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnGreaterThan(String value) {
            addCriterion("MANUFACTURER_YN >", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnGreaterThanOrEqualTo(String value) {
            addCriterion("MANUFACTURER_YN >=", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnLessThan(String value) {
            addCriterion("MANUFACTURER_YN <", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnLessThanOrEqualTo(String value) {
            addCriterion("MANUFACTURER_YN <=", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnLike(String value) {
            addCriterion("MANUFACTURER_YN like", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnNotLike(String value) {
            addCriterion("MANUFACTURER_YN not like", value, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnIn(List<String> values) {
            addCriterion("MANUFACTURER_YN in", values, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnNotIn(List<String> values) {
            addCriterion("MANUFACTURER_YN not in", values, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnBetween(String value1, String value2) {
            addCriterion("MANUFACTURER_YN between", value1, value2, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andManufacturerYnNotBetween(String value1, String value2) {
            addCriterion("MANUFACTURER_YN not between", value1, value2, "manufacturerYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnIsNull() {
            addCriterion("SUPPLIER_YN is null");
            return (Criteria) this;
        }

        public Criteria andSupplierYnIsNotNull() {
            addCriterion("SUPPLIER_YN is not null");
            return (Criteria) this;
        }

        public Criteria andSupplierYnEqualTo(String value) {
            addCriterion("SUPPLIER_YN =", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnNotEqualTo(String value) {
            addCriterion("SUPPLIER_YN <>", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnGreaterThan(String value) {
            addCriterion("SUPPLIER_YN >", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnGreaterThanOrEqualTo(String value) {
            addCriterion("SUPPLIER_YN >=", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnLessThan(String value) {
            addCriterion("SUPPLIER_YN <", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnLessThanOrEqualTo(String value) {
            addCriterion("SUPPLIER_YN <=", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnLike(String value) {
            addCriterion("SUPPLIER_YN like", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnNotLike(String value) {
            addCriterion("SUPPLIER_YN not like", value, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnIn(List<String> values) {
            addCriterion("SUPPLIER_YN in", values, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnNotIn(List<String> values) {
            addCriterion("SUPPLIER_YN not in", values, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnBetween(String value1, String value2) {
            addCriterion("SUPPLIER_YN between", value1, value2, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andSupplierYnNotBetween(String value1, String value2) {
            addCriterion("SUPPLIER_YN not between", value1, value2, "supplierYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnIsNull() {
            addCriterion("FACTORY_NO_YN is null");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnIsNotNull() {
            addCriterion("FACTORY_NO_YN is not null");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnEqualTo(String value) {
            addCriterion("FACTORY_NO_YN =", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnNotEqualTo(String value) {
            addCriterion("FACTORY_NO_YN <>", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnGreaterThan(String value) {
            addCriterion("FACTORY_NO_YN >", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnGreaterThanOrEqualTo(String value) {
            addCriterion("FACTORY_NO_YN >=", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnLessThan(String value) {
            addCriterion("FACTORY_NO_YN <", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnLessThanOrEqualTo(String value) {
            addCriterion("FACTORY_NO_YN <=", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnLike(String value) {
            addCriterion("FACTORY_NO_YN like", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnNotLike(String value) {
            addCriterion("FACTORY_NO_YN not like", value, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnIn(List<String> values) {
            addCriterion("FACTORY_NO_YN in", values, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnNotIn(List<String> values) {
            addCriterion("FACTORY_NO_YN not in", values, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnBetween(String value1, String value2) {
            addCriterion("FACTORY_NO_YN between", value1, value2, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andFactoryNoYnNotBetween(String value1, String value2) {
            addCriterion("FACTORY_NO_YN not between", value1, value2, "factoryNoYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnIsNull() {
            addCriterion("POSITION_ID_YN is null");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnIsNotNull() {
            addCriterion("POSITION_ID_YN is not null");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnEqualTo(Integer value) {
            addCriterion("POSITION_ID_YN =", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnNotEqualTo(Integer value) {
            addCriterion("POSITION_ID_YN <>", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnGreaterThan(Integer value) {
            addCriterion("POSITION_ID_YN >", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnGreaterThanOrEqualTo(Integer value) {
            addCriterion("POSITION_ID_YN >=", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnLessThan(Integer value) {
            addCriterion("POSITION_ID_YN <", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnLessThanOrEqualTo(Integer value) {
            addCriterion("POSITION_ID_YN <=", value, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnIn(List<Integer> values) {
            addCriterion("POSITION_ID_YN in", values, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnNotIn(List<Integer> values) {
            addCriterion("POSITION_ID_YN not in", values, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnBetween(Integer value1, Integer value2) {
            addCriterion("POSITION_ID_YN between", value1, value2, "positionIdYn");
            return (Criteria) this;
        }

        public Criteria andPositionIdYnNotBetween(Integer value1, Integer value2) {
            addCriterion("POSITION_ID_YN not between", value1, value2, "positionIdYn");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table lims_equip_inve_cont
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
     * This class corresponds to the database table lims_equip_inve_cont
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