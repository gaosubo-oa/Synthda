package com.xoa.service.comlicense.impl;

import com.xoa.dao.comlicense.ComlicenseInfoMapper;
import com.xoa.dao.comlicense.ComlicenseUseMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.comlicense.ComlicenseUseWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.comlicense.ComlicenseUseService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class ComlicenseUseServiceImpl implements ComlicenseUseService {

    @Autowired
    private ComlicenseUseMapper comlicenseUseMapper;

    @Autowired
    private ComlicenseInfoMapper comlicenseInfoMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public ToJson getDataByCondition(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs, PageParams pageParams) {
        ToJson toJson = new ToJson<>(1, "查询失败！");
        Map<String,Object> dataMap = new HashMap<>();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users(), redisSessionCookie);
        try {
            dataMap.put("urgency",comlicenseUseWithBLOBs.getUrgency());
            dataMap.put("approvalStatus",comlicenseUseWithBLOBs.getApprovalStatus());
            dataMap.put("page",pageParams);
            dataMap.put("lendTitle",comlicenseUseWithBLOBs.getLendTitle());
            dataMap.put("licenseUseId",comlicenseUseWithBLOBs.getLicenseUseId());
            if (!StringUtils.checkNull(request.getParameter("isAdmin"))&&request.getParameter("isAdmin").equals("1")){
                dataMap.put("reviewer",users.getUserId());
                dataMap.put("approvalUser",comlicenseUseWithBLOBs.getApprovalUser());
            }else if (!StringUtils.checkNull(request.getParameter("isAdmin"))&&request.getParameter("isAdmin").equals("0")){
                dataMap.put("approvalUser",users.getUserId());
            }
            List<ComlicenseUseWithBLOBs> dataByCondition = comlicenseUseMapper.getDataByCondition(dataMap);
            for (ComlicenseUseWithBLOBs useWithBLOBs : dataByCondition) {

                if (!StringUtils.checkNull(useWithBLOBs.getApprovalUser())){
                    useWithBLOBs.setApprovalName(usersMapper.getUsernameByUserId(useWithBLOBs.getApprovalUser()));
                }
                if (useWithBLOBs.getApprovalDept()!=null){
                    useWithBLOBs.setApprovalDeptName(departmentMapper.getDeptNameByDeptId(useWithBLOBs.getApprovalDept()));
                }
                if (!StringUtils.checkNull(useWithBLOBs.getLicenseIds())){
                    List<String> listName = new ArrayList<>();
                    for (String s : useWithBLOBs.getLicenseIds().split(",")) {
                        listName.add(comlicenseInfoMapper.getLicenseNameById(Integer.valueOf(s)));
                    }
                    useWithBLOBs.setLicenseNames(listName);
                }

            }
            toJson.setData(dataByCondition);
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setFlag(0);
            toJson.setMsg("success！");
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson approvalStatus(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs) {
        ToJson toJson = new ToJson<>(1, "err！");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users(), redisSessionCookie);
        try {
//            审批时自动添加审核人的id
            comlicenseUseWithBLOBs.setReviewer(users.getUserId());
            int i = comlicenseUseMapper.updateByPrimaryKeySelective(comlicenseUseWithBLOBs);
            if (i>0){
                toJson.setFlag(0);
                toJson.setMsg("success！");
            }
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    //    提交人修改证照借阅信息
    public ToJson updateComlicenseUse(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs) {
        ToJson toJson = new ToJson<>(1, "err！");
        try {
            int i = comlicenseUseMapper.updateByPrimaryKeySelective(comlicenseUseWithBLOBs);
            if (i>0){
                toJson.setFlag(0);
                toJson.setMsg("success！");
            }
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    //    申请人申请提交证照借阅信息
    public ToJson addComlicenseUse(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs) {
        ToJson toJson = new ToJson<>(1, "err！");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users(), redisSessionCookie);
        try {
            if (StringUtils.checkNull(comlicenseUseWithBLOBs.getApprovalUser())){
                comlicenseUseWithBLOBs.setApprovalUser(users.getUserId());
            }
            if (comlicenseUseWithBLOBs.getApprovalDept()==null){
                comlicenseUseWithBLOBs.setApprovalDept(users.getDeptId());
            }
            if (comlicenseUseWithBLOBs.getUseTime()==null){
                comlicenseUseWithBLOBs.setUseTime(new Date());
            }
            int i = comlicenseUseMapper.insertSelective(comlicenseUseWithBLOBs);
            if (i>0){
                toJson.setFlag(0);
                toJson.setMsg("success！");
            }
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson delComlicenseUse(HttpServletRequest request, String licenseUseIds) {
        ToJson toJson = new ToJson<>(1, "err！");
        try {
            Assert.notNull(licenseUseIds,"Parameter is empty！！");
            int i=0;
            for (String s : licenseUseIds.split(",")) {
                i = comlicenseUseMapper.deleteByPrimaryKey(Integer.valueOf(s));
            }
            if (i>0){
                toJson.setFlag(0);
                toJson.setMsg("success！");
            }
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson getDataByLicenseUseId(HttpServletRequest request, Integer licenseUseId) {
        ToJson toJson = new ToJson<>(1, "err！");
        try {
            Assert.notNull(licenseUseId,"Parameter is empty！！");
            ComlicenseUseWithBLOBs comlicenseUseWithBLOBs = comlicenseUseMapper.selectByPrimaryKey(licenseUseId);
            if (!StringUtils.checkNull(comlicenseUseWithBLOBs.getAddressee())){
                comlicenseUseWithBLOBs.setAddresseeName(usersMapper.getUsernameByUserId(comlicenseUseWithBLOBs.getAddressee()));
            }
            if (!StringUtils.checkNull(comlicenseUseWithBLOBs.getReviewer())){
                comlicenseUseWithBLOBs.setReviewerName(usersMapper.getUsernameByUserId(comlicenseUseWithBLOBs.getReviewer()));
            }
            if (!StringUtils.checkNull(comlicenseUseWithBLOBs.getApprovalUser())){
                comlicenseUseWithBLOBs.setApprovalName(usersMapper.getUsernameByUserId(comlicenseUseWithBLOBs.getApprovalUser()));
            }
            if (!StringUtils.checkNull(comlicenseUseWithBLOBs.getSender())){
                comlicenseUseWithBLOBs.setSenderName(usersMapper.getUsernameByUserId(comlicenseUseWithBLOBs.getSender()));
            }
            if (comlicenseUseWithBLOBs.getApprovalDept()!=null){
                comlicenseUseWithBLOBs.setApprovalDeptName(departmentMapper.getDeptNameByDeptId(comlicenseUseWithBLOBs.getApprovalDept()));
            }
            toJson.setData(comlicenseUseWithBLOBs);
            toJson.setFlag(0);
            toJson.setMsg("success！");
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
