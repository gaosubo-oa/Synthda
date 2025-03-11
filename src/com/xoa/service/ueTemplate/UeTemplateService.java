package com.xoa.service.ueTemplate;

import com.xoa.dao.ueTemplate.UeTemplateMapper;
import com.xoa.model.ueTemplate.UeTemplateWithBLOBs;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UeTemplateService {
    @Autowired
    UeTemplateMapper ueTemplateMapper;

    /**
    * @author 程叶同
    * @date 2018/7/31 10:45
    * @desc 添加ue模板
    */
    public BaseWrapper insertUeTemplate(UeTemplateWithBLOBs ueTemplateWithBLOBs){
        BaseWrapper baseWrapper=new BaseWrapper();
        ueTemplateWithBLOBs.setCreateTime(new Date());
        int i = ueTemplateMapper.insertSelective(ueTemplateWithBLOBs);
        if (i > 0) {
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("添加成功");
            baseWrapper.setStatus(true);
        }
        return  baseWrapper;
    }
    /**
    * @author 程叶同
    * @date 2018/7/31 10:47
    * @desc  删除模板
    */
    public  BaseWrapper deleteUeTemplate(int id){
        BaseWrapper baseWrapper=new BaseWrapper();
        if (id == 0) {
            baseWrapper.setMsg("参数错误");
        }
        int i = ueTemplateMapper.deleteByPrimaryKey(id);
        if (i > 0) {
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("删除成功");
            baseWrapper.setStatus(true);
        }
        return  baseWrapper;
    }
    /**
    * @author 程叶同
    * @date 2018/7/31 11:50
    * @desc修改
    */

    public BaseWrapper updateUeTemplate(UeTemplateWithBLOBs ueTemplateWithBLOBs){
        BaseWrapper baseWrapper=new BaseWrapper();
       int i= ueTemplateMapper.updateByPrimaryKeySelective(ueTemplateWithBLOBs);
        if (i>0) {
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("修改");
            baseWrapper.setStatus(true);
        }
        return  baseWrapper;
    }
    /**
    * @author 程叶同
    * @date 2018/7/31 10:49
    * @desc  查询详情
    */
    public BaseWrapper getUeTemplateById(int id){
        BaseWrapper baseWrapper=new BaseWrapper();
        if (id == 0) {
            baseWrapper.setMsg("参数错误");
        }
        UeTemplateWithBLOBs ueTemplateWithBLOBs= ueTemplateMapper.selectByPrimaryKey(id);
        if (ueTemplateWithBLOBs!=null) {
            baseWrapper.setData(ueTemplateWithBLOBs);
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("查询成功");
            baseWrapper.setStatus(true);
        }
        return  baseWrapper;
    }
    /**
    * @author 程叶同
    * @date 2018/7/31 10:50
    * @desc 模板列表
    */
    public BaseWrapper getUeTemplateList( ){
        BaseWrapper baseWrapper=new BaseWrapper();
        List<UeTemplateWithBLOBs> ueTemplateWithBLOBs = ueTemplateMapper.getUeTemplateList();
        if (ueTemplateWithBLOBs != null) {
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("查询成功");
            baseWrapper.setData(ueTemplateWithBLOBs);
        }
        return  baseWrapper;
    }
}
