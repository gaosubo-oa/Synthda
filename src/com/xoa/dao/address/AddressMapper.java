package com.xoa.dao.address;

import com.xoa.model.address.Address;
import com.xoa.model.address.AddressExample;
import com.xoa.model.address.AddressWithBLOBs;
import com.xoa.model.users.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AddressMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int countByExample(AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int deleteByExample(AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer addId);
    int deleteByPrimaryKeyss(String[] addId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int insert(AddressWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int insertSelective(Address record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    List<AddressWithBLOBs> selectByExampleWithBLOBs(AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    List<Address> selectByExample(AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    AddressWithBLOBs selectByPrimaryKey(Integer addId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") AddressWithBLOBs record, @Param("example") AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") AddressWithBLOBs record, @Param("example") AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") Address record, @Param("example") AddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(AddressWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(AddressWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table address
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Address record);

    List<Address> selectGroups();

    List<Address> getUsersById(Map map);

    int updateUserGroup(Map map);

    //获取不在某个分组下的名单，为分组管理下的联系人移动提供数据
    List<Address> getNotUserById(Map map);


    //根据addid来修改联系人的分组
    int putUser(Map map);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/12
     * 说明: 根据用户组和名字来搜索用户
     */
    List<Address> queryAddress(@Param("groupId") Integer groupId, @Param("name") String name);


    /**
     * 作者: 张航宁
     * 日期: 2017/10/16
     * 说明: 获取通讯簿信息
     */
    List<Address> getAllUsers(Map<String,Object> map);

    /**
     * 作者: 张航宁
     * 日期: 2017/10/19
     * 说明:
     */
    List<Address> selectAddress(Map<String,Object> map);

    List<Users> selectUser(Map<String,Object> map);

    Users getUserById(@Param("uid") Integer uid);
    Users loginUser(@Param("userId") String userId);

    List<Address> queryAdressByName(String trim);

    //批量插入
    int batchToAddress(@Param("addressList") List<AddressWithBLOBs> addresseList);

    List<Address> selectStartById(String userName);

    List<Address> selectStartAddress(Map<String, Object> map);
}
