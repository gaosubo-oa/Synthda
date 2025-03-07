package com.xoa.global.component;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.enclosure.OnlyOfficeHistoryMapper;
import com.xoa.dao.sys.SealLogMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.enclosure.OnlyOfficeHistoryExample;
import com.xoa.model.enclosure.OnlyOfficeHistoryWithBLOBs;
import com.xoa.model.sys.SealLog;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.MD5Utils;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.http.HttpClientUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Component
public class OnlyOfficeCodeManager {

    @Autowired
    private OnlyOfficeHistoryMapper onlyOfficeHistoryMapper;

    @Autowired
    private SealLogMapper sealLogMapper;

    @Autowired
    private UsersMapper usersMapper;


    private final Set<String> onlyOfficeCodes = new HashSet<>();

    // onlyOffice 下载密钥生成接口
    public BaseWrapper onlyOfficeCode(HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        BaseWrapper baseWrapper = new BaseWrapper();

        String code = UUID.randomUUID().toString();
        onlyOfficeCodes.add(code);

        baseWrapper.setData(users);
        baseWrapper.setObj(code);
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);

        return baseWrapper;
    }

    public Boolean hasCode(String code){
        return onlyOfficeCodes.contains(code);
    }

    public Boolean removeCode(String code){
        return onlyOfficeCodes.contains(code);
    }

    // 文件保存（从onlyoffice服务器保存到OA服务器）
    public boolean onlyOfficeFileSave(JSONObject jsonObj,  String filePath){

        String downUrl = jsonObj.getString("url"); //保存变更后文件

        if(StringUtils.checkNull(downUrl)){
            return false;
        }

        // 保存历史记录  判断是否是彻底的文件保存 如果是的话 同时保存历史记录
        if("2".equals(jsonObj.getString("status"))){
            onlyOfficeFileHistorySave(jsonObj);
        }

        // 下载文件进行保存
        File file = HttpClientUtil.downLoadFromUrl(downUrl, null, filePath);

        if(file!=null&&file.exists()&&file.length()>0){

            Attachment attachment = (Attachment) jsonObj.get("attachmentInfo");

            SealLog sealLog = sealLogMapper.selectNoMd5Log(attachment.getAid()+"@"+attachment.getYm()+"_"+attachment.getAttachId(), attachment.getAttachName());

            if(sealLog!=null){
                String fileMd5Code = MD5Utils.getFileMd5Code(file);
                sealLog.setAttachmentMd5(fileMd5Code);
                sealLog.setInfoExt(jsonObj.getString("infoExt"));
                sealLogMapper.updateByPrimaryKeySelective(sealLog);
            }

            return true;
        }

        return false;

    }

    // 历史记录保存
    public void onlyOfficeFileHistorySave(JSONObject jsonObj){

        try{
            OnlyOfficeHistoryWithBLOBs history = new OnlyOfficeHistoryWithBLOBs();

            JSONObject historyJSON = jsonObj.getJSONObject("history");
            JSONArray changesJSON = historyJSON.getJSONArray("changes");
            JSONObject changes0 = changesJSON.getJSONObject(0);

            history.setAid(Integer.valueOf(jsonObj.getString("key").split("-")[2]));
            history.setUserId(changes0.getJSONObject("user").getString("id").split("-")[3]);
            // 查询用户姓名信息
            String usernameByUserId = usersMapper.getUsernameByUserId(history.getUserId());
            history.setUserName(usernameByUserId==null?"不存在该用户":usernameByUserId);
            history.setHistoryKey(jsonObj.getString("key"));
            history.setChangesUrl(jsonObj.getString("changesurl"));
            history.setFileUrl(jsonObj.getString("url"));
            history.setCreated(changes0.getString("created"));

            onlyOfficeHistoryMapper.insert(history);

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    // 根据aid查询历史记录
    public List<OnlyOfficeHistoryWithBLOBs> getFileHistory(Integer aid){
        OnlyOfficeHistoryExample historyExample = new OnlyOfficeHistoryExample();
        OnlyOfficeHistoryExample.Criteria criteria = historyExample.createCriteria();
        criteria.andAidEqualTo(aid);
        return onlyOfficeHistoryMapper.selectByExampleWithBLOBs(historyExample);
    }


}
