package com.xoa.service.smsDelivery;

import com.xoa.model.sms2.Sms2;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public interface Sms2Service {

    ToJson<Sms2> selectSms2(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, boolean useFlag, Sms2 sms2,String beginDate, String endDate, String fromIds);
    ToJson selectSms2ById(HttpServletRequest request, Integer id);
    ToJson insertSms2(Sms2 sms2);
    ToJson delSms2(Sms2 sms2,String beginDate, String endDate, String smsIds, String fromIds);
    ToJson upSms2(Sms2 sms2);
    public BaseWrapper sendMessageByExcel(MultipartFile file);


    ToJson SendSms();
    ToJson sendSmsByUserOrDept(String beginDate, String endDate, String way, Integer page, Integer pageSize, boolean useFlag);
    ToJson delSmsByUserOrDept(String beginDate, String endDate, String fromId, Integer deptId);
}