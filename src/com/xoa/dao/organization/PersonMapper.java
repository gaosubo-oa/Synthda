package com.xoa.dao.organization;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface PersonMapper {

    @Select({"<script> select u.USER_NAME as userName,u.user_priv_name as userPrivName,u.user_id as userId,u.dept_id as deptId,d.dept_name as deptName, u.UID as uid,u.avatar as avatar,u.sex as sex " +
            "from user u ,department d " +
            "WHERE   u.DEPT_ID = d.DEPT_ID AND u.not_login !=1 AND u.DEPT_ID !=0 \n" +
            "        AND (u.DEPT_ID = #{deptId} or u.DEPT_ID_OTHER LIKE CONCAT('%,',#{deptId},',%')\n" +
            "        OR u.DEPT_ID_OTHER LIKE CONCAT(#{deptId},',%') )\n" +
            "        <if test=\"jobId != null and jobId != '' \">\n" +
            "            and u.JOB_ID = #{jobId}\n" +
            "        </if>\n" +
            "        <if test=\"postId != null and postId != '' \">\n" +
            "            and u.POST_ID = #{postId}\n" +
            "        </if>\n" +
            "        ORDER BY u.user_priv_no,u.user_no,u.user_name </script>"})
    public List<Map<String,Object>> findUserByDeptId(@Param("deptId") Integer deptId,@Param("jobId") String jobId,@Param("postId") String postId);


    @Select("select u.USER_NAME as userName,u.user_priv_name as userPrivName,u.user_id as userId,u.dept_id as deptId,d.dept_name as deptName, u.UID as uid,u.avatar as avatar,u.sex as sex from user u ,department d WHERE   u.DEPT_ID = d.DEPT_ID AND u.not_login !=1 AND u.not_mobile_login!=1  AND u.DEPT_ID!=0  and u.USER_NAME=#{departName}")
    public Map<String,Object> getUserByDeptName(String departName);

    @Select("SELECT\n" +
            "\tu.USER_NAME AS userName,\n" +
            "\tu.user_priv_name AS userPrivName,\n" +
            "\tu.user_id AS userId,\n" +
            "\tu.dept_id AS deptId,\n" +
            "\td.dept_name AS deptName,\n" +
            "\tu.UID AS uid,\n" +
            "\tu.avatar AS avatar,\n" +
            "\tu.sex AS sex \n" +
            "FROM\n" +
            "\t`USER` u\n" +
            "LEFT JOIN department d on u.DEPT_ID = d.DEPT_ID \n" +
            "WHERE\n" +
            "\tu.not_login != 1 \n" +
            "\tAND u.not_mobile_login != 1 \n" +
            "\tAND ( u.DEPT_ID = #{deptId} OR u.DEPT_ID_OTHER = #{deptId} OR u.DEPT_ID_OTHER like concat(#{deptId},',%') OR u.DEPT_ID_OTHER like concat('%,',#{deptId},',%') )")
    List<Map<String,Object>> getUserByDeptId(String deptId);
}
