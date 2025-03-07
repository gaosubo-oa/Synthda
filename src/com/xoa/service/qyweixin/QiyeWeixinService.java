package com.xoa.service.qyweixin;

import com.alibaba.fastjson.JSON;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.qiyeWeixin.QiyeWeixinConfigMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.qiyeWeixin.QiyeWeixinConfig;
import com.xoa.model.qiyeWeixin.QiyeWeixinSetting;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by Administrator on 2019/5/31.
 */
@Service
public class QiyeWeixinService {

    @Autowired
    private QiyeWeixinConfigMapper qiyeWeixinConfigMapper;

    @Autowired
    private SysParaMapper sysParaMapper;

    /**
     * @作者: 张航宁
     * @时间: 2019/5/31
     * @说明: 设置企业微信参数
     */
    public BaseWrapper setQiyeWeixinConfig(QiyeWeixinConfig qiyeWeixinConfig) {
        BaseWrapper baseWrapper = new BaseWrapper();

        int i = qiyeWeixinConfigMapper.updateByPrimaryKeySelective(qiyeWeixinConfig);

        if(i==0){
            QiyeWeixinConfig config = qiyeWeixinConfigMapper.selectConfig();
            if(config==null){
                qiyeWeixinConfigMapper.insertSelective(qiyeWeixinConfig);
            }
        }

        baseWrapper.setFlag(true);
        baseWrapper.setMsg("ok");
        baseWrapper.setStatus(true);

        return baseWrapper;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/5/31
     * @说明: 获取企业微信参数
     */
    public BaseWrapper getQiyeWeixinConfig() {
        BaseWrapper baseWrapper = new BaseWrapper();

        QiyeWeixinConfig config = qiyeWeixinConfigMapper.selectConfig();

        baseWrapper.setData(config);
        baseWrapper.setMsg("查询成功！");
        baseWrapper.setFlag(true);

        return baseWrapper;
    }

    /**
     * 项目获取所有的企业微信应用设置
     * @param request
     * @return
     */
    public BaseWrapper getAllWxAppSetting(HttpServletRequest request) {

        BaseWrapper baseWrapper = new BaseWrapper();
        try{
            /*
            item.add("WEIXINQY_APP_DIARY");// 工作日志
            item.add("WEIXINQY_APP_WORKFLOW");// 流程中心
            item.add("WEIXINQY_APP_EMAIL");// 电子邮件
            item.add("WEIXINQY_APP_FILEFOLDER");// 公共文件柜
            item.add("WEIXINQY_APP_NEWS");// 新闻
            item.add("WEIXINQY_APP_NOTIFY");// 公告通知
             */
            SysPara sysPara = sysParaMapper.querySysPara("WEIXINQY_APP_APPS");

            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue())){
                baseWrapper.setMsg("未配置企业微信应用");
                return baseWrapper;
            }

            Map resultMap = JSON.parseObject(sysPara.getParaValue());
            List<SysPara> result = new ArrayList<>();
            for(Object param : resultMap.keySet()){
                SysPara para = new SysPara();
                para.setParaName(param.toString());
                para.setParaValue(resultMap.get(param).toString());
                result.add(para);
            }

            baseWrapper.setData(result);
            baseWrapper.setMsg("success");
            baseWrapper.setFlag(true);
        }catch (Exception e){
            e.printStackTrace();
        }
        return baseWrapper;
    }


    /**
     * 项目根据paraName获取对应的应用设置
     * @param request
     * @param paraName
     * @return
     */
    public BaseWrapper getWxAppSetting(HttpServletRequest request,String paraName) {

        BaseWrapper baseWrapper = new BaseWrapper();
        try{
            SysPara sysPara = sysParaMapper.querySysPara(paraName);
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue())){
                baseWrapper.setMsg("未配置企业微信应用");
                return baseWrapper;
            }

            String[] settingPara = sysPara.getParaValue().split("\\|");

            QiyeWeixinSetting setting = new QiyeWeixinSetting();
            setting.setParaName(paraName);
            assemblyQiyeWeixinSetting(settingPara, setting);

            baseWrapper.setData(setting);
            baseWrapper.setMsg("success");
            baseWrapper.setFlag(true);
        }catch (Exception e){
            e.printStackTrace();
        }
        return baseWrapper;
    }


    /**
     * 项目根据paraName修改对应的应用设置
     * @param request
     * @return
     */
    public BaseWrapper setWxAppSetting(HttpServletRequest request, QiyeWeixinSetting setting) {

        BaseWrapper baseWrapper = new BaseWrapper();
        try{

            if(Objects.isNull(setting) || StringUtils.checkNull(setting.getParaName())){
                baseWrapper.setMsg("参数错误");
                return baseWrapper;
            }

            SysPara sysPara = sysParaMapper.querySysPara(setting.getParaName());
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue())){
                baseWrapper.setMsg("未配置企业微信应用");
                return baseWrapper;
            }

            //重新赋值url字段，url字段不允许修改
            //setting.setUrl(sysPara.getParaValue().split("\\|")[1]);

            String paraValue = setting.getUrl() + "|" + setting.getAgentId() + "|" + setting.getSecret();

            sysPara.setParaValue(paraValue);
            sysParaMapper.updateSysPara(sysPara);

            baseWrapper.setMsg("success");
            baseWrapper.setFlag(true);
        }catch (Exception e){
            e.printStackTrace();
        }
        return baseWrapper;
    }


    /**
     * 项目根据应用url获取对应的应用设置
     * @param request
     * @return
     */
    public BaseWrapper getWxAppSettingByUrl(String url) {

        BaseWrapper baseWrapper = new BaseWrapper();
        try{
            if(StringUtils.checkNull(url)){
                baseWrapper.setMsg("参数错误");
                return baseWrapper;
            }

            SysPara para = new SysPara();
            para.setParaName("WEIXINQY_APP_");
            para.setParaValue(url + "\\|");
            SysPara sysPara = sysParaMapper.selectByParas(para);
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue())){
                baseWrapper.setMsg("未找到企业微信应用设置");
                return baseWrapper;
            }

            String[] settingPara = sysPara.getParaValue().split("\\|");

            QiyeWeixinSetting setting = new QiyeWeixinSetting();
            setting.setParaName(sysPara.getParaName());
            assemblyQiyeWeixinSetting(settingPara, setting);

            baseWrapper.setData(setting);
            baseWrapper.setMsg("success");
            baseWrapper.setFlag(true);
        }catch (Exception e){
            e.printStackTrace();
        }
        return baseWrapper;
    }


    private void assemblyQiyeWeixinSetting(String[] settingPara, QiyeWeixinSetting setting) {
        for (int i = 0; i < settingPara.length; i++) {
            if(i == 0){
                setting.setUrl(settingPara[0]);
            }
            if(i == 1){
                setting.setAgentId(settingPara[1]);
            }
            if(i == 2){
                setting.setSecret(settingPara[2]);
            }
        }
    }
}
