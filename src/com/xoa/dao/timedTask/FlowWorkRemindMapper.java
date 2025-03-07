package com.xoa.dao.timedTask;

import com.xoa.model.timedTask.FlowWorkRemindModel;
import com.xoa.model.timedTask.FlowWorkUsers;

import java.util.List;
import java.util.Map;

public interface FlowWorkRemindMapper {
    List<FlowWorkRemindModel> selectFlowWorkAll();

    FlowWorkUsers selectFlowRun(Map<String, Object> map);

    List<FlowWorkRemindModel> selectFlowBorrowing(Map<String, Object> map);


    int insertBorrowingAll(List<FlowWorkRemindModel> flowWorkRemindModelList);

    int updateById(FlowWorkRemindModel remindModel);
}
