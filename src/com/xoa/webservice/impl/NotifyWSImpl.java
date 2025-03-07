package com.xoa.webservice.impl;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.notify.NotifyOpinionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.notify.Notify;
import com.xoa.model.notify.NotifyOpinionWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.users.UsersService;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import com.xoa.webservice.NotifyWS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class NotifyWSImpl implements NotifyWS {

    @Resource
    private NotifyMapper notifyMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private NotifyOpinionMapper notifyOpinionMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Autowired
    private UsersService usersService;



    @Override
    public String getNotify(String lastTime, String page, String pageSize,String selKey) {
        if(StringUtils.checkNull(selKey)||!selKey.equals("")){
            return "密钥不正确";
        }
        BaseWrapper baseWrapper = new BaseWrapper();

        Map<String,Object> map = new HashMap<String,Object>();
        PageParams pageParams = new PageParams();
        if(!"0".equals(pageSize)){
            pageParams.setPage(Integer.valueOf(page));
            pageParams.setPageSize(Integer.valueOf(pageSize));
            pageParams.setUseFlag(true);
            map.put("page",pageParams);
        }
        map.put("beginDate",lastTime);
        map.put("endDate",new Date());
        List<SysCode> notifyPushTypes = sysCodeMapper.getChildCode("NOTIFY_PUSH");
        String [] typeIds = new String[notifyPushTypes.size()];
        for (int i = 0; i < notifyPushTypes.size(); i++) {
            SysCode sysCode = notifyPushTypes.get(i);
            if(sysCode!=null&&!StringUtils.checkNull(sysCode.getCodeNo())){
                typeIds[i]=sysCode.getCodeNo();
            }
        }
        map.put("typeIds",typeIds);

        List<Notify> notifies = notifyMapper.selectNotifyManage(map);

        for (int i = 0, size = notifies.size(); i < size; i++) {
            Notify notify = notifies.get(i);
            notify.setTypeName("");
            if (!StringUtils.checkNull(notify.getTypeId())) {
                String typeName = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (!StringUtils.checkNull(typeName)) {
                    notify.setTypeName(typeName);
                }
            }
            // 查询回执信息
            List<NotifyOpinionWithBLOBs> notifyOpinionWithBLOBs = selectByNotiIdList(notify.getNotifyId());
            notify.setNotifyOpinions(notifyOpinionWithBLOBs);
            if(notify.getFromDept()!=null){
                Department deptById = departmentMapper.getDeptById(notify.getFromDept());
                notify.setFromDeptStr(deptById.getDeptName());
            }
            if (!StringUtils.checkNull(notify.getAttachmentName()) && !StringUtils.checkNull(notify.getAttachmentId())) {
                notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), "xoa1000", GetAttachmentListUtil.MODULE_NOTIFY));
            }
        }
        baseWrapper.setTotleNum(pageParams.getTotal());
        baseWrapper.setData(notifies);
        baseWrapper.setFlag(true);
        return JSONObject.toJSON(baseWrapper).toString();
    }

    @Override
    public String getNotifyById(String notifyId,String selKey) {
        if(StringUtils.checkNull(selKey)||!selKey.equals("")){
            return "密钥不正确";
        }
        BaseWrapper baseWrapper = new BaseWrapper();

        if(!StringUtils.checkNull(notifyId)&&!"0".equals(notifyId)){
            Notify notify = notifyMapper.getNotifyByNotifyId(Integer.valueOf(notifyId));
            notify.setTypeName("");
            if (!StringUtils.checkNull(notify.getTypeId())) {
                String typeName = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (!StringUtils.checkNull(typeName)) {
                    notify.setTypeName(typeName);
                }
            }
            if (!StringUtils.checkNull(notify.getAttachmentName()) && !StringUtils.checkNull(notify.getAttachmentId())) {
                notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), "xoa1000", GetAttachmentListUtil.MODULE_NOTIFY));
            }

            // 查询回执信息
            List<NotifyOpinionWithBLOBs> notifyOpinionWithBLOBs = selectByNotiIdList(notify.getNotifyId());
            notify.setNotifyOpinions(notifyOpinionWithBLOBs);

            baseWrapper.setData(notify);
            baseWrapper.setFlag(true);
        }

        return JSONObject.toJSON(baseWrapper).toString();
    }


    public List<NotifyOpinionWithBLOBs> selectByNotiIdList(int notifyId) {

        List<NotifyOpinionWithBLOBs> list = notifyOpinionMapper.selectByNotyIdList(notifyId);

        Notify notify = notifyMapper.getNotifyByNotifyId(notifyId);
        /**
         * 重写Set去重规则
         */
        Comparator<Users> use = new Comparator <Users> (){
            @Override
            public int compare(Users o1, Users o2) {
                return o1.getUid().compareTo(o2.getUid());
            }
        };
        /**
         * 发布人员
         */
        String[] userIdList=notify.getUserId().split(",");
        Set<Users> userArray=new TreeSet<>(use);

        for(String userId:userIdList){
            if(!StringUtils.checkNull(userId)){
                userArray.add(usersMapper.SimplefindUsersByuserId(userId));
            }}

        /**
         * 部门人员
         */
        List<Users> deptList=new ArrayList();
        if(!StringUtils.checkNull(notify.getToId())){
            if("ALL_DEPT".trim().equals(notify.getToId())){
                List<Department>  deptListArr=departmentMapper.getAllDepartment();
                StringBuilder stringBuilder=new StringBuilder();
                for(Department department:deptListArr){
                    stringBuilder.append(department.getDeptId());
                    stringBuilder.append(",");
                }
                deptList=usersService.getUserByDeptIds(stringBuilder.toString(),1);
            }else {
                deptList=usersService.getUserByDeptIds(notify.getToId(),5);
            }
        }
        //角色人员
        List<Users> privList=new ArrayList();
        if(!StringUtils.checkNull(notify.getPrivId())){
            privList=usersService.getUserByDeptIds(notify.getPrivId(),6);
        }
        //已填报人员
        String[] opinUserIdList=notify.getOpinUsers().split(",");
        List<Users> opinUserArray=new ArrayList();
        for(NotifyOpinionWithBLOBs notifyOpinionWithBLOBs:list){
            if(notifyOpinionWithBLOBs != null){
                Map map = new HashMap();
                BeanMap beanMap = BeanMap.create(notifyOpinionWithBLOBs);
                for (Object key : beanMap.keySet()) {
                    map.put(key.toString(), beanMap.get(key));
                }
                String[] strings = notify.getOpinionFields().split("-");
                for(int i = 0 ;i<10 ;i++){
                    if( i <strings.length){
                        strings[i] = "".equals(strings[i]) ? "无标题":strings[i];
                        map.put("field"+(i+1),map.get("field"+(i+1))!=null ? map.get("field"+(i+1)) : "");
                        map.put("field"+(i+1),(strings[i]+":"+map.get("field"+(i+1))));
                    }else if(map.get("field"+(i+1))!=null){
                        map.put("field"+(i+1), "");
                    }
                }
                BeanMap beanRrstMap = BeanMap.create(notifyOpinionWithBLOBs);
                beanRrstMap.putAll(map);
                opinUserArray.add(usersMapper.getByUserId(notifyOpinionWithBLOBs.getUserId()));
                notifyOpinionWithBLOBs.setFromName(usersMapper.getByUserId(notify.getFromId()).getUserName());
                notifyOpinionWithBLOBs.setEndTime(notify.getSendTime());

                if(notifyOpinionWithBLOBs.getState()!=null ){
                    switch (notifyOpinionWithBLOBs.getState()){
                        case "0":
                            notifyOpinionWithBLOBs.setStateStr("已填报");
                            break;
                        case "1":
                            notifyOpinionWithBLOBs.setStateStr("已退回");
                            break;
                        case "2":
                            notifyOpinionWithBLOBs.setStateStr("已重新填报");
                            break;
                    }
                }
            }
        }
        userArray.addAll(deptList);
        userArray.addAll(privList);
        if(userArray.size()==1){
            userArray.clear();
        }else{
            userArray.removeAll(opinUserArray);
        }
        String userName = usersMapper.getByUserId(notify.getFromId()).getUserName();
        for(Users user :userArray){
            NotifyOpinionWithBLOBs notifyOpinionWithBLOBs = new NotifyOpinionWithBLOBs();
            notifyOpinionWithBLOBs.setUserName(user.getUserName());
            notifyOpinionWithBLOBs.setDeptName(user.getDeptName());
            notifyOpinionWithBLOBs.setUserId(user.getUserId());
            notifyOpinionWithBLOBs.setStateStr("未填报");
            notifyOpinionWithBLOBs.setFromName(userName);
            notifyOpinionWithBLOBs.setEndTime(notify.getSendTime());
            list.add(notifyOpinionWithBLOBs);
        }
        return list;
    }

}
