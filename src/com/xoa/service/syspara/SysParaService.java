package com.xoa.service.syspara;

import com.xoa.model.common.SysPara;
import com.xoa.model.users.Users;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
    * 
    * @ClassName (类名):  SysParaService
    * @Description(简述): 接口
    * @author(作者):      张丽军
    * @date(日期):        2017-5-5 下午4:28:49
    *
    */
@Service
public interface SysParaService {
    /**
     * 
     * @Title: getIeTitle
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: List<SysPara>   
     * @throws
     */
    List<SysPara> getIeTitle();
	
	List<SysPara> getIeTitle1();
    /**
     * 
     * @Title: updateSysPara
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param sysPara   
     * @return: void   
     * @throws
     */
    void updateSysPara(SysPara sysPara);
    ToJson updateByParaName(SysPara sysPara);
    ToJson selectByParaNames(HttpServletRequest request,String paraName);
    ToJson selectSysParaByParaName(String paraName);
	void updateSysPara1(SysPara sysPara);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 11:41
     * @函数介绍: 获取sys_para, 前端传入key, 获取对应value
     * @参数说明: @param sysPara 封装sys_para表对应的实体类
     * @return: List<SysPara>
     * @param paraName
     * */
    List<SysPara> getTheSysParam(String paraName);


    public ToJson<SysPara> getUserName(String paraName);

    public ToJson<Object> editSysPara(String usersIds);

    public boolean checkIsHaveSecure(Users users, Integer type);
    public ToJson<Object> getStatus();



    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 设置教务管理中的参数设置
     * @参数说明: @param sysPara
     * @return: json
     **/
    public ToJson<SysPara> eduSetParam(String firstDate,String secondDate,String initPwd);

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 获取教务管理的参数
     * @参数说明: @param sysPara
     * @return: json
     **/
    public AjaxJson selEduParam();
    public ToJson<Object> editOperator(String usersIds);
    public ToJson<SysPara> getOperator(String paraName);

    /**
     * 参数设置，不存在插入，存在更新
     * @param sysPara
     * @return
     */
    public ToJson<Object> setSysPara(SysPara sysPara);

    SysPara getSecGraphic();

    public ToJson<Object> selectDemo(SysPara sysPara);

    public ToJson<Object> checkDemo();

    public ToJson<Object> updatePersonnelSelectionRange(SysPara sysPara);

    public ToJson<Object> queryOrgScope();

    List<SysPara> getVersion();

    List<SysPara> getVersionIos();

    SysPara getSelectPassword();

    Map<String,String> selectSysPCAI(HttpServletRequest request);

    ToJson selectProjectId(HttpServletRequest request);

    ToJson<Object> selectByParaName(String paraName);

    ToJson<Object> updateSysParaPlus(SysPara sysPara);

    SysPara selectNtkoLicense();

    //查询自定义告示栏内容
    ToJson<Object> selectSysParaAtPortal(String title,String content);

    //更新自定义告示栏
    ToJson<Object> updateSysParaProtal(String title1, String content1,String title2, String content2,String title3, String content3);

    ToJson querySysParaProtal();

    ToJson querySecrecySysPara(HttpServletRequest request);

    ToJson updateSecrecySysPara(String jsonStr, HttpServletRequest request);


    BaseWrapper selAttendSetting();

    BaseWrapper updateAttendSetting(String attendFreeUserValue,String attendFreeDeptValue,String attendFreePrivValue);

}
