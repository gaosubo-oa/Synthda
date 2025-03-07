package com.xoa.dao.wages_manage;



import com.xoa.model.wages_manage.WagesJobManage;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 马东辉
 * @date 2021/11/30
 * @desc
 */
public interface WagesJobManageMapper {
    int deleteById(Integer jobManageId);

    int insert(WagesJobManage wagesJobManage);

    WagesJobManage selectById(@Param("jobManageId") Integer jobManageId);

    List<WagesJobManage> selectAll(Map<String, Object> map);

    int update(WagesJobManage wagesJobManage);

    WagesJobManage  selectByTypeAndName(@Param("job") String job,@Param("type1") String type1,@Param("type2") String type2);
    WagesJobManage  selectByName(String cell);
    List<WagesJobManage> selectAllData();
}
