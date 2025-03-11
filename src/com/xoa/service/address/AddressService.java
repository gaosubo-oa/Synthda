package com.xoa.service.address;

import com.xoa.model.address.Address;
import com.xoa.model.address.AddressWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by 杨超 on 2017/10/7.
 * 通讯簿
 */
public interface AddressService {
    BaseWrapper getUsersById(HttpServletRequest request, String GROUP_ID, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE);
    BaseWrapper selectByPrimaryKey(String addId);
    BaseWrapper addUser(HttpServletRequest request, AddressWithBLOBs addressWithBLOBs, String birthday,String  addStart , String  addEnd, MultipartFile file,String type,String shareUserId);
    BaseWrapper getNotUserById(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE);
    BaseWrapper updateUser(HttpServletRequest request, AddressWithBLOBs addressWithBLOBs, String birthday,MultipartFile file,String type,String shareUserId);
    BaseWrapper deleteUser(HttpServletRequest request, Integer addId);
    Integer deleteUserss(HttpServletRequest request, String[] addId);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/12
     * 说明: 根据用户组和名字来搜索用户
     */
    BaseWrapper queryAddress(Integer groupId, String name);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/13
     * 说明: 获取同事信息接口
     */
    BaseWrapper getColleagues(HttpServletRequest request);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/18
     * 说明: 导入
     */
    public ToJson<Address> importAddress(HttpServletRequest request, HttpServletResponse response, MultipartFile file);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/18
     * 说明: 导出
     */
    public BaseWrapper exportAddress(HttpServletRequest request, HttpServletResponse response, Integer groupId);

    /**
     * 作者: 季佳伟
     * 日期: 2017/12/15
     * 说明: 查询内部联系人
     */
    public ToJson<Address> selectAddress(HttpServletRequest request, Integer page,
                                         Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response);

    /**
     * 作者: 季佳伟
     * 日期: 2017/12/15
     * 说明: 查询外部联系人
     */
    public ToJson<Users> selectUser(HttpServletRequest request, Integer page,
                                    Integer pageSize, boolean useFlag, Users user);

    public ToJson<Users> getUserInfoById(Integer uid, HttpServletRequest request);

    public ToJson<AddressWithBLOBs> importPublicAddressWithBLOBs(Integer groupId, MultipartFile file, HttpServletRequest request, HttpServletResponse response);

    public BaseWrapper getAddressUser(HttpServletRequest request, String groupId, String PUBLIC_FLAG, String SHARE_TYPE, String TYPE);

    ToJson<Address> queryAdressByName(String trim);

    BaseWrapper getShareById(HttpServletRequest request, String groupId, String public_flag, String share_type, String type);

    ToJson<Address> selectStartUser(HttpServletRequest request, Integer page, Integer pageSize, boolean useFlag, Address address, String export, HttpServletResponse response);
}
