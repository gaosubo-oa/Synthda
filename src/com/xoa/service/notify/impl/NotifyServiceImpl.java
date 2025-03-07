package com.xoa.service.notify.impl;

import com.xoa.dao.common.AppLogMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dao.notes.NotesMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UserPrivTypeMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.model.common.*;
import com.xoa.model.department.Department;
import com.xoa.model.notify.Notify;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.taskCenter.TaskCenter;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.service.ThreadSerivice.ThreadService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.notify.NotifyService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.taskCenter.impl.TaskCenterServiceImpl;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.InetAddress;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   张丽军
 * 创建日期:   2017-4-18 下午6:22:58
 * 类介绍  :   公告实现类(逻辑层)
 * 构造参数:   无
 */
@SuppressWarnings("all")
@Service
public class NotifyServiceImpl implements NotifyService {

    public static String notifyChageId = "1";
    public static String notifyDatetime = "1970-01-01 08:00:00";

    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private NotifyMapper notifyMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private SmsMapper smsMapper;

    @Resource
    private SmsBodyMapper smsBodyMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private UsersService usersService;

    @Resource
    private UsersPrivService usersPrivService;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private UserPrivMapper userPrivMapper;

    @Resource
    private AppLogMapper appLogMapper;

    @Resource
    private SmsService smsService;

    @Autowired
    ThreadService threadService;

    @Resource
    private Sms2PrivService sms2PrivService;

    @Resource
    private NotesMapper notesMapper;

    @Autowired
    private AttachmentMapper attachmentMapper;

    @Autowired
    private SysParaMapper sysParaMapper;
    @Autowired
    private TaskCenterServiceImpl taskCenterService;
    @Resource
    private QywxService qywxService;
    @Resource
    private UserExtMapper userExtMapper;

    @Resource
    private UserPrivTypeMapper userPrivTypeMapper;

    @Resource
    private SyslogMapper syslogMapper;


    /*	*//**
     *
     * 创建作者:    高亚峰
     * 创建日期:   2017-5-22 下午11:59:41
     * 方法说明:   公告查询是否到了指定的置顶时间
     * @return
     *//*

	public boolean validateTime(Notify notify){
    boolean flag =false;
    //判断是否是置顶
    if(notify.getTop().equals("1")) {
    	//判断不是置顶
    	if(notify.getTopDays().intValue()>0){
			try {
				Date sendTime = notify.getSendTime();
				String strDate = DateFormatUtils.formatDate(sendTime);
				//有效时间的开始时间
				Integer beginDate = notify.getBeginDate();
				Date date =new Date();
				String now = DateFormatUtils.formatDate(date);
				//当前时间
				Integer nowDate = DateFormatUtils.getNowDateTime(now);
				//置顶天数
				Integer topDays = notify.getTopDays();
                 //有效时间比开始时间大
					int i =nowDate-beginDate;
					if( i / (24 * 60 * 60) >= topDays){
						notifyMapper.updateTop(notify);
					}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
    return flag;
	}*/

    /**
     * 创建作者:    高亚峰
     * 创建日期:   2017-5-22 下午11:59:41
     * 方法说明:   列表查询出以后显示出待生效状态
     *
     * @return
     */
    public Notify returnNotify(Notify notify) {
        try {
            //有效时间的开始时间
            Integer beginDate = notify.getBeginDate();
            Date date = new Date();
            String strDate1 = DateFormatUtils.formatDate(date);
            //当前时间
            Integer nowDate = DateFormatUtils.getNowDateTime(strDate1);
            if (nowDate - beginDate < 0) {
                notify.setPublish("4");
                notifyMapper.updateNotify(notify);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return notify;
    }

    /**
     * 创建作者:    高亚峰
     * 创建日期:   2017-5-22 下午11:59:41
     * 方法说明:   列表查询出以后显示出失效状态
     *
     * @return
     */
    public Notify returnAlreadyNotify(Notify notify) {
        try {
            //把生效中到期的改为失效
            Integer endTime = notify.getEndDate();
            if (endTime != null && endTime != 0) {
                //结束时间
                Date date = new Date();
                String strDate1 = DateFormatUtils.formatDate(date);
                //当前时间
                Integer nowDate = DateFormatUtils.getNowDateTime(strDate1);
                if (endTime - nowDate < 0) {
                    notify.setPublish("5");
                    notifyMapper.updateNotify(notify);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return notify;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-18 下午11:59:41
     * 方法介绍:   查询公告信息
     * 参数说明:   @param maps  map条件参数
     * 参数说明:   @param page  当前页
     * 参数说明:   @param pageSize  每页显示条数
     * 参数说明:   @param useFlag   是否开启分页插件
     * 参数说明:   @param name
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     *
     * @return List<Notify>
     */
    @Override
    public ToJson<Notify> selectNotify(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, Users users) throws Exception {
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        ToJson<Notify> json = new ToJson<Notify>();
     /*   PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);*/
        String typeIdStr = (String) maps.get("typeId");
        if (StringUtils.checkNull(typeIdStr)) {
            maps.put("typeId", null);
        }
        String changeId = (String) maps.get("changeId");
        if (StringUtils.checkNull(changeId)) {
            json.setFlag(1);
            json.setMsg("err");
            return json;
        } else {
            List<Notify> list = new ArrayList<Notify>();
            if (maps.get("fromId") != null) {
                if (!StringUtils.checkNull(maps.get("fromId").toString())) {
                    String fromIds = maps.get("fromId").toString();
                    String[] substring = fromIds.split(",");
                    maps.put("newStr", substring);
                    maps.remove("fromId");
                }
            }
            //角色或者辅助角色是OA管理员，可以查看所有人公告
            if (1 == users.getUserPriv() || (!StringUtils.checkNull(users.getUserPrivOther()) && Arrays.asList(users.getUserPrivOther().split(",")).contains("1"))) {
                   maps.put("top","1");
                   list = notifyMapper.selectNotify(maps);//遍历每一条公告
                   maps.remove("top");
            } else {
                // 获取当前用户，管理的分支机构（包含管理范围） 范围内的公告
                List<Department> departmentList = departmentService.getDepartmentByClassifyOrg1(users, false);
                if (!CollectionUtils.isEmpty(departmentList)) {
                    Set<Integer> deptIds = departmentList.stream().map(Department::getDeptId).collect(Collectors.toSet());
                    maps.put("deptIds", deptIds);
                    maps.put("top","1");
                    list = notifyMapper.selectNotify(maps);//遍历每一条公告
                    maps.remove("top");
                } else {
                    //查看自己的公告
                    maps.put("fromId", users.getUserId());
                    maps.put("top","1");
                    list = notifyMapper.selectNotify(maps);//遍历每一条公告
                    maps.remove("top");
                }
            }

            for(Notify notify :list){
                //new    Calendar对象，需要在对象了进行转换
                if (notify.getTop().equals("1")) {
                    if (notify.getTopDays() > 0) {
                        Calendar calendar = Calendar.getInstance();

                        calendar.setTime(notify.getSendTime()); //需要将date数据转移到Calender对象中操作
                        calendar.add(calendar.DATE, notify.getTopDays());//把日期往后增加n天.正数往后推,负数往前移动
                        Date date = calendar.getTime();   //这个时间就是日期往后推一天的结果
                        //获取当前时间
                        Date date1 = new Date();
                        if (date.getTime() < date1.getTime()) {
                            //取消置顶
                            notifyMapper.newUpdateTop(notify);
                        }
                    }
                }
            }
            PageParams pages = new PageParams();
            pages.setPageSize(pageSize);
            pages.setPage(page);
            pages.setUseFlag(useFlag);
            maps.put("page",pages);
            list = notifyMapper.selectNotify(maps);
            SysPara sysPara = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if ("1".equals(changeId)) {
                for (Notify notify1 : list) {
                    if ("1".equals(sysPara.getParaValue())) {
                    if (notify1.getContentSecrecy() != null) {
                        SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", notify1.getContentSecrecy());
                        if (sysCode != null) {
                            notify1.setContentSecrecy("【"+sysCode.getCodeName()+"】");
                        }else {
                            notify1.setContentSecrecy("");
                        }
                    }else {
                        notify1.setContentSecrecy("");
                    }
                }else {
                        notify1.setContentSecrecy("");
                    }

                    /*	boolean b = this.validateTime(notify1);*/
                    if (notify1.getPublish().equals("1")) {
                        this.returnAlreadyNotify(notify1);
                        this.returnNotify(notify1);
                    }
                    notify1.setNotifyDateTime(DateFormatUtils.formatDate(notify1.getSendTime()));
                    if (notify1.getBeginDate() != null && !"".equals(notify1.getBeginDate())) {
                        if (!notifyDatetime.equals(DateFormat.getStrTime(notify1.getBeginDate()))) {
                            notify1.setBegin(DateFormat.getStrTime(notify1.getBeginDate()));
                        } else {
                            notify1.setBegin("");
                        }
                    } else {
                        notify1.setBegin("");
                    }
                    if (notify1.getEndDate() != null && !"".equals(notify1.getEndDate())) {
                        if (!notifyDatetime.equals(DateFormat.getStrTime(notify1.getEndDate()))) {
                            notify1.setEnd(DateFormat.getStrTime(notify1.getEndDate()));
                        } else {
                            notify1.setEnd("");
                        }
                    } else {
                        notify1.setEnd("");
                    }


                    // 查询用户
                    notify1.setName(notify1.getUsers().getUserName());
                    if (notify1.getTypeId() != null && !notify1.getTypeId().equals("")) {
                        String name11 = sysCodeMapper.getNotifyNameByNo(notify1.getTypeId());
                        if (StringUtils.checkNull(name11)) {
                            notify1.setTypeName("");
                        } else {
                            notify1.setTypeName(name11);
                        }

                    } else {
                        notify1.setTypeName("");
                    }
                    //	notify1.setTypeName(notify1.getCodes().getCodeName());

					/*String depId = notify1.getToId();
                    if(!StringUtils.checkNull(depId)){
						String  depName= departmentService.getDeptNameByDeptId(depId,",");
						if(!"ALL_DEPT".trim().equals(notify1.getToId())){
							notify1.setDeprange(depName+",");
						}else{
							notify1.setDeprange(depName);
						}


					}

					String userId = notify1.getUserId();
					if(!StringUtils.checkNull(userId)){
						String  userName= usersService.getUserNameById(userId);
						notify1.setUserrange(userName+",");
					}

					String roleId = notify1.getPrivId();
					if(!StringUtils.checkNull(roleId)){
						String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
						notify1.setRolerange(roleName+",");
					}*/
                    // 已读未读
                    if (notify1.getReaders().indexOf(null != users.getUserId() ? users.getUserId() : "") != -1) {
                        notify1.setRead(1);
                    } else {
                        notify1.setRead(0);
                    }

                    //查询拟稿部门  可能为部门id 或 手写
                    if (!StringUtils.checkNull(notify1.getDraftDept())){
                        //Pattern pattern = Pattern.compile("^[0-9]*[1-9][0-9]*$");
                        String reg = "^\\d+$";
                        boolean matches = notify1.getDraftDept().matches(reg);
                        if (matches){
                            notify1.setDraftDeptName(departmentMapper.getDeptNameById(Integer.parseInt(notify1.getDraftDept())));
                        }else {
                            notify1.setDraftDeptName(notify1.getDraftDept());
                        }
                    }
                }
                json.setMsg("ok");
                json.setFlag(0);
//                json.setObj(useFlag ? getPageList(page,pageSize,list) : list);
                json.setObj(list);
                //如何map传入数组需要单独处理，总数没有
                int count = 0;
                if (pages.getTotal()!=null) {
                    json.setTotleNum(pages.getTotal());
                }else
                if (maps.get("newStr") != null) {
                    maps.remove("page");
                    count = notifyMapper.selectCountNumNotify(maps);//遍历每一条公告
                    json.setTotleNum(count);
                } else {
                    json.setTotleNum(list.size());
                }
            } else if ("2".equals(changeId)) {
                for (Notify notify1 : list) {
                    notifyMapper.deleteById(notify1.getNotifyId());
                }
                json.setMsg("ok");
                json.setFlag(0);
                json.setObject(list.size());

            }
        }


        return json;
    }
    //业务层分页 yyl
    public List getPageList(Integer page, Integer limit, List list) {
        if(page!=null&&limit!=null&&page>0&&limit>0){
            List list1 = new ArrayList();
            if (page == 1 && list.size() <= limit) {
                return list;
            } else if (page == 1 && list.size() > limit) {
                for (int i = 0; i < limit; i++) {
                    list1.add(list.get(i));
                }
                return list1;

            } else if (page > 1) {
                if (list.size() / limit >= page) {
                    for (int i = 0; i < limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));

                    }
                    return list1;
                } else {
                    for (int i = 0; i < list.size()%limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));
                    }
                }
                return list1;

            } else {
                return null;
            }
        }else{
            return list;
        }
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午12:03:54
     * 方法介绍:   未读信息
     * 参数说明:   @param maps
     * 参数说明:   @param page
     * 参数说明:   @param pageSize
     * 参数说明:   @param useFlag
     * 参数说明:   @param name
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     *
     * @return List<Notify>
     */

    @Override
    public ToJson<Notify> unreadNotify(Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag, String name, String sqlType) throws Exception {
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        ToJson<Notify> json = new ToJson<Notify>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        String typeIdStr = (String) maps.get("typeId");
        if (StringUtils.checkNull(typeIdStr)) {
            maps.put("typeId", null);
        }
        /*if("admin".equals(name)){
            maps.put("adminPermissions", "2");
		}else {
			maps.put("adminPermissions", "1");
		}*/
        //公告通知不区分管理员，只能按权限查看sql传入1
        maps.put("adminPermissions", "1");
        maps.put("name", name);

        // 辅助部门分割成字符串传入dao
        String deptIdOther = (String) maps.get("deptIdOther");
        if (!StringUtils.checkNull(deptIdOther)) {
            String[] deptIdOthers = deptIdOther.split(",");
            maps.put("deptIdOthers", deptIdOthers);
        }
        //辅助角色分割
        String userPrivOther = (String) maps.get("userPrivOther");
        if (!StringUtils.checkNull(userPrivOther)) {
            String[] PrivOthers = userPrivOther.split(",");
            maps.put("PrivOthers", PrivOthers);
        }
        //人员类型
        String userType = (String) maps.get("userType");
        if (!StringUtils.checkNull(userType)) {
            String[] PrivOthers = userType.split(",");
            maps.put("userType", userType);
        }
        List<Notify> list = notifyMapper.unreadNotify(maps);
        List<Notify> list1 = new ArrayList<Notify>();
        List<Notify> list2 = new ArrayList<Notify>();
        for (Notify notify : list) {

            /*	boolean b = this.validateTime(notify);*/
            //处理公告置顶
            if (notify.getTop().equals("1")) {
                if (notify.getTopDays() > 0) {
                    notifyMapper.newUpdateTop(notify);
                }
            }

            if (notify.getPublish().equals("1")) {
                this.returnAlreadyNotify(notify);
            }
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
            notify.setName(notify.getUsers().getUserName());
            if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (StringUtils.checkNull(name11)) {
                    notify.setTypeName("");
                } else {
                    notify.setTypeName(name11);
                }

            } else {
                notify.setTypeName("");
            }
            if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                    notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                } else {
                    notify.setBegin("");
                }
            } else {
                notify.setBegin("");
            }
            if (notify.getAttachmentName() != null && notify.getAttachmentId() != null) {
                notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_NEWS));
            }
            String depId = notify.getToId();
            if (!StringUtils.checkNull(depId)) {
                String depName = departmentService.getDeptNameByDeptId(depId, ",");
                if (!"ALL_DEPT".trim().equals(notify.getToId())) {
                    notify.setDeprange(depName + ",");
                } else {
                    notify.setDeprange(depName);
                }


            }

