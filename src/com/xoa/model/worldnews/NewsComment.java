package com.xoa.model.worldnews;

import java.util.Date;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/5 11:00
 * 类介绍  :    新闻评论
 * 构造参数:
 */
public class NewsComment {
    //新闻评论主键ID
    private Integer comment_id;
    //跟帖用的字段
    private Integer parent_id;
    //新闻ID
    private Integer news_id;
    //发表评论/回复的用户
    private String user_id;
    //昵称
    private String nick_name;
    //评论/回复内容
    private  String content;
    //评论时间
    private Date re_time;
    //回复数
    private int count;
    //原帖
    private NewsComment originalnewsComment;

    public NewsComment() {
    }

    public NewsComment(Integer comment_id, Integer parent_id, Integer news_id, String user_id, String nick_name, String content, Date re_time, int count, NewsComment originalnewsComment) {
        this.comment_id = comment_id;
        this.parent_id = parent_id;
        this.news_id = news_id;
        this.user_id = user_id;
        this.nick_name = nick_name;
        this.content = content;
        this.re_time = re_time;
        this.count = count;
        this.originalnewsComment = originalnewsComment;
    }

    public Integer getComment_id() {
        return comment_id;
    }

    public void setComment_id(Integer comment_id) {
        this.comment_id = comment_id;
    }

    public Integer getParent_id() {
        return parent_id;
    }

    public void setParent_id(Integer parent_id) {
        this.parent_id = parent_id;
    }

    public Integer getNews_id() {
        return news_id;
    }

    public void setNews_id(Integer news_id) {
        this.news_id = news_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getNick_name() {
        return nick_name;
    }

    public void setNick_name(String nick_name) {
        this.nick_name = nick_name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRe_time() {
        return re_time;
    }

    public void setRe_time(Date re_time) {
        this.re_time = re_time;
    }

    public NewsComment getOriginalnewsComment() {
        return originalnewsComment;
    }

    public void setOriginalnewsComment(NewsComment originalnewsComment) {
        this.originalnewsComment = originalnewsComment;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "NewsComment{" +
                "comment_id=" + comment_id +
                ", parent_id=" + parent_id +
                ", news_id=" + news_id +
                ", user_id='" + user_id + '\'' +
                ", nick_name='" + nick_name + '\'' +
                ", content='" + content + '\'' +
                ", re_time=" + re_time +
                ", count=" + count +
                ", originalnewsComment=" + originalnewsComment +
                '}';
    }

    private String type;
    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    private String user;
    public void setUser(String user) {
        this.user = user;
    }

    public String getUser() {
        return user;
    }

    private String ifAdmin;
    public void setIfAdmin(String ifAdmin) {
        this.ifAdmin = ifAdmin;
    }

    public String getIfAdmin() {
        return ifAdmin;
    }
}
