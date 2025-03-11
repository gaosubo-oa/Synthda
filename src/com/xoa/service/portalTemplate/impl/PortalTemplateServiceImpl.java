package com.xoa.service.portalTemplate.impl;


import com.xoa.dao.portalTemplate.PortalTemplateMapper;
import com.xoa.model.portalTemplate.PortalTemplateExample;
import com.xoa.model.portalTemplate.PortalTemplateWithBLOBs;
import com.xoa.service.portalTemplate.PortalTemplateService;
import com.xoa.util.FileUtility;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;


@Service
public class PortalTemplateServiceImpl implements PortalTemplateService {

    @Resource
    private PortalTemplateMapper portalTemplateMapper;

    @Override
    @Transactional
    public ToJson<PortalTemplateWithBLOBs> selectPortalTemplate(Integer portalId) {
        ToJson<PortalTemplateWithBLOBs> json = new ToJson<PortalTemplateWithBLOBs>();
        try {
            List<PortalTemplateWithBLOBs> list =  portalTemplateMapper.selectPortalTemplate(portalId);
            if (list.size() > 0) {
                json.setObj(list);
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    @Override
    @Transactional
    public ToJson<PortalTemplateWithBLOBs> selectPortalTemplateById(HttpServletRequest request,Integer templateId) {
        ToJson<PortalTemplateWithBLOBs> json = new ToJson<PortalTemplateWithBLOBs>();
        try {
            PortalTemplateWithBLOBs portalTemplate =  portalTemplateMapper.selectByPrimaryKey(templateId);
            String rootPath = request.getSession().getServletContext().getRealPath("/") + File.separator +"cmsTmp" + File.separator + portalTemplate.getPortalId();
            portalTemplate.setTemplateContent(FileUtility.file2String(rootPath + File.separator + portalTemplate.getTemplateFile()));
                json.setObject(portalTemplate);
                json.setMsg("ok");
                json.setFlag(0);

        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }


    @Override
    @Transactional
    public ToJson<PortalTemplateWithBLOBs> insertPortalTemplate(HttpServletRequest request, PortalTemplateWithBLOBs portalTemplateWithBLOBs) {
        ToJson<PortalTemplateWithBLOBs> toJson = new ToJson<PortalTemplateWithBLOBs>(1, "error");
        //判断是否存在相同的文件名
        PortalTemplateExample example = new PortalTemplateExample();
        PortalTemplateExample.Criteria criteria = example.createCriteria();
        criteria.andPortalIdEqualTo(portalTemplateWithBLOBs.getPortalId());
        criteria.andTemplateFileEqualTo(portalTemplateWithBLOBs.getTemplateFile());
        int  a = portalTemplateMapper.countByExample(example);
        if(a>0){
            toJson.setFlag(1);
            toJson.setMsg("存在相同的文件名称");
            return toJson;
        }

        try {
            int temp = portalTemplateMapper.insertSelective(portalTemplateWithBLOBs);
            if (temp > 0) {
                //创建文件并保存模板类容
                String rootPath = request.getSession().getServletContext().getRealPath("/") + File.separator +"cmsTmp" + File.separator + portalTemplateWithBLOBs.getPortalId();
                FileUtility.string2File(rootPath + File.separator + portalTemplateWithBLOBs.getTemplateFile(),portalTemplateWithBLOBs.getTemplateContent());
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    @Transactional
    public ToJson<PortalTemplateWithBLOBs> upPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs) {
        ToJson<PortalTemplateWithBLOBs> toJson = new ToJson<PortalTemplateWithBLOBs>(1, "error");
        //先将原来的模板查询出来
        PortalTemplateWithBLOBs oldPortalTemplateWithBLOBs = portalTemplateMapper.selectByPrimaryKey(portalTemplateWithBLOBs.getTemplateId());
        String rootPath = request.getSession().getServletContext().getRealPath("/") + File.separator +"cmsTmp" + File.separator + oldPortalTemplateWithBLOBs.getPortalId();



        try {
            int temp = portalTemplateMapper.updateByPrimaryKeySelective(portalTemplateWithBLOBs);
            if (temp > 0) {

                //判断文件是否改名
                if(portalTemplateWithBLOBs.getTemplateFile() != null && !portalTemplateWithBLOBs.getTemplateFile().equals(oldPortalTemplateWithBLOBs.getTemplateFile())){
                    //修改文件名
                    try {
                        FileUtility.fileRename(rootPath + File.separator + oldPortalTemplateWithBLOBs.getTemplateFile(),portalTemplateWithBLOBs.getTemplateFile());
                    } catch (Exception e) {
                        //重命名失败
                        e.printStackTrace();
                        toJson.setFlag(1);
                        toJson.setMsg(e.getMessage());
                        return toJson;
                    }
                }

                //修改文件内容
                FileUtility.string2File(rootPath + File.separator + portalTemplateWithBLOBs.getTemplateFile(),portalTemplateWithBLOBs.getTemplateContent());

                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<PortalTemplateWithBLOBs> delPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs) {
        ToJson<PortalTemplateWithBLOBs> toJson = new ToJson<PortalTemplateWithBLOBs>(1, "error");

        //先将原来的模板查询出来
        PortalTemplateWithBLOBs oldPortalTemplateWithBLOBs = portalTemplateMapper.selectByPrimaryKey(portalTemplateWithBLOBs.getTemplateId());


        try {
            int temp = portalTemplateMapper.delPortalTemplate(portalTemplateWithBLOBs);
            if (temp > 0) {
                //删除文件
                String rootPath = request.getSession().getServletContext().getRealPath("/") + File.separator +"cmsTmp" + File.separator + oldPortalTemplateWithBLOBs.getPortalId();
                FileUtility.fileDelete(rootPath + File.separator + oldPortalTemplateWithBLOBs.getTemplateFile());
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }


}