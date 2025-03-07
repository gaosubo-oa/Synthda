package com.xoa.service.address.impl;

import com.xoa.dao.address.AddressGroupMapper;
import com.xoa.dao.address.AddressMapper;
import com.xoa.model.addressGroup.AddressGroup;
import com.xoa.model.addressGroup.AddressGroupWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.address.AddressGroupService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.I18nUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 张勇 on 2017/10/7.
 */
@Service
public class AddressGroupServiceImpl implements AddressGroupService {
    @Autowired
    private AddressGroupMapper addressGroupMapper;

    @Autowired
    private AddressMapper addressMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private UsersPrivService usersPrivService;

    @Resource
    private UsersService usersService;

    /**
     * auth: 杨超
     * 判断新建的组名是否存在
     */
    @Override
    public BaseWrapper isExis(HttpServletRequest request, String groupName) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        Map param = new HashMap<String, Object>();
        param.put("groupName", groupName);
        param.put("usersId", users.getUserId());
        List<AddressGroup> addressGroups = addressGroupMapper.selectGroupsByName(param);
        if (addressGroups.size() > 0) {
            baseWrapper.setData(true);
        } else {
            baseWrapper.setData(false);
        }
        return baseWrapper;
    }

    public BaseWrapper isPublicExis(HttpServletRequest request, String groupName) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        Map param = new HashMap<String, Object>();
        param.put("groupName", groupName);
        param.put("usersId", "");
        List<AddressGroup> addressGroups = addressGroupMapper.selectGroupsByName(param);
        if (addressGroups.size() > 0) {
            for (AddressGroup addressGroup1:addressGroups){
                if(addressGroup1.getUserId()==null || addressGroup1.getUserId()==""){
                    baseWrapper.setData(true);
                }else {
                    baseWrapper.setData(false);
                }
            }
        } else {
            baseWrapper.setData(false);
        }
        return baseWrapper;
    }


    /***
     * 添加分组
     * @auth: 杨超
     * @param request
     * @param groupName
     * @param ids
     * @return
     */
    public BaseWrapper addGroup(HttpServletRequest request, String groupName, String ids) {
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);

        BaseWrapper baseWrapper = new BaseWrapper();
        //判断分组是否存在
        BaseWrapper isexis = isExis(request,groupName);
        if((boolean)isexis.getData()){
            baseWrapper.setFlag(false);
            baseWrapper.setMsg(I18nUtils.getMessage("depatement.th.Modifya"));
            return baseWrapper;
        }

        AddressGroupWithBLOBs addressGroupWithBLOBs = new AddressGroupWithBLOBs();
        addressGroupWithBLOBs.setGroupName(groupName);
        addressGroupWithBLOBs.setUserId(users.getUserId());
        addressGroupWithBLOBs.setShareGroupId(0);
        int count = addressGroupMapper.insertSelective(addressGroupWithBLOBs);
        if (ids != null && !"".equals(ids)) {
        }
        baseWrapper.setData(addressGroupWithBLOBs);
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    /**
     * 作者:季佳伟
     * 日期: 2017/12/21
     * 说明: 添加公共通讯簿分组
     */
    public ToJson<AddressGroupWithBLOBs> addPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs) {
        ToJson<AddressGroupWithBLOBs> json = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try{
            //判断分组是否存在
            BaseWrapper isexis = isPublicExis(request,addressGroupWithBLOBs.getGroupName());
            if((boolean)isexis.getData()){
                json.setFlag(1);
                json.setMsg(I18nUtils.getMessage("depatement.th.Modifya"));
                return json;
            }

            addressGroupWithBLOBs.setShareGroupId(0);
            int count = addressGroupMapper.insertSelective(addressGroupWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }

        return json;
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/21
     * 说明: 查看公共通讯簿分组
     */
    public ToJson<AddressGroupWithBLOBs> getPublicGroups(HttpServletRequest request, Integer page,
                                                         Integer pageSize, boolean useFlag) {
        ToJson<AddressGroupWithBLOBs> json = new ToJson<>();
        try {
            PageParams pageParams=new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("userId","");
            List<AddressGroupWithBLOBs> addressGroupWithBLOBsList =addressGroupMapper.selectPublicGroup(map);
            for(AddressGroupWithBLOBs addressGroupWithBLOBs:addressGroupWithBLOBsList){
                String privDept = addressGroupWithBLOBs.getPrivDept();
                if(!StringUtils.checkNull(privDept)){
                    String  depName= departmentService.getDeptNameByDeptId(privDept,",");
                    if(!"ALL_DEPT".trim().equals(addressGroupWithBLOBs.getPrivDept())){
                        addressGroupWithBLOBs.setDeptRange(depName+",");
                    }else{
                        addressGroupWithBLOBs.setDeptRange(depName);
                    }

                }
                String privRole = addressGroupWithBLOBs.getPrivRole();
                if(!StringUtils.checkNull(privRole)){
                    String  roleName= usersPrivService.getPrivNameByPrivId(privRole,",");
                    addressGroupWithBLOBs.setRoleRange(roleName+",");
                }
                String privUser = addressGroupWithBLOBs.getPrivUser();
                if(!StringUtils.checkNull(privUser)){
                    String  userName= usersService.getUserNameById(privUser);
                    addressGroupWithBLOBs.setUserRange(userName+",");
                }

            }
            json.setObj(addressGroupWithBLOBsList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 作者:季佳伟
     * 日期: 2017/12/21
     * 说明: 修改公共通讯簿分组
     */
    public ToJson<AddressGroupWithBLOBs> updatePublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs){
        ToJson<AddressGroupWithBLOBs> json = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {

            Map<String, Object> map = new HashMap<String, Object>();
            if(addressGroupWithBLOBs.getGroupName()!=null&&!addressGroupWithBLOBs.getGroupName().equals("")){
                map.put("groupName",addressGroupWithBLOBs.getGroupName());
            }
            map.put("userId","");
            List<AddressGroup> addressGroupList = addressGroupMapper.selectGroupsByName(map);
            if(addressGroupList.size()>0){
                for (AddressGroup addressGroup:addressGroupList){
                    if (addressGroup.getGroupId()!=addressGroupWithBLOBs.getGroupId()){
                        json.setMsg(I18nUtils.getMessage("depatement.th.Modifya"));
                        json.setFlag(1);
                        return json;
                    }
                }
            }
            addressGroupMapper.updatePublicGroup(addressGroupWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;

    }

    /**
     * 作者:季佳伟
     * 日期: 2017/12/22
     * 说明: 公共通讯簿分组详情
     */
    public ToJson<AddressGroupWithBLOBs> selectPublicGroupInfo(Integer groupId){
        ToJson<AddressGroupWithBLOBs> json = new ToJson<>();
        try {
            AddressGroupWithBLOBs addressGroupWithBLOBs = addressGroupMapper.selectPublicGroupInfo(groupId);
            String privDept = addressGroupWithBLOBs.getPrivDept();
            if(!StringUtils.checkNull(privDept)){
                String depName= departmentService.getDeptNameByDeptId(privDept,",");
                if(!"ALL_DEPT".trim().equals(addressGroupWithBLOBs.getPrivDept())){
                    addressGroupWithBLOBs.setDeptRange(depName+",");
                }else{
                    addressGroupWithBLOBs.setDeptRange(depName);
                }

            }
            //权限部门
            String supportDept = addressGroupWithBLOBs.getSupportDept();
            if(!StringUtils.checkNull(supportDept)){
                String supportDeptName= departmentService.getDeptNameByDeptId(supportDept,",");
                if(!"ALL_DEPT".trim().equals(supportDept)){
                    addressGroupWithBLOBs.setSupportDeptName(supportDeptName+",");
                }else{
                    addressGroupWithBLOBs.setSupportDeptName(supportDeptName);
                }

            }
            String privRole = addressGroupWithBLOBs.getPrivRole();
            if(!StringUtils.checkNull(privRole)){
                String  roleName= usersPrivService.getPrivNameByPrivId(privRole,",");
                addressGroupWithBLOBs.setRoleRange(roleName+",");
            }
            String privUser = addressGroupWithBLOBs.getPrivUser();
            if(!StringUtils.checkNull(privUser)){
                String  userName= usersService.getUserNameById(privUser);
                addressGroupWithBLOBs.setUserRange(userName+",");
            }
            //权限人员
            String supportUser = addressGroupWithBLOBs.getSupportUser();
            if(!StringUtils.checkNull(supportUser)){
                String  supportUserName= usersService.getUserNameById(supportUser);
                addressGroupWithBLOBs.setSupportUserName(supportUserName+",");
            }
            json.setObject(addressGroupWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;

    }



    /***
     * 获取所有分组
     * @auth: 杨超
     * @param request
     * @return
     */
    @Override
    public BaseWrapper getGroups(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Map param = new HashMap();
            param.put("userId",users.getUserId());

            baseWrapper.setData(addressGroupMapper.selectGroupsByName(param));
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
        }catch (Exception e){
            e.printStackTrace();
            baseWrapper.setMsg(e.getMessage());
        }

        return baseWrapper;
    }

    /**
     * 作者:季佳伟
     * 日期: 2017/12/25
     * 说明: 获取通讯簿分组，并根据权限获取公共通讯簿分组
     */
    public BaseWrapper selectAllAddressGroup(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);

            Map<String, Object> maps = new HashMap<String, Object>();
            maps.put("uuserId",users.getUserId());
            maps.put("privDept", users.getDeptId() + "");
            maps.put("privRole", users.getUserPriv() + "");
            maps.put("privUser", users.getUserId());
            List<AddressGroupWithBLOBs> addressGroupWithBLOBs = addressGroupMapper.selectAllAddressGroup(maps);
            baseWrapper.setData(addressGroupWithBLOBs);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
        }catch (Exception e){
            e.printStackTrace();
            baseWrapper.setMsg(e.getMessage());
        }
        return baseWrapper;
    }


    /**
     * 删除分组信息，并将该分组下的用户移至默认分组
     * @param request
     * @param groupId
     * @return
     */
    @Override
    public BaseWrapper deleteGroups(HttpServletRequest request, String groupId) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);

        //修改当前分组的用户到默认分组
        Map param = new HashedMap();
        param.put("userId",users.getUserId());
        //需要迁移到的组id
        param.put("groupId",0);
        //当前组id
        param.put("oldId",groupId);
        addressMapper.updateUserGroup(param);


        //删除当前组
        int status = addressGroupMapper.deleteByPrimaryKey(Integer.valueOf(groupId));
        baseWrapper.setStatus(status>0);
        baseWrapper.setFlag(status>0);
        return baseWrapper;
    }

    /**
     * 获取分组信息
     * @param request
     * @param groupId
     * @return
     */
    public BaseWrapper getGroupInfo(HttpServletRequest request, String groupId){
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setData(addressGroupMapper.selectByPrimaryKey(Integer.valueOf(groupId)));
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        return baseWrapper;
    }

    @Override
    public BaseWrapper putGroup(HttpServletRequest request, String groupId, String group_name, String FLD_STR) {
        BaseWrapper baseWrapper = new BaseWrapper();
        //获取当前登陆的用户user_id
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);

        if(groupId ==null){
            baseWrapper.setMsg(I18nUtils.getMessage("address.th.groupingError"));
            baseWrapper.setStatus(false);
            return baseWrapper;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("groupName",group_name);
        map.put("userId",users.getUserId());
        List<AddressGroup> addressGroupList = addressGroupMapper.selectGroupsByName(map);
        if(addressGroupList.size()>0){
            for (AddressGroup addressGroup:addressGroupList){
                if (addressGroup.getGroupId()!=Integer.parseInt(groupId)){
                    baseWrapper.setFlag(false);
                    baseWrapper.setMsg(I18nUtils.getMessage("depatement.th.Modifya"));
                    return baseWrapper;
                }
            }
        }
        //如果提交的分组名不为空且有效则修改
        if(group_name!=null && !"".equals(group_name)){
            AddressGroupWithBLOBs addressGroupWithBLOBs = new AddressGroupWithBLOBs();
            addressGroupWithBLOBs.setGroupId(Integer.valueOf(groupId));
            addressGroupWithBLOBs.setGroupName(group_name);
            addressGroupMapper.updateByPrimaryKeySelective(addressGroupWithBLOBs);
        }
        // 如果提交的联系人id字符串不为空则修改这些联系人的分组
        if(FLD_STR != null && !"".equals(FLD_STR)){
            Map param = new HashedMap();
            param.put("groupId",groupId);
            param.put("fldStr",(FLD_STR+"0").split(","));
            param.put("userId",users.getUserId());
            addressMapper.putUser(param);
        }
        baseWrapper.setData(addressGroupMapper.selectByPrimaryKey(Integer.valueOf(groupId)));
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        return baseWrapper;
    }


    @Override
    public ToJson<AddressGroupWithBLOBs> stickPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs) {
        ToJson<AddressGroupWithBLOBs> json = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if(addressGroupWithBLOBs.getGroupName()!=null&&!addressGroupWithBLOBs.getGroupName().equals("")){
                map.put("groupName",addressGroupWithBLOBs.getGroupName());
            }
            map.put("userId","");
            List<AddressGroup> addressGroupList = addressGroupMapper.selectGroupsByName(map);
            if(addressGroupList.size()>0){
                for (AddressGroup addressGroup:addressGroupList){
                    if (addressGroup.getGroupId()!=addressGroupWithBLOBs.getGroupId()){
                        json.setMsg(I18nUtils.getMessage("depatement.th.Modifya"));
                        json.setFlag(1);
                        return json;
                    }
                }
            }
            addressGroupMapper.stickPublicGroup(addressGroupWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }
}
