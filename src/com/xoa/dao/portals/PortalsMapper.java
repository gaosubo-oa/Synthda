package com.xoa.dao.portals;

import com.xoa.model.portals.Portals;
import com.xoa.model.portals.PortalsExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PortalsMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int countByExample(PortalsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int deleteByExample(PortalsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer portalsId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int insert(Portals record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int insertSelective(Portals record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    List<Portals> selectByExample(PortalsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    Portals selectByPrimaryKey(Integer portalsId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") Portals record, @Param("example") PortalsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") Portals record, @Param("example") PortalsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Portals record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table portals
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Portals record);


    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 查询所有门户信息
     */
    List<Portals> selPortals(Map<String,Object> map);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据ids删除
     */
    void deletePortalsByIds(@Param("ids") String[] ids);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据id查询
     */
    Portals selPortalsById(@Param("portalsId")Integer portalsId);

}