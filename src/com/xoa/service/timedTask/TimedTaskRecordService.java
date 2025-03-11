package com.xoa.service.timedTask;

import com.xoa.model.timedTask.TimedTaskRecord;

public interface TimedTaskRecordService {
    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-10 17:58
     * 方法介绍: 添加一条定时任务执行记录
     * @param timedTaskRecord
     * @return int
     */
    int insertTimedRecord(TimedTaskRecord timedTaskRecord);
}
