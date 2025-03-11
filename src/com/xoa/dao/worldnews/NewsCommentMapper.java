package com.xoa.dao.worldnews;

import com.xoa.model.worldnews.NewsComment;

import java.util.List;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-05 11:15
 *    类介绍：       新闻评论
 *    构造参数：     无
 *
 */
public interface NewsCommentMapper {

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   添加新闻评论信息
     * 参数说明:   @param newsComment 需要保存的参数
     * 参数说明:   @return
     */
    public void addNewsComment(NewsComment newsComment);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   查询新闻评论信息（倒序）
     * 参数说明:   @param
     * 参数说明:   @return
     */
   public List<NewsComment> getNewsCommentInfo(String news_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 20:13
     * @函数介绍: 查询某条评论的回复数
     * @参数说明：COMMENT_ID 评论id
     * @return: int
     * */
    public int getCount(Integer parent_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 10:13
     * @函数介绍: 删除某条评论
     * @参数说明：COMMENT_ID 评论id
     * @return: void
     **/
    public void deleteComment(Integer comment_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 11:13
     * @函数介绍: 根据comment_id查询与它相关的评论
     * @参数说明：COMMENT_ID 评论id
     * @return: Tojson
     **/
    public List<NewsComment> getCommentByparentId(Integer comment_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 11:19
     * @函数介绍: 删除某条评论的相关评论
     * @参数说明：COMMENT_ID 评论id
     * @return: void
     **/
    public void deleteRelateComment(Integer comment_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 12:13
     * @函数介绍: 查询某条新闻的评论数
     * @参数说明：news_id 新闻id
     * @return: json
     **/
    public int getNewsCount(Integer news_id);

    public NewsComment getNewsCommentById(Integer comment_id);

}
