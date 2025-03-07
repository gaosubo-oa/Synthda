package com.xoa.service.extfield;

import com.xoa.model.extfield.FieldSet;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface FieldSetService {
    ToJson<FieldSet> addFieldSet(FieldSet fieldSet);

    ToJson<FieldSet> deleteFieldSet(String tabName, String fieldNo);

    ToJson<FieldSet> updateFieldSet(FieldSet fieldSet);

    ToJson<FieldSet> selectFieldSet(HttpServletRequest request, Map<String, Object> map, Integer page, Integer limit, boolean useFlag, String fieldNo,String tabName);

    ToJson<FieldSet> selectFieldSetAndData(String tabName, String identyId);
}
