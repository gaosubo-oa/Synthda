package com.xoa.service.send;

import com.xoa.dao.sms2.Sms2PrivMapper;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ESsendService {

    @Resource
    private Sms2PrivMapper sms2PrivMapper;

    /**
     * 验证是否有 发送 或 接受权限
     * @param byName
     */
    @Transactional
    public String checked(String byName){
        String message="";
        try{
            //是否有发送权限
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if(!StringUtils.checkNull(sms2Priv.getOutPriv())){
                String[] split = sms2Priv.getOutPriv().split(",");
                List<Sms2Priv> sms2Priv1 = sms2PrivMapper.selOutPriv(split);
                if(sms2Priv1.size()>0){
                    for(int i=0;i<sms2Priv1.size();i++){
                        if(sms2Priv1.get(i).getOutPriv().equals(byName)){
                            //是否有接受权限
                            message="";
                        }
                    }
                    message="没有发送权限";
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }
}
