package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesPriv;

import java.util.List;
import java.util.Map;

public interface WagesPrivMapper {
    int addWagesPriv(WagesPriv wagesPriv);

    int deleteWagesPriv(Integer payPriv);

    int updateWagesPriv(WagesPriv wagesPriv);

    List<WagesPriv> selectAllWagesPriv(Map<String, Object> map);

    List<WagesPriv> selectByUserId(String userId);
}
