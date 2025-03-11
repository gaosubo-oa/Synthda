package com.xoa.dao.diary;

import com.xoa.model.diary.DiaryCommentModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 创建作者:   牛江丽
 创建日期:   2017年7月5日 下午15:08:35
 * 类介绍  :    工作日志评论dao接口
 * 构造参数:   无
 **
 */
public interface DiaryCommentModelMapper {
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午15:05:05
     * 方法介绍:   添加工作日志评论
     * @return int 添加条数
     */
    public int insertDiaryComment(DiaryCommentModel diaryCommentModel);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午15:58:05
     * 方法介绍:   获取所有工作日志评论
     * @return List
     */
    public List<DiaryCommentModel> getDiaryCommentByDiaId(Map<String, Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午19:21:00
     * 方法介绍:   根据评论id删除评论
     * @return
     */
    public int delDiaryCommentByCommentId(String commentId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月6日 下午9:56:00
     * 方法介绍:   根据日志id查询 评论的数量
     * @return int
     */
    public int getDiaryCommentCount(Integer diaId);

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/4/13
     * 方法介绍:    根据评论id 修改评论
     * 参数说明:    [diaryCommentModel]
     * 返回值说明:   int
     */
    int updateDiaryCommentByCommentId(DiaryCommentModel diaryCommentModel);

    DiaryCommentModel getDiaryCommentById(Integer commentId);

    List<DiaryCommentModel> getDiaryCommentByIdAndUserId(@Param("diaId") String diaId, @Param("userId") String userId);

    List<DiaryCommentModel> getComDiary(@Param("diaIds")List<Integer> diaIds);

    List<DiaryCommentModel> getIsComment(@Param("diaList")Set<Integer> diaList, @Param("userId")String userId);

    List<DiaryCommentModel> getComTotalList(@Param("diaList")Set<Integer> diaList);
}