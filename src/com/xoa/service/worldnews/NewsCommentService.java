package com.xoa.service.worldnews;/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/5 13:19
 * 类介绍  :   新闻评论接口
 * 构造参数:
 */

import com.xoa.model.users.Users;
import com.xoa.model.worldnews.NewsComment;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-05 13:19
 *    类介绍：       无
 *    构造参数：     无
 *
 */
public interface NewsCommentService {
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   添加新闻评论信息
     * 参数说明:   @param newsComment 需要保存的参数
     * 参数说明:   @return
     */
    public void addNewsComment(HttpServletRequest request,NewsComment newsComment);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   查询新闻评论信息（倒序）
     * 参数说明:   @param
     * 参数说明:   @return
     */
    public List<NewsComment> getNewsCommentInfo(HttpServletRequest request,String news_id);


    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 13:53
     * @函数介绍: 新闻获取当前用户名
     * @参数说明:
     * @return: Tojson
     * */
    public ToJson<Users> getUser(HttpServletRequest request);

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 20:13
     * @函数介绍: 查询某条评论的回复数
     * @参数说明：COMMENT_ID 评论id
     * @return: int
     * */
    public int getCount(String parent_id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 10:13
     * @函数介绍: 删除某条评论及相关评论
     * @参数说明：COMMENT_ID 评论id
     * @return: void
     **/
    public String deleteComment(String comment_id,HttpServletRequest request);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 12:13
     * @函数介绍: 查询某条新闻的评论数
     * @参数说明：news_id 新闻id
     * @return: json
     **/
    public int getNewsCount(String news_id);
}
