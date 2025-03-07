package com.xoa.dao.extfield;

import com.xoa.model.extfield.FieldSet;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FieldSetMapper {
    int addFieldSet(FieldSet fieldSet);

    String selectMaxFieldNo(Map<String, Object> map);

    int deleteFieldSet(@Param("tabName")String tabName, @Param("fieldNo")String fieldNo);

    int updateFieldSet(FieldSet fieldSet);

    List<FieldSet> selectFieldSet(Map<String, Object> map);

    int selectIsRepeatFieldName(Map<String, Object> map);
}
