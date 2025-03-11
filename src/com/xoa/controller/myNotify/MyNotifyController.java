package com.xoa.controller.myNotify;

import com.xoa.dao.meet.MeetingMapper;
import com.xoa.dao.myNotify.MyNotifyMapper;
import com.xoa.dao.myNotify.MyNotifyOpinionMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.model.HSTmeeting.HstMeetingWithBLOBs;
import com.xoa.model.HSTmeeting.HstRoomWithBLOBs;
import com.xoa.model.common.AppLog;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.myNotify.MyNotify;
import com.xoa.model.myNotify.MyNotifyOpinionWithBLOBs;
import com.xoa.model.notify.NotifyAndMeeting;
import com.xoa.model.users.Users;
import com.xoa.service.ThreadSerivice.ThreadService;
import com.xoa.service.meeting.impl.MeetingServiceImpl;
import com.xoa.service.myNotify.MyNotifyOpinionService;
import com.xoa.service.myNotify.MyNotifyService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 *自定义公告模块
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/myNotice")
public class MyNotifyController {


	@Resource
	private MyNotifyService myNotifyService;

	@Resource
	private MyNotifyOpinionMapper myNotifyOpinionMapper;

	@Autowired
	private MyNotifyOpinionService notifyOpinionService;
	private String err = "err";
	private String ok = "ok";

	@Resource
	private SmsService smsService;
	@Resource
	private UsersService  usersService;

	@Autowired
	ThreadService threadService;

	@Resource
	MyNotifyMapper myNotifyMapper;
	@Resource
	private MeetingMapper meetingMapper;
	@Resource
	MeetingServiceImpl meetingServiceImpl;
	@Resource
	UserExtMapper userExtMapper;

	@Resource
	private SysLogService sysLogService;






	//普陀 通知管理
	@RequestMapping("/NoticeManagementPt")
	public String noticeManagementPt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/noticeManagementPt";
	}
	//通知管理
	@RequestMapping("/NotiManagement")
	public String notiManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/notiManagement";
	}
	//新建通知
	@RequestMapping("/newNotification")
	public String newNotification(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/newNotification";
	}
	//通知查询
	@RequestMapping("/notificationInquiry")
	public String notificationInquiry(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/notificationInquiry";
	}
	//通知统计
	@RequestMapping("/statisticalPt")
	public String statisticalPt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/statisticalPt";
	}
	//通知审批
	@RequestMapping("/noticeApprovePt")
	public String noticeApprovePt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		//消除事务提醒
		String notifyId=request.getParameter("notifyId");
		if(!StringUtils.checkNull(notifyId)){
			Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
			Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
			smsService.setSmsRead("1","/notice/noticeApprovePt?notifyId="+notifyId,users);
		}
		return "app/mynotice/allNoticePt/noticeApprovePt";
	}


	//个人事务 通知
//	@RequestMapping("/allNotificationsPt")
//	public String allNotificationsPt(HttpServletRequest request) {
//		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
//		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
//		ContextHolder.setConsumerType("xoa" + loginDateSouse);
//		return "app/notice/allNoticePt/allNotificationsPt";
//	}

	@RequestMapping("/allNotificationsPt")
	public String allNotificationsPt(){
		return "app/mynotice/allNoticePt/allNotificationsPt";
	}

	@RequestMapping("/unreadPt")
	public String unreadPt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/unreadPt";
	}
	@RequestMapping("/InformTheViewPt")
	public String InformTheViewPt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/InformTheViewPt";
	}
	@RequestMapping("/queryAllPt")
	public String queryAllPt(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNoticePt/queryAllPt";
	}


	/**
	 *
	 *
	 *
	 * 自定义公告模块映射
 	 * @param request
	 * @return
	 */


	@RequestMapping("/myNoticeApprove")//审批
	public String noticeApprove(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeApprove";
	}



	@RequestMapping("/myAllNotifications")//公告
	public String myAllNotifications(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/allNotifications";
	}


	@RequestMapping("/myInformTheView")//公告通知
	public String myInformTheView(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/InformTheView";
	}


	@RequestMapping("/myQueryAll")//公告查询
	public String myQueryAll(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/queryAll";
	}


	@RequestMapping("/myUnread")//未读公告
	public String myUnread(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/unread";
	}

	@RequestMapping("/myNoticeManagemen")//管理模块
	public String myNoticeManagemen(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/noticeManagement";
	}

	@RequestMapping("/myManagement")//公告管理
	public String myManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/management";
	}

	@RequestMapping("/myNewAndEdit")//新建公告
	public String myNewAndEdit(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/newAndEdit";
	}


	@RequestMapping("/myStatistical")//公告统计
	public String myStatistical(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/statistical";
	}

	@RequestMapping("/myTheQuery")//公告查询
	public String mytTheQuery(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/theQuery";
	}

	@RequestMapping("/myNotificAtiony")//公告设置
	public String mytNotificAtiony(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/notificAtion";
	}


	@RequestMapping("/index")
	public String clickNews(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/notice";
	}

	@RequestMapping("/manage")
	public String manage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManage";
	}

//	骆鹏添加

	@RequestMapping("/noticeManagement")
	public String noticeManagement(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/noticeManagement";
	}
	@RequestMapping("/management")
	public String management(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/management";
	}
	@RequestMapping("/newAndEdit")
	public String newAndEdit(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/newAndEdit";
	}
	@RequestMapping("/theQuery")
	public String theQuery(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/theQuery";
	}
	@RequestMapping("/statistical")
	public String statistical(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement/statistical";
	}

//	普陀教育公告通知管理

	@RequestMapping("/noticeManagement_PuTuo")
	public String noticeManagement_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement_PutTuo/noticeManagement_PuTuo";
	}
	@RequestMapping("/management_PuTuo")
	public String management_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement_PutTuo/management_PuTuo";
	}
	@RequestMapping("/newAndEdit_PuTuo")
	public String newAndEdit_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement_PutTuo/newAndEdit_PuTuo";
	}
	@RequestMapping("/theQuery_PuTuo")
	public String theQuery_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement_PutTuo/theQuery_PuTuo";
	}
	@RequestMapping("/statistical_PuTuo")
	public String statistical_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeManagement_PutTuo/statistical_PuTuo";
	}


	@RequestMapping("/allNotifications")
	public String allNotifications(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/allNotifications";
	}

	@RequestMapping("/unread")
	public String unread(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/unread";
	}
	@RequestMapping("/InformTheView")
	public String InformTheView(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/InformTheView";
	}
	@RequestMapping("/queryAll")
	public String queryAll(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications/queryAll";
	}

