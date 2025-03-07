package com.xoa.service.myNotify;

import com.xoa.model.myNotify.MySysPara;
import com.xoa.model.users.Users;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
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
public interface MySysParaService {
    /**
     *
     * @Title: getIeTitle
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return
     * @return: List<SysPara>
     * @throws
     */
    List<MySysPara> getIeTitle();

	List<MySysPara> getIeTitle1();
    /**
     *
     * @Title: updateSysPara
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param sysPara
     * @return: void
     * @throws
     */
    void updateSysPara(MySysPara sysPara,String specifyTable);

	void updateSysPara1(MySysPara sysPara,String specifyTable);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 11:41
     * @函数介绍: 获取sys_para, 前端传入key, 获取对应value
     * @参数说明: @param sysPara 封装sys_para表对应的实体类
     * @return: List<SysPara>
     * @param paraName
     * */
    List<MySysPara> getTheSysParam(String paraName,String specifyTable);


    public ToJson<MySysPara> getUserName(String paraName,String specifyTable);

    public ToJson<Object> editSysPara(String usersIds,String specifyTable);

    public boolean checkIsHaveSecure(Users users, Integer type,String specifyTable);
    public ToJson<Object> getStatus(String specifyTable);



    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 设置教务管理中的参数设置
     * @参数说明: @param MySysPara
     * @return: json
     **/
    public ToJson<MySysPara> eduSetParam(String firstDate, String secondDate, String initPwd,String specifyTable);

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 获取教务管理的参数
     * @参数说明: @param MySysPara
     * @return: json
     **/
    public AjaxJson selEduParam(String specifyTable);
    public ToJson<Object> editOperator(String usersIds,String specifyTable);
    public ToJson<MySysPara> getOperator(String paraName,String specifyTable);

    /**
     * 参数设置，不存在插入，存在更新
     * @param MySysPara
     * @return
     */
    public ToJson<Object> setSysPara(MySysPara sysPara,String specifyTable);

    MySysPara getSecGraphic(String specifyTable);

    public ToJson<Object> selectDemo(MySysPara sysPara,String specifyTable);

    public ToJson<Object> checkDemo(String specifyTable);

    public ToJson<Object> updatePersonnelSelectionRange(MySysPara sysPara,String specifyTable);

    public ToJson<Object> queryOrgScope(String specifyTable);

    List<MySysPara> getVersion(String specifyTable);

    List<MySysPara> getVersionIos(String specifyTable);

    MySysPara getSelectPassword(String specifyTable);

    Map<String,String> selectSysPCAI(HttpServletRequest request,String specifyTable);

    ToJson selectProjectId(HttpServletRequest request,String specifyTable);

    ToJson<Object> selectByParaName(String paraName,String specifyTable);

    ToJson<Object> updateSysParaPlus(MySysPara sysPara,String specifyTable);
}
