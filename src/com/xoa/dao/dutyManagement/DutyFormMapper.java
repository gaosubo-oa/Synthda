package com.xoa.dao.dutyManagement;

import com.xoa.model.dutyManagement.DutyForm;

import java.util.List;
import java.util.Map;

public interface DutyFormMapper {
    Integer addDutyFormManagement(DutyForm dutyForm);

    List<DutyForm> getDutyFormManagement(Map<String, Object> map);

    List<DutyForm> getDutyFormManagementAll();

    List<DutyForm> getDutyFormManagementListByUserId(Map<String, Object> map);

    List<DutyForm> getDutyFormRemind(Map<String, Object> map);

    DutyForm getDutyFormById(Integer dutyId);

    Integer delDutyFormById(Integer dutyId);

    Integer updDutyFormById(DutyForm dutyForm);

    Integer delDutyFormAll();

    Integer delDutyFormByDutyIds(String[] dutyIds);

    List<DutyForm> getDutyFormManagementByAllId(Map<String, Object> map);

    Integer getDutyFormManagementByAll(Map<String, Object> map);

    String getUserPrivById(Integer privId);

    String getUserById(Integer userId);

    Integer getSmsBodyBodyId(String url);

    Integer updSmsByUserIdAndBodyId(Map<String, Object> map);

    List<DutyForm> getdutyformList(Map map);

    Integer getCountdutyformList(Map map);
}
