package com.xoa.service.comlicense.impl;

import com.xoa.dao.comlicense.ComlicenseInfoMapper;
import com.xoa.dao.comlicense.ComlicenseTypeMapper;
import com.xoa.dao.comlicense.ComlicenseVersionMapper;
import com.xoa.model.comlicense.ComlicenseInfoWithBLOBs;
import com.xoa.model.comlicense.ComlicenseVersionExample;
import com.xoa.model.comlicense.ComlicenseVersionWithBLOBs;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.comlicense.ComlicenseInfoService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ComlicenseInfoServiceImpl implements ComlicenseInfoService {
    @Autowired
    private ComlicenseInfoMapper comlicenseInfoMapper;
    @Autowired
    private ComlicenseTypeMapper comlicenseTypeMapper;
    @Autowired
    private ComlicenseVersionMapper comlicenseVersionMapper;

    @Override
    public ToJson addComlicenseInfo(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfo) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseInfoMapper.insertSelective(comlicenseInfo);
            if (i>0) {
                ComlicenseVersionWithBLOBs comlicenseVersionWithBLOBs = new ComlicenseVersionWithBLOBs();
//                插入证照时并向日志表中添加数据日志
                BeanUtils.copyProperties(comlicenseInfo,comlicenseVersionWithBLOBs);
                comlicenseVersionWithBLOBs.setLicenseId(comlicenseInfo.getLicenseId());
                comlicenseVersionWithBLOBs.setVersionId(null);
                comlicenseVersionWithBLOBs.setCreateTime(new Date());
                comlicenseVersionWithBLOBs.setVersionName(StringUtils.checkNull(request.getParameter("versionName"))?null:request.getParameter("versionName"));
                comlicenseVersionWithBLOBs.setVersionExplain(StringUtils.checkNull(request.getParameter("versionExplain"))?null:request.getParameter("versionExplain"));
                int i1 = comlicenseVersionMapper.insertSelective(comlicenseVersionWithBLOBs);
                if (i1>0){
                    toJson.setFlag(0);
                    toJson.setMsg("插入成功");
                }
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson deleteComlicenseType(HttpServletRequest request, Integer licenseId) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseInfoMapper.deleteByPrimaryKey(licenseId);
            if (i>0) {
                toJson.setFlag(0);
                toJson.setMsg("删除成功");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson updateComlicenseInfo(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfo) {
        ToJson toJson = new ToJson();
        try {
            int i = comlicenseInfoMapper.updateByPrimaryKeySelective(comlicenseInfo);
            if (i>0) {
                ComlicenseVersionWithBLOBs comlicenseVersionWithBLOBs = new ComlicenseVersionWithBLOBs();
//                插入证照时并向日志表中添加数据日志
                BeanUtils.copyProperties(comlicenseInfo,comlicenseVersionWithBLOBs);
                comlicenseVersionWithBLOBs.setCreateTime(new Date());
                comlicenseVersionWithBLOBs.setVersionId(null);
                comlicenseVersionWithBLOBs.setVersionName(StringUtils.checkNull(request.getParameter("versionName"))?null:request.getParameter("versionName"));
                comlicenseVersionWithBLOBs.setVersionExplain(StringUtils.checkNull(request.getParameter("versionExplain"))?null:request.getParameter("versionExplain"));
                int i1 = comlicenseVersionMapper.insertSelective(comlicenseVersionWithBLOBs);
                if (i1>0){
                    toJson.setFlag(0);
                    toJson.setMsg("修改成功");
                }
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson queryAll(HttpServletRequest request, PageParams pageParams) {
        ToJson toJson = new ToJson();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
            Map<String, Object> map = new HashMap<>();
            map.put("pageParams",pageParams);
            map.put("licenseType",StringUtils.checkNull(request.getParameter("licenseType"))?null:request.getParameter("licenseType"));
            List<ComlicenseInfoWithBLOBs> comlicenseInfoWithBLOBs = comlicenseInfoMapper.selectAll(map);
            for (ComlicenseInfoWithBLOBs comlicenseInfoWithBLOB : comlicenseInfoWithBLOBs) {
                if(comlicenseInfoWithBLOB.getLicenseType()!=null){  //类型名称
                    String typeName = comlicenseTypeMapper.selectTypeNameByTypeId(comlicenseInfoWithBLOB.getLicenseType());
                    comlicenseInfoWithBLOB.setTypeName(typeName);
                }
                if (!StringUtils.checkNull(comlicenseInfoWithBLOB.getAttachmentName()) && !StringUtils.checkNull(comlicenseInfoWithBLOB.getAttachmentId())) {   //证照附件
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(comlicenseInfoWithBLOB.getAttachmentName(), comlicenseInfoWithBLOB.getAttachmentId(), sqlType, "comlicense");//暂定plancheck
                    comlicenseInfoWithBLOB.setAttachments(atts);
                }
            }
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setData(comlicenseInfoWithBLOBs);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson queryByInfoId(HttpServletRequest request, Integer licenseId) {
        ToJson toJson = new ToJson();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        try {
            ComlicenseInfoWithBLOBs comlicenseInfoWithBLOBs = comlicenseInfoMapper.selectByPrimaryKey(licenseId);
            if (!StringUtils.checkNull(comlicenseInfoWithBLOBs.getAttachmentName()) && !StringUtils.checkNull(comlicenseInfoWithBLOBs.getAttachmentId())) {   //证照附件
                List<Attachment> atts = GetAttachmentListUtil.returnAttachment(comlicenseInfoWithBLOBs.getAttachmentName(), comlicenseInfoWithBLOBs.getAttachmentId(), sqlType, "comlicense");//暂定plancheck
                comlicenseInfoWithBLOBs.setAttachments(atts);
            }
            toJson.setData(comlicenseInfoWithBLOBs);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    //    通过licenseId查询该证照的历史日志数据
    public ToJson getLogById(HttpServletRequest request, Integer licenseId) {
        ToJson toJson = new ToJson<>(1, "查询失败！");
        try {
            ComlicenseVersionExample comlicenseVersionExample = new ComlicenseVersionExample();
            comlicenseVersionExample.setOrderByClause("CREATE_TIME DESC");
            comlicenseVersionExample.createCriteria().andLicenseIdEqualTo(licenseId);
            List<ComlicenseVersionWithBLOBs> comlicenseVersionWithBLOBs = comlicenseVersionMapper.selectByExampleWithBLOBs(comlicenseVersionExample);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if (!comlicenseVersionWithBLOBs.isEmpty()){
                for (ComlicenseVersionWithBLOBs comlicenseVersionWithBLOB : comlicenseVersionWithBLOBs) {
                    comlicenseVersionWithBLOB.setVersionName(comlicenseVersionWithBLOB.getLicenseName()+" "+formatter.format(comlicenseVersionWithBLOB.getCreateTime()));
                }
                toJson.setData(comlicenseVersionWithBLOBs);
                toJson.setFlag(0);
                toJson.setMsg("查询成功！");
            }
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    //    根据条件获取证照信息
    public ToJson getDataByCondition(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfoWithBLOBs,PageParams pageParams) {
        ToJson toJson = new ToJson<>(1, "查询失败！");
        Map<String,Object> dataMap = new HashMap<>();
        try {
            dataMap.put("licenseName",comlicenseInfoWithBLOBs.getLicenseName());
            dataMap.put("licenseStatus",comlicenseInfoWithBLOBs.getLicenseStatus());
            dataMap.put("issueUnit",comlicenseInfoWithBLOBs.getIssueUnit());
            dataMap.put("licenseType",comlicenseInfoWithBLOBs.getLicenseType());
            dataMap.put("effectiveDate",StringUtils.checkNull(request.getParameter("effectiveDate"))?null:request.getParameter("effectiveDate"));
            dataMap.put("page",pageParams);
            List<ComlicenseInfoWithBLOBs> dataByCondition = comlicenseInfoMapper.getDataByCondition(dataMap);
            toJson.setData(dataByCondition);
            toJson.setFlag(0);
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setMsg("查询成功！");
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    //    根据版本的主键id查询某个证照的版本
    public ToJson getLogDetailById(HttpServletRequest request, Integer logId) {
        ToJson toJson = new ToJson<>(1, "查询失败！");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        try {
            ComlicenseVersionWithBLOBs comlicenseVersionWithBLOBs = comlicenseVersionMapper.selectByPrimaryKey(logId);
            if (!StringUtils.checkNull(comlicenseVersionWithBLOBs.getAttachmentName()) && !StringUtils.checkNull(comlicenseVersionWithBLOBs.getAttachmentId())) {   //证照附件
                List<Attachment> atts = GetAttachmentListUtil.returnAttachment(comlicenseVersionWithBLOBs.getAttachmentName(), comlicenseVersionWithBLOBs.getAttachmentId(), sqlType, "comlicense");//暂定plancheck
                comlicenseVersionWithBLOBs.setAttachments(atts);
            }
            toJson.setData(comlicenseVersionWithBLOBs);
            toJson.setFlag(0);
            toJson.setMsg("查询成功！");
            return toJson;
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
