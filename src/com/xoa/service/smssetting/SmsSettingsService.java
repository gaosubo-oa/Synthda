package com.xoa.service.smssetting;


import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2017/12/13.
 */
public interface SmsSettingsService {

    ToJson insertSmsSettings(SmsSettings smsSettings);
    ToJson delSmsSettings(int id);
    ToJson upSmsSettings(SmsSettings smsSettings);
    ToJson selectSmsSettings();

    ToJson selectSmsSettingsAll();
    ToJson selectSmsSettingsById(HttpServletRequest request, Integer id);


}
