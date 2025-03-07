package com.xoa.service.smssetting.impl;


import com.xoa.dao.smsSettings.SmsSettingsMapper;
import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.service.smssetting.SmsSettingsService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/12/13.
 */
@Service
public class SmsSettingsServiceImpl implements SmsSettingsService
{

    @Autowired
    private SmsSettingsMapper smsSettingsMapper;

    @Transactional
    public ToJson insertSmsSettings(SmsSettings smsSettings) {
        ToJson<SmsSettings> toJson = new ToJson<SmsSettings>(1, "error");
        try {
            int temp = smsSettingsMapper.insertSelective(smsSettings);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return toJson;

    }

    @Transactional
    public ToJson delSmsSettings(int id) {
        ToJson toJson = new ToJson(1, "error");
        try {
            int temp = smsSettingsMapper.deleteByPrimaryKey(id);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Transactional
    public ToJson upSmsSettings(SmsSettings smsSettings) {
        ToJson toJson = new ToJson<>(1, "error");

        try {
            int temp = smsSettingsMapper.updateByPrimaryKeySelective(smsSettings);
            int id = 0;
            if (temp > 0) {
                if (!smsSettings.getState().equals("0")) {
                    List<SmsSettings> list = smsSettingsMapper.selectSmsSettingsState(smsSettings.getId());
                    for (int i = 0; i < list.size(); i++) {
                        id = list.get(i).getId();
                        smsSettingsMapper.upSmsSettingsState(id);
                    }
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Transactional
public ToJson selectSmsSettings() {
    ToJson<SmsSettings> toJson = new ToJson<>(1, "error");
    Map<String, Object> map = new HashMap<String, Object>();
    try {
       List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(map);
          /*  SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(pzFullRelease.getpOutPrisonTime());
            pzFullRelease.setOutTime(format);

            String format1 = sdf.format(pzFullRelease.getpJoinDate());
            pzFullRelease.setJoinDate(format1);*/

        if (list.size()>0) {
            toJson.setObj(list);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }
    } catch (Exception e) {

        toJson.setFlag(1);
        toJson.setMsg(e.getMessage());
        e.printStackTrace();
    }


    return toJson;
}
    @Transactional
    public ToJson selectSmsSettingsAll() {
        ToJson<SmsSettings> toJson = new ToJson<>(1, "error");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<SmsSettings> list = smsSettingsMapper.selectSmsSettingsAll(map);
          /*  SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(pzFullRelease.getpOutPrisonTime());
            pzFullRelease.setOutTime(format);

            String format1 = sdf.format(pzFullRelease.getpJoinDate());
            pzFullRelease.setJoinDate(format1);*/

            if (list.size() > 0) {
                toJson.setObj(list);
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {

            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }


        return toJson;
    }

    @Transactional
    public ToJson selectSmsSettingsById(HttpServletRequest request, Integer id) {
        ToJson<SmsSettings> toJson = new ToJson<>(1, "error");
        try {
            SmsSettings smsSettings = smsSettingsMapper.selectByPrimaryKey(id);
          /*  SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(pzFullRelease.getpOutPrisonTime());
            pzFullRelease.setOutTime(format);

            String format1 = sdf.format(pzFullRelease.getpJoinDate());
            pzFullRelease.setJoinDate(format1);*/

            toJson.setObject(smsSettings);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {

            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }
}
