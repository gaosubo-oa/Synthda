package com.xoa.service.censor.impl;

import com.xoa.dao.censor.CensorModuleMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.censor.CensorModule;
import com.xoa.model.users.Users;
import com.xoa.service.censor.CensorModuleService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CensorModuleServiceImpl implements CensorModuleService {

    @Resource
    private CensorModuleMapper censorModuleMapper;

    @Resource
    private UsersMapper usersMapper;

    @Override
    public ToJson<CensorModule> addCensorModule(HttpServletRequest request, CensorModule censorModule) {
        ToJson<CensorModule> toJson = new ToJson<>(1,"err");
        try {
            int a = censorModuleMapper.addCensorModule(censorModule);
            if (a>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }else {
                toJson.setMsg("false");
                toJson.setFlag(1);
            }
        }catch (Exception e){
                e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorModule> delCensorModule(HttpServletRequest request, Integer moduleId) {
        ToJson<CensorModule> toJson = new ToJson<>(1,"err");
        try {
            if (moduleId!=0){
                censorModuleMapper.delCensorModule(moduleId);
            }
            toJson.setMsg("删除成功");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorModule> updateCensorModule(HttpServletRequest request, CensorModule censorModule) {
        ToJson<CensorModule> toJson = new ToJson<>(1,"err");
        try {
            int a = censorModuleMapper.updateCensorModule(censorModule);
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
    public ToJson<CensorModule> getCensorModuleInforById(HttpServletRequest request, Integer moduleId) {
        ToJson<CensorModule> toJson = new ToJson<>(1,"err");
        try {
            CensorModule censorModule = censorModuleMapper.getCensorModuleInforById(moduleId);
            if(!StringUtils.checkNull(censorModule.getCheckUser())){
                String[] checkUserArr=censorModule.getCheckUser().split(",");
                List<Users> list=usersMapper.getUserByUserIds(checkUserArr);
                StringBuffer sb=new StringBuffer();
                for(Users users:list){
                    sb.append(users.getUserName()+",");
                }
                censorModule.setCheckUserName(sb.toString());
            }
            if (censorModule != null){
                toJson.setObject(censorModule);
                toJson.setMsg("ok");
            }else {
                toJson.setMsg("NULL");
            }
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<CensorModule> getCensorModule(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request, CensorModule censorModule) {
        ToJson<CensorModule> toJson = new ToJson<>(1,"err");
        try {
            Map<String,Object> map = new HashMap<>();
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page",pageParams);
            map.put("censorModule",censorModule);
            List<CensorModule> list = censorModuleMapper.getCensorModule(map);
            for(CensorModule temp:list){
                if(!StringUtils.checkNull(temp.getCheckUser())){
                    String[] checkUserArr=temp.getCheckUser().split(",");
                    List<Users> list1=usersMapper.getUserByUserIds(checkUserArr);
                    StringBuffer sb=new StringBuffer();
                    for(Users users:list1){
                        sb.append(users.getUserName()+",");
                    }
                    temp.setCheckUserName(sb.toString());
                }
            }
            if (list!=null && list.size()>0){
                toJson.setObj(list);
                toJson.setTotleNum(pageParams.getTotal());
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
