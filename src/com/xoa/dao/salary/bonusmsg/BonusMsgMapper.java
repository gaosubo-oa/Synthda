package com.xoa.dao.salary.bonusmsg;

import com.xoa.model.salary.bonusmsg.BonusMsg;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BonusMsgMapper {

    //插入
    int inserMsg(Map<String,Object> map1);

    List<BonusMsg> getHrStaffContractList(String userId);

    List<Map>queryBounsMsgByBounsId(Map map);

    int deleteBMsg(Map map);

    //修改
    int updateBMsg(Map map);

    int deleteBonusMsg(@Param("bonusMsgId") Integer bonusMsgId);
}