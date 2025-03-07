package com.xoa.dao.gw_device;

import com.xoa.model.gw_device.GwDeviceAll;
import com.xoa.model.gw_device.GwDeviceServer;

import java.util.List;
import java.util.Map;

public interface GwDeviceServerMapper {
    int deleteByPrimaryKey(Integer serverId);

    int insert(GwDeviceServer record);

    int insertSelective(GwDeviceServer record);

    GwDeviceServer selectByPrimaryKey(Integer serverId);

    int updateByPrimaryKeySelective(GwDeviceServer record);

    int updateByPrimaryKeyWithBLOBs(GwDeviceServer record);

    int updateByPrimaryKey(GwDeviceServer record);

    List<GwDeviceServer> serch(Map map);

    int insertByObject(GwDeviceAll gwDeviceAll);

    int updateByObject(GwDeviceAll gwDeviceAll);
}