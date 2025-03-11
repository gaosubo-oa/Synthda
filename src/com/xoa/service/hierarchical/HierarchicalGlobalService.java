package com.xoa.service.hierarchical;


import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.hierarchical.HierarchicalGlobalMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.model.department.Department;
import com.xoa.model.hierarchical.HierarchicalGlobal;
import com.xoa.model.users.UserPriv;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.users.UsersService;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-9-26 18:06
 * 类介绍  :
 * 构造参数:
 */
@Service
public class HierarchicalGlobalService {

    @Autowired
    private HierarchicalGlobalMapper hierarchicalGlobalMapper;

    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UserPrivMapper userPrivMapper;

    @Autowired
    private DepartmentMapper departmentMapper;


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月26日 下午10:05:05
     * 方法介绍:   在分级机构中设置全局管理员
     * @return String
     */
    public ToJson<HierarchicalGlobal> setHierarchicalGlobalPerson(String globalJson){
        ToJson<HierarchicalGlobal> json = new ToJson<HierarchicalGlobal>(1, "error");
        try{
            int count=0;
            List<HierarchicalGlobal> list=new ArrayList<HierarchicalGlobal>();
            list =JSONObject.parseArray(globalJson,HierarchicalGlobal.class);
            for(HierarchicalGlobal hierarchicalGlobal:list){
                if(hierarchicalGlobalMapper.selByModel(hierarchicalGlobal)!=null){
                    count=hierarchicalGlobalMapper.updatePersonByModel(hierarchicalGlobal);
                }else{
                    count=hierarchicalGlobalMapper.insertGlobal(hierarchicalGlobal);
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("HierarchicalGlobalService setHierarchicalGlobalPerson:"+e);
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月26日 下午10:05:05
     * 方法介绍:  查询分级机构中的全局管理员
     * @return String
     */
    public AjaxJson selGlobalPerson(){
        AjaxJson ajaxJson=new AjaxJson();
        ajaxJson.setMsg("error");
        ajaxJson.setFlag(false);
        try{
            ArrayList<HierarchicalGlobal> arrayList=new ArrayList();
            Map<String,Object> map=new HashedMap();
            HierarchicalGlobal hierarchicalGlobal=new HierarchicalGlobal();
            hierarchicalGlobal.setModelId("0132");
            HierarchicalGlobal global=hierarchicalGlobalMapper.selByModel(hierarchicalGlobal);
            arrayList.add(global);
            int i=1;
            for (HierarchicalGlobal temp:arrayList){
                if(temp!=null){
                    temp.setGlobalPersonName(usersService.getUserNameById(temp.getGlobalPerson()));
                    if(!StringUtils.checkNull(temp.getGlobalDept())){
                        List<Department> departments = departmentMapper.selDeptByIds(temp.getGlobalDept().split(","));
                        StringBuilder ids = new StringBuilder();
                        StringBuilder names = new StringBuilder();
                        departments.forEach(d -> {
                            ids.append(d.getDeptId()).append(",");
                            names.append(d.getDeptName()).append(",");
                        });
                        temp.setGlobalDept(ids.toString());
                        temp.setGlobalDeptName(names.toString());
                    }
                    if(!StringUtils.checkNull(temp.getGlobalPriv())){
                        List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(temp.getGlobalPriv().split(","));
                        StringBuilder ids = new StringBuilder();
                        StringBuilder names = new StringBuilder();
                        userPrivByIds.forEach(priv -> {
                            ids.append(priv.getUserPriv()).append(",");
                            names.append(priv.getPrivName()).append(",");
                        });
                        temp.setGlobalPriv(ids.toString());
                        temp.setGlobalPrivName(names.toString());
                    }
                }
                map.put("model"+i,temp);
                i++;
            }
            ajaxJson.setAttributes(map);
            ajaxJson.setMsg("ok");
            ajaxJson.setFlag(true);
        }catch(Exception e){
            ajaxJson.setMsg(e.getMessage());
            L.e("HierarchicalGlobalService selGlobalPerson:"+e);
        }
        return  ajaxJson;
    }

}
