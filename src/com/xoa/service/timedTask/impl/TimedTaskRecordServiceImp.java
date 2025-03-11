package com.xoa.service.timedTask.impl;

import com.xoa.dao.timedTask.TimedTaskRecordMapper;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.service.timedTask.TimedTaskRecordService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class TimedTaskRecordServiceImp implements TimedTaskRecordService {

    @Resource
    private TimedTaskRecordMapper timedTaskRecordMapper;

    @Override
    public int insertTimedRecord(TimedTaskRecord timedTaskRecord) {
        return timedTaskRecordMapper.insertSelective(timedTaskRecord);
    }

}
