package com.xoa.service.fulltext;


import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.fulltext.AttachmentIndexMapper;
import com.xoa.dao.fulltext.AttachmentIndexPrivMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.fulltext.AttachmentIndex;
import com.xoa.model.fulltext.AttachmentIndexPriv;

import com.xoa.model.fulltext.AttachmentIndexSwitch;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AttachmentIndexPrivService {
    @Resource
    private AttachmentIndexPrivMapper attachmentIndexPrivMapper;
    @Resource
    private AttachmentIndexMapper attachmentIndexMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UserPrivMapper userPrivMapper;
    @Resource
    private SysParaMapper sysParaMapper;

    //全文检索权限页面数据
    public ToJson selectAll() {
        ToJson json = new ToJson();
        try {
            List<AttachmentIndexPriv> attachmentIndexPrivs = attachmentIndexPrivMapper.selectAll();
            if (attachmentIndexPrivs.size() > 0) {
                json.setFlag(0);
                json.setObj(attachmentIndexPrivs);
                json.setMsg("ok");
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }

        return json;
    }

    //全文检索修改接口
    public ToJson update(AttachmentIndexPriv attachmentIndexPriv) {
        ToJson json = new ToJson();
        if (attachmentIndexPriv.getModuleId() == null) {
            json.setFlag(1);
            json.setMsg("模块id为空");
            return json;
        }
        try {
            attachmentIndexPrivMapper.update(attachmentIndexPriv);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    //全文检索保存接口--暂无用
    public ToJson insert(AttachmentIndexPriv attachmentIndexPriv) {
        ToJson json = new ToJson();
        try {
            attachmentIndexPrivMapper.insert(attachmentIndexPriv);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    //查看详情权限人员部门角色
    public ToJson selectByModuleId(Integer moduleId) {
        ToJson json = new ToJson();
        try {
            AttachmentIndexPriv attachmentIndexPriv = attachmentIndexPrivMapper.selectByModuleId(moduleId);
            if (attachmentIndexPriv != null) {
                StringBuffer privNames = new StringBuffer();
                StringBuffer userNames = new StringBuffer();
                StringBuffer deptNames = new StringBuffer();
                String userIds = attachmentIndexPriv.getUserIds();
                if (!StringUtils.checkNull(userIds)) {
                    String[] split = userIds.split(",");
                    for (String s : split) {
                        String username = usersMapper.getUsernameByUserId(s);
                        userNames.append(username + ",");
                    }
                    attachmentIndexPriv.setUserNames(userNames.toString());
                }
                String deptIds = attachmentIndexPriv.getDeptIds();
                if (!StringUtils.checkNull(deptIds)) {
                    String[] split = deptIds.split(",");
                    for (String s : split) {
                        String deptNameById = departmentMapper.getDeptNameById(Integer.valueOf(s));
                        deptNames.append(deptNameById + ",");
                    }
                    attachmentIndexPriv.setDeptNames(deptNames.toString());
                }
                String privIds = attachmentIndexPriv.getPrivIds();
                if (!StringUtils.checkNull(privIds)) {
                    String[] split = privIds.split(",");
                    for (String s : split) {
                        String privNameById = userPrivMapper.getPrivNameById(Integer.valueOf(s));
                        privNames.append(privNameById + ",");
                    }
                    attachmentIndexPriv.setPrivNames(privNames.toString());
                }

            }
            json.setObject(attachmentIndexPriv);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    public ToJson resetting(HttpServletRequest request){
        ToJson json = new ToJson();
        try {
            Integer resetting = attachmentIndexMapper.resetting();
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(resetting);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    //查询全文检索保开关数据
    public ToJson selectAttach() {
        ToJson json = new ToJson();
        try {
            List<SysPara> sysParas = sysParaMapper.selectAttach();
            Map<String, Object> map = attachmentIndexMapper.selectAttCount();
            Map<String,Object>  attachIndex = attachmentIndexMapper.selectIndexCount();
            Integer percentage = 0;
            AttachmentIndexSwitch attachmentIndexSwitch = new AttachmentIndexSwitch();
            if (sysParas.size() > 0) {
                for (SysPara sysPara : sysParas) {
                    String paraName = sysPara.getParaName();
                    if (paraName.equals("ALLDOC_INDEX_YN")) {
                        attachmentIndexSwitch.setAlldocIndexYn(sysPara.getParaValue());
                    }
                    if (paraName.equals("ALLDOC_INDEX_DOTIME")) {
                        String paraValue = sysPara.getParaValue();
                        attachmentIndexSwitch.setAlldocIndexDotime(paraValue);
                        JSONObject jsonObject = JSONObject.fromObject(paraValue);
                    }
                    if (paraName.equals("ALLDOC_INDEX_FILENUM")) {
                        attachmentIndexSwitch.setAlldocIndexFileNum(sysPara.getParaValue());
                    }
                    if (paraName.equals("ALLDOC_INDEX_FILETYPE")) {
                        String paraValue = sysPara.getParaValue();
                        attachmentIndexSwitch.setAlldocIndexFileType(paraValue);
                        JSONObject jsonObject = JSONObject.fromObject(paraValue);
                        String word_index = (String) jsonObject.get("WORD_INDEX");
                        String excle_index = (String) jsonObject.get("EXCLE_INDEX");
                        String ppt_index = (String) jsonObject.get("PPT_INDEX");
                        String pdf_index = (String) jsonObject.get("PDF_INDEX");
                        String html_index = (String) jsonObject.get("HTML_INDEX");
                        String txt_index = (String) jsonObject.get("TXT_INDEX");
                        attachmentIndexSwitch.setWordIndex(word_index);
                        attachmentIndexSwitch.setExcleIndex(excle_index);
                        attachmentIndexSwitch.setPptIndex(ppt_index);
                        attachmentIndexSwitch.setPdfIndex(pdf_index);
                        attachmentIndexSwitch.setHtmlIndex(html_index);
                        attachmentIndexSwitch.setTxtIndex(txt_index);
                    }
                }
            } else {
                json.setFlag(1);
                json.setMsg("err");
                return json;
            }
            attachmentIndexSwitch.setAttachAll(map);
            attachmentIndexSwitch.setAttachIndex(attachIndex);
            if ((long)map.get("allcount")>0) {
                percentage = Math.round((long)attachIndex.get("indexCount") *  100/(long)map.get("allcount"));
            }
            attachmentIndexSwitch.setPercentage(percentage.toString());
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(attachmentIndexSwitch);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    public ToJson AttachUpdate(HttpServletRequest request, AttachmentIndexSwitch attachmentIndexSwitch) {
        ToJson json = new ToJson();
        Map<String, Object> map = new HashMap<>();
        JSONObject jsonObject = new JSONObject();
        try {
            map.put("paraName", "ALLDOC_INDEX_YN");
            map.put("paraValue", attachmentIndexSwitch.getAlldocIndexYn());
            sysParaMapper.updateAttach(map);
//            jsonObject.put("BEGIN_TIME", attachmentIndexSwitch.getBeginTime());
//            jsonObject.put("END_TIME", attachmentIndexSwitch.getEndTime());
//            attachmentIndexSwitch.setAlldocIndexDotime(jsonObject.toString());
//            map.put("paraName", "ALLDOC_INDEX_DOTIME");
//            map.put("paraValue", attachmentIndexSwitch.getAlldocIndexDotime());
//            sysParaMapper.updateAttach(map);
            map.put("paraName", "ALLDOC_INDEX_FILENUM");
            map.put("paraValue", attachmentIndexSwitch.getAlldocIndexFileNum());
            sysParaMapper.updateAttach(map);
            jsonObject = new JSONObject();
            jsonObject.put("WORD_INDEX", attachmentIndexSwitch.getWordIndex());
            jsonObject.put("EXCLE_INDEX", attachmentIndexSwitch.getExcleIndex());
            jsonObject.put("PPT_INDEX", attachmentIndexSwitch.getPptIndex());
            jsonObject.put("PDF_INDEX", attachmentIndexSwitch.getPdfIndex());
            jsonObject.put("HTML_INDEX", attachmentIndexSwitch.getHtmlIndex());
            jsonObject.put("TXT_INDEX", attachmentIndexSwitch.getTxtIndex());
            attachmentIndexSwitch.setAlldocIndexFileType(jsonObject.toString());
            map.put("paraName", "ALLDOC_INDEX_FILETYPE");
            map.put("paraValue", attachmentIndexSwitch.getAlldocIndexFileType());
            sysParaMapper.updateAttach(map);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }




//
//    public ToJson selectByStr(HttpServletRequest request, String str) {
//        ToJson json = null;
//        try {
//            json = new ToJson();
//            List<String> strs = new ArrayList<>();
//            String[] s = str.split(" ");
//            for (String s1 : s) {
//                if (!StringUtils.checkNull(s1)) {
//                    strs.add(s1);
//                }
//            }
//            List<AttachmentIndex> attachmentIndices = attachmentIndexMapper.selectByStr(strs);
//            json.setObj(attachmentIndices);
//            json.setFlag(0);
//            json.setMsg("ok");
//        } catch (Exception e) {
//            e.printStackTrace();
//            json.setFlag(1);
//            json.setMsg("err");
//        }
//
//        return json;
//    }



}
