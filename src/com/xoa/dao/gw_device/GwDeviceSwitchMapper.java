package com.xoa.dao.gw_device;

import com.xoa.model.gw_device.GwDeviceAll;
import com.xoa.model.gw_device.GwDeviceSwitch;

import java.util.List;
import java.util.Map;

public interface GwDeviceSwitchMapper {
    int deleteByPrimaryKey(Integer switchId);

    int insert(GwDeviceSwitch record);

    int insertSelective(GwDeviceSwitch record);

    GwDeviceSwitch selectByPrimaryKey(Integer switchId);

    int updateByPrimaryKeySelective(GwDeviceSwitch record);

    int updateByPrimaryKeyWithBLOBs(GwDeviceSwitch record);

    int updateByPrimaryKey(GwDeviceSwitch record);

    List<GwDeviceSwitch> serch(Map map);

    int insertByObject(GwDeviceAll gwDeviceAll);

    int updateByObject(GwDeviceAll gwDeviceAll);
}