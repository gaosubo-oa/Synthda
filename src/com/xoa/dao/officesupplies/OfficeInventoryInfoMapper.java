package com.xoa.dao.officesupplies;

import com.xoa.model.officesupplies.OfficeInventoryInfo;

import java.util.List;
import java.util.Map;

public interface OfficeInventoryInfoMapper {
    int addOfficeInventoryInfo(OfficeInventoryInfo officeInventoryInfo);

    List<OfficeInventoryInfo> selectOfficeInventoryInfo(Map<String, Object> map);

    OfficeInventoryInfo selectLastOfficeInventoryInfo(Integer proId);

}
