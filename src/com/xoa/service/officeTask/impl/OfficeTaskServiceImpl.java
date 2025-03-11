package com.xoa.service.officeTask.impl;


import com.xoa.dao.officeTask.OfficeTaskMapper;
import com.xoa.model.officeTask.OfficeTask;
import com.xoa.service.officeTask.OfficeTaskService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class OfficeTaskServiceImpl implements OfficeTaskService {

    @Resource
    private  OfficeTaskMapper officeTaskMapper;

    @Override
    public ToJson<OfficeTask> addOfficeTask(HttpServletRequest request,OfficeTask officeTask) {
        ToJson<OfficeTask> toJson = new ToJson<>(1,"err");
        try {
            int a = officeTaskMapper.addOfficeTask(officeTask);
            if (a>0){
                toJson.setFlag(0);
                toJson.setMsg("添加成功");
            }else {
                toJson.setFlag(1);
                toJson.setMsg("添加失败");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<OfficeTask> delOfficeTaskrById(HttpServletRequest request, Integer id) {
        ToJson<OfficeTask> toJson = new ToJson<>(1,"err");
        try{
            if (id!=0){
                officeTaskMapper.delOfficeTaskrById(id);
            }
            toJson.setFlag(0);
            toJson.setMsg("删除成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<OfficeTask> getOfficeTaskInforById(HttpServletRequest request, Integer id) {
        ToJson<OfficeTask> toJson = new ToJson<>(1,"err");
        try{
            OfficeTask officeTask = officeTaskMapper.getOfficeTaskInforById(id);
            if (officeTask != null) {
                toJson.setObject(officeTask);
                toJson.setMsg("ok");
            }else {
                toJson.setMsg("空数据");
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<OfficeTask> updateOfficeTask(HttpServletRequest request, OfficeTask officeTask) {
        ToJson<OfficeTask> toJson = new ToJson<>(1,"err");
        try {
            int a = officeTaskMapper.updateOfficeTask(officeTask);
            if (a>0){
                toJson.setMsg("修改成功");
                toJson.setFlag(0);
            }else {
                toJson.setMsg("修改失败");
                toJson.setFlag(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<OfficeTask> getOfficeTask(HttpServletRequest request, Integer taskId) {
        ToJson<OfficeTask> toJson = new ToJson<>(1,"err");
        try{
            List<OfficeTask> list = officeTaskMapper.getOfficeTask(taskId);
            if (list != null){
                toJson.setObj(list);
                toJson.setMsg("ok");
            }else {
                toJson.setMsg("空数据");
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
