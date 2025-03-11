package com.xoa.service.officeTask;



import com.xoa.model.officeTask.OfficeTask;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 朱新元
 * @since 2018-04-02
 */
@Service

public interface OfficeTaskService {

    ToJson<OfficeTask> addOfficeTask(HttpServletRequest request,OfficeTask officeTask);

    ToJson<OfficeTask> delOfficeTaskrById(HttpServletRequest request, Integer id);

    ToJson<OfficeTask> getOfficeTaskInforById(HttpServletRequest request, Integer id);

    ToJson<OfficeTask> updateOfficeTask(HttpServletRequest request, OfficeTask officeTask);

    ToJson<OfficeTask> getOfficeTask(HttpServletRequest request,Integer taskId);



}
