package com.xoa.dao.email;

import com.xoa.dao.base.BaseMapper;
import com.xoa.model.email.EmailModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:44:25
 * 类介绍  :   发件箱数据层
 * 构造参数:   
 *
 */
public interface EmailMapper extends BaseMapper<EmailModel>{
   
//   public int insert(Email email);

//   public int insertSelective(EmailModel record);
   /**
    * 
    * 创建作者:   张勇
    * 创建日期:   2017-4-20 上午10:45:18
    * 方法介绍:   未读点击转换为已读
    * 参数说明:   @param email
    * @return     void
    */
   public void updateIsRead(EmailModel email);

   /**
    * 创建作者:   张勇
    * 创建日期:   2017/5/15 16:28
    * 方法介绍:   建立外部邮件关联关系
    * 参数说明:
    * @return
    */
   public void updateEmailBox(EmailModel emailModel);


   List<EmailModel> selectUserReadFlag(Map<String,Object> param);

   List<EmailModel> selectUserReadFlag1(Map<String,Object> param);

   EmailModel queryByEmailOne(@Param("emailId") Integer emailId);

   /**
    * 作者: 张航宁
    * 日期: 2017/12/19
    * 说明: 根据bodyId查询
    */
   public List<EmailModel> selectByBodyId(Map<String,Object> map);

   /**
    * 作者: 张航宁
    * 日期: 2017/12/19
    * 说明: 更新撤回状态
    */
   public void updateEmailWithdraw(Map<String,Object> param);

   /**
    * 作者: 张航宁
    * 日期: 2017/12/19
    * 说明: 查询收件箱总数
    */
   public Integer selectEmailInboxOWCount();

   /**
    *根据当前人员查询邮件总数
    */
   public  Integer selectEmail();

   public Integer SendEmails(EmailModel emailModel);

    int updateDiu(Map<String,Object> map);
}