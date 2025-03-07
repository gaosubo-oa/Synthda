package com.xoa.global.intercptor;

import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.model.menu.SysFunction;
import com.xoa.util.common.L;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * Created by 韩东堂on 2017/6/28.
 */
@Component
public class CommonFunctionMemory implements InitializingBean {

    @Autowired
    SysFunctionMapper mapper;


    private Map<String,String> reflectMaps;
    private List<SysFunction> functionIds;
    private static Map<String,String> userSessionMaps;
    private static Map<String,String> jsession_sessionIdMaps;

    public List<SysFunction>getFunctionIds() {
        return functionIds;
    }

    public Map<String, String> getReflectMaps() {
        return reflectMaps;
    }

    public  String getSession(String userName){
        if(userSessionMaps!=null){
            return  userSessionMaps.get(userName);
        }
        return null;
    }
    public void putReflectSession(String jsessionId,String sessionId){
        if(jsession_sessionIdMaps==null){
            jsession_sessionIdMaps=new HashMap<String,String>();
        }
        jsession_sessionIdMaps.put(jsessionId,sessionId);
    }
    public String getSessionIdByJessionId(String jessionId){
        if(jsession_sessionIdMaps!=null){
            return jsession_sessionIdMaps.get(jessionId);
        }
        return null;
    }

    public  void putSession(String userName,String sessionId){
        if(userSessionMaps==null){
            userSessionMaps=new HashMap<String,String>();
        }
        userSessionMaps.put(userName,sessionId);
    }
    public  Set<String> getUserName(String seesion){
       Set<String> userSet =new HashSet<String>();
        if(userSessionMaps!=null){
            for(Map.Entry<String,String> entry:userSessionMaps.entrySet()){
                entry.getKey();
                if(seesion.equals(entry.getValue())){
                    userSet.add(entry.getKey());
                }
            }
        }
        return userSet;
    }

    public void setReflectMaps(Map<String, String> reflectMaps) {
        this.reflectMaps = reflectMaps;
    }

    public void setFunctionIds(List<SysFunction> functionIds) {
        this.functionIds = functionIds;
    }

    @Override
    public void afterPropertiesSet() throws Exception {

       List<SysFunction>  functions=mapper.getAll();
       if(functions!=null&&functions.size()>0){
           functionIds=new ArrayList<SysFunction>();
           int i=0;
           for(SysFunction function:functions){
               if(!function.getUrl().contains("@")){
                   functionIds.add(function);
               }
               i++;
           }
       }
        reflectMaps =new HashMap<String,String>();
        jsession_sessionIdMaps =new HashMap<String,String>();
        reflectMaps.put("email","email/index");
        reflectMaps.put("notify/show","notice/index");
        reflectMaps.put("news/show","news/index");
        reflectMaps.put("file_folder/index2.php","file/persionBox");
        reflectMaps.put("system/file_folder","showFileBySort_id");
        reflectMaps.put("diary/show","diary/index");
        reflectMaps.put("news/manage","news/manage");
        reflectMaps.put("notify/manage","notice/manage");
        reflectMaps.put("knowledge/management","file/home");
        reflectMaps.put("system/file/folder","file/setIndex");
        reflectMaps.put("system/workflow/flow_guide","flow/type/index");
        reflectMaps.put("system/workflow/flow_form","workflow/formtype/index");
        reflectMaps.put("system/workflow/flow_sort","workflow/flowclassify/index");
//                "file_folder_index2.php":"file/persionBox",
        reflectMaps.put("system/unit","sys/companyInfo");
        reflectMaps.put("system/dept","common/deptManagement");
        reflectMaps.put("system/org_manage","sys/organizational");
        reflectMaps.put("workflow/new","workflow/work/addwork");
        reflectMaps.put("workflow/list","workflow/work/workList");
        reflectMaps.put("system/user","common/userManagement");
        reflectMaps.put("system/user_priv","roleAuthorization");
        reflectMaps.put("system/status_text","sys/statusBar");
        reflectMaps.put("system/interface","sys/interfaceSettings");
        reflectMaps.put("system/reg_view","sys/sysInfo");
        reflectMaps.put("system/menu","sys/menuSetting");
        reflectMaps.put("system/log","sys/journal");
        reflectMaps.put("system/code","common/systemCode");
        reflectMaps.put("info/unit","sys/unitInfor");
        reflectMaps.put("info/dept","department/deptQuery");
        reflectMaps.put("info/user","sys/userInfor");
        reflectMaps.put("calendar","schedule/index");
        reflectMaps.put("system/netdisk","netdiskSettings/netdisksetting");
        reflectMaps.put("document/mine","document/mine");
        reflectMaps.put("person/info","controlpanel/index");
        reflectMaps.put("workflow/rule","workflow/work/workDelegate");

        L.s("0=||======================================>",functionIds);

        userSessionMaps =new HashMap<String,String>();
    }
}
