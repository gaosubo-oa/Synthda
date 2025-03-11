package com.xoa.service.worldnews.impl;

import com.xoa.dao.worldnews.NewsCommentMapper;
import com.xoa.model.users.Users;
import com.xoa.model.worldnews.NewsComment;
import com.xoa.service.users.UsersService;
import com.xoa.service.worldnews.NewsCommentService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/5 13:20
 * 类介绍  :
 * 构造参数:
 */
@Service
public class NewsCommentServiceImpl implements NewsCommentService {

    @Resource
    private NewsCommentMapper newsCommentMapper;
    @Resource
    private UsersService usersService;
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   添加新闻评论信息
     * 参数说明:   @param newsComment 需要保存的参数
     * 参数说明:   @return
     */
    @Override
    public void addNewsComment(HttpServletRequest request,NewsComment newsComment) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        newsComment.setUser_id(users.getUserId());
        //加上内容的判断不能为空（否则数据库保存失败）
        if(newsComment.getContent()==null){
            newsComment.setContent("");
        }
        newsCommentMapper.addNewsComment(newsComment);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-07-05 11:15
     * 方法介绍:   查询新闻评论信息（倒序）
     * 参数说明:   @param
     * 参数说明:   @return
     */
    @Override
    public List<NewsComment> getNewsCommentInfo(HttpServletRequest request,String news_id) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users name=SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        NewsComment newsComment1 = new NewsComment();
        if(name.getUserPriv()==1){
            newsComment1.setUser("ok");
        }else {
            newsComment1.setUser("err");
        }
        List<NewsComment> newsCommentInfo = newsCommentMapper.getNewsCommentInfo(news_id);
        for(NewsComment newsComment:newsCommentInfo){
            String user_id = newsComment.getUser_id();
             if(name.getUserId().equals(user_id)){
                 newsComment.setType("ok");
             }else {
                 newsComment.setType("err");
             }
             //判断是不是admin
            if(newsComment1.getUser()!=null){
                newsComment.setIfAdmin(newsComment1.getUser());
            }
                //查询回复数
                int count = newsCommentMapper.getCount(newsComment.getComment_id());
                newsComment.setCount(count);
               //查询user对应的真是姓名
            Users usersByuserId = usersService.getUsersByuserId(user_id);
            if(usersByuserId == null ){
                if (locale.equals("zh_CN")) {
                    newsComment.setUser_id("用户已删除!");
                } else if (locale.equals("en_US")) {
                    newsComment.setUser_id("The user has been deleted!");
                } else if (locale.equals("zh_TW")) {
                    newsComment.setUser_id("用戶已刪除!");
                }
            }else{
                newsComment.setUser_id(usersByuserId.getUserName());
            }

        }
        return  newsCommentInfo;
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 13:53
     * @函数介绍: 新闻获取当前用户名
     * @参数说明:
     * @return: Tojson
     * */
    @Override
    public ToJson<Users> getUser(HttpServletRequest request) {
        ToJson<Users> json =new ToJson<Users>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(users);

        } catch (Exception e) {
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(null);
            e.printStackTrace();
        }
        return json;
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 20:13
     * @函数介绍: 查询某条评论的回复数
     * @参数说明：COMMENT_ID 评论id
     * @return: int
     * */
    @Override
    public int getCount(String parent_id) {
       return newsCommentMapper.getCount(Integer.valueOf(parent_id));
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 10:13
     * @函数介绍: 删除某条评论及相关评论
     * @参数说明：COMMENT_ID 评论id
     * @return: void
     **/
    @Override
    public String deleteComment(String comment_id,HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users name=SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        NewsComment comment= newsCommentMapper.getNewsCommentById(Integer.parseInt(comment_id));
        if (name.getUserId().equals(comment.getUser_id())) {
            //调用递归删除
            deleteEachComment(comment_id);
            if (locale.equals("en_US")) {
                return "Success";
            } else if (locale.equals("zh_TW")) {
                return "成功";
            }
            return "成功";
        } else {
            if (locale.equals("en_US")) {
                return "You can't delete the content posted by others";
            } else if (locale.equals("zh_TW")) {
                return "您不能刪除別人發佈的東西";
            }
            return "您不能删除别人发布的东西";
        }


    }


    /**
     * @创建作者:  高亚峰
     * @创建日期: 2017/7/7 10:29
     * @函数介绍:  递归删除评论相关评论
     * @参数说明: @param comment_id 评论数
     * @return: XXType(value introduce)
     **/

    public void deleteEachComment(String comment_id) {
        //先删除选中的评论
        newsCommentMapper.deleteComment(Integer.valueOf(comment_id));
        //查询一下是否是相关的评论
        List<NewsComment> commentByparentId = newsCommentMapper.getCommentByparentId(Integer.valueOf(comment_id));
        //判断如果不为空则删除相关评论
        if (commentByparentId != null) {
            for (NewsComment newsComment : commentByparentId) {
                //判断一下遍历是否为空
                if (newsComment != null) {
                    //循环调用（把二级当作以及再去查看是否有相关评论）
                    deleteEachComment(String.valueOf(newsComment.getComment_id()));

                }
            }
        }

/*        if (commentByparentId != null) {

            deleteEachComment(commentByparentId);
            //如果不为空，则说明有相关评论 ，删除相关评论
            newsCommentMapper.deleteRelateComment(Integer.valueOf(comment_id));
        }*/

    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 12:13
     * @函数介绍: 查询某条新闻的评论数
     * @参数说明：news_id 新闻id
     * @return: json
     **/
    @Override
    public int getNewsCount(String news_id) {
        return newsCommentMapper.getNewsCount(Integer.valueOf(news_id));
    }
}
