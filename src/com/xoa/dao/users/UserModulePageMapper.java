package com.xoa.dao.users;

import com.xoa.model.users.UserModulePage;
import com.xoa.model.users.UserModulePageExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserModulePageMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int countByExample(UserModulePageExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int deleteByExample(UserModulePageExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer pageId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int insert(UserModulePage record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int insertSelective(UserModulePage record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    List<UserModulePage> selectByExample(UserModulePageExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    UserModulePage selectByPrimaryKey(Integer pageId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") UserModulePage record, @Param("example") UserModulePageExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") UserModulePage record, @Param("example") UserModulePageExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(UserModulePage record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_module_page
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(UserModulePage record);
}