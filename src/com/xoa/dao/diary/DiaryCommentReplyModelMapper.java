package com.xoa.dao.diary;

import com.xoa.model.diary.DiaryCommentReplyModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017年7月5日 下午16:47:00
 * 类介绍  :    工作日志回复评论dao接口
 * 构造参数:   无
 *
 */
public interface DiaryCommentReplyModelMapper {
    int deleteByPrimaryKey(Integer replyId);

    int insert(DiaryCommentReplyModel record);

    int insertSelective(DiaryCommentReplyModel record);

    DiaryCommentReplyModel selectByPrimaryKey(Integer replyId);

    int updateByPrimaryKeySelective(DiaryCommentReplyModel record);

    int updateByPrimaryKeyWithBLOBs(DiaryCommentReplyModel record);

    int updateByPrimaryKey(DiaryCommentReplyModel record);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午16:50:05
     * 方法介绍:   添加工作日志评论回复
     * @return int 添加条数
     */
    public int insertCommentReply(DiaryCommentReplyModel diaryCommentReplyModel);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午18:17:00
     * 方法介绍:   根据评论id进行查询并根据回复时间进行排序
     * @return
     */
    public List<DiaryCommentReplyModel> getCommentReplyByCommentId(String commentId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午19:21:00
     * 方法介绍:   根据评论id删除评论回复
     * @return
     */
    public int delCommentReplyByCommentId(String commentId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午19:21:00
     * 方法介绍:   根据评论id删除评论回复
     * @return
     */
    public int delCommentReplyByReplyId(String replyId);

    int selectNumberOfReplies(Integer diaId);

    List<DiaryCommentReplyModel> getCommentReplyDiary(@Param("commIdsNotSelf")List<Integer> commIdsNotSelf,@Param("userId")String userId);
}