//普陀教育复制公告通知
	@RequestMapping("/allNotifications_PuTuo")
	public String allNotifications_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/notice/allNotifications_PuTuo/allNotifications_PuTuo";
	}

	@RequestMapping("/unread_PuTuo")
	public String unread_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications_PuTuo/unread_PuTuo";
	}
	@RequestMapping("/InformTheView_PuTuo")
	public String InformTheView_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications_PuTuo/InformTheView_PuTuo";
	}
	@RequestMapping("/queryAll_PuTuo")
	public String queryAll_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/allNotifications_PuTuo/queryAll_PuTuo";
	}


	//	领导指示精神
    //未读公告/通知公告/公告查询
	@RequestMapping("/leadtions")
	public String leadtions(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/lead/leadtions";
	}
	//	领导精神未读
	@RequestMapping("/leadread")
	public String leadread(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/lead/leadread";
	}
    //领导精神通知
	@RequestMapping("/leadView")
	public String leadView(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/lead/leadView";
	}
	//领导精神查询
	@RequestMapping("/leadAll")
	public String leadAll(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/lead/leadAll";
	}







	@RequestMapping(value={"detailOpin","detail"})
	public String details(HttpServletRequest request,String notifyId,String specifyTable) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

		String visitUrl= request.getRequestURI();
		visitUrl+="?notifyId="+notifyId;
		Integer smsId=smsService.getSmsId(request,visitUrl);

		if(smsId!=null){
			int RemidFlag= smsService.getRemidFlagById(smsId);
			if(RemidFlag!=0){
				smsService.setRead(request,visitUrl);
				AppLog appLog=new AppLog();
				Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
				Users sessionUser = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
				if (sessionUser != null && !StringUtils.checkNull(sessionUser.getUserId())) {
					appLog.setUserId(sessionUser.getUid()+"");
				}

				appLog.setTime(new Date());
				appLog.setModule("4");//模块4：公告通知
				appLog.setType("1"); //type 1 暂时存放1

				/**
				 * 标记标记
				 *
				 *
				 *
				 *
				 * 标记·
				 *
				 *
				 *
				 * 标记
				 *
				 *
				 *
				 */
				int smsid=smsService.getSmsId(request,visitUrl);

				appLog.setOppId(smsid+""); //操作记录的id,这里设置为SMS_ID
				appLog.setRemark("备注");
				myNotifyService.saveApplog4Notify(appLog,specifyTable);
			}else{
				AppLog appLog=new AppLog();
				Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
				Users sessionUser = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
				if (sessionUser != null && !StringUtils.checkNull(sessionUser.getUserId())) {
					appLog.setUserId(sessionUser.getUid()+"");
				}

				appLog.setTime(new Date());
				appLog.setModule("4");//模块4：公告通知
				appLog.setType("1"); //type 1 暂时存放1

				int smsid=smsService.getSmsId(request,visitUrl);

				appLog.setOppId(smsid+""); //操作记录的id,这里设置为SMS_ID
				appLog.setRemark("备注");
				myNotifyService.saveApplog4Notify(appLog,specifyTable);
			}
		}
		return "app/mynotice/noticeDerail";
	}
	@RequestMapping("/add")
	public String add(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/add";
	}

	@RequestMapping("/noticeQuery")
	public String noticeQuery(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/noticeQuery";
	}

	@RequestMapping("/notificAtion")
	public String notificAtion(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/notificAtion";
	}
	@RequestMapping("/finddetail")
	public String finddetail(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/find_detail";
	}
	@RequestMapping("/finddetailOpinion")
	public String finddetailOpinion(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/mynotice/opinion/opinionNotify";
	}
	@RequestMapping(" /appprove")
	public String appprove(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		//消除事务提醒
		String notifyId=request.getParameter("notifyId");
		if(!StringUtils.checkNull(notifyId)){
			Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
			Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
			smsService.setSmsRead("1","/notice/appprove?notifyId="+notifyId,users);
		}
		return "app/mynotice/noticeApprove";
	}
