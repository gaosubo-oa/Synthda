package com.xoa.dev.approveEmail.service;

import com.xoa.dev.approveEmail.model.EmailSet2;
import com.xoa.model.common.AppLog;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:46:51
 * 类介绍  :   邮件业务层
 * 构造参数:   
 *
 */
public interface ApproveEmailService {

	ToJson<EmailSet2> addEmailSet(HttpServletRequest request, EmailSet2 emailSet2);


	ToJson<EmailSet2> delEmailSetById(HttpServletRequest request, int essId);


	ToJson<EmailSet2> updateEmailSetById(HttpServletRequest request, EmailSet2 emailSet);

	ToJson<EmailSet2> selEmailSet(HttpServletRequest request);

	/**
	 * 反显，根据部门进行反显
	 * @param request
	 * @return
	 */
	public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request, int essId);

	/**
	 * 查询需要进行审批的邮件
	 * @return
	 */
	public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request);

	/**
	 * 审批邮件
	 * @return
	 */
	public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel, Integer flag, HttpServletRequest request);

	/**
	 * 查询需要进行审批的邮件(过滤词审核)
	 * @return
	 */
	public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request);

	public int saveAppLog4Email(AppLog appLog);

	public ToJson<EmailBodyModel> selectNewShowEmail(String flag, HttpServletRequest request, Map<String, Object> maps, Integer page,
                                                     Integer pageSize, boolean useFlag, String sqlType);



}
