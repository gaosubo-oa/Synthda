package com.xoa.service.portals;

import com.xoa.model.portals.Portals;
import com.xoa.model.portals.PortalsUser;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2018/2/28.
 */
public interface PortalsService {

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 添加门户
     */
    public ToJson<Portals> addPortals(Portals portals);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 修改门户
     */
    public ToJson<Portals> updatePortals(HttpServletRequest request,Portals portals);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 查询所有门户
     */
    public ToJson<Portals> selPortals(PageParams pageParams,Portals portals);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 删除门户信息
     */
    public ToJson<Portals> deletePortals(String PortalsIds);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据id查询信息
     */
    public ToJson<Portals> selPortalsById(Integer portalsId);

    /**
     * 作者: 张航宁
     * 日期: 2018/3/1
     * 说明: 获取门户用户信息
     */
    ToJson<PortalsUser> selPortalsUser(HttpServletRequest request);

    /**
     * 作者: 张航宁
     * 日期: 2018/3/2
     * 说明: 查询所有门户显示在主页 【有权限判断】
     */
    public ToJson<Portals> selIndexPortals(HttpServletRequest request);

    ToJson<Portals> updatePersonal(String myTableRight,Integer portalsId);
}
