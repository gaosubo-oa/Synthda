package com.xoa.dao.diary.setting;

import com.xoa.model.diary.setting.DiaryReadPriv;

import java.util.List;
import java.util.Map;

public interface DiaryReadPrivMapper {

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/7/29
     * 方法介绍:    新增查看权限
     * 参数说明:    [diaryReadPriv]
     * 返回值说明:   int
     */
    int addDiaryReadPriv(DiaryReadPriv diaryReadPriv);

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/7/29
     * 方法介绍:    删除查看权限
     * 参数说明:    [rprivId]
     * 返回值说明:   int
     */
    int deleteDiaryReadPrivById(Integer rprivId);

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/7/29
     * 方法介绍:    修改查看权限
     * 参数说明:    [diaryReadPriv]
     * 返回值说明:   com.xoa.util.ToJson<com.xoa.model.diary.setting.DiaryReadPriv>
     */
    int updateDiaryReadPriv(DiaryReadPriv diaryReadPriv);

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/7/29
     * 方法介绍:    查询全部查看权限、单条查看权限
     * 参数说明:    [map]
     * 返回值说明:   java.util.List<com.xoa.model.diary.setting.DiaryReadPriv>
     */
    List<DiaryReadPriv> selectAllDiaryReadPriv(Map<String, Object> map);

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/7/29
     * 方法介绍:    查询当前登录人的查看权限
     * 参数说明:    [userId]
     * 返回值说明:   com.xoa.model.diary.setting.DiaryReadPriv
     */
    DiaryReadPriv selectDiaryReadPriv(String userId);
}
