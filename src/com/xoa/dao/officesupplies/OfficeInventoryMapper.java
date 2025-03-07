package com.xoa.dao.officesupplies;

import com.xoa.model.officesupplies.OfficeInventory;

import java.util.List;
import java.util.Map;

public interface OfficeInventoryMapper {
    List<OfficeInventory> selectOfficeInventory(Map<String, Object> map);

    int addOfficeInventory(OfficeInventory officeInventory);
}
