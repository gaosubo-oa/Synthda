package com.xoa.service.email;

import com.xoa.model.common.AppLog;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailBoxModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:46:51
 * 类介绍  :   邮件业务层
 * 构造参数:   
 *
 */
public interface EmailService {

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:47:08
	 * 方法介绍:   创建邮件并发送
	 * 参数说明:   @param emailBody  邮件内容实体类
	 * 参数说明:   @param email 邮件状态实体类
	 * @return     void
	 */
	public ToJson<EmailBodyModel> sendEmail(EmailBodyModel emailBody, EmailModel email,String sqlType,String remind,HttpServletRequest request);
	public ToJson<EmailBodyModel> sendEmailCross(EmailBodyModel emailBody, EmailModel email,String sqlType,String remind,HttpServletRequest request,String senduserid);




	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:47:26
	 * 方法介绍:   草稿箱
	 * 参数说明:   @param emailBody 邮件内容实体类
	 * @return     void
	 */
	public ToJson<EmailBodyModel> saveEmail(EmailBodyModel emailBody);
	
	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:47:44
	 * 方法介绍:    未读转为已读
	 * 参数说明:   @param email  收件箱参数
	 * @return     void
	 */
	public void updateIsRead(EmailModel email);

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:48:04
	 * 方法介绍:   草稿箱
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	public ToJson<EmailBodyModel> selectEmail(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:48:31
	 * 方法介绍:   根据ID删除一条
	 * 参数说明:   @param bodyId 邮件Id
	 * @return     void
	 */
	public void deleteByID(Integer bodyId);

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:48:55
	 * 方法介绍:   根据ID查询一条邮件
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * @return     EmailBodyModel
	 */
	public EmailBodyModel queryById(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag,String sqlType);

	public EmailBodyModel queryByCountID(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag,String sqlType);
	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:49:30
	 * 方法介绍:   收件箱查询
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	ToJson<EmailBodyModel> selectInbox(HttpServletRequest request,Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:51:42
	 * 方法介绍:   草稿箱查询
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	ToJson<EmailBodyModel> listDrafts(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:52:01
	 * 方法介绍:   已发送查询
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	ToJson<EmailBodyModel> listSendEmail(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:52:30
	 * 方法介绍:   废纸篓查询
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	ToJson<EmailBodyModel> listWastePaperbasket(Map<String, Object> maps,
			Integer page, Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:52:59
	 * 方法介绍:   已发送查询
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * 作废
	 * @return     List<EmailBodyModel>
	 */
	public ToJson<EmailBodyModel> selectEmailBody(Map<String, Object> maps,
			Integer page, Integer pageSize, boolean useFlag,String sqlType) throws Exception;

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午10:53:42
	 * 方法介绍:   未读
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 结果集合
	 * 参数说明:   @throws Exception
	 * @return     List<EmailBodyModel>
	 */
	public ToJson<EmailBodyModel> selectIsRead(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag,String sqlType) throws Exception;
	
	/**
	 * 
	 * 创建作者:   郑山河
	 * 创建日期:   2017-4-21 上午11:16:38
	 * 方法介绍:   草稿箱删除邮件
	 * 参数说明:   @param emailBodyModel
	 * @return     void
	 */
	public String deleteDraftsEmail(Integer emailId);


	/**
	 *
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-21 上午11:16:38
	 * 方法介绍:   发件箱删除邮件
	 * 参数说明:   @param emailBodyModel
	 * @return     void
	 */
	public String deleteOutEmail(Integer emailId,String flag);
	
	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-21 上午11:16:38
	 * 方法介绍:   收件箱删除邮件
	 * 参数说明:   @param emailBodyModel
	 * @return     void
	 */
	public String deleteInEmail(Integer emailId,String flag);
	
	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-21 上午11:16:38
	 * 方法介绍:   废纸篓删除邮件
	 * 参数说明:   @param emailBodyModel
	 * @return     void
	 */
	public String deleteRecycleEmail(Integer emailId,String flag);

	public ToJson<EmailModel> deleteRecycleEmails(HttpServletRequest request);

	/**
	 *
	 * 创建作者:   张勇
	 * 创建日期:   2017-5-9 下午14:20:42
	 * 方法介绍:   回复或转发返回信息处理
	 * 参数说明:   @param maps 相关条件参数传值
	 * 参数说明:   @param page 当前页
	 * 参数说明:   @param pageSize 每页显示条数
	 * 参数说明:   @param useFlag 是否开启分页插件
	 * 参数说明:   @return 字符串
	 */
	public String queryByIdCss(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag,String sqlType,HttpServletRequest request );


	public String queryByIdCssCount(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag,String sqlType,HttpServletRequest request );



	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 15:18
	 * 方法介绍:
	 * 参数说明:   发件箱、收件箱内容信息保存
	 * 参数说明:   收件人实体类
	 * @return
	 */
	public ToJson<EmailBodyModel> draftsSendEmail(EmailBodyModel emailBody, EmailModel email,String sqlType,HttpServletRequest request);



	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 16:37
	 * 方法介绍:   新建其他邮件文件夹
	 * 参数说明:   
	 * @return     
	 */
	public ToJson<EmailBoxModel> saveEmailBox(EmailBoxModel emailBoxModel);


	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 16:38
	 * 方法介绍:   查询所有其他邮件文件夹
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailBoxModel> showEmailBox(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 16:39
	 * 方法介绍:   把收件箱邮件转移到其他邮件文件夹中
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailModel> updateEmailBox(EmailModel emailModel);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 16:48
	 * 方法介绍:   其他邮箱中的邮件列表
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailBodyModel> selectBoxEmail(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag,String sqlType);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 17:00
	 * 方法介绍:   删除其他邮件文件夹，并判断其中
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailBodyModel> deleteBoxEmail(Map<String,Object> maps,Integer page, Integer pageSize, boolean useFlag);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/19 10:19
	 * 方法介绍:   其他邮件名称和序号修改
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailBoxModel> updeateEmailBoxName(EmailBoxModel emailBoxModel);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/19 17:44
	 * 方法介绍:   收件箱未读查询
	 * 参数说明:
	 * @return
	 */
	public ToJson<EmailBodyModel> selectInboxIsRead(Map<String,Object> maps, Integer page, Integer pageSize, boolean useFlag,String sqlType);


	public ToJson<EmailBodyModel> selectInboxIsReadList(Map<String,Object> maps, Integer page, Integer pageSize, boolean useFlag,String sqlType);


	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/6/15 16:41
	 * 方法介绍:   新建外部邮箱关联
	 * 参数说明:
	 * @return
	 */
	public ToJson<Webmail> saveWebMail(Webmail webmail);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/6/15 16:42
	 * 方法介绍:   修改外部邮箱关联
	 * 参数说明:
	 * @return
	 */
	public  ToJson<Webmail> updateWebMail(Webmail webmail);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/6/15 16:43
	 * 方法介绍:   删除外部邮箱关联
	 * 参数说明:
	 * @return
	 */
	public ToJson<Webmail> deleteWebMail(Integer mailId);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/13 11:51
	 * 方法介绍:   根据用户user_id查询
	 * 参数说明:
	 * @return
	 */
	public ToJson<Webmail> selectUserWebMail(String userId);

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/13 15:56
	 * 方法介绍:   单条外部邮件详细查询
	 * 参数说明:
	 * @return
	 */
	public ToJson<Webmail> selectOneWebMail(String userId,Integer mailId);

	BaseWrappers getEmailReadDetail(Integer bodyId, String userIdsType,String json);

	//BaseWrappers getEmailReadDetail1(Integer bodyId, String userIds);

    ToJson<EmailBodyModel> selectCount(HttpServletRequest request,HttpServletResponse response , String sendTime, Integer toId , String export);

	ToJson<EmailBodyModel> selectListByMoths(HttpServletRequest request, String sendTime);

	ToJson<EmailBodyModel> selectDetailById(HttpServletRequest request, Integer bodyId);

	/**
	 * 作者: 张航宁
	 * 日期: 2017/12/19
	 * 说明: 邮件撤回
	 */
	public ToJson<EmailModel> updateEmailWithdraw(Integer bodyId);

	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2018年3月15日 下午17:32:22
	 * 方法介绍:   根据subject进行模糊查询内部邮件信息
	 * 参数说明:   @param subject
	 * 参数说明:
	 *
	 */
	ToJson<EmailBodyModel> queryEmailBySubject(String trim);


	ToJson<EmailSet> addEmailSet(HttpServletRequest request,EmailSet emailSet);


	ToJson<EmailSet> delEmailSetById(HttpServletRequest request,int essId);


	ToJson<EmailSet> updateEmailSetById(HttpServletRequest request,EmailSet emailSet);

	ToJson<EmailSet> selEmailSet(HttpServletRequest request);

	/**
	 * 反显，根据部门进行反显
	 * @param request
	 * @return
	 */
	public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request,int essId);

	/**
	 * 查询需要进行审批的邮件
	 * @return
	 */
	public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request);

	/**
	 * 审批邮件
	 * @return
	 */
	public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel,Integer flag,HttpServletRequest request);

	/**
	 * 查询需要进行审批的邮件(过滤词审核)
	 * @return
	 */
	public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request);

	public int saveAppLog4Email(AppLog appLog);

	public ToJson<EmailBodyModel> selectNewShowEmail(String flag,HttpServletRequest request,Map<String, Object> maps, Integer page,
					   Integer pageSize, boolean useFlag,String sqlType);


	/**
	 * 邮件分发
	 * @param emailBodyModel
	 * @param request
	 * @param response
	 * @param remind
	 * @param mId
	 * @param mName
	 * @return
	 */
	public ToJson SendEmails(EmailBodyModel emailBodyModel,HttpServletRequest request, HttpServletResponse response,String remind,String mId,String mName);

	public ToJson getEmailNames(HttpServletRequest request);

	public ToJson<EmailBodyModel> gdSelect(Map<String, Object> maps,HttpServletRequest request,String email, Integer page,
										   Integer pageSize, boolean useFlag,String tableName);

    ToJson<EmailBodyModel> upDateDiu(HttpServletRequest request, String toId,String bodyId);

	BaseWrapper judgeEmailSize(HttpServletRequest request);
}
