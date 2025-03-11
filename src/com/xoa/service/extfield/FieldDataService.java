package com.xoa.service.extfield;

import com.xoa.model.extfield.FieldData;
import com.xoa.util.ToJson;

public interface FieldDataService {

    ToJson<FieldData>  updateFieldData(String tabName, String identyId, String strJson);

    ToJson<FieldData>  selectFieldDataByidentyId(String identyId,String tabName);


}
