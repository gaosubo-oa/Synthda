package com.xoa.dao.email;

import com.xoa.dao.base.BaseMapper;
import com.xoa.model.email.Webmail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/12 14:33
 * 方法介绍:    外部邮箱基础信息
 * 参数说明:
 * @return
 */
public interface WebmailMapper extends BaseMapper<Webmail>{

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 16:28
     * 方法介绍:   删除外部邮件条数
     * 参数说明:
     * @return
     */
    public void deleteWebMail(@Param("mailId")Integer mailId);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 20:07
     * 方法介绍:   根据外部邮箱email_查询外部邮箱STMP/POP3的相关信息
     * 参数说明:
     * @return
     */
    public Webmail selectWebMail(@Param("email") String email);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 11:39
     * 方法介绍:   外部邮箱信息展示
     * 参数说明:  
     * @return
     */
    public List<Webmail> selectUserWebMail(@Param("userId")String userId);

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 15:55
     * 方法介绍:   单条外部邮件详细查询
     * 参数说明:
     * @return
     */
    public Webmail selectOneWebMail(@Param("userId")String userId,@Param("mailId")Integer mailId);

}