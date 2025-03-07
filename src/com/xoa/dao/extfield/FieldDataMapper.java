package com.xoa.dao.extfield;

import com.xoa.model.extfield.FieldData;
import com.xoa.model.extfield.FieldDataSet;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FieldDataMapper {
    FieldData selectFieldData(Map<String, Object> fieldDataMap);

    int updateFieldData(FieldData fieldData);

    int addFieldData(FieldData fieldData);

    List<FieldData> selectFieldDataByidentyId(@Param("identyId") String identyId, @Param("tabName") String tabName);

    List<FieldDataSet>  selectFieldDataByidentyIdAndfieldNo(@Param("identyId") String identyId, @Param("tabName") String tabName);
}
