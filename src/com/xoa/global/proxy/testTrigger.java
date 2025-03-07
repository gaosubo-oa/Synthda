package com.xoa.global.proxy;

import com.xoa.dao.notify.NotifyMapper;
import com.xoa.model.notify.Notify;
import com.xoa.util.common.L;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by pfl on 2017/7/29.
 */
@Service
public class testTrigger implements TriggerSubject {
    @Resource
    private NotifyMapper notifyMapper;
    @Override
    public void doRun(String company,Object... ags) {
        ContextHolder.setConsumerType(company);
        notifyMapper.addNotify(new Notify(ags[0].toString(),ags[1].toString(),(Date) ags[2],
                ags[3].toString(),ags[4].toString(),ags[5].toString(),ags[6].toString()));
        L.s("0==||==============================>","触发器执行的",ags[0].toString(),ags[1].toString(),(Date) ags[2],
                ags[3].toString(),ags[4].toString(),ags[5].toString(),ags[6].toString());
    }
}
