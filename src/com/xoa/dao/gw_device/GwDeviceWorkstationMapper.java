package com.xoa.dao.gw_device;

import com.xoa.model.gw_device.GwDeviceAll;
import com.xoa.model.gw_device.GwDeviceWorkstation;

import java.util.List;
import java.util.Map;

public interface GwDeviceWorkstationMapper {
    int deleteByPrimaryKey(Integer stationId);

    int insert(GwDeviceWorkstation record);

    int insertSelective(GwDeviceWorkstation record);

    GwDeviceWorkstation selectByPrimaryKey(Integer stationId);

    int updateByPrimaryKeySelective(GwDeviceWorkstation record);

    int updateByPrimaryKeyWithBLOBs(GwDeviceWorkstation record);

    int updateByPrimaryKey(GwDeviceWorkstation record);

    List<GwDeviceWorkstation> serch(Map map);

    int insertByObject(GwDeviceAll gwDeviceAll);

    int updateByObject(GwDeviceAll gwDeviceAll);
}