//普陀公告通知审批
	@RequestMapping("/appprove_PuTuo")
	public String appprove_PuTuo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		//消除事务提醒
		String notifyId=request.getParameter("notifyId");
		if(!StringUtils.checkNull(notifyId)){
			Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
			Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
			smsService.setSmsRead("1","/notice/appprove?notifyId="+notifyId,users);
		}
		return "app/mynotice/appprove_PuTuo";
	}
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:03:18
	 * 方法介绍:   公告通知
	 * 参数说明:   @param page   当前页面
	 * 参数说明:   @param pageSize  页面数
	 * 参数说明:   @param useFlag  是否启用分页插件
	 * 参数说明:   @return
	 * @return     String(true:seccess   false：fail)
	 */
	@ResponseBody
	@RequestMapping(value = "/notifyManage", produces = { "application/json;charset=UTF-8" })
	public ToJson<MyNotify> notifyManage(
			@RequestParam(value = "format", required = false) String format,
			@RequestParam(value = "typeId", required = false) String typeId,
			@RequestParam(value = "top", required = false) String top,
			@RequestParam(value = "publish", required = false) String publish,
			@RequestParam(value = "subject", required = false) String subject,
			@RequestParam(value = "lastEditTime", required = false) String lastEditTime,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "fromDept", required = false) String fromDept,
			@RequestParam(value = "sendTime", required = false) String sendTime,
			@RequestParam(value = "fromId", required = false) String fromId,
			@RequestParam(value = "fromIdName", required = false) String fromIdName,
			@RequestParam(value = "toId", required = false) String toId,
			@RequestParam(value ="beginDate", required = false) String beginDate,
			@RequestParam(value ="endDate", required = false) String endDate,
			@RequestParam(value = "read", required = false) String read,
			@RequestParam("page") Integer page,
			@RequestParam("pageSize") Integer pageSize,
			@RequestParam("useFlag") Boolean useFlag,HttpServletRequest request,String queryField,String specifyTable) throws ParseException {
		String sqlType = "xoa"+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		ContextHolder.setConsumerType(sqlType);
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		users=usersService.getUsersByuserId(users.getUserId());
		String userId=null;
		String userPriv=null;
		String deptId=null;
		if(users!=null&&users.getUserId()!=null){
			userId=users.getUserId();
			userPriv =users.getUserPriv()+"";
			deptId=users.getDeptId()+"";
		}
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("format", format);
		if("0".equals(typeId)){
			typeId=null;
		}else{
			maps.put("typeId", typeId);
		}
		if(!"".equals(fromId)&&fromId!=null){
			fromId=fromId.substring(0, fromId.length()-1);
		}
		Date dt=new Date();
		String data = DateFormatUtils.formatDate(dt);

		maps.put("top", top);
		maps.put("publish", publish);
		maps.put("subject", subject);
		maps.put("lastEditTime", lastEditTime);
		maps.put("content",content);
		maps.put("fromDept", fromDept);
		maps.put("sendTime", sendTime);
		maps.put("fromId", fromId);
		maps.put("fromIdName", fromIdName);
		maps.put("toId", toId);
		maps.put("beginDate", beginDate);
		maps.put("endDate", endDate);
		maps.put("userId", userId);
		maps.put("userPriv", userPriv);
		maps.put("deptId", deptId);
		maps.put("deptIdOther",users.getDeptIdOther()); //輔助部門
		maps.put("userPrivOther",users.getUserPrivOther()); //輔助角色
		maps.put("notifyTime", data);
		maps.put("queryField", queryField);
		maps.put("userType", userExtMapper.selUserExtByUserId(users.getUserId()).getEmploymentType());
		Users users1 = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		String name=users1.getUserId();

		ToJson<MyNotify> tojson = new ToJson<MyNotify>(0, "");
		/* myNotifyService.queryDeleteByStaleDated();*/
		try {
			switch (read){
				case "0":
					ToJson<MyNotify> tojson1 = myNotifyService.unreadNotify(maps, page, pageSize, useFlag,
							name,sqlType,specifyTable);
					if (tojson1.getObj().size() > 0) {
						tojson1.setFlag(0);
						tojson1.setMsg(ok);
						tojson=tojson1;
					} else {
						tojson1.setFlag(1);
						tojson1.setMsg(err);
						tojson=tojson1;
					}
					break;
				case "1":
					ToJson<MyNotify> tojson2 = myNotifyService.readNotify(maps, page, pageSize, useFlag,
							name,sqlType,specifyTable);
					if (tojson2.getObj().size() > 0) {
						tojson2.setFlag(0);
						tojson2.setMsg(ok);
						tojson=tojson2;
					} else {
						tojson2.setFlag(1);
						tojson2.setMsg(err);
						tojson=tojson2;
					}
					break;
				case "2":
					ToJson<MyNotify> toJson3 =myNotifyService.unreadNotify(maps, page, pageSize, useFlag,
							name,sqlType,specifyTable);
					if(toJson3.getObj()!=null&&toJson3.getObj().size()>0){//存在未读
						toJson3.setFlag(0);
						toJson3.setMsg(ok);
						toJson3.setCode("unread");
						tojson=toJson3;
					}else{//不存在未读
						ToJson<MyNotify>  list =myNotifyService.selectNotifyManage(maps, page, pageSize, useFlag,name,sqlType,specifyTable);
						list.setCode("read");
						list.setFlag(0);
						list.setMsg(ok);
						tojson=list;
					}
					break;
				default:
					ToJson<MyNotify>  list =myNotifyService.selectNotifyManage(maps, page, pageSize, useFlag,name,sqlType,specifyTable);
					if (list.getObj().size() > 0) {
						list.setFlag(0);
						list.setMsg(ok);
						tojson=list;
					} else {
						list.setFlag(1);
						list.setMsg(err);
						tojson=list;
					}
					break;
			}

		}catch (Exception e) {
			e.printStackTrace();
			L.e("notifyManage:" + e);
			err = "err";
			tojson.setFlag(1);
			tojson.setMsg(e.getMessage());
		}
		return tojson;
	}

	@ResponseBody
	@RequestMapping(value = "/notifyManagePlus", produces = { "application/json;charset=UTF-8" })
	public ToJson<MyNotify> notifyManagePlus(
			@RequestParam(value = "format", required = false) String format,
			@RequestParam(value = "typeId", required = false) String typeId,
			@RequestParam(value = "top", required = false) String top,
			@RequestParam(value = "publish", required = false) String publish,
			@RequestParam(value = "subject", required = false) String subject,
			@RequestParam(value = "lastEditTime", required = false) String lastEditTime,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "fromDept", required = false) String fromDept,
			@RequestParam(value = "sendTime", required = false) String sendTime,
			@RequestParam(value = "fromId", required = false) String fromId,
			@RequestParam(value = "toId", required = false) String toId,
			@RequestParam(value ="beginDate", required = false) String beginDate,
			@RequestParam(value ="endDate", required = false) String endDate,
			@RequestParam(value = "read", required = false) String read,
			@RequestParam("page") Integer page,
			@RequestParam("pageSize") Integer pageSize,
			@RequestParam("useFlag") Boolean useFlag,HttpServletRequest request,String queryField,String specifyTable) throws ParseException {
		String sqlType = "xoa"+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		ContextHolder.setConsumerType(sqlType);
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		users=usersService.getUsersByuserId(users.getUserId());
		String userId=null;
		String userPriv=null;
		String deptId=null;
		if(users!=null&&users.getUserId()!=null){
			userId=users.getUserId();
			userPriv =users.getUserPriv()+"";
			deptId=users.getDeptId()+"";
		}
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("format", format);
		if("0".equals(typeId)){
			typeId=null;
		}else{
			maps.put("typeId", typeId);
		}
		if(!"".equals(fromId)&&fromId!=null){
			fromId=fromId.substring(0, fromId.length()-1);
		}
		Date dt=new Date();
		String data = DateFormatUtils.formatDate(dt);

		maps.put("top", top);
		maps.put("publish", publish);
		maps.put("subject", subject);
		maps.put("lastEditTime", lastEditTime);
		maps.put("content",content);
		maps.put("fromDept", fromDept);
		maps.put("sendTime", sendTime);
		maps.put("fromId", fromId);
		maps.put("toId", toId);
		maps.put("beginDate", beginDate);
		maps.put("endDate", endDate);
		maps.put("userId", userId);
		maps.put("userPriv", userPriv);
		maps.put("deptId", deptId);
		maps.put("deptIdOther",users.getDeptIdOther()); //輔助部門
		maps.put("userPrivOther",users.getUserPrivOther()); //輔助角色
		maps.put("notifyTime", data);
		maps.put("queryField", queryField);
		maps.put("userType", userExtMapper.selUserExtByUserId(users.getUserId()).getEmploymentType());
		Users users1 = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		String name=users1.getUserId();

		ToJson<MyNotify> tojson = new ToJson<MyNotify>(0, "");
		/* myNotifyService.queryDeleteByStaleDated();*/
		try {
			switch (read){
				case "0":
					ToJson<MyNotify> tojson1 = myNotifyService.unreadNotify(maps, page, pageSize, useFlag,
							name,sqlType,specifyTable);
					if (tojson1.getObj().size() > 0) {
						tojson1.setFlag(0);
						tojson1.setMsg(ok);
						tojson=tojson1;
					} else {
						tojson1.setFlag(1);
						tojson1.setMsg(err);
						tojson=tojson1;
					}
					break;
				case "1":
					ToJson<MyNotify> tojson2 = myNotifyService.readNotifyPlus(maps, page, pageSize, useFlag, name,sqlType,specifyTable);
					if (tojson2.getObj().size() > 0) {
						tojson2.setFlag(0);
						tojson2.setMsg(ok);
						tojson=tojson2;
					} else {
						tojson2.setFlag(1);
						tojson2.setMsg(err);
						tojson=tojson2;
					}
					break;
				case "2":
					ToJson<MyNotify> toJson3 =myNotifyService.unreadNotify(maps, page, pageSize, useFlag,
							name,sqlType, specifyTable);
					if(toJson3.getObj()!=null&&toJson3.getObj().size()>0){//存在未读
						toJson3.setFlag(0);
						toJson3.setMsg(ok);
						toJson3.setCode("unread");
						tojson=toJson3;
					}else{//不存在未读
						ToJson<MyNotify>  list =myNotifyService.selectNotifyManage(maps, page, pageSize, useFlag,name,sqlType,specifyTable);
						list.setCode("read");
						list.setFlag(0);
						list.setMsg(ok);
						tojson=list;
					}
					break;
				default:
					ToJson<MyNotify>  list =myNotifyService.selectNotifyManage(maps, page, pageSize, useFlag,name,sqlType,specifyTable);
					if (list.getObj().size() > 0) {
						list.setFlag(0);
						list.setMsg(ok);
						tojson=list;
					} else {
						list.setFlag(1);
						list.setMsg(err);
						tojson=list;
					}
					break;
			}

		}catch (Exception e) {
			L.e("notifyManage:" + e);
			err = "err";
			tojson.setFlag(1);
		}
		return tojson;
	}
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:12:18
	 * 方法介绍:   公告通管理
	 * 参数说明:   @param typeId  公告类型
	 * 参数说明:   @param sendTime 发送时间
	 * 参数说明:   @param subject  公告标题
	 * 参数说明:   @param content  公告内容
	 * 参数说明:   @param format   公告格式
	 * 参数说明:   @param page     当前页面
	 * 参数说明:   @param pageSize  页面数
	 * 参数说明:   @param useFlag  是否启用分页插件
	 * 参数说明:   @return  Json
	 * @return     String(true:seccess  false：fail)
	 */
	@RequestMapping(value = "/notifyList",method = RequestMethod.GET)
	public @ResponseBody
	ToJson<MyNotify> notifyList(@RequestParam(value = "format", required = false) String format,
							  @RequestParam(value = "typeId", required = false) String typeId,
							  @RequestParam(value = "top", required = false) String top,
							  @RequestParam(value = "publish", required = false) String publish,
							  @RequestParam(value = "subject", required = false) String subject,
							  @RequestParam(value = "lastEditTime", required = false) String lastEditTime,
							  @RequestParam(value = "content", required = false) String content,
							  @RequestParam(value = "fromDept", required = false) String fromDept,
							  @RequestParam(value = "sendTime", required = false) String sendTime,
							  @RequestParam(value = "fromId", required = false) String fromId,
							  @RequestParam(value = "toId", required = false) String toId,
							  @RequestParam(value ="read", required = false) String read,
							  @RequestParam(value ="beginDate", required = false) String beginDate,
							  @RequestParam(value ="endDate", required = false) String endDate,
							  @RequestParam("page") Integer page,
							  @RequestParam("pageSize") Integer pageSize,
							  @RequestParam("useFlag") Boolean useFlag,
							  HttpServletRequest request, HttpServletResponse response,String exportId,String changeId,String specifyTable) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("format", format);
		if ("".equals(typeId) || "0".equals(typeId)) {
			typeId=null;
		}
		if(!"".equals(fromId)&&fromId!=null){
			//FIXME 也不动动脑子上来就截取，万一人家结尾突然不传递 逗号了 你不就查错数据了吗？？
			fromId=fromId.substring(0, fromId.length()-1);
		}
		maps.put("typeId", typeId);
		maps.put("top", top);
		if(!StringUtils.checkNull(publish)){
			if(publish.contains(",")){
				if(publish.length()>1){
					publish.substring(0,publish.length()-1);
				}else{
					publish="";
				}
			}
		}
		maps.put("publish", publish);
		maps.put("subject", subject);
		maps.put("lastEditTime", lastEditTime);
		maps.put("content",content);
		maps.put("fromDept", fromDept);
		maps.put("sendTime", sendTime);
		maps.put("fromId", fromId);
		maps.put("toId", toId);
		maps.put("beginDate", beginDate);
		maps.put("endDate", endDate);
		maps.put("changeId", changeId);
		ToJson<MyNotify> returnReslt = new ToJson<MyNotify>(0, "");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

		/*myNotifyService.queryDeleteByStaleDated();*/
		try{
			ToJson<MyNotify>  notifyToJson = myNotifyService.selectNotify(maps, page, pageSize, useFlag, users, specifyTable);
			if("1".equals(exportId)){
				returnReslt=notifyToJson;
			}else if("2".equals(exportId)){
				try {
					List<MyNotify> list=notifyToJson.getObj();
					HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("公告信息导出", 9);
					String[] secondTitles = {"发布人", "类型", "标题", "发布时间", "生效日期", "终止日期", "状态", "附件名称", "内容"};
					HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);

					// String[] beanProperty = {user.getDep().getDeptName(),"userName","userPrivName", "roleAuxiliaryName","online","sex","online","telNoDept","telNoDept","departmentPhone","email"};
					String[] beanProperty = {"name", "typeName", "subject", "notifyDateTime", "begin", "end", "publish", "attachmentName", "content"};

					HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
					ServletOutputStream out = response.getOutputStream();

					String filename = "公告信息导出.xls";
					filename = FileUtils.encodeDownloadFilename(filename,
							request.getHeader("user-agent"));
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("content-disposition",
							"attachment;filename=" + filename);
					workbook.write(out);
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

			}




		}catch(Exception e) {
			e.printStackTrace();
			L.e(e.getMessage());
		}
		return returnReslt;
	}




	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:12:18
	 * 方法介绍:   公告过期筛选
	 * 参数说明:   @param typeId  公告类型
	 * 参数说明:   @param sendTime 发送时间
	 * 参数说明:   @param subject  公告标题
	 * 参数说明:   @param content  公告内容
	 * 参数说明:   @param format   公告格式
	 * 参数说明:   @param page     当前页面
	 * 参数说明:   @param pageSize  页面数
	 * 参数说明:   @param useFlag  是否启用分页插件
	 * 参数说明:   @return  Json
	 * @return     String(true:seccess  false：fail)
	 */
	@RequestMapping(value = "/selectNotifyOverTime",method = RequestMethod.GET)
	public @ResponseBody
	ToJson<MyNotify> selectNotifyOverTime(
							  @RequestParam(value = "fromId", required = false) String fromId,
							  @RequestParam(value = "toId", required = false) String toId,
							  @RequestParam("page") Integer page,
							  @RequestParam("pageSize") Integer pageSize,
							  @RequestParam("useFlag") Boolean useFlag,
							  HttpServletRequest request, HttpServletResponse response,String specifyTable) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		Map<String, Object> maps = new HashMap<String, Object>();
		if(!"".equals(fromId)&&fromId!=null){
			//FIXME 也不动动脑子上来就截取，万一人家结尾突然不传递 逗号了 你不就查错数据了吗？？
			fromId=fromId.substring(0, fromId.length()-1);
		}

		maps.put("fromId", fromId);
		maps.put("toId", toId);

		ToJson<MyNotify> returnReslt = new ToJson<MyNotify>(0, "");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users name = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

		try{
			ToJson<MyNotify>  notifyToJson = myNotifyService.selectNotifyOverTime(maps, page, pageSize, useFlag,name.getUserPriv(), name.getUserId(),specifyTable);
			if(notifyToJson!=null){
				returnReslt=notifyToJson;
			}
		}catch(Exception e) {
			e.printStackTrace();
			L.e(e.getMessage());
		}
		return returnReslt;
	}

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:19:13
	 * 方法介绍:   公告查询详情
	 * 参数说明:   @param notifyId
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     String
	 */
	@RequestMapping(value = "/getOneById",method = RequestMethod.GET,produces = { "application/json;charset=UTF-8" })
	public @ResponseBody ToJson<MyNotify> getOneById(@RequestParam("notifyId") Integer notifyId,
												   Integer permissionId,
												   String changId,
												   HttpServletRequest request,
												   String type,String specifyTable){
		String sqlType = "xoa" + (String) request.getSession().getAttribute(
				"loginDateSouse");
		ContextHolder.setConsumerType(sqlType);
		String visitUrl= "/notice/detail";
		visitUrl+="?notifyId="+notifyId;
		Integer smsId=smsService.getSmsId(request,visitUrl);

		//if(smsId!=null){
//			int RemidFlag= smsService.getRemidFlagById(smsId);
//			if(RemidFlag!=0){
				smsService.setRead(request,visitUrl);
				AppLog appLog=new AppLog();
				Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
				Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
				if (users != null && !StringUtils.checkNull(users.getUserId())) {
					appLog.setUserId(users.getUid()+"");
				}
				appLog.setTime(new Date());
				appLog.setModule("4");//模块4：公告通知
				appLog.setType("1"); //type 1 暂时存放1
//				int smsid=smsService.getSmsId(request,visitUrl);

				appLog.setOppId(notifyId+""); //操作记录的id,这里设置为SMS_ID
				appLog.setRemark("备注");
				myNotifyService.saveApplog4Notify(appLog,specifyTable);

//			}
		//}






		Map<String, Object> maps = new HashMap<String, Object>();

		String userId=null;
		String userPriv=null;
		String deptId=null;
		String deptIdOther = null;
		String userPrivOther = null;
		if(users!=null&&users.getUserId()!=null){
			userId=users.getUserId();
			userPriv =users.getUserPriv()+"";
			deptId=users.getDeptId()+"";
			deptIdOther = users.getDeptIdOther();
			userPrivOther = users.getUserPrivOther();
		}
		maps.put("userId", userId);
		maps.put("userPriv", userPriv);
		maps.put("deptId", deptId);
		maps.put("notifyId", notifyId);
		maps.put("type",type);
		maps.put("deptIdOther",deptIdOther);
		maps.put("userPrivOther",userPrivOther);
		ToJson<MyNotify> toJson=new ToJson<MyNotify>(0, "");

		Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		String name=user.getUserId();
		//loger.debug("transfersID"+notifyId);
		try {
			MyNotify notify=myNotifyService.queryById(maps, 1, 20, false, name,sqlType,changId,specifyTable);
			MyNotifyOpinionWithBLOBs notifyOpinionWithBLOBs = notifyOpinionService.selectByNotiId(notify.getNotifyId(),user.getUserId(),sqlType,specifyTable);
			toJson.setMsg("success");
			toJson.setObject(notify);
			toJson.setObj1(notifyOpinionWithBLOBs);
			return toJson;
		} catch (Exception e) {
			e.printStackTrace();
			toJson.setMsg("err");
			//	loger.debug("ERROR:"+e);
			return toJson;
		}
	}

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:19:48
	 * 方法介绍:   修改公告信息
	 * 参数说明:   @param notifyId  主键(公告)
	 * 参数说明:   @param fromId   发布用户USER_ID
	 * 参数说明:   @param typeId  公告型
	 * 参数说明:   @param subject  公告标题
	 * 参数说明:   @param content  公告通知内容
	 * 参数说明:   @param format  公告通知格式(0-普通格式,1-mht格式,2-超链接)
	 * 参数说明:   @param fromDept 发布部门ID
	 * 参数说明:   @param sendTime  发送时间
	 * 参数说明:   @param beginDate  开始日期
	 * 参数说明:   @param endDate   结束日期
	 * 参数说明:   @param print  是否允许打印office附件(0-不允许,1-允许)
	 * 参数说明:   @param top  是否置顶(0-否,1-是)
	 * 参数说明:   @param topDays  置顶天数
	 * 参数说明:   @param publish   发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
	 * 参数说明:   @param auditer  审核人用户ID
	 * 参数说明:   @param auditDate  审核时间
	 * 参数说明:   @param download  是否允许下载office附件(0-不允许,1-允许)
	 * 参数说明:   @param lastEditor  最后编辑人
	 * 参数说明:   @param lastEditTime  最后编辑时间
	 * 参数说明:   @param subjectColor  公告标题颜色
	 * 参数说明:   @param keyword  内容关键字
	 * 参数说明:   @param isFw  是否转发
	 * 参数说明:   @param toId  按部门发布
	 * 参数说明:   @param attachmentId  附件ID串
	 * 参数说明:   @param attachmentName  附件名称串
	 * 参数说明:   @param readers  阅读人员用户ID串
	 * 参数说明:   @param privId  按角色发布
	 * 参数说明:   @param userId  用户id
	 * 参数说明:   @param reason  审核人不同意的原因
	 * 参数说明:   @param compressContent  压缩后的公告通知内容
	 * 参数说明:   @param summary  内容简介
	 * 参数说明:   @return
	 * @param notifyId
	 * @return     String
	 */

	@ResponseBody
	@RequestMapping(value = "/updateNotify", produces = { "application/json;charset=UTF-8" })
	public ToJson updateNotify(MyNotify notify, HttpServletRequest request,
							   @RequestParam("notifyId") Integer notifyId,String sendTimes,
							   @RequestParam(name = "lastEditTimes", required = false) String lastEditTimes,
							   @RequestParam(value = "beginDates", required = false) String beginDates,
							   @RequestParam(value = "endDates", required = false)  String endDates,
							   @RequestParam(value = "remind", required = false,defaultValue = "0") String remind,
							   @RequestParam(value = "approve", required = false,defaultValue = "0")String approve,String specifyTable){
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		notify.setNotifyId(notifyId);
		notify.setReaders("");
		String tuisong=request.getParameter("tuisong");
		if(!StringUtils.checkNull(sendTimes)){
			notify.setSendTime(DateFormat.getDate(sendTimes));
		}
		if(!StringUtils.checkNull(beginDates)){
			notify.setBeginDate(DateFormat.getDateTime(beginDates));
		}
		if(!StringUtils.checkNull(endDates)){
			notify.setEndDate(DateFormat.getDateTime(endDates));
		}
		if(!StringUtils.checkNull(lastEditTimes)){
			notify.setLastEditTime(DateFormat.getDate(lastEditTimes));

		}




		ToJson toJson =new ToJson();
		try {

			myNotifyService.updateNotify(notify,remind,tuisong,request,approve,specifyTable);
			toJson.setFlag(0);
			toJson.setMsg("ok");
			return toJson;
		} catch (Exception e) {
			e.printStackTrace();
			toJson.setFlag(1);
			toJson.setMsg("error");
			L.e("addNotify:" + e);
			return toJson;
		}
	}


	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:19:48
	 * 方法介绍:   修改公告信息
	 * 参数说明:   @param notifyId  主键(公告)
	 * 参数说明:   @param fromId   发布用户USER_ID
	 * 参数说明:   @param typeId  公告型
	 * 参数说明:   @param subject  公告标题
	 * 参数说明:   @param content  公告通知内容
	 * 参数说明:   @param format  公告通知格式(0-普通格式,1-mht格式,2-超链接)
	 * 参数说明:   @param fromDept 发布部门ID
	 * 参数说明:   @param sendTime  发送时间
	 * 参数说明:   @param beginDate  开始日期
	 * 参数说明:   @param endDate   结束日期
	 * 参数说明:   @param print  是否允许打印office附件(0-不允许,1-允许)
	 * 参数说明:   @param top  是否置顶(0-否,1-是)
	 * 参数说明:   @param topDays  置顶天数
	 * 参数说明:   @param publish   发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
	 * 参数说明:   @param auditer  审核人用户ID
	 * 参数说明:   @param auditDate  审核时间
	 * 参数说明:   @param download  是否允许下载office附件(0-不允许,1-允许)
	 * 参数说明:   @param lastEditor  最后编辑人
	 * 参数说明:   @param lastEditTime  最后编辑时间
	 * 参数说明:   @param subjectColor  公告标题颜色
	 * 参数说明:   @param keyword  内容关键字
	 * 参数说明:   @param isFw  是否转发
	 * 参数说明:   @param toId  按部门发布
	 * 参数说明:   @param attachmentId  附件ID串
	 * 参数说明:   @param attachmentName  附件名称串
	 * 参数说明:   @param readers  阅读人员用户ID串
	 * 参数说明:   @param privId  按角色发布
	 * 参数说明:   @param userId  用户id
	 * 参数说明:   @param reason  审核人不同意的原因
	 * 参数说明:   @param compressContent  压缩后的公告通知内容
	 * 参数说明:   @param summary  内容简介
	 * 参数说明:   @return
	 * @param notifyId
	 * @return     String
	 */

	@ResponseBody
	@RequestMapping(value = "/newUpdateNotify", produces = { "application/json;charset=UTF-8" })
	public ToJson newUpdateNotify(MyNotify notify, HttpServletRequest request,
								  @RequestParam("notifyId") Integer notifyId,String sendTimes,
								  @RequestParam(name = "lastEditTimes", required = false) String lastEditTimes,
								  @RequestParam(value = "beginDates", required = false) String beginDates,
								  @RequestParam(value = "endDates", required = false)  String endDates,
								  @RequestParam(value = "remind", required = false,defaultValue = "0") String remind,
								  @RequestParam(value = "approve", required = false,defaultValue = "0")String approve,String specifyTable){
		ContextHolder.setConsumerType("xoa"+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

		notify.setNotifyId(notifyId);
		notify.setReaders("");
		String tuisong=request.getParameter("tuisong");
		if (StringUtils.checkNull(sendTimes)){ // 开始时间为空设置当前时间
			try {
				sendTimes=DateFormatUtils.formatDate(new Date());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(!StringUtils.checkNull(sendTimes)){
			notify.setSendTime(DateFormat.getDate(sendTimes));
		}
		if(!StringUtils.checkNull(beginDates)){
			notify.setBeginDate(DateFormat.getDateTime(beginDates));
		}
		if(!StringUtils.checkNull(endDates)){
			notify.setEndDate(DateFormat.getDateTime(endDates));
		}
		if(!StringUtils.checkNull(lastEditTimes)){
			notify.setLastEditTime(DateFormat.getDate(lastEditTimes));
		}

		ToJson toJson =new ToJson();
		try {

			myNotifyService.upNewdateNotify(notify,remind,tuisong,request,approve,specifyTable);

			//添加日志
			Syslog syslog = new Syslog();
			syslog.setUserId(user.getUserId());
			syslog.setType(15); //sys_code
			syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",提交");
			sysLogService.saveLog(syslog,request);

			toJson.setFlag(0);
			toJson.setMsg("ok");
			return toJson;
		} catch (Exception e) {
			e.printStackTrace();
			toJson.setFlag(1);
			toJson.setMsg("error");
			L.e("addNotify:" + e);
			return toJson;
		}
	}


	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:20:09
	 * 方法介绍:   保存公告信息
	 * 参数说明:   @param fromId   发布用户USER_ID
	 * 参数说明:   @param typeId  公告型
	 * 参数说明:   @param subject  公告标题
	 * 参数说明:   @param content  公告通知内容
	 * 参数说明:   @param format  公告通知格式(0-普通格式,1-mht格式,2-超链接)
	 * 参数说明:   @param fromDept 发布部门ID
	 * 参数说明:   @param sendTime  发送时间
	 * 参数说明:   @param beginDate  开始日期
	 * 参数说明:   @param endDate   结束日期
	 * 参数说明:   @param print  是否允许打印office附件(0-不允许,1-允许)
	 * 参数说明:   @param top  是否置顶(0-否,1-是)
	 * 参数说明:   @param topDays  置顶天数
	 * 参数说明:   @param publish   发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
	 * 参数说明:   @param auditer  审核人用户ID
	 * 参数说明:   @param auditDate  审核时间
	 * 参数说明:   @param download  是否允许下载office附件(0-不允许,1-允许)
	 * 参数说明:   @param lastEditor  最后编辑人
	 * 参数说明:   @param lastEditTime  最后编辑时间
	 * 参数说明:   @param subjectColor  公告标题颜色
	 * 参数说明:   @param keyword  内容关键字
	 * 参数说明:   @param isFw  是否转发
	 * 参数说明:   @param toId  按部门发布
	 * 参数说明:   @param attachmentId  附件ID串
	 * 参数说明:   @param attachmentName  附件名称串
	 * 参数说明:   @param readers  阅读人员用户ID串
	 * 参数说明:   @param privId  按角色发布
	 * 参数说明:   @param userId  用户id
	 * 参数说明:   @param reason  审核人不同意的原因
	 * 参数说明:   @param compressContent  压缩后的公告通知内容
	 * 参数说明:   @param summary  内容简介
	 * 参数说明:   @return
	 * @return     String
	 */

	@RequestMapping(value = "/addNotify", method = RequestMethod.POST, produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	ToJson<MyNotify> addNotify(MyNotify notify,String sendTimes,HttpServletRequest request, String beginDates, String endDates,
							 @RequestParam(value = "remind", required = false,defaultValue ="0") String remind,
							 @RequestParam(value = "approveRemind", required = false,defaultValue ="0") String approveRemind,String specifyTable) {
		String tuisong=request.getParameter("tuisong");
		ToJson<MyNotify> toJson = new ToJson<MyNotify>(0,"");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users name = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		notify.setFromId(name.getUserId());
		if (StringUtils.checkNull(sendTimes)){ // 开始时间为空设置当前时间
			try {
				sendTimes=DateFormatUtils.formatDate(new Date());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(!StringUtils.checkNull(beginDates)){
			notify.setBeginDate(DateFormat.getDateTime(beginDates));
		}else{
			notify.setBeginDate(DateFormat.getDateTime(DateFormat.getDatestr(new Date())));

		}
		if(!StringUtils.checkNull(endDates)){
			notify.setEndDate(DateFormat.getDateTime(endDates));
		}
		notify.setFromDept(name.getDeptId());
		notify.setSendTime(DateFormat.getDate(sendTimes));
		Date  curDate=new Date(System.currentTimeMillis());
		notify.setLastEditTime(curDate);
		if(StringUtils.checkNull(notify.getSubject())){
			notify.setSubject("[无主题]");
		}
		try {
			notify.setOpinUsers("");
			int b=	myNotifyService.addNotify(notify,remind,tuisong,request,approveRemind,specifyTable);
			if(b>0){
				toJson.setFlag(0);
				toJson.setMsg("success");
			}else{
				toJson.setFlag(1);
				toJson.setMsg("err");
			}
		} catch (Exception e) {
			L.e("addNotify:" + e);
			e.printStackTrace();
		}
		return toJson;
	}

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:20:30
	 * 方法介绍:   根据ID删除公告
	 * 参数说明:   @param notifyId
	 * 参数说明:   @return
	 * @return     String
	 */
	@RequestMapping(value = "/deleteById", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody ToJson<MyNotify> deleteById(@RequestParam("notifyId") Integer notifyId,HttpServletRequest request,String specifyTable) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<MyNotify> toJson = new ToJson<MyNotify>(0,"");
		//loger.debug("transfersID"+notifyId);
		try{
			myNotifyService.delete(notifyId,specifyTable);

			//添加日志
			Syslog syslog = new Syslog();
			syslog.setUserId(user.getUserId());
			syslog.setType(15); //sys_code
			syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",删除");
			sysLogService.saveLog(syslog,request);

			toJson.setMsg("ok");
			return toJson;
		}catch(Exception e){
			toJson.setMsg("err");
			return toJson;
		}
	}

	@RequestMapping( "/deleteByIds")
	public @ResponseBody ToJson<MyNotify> deleteByIds(HttpServletRequest request,@RequestParam("notifyIds[]") String[] notifyIds,String specifyTable){
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

		//添加日志
		Syslog syslog = new Syslog();
		syslog.setUserId(user.getUserId());
		syslog.setType(15); //sys_code
		syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",批量删除");
		sysLogService.saveLog(syslog,request);

		return  myNotifyService.deleteByids(notifyIds,specifyTable);

	}
	@RequestMapping( "/updateByIds")
	public @ResponseBody ToJson<MyNotify> updateByIds(@RequestParam("notifyIds[]") String[] notifyIds,String top,String specifyTable){

		return  myNotifyService.updateByids(notifyIds,top,specifyTable);
	}

	@RequestMapping( "/querySituation")
	public @ResponseBody ToJson<MyNotify> querySituation(String notifyId,HttpServletRequest request,String specifyTable){

		return  myNotifyService.ConsultTheSituationNotify(notifyId,request,specifyTable);
	}


	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午8:52:53
	 * 方法介绍:   为null时转换为""
	 * 参数说明:   @param value
	 * 参数说明:   @return
	 * @return     String
	 */
	public static String returnValue(String value) {
		if (value != null) {
			return value;
		} else {
			return "";
		}
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:40:00
	 * 方法介绍:   查询出发布公告的所有部门
	 * 参数说明:   @param notify
	 * @return     Department
	 */
	@ResponseBody
	@RequestMapping(value = "/getNotifyGroupFromDept")
	public ToJson<Department> getNotifyGroupFromDept(MyNotify notify,String specifyTable){
		return myNotifyService.getNotifyGroupFromDept(notify,specifyTable);
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:48:00
	 * 方法介绍:   根据发布公告的部门查询出该部门中发布公告的用户
	 * 参数说明:   @param notify
	 * @return    Notify
	 */
	@ResponseBody
	@RequestMapping(value = "/getNotifyByFromDept")
	public ToJson<MyNotify> getNotifyByFromDept(MyNotify notify,String specifyTable){
		return myNotifyService.getNotifyByFromDept(notify,specifyTable);
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据发布公告的部门和发布公告的用户查询出所发布的公告
	 * 参数说明:   @param notify
	 * @return    Notify
	 */
	@ResponseBody
	@RequestMapping(value = "/getNotifyByFromIdAndDept")
	public ToJson<MyNotify> getNotifyByFromIdAndDept(MyNotify notify,String specifyTable){
		return myNotifyService.getNotifyByFromIdAndDept(notify,specifyTable);
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据公告id进行查询公告
	 * 参数说明:   @param notifyId
	 * @return    Notify
	 */
	@ResponseBody
	@RequestMapping(value = "/getNotifyByNotifyId")
	public ToJson<MyNotify> getNotifyByNotifyId(Integer notifyId,String specifyTable){
		return myNotifyService.getNotifyByNotifyId(notifyId,specifyTable);
	}
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月12日 下午11:18:00
	 * 方法介绍:   公告统计信息导出
	 */
	@ResponseBody
	@RequestMapping(value = "/outputNotify")
	public  ToJson<MyNotify> outputNotify(int step,MyNotify notify, HttpServletRequest request, HttpServletResponse response,String specifyTable){
		return myNotifyService.outputNotify(step,notify,request,response,specifyTable);
	}

	@RequestMapping("/subjectDetail")
	public String subjectDetail(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/notice/subjectDetail";
	}

	/**
	 * 创建者: 杨超
	 * 创建日期：2017/08/15
	 * 方法介绍: 按类型统计通知数量
	 */
	@ResponseBody
	@RequestMapping("/selectByType")
	public BaseWrapper selectByType(String specifyTable){
		return myNotifyService.selectByType(specifyTable);
	}

	//H5微应用
	//公告通知列表
	@RequestMapping("/noticeh5")
	public String noticeh5() {
		return "/app/notice/m/noticeh5";
	}
	//公告通知详情
	@RequestMapping("/noticeDetailsh5")
	public String noticeDetailsh5() {
		return "/app/notice/m/noticeDetailsh5";
	}
	/**
	 * 创建者: 高亚峰
	 * 创建日期：2017/06/04
	 * 方法介绍: 立即生效/终止
	 */
	@ResponseBody
	@RequestMapping("/updateTopstatus")
	public ToJson updateTopstatus(MyNotify notify,HttpServletRequest request,String specifyTable){
		return myNotifyService.updateTopstatus(notify,request,specifyTable);
	}

	/**
	 * 创建者: 张丽军
	 * 创建日期：2019/02/11
	 * 方法介绍: 解决升级问题
	 */
	@ResponseBody
	@RequestMapping("/updateDate")
	//解决升级问题（部分数据会出现不支持HTML格式，后台统一处理一下数据格式）
	public ToJson<MyNotify> updateDate(HttpServletRequest request,String specifyTable){
		return myNotifyService.updateDate(request,specifyTable);
	}

	/**
	 * 方法介绍: 增加公告反馈内容
	 */
	@ResponseBody
	@RequestMapping("/addOpinion")
	public ToJson addOpinion(HttpServletRequest request, MyNotifyOpinionWithBLOBs notifyOpinion,String specifyTable){
		Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
		notifyOpinion.setUserId(user.getUserId());
		return notifyOpinionService.addOpinion(notifyOpinion,specifyTable);
	}

	/**
	 * 方法介绍: 修改反馈内容
	 */
	@ResponseBody
	@RequestMapping("/updateOpin")
	public ToJson updateOpin(HttpServletRequest request, MyNotifyOpinionWithBLOBs notifyOpinion,String specifyTable){
		ToJson toJson = new ToJson(1,"err");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
		notifyOpinion.setUserId(user.getUserId());
		int i = notifyOpinionService.updateOpinion(notifyOpinion,specifyTable);
		if(i>0){
			toJson.setMsg("true");
			toJson.setFlag(0);
		}
		return toJson;
	}

	/**
	 * 方法介绍: 反馈退回
	 */
	@ResponseBody
	@RequestMapping("/returnOpinion")
	public ToJson returnOpinion(HttpServletRequest request, int notifyId ,String userId,String specifyTable){
		ToJson toJson = new ToJson(1,"err");
		int i = notifyOpinionService.returnOpinion(notifyId,userId,specifyTable);
		if(i>0){
			toJson.setMsg("true");
			toJson.setFlag(0);
		}
		return toJson;
	}

	/**
	 * 方法介绍: 催办未填报用户
	 */
	@ResponseBody
	@RequestMapping("/urgeOpin")
	public ToJson urgeOpin(HttpServletRequest request, int notifyId,String userIds,String specifyTable){
		ToJson toJson = new ToJson(0,"true");
		toJson = notifyOpinionService.urgeOpin(request,notifyId,userIds,specifyTable);
		return toJson;
	}

	/**
	 * 方法介绍: 反馈导出
	 */
	@ResponseBody
	@RequestMapping("/outputNotifyOpin")
	public ToJson outputNotifyOpin(HttpServletRequest request,HttpServletResponse response , int  notifyId,String specifyTable){
		return notifyOpinionService.outputNotifyOpins(request,response,notifyId,specifyTable);
	}

	/**
	 * 方法介绍: 批量下载附件
	 */
	@ResponseBody
	@RequestMapping("/downLoadZipAttachment")
	public ToJson downLoadZipAttachment(HttpServletRequest request,HttpServletResponse response , int  notifyId,String specifyTable) throws UnsupportedEncodingException {
		return notifyOpinionService.downLoadZipAttachment(request,response,notifyId,specifyTable);
	}

	/**
	 * 方法介绍: 反馈情况
	 */
	@ResponseBody
	@RequestMapping("/finddetailOpin")
	public ToJson<MyNotifyOpinionWithBLOBs> finddetailOpin(HttpServletRequest request,HttpServletResponse response, @RequestParam("notyId") Integer notyId,boolean isOut,String specifyTable){
		ToJson toJson = new ToJson(1,"err");
		try {
			/**
			 * 根据前端传入的参数获得要操作的模块表名
			 */
			MyNotifyConfig myNotifyConfig = new MyNotifyConfig();
			ToJson notifyType = myNotifyConfig.getNotifyType(specifyTable);
			Map data = (Map) notifyType.getData();
			String tableName = (String) data.get("mynotice_table");//模块表名

			MyNotify notify = myNotifyMapper.getNotifyByNotifyId(notyId,tableName);
			List<MyNotifyOpinionWithBLOBs> list = myNotifyOpinionMapper.selectByNotyIdList(notyId);
			Map map = new HashMap();
			List<MyNotifyOpinionWithBLOBs> notiIdList = notifyOpinionService.selectByNotiIdList(request,notyId,specifyTable);
			int yfk = 0;
			if(notify.getOpinUsers()!= null && !"".equals(notify.getOpinUsers().trim())){
				yfk = notify.getOpinUsers().split(",").length;
			}
			map.put("yiHuiZhi",yfk);
			map.put("huiZhiTuiHui",(list.size()-yfk));
			map.put("weiHuiZhi",(notiIdList.size()-list.size()));
			map.put("quanBuRenYuan",(notiIdList.size()));

			if(isOut){
				List<Map<String,Object>> notiIdListMap = new ArrayList<>();

				List<String> secondTitlesone = new ArrayList<>();
				secondTitlesone.add("状态");
				secondTitlesone.add("发布人");
				secondTitlesone.add("发布任务时间");
				secondTitlesone.add("填报人");
				secondTitlesone.add("填报部门");

				List<String> beanPropertyone = new ArrayList<>();
				beanPropertyone.add("stateStr");
				beanPropertyone.add("fromName");
				beanPropertyone.add("endTimeStr");
				beanPropertyone.add("userName");
				beanPropertyone.add("deptName");

				AtomicBoolean is= new AtomicBoolean(true);
				notiIdList.forEach(item -> {
					Map map1 = new HashMap();
					map1.put("stateStr", !StringUtils.checkNull(item.getStateStr()) ? item.getStateStr() :""  );
					map1.put("fromName",  !StringUtils.checkNull(item.getFromName()) ? item.getFromName() :"");
					map1.put("endTimeStr", !StringUtils.checkNull(item.getEndTimeStr()) ? item.getEndTimeStr() :"");
					map1.put("userName", !StringUtils.checkNull(item.getUserName()) ? item.getUserName() :"" );
					map1.put("deptName", !StringUtils.checkNull(item.getDeptName()) ? item.getDeptName() :"");

					Map<String, Object> mapTo2 = item.getMapTo2();
					if (mapTo2!=null){
						mapTo2.forEach((k,v) -> {
							if (is.get()){
								secondTitlesone.add(k);
								beanPropertyone.add(k);
							}
							map1.put(k,v);
						});
						is.set(false);
					}

					map1.put("inputTimeStr", !StringUtils.checkNull(item.getInputTimeStr()) ? item.getInputTimeStr() :"");
					map1.put("updateTimeStr", !StringUtils.checkNull(item.getUpdateTimeStr()) ? item.getUpdateTimeStr() :"");
					map1.put("attachmentName", !StringUtils.checkNull(item.getAttachmentName()) ? item.getAttachmentName() :"");
					notiIdListMap.add(map1);

				});

				secondTitlesone.add("填报时间");
				secondTitlesone.add("修改时间");
				secondTitlesone.add("附件名称");

				beanPropertyone.add("inputTimeStr");
				beanPropertyone.add("updateTimeStr");
				beanPropertyone.add("attachmentName");

				HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("公告回执信息导出", 10 );
				HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitlesone.toArray(new String[secondTitlesone.size()]));
				HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, notiIdListMap, beanPropertyone.toArray(new String[beanPropertyone.size()]));
				ServletOutputStream out = response.getOutputStream();
				String filename = "公告回执信息导出.xls";
				filename = FileUtils.encodeDownloadFilename(filename,request.getHeader("user-agent"));
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("content-disposition","attachment;filename=" + filename);
				workbook.write(out);
				out.close();
			}

			toJson.setObj(notiIdList);
			toJson.setObj1(map);
			toJson.setMsg("true");
			toJson.setFlag(0);
		}catch (Exception e){
			e.printStackTrace();
			toJson.setMsg(e.getMessage());
		}
		return toJson;
	}

    //将公告和会议的未读数据按照时间顺序取前十五条
    @ResponseBody
    @RequestMapping("/findNotifyandMeeting")
    public ToJson findNotifyandMeeting(HttpServletRequest request,String specifyTable) {
        List<NotifyAndMeeting> list = new ArrayList();
        ToJson toJson = new ToJson(1, "err");
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        users = usersService.getUsersByuserId(users.getUserId());
        String userId = null;
        String userPriv = null;
        String deptId = null;
        if (users != null && users.getUserId() != null) {
            userId = users.getUserId();
            userPriv = users.getUserPriv() + "";
            deptId = users.getDeptId() + "";
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        Date dt = new Date();
        String data = null;
        try {
            data = DateFormatUtils.formatDate(dt);
            maps.put("userId", userId);
            maps.put("userPriv", userPriv);
            maps.put("deptId", deptId);
            maps.put("deptIdOther", users.getDeptIdOther()); //輔助部門
            maps.put("userPrivOther", users.getUserPrivOther()); //輔助角色
            maps.put("notifyTime", data);
            maps.put("userType", userExtMapper.selUserExtByUserId(users.getUserId()).getEmploymentType());
            List<MyNotify> obj = myNotifyService.unreadNotifyPlus(maps, 1, 20, true,
                    users.getUserId(), sqlType,specifyTable).getObj();
            if (obj.size() > 0) {
				for (MyNotify notify : obj
				) {
					if (!StringUtils.checkNull(notify.getTypeId())) {
						NotifyAndMeeting notifyAndMeeting = new NotifyAndMeeting();
						notifyAndMeeting.setSendTime(notify.getSendTime());
						notifyAndMeeting.setUrl("/notice/detail?notifyId=" + notify.getNotifyId());
						notifyAndMeeting.setSubject(notify.getSubject());
						notifyAndMeeting.setModelType(1);
						list.add(notifyAndMeeting);
					}

				}

			}
        } catch (Exception e) {
            e.printStackTrace();
        }
		try{//公告判断置顶并取消置顶时间已过的
			myNotifyService.updateTop(specifyTable);
		}catch (Exception e){

		}
        try {
            PageParams pageParams = new PageParams();
            pageParams.setPage(1);
            pageParams.setPageSize(20);
            pageParams.setUseFlag(true);
            MeetingWithBLOBs meetingWithBLOBs = new MeetingWithBLOBs();
            meetingWithBLOBs.setUid(users.getUid());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("meetingWithBLOBs", meetingWithBLOBs);
			try{
				meetingServiceImpl.meetingStatus();// 对已经结束会议修改状态
			}catch (Exception e){
				e.printStackTrace();
			}
			//获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long currentTime = Long.valueOf(DateFormat.getTime(sdf.format(date)));
            List<MeetingWithBLOBs> meetingList = meetingMapper.getMeetingNotify(map);
            for (MeetingWithBLOBs meetingWithBLOBs1 : meetingList) {
                //判断该会议是否在进行中
                Long startDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getStartTime()));
                Long endDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getEndTime()));
                if ((3 == meetingWithBLOBs1.getStatus()) || (2 == meetingWithBLOBs1.getStatus() && currentTime >= startDate && currentTime <= endDate) || (2 == meetingWithBLOBs1.getStatus())) {
                    NotifyAndMeeting notifyAndMeeting = new NotifyAndMeeting();
                    notifyAndMeeting.setSubject("[会议] " + meetingWithBLOBs1.getSubject());
                    notifyAndMeeting.setSendTime(sdf.parse(meetingWithBLOBs1.getCreateTime()));
                    notifyAndMeeting.setUrl("/meeting/detail?meetingId=" + meetingWithBLOBs1.getSid());
					notifyAndMeeting.setModelType(2);
                    list.add(notifyAndMeeting);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (list.size() > 1) {//根据时间排序
            //list 集合倒叙排序
            list.sort((a1, a2) -> {
                try {
                    return sdf.parse(sdf.format(a2.getSendTime())).compareTo(sdf.parse(sdf.format(a1.getSendTime())));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                return 1;
            });
        }
        List<NotifyAndMeeting> showList = new ArrayList();
        for (int i = 0; i < list.size(); i++) {
            showList.add(list.get(i));
            if (i == 15) {
                break;
            }
        }
        toJson.setObj(showList);
        toJson.setFlag(0);
        toJson.setMsg("ok");
        return toJson;
    }

	/**
	 * 只是单纯的更新公告
	 * @param notify
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateNotifys", produces = { "application/json;charset=UTF-8" })
	public ToJson newUpdateNotify(MyNotify notify, HttpServletRequest request, String sendTimes, String beginDates, String endDates,String specifyTable){
		ToJson toJson =new ToJson();
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
		try {
			if (StringUtils.checkNull(sendTimes)){ // 开始时间为空设置当前时间
				try {
					sendTimes=DateFormatUtils.formatDate(new Date());
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			notify.setSendTime(DateFormat.getDate(sendTimes));
			if(!StringUtils.checkNull(beginDates)){
				notify.setBeginDate(DateFormat.getDateTime(beginDates));
			}else{
				notify.setBeginDate(DateFormat.getDateTime(DateFormat.getDatestr(new Date())));
			}
			if(!StringUtils.checkNull(endDates)){
				notify.setEndDate(DateFormat.getDateTime(endDates));
			}
			MyNotifyConfig myNotifyConfig = new MyNotifyConfig();
			ToJson notifyType = myNotifyConfig.getNotifyType(specifyTable);
			Map data = (Map) notifyType.getData();
			String tableName = (String) data.get("mynotice_table");//模块表名
			notify.setTableName(tableName);
			myNotifyMapper.updateNotifys(notify);

			//添加日志
			Syslog syslog = new Syslog();
			syslog.setUserId(user.getUserId());
			syslog.setType(15); //sys_code
			syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",修改");
			sysLogService.saveLog(syslog,request);


			toJson.setFlag(0);
			toJson.setMsg("ok");
			return toJson;
		} catch (Exception e) {
			e.printStackTrace();
			toJson.setFlag(1);
			toJson.setMsg("error");
			return toJson;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/selectById", produces = { "application/json;charset=UTF-8" })
	public ToJson selectById(Integer notifyId, HttpServletRequest request,String specifyTable){
		ToJson toJson =new ToJson();
		try {
			/**
			 * 根据前端传入的参数获得要操作的模块表名
			 */
			MyNotifyConfig myNotifyConfig = new MyNotifyConfig();
			ToJson notifyType = myNotifyConfig.getNotifyType(specifyTable);
			Map data = (Map) notifyType.getData();
			String tableName = (String) data.get("mynotice_table");//模块表名

			MyNotify notify = myNotifyMapper.selectById(notifyId,tableName);
			toJson.setObj1(notify);
			toJson.setFlag(0);
			toJson.setMsg("ok");
			return toJson;
		} catch (Exception e) {
			e.printStackTrace();
			toJson.setFlag(1);
			toJson.setMsg("error");
			return toJson;
		}
	}

	//公告一键已读
	@ResponseBody
	@RequestMapping(value = "/readNotify", produces = {"application/json;charset=UTF-8"})
	public ToJson readNotify(HttpServletRequest request,String specifyTable) {
		return myNotifyService.readNotify(request,specifyTable);
	}
}



