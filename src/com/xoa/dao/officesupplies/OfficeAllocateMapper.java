package com.xoa.dao.officesupplies;

import com.xoa.model.officesupplies.OfficeAllocate;

import java.util.List;
import java.util.Map;

public interface OfficeAllocateMapper {


    List<OfficeAllocate>  selectByMap(Map<String,Object> map);

    OfficeAllocate selectById(Integer id);

    int insertSelective(OfficeAllocate officeAllocate);


    int updateSelective(OfficeAllocate officeAllocate);

    int updateStatus(OfficeAllocate officeAllocate);


}
