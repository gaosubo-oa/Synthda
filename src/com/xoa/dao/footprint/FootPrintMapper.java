package com.xoa.dao.footprint;


import com.xoa.model.footprint.Foot;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FootPrintMapper {


    void addFootPrint(Foot foot);

    List<Foot> getFootPrintByDepId(Map<String, Object> hashMap);

    List<Foot> getWebFootPrintByDepId(Map<String, Object> hashMap);

    List<Foot> getFootPrintByUid(Map<String, Object> hashMap);

    List<Foot> getWebFootPrintByUid(Map<String, Object> hashMap);

    List<Foot> getAllFootPrint(Map<String, Object> hashMap);

    List<Foot> getWebAllFootPrint(Map<String, Object> hashMap);

    List<Foot> getUserDayFootPrint(Map<String, Integer> hashMap);

    List<Foot> getDeptFootPrintByCondition(Map<String, Object> hashMap);

    List<Foot> getAllFootPrintByCondition(Map<String, Object> hashMap);

    List<Foot> getDeptFootPrintByTime(Map<String, Long> map);

    List<Foot> getFootPrintByUidTime(Map<String, Object> hashMap);

    List<Foot> getAllFootPrintByTime(Map<String, Object> hashMap);

    List<Foot> getTheDayFootPrint(Map<String, Object> hashMap);

      int editFootByTime(@Param("time") Integer time,@Param("uid") Integer uid,@Param("id") Integer id);
      Foot queryById(@Param("id") Integer id);
}
