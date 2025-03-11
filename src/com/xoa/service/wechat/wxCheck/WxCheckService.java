package com.xoa.service.wechat.wxCheck;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.wechat.WxCheckMapper;
import com.xoa.model.wechat.WxCheck;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class WxCheckService {

    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private WxCheckMapper wxCheckMapper;


    @Transactional
    public ToJson<WxCheck> addWxCheck(HttpServletRequest request, WxCheck wxCheck) {
        ToJson<WxCheck> json = new ToJson<WxCheck>();

        try {
            int count=0;

            String[] userIdArr=wxCheck.getUserId().split(",");
            for(String userId:userIdArr){
                WxCheck wxCheck1=new WxCheck();
                wxCheck1.setUserId(userId);
                wxCheck1.setDeptId(wxCheck.getDeptId());
                count=wxCheckMapper.insertSelective(wxCheck1);
            }


            if (count > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }

        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }


    public ToJson<WxCheck> delWxCheckById(HttpServletRequest request, WxCheck wxCheck) {

        ToJson<WxCheck> json = new ToJson<>(1, "error");

        try {


            int count = wxCheckMapper.delUserByDeptId(wxCheck);

            if (count > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }

        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }


    @Transactional
    public ToJson<WxCheck> updateWxCheck(HttpServletRequest request, WxCheck wxCheck) {

        ToJson<WxCheck> json = new ToJson<>(1, "error");

        try {

            int count = 0;

            count=wxCheckMapper.delUserByDeptId(wxCheck);

            if(count==0){
                json.setMsg("更新失败！");
                json.setFlag(1);
                return json;
            }else {

                String[] userIdArr = wxCheck.getUserId().split(",");

                for (String userId : userIdArr) {
                    WxCheck wxCheck1=new WxCheck();
                    wxCheck1.setUserId(userId);
                    wxCheck1.setDeptId(wxCheck.getDeptId());
                    count=wxCheckMapper.insertSelective(wxCheck1);

                }
                if (count > 0) {
                    json.setMsg("ok");
                    json.setFlag(0);
                }
            }



        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }


    public ToJson<WxCheck> selWxCheck(HttpServletRequest request) {

        ToJson<WxCheck> json = new ToJson<>(1, "error");

        try {

            List<WxCheck> esList=new ArrayList<>();
            List<Integer> deptIds=wxCheckMapper.selDeptId();

            for(Integer deptId:deptIds) {
                StringBuffer userName=new StringBuffer();
                StringBuffer userId=new StringBuffer();
                WxCheck wxCheck=new WxCheck();
                List<WxCheck> wxChecks = wxCheckMapper.selUserByDeptId(deptId);
                for (WxCheck un : wxChecks) {
                    userName.append(un.getUserName() + ", ");
                    userId.append(un.getUserId()+",");

                }
                wxCheck.setDeptId(deptId);
                wxCheck.setUserId(userId.toString());
                wxCheck.setDeptName(departmentMapper.getDeptNameByDeptId(deptId));
                wxCheck.setUserName(userName.toString());

                esList.add(wxCheck);
            }

            json.setObject(esList);
            json.setFlag(0);
            json.setMsg("ok");


        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;

    }

}
