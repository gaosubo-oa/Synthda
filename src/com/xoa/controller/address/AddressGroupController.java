package com.xoa.controller.address;

import com.xoa.model.addressGroup.AddressGroupWithBLOBs;
import com.xoa.service.address.AddressGroupService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
@Controller
@RequestMapping("addressGroup")
public class AddressGroupController {

    @Autowired
    AddressGroupService addressGroupService;
    //返回分组管理页面
    @RequestMapping("/manager")
    public String addressGroup(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/group/group_manage";
    }

    //返回分组信息页面
    @RequestMapping("/showGroup")
    public String showGroup(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/group/show_group";
    }

    //返回添加分组页面
    @RequestMapping("/add")
    public String groupAdd(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/address/group/group_new";
    }

    /**
     * 判断是否存在
     */
    @ResponseBody
    @RequestMapping("/isExis")
    public BaseWrapper isExis(HttpServletRequest request, String group_name){
        return addressGroupService.isExis(request,group_name);
    }

    /**
     * 添加分组
     */
    @ResponseBody
    @RequestMapping("/addGroup")
    public BaseWrapper addGroup(HttpServletRequest request, String group_name, String ids){
        return addressGroupService.addGroup(request,group_name,ids);
    }

    /**
     * 获取所有分组
     */
    @ResponseBody
    @RequestMapping("/getGroups")
    public BaseWrapper getGroups(HttpServletRequest request){
        return addressGroupService.getGroups(request);
    }

    /**
     * 删除分组
     */
    @ResponseBody
    @RequestMapping("/deleteGroups")
    public BaseWrapper deleteGroups(HttpServletRequest request, String groupId){
        return addressGroupService.deleteGroups(request,groupId);
    }

    /**
     * 获取分组信息
     */
    @ResponseBody
    @RequestMapping("/getGroupInfo")
    public BaseWrapper getGroupInfo(HttpServletRequest request, String groupId){
        return addressGroupService.getGroupInfo(request,groupId);
    }

    /**
     * 修改分组信息
     */
    @ResponseBody
    @RequestMapping("/putGroup")
    public BaseWrapper putGroup(HttpServletRequest request, String groupId, String group_name, String FLD_STR){

        return addressGroupService.putGroup(request,groupId,group_name,FLD_STR);
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/21
     * 说明: 添加公共通讯簿分组
     */
    @ResponseBody
    @RequestMapping("/addPublicGroup")
    public ToJson<AddressGroupWithBLOBs> addPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs) {

        return addressGroupService.addPublicGroup(request, addressGroupWithBLOBs);
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/22
     * 说明: 公共通讯簿分组列表
     */
    @ResponseBody
    @RequestMapping("/getPublicGroups")
    public ToJson<AddressGroupWithBLOBs> getPublicGroups(HttpServletRequest request, Integer page,
                                                            Integer pageSize, boolean useFlag) {
        return addressGroupService.getPublicGroups(request, page, pageSize, useFlag);
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/22
     * 说明: 公共通讯簿分组修改
     */
    @ResponseBody
    @RequestMapping("/updatePublicGroup")
    public ToJson<AddressGroupWithBLOBs> updatePublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs){
        return addressGroupService.updatePublicGroup(request, addressGroupWithBLOBs);
    }
    @ResponseBody
    @RequestMapping("/stickPublicGroup")
    public ToJson<AddressGroupWithBLOBs> stickPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs){
        return addressGroupService.stickPublicGroup(request, addressGroupWithBLOBs);
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/22
     * 说明: 公共通讯簿分组详情
     */
    @ResponseBody
    @RequestMapping("/selectPublicGroupInfo")
    public ToJson<AddressGroupWithBLOBs> selectPublicGroupInfo(Integer groupId){
        return addressGroupService.selectPublicGroupInfo(groupId);
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/22
     * 说明: 查询通讯簿分组 并根据权限查询公共分组
     */
    @ResponseBody
    @RequestMapping("/selectAllAddressGroup")
    public BaseWrapper selectAllAddressGroup(HttpServletRequest request) {
        return addressGroupService.selectAllAddressGroup(request);
    }


}
