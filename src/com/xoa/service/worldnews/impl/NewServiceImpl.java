package com.xoa.service.worldnews.impl;

import com.xoa.dao.budget.BudgetLogMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.notes.NotesMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.worldnews.NewsCommentMapper;
import com.xoa.dao.worldnews.NewsMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.notify.NotifyModel;
import com.xoa.model.users.Users;
import com.xoa.model.worldnews.News;
import com.xoa.service.ThreadSerivice.ThreadService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.service.worldnews.NewService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 *
 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:40:36 类介绍 : 新闻ServiceImpl(逻辑层) 构造参数:
 *
 */
@Service
@SuppressWarnings("all")
public class NewServiceImpl implements NewService {

@Resource
private NotesMapper notesMapper;
	@Resource
	private NewsMapper newsMapper;// 新闻DAO

	@Resource
	private DepartmentService departmentService;
	@Resource
	private DepartmentMapper DepartmentMapper;
	@Resource
	private UsersService usersService;
	@Resource
	private UsersPrivService usersPrivService;
	@Resource
	private UserPrivMapper userPrivMapper;
	@Resource
	private UsersMapper usersMapper;
	@Resource
	private SysCodeMapper sysCodeMapper;
	@Resource
	private  DepartmentMapper departmentMapper;
	@Resource
	private NewsCommentMapper newsCommentMapper;
	@Resource
	private SmsService smsService;
	@Resource
	private SysParaMapper sysParaMapper;
	@Autowired
	ThreadService threadService;
	@Autowired
	BudgetLogMapper budgetLogMapper;
	@Autowired
	ThreadPoolTaskExecutor threadPoolTaskExecutor;
	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:35:41 方法介绍: 查询新闻列表 参数说明: @param maps
	 * map条件参数 参数说明: @param page 当前页 参数说明: @param pageSize 每页显示条数 参数说明: @param
	 * useFlag 是否开启分页插件 参数说明: @param name 名字 参数说明: @return 参数说明: @throws
	 * Exception
	 *
	 * @return List<News> 返回新闻列表List
	 */
	@Override
	public ToJson<News> selectNews(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag, Users users) throws Exception {
		// spring获取request
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		ToJson<News> newJson = new ToJson<News>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}
		String changeId = (String) maps.get("changeId");
		if (StringUtils.checkNull(changeId)) {
			newJson.setFlag(1);
			newJson.setMsg("err");
			return newJson;
		}else {
			List<News> list=new ArrayList<News>();
			//角色或者辅助角色是OA管理员，可以查看所有人新闻
			if(1 == users.getUserPriv() || (!StringUtils.checkNull(users.getUserPrivOther()) && Arrays.asList(users.getUserPrivOther().split(",")).contains("1"))){
				list = newsMapper.selectNews(maps);//遍历每一条公告
			}else {
				// 获取当前用户，管理的分支机构（包含管理范围）  范围内的新闻
				List<Department> departmentList = departmentService.getDepartmentByClassifyOrg1(users, false);
				if (!org.springframework.util.CollectionUtils.isEmpty(departmentList)) {
					Set<Integer> deptIds = departmentList.stream().map(Department::getDeptId).collect(Collectors.toSet());
					maps.put("deptIds", deptIds);
					list = newsMapper.selectNews(maps);
				} else {
					//查看自己的新闻
					maps.put("provider", users.getUserId());
					list = newsMapper.selectNews(maps);
				}
			}
			if("1".equals(changeId)) {
				for (News news : list) {
					news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
					news.setProviderName(news.getUsers().getUserName());
					if (news.getTypeId() != null && !news.getTypeId().equals("")) {
						SysCode typeSysCode = sysCodeMapper.getSingleCode("NEWS", news.getTypeId());
						news.setTypeName("");

						if (locale.equals("zh_CN")) {
							news.setTypeName(typeSysCode.getCodeName());
						} else if (locale.equals("en_US")) {
							news.setTypeName(typeSysCode.getCodeName1());
						} else if (locale.equals("zh_TW")) {
							news.setTypeName(typeSysCode.getCodeName2());
						}

					} else {
						news.setTypeName("");
					}
					String depId = news.getToId();
					if(!StringUtils.checkNull(depId)){
						String  depName= departmentService.getDeptNameByDeptId(depId,",");
						if(!"ALL_DEPT".trim().equals(news.getToId())){
							 news.setDeprange(depName+",");
						}else{
							news.setDeprange(depName);
						}

					}

					String userId = news.getUserId();
					if(!StringUtils.checkNull(userId)){
						String  userName= usersService.getUserNameById(userId);
						news.setUserrange(userName+",");
					}

					String roleId = news.getPrivId();
					if(!StringUtils.checkNull(roleId)){
						String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
						news.setRolerange(roleName+",");
					}
					if(!StringUtils.checkNull(news.getAuditer())){
						news.setAuditerName(usersMapper.getUsernameByUserId(news.getAuditer()));
					}


					if (news.getReaders().indexOf(users.getUserId()) != -1) {
						news.setRead(1);
					} else {
						news.setRead(0);
					}
				}
				newJson.setFlag(0);
				newJson.setMsg("ok");
				newJson.setObj(list);
				newJson.setTotleNum(pageParams.getTotal());
			}else if("2".equals(changeId)){
				for (News news : list) {
					newsMapper.deleteNews(news.getNewsId());
				}
				newJson.setFlag(0);
				newJson.setMsg("ok");
				newJson.setObject(list.size());
			}
		}
		return newJson;
	}

	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:35:41 方法介绍: 查询未读新闻列表 参数说明: @param maps
	 * map条件参数 参数说明: @param page 当前页 参数说明: @param pageSize 每页显示条数 参数说明: @param
	 * useFlag 是否开启分页插件 参数说明: @param name 名字 参数说明: @return 参数说明: @throws
	 * Exception
	 *
	 * @return List<News> 返回新闻列表List
	 */
	@Override
	public ToJson<News> unreadNews(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag, String name, String sqlType)
			throws Exception {
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		ToJson<News> newJson = new ToJson<News>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}
		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			String[] userPrivOthers = userPrivOther.split(",");
			maps.put("userPrivOthers", userPrivOthers);
		}
		String sysPara = null;
		try {
			sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
		}catch (Exception e){
			e.printStackTrace();
		}
		if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
			String auditerStatus = "1";
			maps.put("auditerStatus",auditerStatus);
		}

		List<News> list = newsMapper.unreadNews(maps);
		List<News> list1 = new ArrayList<News>();
		List<News> list2 = new ArrayList<News>();
		for (News news : list) {
			Integer newsId = news.getNewsId();
			if(newsId!=null){
				int count = newsCommentMapper.getNewsCount(newsId);
				news.setNewsCount(count);
			}

			news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
			/*Users users = usersMapper.selectUserByUserId2(news.getProvider());
			if(users == null){
				users = new Users();
				users.setAvatar("0");
				users.setUserName("用户已删除");
			}
			news.setUsers(users);*/
			news.setProviderName(news.getUsers().getUserName());
			if (news.getTypeId() != null && !news.getTypeId().equals("")) {
				String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
				if (StringUtils.checkNull(name11)) {
					news.setTypeName("");
				} else {
					news.setTypeName(name11);
				}
			} else {
				news.setTypeName(" ");
			}
			if (news.getAttachmentName() != null
					&& news.getAttachmentId() != null) {
				news.setAttachment(GetAttachmentListUtil.returnAttachment(news.getAttachmentName(), news.getAttachmentId(),
						sqlType, GetAttachmentListUtil.MODULE_NEWS));
			}

			if (!StringUtils.checkNull(news.getTitlePicName())
					&& !StringUtils.checkNull(news.getTitlePicId())) {
				List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(
						news.getTitlePicName(), news.getTitlePicId(),
						sqlType, GetAttachmentListUtil.MODULE_NEWS);
				if(!Objects.isNull(attachments) && attachments.size() > 0){
					news.setTitlePicAttachment(attachments.get(0));
				}
			}

		//	String depId = news.getToId();

			String depId = news.getToId();
			if(!StringUtils.checkNull(depId)){
				String  depName= departmentService.getDeptNameByDeptId(depId,",");
				if(!"ALL_DEPT".trim().equals(news.getToId())){
					news.setDeprange(depName+",");
				}else{
					news.setDeprange(depName);
				}

			}

			String userId = news.getUserId();
			if(!StringUtils.checkNull(userId)){
				String  userName= usersService.getUserNameById(userId);
				news.setUserrange(userName+",");
			}

			String roleId = news.getPrivId();
			if(!StringUtils.checkNull(roleId)){
				String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
				news.setRolerange(roleName+",");
			}
			// 1 已读  0未读
			if (news.getReaders().indexOf(","+name+",") != -1) {
				news.setRead(1);
			} else {
				news.setRead(0);
			}

		}


		newJson.setObj(list);
		newJson.setTotleNum(pageParams.getTotal());
		return newJson;
	}



	@Override
	public ToJson<News> unreadNewsPlus(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String name, String sqlType) {
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		ToJson<News> newJson = new ToJson<News>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}
		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			String[] userPrivOthers = userPrivOther.split(",");
			maps.put("userPrivOthers", userPrivOthers);
		}
		String sysPara = null;
		try {
			sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
		}catch (Exception e){
			e.printStackTrace();
		}
		if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
			String auditerStatus = "1";
			maps.put("auditerStatus",auditerStatus);
		}

		List<News> list = newsMapper.unreadNewsPlus(maps);
		List<News> list1 = new ArrayList<News>();
		List<News> list2 = new ArrayList<News>();
		for (News news : list) {
			// 1 已读  0未读
			if (news.getReaders().indexOf(","+name+",") != -1) {
				news.setRead(1);
			} else {
				news.setRead(0);
			}
			if (news.getTypeId() != null && !news.getTypeId().equals("")) {
				String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
				if (StringUtils.checkNull(name11)) {
					news.setTypeName("");
				} else {
					news.setTypeName(name11);
				}
			} else {
				news.setTypeName(" ");
			}

			news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
		}

		newJson.setObj(list);
		newJson.setTotleNum(pageParams.getTotal());
		return newJson;
	}

	@Override
	public ToJson<News> readNewsPlus(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String name, String sqlType) {
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		ToJson<News> newJson = new ToJson<News>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}
		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			String[] userPrivOthers = userPrivOther.split(",");
			maps.put("userPrivOthers", userPrivOthers);
		}
		String sysPara = null;
		try {
			sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
		}catch (Exception e){
			e.printStackTrace();
		}
		if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
			String auditerStatus = "1";
			maps.put("auditerStatus",auditerStatus);
		}

		List<News> list = newsMapper.readNewsPlus(maps);
		for (News news : list) {
			if (news.getReaders().indexOf(name) != -1) {
				news.setRead(1);
			} else {
				news.setRead(0);
			}
			if (news.getTypeId() != null && !news.getTypeId().equals("")) {
				String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
				if (StringUtils.checkNull(name11)) {
					news.setTypeName("");
				} else {
					news.setTypeName(name11);
				}
			} else {
				news.setTypeName(" ");
			}
			news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
		}

		newJson.setObj(list);
		newJson.setTotleNum(pageParams.getTotal());
		return newJson;
	}

	/**
	 * 新闻判断置顶并取消置顶时间已过的
	 */
	@Override
	public void updateTop() {
		List<News> lists = newsMapper.selectTop();
		for (News list:lists){
			long time = list.getNewsTime().getTime();
			String topDays = list.getTopDays();
            long oneDayTime=1000*60*60*24;
            long sss = time+Integer.parseInt(topDays)*oneDayTime;
            long ssss = System.currentTimeMillis();
            if (time+Integer.parseInt(topDays)*oneDayTime < System.currentTimeMillis()){
            	newsMapper.updateTop(list.getNewsId());
			}
		}
	}

	@Override
	public ToJson<News> readNews(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag, String name, String sqlType)
			throws Exception {
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		ToJson<News> newJson = new ToJson<News>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}
		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			String[] userPrivOthers = userPrivOther.split(",");
			maps.put("userPrivOthers", userPrivOthers);
		}
		String sysPara = null;
		try {
			sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
		}catch (Exception e){
			e.printStackTrace();
		}
		if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
			String auditerStatus = "1";
			maps.put("auditerStatus",auditerStatus);
		}

		List<News> list = newsMapper.readNews(maps);
		for (News news : list) {
			Integer newsId = news.getNewsId();
			if(newsId!=null){
				int count = newsCommentMapper.getNewsCount(newsId);
				news.setNewsCount(count);
			}
			news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
			/*Users users = usersMapper.selectUserByUserId2(news.getProvider());
			if(users == null){
				users = new Users();
				users.setAvatar("0");
				users.setUserName("用户已删除");
			}
			news.setUsers(users);*/
			news.setProviderName(news.getUsers().getUserName());
			if (news.getTypeId() != null && !news.getTypeId().equals("")) {
				String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
				if (StringUtils.checkNull(name11)) {
					news.setTypeName("");
				} else {
					news.setTypeName(name11);
				}
			} else {
				news.setTypeName(" ");
			}
			if (news.getAttachmentName() != null
					&& news.getAttachmentId() != null) {
				news.setAttachment(GetAttachmentListUtil.returnAttachment(
						news.getAttachmentName(), news.getAttachmentId(),
						sqlType, GetAttachmentListUtil.MODULE_NEWS));
			}
			if (!StringUtils.checkNull(news.getTitlePicName())
					&& !StringUtils.checkNull(news.getTitlePicId())) {
				List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(
						news.getTitlePicName(), news.getTitlePicId(),
						sqlType, GetAttachmentListUtil.MODULE_NEWS);
				if(!Objects.isNull(attachments) && attachments.size() > 0){
					news.setTitlePicAttachment(attachments.get(0));
				}
			}
			String depId = news.getToId();
			if(!StringUtils.checkNull(depId)){
				String  depName= departmentService.getDeptNameByDeptId(depId,",");
				if(!"ALL_DEPT".trim().equals(news.getToId())){
					news.setDeprange(depName+",");
				}else{
					news.setDeprange(depName);
				}

			}

			String userId = news.getUserId();
			if(!StringUtils.checkNull(userId)){
				String  userName= usersService.getUserNameById(userId);
				news.setUserrange(userName+",");
			}

			String roleId = news.getPrivId();
			if(!StringUtils.checkNull(roleId)){
				String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
				news.setRolerange(roleName+",");
			}
			if (news.getReaders().indexOf(name) != -1) {
				news.setRead(1);
			} else {
				news.setRead(0);
			}

		}

		newJson.setObj(list);
		newJson.setTotleNum(pageParams.getTotal());
		return newJson;
	}

	/**
	 *
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:39:24 方法介绍: 添加新闻 参数说明: @param news
	 *
	 */
	@Override
	@Transactional
	public News sendNews(News news, String remind, String tuisong, HttpServletRequest request) {
		String sysPara = null;
		String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		try {
			sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值 而报错
			if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {//为1的时候需要审批
				if(news.getRunId()!=null&&news.getRunId()!=0){//不为空是属于流程审批
					news.setAuditerStatus("3");
				}else{//为空是正常审批
					news.setAuditerStatus("0");
				}
				news.setPublish("0");
				remind = "0";
			} else {
				news.setAuditerTime(new Date());
				news.setAuditerStatus("1");
			}
		}catch (Exception e){

		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (news.getAuditerTime()==null){//新建时防止审批时间为空导致新建失败
			news.setAuditerTime(new Date());
		}
		if(news.getAuditer()==null){
			news.setAuditer("");
		}
		newsMapper.save(news);
		if ("1".equals(news.getPublish())) {//发布标识(0-未发布,1-已发布,2-已终止)
			threadService.addNew(news, remind, tuisong, sqlType, locale);
			threadService.addAffairs(news,remind,request);
		}
		return news;
	}

	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:39:48 方法介绍: 修改新闻 参数说明: @param news
	 *
	 * @return void
	 */
	@Override
	@Transactional
	public void updateNews(News news,String remind,String tuisong, HttpServletRequest request) {
		Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		// 如果发布部门to_id的值为ALL_DEPT,则清空发布角色和发布人员的值
		if("ALL_DEPT".equals(news.getToId())){
			news.setPrivId("");
			news.setUserId("");
		}
		newsMapper.update(news);
		Map<String,Object> map=new HashedMap();
		map.put("newsId",news.getNewsId());
		News news1=newsMapper.selectId(news.getNewsId());
		if("1".equals(news1.getPublish())){
			String sqlType =(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
			threadService.addNew(news1,remind,tuisong,sqlType, locale);

		}

	}

	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:40:16 方法介绍: 根据ID查询一条 参数说明: @param newsId
	 *
	 * @return void
	 */
	@Override
	public News queryById(Map<String, Object> maps, Integer page,
			Integer pageSize, boolean useFlag, String name, String sqlType,String changId)
			throws Exception {
	   String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String[] userPrivOthers = null;
				String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			 userPrivOthers = userPrivOther.split(",");
		}
		maps.put("userPrivOthers", userPrivOthers);
		News news = newsMapper.detailedNews(maps);
		news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
		Users users = usersMapper.getByUserId(news.getProvider());
		if(users == null){
			users = new Users();
			users.setUserName("");
		}
		news.setUsers(users);
		news.setProviderName(news.getUsers().getUserName());
		if (news.getTypeId() != null && !news.getTypeId().equals("")) {
			String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
			if (StringUtils.checkNull(name11)) {
				news.setTypeName("");
			} else {
				news.setTypeName(name11);
			}
		} else {
			news.setTypeName(" ");
		}
		if (news.getAttachmentName() != null && news.getAttachmentId() != null) {
			news.setAttachment(GetAttachmentListUtil.returnAttachment(
					news.getAttachmentName(), news.getAttachmentId(), sqlType,
					GetAttachmentListUtil.MODULE_NEWS));
		}
		if (!StringUtils.checkNull(news.getTitlePicName())
				&& !StringUtils.checkNull(news.getTitlePicId())) {
			List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(
					news.getTitlePicName(), news.getTitlePicId(),
					sqlType, GetAttachmentListUtil.MODULE_NEWS);
			if(!Objects.isNull(attachments) && attachments.size() > 0){
				news.setTitlePicAttachment(attachments.get(0));
			}
		}
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

		String depId = news.getToId();
		if(!StringUtils.checkNull(depId)){
			String  depName= departmentService.getDeptNameByDeptId(depId,",");
			if(!"ALL_DEPT".trim().equals(news.getToId())){
				news.setDeprange(depName+",");
			}else{
				news.setDeprange(depName);
			}

		}

		String userId = news.getUserId();
		if(!StringUtils.checkNull(userId)){
			String  userName= usersService.getUserNameById(userId);
			news.setUserrange(userName+",");
		}

		String roleId = news.getPrivId();
		if(!StringUtils.checkNull(roleId)){
			String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
			news.setRolerange(roleName+",");
		}
		if(!"1".equals(changId)){
			// 2020/5/27 之前规则有问题   indexof 131  如果数据库存有1131 就判断不进来
			if (news.getReaders().indexOf(","+name+",")== -1 || StringUtils.checkNull(news.getReaders())) {
				smsService.updatequerySmsByType("14",name,String.valueOf(news.getNewsId()));
			StringBuffer str2 = new StringBuffer(news.getReaders());
				str2.append(name);
				str2.append(",");
				String str1 = str2.toString();
				news.setNewsId(news.getNewsId());
				// 2020/5/27 之前规则有问题   indexof 131  如果数据库存有1131 就判断不进来
				if (StringUtils.checkNull(str1)){
					news.setReaders(","+str1);
				}else {
					news.setReaders(str1);
				}
				news.setClickCount(news.getClickCount() + 1);
				newsMapper.updateNews(news);
			}
			 else {
				news.setNewsId(news.getNewsId());
				news.setClickCount(news.getClickCount() + 1);
				newsMapper.updateclickCount(news);
			}
		}

		return news;

	}

	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:40:16 方法介绍: 根据ID删除一条 参数说明: @param newsId
	 *
	 * @return void
	 */
	@Override
	@Transactional
	public void deleteByPrimaryKey(Integer newsId) {
		newsMapper.deleteNews(newsId);
	}

	@Override
	public ToJson<News>deleteByids(String[] newsId) {
		ToJson<News> newsToJson=new ToJson<News>();
		if(newsId.length>0){

			newsMapper.deleteByids(newsId);

		}
		newsToJson.setFlag(0);
		newsToJson.setMsg("ok");
		return newsToJson;
	}

	@Override
	public ToJson<News> updayeByids(String[] newsId, String top,String publish) {
		ToJson<News>  newsToJson=new ToJson<News>();
		if (StringUtils.checkNull(top)&&StringUtils.checkNull(publish)){
			newsToJson.setFlag(1);
			newsToJson.setMsg("err");
			return newsToJson;
		}
		if(newsId.length>0){

		int a=newsMapper.updateByIds(top,publish,newsId);
			newsToJson.setFlag(0);
			newsToJson.setMsg("ok");
		}else {
			newsToJson.setFlag(1);
			newsToJson.setMsg("err");

		}		return newsToJson;
	}

	@Override
	public ToJson<News> ConsultTheSituationNew(String newsId) {
		ToJson<News> newsToJson=new ToJson<News>();
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("newsId", newsId);
		 News news=newsMapper.detailedNews(maps);
		 if(news!=null){
			 news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
			 news.setProviderName(news.getUsers().getUserName());
			 List<Users> unreadList = usersMapper.unreadConsultTheSituationNew(maps);
			 List<Users> readList = usersMapper.readConsultTheSituationNew(maps);
			 List<Department> departmentList = departmentMapper.getDatagrid();

			 if (!StringUtils.checkNull(news.getProvider())) {
				 Users users = usersMapper.getUsersByuserId(news.getProvider());
				 news.setProviderName(users.getUserName());
			 }
			 Set<Users> s = new HashSet();
			 if (!StringUtils.checkNull(news.getToId())) {
				 String[] deptIdOthers = news.getToId().split(",");
				 s.addAll(notesMapper.getUsersByAssistedDeptIds(deptIdOthers));
			 }
			 if (!StringUtils.checkNull(news.getPrivId())) {
				 String[] userPrivOthers = news.getPrivId().split(",");
				 s.addAll(notesMapper.getUsersByAssistedPrivIds(userPrivOthers));
			 }
			 String re = news.getReaders();
			 if (!StringUtils.checkNull(re)) {
				 for (Users ue : s) {
					 if (re.contains(ue.getUserId())) {
						 readList.add(ue);
					 } else {
						 unreadList.add(ue);
					 }
				 }
			 }
			 Set<Users> set = new TreeSet<>(new Comparator<Users>() {
				 @Override
				 public int compare(Users o1, Users o2) {
					 return o1.getUid() - o2.getUid();
				 }
			 });
			 set.addAll(readList);
			 readList = new ArrayList<>(set);
			 set.clear();
			 set.addAll(unreadList);
			 unreadList = new ArrayList<>(set);
			 for (Department department : departmentList) {
				 StringBuffer stringBuffer = new StringBuffer();
				 for (Users users : unreadList) {
					 Integer depId = users.getDeptId();
					 if (department.getDeptId().equals(depId)) {
						 stringBuffer.append(users.getUserName());
						 stringBuffer.append(",");
					 }
				 }
				 department.setUnread(stringBuffer.toString());
				 StringBuffer stringBuffer1 = new StringBuffer();
				 for (Users users : readList) {
					 Integer depId = users.getDeptId();
					 if (department.getDeptId().equals(depId)) {
						 stringBuffer1.append(users.getUserName());
						 stringBuffer1.append(",");
					 }
				 }
				 department.setRead(stringBuffer1.toString());
			 }

			 news.setReadSize(readList.size());
			 news.setUnreadSize(unreadList.size());
			 news.setDepartmentList(departmentList);
		 }

		newsToJson.setFlag(0);
		newsToJson.setMsg("ok");
		newsToJson.setObject(news);
		return newsToJson;
	}

	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:39:06 方法介绍: 查询新闻管理 参数说明: @param maps
	 * map条件参数 参数说明: @param page 当前页 参数说明: @param pageSize 每页显示条数 参数说明: @param
	 * useFlag 是否开启分页插件 参数说明: @return 参数说明: @throws Exception
	 *
	 * @return List<News>
	 */
	@Override
	public ToJson<News> selectNewsManage(Map<String, Object> maps,
			Integer page, Integer pageSize, boolean useFlag, String name,
			String sqlType) throws Exception {
		ToJson<News> newJson = new ToJson<News>();
		String[] strArray = null;
		String[] strArray1 = null;
		String[] strArray2 = null;
		StringBuffer s = new StringBuffer();
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		maps.put("page", pageParams);
		String typeIdStr = (String) maps.get("typeId");
		if (StringUtils.checkNull(typeIdStr)) {
			maps.put("typeId", null);
		}

		String newStr= new String();
		if (maps.get("provider")!=null){
			if(!StringUtils.checkNull(maps.get("provider").toString())){
				String fromIds = maps.get("provider").toString();
				String[] substring = fromIds.split(",");
				maps.put("newStr",substring);
			}
		}

		// 辅助部门分割成字符串传入dao
		String deptIdOther = (String) maps.get("deptIdOther");
		if (!StringUtils.checkNull(deptIdOther)) {
			String[] deptIdOthers = deptIdOther.split(",");
			maps.put("deptIdOthers", deptIdOthers);
		}
		//辅助角色分割成字符串传入dao
		String userPrivOther = (String) maps.get("userPrivOther");
		if (!StringUtils.checkNull(userPrivOther)) {
			String[] userPrivOthers = userPrivOther.split(",");
			maps.put("userPrivOthers", userPrivOthers);
		}

		List<News> list = newsMapper.selectNewsManage(maps);
		List<News> list1 = new ArrayList<News>();

			for (News news : list) {
				Integer newsId = news.getNewsId();
				if(newsId!=null){
					int count = newsCommentMapper.getNewsCount(newsId);
					news.setNewsCount(count);
				}
				news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));

				/*Users users = usersMapper.getByUserId(news.getProvider());
				if(users == null){
					users = new Users();
					users.setUserName("用户已删除");
					users.setAvatar("0");
				}
				news.setUsers(users);*/
//				Users users = usersMapper.selectUserByUserId2(news.getProvider());
//               //兼容移动端参数，逻辑不明，故不修改以前代码
//                Users u11 = usersMapper.getByUserId(news.getProvider());
//                users.setAvatar(u11.getAvatar());
//				news.setUsers(users);
                //String  uName= usersService.getUserNameById(news.getProvider());
				news.setProviderName(news.getUsers().getUserName());
				if (news.getTypeId() != null && !news.getTypeId().equals("")) {
					String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
					if (StringUtils.checkNull(name11)) {
						news.setTypeName("");
					} else {
						news.setTypeName(name11);
					}
				} else {
					news.setTypeName(" ");
				}
				if (news.getAttachmentName() != null
						&& news.getAttachmentId() != null) {
					news.setAttachment(GetAttachmentListUtil.returnAttachment(
							news.getAttachmentName(), news.getAttachmentId(),
							sqlType, GetAttachmentListUtil.MODULE_NEWS));
				}
				if (!StringUtils.checkNull(news.getTitlePicName())
						&& !StringUtils.checkNull(news.getTitlePicId())) {
					List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(
							news.getTitlePicName(), news.getTitlePicId(),
							sqlType, GetAttachmentListUtil.MODULE_NEWS);
					if(!Objects.isNull(attachments) && attachments.size() > 0){
						news.setTitlePicAttachment(attachments.get(0));
					}
				}
				String depId = news.getToId();
				if(!StringUtils.checkNull(depId)){
					String  depName= departmentService.getDeptNameByDeptId(depId,",");
					news.setDeprange(depName);
				}

				String userId = news.getUserId();
				if(!StringUtils.checkNull(userId)){
					String  userName= usersService.getUserNameById(userId);
					news.setUserrange(userName);
				}

				String roleId = news.getPrivId();
				if(!StringUtils.checkNull(roleId)){
					String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
					news.setRolerange(roleName);
				}
				if (news.getReaders().indexOf(name) != -1) {
					news.setRead(1);
				} else {
					news.setRead(0);
				}

			}

		String button = (String) maps.get("button");
		if (StringUtils.checkNull(button)) {
			maps.put("typeId", null);
		}

		newJson.setObj(list);
		newJson.setTotleNum(pageParams.getTotal());
		return newJson;
	}

	@Override
	public void updatePublish(News news,String remind,String tuisong,HttpServletRequest request) {
		// TODO Auto-generated method stub
		Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		newsMapper.updatePublish(news);
		Map<String,Object> map=new HashedMap();
		map.put("newsId",news.getNewsId());
		News news1=newsMapper.detailedNews(map);
		if("1".equals(news1.getPublish())){
			String sqlType =(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
			threadService.addNew(news1,remind,tuisong,sqlType, locale);
		}

	}


	@Override
	public void updateNewsReades(News news,String remind,String tuisong,HttpServletRequest request) {
		// TODO Auto-generated method stub
		newsMapper.updateNewsReades(news);
	}

	/*
	给公告添加提醒事务
	 */

	@Override
	public BaseWrapper getNewCountByType(HttpServletRequest request, String type){
		BaseWrapper baseWrapper = new BaseWrapper();
		String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		List<News> news = newsMapper.getNewCountByType();
		Map<String,Integer> temp = new HashMap<>();
		for(News item : news){
			String key = "新闻";
			if (locale.equals("en_US")) {
				key = "News";
			} else if (locale.equals("zh_TW")) {
				key = "新聞";
			}
			SysCode code = item.getCodes();
			if(code!=null){
				key = code.getCodeName();
			}
			if(temp.containsKey(key)){
				temp.put(key,temp.get(key)+1);
			}else{
				temp.put(key,1);
			}
		}
		baseWrapper.setData(temp);
		baseWrapper.setFlag(true);
		baseWrapper.setStatus(true);
		return baseWrapper;


	}
	/**
	 * @author 程叶同
	 * @date 2018/7/28 11:38
	 * @desc  获取徐州教育网站新闻
	 */
	@Override
	public ToJson getXzNews(HttpServletRequest request){
		ToJson toJson=new ToJson();
		String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		List<NotifyModel> list=new ArrayList<>();
		try {
			URL url=new URL("http://www.xzkfq.cn/");
			String urlsource = getURLSource(url);
			Document doc = Jsoup.parse(urlsource);
			Elements rows = doc.select("div[class=bd]").get(0).select("ul");
			if (rows.size() == 0) {
				if (locale.equals("zh_CN")) {
					toJson.setMsg("没有数据");
				} else if (locale.equals("en_US")) {
					toJson.setMsg("No data");
				} else if (locale.equals("zh_TW")) {
					toJson.setMsg("沒有數據");
				}
				return  toJson;
			}else {
				Element row = rows.get(0);
				NotifyModel notify=null;
				Elements a = rows.get(0).select("a");
				for(int i=0;i<a.size();i++) {
					notify=new NotifyModel();
					String title = a.get(i).attr("title");
					String href = a.get(i).attr("href");
					notify.setTitle(title);
					notify.setUrl("http://www.xzkfq.cn/"+href);
					list.add(notify);
				}
				toJson.setFlag(0);
				if (locale.equals("zh_CN")) {
					toJson.setMsg("查询成功");
				} else if (locale.equals("en_US")) {
					toJson.setMsg("Query was successful");
				} else if (locale.equals("zh_TW")) {
					toJson.setMsg("查詢成功");
				}
				toJson.setObj(list);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  toJson;
	}

	@Override
	public ToJson<News> updateDate(HttpServletRequest request) {

		ToJson<News> json = new ToJson<>(1, "err");
		News news = new News();
		try {
			List<News> list = newsMapper.getAll();
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					String content =list.get(i).getContent();

                   /* Pattern CRLF = Pattern.compile("(\r\n|\r|\n|\n\r)");
                    Matcher m = CRLF.matcher(content);*/
                   /* if (m.find()) {*/
					//content = m.replaceAll("<br/>");
					content = content.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
                    /*}*/
					//System.out.println(content);
					news.setNewsId(list.get(i).getNewsId());
					news.setContent(content);
					newsMapper.updateDate(news);
				}
			}
			json.setFlag(0);
			json.setMsg("ok");

		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return json;
	}


	/** *//**
	 * 通过网站域名URL获取该网站的源码
	 * @param url
	 * @return String
	 * @throws Exception
	 */
	public static String getURLSource(URL url) throws Exception    {
//		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		StringBuffer sb = new StringBuffer();
//		conn.setRequestMethod("GET");
//		conn.setConnectTimeout(5 * 1000);
//		InputStream inStream =  conn.getInputStream();  //通过输入流获取html二进制数据
		BufferedReader in = new BufferedReader(new InputStreamReader(url
				.openStream(),"utf-8"));
		String line;
		while ((line = in.readLine()) != null) {
			sb.append(line);
		}
		in.close();
		String htmlSource=sb.toString();
//		byte[] data = readInputStream(inStream);        //把二进制数据转化为byte字节数据
//		String htmlSource = new String(data);
		return htmlSource;
	}

	/** *//**
	 * 把二进制流转化为byte字节数组
	 * @param instream
	 * @return byte[]
	 * @throws Exception
	 */
	public static byte[] readInputStream(InputStream instream)  {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		byte[]  buffer = new byte[1204];
		int len = 0;

		try {
		while ((len = instream.read(buffer)) != -1){
			outStream.write(buffer,0,len);
		}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			if(instream !=null){
				try {
					instream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return outStream.toByteArray();
	}
	@Override
	public ToJson<News> getNewStatus(HttpServletRequest request,String auditerStatus,Integer page, Integer pageSize,Boolean useFlag) {
		ToJson<News> json = new ToJson<>(1, "err");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

		Map<String, Object> map = new HashMap<String, Object>();
		PageParams pageParams = new PageParams();
		pageParams.setUseFlag(useFlag);
		pageParams.setPage(page);
		pageParams.setPageSize(pageSize);
		map.put("page", pageParams);
		map.put("auditerStatus",auditerStatus);
		map.put("userId",user.getUserId());
		List<News> news = newsMapper.selectManageNews(map);//查询当前要审批的新闻
		for (News news1:news){
			if (news1.getTypeId() != null && !news1.getTypeId().equals("")) {
				String name11 = sysCodeMapper.getNewsNameByNo(news1.getTypeId());
				if (StringUtils.checkNull(name11)) {
					news1.setTypeName("");
				} else {
					news1.setTypeName(name11);
				}
			} else {
				news1.setTypeName(" ");
			}

			String depId = news1.getToId();
			if(!StringUtils.checkNull(depId)){
				String  depName= departmentService.getDeptNameByDeptId(depId,",");
				news1.setDeprange(depName);
			}

			String userId = news1.getUserId();
			if(!StringUtils.checkNull(userId)){
				String  userName= usersService.getUserNameById(userId);
				news1.setUserrange(userName);
			}

			String roleId = news1.getPrivId();
			if(!StringUtils.checkNull(roleId)){
				String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
				news1.setRolerange(roleName);
			}

			String provider = news1.getProvider();//发布者
			if(!StringUtils.checkNull(provider)){
				String providerName= usersMapper.findUsersByuserId(provider).getUserName();
				news1.setProviderName(providerName);
			}

			if(!StringUtils.checkNull(news1.getAuditer())){
				news1.setAuditerName(usersMapper.getUsernameByUserId(news1.getAuditer()));
			}
			if (news1.getAuditer().equals("1")){//审批同意的
				if (news1.getPublish().equals("0")){  //审批同意后发布状态应为1  如果还是0  更改发布状态为1 并记录日志表
					String sysPara = null;
					try {
						sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
					}catch (Exception e){

					}
				}
			}
		}
		json.setObj(news);
		json.setFlag(0);
		json.setTotleNum(pageParams.getTotal());
		return json;
	}

	@Override
	public ToJson<News> upNewStatus(HttpServletRequest request, String auditerStatus, String newsId ,String publish) {
		ToJson<News> json = new ToJson<>(1, "err");
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("auditerStatus",auditerStatus);
		map.put("newsId",newsId);
		map.put("auditerTime",new Date());
		map.put("userId",user.getUserId());
		map.put("publish", publish);
		if ("1".equals(auditerStatus)&&"0".equals(publish)){//点击批准时pulish传1   防止出现已审批未发布情况
			map.put("publish",1);
		}
        Boolean sendNewsYn = true;
        if(sendNewsYn){
            int news = newsMapper.upNewStatus(map);
            if ("1".equals(auditerStatus)){//批准发送事务提醒
                News news1 = newsMapper.selectId(Integer.parseInt(newsId));
                if("1".equals(news1.getPublish())){
                    String sqlType =(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    String remind = "1";
                    String tuisong = "1";
                    threadService.addNew(news1,remind,tuisong,sqlType, locale);

                }
            }
        }
		json.setFlag(0);
		json.setCode("1");
		return json;
	}

	//新闻一键已读
	@Override
	public ToJson readNews(HttpServletRequest request) {
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		String name=user.getUserId();
		ToJson toJson = new ToJson();
		String[] newsIds = request.getParameter("newsIds").split(",");
		String changId = request.getParameter("changId");
		for (String newsId:newsIds) {
			if(!"1".equals(changId)){
                News news = newsMapper.selectId(Integer.parseInt(newsId));
                //判断当前办理人是否在已阅人员中
                boolean flag = Arrays.asList(news.getReaders().split(",")).contains(name);
                if (flag==false || StringUtils.checkNull(news.getReaders())) {
					smsService.updatequerySmsByType("14",name,String.valueOf(news.getNewsId()));
					StringBuffer str2 = new StringBuffer(news.getReaders());
					str2.append(name);
					str2.append(",");
					String str1 = str2.toString();
					news.setNewsId(news.getNewsId());
					if (StringUtils.checkNull(str1)){
						news.setReaders(","+str1);
					}else {
						news.setReaders(str1);
					}
					news.setClickCount(news.getClickCount() + 1);
					newsMapper.updateNews(news);
				}
				else {
					news.setNewsId(news.getNewsId());
					news.setClickCount(news.getClickCount() + 1);
					newsMapper.updateclickCount(news);
				}
			}
		}
        toJson.setMsg("ok");
		toJson.setFlag(0);
		return toJson;
	}

	//办公门户待审核新闻
	@Override
	public ToJson approveNew(HttpServletRequest request) {
		ToJson json = new ToJson();

		return json;

	}

	//根据新闻主键更新新闻内容
	@Override
	public ToJson<News> updateContent(News news, HttpServletRequest request) {
		ToJson<News> json = new ToJson<>(1, "err");
		try {
			newsMapper.updateDate(news);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return json;
	}

    //新闻集成单独处理
    public boolean power(News news, HttpServletRequest request) {
        ToJson<News> json = new ToJson<>(1, "err");

        return false;
    }
    //根据主键获取新闻数据
    @Override
    public News getDataByNewsId(HttpServletRequest request, Integer newsId, String sqlType) throws Exception {
		String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        News news = newsMapper.selectId(newsId);
        news.setNewsDateTime(DateFormat.getStrDate(news.getNewsTime()));
        Users users = usersMapper.getByUserId(news.getProvider());
        if (users == null) {
            users = new Users();
			if (locale.equals("zh_CN")) {
				users.setUserName("用户已删除");
			} else if (locale.equals("en_US")) {
				users.setUserName("The user has been deleted");
			} else if (locale.equals("zh_TW")) {
				users.setUserName("用戶已刪除");
			}
        }
        news.setUsers(users);
        news.setProviderName(news.getUsers().getUserName());
        if (news.getTypeId() != null && !news.getTypeId().equals("")) {
            String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
            if (StringUtils.checkNull(name11)) {
                news.setTypeName("");
            } else {
                news.setTypeName(name11);
            }
        } else {
            news.setTypeName(" ");
        }
        if (news.getAttachmentName() != null && news.getAttachmentId() != null) {
            news.setAttachment(GetAttachmentListUtil.returnAttachment(
                    news.getAttachmentName(), news.getAttachmentId(), sqlType,
                    GetAttachmentListUtil.MODULE_NEWS));
        }
		if (!StringUtils.checkNull(news.getTitlePicName())
				&& !StringUtils.checkNull(news.getTitlePicId())) {
			List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(
					news.getTitlePicName(), news.getTitlePicId(),
					sqlType, GetAttachmentListUtil.MODULE_NEWS);
			if(!Objects.isNull(attachments) && attachments.size() > 0){
				news.setTitlePicAttachment(attachments.get(0));
			}
		}
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();

        String depId = news.getToId();
        if (!StringUtils.checkNull(depId)) {
            String depName = departmentService.getDeptNameByDeptId(depId, ",");
            if (!"ALL_DEPT".trim().equals(news.getToId())) {
                news.setDeprange(depName + ",");
            } else {
                news.setDeprange(depName);
            }
        }
        String userId = news.getUserId();
        if (!StringUtils.checkNull(userId)) {
            String userName = usersService.getUserNameById(userId);
            news.setUserrange(userName + ",");
        }
        String roleId = news.getPrivId();
        if (!StringUtils.checkNull(roleId)) {
            String roleName = usersPrivService.getPrivNameByPrivId(roleId, ",");
            news.setRolerange(roleName + ",");
        }
        return news;

    }
	//统计所有新闻题目，作者，摄影作者，日期，字数，图片数量等数量并导出excel
	@Override
	public ToJson<News> showAllCountByHtml(HttpServletRequest request, HttpServletResponse response) {
		ToJson<News> toJson = new ToJson<>();
		String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
		I18nUtils.setLocale(locale);
		try {
				List<News> news = newsMapper.showAllCountByHtml();
				for (News news1 : news) {
					Document dom = HtmlUtil.getDom(news1.getContent());
					int imgCount = dom.getElementsByTag("img").size();	//照片数量
					int count = dom.text().length();	//文字数量
					news1.setPhotoCount(imgCount+"");
					news1.setWordsCount(count+"");
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy" + I18nUtils.getMessage("chat.th.year") +
							"MM" + I18nUtils.getMessage("global.lang.month") + "dd" + I18nUtils.getMessage("global.lang.day") +
							"  HH " + I18nUtils.getMessage("calendar.th.hour") + " mm " + I18nUtils.getMessage("calendar.th.minute") +
							" ss " + I18nUtils.getMessage("system.th.second"));
					String format = simpleDateFormat.format(news1.getNewsTime());
					news1.setAnonymityYn(format);
				}
				HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("ID，" +
						I18nUtils.getMessage("new.th.topic") + "，" + I18nUtils.getMessage("event.th.author") + "，" +
						I18nUtils.getMessage("new.th.photographyAuthor") + "，" + I18nUtils.getMessage("global.lang.date") + "，" +
						I18nUtils.getMessage("new.th.numberOfWords") + "，" + I18nUtils.getMessage("new.th.numberOfImages"), 6);//40
				String[] secondTitles = {"ID", I18nUtils.getMessage("new.th.topic"), I18nUtils.getMessage("event.th.author"),
						I18nUtils.getMessage("new.th.photographyAuthor"), I18nUtils.getMessage("global.lang.date"),
						I18nUtils.getMessage("new.th.numberOfWords"), I18nUtils.getMessage("new.th.numberOfImages")};
				HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
				String[] beanProperty = {"newsId","subject", "author", "photographer", "anonymityYn", "wordsCount", "photoCount"};
				HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, news, beanProperty);
				ServletOutputStream out = response.getOutputStream();

				String filename = I18nUtils.getMessage("new.th.newsDataStatistics") + ".xls"; //考虑多语言
				filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("content-disposition",
						"attachment;filename=" + filename);
				workbook.write(out);
				out.close();

				toJson.setMsg("OK");
		}catch (Exception e){
			e.printStackTrace();
		}
		return toJson;
	}

}
