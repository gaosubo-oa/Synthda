package com.xoa.service.sys;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.model.common.SysPara;
import com.xoa.service.department.DepartmentService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

@Service
public class SysTasksService {
    @Resource
   private SysParaMapper sysParaMapper;

    @Autowired
    private SystemInfoService systemInfoService;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private UserDeptOrderMapper userDeptOrderMapper;

    public ToJson updateSysTasks(SysPara sysPara){
        ToJson toJson=new ToJson();
        try {
            sysParaMapper.updateSysPara(sysPara);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch(Exception e){
            e.getMessage();
            toJson.setMsg("error");
            toJson.setFlag(1);
        }
        return  toJson;
    }

    public ToJson selectAll(){
        ToJson toJson=new ToJson();
        try{
          List<SysPara> list= sysParaMapper.listSysPara();
          toJson.setMsg("ok");
          toJson.setFlag(0);
          toJson.setObj(list);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("error");
        }
        return toJson;
    }

    public ToJson updateBatch(String jsonStr,HttpServletRequest request){
        ToJson toJson=new ToJson(1,"error");
        //判断注册文件是否授权了
        String modle = "";
        Map<String, String> map = systemInfoService.getAuthInfo(request);
        if(map!=null&&map.size()>0){
            Iterator i = map.entrySet().iterator();
            while (i.hasNext()) {
                Map.Entry entry = (Map.Entry) i.next();
                if(entry.getKey().equals("module")){
                    modle =  entry.getValue().toString();
                    break;
                }

            }
        }
        String[] strCode = modle.split(",");
        //默认附件加密是没有授权的
        boolean flag = false;
        for(int i=0;i<strCode.length;i++){
            if("12".contains(strCode[i])){
                flag = true;
            }
        }
       try{
           List<SysPara> list= new Gson().fromJson(jsonStr,new TypeToken<List<SysPara>>(){}.getType());
           SysPara para = null;
           for(SysPara sysPara:list){
               if(sysPara!=null&&!StringUtils.checkNull(sysPara.getParaValue())){
                   if(flag==true){

                   }else {
                       if(sysPara.getParaName().equals("LOGIN_SECURE_KEY")){
                           sysPara.setParaValue("0");

                       }
                   }
                   para=sysParaMapper.querySysPara(sysPara.getParaName());
                   if(para==null){
                       sysParaMapper.insertSysPara(sysPara);
                   }else{
                       sysParaMapper.updateSysPara(sysPara);
                   }

                   /*if(sysPara.getParaName().equals("USER_DEPT_ORDER")&&sysPara.getParaValue().equals("1")){  //用户同步到userDeptOrder
                       int i = userDeptOrderMapper.selectCount();
                       if (i==0){
                           departmentService.userUpdata();//user表所有信息同步到userDeptOrder
                       }
                   }*/
               }
           }
           toJson.setFlag(0);
           toJson.setMsg("ok");

       }catch (Exception e){
           e.printStackTrace();
       }
        return toJson;
    }

    /**
     * 添加在线预览
     * @param sysPara
     * @return
     */
    public ToJson  upPreview (SysPara sysPara){
        ToJson json = new ToJson();
//        SysPara sysPara1 =new SysPara();
//        SysPara sysPara2 =new SysPara();
//        sysPara1 =sysParaMapper.selectPreview();
//        if (!StringUtils.checkNull(sysPara1.getParaValue())){
//            sysPara2.setParaValue(sysPara1.getParaValue()+","+sysPara.getParaValue());
//            sysPara2.setParaName(sysPara1.getParaName());
//            sysParaMapper.upPreview(sysPara2);
//            try {
//                json.setMsg("ok");
//                json.setFlag(0);
//            }catch(Exception e){
//                e.getMessage();
//                json.setMsg("error");
//                json.setFlag(1);
//            }
//        }else {
            try {
                sysParaMapper.upPreview(sysPara);
                json.setMsg("ok");
                json.setFlag(0);
                json.setTurn(true);
            }catch(Exception e){
                e.getMessage();
                json.setMsg("error");
                json.setFlag(1);
            }
//        }

        return json;

    }
    //查询在线预览
    public ToJson selectPreview (){
        ToJson json = new ToJson();
        SysPara sysPara = new SysPara();
//        String[] str = null;
        try{
            sysPara = sysParaMapper.selectPreview();
//            str = sysPara.getParaValue().split(",");
            json.setMsg("ok");
            json.setFlag(0);
//           json.setObject(str);
            json.setObject(sysPara);
        }catch (Exception e){
            e.getMessage();
            json.setFlag(1);
            json.setMsg("error");
        }
        return json;
    }

    //修改是否快开启在线编辑
    public ToJson  upPreviewOpen (SysPara sysPara){
        ToJson json = new ToJson();
        sysParaMapper.upPreviewOpen(sysPara);
            try {
                json.setMsg("ok");
                json.setFlag(0);
            }catch(Exception e){
                e.getMessage();
                json.setMsg("error");
                json.setFlag(1);
            }
        return json;
    }
    //查询
    public ToJson  selectPreviewOpen(){
        ToJson json = new ToJson();
        SysPara sysPara = new SysPara();
        sysPara= sysParaMapper.selectPreviewOpen();
        try {
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(sysPara);
        }catch(Exception e){
            e.getMessage();
            json.setMsg("error");
            json.setFlag(1);
        }
        return json;
    }

    public ToJson  selectWebAddress(){
        ToJson json = new ToJson();
        SysPara sysPara = new SysPara();
        sysPara= sysParaMapper.selectWebAddress();
        try {
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(sysPara);
        }catch(Exception e){
            e.getMessage();
            json.setMsg("error");
            json.setFlag(1);
        }
        return json;
    }

    public ToJson getOfficePreviewSetting(){
        ToJson json = new ToJson();
        Map<String,Object> map = new HashMap<String,Object>();
        try {
            SysPara sysPara = sysParaMapper.selectPreview();
            SysPara sysPara1 = sysParaMapper.selectPreviewOpen();
            if(sysPara!=null){
                map.put("previewUrl",sysPara.getParaValue());
            }
            if(sysPara1!=null){
                map.put("previewOpen",sysPara1.getParaValue());
            }
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(map);
        }catch(Exception e){
            e.getMessage();
            json.setMsg("error");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 判断是否开启加密
     * @return
     */
    public boolean isEncryption(){
        boolean bol =false;
        try {
            SysPara sysPara = sysParaMapper.getEncryption();
            String sysParaKey = sysParaMapper.getEncryptionKey();
            if(sysPara!=null && sysParaKey!=null
                && sysPara.getParaValue() !=null
                && !StringUtils.checkNull(sysParaKey)
                && "0".equals(sysPara.getParaValue().trim())
                && sysParaKey.length() == 16){
                bol=true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return bol;
    }

    /**
     * 设置附件加密密匙
     * @return
     */
    public boolean setEncryptionKEY(String key){
        try {

            if(Pattern.matches("^[A-Z a-z 0-9]{16,16}$", key.replace(" ",""))){
                int i  = sysParaMapper.setEncryptionKey(key);
                if(i>0){
                    sysParaMapper.setBackupsEncryptionKEY(key+",");
                    return true;
                }
            }

        }catch(Exception e){
            e.getMessage();
        }
        return false;
    }


    /**
     *@作者: 廉立深
     *@时间: 2020/12/23
     *@介绍: 通过PARA_NAME串查找
     */
    public ToJson getSysParaList(HttpServletRequest request,List<String> paraName) {
        ToJson toJson = new ToJson(1,"false");
        try {
            toJson.setObj(sysParaMapper.getSysParaList(paraName));
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
