package com.xoa.service.timedTask.impl;

import com.xoa.dao.officeTask.OfficeTaskMapper;
import com.xoa.model.officeTask.OfficeTask;
import com.xoa.service.timedTask.TimedTaskService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 接口实现类
 * Created by 郅浩宇 on 2018/8/14
 */
@Service
public class TimedTaskServiceImpl implements TimedTaskService {

    @Resource
    private OfficeTaskMapper officeTaskMapper;

    //单例toJson
    private static ToJson toJson = new ToJson();

    //列表查询
    @Override
    public ToJson selectQuery(Boolean useFlag,Integer page,Integer pageSize){
        initialToJson(toJson);
        try {
            //分页
            PageParams pageParams = new PageParams();
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            //参数
            Map<String,Object> map = new HashMap<>();
            map.put("page",pageParams);
            //查询
            List<OfficeTask> list = officeTaskMapper.selectQuery(map);
            //unix时间转换
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
            for (OfficeTask officeTask:list){
                if (officeTask!=null){
                    if (officeTask.getLastExec()!=null){
                        String tempString_1 = dateFormat.format(officeTask.getLastExec());
                        officeTask.setLastExecString(tempString_1);
                    } else {
                        officeTask.setLastExecString("0000-00-00 00:00:00");
                    }
                    if (officeTask.getExecTime()!=null){
                        String tempString_2 = simpleDateFormat.format(officeTask.getExecTime());
                        officeTask.setExecTimeString(tempString_2);
                    } else {
                        officeTask.setExecTimeString("00:00:00");
                    }
                }
            }
            //处理null（虽然数据库里都是非null，以防万一）
            String[] targetAttributes_1 = {"taskType","execMsg","taskUrl","taskName","taskDesc","taskCode","useFlag","sysTask","extData"};
            String[] targetAttributes_2 = {"interval","execFlag","exceptionLog"};
            for (OfficeTask officeTask:list){
                replaceValueToValue(officeTask,targetAttributes_1,null,"");
                replaceValueToValue(officeTask,targetAttributes_2,null,0);
            }

            toJson.setFlag(0);
            toJson.setMsg("success");
            toJson.setObj(list);
            toJson.setTotleNum(officeTaskMapper.selectCount());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    //修改设置前查询
    public ToJson updateSettingsSelect(Integer taskId){
        initialToJson(toJson);
        try {
            //查询
            OfficeTask officeTask = officeTaskMapper.updateSettingsSelect(taskId);
            //unix时间转换
            SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
            if (officeTask.getExecTime()!=null) {
                String tempString = format.format(officeTask.getExecTime());
                officeTask.setExecTimeString(tempString);
            } else {
                officeTask.setExecTimeString("00:00:00");
            }
            //处理null
            String[] targetAttributes_1 = {"interval"};
            String[] targetAttributes_2 = {"useFlag","taskName"};
            replaceValueToValue(officeTask,targetAttributes_1,null,0);
            replaceValueToValue(officeTask,targetAttributes_2,null,"");

            toJson.setFlag(0);
            toJson.setMsg("success");
            toJson.setObject(officeTask);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    //修改设置
    @Override
    public ToJson updateSettings(Integer interval,String execTime,String useFlag,Integer taskId){
        initialToJson(toJson);
        try {
            //参数
           Map<String,Object> map = new HashMap<>();
           Date execTimeToDate = null;
            if (execTime!=null) {
                SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
                execTimeToDate = format.parse(execTime);
            }
            map.put("execTime",execTimeToDate);
            map.put("interval",interval);
            map.put("useFlag",useFlag);
            map.put("taskId",taskId);
            //修改
            int i = officeTaskMapper.updateSettings(map);

            if (i>0){
                toJson.setFlag(0);
                toJson.setMsg("success");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    //立即执行
    @Override
    public ToJson executeNow(Integer taskId, String taskCode){
        initialToJson(toJson);
        try {
            Map<String,Object> map = new HashMap<>();
            map.put("taskId",taskId);
            map.put("taskCode",taskCode);
            OfficeTask officeTask = officeTaskMapper.selectTask(map);

            Map<String,Object> map1 = new HashMap<>();
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
            String currentDate = dateFormat.format(date);
            String currentTime = simpleDateFormat.format(date);
            Integer interval = officeTask.getInterval();
            map1.put("currentDate",currentDate);
            map1.put("currentTime",currentTime);
            map1.put("interval",interval);

            toJson.setFlag(0);
            toJson.setMsg("success");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }





    //其他方法
    //初始化toJson
    private static void initialToJson(ToJson toJson){
        toJson.setFlag(1);
        toJson.setMsg("error");
        toJson.setObject(null);
        toJson.setObj(null);
        toJson.setTotleNum(null);
    }
    //将对象实例的指定属性值替换为另一个值
    private static void replaceValueToValue(Object object,String[] targetAttributes,Object pastValue,Object valueForReplace){
        try {
            Field[] fields = object.getClass().getDeclaredFields();
            for (Field attribute:fields){
                attribute.setAccessible(true);
                String attributeName = attribute.getName();
                if(isIn(targetAttributes,attributeName)){
                    if (attribute.get(object) == pastValue){
                        attribute.set(object,valueForReplace);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //判断字符串对象是否在字符串数组中
    private static boolean isIn(String[] stringArray,String string){
        for(String str:stringArray){
            if(str.equals(string)){
                return true;
            }
        }
        return false;
    }

}
