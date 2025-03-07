package com.xoa.service.address;

import com.xoa.model.addressGroup.AddressGroupWithBLOBs;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by 张勇 on 2017/10/7.
 */
public interface AddressGroupService {
    BaseWrapper isExis(HttpServletRequest request, String groupName);
    BaseWrapper addGroup(HttpServletRequest request, String groupName, String ids);
    BaseWrapper getGroups(HttpServletRequest request);
    BaseWrapper deleteGroups(HttpServletRequest request, String groupId);
    BaseWrapper getGroupInfo(HttpServletRequest request, String groupId);
    BaseWrapper putGroup(HttpServletRequest request, String groupId, String group_name, String FLD_STR);
    /**
     * 作者:季佳伟
     * 日期: 2017/12/21
     * 说明: 添加公共通讯簿分组
     */
    public ToJson<AddressGroupWithBLOBs> addPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs);

    public ToJson<AddressGroupWithBLOBs> getPublicGroups(HttpServletRequest request, Integer page,
                                                         Integer pageSize, boolean useFlag) ;

    public ToJson<AddressGroupWithBLOBs> updatePublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs);

    public ToJson<AddressGroupWithBLOBs> selectPublicGroupInfo(Integer groupId);

    BaseWrapper selectAllAddressGroup(HttpServletRequest request);

    ToJson<AddressGroupWithBLOBs> stickPublicGroup(HttpServletRequest request, AddressGroupWithBLOBs addressGroupWithBLOBs);
}