            String userId = notify.getUserId();
            if (!StringUtils.checkNull(userId)) {
                String userName = usersService.getUserNameById(userId);
                notify.setUserrange(userName + ",");
            }

            String roleId = notify.getPrivId();
            if (!StringUtils.checkNull(roleId)) {
                String roleName = usersPrivService.getPrivNameByPrivId(roleId, ",");
                notify.setRolerange(roleName + ",");
            }
            // 2020/5/27 之前规则有问题   indexof 131  如果数据库存有1131 就判断不进来
            // 已读未读  1 已读  0未读
            if (notify.getReaders().indexOf(","+name+",") != -1) {
                notify.setRead(1);
            } else {
                notify.setRead(0);
            }
        }

        json.setObj(list);
        json.setTotleNum(list.size());
        return json;
    }

    @Override
    public ToJson<Notify> unreadNotifyPlus(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType) throws Exception {
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        ToJson<Notify> json = new ToJson<Notify>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        String typeIdStr = (String) maps.get("typeId");
        if (StringUtils.checkNull(typeIdStr)) {
            maps.put("typeId", null);
        }
        /*if("admin".equals(name)){
            maps.put("adminPermissions", "2");
		}else {
			maps.put("adminPermissions", "1");
		}*/
        //公告通知不区分管理员，只能按权限查看sql传入1
        maps.put("adminPermissions", "1");
        maps.put("name", name);

        // 辅助部门分割成字符串传入dao
        String deptIdOther = (String) maps.get("deptIdOther");
        if (!StringUtils.checkNull(deptIdOther)) {
            String[] deptIdOthers = deptIdOther.split(",");
            maps.put("deptIdOthers", deptIdOthers);
        }
        //辅助角色分割
        String userPrivOther = (String) maps.get("userPrivOther");
        if (!StringUtils.checkNull(userPrivOther)) {
            String[] PrivOthers = userPrivOther.split(",");
            maps.put("PrivOthers", PrivOthers);
        }
        //人员类型
        String userType = (String) maps.get("userType");
        if (!StringUtils.checkNull(userType)) {
            String[] PrivOthers = userType.split(",");
            maps.put("userType", userType);
        }
        List<Notify> list = notifyMapper.unreadNotifyPlus(maps);
        List<Notify> list1 = new ArrayList<Notify>();
        List<Notify> list2 = new ArrayList<Notify>();
        for (Notify notify : list) {

            /*	boolean b = this.validateTime(notify);*/
            //处理公告置顶
            if (notify.getTop().equals("1")) {
                if (notify.getTopDays() > 0) {
                    notifyMapper.newUpdateTop(notify);
                }
            }

            if (notify.getPublish().equals("1")) {
                this.returnAlreadyNotify(notify);
            }
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));

            // 2020/5/27 之前规则有问题   indexof 131  如果数据库存有1131 就判断不进来
            // 已读未读  1 已读  0未读
            if (notify.getReaders().indexOf(","+name+",") != -1) {
                notify.setRead(1);
            } else {
                notify.setRead(0);
            }

        }

        json.setObj(list);
        json.setTotleNum(pageParams.getTotal());
        return json;
    }

    /**
     * 公告判断置顶并取消置顶时间已过的
     */
    @Override
    public void updateTop() {
        List<Notify> notifies = notifyMapper.selectTop();
        for (Notify notify:notifies){
            if (notify.getTopDays() != null){//置顶天数不为空
                long time = notify.getSendTime().getTime();//发布时间
                int topDays = notify.getTopDays();
                long oneDayTime=1000*60*60*24;
                long sss = time+topDays*oneDayTime;
                long ssss = System.currentTimeMillis();
                if (time+topDays*oneDayTime < System.currentTimeMillis()){
                    notifyMapper.updateTop(notify);
                }
            }
        }
    }

    /**
     * 发送事务提醒给所有未读人员
     * @param notifyId 公告id
     * @return
     */
    @Override
    public ToJson notifyUnAll(Integer notifyId, HttpServletRequest request) {
        ToJson notifyToJson = new ToJson();
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            I18nUtils.setLocale(locale);

            if(Objects.isNull(notifyId)){
                notifyToJson.setMsg(I18nUtils.getMessage("notice.th.parameterErrorIDNotNull"));
                return notifyToJson;
            }

            //根据公告id查询公告是否存在，公告标识是否为已发布
            Notify notify = notifyMapper.selectById(notifyId);
            if (Objects.isNull(notify) || !"1".equals(notify.getPublish())){
                notifyToJson.setMsg(I18nUtils.getMessage("notice.th.announcementNotFound"));
                return notifyToJson;
            }

            //查询未读人员
            Map<String, Object> maps = new HashMap<String, Object>();
            maps.put("notifyId", notifyId);
            List<Users> usersList = usersMapper.unreadConsultTheSituationNotify(maps);
            if(Objects.isNull(usersList) || usersList.size() == 0){
                notifyToJson.setMsg(I18nUtils.getMessage("notice.th.noUnreadPersonnel"));
                return notifyToJson;
            }

            //发送事务提醒（发送公告事务提醒公共方法不能指定发送给哪些用户，所以单独在方法中写）
            String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
            threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {

                    String toIds = usersList.stream().map(Users::getUserId).collect(Collectors.joining(","));

                    ContextHolder.setConsumerType("xoa"+sqlType);
                    SmsBody smsBody=new SmsBody();
                    smsBody.setFromId(notify.getFromId());
                    Integer sendTime=0;
                    if(notify.getSendTime()!=null){
                        try {
                            sendTime= DateFormatUtils.getNowDateTime(DateFormatUtils.formatDate(notify.getSendTime()));
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                    smsBody.setSendTime(sendTime);
                    SysCode sysCode=new SysCode();
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName("公告通知");
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName("Announcement notice");
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName("公告通知");
                    }
                    sysCode.setParentNo("SMS_REMIND");
                    if(!StringUtils.checkNull(notify.getAttachmentId())&&!StringUtils.checkNull(notify.getAttachmentName())){
                        smsBody.setIsAttach("1");
                    }
                    if(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode)!=null){
                        smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                    }
                    String title="";
                    // 检查人员类型
                    if (!StringUtils.checkNull(notify.getUserType())){
                        Map map = new HashMap();
                        map.put("userIds",toIds.split(","));
                        map.put("userType",notify.getUserType().split(","));
                        StringBuffer sb = new StringBuffer();
                        List<UserExt> userExts = null;
                        try {
                            userExts = userExtMapper.checkUser(map);
                        }catch (Exception e){
                            e.printStackTrace();
                        }

                        for (UserExt user : userExts){
                            sb.append(user.getUserId()+",");
                        }
                        toIds = sb.toString();
                    }
                    smsBody.setRemindUrl("/notice/detail?notifyId="+notify.getNotifyId());
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent("请查看公告通知！标题："+notify.getSubject());
                        title="您有新的公告通知";
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent("Please check the announcements and notices！Title："+notify.getSubject());
                        title="You have new announcements and notices";
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent("請查看公告通知！標題："+notify.getSubject());
                        title="您有新的公告通知";
                    }
                    String typeName="";
                    if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                        String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                        if (StringUtils.checkNull(name11)) {
                        } else {
                            typeName=name11;
                        }
                    }
                    smsBody.setEditFlag("1");
                    String context ="";
                    if(typeName.equals("")){
                        context=notify.getSubject();
                    }else {
                        context=typeName+":"+notify.getSubject();
                    }
                    smsService.saveSms(smsBody,toIds,"1","",title,context,sqlType);
                    qywxService.sendMsg(Arrays.asList(toIds.split(",")),title,context,"/ewx/noticeDetail?notifyId="+notify.getNotifyId(),false);
                }
            });

            notifyToJson.setMsg("success");
            notifyToJson.setFlag(0);

        }catch (Exception e){
            notifyToJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return notifyToJson;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午12:03:54
     * 方法介绍:   已读信息
     * 参数说明:   @param maps
     * 参数说明:   @param page
     * 参数说明:   @param pageSize
     * 参数说明:   @param useFlag
     * 参数说明:   @param name
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     *
     * @return List<Notify>
     */
    @Override
    public ToJson<Notify> readNotify(Map<String, Object> maps, Integer page,
                                     Integer pageSize, boolean useFlag, String name, String sqlType) throws Exception {
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        ToJson<Notify> json = new ToJson<Notify>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        String typeIdStr = (String) maps.get("typeId");
        if (StringUtils.checkNull(typeIdStr)) {
            maps.put("typeId", null);
        }
		/*if("admin".equals(name)){
			maps.put("adminPermissions", "2");
		}else {
			maps.put("adminPermissions", "1");
		}*/
        //公告通知不区分管理员，只能按权限查看sql传入1
        maps.put("adminPermissions", "1");
        maps.put("name", name);

        // 辅助部门分割成字符串传入dao
        String deptIdOther = (String) maps.get("deptIdOther");
        if (!StringUtils.checkNull(deptIdOther)) {
            String[] deptIdOthers = deptIdOther.split(",");
            maps.put("deptIdOthers", deptIdOthers);
        }

        //辅助角色分割
        String userPrivOther = (String) maps.get("userPrivOther");
        if (!StringUtils.checkNull(userPrivOther)) {
            String[] PrivOthers = userPrivOther.split(",");
            maps.put("PrivOthers", PrivOthers);
        }
        //人员类型
        String userType = (String) maps.get("userType");
        if (!StringUtils.checkNull(userType)) {
            String[] PrivOthers = userType.split(",");
            maps.put("userType", userType);
        }
        List<Notify> list = notifyMapper.readNotify(maps);
        List<Notify> list1 = new ArrayList<Notify>();
        List<Notify> list2 = new ArrayList<Notify>();
        List<Notify> list3 = new ArrayList<Notify>();
        for (Notify notify : list) {
            //处理公告置顶
            if (notify.getTop().equals("1")) {
                if (notify.getTopDays() > 0) {
                    notifyMapper.newUpdateTop(notify);
                }
            }
            /*	boolean b = this.validateTime(notify);*/
            if (notify.getPublish().equals("1")) {
                this.returnAlreadyNotify(notify);
            }

            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
            notify.setName(notify.getUsers().getUserName());
            if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (StringUtils.checkNull(name11)) {
                    notify.setTypeName("");
                } else {
                    notify.setTypeName(name11);
                }

            } else {
                notify.setTypeName("");
            }
            if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                    notify.setBegin(DateFormat.getStrTime(notify.getBeginDate()));
                } else {
                    notify.setBegin("");
                }
            } else {
                notify.setBegin("");
            }
            if (notify.getEndDate() != null && !"".equals(notify.getEndDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                    notify.setEnd(DateFormat.getStrTime(notify.getEndDate()));
                } else {
                    notify.setEnd("");
                }
            } else {
                notify.setEnd("");
            }

            if (notify.getAttachmentName() != null && notify.getAttachmentId() != null) {
                notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_NEWS));
            }
            String depId = notify.getToId();
            if (!StringUtils.checkNull(depId)) {
                String depName = departmentService.getDeptNameByDeptId(depId, ",");
                if (!"ALL_DEPT".trim().equals(notify.getToId())) {
                    notify.setDeprange(depName + ",");
                } else {
                    notify.setDeprange(depName);
                }


            }

            String userId = notify.getUserId();
            if (!StringUtils.checkNull(userId)) {
                String userName = usersService.getUserNameById(userId);
                notify.setUserrange(userName + ",");
            }

            String roleId = notify.getPrivId();
            if (!StringUtils.checkNull(roleId)) {
                String roleName = usersPrivService.getPrivNameByPrivId(roleId, ",");
                notify.setRolerange(roleName + ",");
            }
            // 已读未读
            if (notify.getReaders().indexOf(null != name ? name : "") != -1) {
                notify.setRead(1);
            } else {
                notify.setRead(0);
            }
        }

        json.setObj(list);
        json.setTotleNum(pageParams.getTotal());
        return json;

    }

    @Override
    public ToJson<Notify> readNotifyPlus(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType) throws Exception {
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;
        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        ToJson<Notify> json = new ToJson<Notify>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        String typeIdStr = (String) maps.get("typeId");
        if (StringUtils.checkNull(typeIdStr)) {
            maps.put("typeId", null);
        }
		/*if("admin".equals(name)){
			maps.put("adminPermissions", "2");
		}else {
			maps.put("adminPermissions", "1");
		}*/
        //公告通知不区分管理员，只能按权限查看sql传入1
        maps.put("adminPermissions", "1");
        maps.put("name", name);

        // 辅助部门分割成字符串传入dao
        String deptIdOther = (String) maps.get("deptIdOther");
        if (!StringUtils.checkNull(deptIdOther)) {
            String[] deptIdOthers = deptIdOther.split(",");
            maps.put("deptIdOthers", deptIdOthers);
        }

        //辅助角色分割
        String userPrivOther = (String) maps.get("userPrivOther");
        if (!StringUtils.checkNull(userPrivOther)) {
            String[] PrivOthers = userPrivOther.split(",");
            maps.put("PrivOthers", PrivOthers);
        }
        //人员类型
        String userType = (String) maps.get("userType");
        if (!StringUtils.checkNull(userType)) {
            String[] PrivOthers = userType.split(",");
            maps.put("userType", userType);
        }
        List<Notify> list = notifyMapper.readNotifyPlus(maps);
        List<Notify> list1 = new ArrayList<Notify>();
        List<Notify> list2 = new ArrayList<Notify>();
        List<Notify> list3 = new ArrayList<Notify>();
        for (Notify notify : list) {
            //处理公告置顶
            if (notify.getTop().equals("1")) {
                if (notify.getTopDays() > 0) {
                    notifyMapper.newUpdateTop(notify);
                }
            }
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));

            /*	boolean b = this.validateTime(notify);*/
            if (notify.getPublish().equals("1")) {
                this.returnAlreadyNotify(notify);
            }
            // 已读未读
            if (notify.getReaders().indexOf(null != name ? name : "") != -1) {
                notify.setRead(1);
            } else {
                notify.setRead(0);
            }
        }

        json.setObj(list);
        json.setTotleNum(pageParams.getTotal());
        return json;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:49:31
     * 方法介绍:   更新公告信息
     * 参数说明:   @param notify
     *
     * @return void
     */
    @Override

    public void updateNotify(Notify notify, String remind, String tuisong, HttpServletRequest request, String approve) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Map<String, Object> map = new HashedMap();//添加事务提醒
        map.put("notifyId", notify.getNotifyId());
        map.put("userId",user.getUserId());
        Notify notify1 = notifyMapper.detailedNotify(map);

        if (notify.getPublish() != null && !"".equals(notify.getPublish())) {
			/*if ("1".equals(notify.getPublish())||"3".equals(notify.getPublish())){
				Date date = new Date();
				//设置要获取到什么样的时间
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//获取String类型的时间
				String createdate = sdf.format(date);
				Date date1 = null;
				try {
					date1 = sdf.parse(createdate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				notify.setSendTime(date1);
			}*/

        }
        if (StringUtils.checkNull(notify.getAttachmentId()) && StringUtils.checkNull(notify.getAttachmentName())) {
            notify.setAttachmentId(notify1.getAttachmentId());
            notify.setAttachmentName(notify1.getAttachmentName());
        }
	/*	if("1".equals(notify.getPublish()) && !"1".equals(approve)){
			if(StringUtils.checkNull(notify.getSubject())){
				notify.setSubject("[无主题]");
			}
		}*/
        if ("1".equals(approve)) {//审批
            notify.setAuditDate(new Date());
            notifyMapper.updatePublish(notify);
            //取消审批提醒
            smsService.setSmsRead("1", "/notice/appprove?notifyId=" + notify.getNotifyId(), user);
            remind = "1";
            tuisong = "1";
			/*//审批通过后，添加发布提醒
			if("1".equals(notify.getPublish()) && "on".equals(notify1.getThingDefault())) {
				String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
				threadService.addNotify(notify1, remind, tuisong, sqlType, "1", locale);
			}*/
            //消除任务中心待办数据，更改已办。
            TaskCenter taskCenter = new TaskCenter(notify1.getNotifyId(), user.getUserId(), "/notice/appprove?notifyId=" + notify.getNotifyId());
            taskCenterService.finishTaskCenter(taskCenter, TaskCenterConstant.notifyApproval);
            String[] a = null;
            if(!StringUtils.checkNull(notify.getHowRenind())){
                a = notify.getHowRenind().split(",");
                for(String str : a){
                    if("1".equals(str)){   //短信发送
                        Notify notify2 = notifyMapper.getNotifyByNotifyId(notify.getNotifyId());
                        threadService.addNotifyMessageSendering(notify2, request);
                    }
                }
            }
            if ("1".equals(notify.getPublish())) {
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                threadService.addNotify(notify1, remind, tuisong, sqlType, "1", locale);
            }

            //增加系统日志
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                try {
                    Syslog syslog = new Syslog();
                    syslog.setUserId(user.getUserId());
                    syslog.setType(58);
                    syslog.setTime(new Date());
                    // 设置ip
                    syslog.setIp(IpAddr.getIpAddress(request));
                    SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", notify1.getContentSecrecy());
                    String operationTypeStr;
                    if (locale.equals("zh_CN")) {
                        syslog.setTypeName("内容发布审批");
                        syslog.setRemark("审批结果：" + ("1".equals(notify.getPublish())? "通过":"未通过") + "，审批操作类型：新建" + "，审批用户："+user.getUserName()
                                + "，审批内容模块：公告通知" + "，审批内容标题：" + notify1.getSubject() + "，审批内容密级：" + sysCode.getCodeName() + "，审批模块主表：notify"  + "，审批主表记录" + notify1.getNotifyId());
                    } else if (locale.equals("en_US")) {
                        syslog.setTypeName("Content Release Approval");
                        syslog.setRemark("Approval result：" + ("1".equals(notify.getPublish())? "Approve":"Not approved") + "，Approval operation type: New creation" + "，Approval User："+user.getUserName()
                                + "，Approval content module: Announcement and Notice" + "，Approval Content Title：" + notify1.getSubject() + "，Confidentiality level of the approval content：" +
                                sysCode.getCodeName() + "，Main Table of the Approval Module：notify"  + "，Approval Main Table Record" + notify1.getNotifyId());
                    } else if (locale.equals("zh_TW")) {
                        syslog.setTypeName("內容發佈審批");
                        syslog.setRemark("審批結果：" + ("1".equals(notify.getPublish())? "通過":"未通過") + "，審批操作類型：新建" + "，審批用戶："+user.getUserName()
                                + "，審批內容模塊：公告通知" + "，審批內容標題：" + notify1.getSubject() + "，審批內容密級：" + sysCode.getCodeName() + "，審批模塊主表：notify"  + "，審批主表記錄" + notify1.getNotifyId());
                    }
                    syslogMapper.save(syslog);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        } else {
            notifyMapper.updateNotify(notify);
            String visitUrl = "/notice/detail?notifyId=" + notify.getNotifyId();
            AppLogExample example = new AppLogExample();
            AppLogExample.Criteria criteria = example.createCriteria();

            Integer smsId = smsMapper.getSmsId(user.getUserId() + "", visitUrl);
            if (smsId != null) {
                criteria.andOppIdEqualTo(smsId + "");
                criteria.andUserIdEqualTo(user.getUid() + "");
                criteria.andModuleEqualTo("4");//module 4:公告模块

                AppLog appLog = new AppLog();
                List<AppLog> list = appLogMapper.selectByExample(example);
                String time = "";
                if (list != null && list.size() > 0) {
                    appLog = list.get(0);
                    appLogMapper.deleteByExample(example);
                }
            }
        }
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:49:31
     * 方法介绍:   更新公告信息
     * 参数说明:   @param notify
     *
     * @return void
     */
    @Override

    public void upNewdateNotify(Notify notify, String remind, String tuisong, HttpServletRequest request, String approve) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Map<String, Object> map = new HashedMap();//添加事务提醒
        map.put("notifyId", notify.getNotifyId());
        map.put("userId",user.getUserId());
        Notify notify1 = notifyMapper.detailedNotify(map);
        //时间不修改
	/*	if(notify.getPublish()!= null &&!"".equals(notify.getPublish())){
			if ("1".equals(notify.getPublish())||"3".equals(notify.getPublish())){
				Date date = new Date();
				//设置要获取到什么样的时间
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//获取String类型的时间
				String createdate = sdf.format(date);
				Date date1 = null;
				try {
					date1 = sdf.parse(createdate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				notify.setSendTime(date1);
			}

		}*/
        if (StringUtils.checkNull(notify.getAttachmentId()) && StringUtils.checkNull(notify.getAttachmentName())) {
            notify.setAttachmentId(notify1.getAttachmentId());
            notify.setAttachmentName(notify1.getAttachmentName());
        }
	/*	if("1".equals(notify.getPublish()) && !"1".equals(approve)){
			if(StringUtils.checkNull(notify.getSubject())){
				notify.setSubject("[无主题]");
			}
		}*/

        if ("1".equals(approve)) {//审批
            notifyMapper.updatePublish(notify);
            //取消审批提醒
            smsService.setSmsRead("1", "/notice/appprove?notifyId=" + notify.getNotifyId(), user);
            remind = "1";
            tuisong = "1";
			/*//审批通过后，添加发布提醒
			if("1".equals(notify.getPublish()) && "on".equals(notify1.getThingDefault())) {
				String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
				threadService.addNotify(notify1, remind, tuisong, sqlType, "1", locale);
			}*/
            if ("1".equals(notify.getPublish())) {
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                threadService.addNotify(notify1, remind, tuisong, sqlType, "1", locale);
            }

        } else {
            notifyMapper.newUpdateNotify(notify);
            //2是审批
            if ("2".equals(notify.getPublish())) {
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                if (!StringUtils.checkNull(notify.getApproveRemind()) && "1".equals(notify.getApproveRemind())) {
                    threadService.addNotify(notify1, tuisong, remind, sqlType, "2", locale);
                }
                //任务中心数据推送。
                TaskCenter taskCenter = new TaskCenter(notify1.getNotifyId(),notify1.getSubject(), notify1.getAuditer(), new Date(), null, "/notice/appprove?notifyId=" + notify.getNotifyId(),notify1.getFromId());
                taskCenterService.addTaskCenter(taskCenter, TaskCenterConstant.notifyApproval);
            }
            if(notify.getThingDefault()!=null){
                //为什么remind字段前端也不传过来，后台加上好了
                remind = "1";
                //不知道ThingDefault是什么字段，为啥前端ThingDefault传0后台用on判断，暂时改成0
                if ("1".equals(notify.getPublish())&&notify.getThingDefault().equals("0")) {
                    String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    threadService.addNotify(notify1, tuisong, remind, sqlType, "1", locale);
                }
            }else if ("1".equals(notify.getPublish())) {
                remind = "0";
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                threadService.addNotify(notify1, tuisong, remind, sqlType, "1", locale);
            }
        }
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:51:20
     * 方法介绍:   新增公告信息
     * 参数说明:   @param notify
     *
     * @return void
     */

    @Override
    public int addNotify(Notify notify, String remind, String tuisong, HttpServletRequest request,String approveRemind) {
        if(!StringUtils.checkNull(notify.getOpinUsers())){
            notify.setOpinUsers("");
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        int count = notifyMapper.addNotify(notify);
        if (count > 0) {
            if ("1".equals(notify.getPublish())) {
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                if (!StringUtils.checkNull(notify.getThingDefault()) && "on".equals(notify.getThingDefault())) {
                    threadService.addNotify(notify, tuisong, remind, sqlType, "1", locale);
                }
                //短信发送
                if (!StringUtils.checkNull(notify.getHowRenind())) {
                    String[] s = notify.getHowRenind().split(",");
                    for(String s1:s){
                        if("1".equals(s1)){
                            threadService.addNotifyMessageSendering(notify, request);
                        }else if("0".equals(s1)){
                            threadService.addNotify(notify, tuisong, "1", sqlType, "1", locale);
                        }
                    }
                }
            }
            if ("2".equals(notify.getPublish())) {
                String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                if (!StringUtils.checkNull(notify.getApproveRemind()) && "1".equals(notify.getApproveRemind())) {
                    threadService.addNotify(notify, tuisong, approveRemind, sqlType, "2", locale);
                }
                //任务中心数据推送。
                TaskCenter taskCenter = new TaskCenter(notify.getNotifyId(),notify.getSubject(), notify.getAuditer(), new Date(), null, "/notice/appprove?notifyId=" + notify.getNotifyId(),notify.getFromId());
                taskCenterService.addTaskCenter(taskCenter, TaskCenterConstant.notifyApproval);

            }

            //增加系统日志
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                try {
                    Syslog syslog = new Syslog();
                    syslog.setUserId(user.getUserId());
                    syslog.setType(57);
                    syslog.setTime(new Date());
                    // 设置ip
                    syslog.setIp(IpAddr.getIpAddress(request));
                    SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", notify.getContentSecrecy());
                    if (locale.equals("zh_CN")) {
                        syslog.setTypeName("提交内容发布审批");
                        syslog.setRemark("操作类型：新建" + "，提交用户："+user.getUserName() + "，内容模块：公告通知" +
                                "，内容标题：" + notify.getSubject() + "，内容密级：" + sysCode.getCodeName() + "，模块主表：notify" + "，主表记录" + notify.getNotifyId());
                    } else if (locale.equals("en_US")) {
                        syslog.setTypeName("Submit the content release for approval");
                        syslog.setRemark("Operation type: New creation" + "，Submitting User："+user.getUserName() + "，Content module: Announcement and Notice" +
                                "，Content Title：" + notify.getSubject() + "，Content confidentiality level：" + sysCode.getCodeName() + "，Module Main Table：notify" + "，Main Table Record" + notify.getNotifyId());
                    } else if (locale.equals("zh_TW")) {
                        syslog.setTypeName("提交內容發佈審批");
                        syslog.setRemark("操作類型：新建" + "，提交用戶："+user.getUserName() + "，內容模塊：公告通知" +
                                "，內容標題：" + notify.getSubject() + "，內容密級：" + sysCode.getCodeName() + "，模塊主表：notify" + "，主表記錄" + notify.getNotifyId());
                    }
                    syslogMapper.save(syslog);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }

        //run(notify,tuisong,remind);
        return count;

    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:51:50
     * 方法介绍:   根据ID查找公告详情
     * 参数说明:   @param maps
     * 参数说明:   @param page
     * 参数说明:   @param pageSize
     * 参数说明:   @param useFlag
     * 参数说明:   @param name
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     *
     * @return Notify
     */
    @Override
    public Notify queryById(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType, String changId) throws Exception {

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
        String userPrivOther = (String) maps.get("userPrivOther");
        if (!StringUtils.checkNull(userPrivOther)) {
            String[] userPrivOthers = userPrivOther.split(",");
            maps.put("userPrivOthers", userPrivOthers);
        }
        //人员类型
        String userType = (String) maps.get("userType");
        if (!StringUtils.checkNull(userType)) {
            String[] PrivOthers = userType.split(",");
            maps.put("userType", userType);
        }
        maps.put("notifyTime", DateFormat.getCurrentTime2());

        Notify notify = notifyMapper.detailedNotify(maps);
        if (notify != null) {
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
            notify.setName(notify.getUsers().getUserName());
            if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (StringUtils.checkNull(name11)) {
                    notify.setTypeName("");
                } else {
                    notify.setTypeName(name11);
                }

            } else {
                notify.setTypeName("");
            }

            if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                    notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                } else {
                    notify.setBegin("");
                }
            } else {
                notify.setBegin("");
            }
            if (notify.getEndDate() != null && !"".equals(notify.getEndDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                    notify.setEnd(DateFormat.getStrDateTime(notify.getEndDate()));
                } else {
                    notify.setEnd("");
                }
            } else {
                notify.setEnd("");
            }
            //notify.setUsers(null);
            if (notify.getAttachmentName() != null && notify.getAttachmentId() != null) {
                notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_NOTIFY));
            }

            StringBuffer s = new StringBuffer();
            StringBuffer s1 = new StringBuffer();
            StringBuffer s2 = new StringBuffer();


            String depId = notify.getToId();
            if (!StringUtils.checkNull(depId)) {
                String depName = departmentService.getDeptNameByDeptId(depId, ",");
                if (!"ALL_DEPT".trim().equals(notify.getToId())) {
                    notify.setDeprange(depName + ",");
                } else {
                    notify.setDeprange(depName);
                }


            }

            String userId = notify.getUserId();
            if (!StringUtils.checkNull(userId)) {
                String userName = usersService.getUserNameById(userId);
                notify.setUserrange(userName + ",");
            }

            String roleId = notify.getPrivId();
            if (!StringUtils.checkNull(roleId)) {
                String roleName = usersPrivService.getPrivNameByPrivId(roleId, ",");
                notify.setRolerange(roleName + ",");
            }
            if (!StringUtils.checkNull(notify.getAuditer())) {
                Users users = usersMapper.findUsersByuserId(notify.getAuditer());
                if (users != null) {
                    notify.setAuditerName(users.getUserName());
                }
            }
            //部门名称
            if (notify.getFromDept() != null) {
                Department department = departmentMapper.getDeptById(notify.getFromDept());
                if (department != null){
                    notify.setDepName(department.getDeptName());
                }else {
                    notify.setDepName("");
                }
            }


            if (!notifyChageId.equals(changId)) {
                if (notify.getReaders().indexOf(","+name+",") == -1) {
                    smsService.updatequerySmsByType("1", name, String.valueOf(notify.getNotifyId()));
                    StringBuffer str2 = new StringBuffer(notify.getReaders());
                    str2.append(name);
                    str2.append(",");
                    String str1 = str2.toString();
                    notify.setNotifyId(notify.getNotifyId());
                    if (StringUtils.checkNull(notify.getReaders())){
                        notify.setReaders(","+str1);
                    }else {
                        notify.setReaders(str1);
                    }
                    notifyMapper.updateReaders(notify);

                }
            }

            //查询拟稿部门  可能为部门id 或 手写
            if (!StringUtils.checkNull(notify.getDraftDept())){
                //Pattern pattern = Pattern.compile("^[0-9]*[1-9][0-9]*$");
                String reg = "^\\d+$";
                boolean matches = notify.getDraftDept().matches(reg);
                if (matches){
                    notify.setDraftDeptName(departmentMapper.getDeptNameById(Integer.parseInt(notify.getDraftDept())));
                }else {
                    notify.setDraftDeptName(notify.getDraftDept());
                }
            }
        }
        return notify;


    }

    @Override
    public ToJson<Notify> deleteByids(String[] newsId) {
        ToJson<Notify> notifyToJson = new ToJson<Notify>();
        if (newsId.length > 0) {

            notifyMapper.deleteByids(newsId);

        }
        notifyToJson.setFlag(0);
        notifyToJson.setMsg("ok");
        return notifyToJson;
    }

    /**
     * 已经不用了
     */
    @Override
    public void queryDeleteByStaleDated() {
        Map<String, Object> maps = new HashMap<String, Object>();
        List<Notify> notifyList = notifyMapper.selectNotify(maps);
        if (notifyList.size() > 0 && notifyList != null) {
            for (Notify notify : notifyList) {
                if (notify.getEndDate() != null && !"".equals(notify.getEndDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                        Date dt = new Date();
                        SimpleDateFormat matter1 = new SimpleDateFormat("yyyy-MM-dd");
                        String data = matter1.format(dt);
                        if (data.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                            notifyMapper.deleteById(notify.getNotifyId());

                        }

                    }
                }

            }
        }
    }

    @Override
    public ToJson<Notify> updateByids(String[] newsId, String top) {
        ToJson<Notify> notifyToJson = new ToJson<Notify>();
        if (StringUtils.checkNull(top)) {
            notifyToJson.setFlag(1);
            notifyToJson.setMsg(I18nUtils.getMessage("notice.th.valuePassingError"));
            return notifyToJson;
        }

        if (newsId.length > 0) {

            notifyMapper.updateByIds(top, newsId);
            notifyToJson.setFlag(0);
            notifyToJson.setMsg("ok");
        } else {
            notifyToJson.setFlag(1);
            notifyToJson.setMsg(I18nUtils.getMessage("notice.th.valuePassingError"));
        }

        return notifyToJson;
    }

    @Override
    public ToJson<Notify> ConsultTheSituationNotify(String newsId, HttpServletRequest request) {
        ToJson<Notify> NotifyToJson = new ToJson<Notify>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("notifyId", newsId);

        Notify notify = notifyMapper.detailedNotify(maps);
        if (notify != null) {
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
            notify.setName(notify.getUsers().getUserName());
        }

        List<Users> usersList = usersMapper.unreadConsultTheSituationNotify(maps);
        List<Users> usersList1 = usersMapper.readConsultTheSituationNotify(maps);

        // 增加辅助部门
        /*上分割线*/
        String[] toIdArray = notify.getToId().split(",");
        // 查辅助部门下的用户，作为之前的补充
        List<Users> appendedUsersList= new ArrayList<>();
        if(toIdArray.length>0 && !"".equals(toIdArray[0])){
            appendedUsersList = notesMapper.getUsersByAssistedDeptIds(toIdArray);
        }
        // 增加辅助角色
        String[] privIdArray = notify.getPrivId().split(",");
        // 查辅助角色下的用户，作为之前的补充
        List<Users> appendedUsersprivList = new ArrayList<>();
        if(privIdArray.length>0 && !"".equals(privIdArray[0])) {
            appendedUsersprivList = notesMapper.getUsersByAssistedPrivIds(privIdArray);
        }
        List<Users> appendedUnreadUsersList = new ArrayList<>();
        List<Users> appendedReadUsersList = new ArrayList<>();

        String readers = notify.getReaders();
        appendedUsersList.addAll(appendedUsersprivList);
        for (Users users : appendedUsersList){
            if (readers.contains(users.getUserId())) {
                appendedReadUsersList.add(users);
            } else {
                appendedUnreadUsersList.add(users);
            }
        }

        usersList.addAll(appendedUnreadUsersList);
        usersList1.addAll(appendedReadUsersList);

        // 主部门和辅助部门都包含某个用户的情况需要去重
        Set<Users> set = new TreeSet<>(new Comparator<Users>() {
            @Override
            public int compare(Users o1, Users o2) {
                return o1.getUid() - o2.getUid();
            }
        });
        set.addAll(usersList);
        usersList = new ArrayList<>(set);
        set.clear();
        set.addAll(usersList1);
        usersList1 = new ArrayList<>(set);
        /*下分割线*/

        List<Department> resultList = new ArrayList<Department>();
        // 获取当前用户，管理的分支机构（包含管理范围）
        List<Department> departmentList= departmentService.getDepartmentByClassifyOrg1(user, false);
        if (org.springframework.util.CollectionUtils.isEmpty(departmentList)) {
            departmentList=departmentMapper.getDatagrid();
        }
        // List<Department>  departmentList1=new ArrayList<>();
        for (Department department : departmentList) {
            StringBuffer stringBuffer = new StringBuffer();
            Integer deptId = department.getDeptId();
            for (Users users : usersList) {
                Integer usersDeptId = users.getDeptId();
                // 增加辅助部门
                String deptIdOther = users.getDeptIdOther();
                if (deptId.equals(usersDeptId)) {
                    stringBuffer.append(users.getUserName());
                    stringBuffer.append(",");
                }
            }
            department.setUnread(stringBuffer.toString());
            StringBuffer stringBuffer1 = new StringBuffer();
            for (Users users : usersList1) {
                Integer usersDeptId = users.getDeptId();
                // 增加辅助部门
                String deptIdOther = users.getDeptIdOther();
                if (deptId.equals(usersDeptId)) {
                    stringBuffer1.append(users.getUserName()).append(",");
                    //stringBuffer1.append(",");

                    //郭宇飞(审核后提交)

                    String visitUrl = "/notice/detail?notifyId=" + newsId;

                    AppLogExample example = new AppLogExample();
                    AppLogExample.Criteria criteria = example.createCriteria();
/*
                    Integer smsId = smsMapper.getSmsId(users.getUserId() + "", visitUrl);
                    if (smsId != null) {
                        criteria.andOppIdEqualTo(smsId + "");
                        criteria.andUserIdEqualTo(users.getUid() + "");
                        criteria.andModuleEqualTo("4");//module 4:公告模块

                        AppLog appLog = new AppLog();
                        List<AppLog> list = appLogMapper.selectByExample(example);
                        String time = "";
                        if (list != null && list.size() > 0) {
                            appLog = list.get(0);
                            //	time=appLog.getTime()+"";

                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            time = sdf.format(appLog.getTime());
                        }else{
                            SmsExample example1=new SmsExample();
                            SmsExample.Criteria criteria1 = example1.createCriteria();
                            criteria1.andSmsIdEqualTo(smsId);
                            List<Sms> sms = smsMapper.selectByExample(example1);
                            time=DateFormat.getStrTime(sms.get(0).getRemindTime());
                        }
                        //郭宇飞(审核后提交)

                        stringBuffer1.append("(" + time + "),");
                    }*/



       //             Integer smsId = smsMapper.getSmsId(users.getUserId() + "", visitUrl);
//                    if (smsId != null) {
                 //   criteria.andOppIdEqualTo(smsId + "");
                    criteria.andUserIdEqualTo(users.getUid() + "");
                    criteria.andModuleEqualTo("4");//module 4:公告模块

                    AppLog appLog = new AppLog();
                    appLog.setOppId(newsId);
                    appLog.setUserId(users.getUid()+"");
                    appLog.setModule(4+"");
                    List<AppLog> list = appLogMapper.selectAppLogByNotify(appLog);
                    String time = "";
                        if (list != null && list.size() > 0) {
                            appLog = list.get(0);
                            //	time=appLog.getTime()+"";
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            time = sdf.format(appLog.getTime());
                            stringBuffer1.append("(" + time + "),");
                        }
                    //郭宇飞(审核后提交)


                    //}

                }
            }
            department.setRead(stringBuffer1.toString());
        }

		/*for (Department department : departmentList) {
			if (department.getDeptParent() == 0) {//父级菜单开始添加
				resultList.add(department);
				if (ifChilds(departmentList, department.getDeptId())) {//存在子集
					List<Department> childs = new ArrayList<Department>();
					childs = getChildList(departmentList, department.getDeptId(), resultList);
					resultList.addAll(childs);
				}
			}

		}*/
        notify.setReadSize(usersList1.size());
        notify.setUnreadSize(usersList.size());
        notify.setDepartmentList(departmentList);
        NotifyToJson.setObject(notify);
        NotifyToJson.setFlag(0);
        NotifyToJson.setMsg("ok");
        return NotifyToJson;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:48:39
     * 方法介绍:   根据ID获取公告信息
     * 参数说明:   @param id
     * 参数说明:   @return
     *
     * @return List<Notify>
     */
    @Override
    public List<Notify> getNotifyById(String id) {
        return notifyMapper.getNotifyById(id);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:48:39
     * 方法介绍:   根据ID获取公告信息
     * 参数说明:   @param id
     * 参数说明:   @return
     *
     * @return List<Notify>
     */
    @Override
    public Notify getNotifyById(Integer id) {
        return notifyMapper.getNotifyById(id);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午11:51:31
     * 方法介绍:   删除公告信息
     * 参数说明:   @param notifyId
     *
     * @return void
     */
    @Override
    @Transactional
    public void delete(Integer notifyId) {

        notifyMapper.deleteById(notifyId);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 上午12:03:43
     * 方法介绍:   查询公告管理信息
     * 参数说明:   @param maps
     * 参数说明:   @param page
     * 参数说明:   @param pageSize
     * 参数说明:   @param useFlag
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     *
     * @return List<Notify>
     */
    @Override
    public ToJson<Notify> selectNotifyManage(Map<String, Object> maps,
                                             Integer page, Integer pageSize, boolean useFlag, String name, String sqlType) throws Exception {
        ToJson<Notify> json = new ToJson<Notify>();
        String[] strArray = null;
        String[] strArray1 = null;
        String[] strArray2 = null;

        StringBuffer s = new StringBuffer();
        StringBuffer s1 = new StringBuffer();
        StringBuffer s2 = new StringBuffer();
        try {
            PageParams pageParams = new PageParams();
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            maps.put("page", pageParams);
            String typeIdStr = (String) maps.get("typeId");
            if (StringUtils.checkNull(typeIdStr)) {
                maps.put("typeId", null);
            }
	/*if("admin".equals(name)){
			maps.put("adminPermissions", "2");
		}else {
			maps.put("adminPermissions", "1");
		}*/
            //公告通知不区分管理员，只能按权限查看sql传入1
            maps.put("adminPermissions", "1");
            maps.put("name", name);
            List<Notify> list1 = new ArrayList<Notify>();
            String newStr = new String();
            if (maps.get("fromId") != null) {
                if (!StringUtils.checkNull(maps.get("fromId").toString())) {
                    String fromIds = maps.get("fromId").toString();
                    String[] substring = fromIds.split(",");
                    maps.put("newStr", substring);
                }
            }

            // 辅助部门分割成字符串传入dao
            String deptIdOther = (String) maps.get("deptIdOther");
            if (!StringUtils.checkNull(deptIdOther)) {
                String[] deptIdOthers = deptIdOther.split(",");
                maps.put("deptIdOthers", deptIdOthers);
            }
            //辅助角色分割
            String userPrivOther = (String) maps.get("userPrivOther");
            if (!StringUtils.checkNull(userPrivOther)) {
                String[] PrivOthers = userPrivOther.split(",");
                maps.put("PrivOthers", PrivOthers);
            }
            //人员类型
            String userType = (String) maps.get("userType");
            if (!StringUtils.checkNull(userType)) {
                String[] PrivOthers = userType.split(",");
                maps.put("userType", userType);
            }
            List<Notify> list = notifyMapper.selectNotifyManage(maps);

            for (Notify notify : list) {


                /*	boolean b = this.validateTime(notify);*/
//处理公告置顶
                if (notify.getTop().equals("1")) {
                    if (notify.getTopDays() > 0) {
                        notifyMapper.newUpdateTop(notify);
                    }
                }
                if (notify.getPublish().equals("1")) {
                    this.returnAlreadyNotify(notify);
                }
                notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
                notify.setName(notify.getUsers().getUserName());
                if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                    String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                    if (StringUtils.checkNull(name11)) {
                        notify.setTypeName("");
                    } else {
                        notify.setTypeName(name11);
                    }

                } else {
                    notify.setTypeName("");
                }
                if (!StringUtils.checkNull(notify.getAttachmentName()) && !StringUtils.checkNull(notify.getAttachmentId())) {
                    notify.setAttachment(GetAttachmentListUtil.returnAttachment(notify.getAttachmentName(), notify.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_NOTIFY));
                }
                if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                        notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                    } else {
                        notify.setBegin("");
                    }
                } else {
                    notify.setBegin("");
                }
//				String depId = notify.getToId();
//				if(!StringUtils.checkNull(depId)){
//					String  depName= departmentService.getDeptNameByDeptId(depId,",");
//					if(!"ALL_DEPT".trim().equals(notify.getToId())){
//						notify.setDeprange(depName+",");
//					}else{
//						notify.setDeprange(depName);
//					}
//
//
//				}
//
//				String userId = notify.getUserId();
//				if(!StringUtils.checkNull(userId)){
//					String  userName= usersService.getUserNameById(userId);
//					notify.setUserrange(userName+",");
//				}
//
//				String roleId = notify.getPrivId();
//				if(!StringUtils.checkNull(roleId)){
//					String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
//					notify.setRolerange(roleName+",");
//				}
                if (notify.getReaders().indexOf(name) != -1) {
                    notify.setRead(1);
                } else {
                    notify.setRead(0);
                }

            }

            json.setObj(list);
            json.setTotleNum(pageParams.getTotal());
            //如何map传入数组需要单独处理，总数没有
            int count = 0;
            if (maps.get("newStr") != null) {
                maps.remove("page");
                count = notifyMapper.selectCountNotifyManage(maps);//遍历每一条公告
            } else {
                json.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;

    }

    /**
     * 判断是否存在子集
     */
    private static boolean ifChilds(List<Department> list, int deptId) {
        boolean flag = false;
        for (Department department : list) {
            if (department.getDeptParent() == deptId) {
                flag = true;
                break;
            }
        }
        return flag;
    }

    /**
     * 获取父id下的子集合
     */
    private static List<Department> getChildList(List<Department> list, int deptId, List<Department> reList) {
        for (Department department : list) {
            if (department.getDeptParent() == deptId) {//查询下级菜单
                List<Department> l = department.getChild();
                reList.add(department);
                if (ifChilds(list, department.getDeptId())) {
                    getChildList(list, department.getDeptId(), reList);
                }
            }
        }
        return reList;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-11 下午13:40:00
     * 方法介绍:   查询出发布公告的所有部门
     * 参数说明:   @param notify
     *
     * @return Department
     */
    public ToJson<Department> getNotifyGroupFromDept(HttpServletRequest request, Notify notify) {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            if (notify != null && notify.getSendTime() != null) {
                String datestr = DateFormat.getDatestr(notify.getSendTime());
                notify.setSendTimeStr(datestr);
            }
            Map<String, Object> map = new HashMap<>();
            map.put("notify", notify);
            List<Department> departments = departmentService.getDepartmentByClassifyOrg(users, true, true);
            if (!CollectionUtils.isEmpty(departments)) {
                Set<Integer> listDeptId = departments.stream().map(Department::getDeptId).collect(Collectors.toSet());
                map.put("deptIds", listDeptId);
            }
            List<Department> departmentList = notifyMapper.getNotifyGroupFromDept(map);
            for (Department department : departmentList) {
                notify.setFromDept(department.getDeptId());
                int count = notifyMapper.getCountByFromDept(notify);
                department.setCount(String.valueOf(count));
            }
            json.setObj(departmentList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("NotifyServiceImpl getNotifyGroupFromDept:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-11 下午13:48:00
     * 方法介绍:   根据发布公告的部门查询出该部门中发布公告的用户
     * 参数说明:   @param notify
     *
     * @return Notify
     */
    public ToJson<Notify> getNotifyByFromDept(Notify notify) {
        ToJson<Notify> json = new ToJson<Notify>(1, "error");
        try {
            List<Notify> notifyList = notifyMapper.getNotifyByFromDept(notify);
            for (Notify notify1 : notifyList) {
                notify1.setFromDeptStr(departmentMapper.getDeptNameByDeptId(notify1.getFromDept()));
                notify1.setFromIdStr(usersMapper.getUsernameByUserId(notify1.getFromId()));
                notify1.setResultCount(notifyMapper.getCountByFromIdAndDept(notify1));
            }
            json.setObj(notifyList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("NotifyServiceImpl getNotifyByFromDept:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-11 下午13:45:00
     * 方法介绍:   根据发布公告的部门和发布公告的用户查询出所发布的公告
     * 参数说明:   @param notify
     *
     * @return Notify
     */
    public ToJson<Notify> getNotifyByFromIdAndDept(HttpServletRequest request, Notify notify) {
        ToJson<Notify> json = new ToJson<Notify>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            List<Notify> notifyList = notifyMapper.getNotifyByFromIdAndDept(notify);
            for (Notify notify1 : notifyList) {
                StringBuffer toDeptStr = new StringBuffer();
                StringBuffer toPrivStr = new StringBuffer();
                StringBuffer toUserStr = new StringBuffer();
                if (notify1.getToId().equals("ALL_DEPT")) {
                    notify1.setToId(I18nUtils.getMessage("new.th.allDepartments"));
                }
                if (!StringUtils.checkNull(notify1.getToId()) && !notify1.getToId().equals("ALL_DEPT")) {
                    String[] deptArry = notify1.getToId().split(",");
                    for (String dept : deptArry) {
                        if (!StringUtils.checkNull(departmentMapper.getDeptNameByDeptId(Integer.valueOf(dept)))) {
                            toDeptStr.append(departmentMapper.getDeptNameByDeptId(Integer.valueOf(dept)) + ",");
                        }
                    }
                    notify1.setToId(toDeptStr.toString());
                }
                if (!StringUtils.checkNull(notify1.getPrivId())) {
                    String[] privArry = notify1.getPrivId().split(",");
                    for (String priv : privArry) {
                        if (!StringUtils.checkNull(userPrivMapper.getPrivNameByPrivId(Integer.valueOf(priv)))) {
                            toPrivStr.append(userPrivMapper.getPrivNameByPrivId(Integer.valueOf(priv)) + ",");
                        }
                    }
                    notify1.setPrivId(toPrivStr.toString());
                }
                if (!StringUtils.checkNull(notify1.getUserId())) {
                    String[] userArry = notify1.getUserId().split(",");
                    for (String user : userArry) {
                        if (usersMapper.findUsersByuserId(user) != null) {
                            if (!StringUtils.checkNull(usersMapper.findUsersByuserId(user).getUserName())) {
                                toUserStr.append(usersMapper.findUsersByuserId(user).getUserName() + ",");
                            }
                        }
                    }
                    notify1.setUserId(toUserStr.toString());
                }
                if (!StringUtils.checkNull(notify1.getTypeId())) {
                    notify1.setTypeId(sysCodeMapper.getNotifyNameByNo(notify1.getTypeId()));
                } else {
                    notify1.setTypeId("");
                }
                notify1.setFromIdStr(usersMapper.getUsernameByUserId(notify1.getFromId()));
                int notifyStatus = Integer.valueOf(notify1.getPublish());
                switch (notifyStatus) {
                    case 0:
                        notify1.setPublish(I18nUtils.getMessage("notice.th.unposted"));
                        break;
                    case 1:
                        notify1.setPublish(I18nUtils.getMessage("notice.th.posted"));
                        break;
                    case 2:
                        notify1.setPublish(I18nUtils.getMessage("meet.th.PendingApproval"));
                        break;
                    case 3:
                        notify1.setPublish(I18nUtils.getMessage("notice.th.notApproved"));
                        break;
                }
            }
            json.setObj(notifyList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("NotifyServiceImpl getNotifyByFromIdAndDept:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-11 下午13:45:00
     * 方法介绍:   根据公告id进行查询公告
     * 参数说明:   @param notifyId
     *
     * @return Notify
     */
    public ToJson<Notify> getNotifyByNotifyId(Integer notifyId) {
        ToJson<Notify> json = new ToJson<Notify>(1, "error");
        try {
            Notify notify = notifyMapper.getNotifyByNotifyId(notifyId);
            notify.setFromDeptStr(departmentMapper.getDeptNameByDeptId(notify.getFromDept()));
            notify.setFromIdStr(usersMapper.getUsernameByUserId(notify.getFromId()));
            notify.setTypeId(sysCodeMapper.getNotifyNameByNo(notify.getTypeId()));
            json.setObject(notify);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("NotifyServiceImpl getNotifyByNotifyId:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月12日 下午11:18:00
     * 方法介绍:   公告统计信息导出
     */
    public ToJson<Notify> outputNotify(int step, Notify notify, HttpServletRequest request, HttpServletResponse response) {
        ToJson<Notify> json = new ToJson<Notify>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        HSSFWorkbook workbook1 = new HSSFWorkbook();
        HSSFWorkbook workbook2 = new HSSFWorkbook();
        HSSFWorkbook workbook3 = new HSSFWorkbook();
        try {
            HSSFWorkbook workbook11 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("notice.th.announcementStatisticalInformation"), 9);
            switch (step) {
                case 1:
                    String[] secondTitles = {I18nUtils.getMessage("userManagement.th.department"), I18nUtils.getMessage("notice.th.PublicationQuantity")};
                    HSSFWorkbook workbook21 = ExcelUtil.makeSecondHead(workbook11, secondTitles);
                    Map<String, Object> map = new HashMap<>();
                    map.put("notify", notify);
                    List<Department> departments = departmentService.getDepartmentByClassifyOrg(users, true ,true);
                    if (!CollectionUtils.isEmpty(departments)) {
                        Set<Integer> listDeptId = departments.stream().map(Department::getDeptId).collect(Collectors.toSet());
                        map.put("deptIds", listDeptId);
                    }
                    List<Department> departmentList = notifyMapper.getNotifyGroupFromDept(map);
                    for (Department department : departmentList) {
                        notify.setFromDept(department.getDeptId());
                        int count = notifyMapper.getCountByFromDept(notify);
                        department.setCount(String.valueOf(count));
                    }

                    String[] beanProperty1 = {"deptName", "count"};
                    workbook1 = ExcelUtil.exportExcelData(workbook21, departmentList, beanProperty1);
                    break;
                case 2:
                    String[] secondTitles1 = {I18nUtils.getMessage("userManagement.th.department"),
                            I18nUtils.getMessage("userDetails.th.name"), I18nUtils.getMessage("notice.th.PublicationQuantity")};
                    HSSFWorkbook workbook22 = ExcelUtil.makeSecondHead(workbook11, secondTitles1);
                    List<Notify> notifyList = notifyMapper.getNotifyByFromDept(notify);
                    for (Notify notify1 : notifyList) {
                        notify1.setFromDeptStr(departmentMapper.getDeptNameByDeptId(notify1.getFromDept()));
                        notify1.setFromIdStr(usersMapper.getUsernameByUserId(notify1.getFromId()));
                        notify1.setResultCount(notifyMapper.getCountByFromIdAndDept(notify1));
                    }

                    String[] beanProperty2 = {"fromDeptStr", "fromIdStr", "resultCount"};
                    workbook2 = ExcelUtil.exportExcelData(workbook22, notifyList, beanProperty2);
                    break;
                case 3:
                    String[] secondTitles3 = {I18nUtils.getMessage("notice.th.publisher"), I18nUtils.getMessage("notice.th.type"),
                            I18nUtils.getMessage("notice.th.releasescope"), I18nUtils.getMessage("notice.th.title"),
                            I18nUtils.getMessage("notice.th.createTime"), I18nUtils.getMessage("notice.th.effectivedate"),
                            I18nUtils.getMessage("notice.th.endDate"), I18nUtils.getMessage("notice.th.state")};
                    HSSFWorkbook workbook23 = ExcelUtil.makeSecondHead(workbook11, secondTitles3);
                    StringBuffer toDeptStr = new StringBuffer();
                    StringBuffer toPrivStr = new StringBuffer();
                    StringBuffer toUserStr = new StringBuffer();
                    List<Notify> notifyList2 = notifyMapper.getNotifyByFromIdAndDept(notify);
                    for (Notify notify1 : notifyList2) {
                        if (notify1.getToId().equals("ALL_DEPT")) {
                            notify1.setToId(I18nUtils.getMessage("new.th.allDepartments"));
                        }
                        if (!StringUtils.checkNull(notify1.getToId())) {
                            String[] deptArry = notify1.getToId().split(",");
                            for (String dept : deptArry) {
                                if (!StringUtils.checkNull(departmentMapper.getDeptNameByDeptId(Integer.valueOf(dept)))) {
                                    toDeptStr.append(departmentMapper.getDeptNameByDeptId(Integer.valueOf(dept)) + ",");
                                }
                            }
                            notify1.setToId(toDeptStr.toString());
                        }
                        if (!StringUtils.checkNull(notify1.getPrivId())) {
                            String[] privArry = notify1.getPrivId().split(",");
                            for (String priv : privArry) {
                                if (!StringUtils.checkNull(userPrivMapper.getPrivNameByPrivId(Integer.valueOf(priv)))) {
                                    toPrivStr.append(userPrivMapper.getPrivNameByPrivId(Integer.valueOf(priv)) + ",");
                                }
                            }
                            notify1.setPrivId(toPrivStr.toString());
                        }
                        if (!StringUtils.checkNull(notify1.getUserId())) {
                            String[] userArry = notify1.getUserId().split(",");
                            for (String user : userArry) {
                                if (!StringUtils.checkNull(usersMapper.findUsersByuserId(user).getUserName())) {
                                    toUserStr.append(usersMapper.findUsersByuserId(user).getUserName() + ",");
                                }
                            }
                            notify1.setUserId(toUserStr.toString());
                        }
                        if (!StringUtils.checkNull(notify1.getTypeId())) {
                            notify1.setTypeId(sysCodeMapper.getNotifyNameByNo(notify1.getTypeId()));
                        } else {
                            notify1.setTypeId("");
                        }
                        notify1.setFromIdStr(usersMapper.getUsernameByUserId(notify1.getFromId()));
                        int notifyStatus = Integer.valueOf(notify1.getPublish());
                        switch (notifyStatus) {
                            case 0:
                                notify1.setPublish(I18nUtils.getMessage("notice.th.unposted"));
                                break;
                            case 1:
                                notify1.setPublish(I18nUtils.getMessage("notice.th.posted"));
                                break;
                            case 2:
                                notify1.setPublish(I18nUtils.getMessage("meet.th.PendingApproval"));
                                break;
                            case 3:
                                notify1.setPublish(I18nUtils.getMessage("notice.th.notApproved"));
                                break;
                        }


                        StringBuffer rangeStr = new StringBuffer();
                        if (!StringUtils.checkNull(toDeptStr.toString())) {
                            rangeStr.append(I18nUtils.getMessage("userManagement.th.department") + "：" + toDeptStr.toString() + "  ");
                        }
                        if (!StringUtils.checkNull(toPrivStr.toString())) {
                            rangeStr.append(I18nUtils.getMessage("userManagement.th.role") + "：" + toPrivStr.toString() + "  ");
                        }
                        if (!StringUtils.checkNull(toUserStr.toString())) {
                            rangeStr.append(I18nUtils.getMessage("diary.th.body") + "：" + toUserStr.toString() + "  ");
                        }
                        notify1.setRange(rangeStr.toString());
                    }
                    String[] beanProperty3 = {"fromIdStr", "typeId", "range", "subject", "sendTime", "beginDate", "endDate", "publish"};
                    workbook3 = ExcelUtil.exportExcelData(workbook23, notifyList2, beanProperty3);
                    break;
            }
            ServletOutputStream out = response.getOutputStream();

            String filename = I18nUtils.getMessage("notice.th.announcementStatisticalInformation") + ".xls"; //考虑多语言
            filename = FileUtils.encodeDownloadFilename(filename,
                    request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition",
                    "attachment;filename=" + filename);
            switch (step) {
                case 1:
                    workbook1.write(out);
                    break;
                case 2:
                    workbook2.write(out);
                    break;
                case 3:
                    workbook3.write(out);
                    break;
            }
            out.close();
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("NotifyServiceImpl outputNotify:" + e);
        }
        return json;
    }

    /**
     * @author:杨超
     * @函数说明：按照类型统计通知信息
     * @创建时间: 2017/08/15
     */
    public BaseWrapper selectByType() {
        BaseWrapper baseWrapper = new BaseWrapper();
        List<Notify> temp = notifyMapper.selectByType();
        HashMap<String, Integer> count = new HashMap<>();
        for (Notify n : temp) {
            String key = "其他";
            SysCode s = n.getCodes();
            if (s != null) {
                key = s.getCodeName();
            }
            if (count.containsKey(key)) {
                count.put(key, count.get(key) + 1);
            } else {
                count.put(key, 1);
            }
        }
        baseWrapper.setData(count);
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        return baseWrapper;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年3月15日 下午17:32:22
     * 方法介绍:   根据subject进行模糊查询公告通知信息
     * 参数说明:   @param subject
     * 参数说明:
     */
    @Override
    public ToJson<Notify> queryNotifyBySubject(String trim) {
        ToJson<Notify> json = new ToJson<Notify>();
        List<Notify> list = notifyMapper.queryNotifyBySubject(trim);

        for (Notify notify : list) {
            notify.setNotifyDateTime(DateFormat.getStrDate(notify.getSendTime()));
            notify.setName(notify.getUsers().getUserName());
            if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                if (StringUtils.checkNull(name11)) {
                    notify.setTypeName("");
                } else {
                    notify.setTypeName(name11);
                }

            } else {
                notify.setTypeName("");
            }

            if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                    notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                } else {
                    notify.setBegin("");
                }
            } else {
                notify.setBegin("");
            }
            String depId = notify.getToId();
            if (!StringUtils.checkNull(depId)) {
                String depName = departmentService.getDeptNameByDeptId(depId, ",");
                if (!"ALL_DEPT".trim().equals(notify.getToId())) {
                    notify.setDeprange(depName + ",");
                } else {
                    notify.setDeprange(depName);
                }


            }

            String userId = notify.getUserId();
            if (!StringUtils.checkNull(userId)) {
                String userName = usersService.getUserNameById(userId);
                notify.setUserrange(userName + ",");
            }

            String roleId = notify.getPrivId();
            if (!StringUtils.checkNull(roleId)) {
                String roleName = usersPrivService.getPrivNameByPrivId(roleId, ",");
                notify.setRolerange(roleName + ",");
            }

        }

        json.setObj(list);
        return json;

    }

    @Override
    public int saveApplog4Notify(AppLog appLog) {
        return appLogMapper.insertSelective(appLog);
    }

    @Override
    public ToJson updateTopstatus(Notify notify, HttpServletRequest request) {
        ToJson<Object> json = new ToJson<>(1, "err");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            if (notify.getPublish() != null && !"".equals(notify.getPublish())) {
                if ("1".equals(notify.getPublish())) {
                    Date date = new Date();
                    //设置要获取到什么样的时间
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    //获取String类型的时间
                    String createdate = sdf.format(date);
                    Date date1 = sdf.parse(createdate);
                    notify.setSendTime(date1);
                    notify.setBeginDate(DateFormat.getDateTime(createdate));
                    notifyMapper.updateNotifyStatus(notify);
                    Map<String, Object> map = new HashedMap();
                    map.put("notifyId", notify.getNotifyId());
                    Notify notify1 = notifyMapper.detailedNotify(map);
                    String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    threadService.addNotify(notify1, "1", "1", sqlType, "1", locale);
                } else {
                    notifyMapper.updateNotifyStatus(notify);
                }
                json.setFlag(0);
                json.setMsg("ok");

            }

        } catch (ParseException e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Notify> updateDate(HttpServletRequest request) {

        ToJson<Notify> json = new ToJson<>(1, "err");
        Notify notify = new Notify();
        try {
            List<Notify> list = notifyMapper.getAll();
            if(list!=null&&list.size()>0){
                for(int i=0;i<list.size();i++){
                    String content =list.get(i).getContent();

                   /* Pattern CRLF = Pattern.compile("(\r\n|\r|\n|\n\r)");
                    Matcher m = CRLF.matcher(content);*/
                    /* if (m.find()) {*/
                    //content = m.replaceAll("<br/>");
                    content = content.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
                    /*}*/
                    System.out.println(content);
                    notify.setNotifyId(list.get(i).getNotifyId());
                    notify.setContent(content);
                    notifyMapper.updateDate(notify);
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

    @Override
    public ToJson<Notify> selectNotifyOverTime(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, Integer name, String fromId) {

        ToJson<Notify> json = new ToJson<Notify>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);

        Date date11 = new Date();
        String beginDate =DateFormat.getStrDate(date11);
        Integer dateTime= DateFormat.getDateTime(beginDate);
        maps.put("beginDate",dateTime);

        List<Notify> list = new ArrayList<Notify>();
        if (maps.get("fromId") != null) {
            if (!StringUtils.checkNull(maps.get("fromId").toString())) {
                String fromIds = maps.get("fromId").toString();
                String[] substring = fromIds.split(",");
                maps.put("newStr", substring);
                maps.remove("fromId");
            }
        }
        if (1 == name) {
            list = notifyMapper.selectNotifyOverTime(maps);//遍历每一条公告
        } else {
            maps.put("fromId", fromId);
            list = notifyMapper.selectNotifyOverTime(maps);//遍历每一条公告
        }

        for(Notify notify :list){
            //new    Calendar对象，需要在对象了进行转换
            if (notify.getTop().equals("1")) {
                if (notify.getTopDays() > 0) {
                    Calendar calendar = Calendar.getInstance();

                    calendar.setTime(notify.getSendTime()); //需要将date数据转移到Calender对象中操作
                    calendar.add(calendar.DATE, notify.getTopDays());//把日期往后增加n天.正数往后推,负数往前移动
                    Date date = calendar.getTime();   //这个时间就是日期往后推一天的结果
                    //获取当前时间
                    Date date1 = new Date();
                    if (date.getTime() < date1.getTime()) {
                        //取消置顶
                        notifyMapper.newUpdateTop(notify);
                    }
                }
            }
        }
          try{
              for (Notify notify1 : list) {
                  notify1.setNotifyDateTime(DateFormatUtils.formatDate(notify1.getSendTime()));
                  if (notify1.getBeginDate() != null && !"".equals(notify1.getBeginDate())) {
                      if (!notifyDatetime.equals(DateFormat.getStrTime(notify1.getBeginDate()))) {
                          notify1.setBegin(DateFormat.getStrTime(notify1.getBeginDate()));
                      } else {
                          notify1.setBegin("");
                      }
                  } else {
                      notify1.setBegin("");
                  }
                  if (notify1.getEndDate() != null && !"".equals(notify1.getEndDate())) {
                      if (!notifyDatetime.equals(DateFormat.getStrTime(notify1.getEndDate()))) {
                          notify1.setEnd(DateFormat.getStrTime(notify1.getEndDate()));
                      } else {
                          notify1.setEnd("");
                      }
                  } else {
                      notify1.setEnd("");
                  }


                  // 查询用户
                  notify1.setName(notify1.getUsers().getUserName());
                  if (notify1.getTypeId() != null && !notify1.getTypeId().equals("")) {
                      String name11 = sysCodeMapper.getNotifyNameByNo(notify1.getTypeId());
                      if (StringUtils.checkNull(name11)) {
                          notify1.setTypeName("");
                      } else {
                          notify1.setTypeName(name11);
                      }

                  } else {
                      notify1.setTypeName("");
                  }

                  // 已读未读
                  if (notify1.getReaders().indexOf(null != fromId ? fromId : "") != -1) {
                      notify1.setRead(1);
                  } else {
                      notify1.setRead(0);
                  }
              }
              json.setMsg("ok");
              json.setFlag(0);
              json.setObj(list);
              //如何map传入数组需要单独处理，总数没有
              int count = 0;
              if (maps.get("newStr") != null) {
                  maps.remove("page");
                  count = notifyMapper.selectCountNumNotify(maps);//遍历每一条公告
                  json.setTotleNum(count);
              } else {
                  json.setTotleNum(pageParams.getTotal());
              }
          }catch (Exception e){
            json.setFlag(1);
            json.setMsg("err");
          }
        return json;
    }

    //公告一键已读
    @Override
    public ToJson readNotify(HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String name=user.getUserId();
        ToJson toJson = new ToJson();
        String[] notifyIds = request.getParameter("notifyIds").split(",");
        String changId = request.getParameter("changId");
        for (String notifyId:notifyIds) {
            if (!notifyChageId.equals(changId)) {
                Notify notify = notifyMapper.selectById(Integer.parseInt(notifyId));
                if (notify.getReaders().indexOf(","+name+",") == -1) {
                    smsService.updatequerySmsByType("1", name, String.valueOf(notify.getNotifyId()));
                    StringBuffer str2 = new StringBuffer(notify.getReaders());
                    str2.append(name);
                    str2.append(",");
                    String str1 = str2.toString();
                    notify.setNotifyId(notify.getNotifyId());
                    if (StringUtils.checkNull(notify.getReaders())){
                        notify.setReaders(","+str1);
                    }else {
                        notify.setReaders(str1);
                    }
                    notifyMapper.updateReaders(notify);
                }
            }
        }
        toJson.setFlag(0);
        return toJson;
    }

    //办公门户待批公告
    @Override
    public ToJson approveNotify(HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        ToJson json = new ToJson();
        //获取审批公告人员
        SysPara sysPara = sysParaMapper.querySysPara("NOTIFY_AUDITING_ALL");
        try {
            boolean flag = Arrays.asList(sysPara.getParaValue().split(",")).contains(user.getUserId());
            if (flag) {
                Map<String, Object> maps = new HashMap<String, Object>();
                PageParams pageParams = new PageParams();
                pageParams.setUseFlag(true);
                pageParams.setPage(1);
                pageParams.setPageSize(100);
                maps.put("page", pageParams);
                maps.put("typeId", "");
                maps.put("start", "");
                maps.put("size", "");
                maps.put("auditer", user.getUserId());
                List<Object> list = new ArrayList<Object>();
                //获取待批准数量
                List<Notify> notifyList = notifyMapper.selectPendingNotifyByTypeId(maps);
                json.setTotleNum(pageParams.getTotal());
                json.setObject(0);
            } else {
                json.setObject(1);
            }
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
        }
        return json;
    }
}