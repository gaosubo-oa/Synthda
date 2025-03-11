package com.xoa.service.voteTitle.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.voteItem.VoteItemMapper;
import com.xoa.dao.voteTitle.VoteTitleMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.model.voteItem.VoteItem;
import com.xoa.model.voteTitle.VoteTitle;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.service.voteTitle.IVoteTitleService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * <p>
 * 投票基本信息表 服务实现类
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-16
 */
@Service
public class VoteTitleServiceImpl extends ServiceImpl<VoteTitleMapper, VoteTitle> implements IVoteTitleService {

    @Resource
    VoteTitleMapper voteTitleMapper;

    @Autowired
    SysCodeMapper sysCodeMapper;

    @Autowired
    DepartmentService departmentService;

    @Autowired
    UsersMapper usersMapper;

    @Resource
    private SmsService smsService;

    @Autowired
    SmsMapper smsMapper;

    @Resource
    UsersPrivService usersPrivService;

    @Resource
    UsersService usersService;

    @Resource
    VoteItemMapper voteItemMapper;

    @Resource
    DepartmentMapper departmentMapper;


    @Override
    public ToJson<VoteTitle> getVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                              Integer pageSize, boolean useFlag) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            maps.put("page", pageParams);
            List<VoteTitle> list = new ArrayList<VoteTitle>();
            if (user.getUserPriv().intValue() == 1) {
                list = voteTitleMapper.getAdminVoteTitleList(maps);//获取管理员投票标题列表
                //单独处理下发布人与发布角色
                for (VoteTitle voteTitle1 : list) {
                    //获取信息
                    String formUsername = usersMapper.getUsernameByUserId(voteTitle1.getFromId());
                    voteTitle1.setUserName(formUsername);
                }
            } else {
                maps.put("userId", user.getUserId());
                                                                            //   ==
                if (voteTitle.getSendTime() == null || voteTitle.getSendTime().equals("") ) {
                    voteTitle.setSendTime(DateFormat.getCurrentTime());
                }                                                             //   ==
                if (voteTitle.getEndDate() == null || voteTitle.getEndDate() .equals("0000-00-00 00:00:00")) {
                    voteTitle.setEndDate(DateFormat.getCurrentTime());
                }
                list = voteTitleMapper.selectVoteTitleLists(maps);
            }

            //部门遍历，用逗号分割部门id,查出部门对应的部门名，在用逗号拼接起来。
            for (VoteTitle voteTitle1 : list) {
                List<Users> returnList = new ArrayList<>();
                //部门总人数
                if(("ALL_DEPT").equals(voteTitle1.getToId())){
                    //全体用户 131
                    List<Users> userIds = usersMapper.selectAllUsers();
                    returnList.addAll(userIds);
                }else if (!StringUtils.checkNull(voteTitle1.getToId())){
                    String[] split = voteTitle1.getToId().split(",");
                    String deptIds = new String();
                    for (String string:split){
                        deptIds = getChildList(Integer.parseInt(string),new StringBuffer());//查出所有部门及子部门id
                    }
                    List<Users> userIds = usersMapper.getUsersByDeptIds(deptIds.split(","));
                    returnList.addAll(userIds);
                }
                //角色人数
                if(!StringUtils.checkNull(voteTitle1.getPrivId())){
                    String[] split = voteTitle1.getPrivId().split(",");
                    for(String string:voteTitle1.getPrivId().split(",")){
                        Users target = new Users();
                        target.setUserPriv(Integer.valueOf(string));
                        List<Users> userIds = usersMapper.getUserByRoleId(target);
                        for(Users users:userIds){
                            if (!returnList.contains(users)) {
                                returnList.add(user);
                            }
                        }
                    }
                }
                //用户人数
                if(!StringUtils.checkNull(voteTitle1.getUserId())){
                    List<Users> userIds = usersMapper.getUserByUserIds(voteTitle1.getUserId().split(","));
                    for(Users users:userIds){
                        if (!returnList.contains(users)) {
                            returnList.add(users);
                        }
                    }
                }

                voteTitle1.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle1.getSendTime(), 0, voteTitle1.getSendTime().length() - 2));
                String s = voteTitle1.getEndDate();
                if (s != null) {
                    if (voteTitle1.getEndDate().toString() != null && voteTitle1.getEndDate().toString().length() > 0) {
                        voteTitle1.setEndDate(org.apache.commons.lang3.StringUtils.substring(voteTitle1.getEndDate(), 0, voteTitle1.getEndDate().length() - 2));
                    }
                }

                String depId = voteTitle1.getToId();
                if (!StringUtils.checkNull(depId)) {
                    String depName = departmentService.getDeptNameByDeptId(depId, ",");
                    if (!"ALL_DEPT".trim().equals(depId)) {
                        voteTitle1.setDeptName(depName + ",");
                    } else {
                        voteTitle1.setDeptName(depName);
                    }
                }//获取所有部门信息
                if (voteTitle1.getToId() != null) {
                    if (voteTitle1.getToId().split(",").length > 10) {
                        String indexStr = StringUtils.getIndexStr(voteTitle1.getToId(), ",", 10);
                        String toID = departmentService.getDeptNameByDeptId(indexStr, ",");
                        voteTitle1.setToDeptName(toID + "...");
                    } else {
                        String toID = departmentService.getDeptNameByDeptId(voteTitle1.getToId(), ",");
                        voteTitle1.setToDeptName(toID);
                    }
                }

                //获取所有角色信息
                if (voteTitle1.getPrivId() != null) {
                    if (voteTitle1.getPrivId().split(",").length > 10) {
                        String indexStr = StringUtils.getIndexStr(voteTitle1.getPrivId(), ",", 10);
                        String privId = usersPrivService.getPrivNameByPrivId(indexStr, ",");
                        voteTitle1.setToPrivName(privId + "...");
                    } else {
                        String privId = usersPrivService.getPrivNameByPrivId(voteTitle1.getPrivId(), ",");
                        voteTitle1.setToPrivName(privId);
                    }
                }
                if (voteTitle1.getUserId() != null) {
                    //获取所有用户信息
                    if (voteTitle1.getUserId().split(",").length > 10) {
                        String indexStr = StringUtils.getIndexStr(voteTitle1.getUserId(), ",", 10);
                        String userId = usersService.getUserNameById(indexStr, ",");
                        voteTitle1.setToUserName(userId + "...");
                    } else {
                        String userId = usersService.getUserNameById(voteTitle1.getUserId(), ",");
                        voteTitle1.setToUserName(userId);
                    }
                }

                //获取所有查看所有权限范围的角色
                if (voteTitle1.getViewResultPrivId() != null) {
                    if (voteTitle1.getViewResultPrivId().split(",").length > 10) {
                        String indexStr = StringUtils.getIndexStr(voteTitle1.getViewResultPrivId(), ",", 10);
                        String viewResultPrivId = usersPrivService.getPrivNameByPrivId(indexStr, ",");
                        voteTitle1.setViewResultPrivId(viewResultPrivId + "...");
                    } else {
                        String viewResultPrivId = usersPrivService.getPrivNameByPrivId(voteTitle1.getViewResultPrivId(), ",");
                        voteTitle1.setViewResultPrivId(viewResultPrivId);
                    }
                }
                if (voteTitle1.getFromId() != null) {
                    String username = usersMapper.getUsernameByUserId(voteTitle1.getFromId());
                    voteTitle1.setUserName(username);
                }

                //获取所有查看所有权限范围的用户
                if (voteTitle1.getViewResultUserId() != null) {
                    if (voteTitle1.getViewResultUserId().split(",").length > 10) {
                        String indexStr = StringUtils.getIndexStr(voteTitle1.getViewResultUserId(), ",", 10);
                        String viewResultUserId = usersService.getUserNameById(indexStr, ",");
                        voteTitle1.setViewResultUserId(viewResultUserId + "...");
                    } else {
                        String viewResultUserId = usersService.getUserNameById(voteTitle1.getViewResultUserId(), ",");
                        voteTitle1.setViewResultUserId(viewResultUserId);
                    }
                }


                //查询已投票人数
                List<VoteItem> voteItemList;

                //查询父投票有没有子投票
                // 1.如果有就判断子投票
                //2.没有就判断当前投票
                Integer voteId = voteTitle1.getVoteId();
                List<VoteTitle> voteTitleList = voteTitleMapper.selByParentId(voteId);
                //voteTitleList!=null&&(!voteTitleList.equals(""))
                int size = voteTitleList.size();
                if(size!=0) {
                    voteItemList = voteItemMapper.getVoteItemList(voteTitleList.get(0).getVoteId());
                }else {
                    voteItemList = voteItemMapper.getVoteItemList(voteTitle1.getVoteId());
                }

                List<String> voteUser = new ArrayList<>();
                for(VoteItem voteItem:voteItemList){
                    if(!StringUtils.checkNull(voteItem.getVoteUser())){
                        List<String> userList = Arrays.asList(voteItem.getVoteUser().split(","));
                        for(String string:userList){
                            if(!voteUser.contains(string)){ //将已投票的用户去重
                                voteUser.add(string);
                            }
                        }
                    }

                    String attachmentId   = voteItem.getAttachmentId();
                    String attachmentName = voteItem.getAttachmentName();
                    if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                        List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                        voteItem.setAttachmentList(atts);
                    }
                }

                Integer i = voteItemMapper.selVoteCountSum(voteTitle1.getVoteId());
                if (i == null) {
                    i = 0;
                }
                voteTitle1.setVoteCount(i);
                voteTitle1.setSum(returnList.size()-voteUser.size());//未投票总数
                voteTitle1.setCount(voteUser.size());//已投票总数

            }

            if (list != null) {
                toJson.setObj(list);
                toJson.setTotleNum(pageParams.getTotal());
                toJson.setMsg("ok");
            } else {
                toJson.setMsg("列表为空");
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl getVoteTitleList:" + e);
        }
        return toJson;
    }

    public ToJson getVoteTitleListOner(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        try {
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            maps.put("page", pageParams);
            //获取用户信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            user = usersMapper.getUsersByuserId(user.getUserId());
            List<VoteTitle> list = voteTitleMapper.getVoteTitleList(maps);
            //过滤数据
            for (int i = 0; i < list.size(); i++) {
                VoteTitle voteTitle1 = list.get(i);
                if (voteTitle1 != null) {
                    String toId = voteTitle1.getToId();
                    String privId = voteTitle1.getPrivId();
                    String userId = voteTitle1.getUserId();
                    String viewResultPrivId = voteTitle1.getViewResultPrivId();
                    String viewResultUserId = voteTitle1.getViewResultUserId();
                    String toIds[] = null, privIds[] = null, userIds[] = null, viewResultPrivIds[] = null, viewResultUserIds[] = null;
                    if (toId != null) {
                        toIds = toId.split(",");
                    }
                    if (privId != null) {
                        privIds = privId.split(",");
                    }
                    if (userId != null) {
                        userIds = userId.split(",");
                    }
                    if (viewResultPrivId != null) {
                        viewResultPrivIds = viewResultPrivId.split(",");
                    }
                    if (viewResultUserId != null) {
                        viewResultUserIds = viewResultUserId.split(",");
                    }
                    if (toIds != null) {
                        if (!(Arrays.asList(toIds).contains(user.getDeptId()))) {
                            if (privIds != null) {
                                if (!(Arrays.asList(privIds).contains(user.getUid()))) {
                                    if (userIds != null) {
                                        if (!(Arrays.asList(userIds).contains(user.getUserId()))) {
                                            if (viewResultPrivIds != null) {
                                                if (!(Arrays.asList(viewResultPrivIds).contains(user.getUid()))) {
                                                    if (viewResultUserIds != null) {
                                                        if (!(Arrays.asList(viewResultUserIds).contains(user.getUserId()))) {
                                                            list.remove(i);
                                                            continue;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else if (privIds != null) {
                        if (!(Arrays.asList(privIds).contains(user.getUid()))) {
                            if (userIds != null) {
                                if (!(Arrays.asList(userIds).contains(user.getUserId()))) {
                                    if (viewResultPrivIds != null) {
                                        if (!(Arrays.asList(viewResultPrivIds).contains(user.getUid()))) {
                                            if (viewResultUserIds != null) {
                                                if (!(Arrays.asList(viewResultUserIds).contains(user.getUserId()))) {
                                                    list.remove(i);
                                                    continue;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else if (userIds != null) {
                        if (!(Arrays.asList(userIds).contains(user.getUserId()))) {
                            if (viewResultPrivIds != null) {
                                if (!(Arrays.asList(viewResultPrivIds).contains(user.getUid()))) {
                                    if (viewResultUserIds != null) {
                                        if (!(Arrays.asList(viewResultUserIds).contains(user.getUserId()))) {
                                            list.remove(i);
                                            continue;
                                        }
                                    }
                                }
                            }
                        }
                    } else if (viewResultPrivIds != null) {
                        if (!(Arrays.asList(viewResultPrivIds).contains(user.getUid()))) {
                            if (viewResultUserIds != null) {
                                if (!(Arrays.asList(viewResultUserIds).contains(user.getUserId()))) {
                                    list.remove(i);
                                    continue;
                                }
                            }
                        }
                    } else if (viewResultUserIds != null) {
                        if (!(Arrays.asList(viewResultUserIds).contains(user.getUserId()))) {
                            list.remove(i);
                            continue;
                        }
                    }
                }
            }
            if (list.size() > 0) {
                json.setObj(list);
                json.setMsg("ok");
                json.setTotleNum(pageParams.getTotal());
                json.setFlag(0);
                return json;
            }
            json.setFlag(0);
            json.setMsg("err");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<VoteTitle> newVoteTitle(HttpServletRequest request, VoteTitle voteTitle) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            if (voteTitle.getParentId() == null) {
                voteTitle.setParentId(0);
            }
            if (StringUtils.checkNull(voteTitle.getBeginDate())) {
                voteTitle.setBeginDate(DateFormat.getCurrentTime2());
            }
            /*if(StringUtils.checkNull(voteTitle.getEndDate())){
                voteTitle.setEndDate(DateFormat.getCurrentTime2());
            }*/
            if (StringUtils.checkNull(voteTitle.getSendTime())) {
                voteTitle.setSendTime(DateFormat.getCurrentTime());
            }
            voteTitle.setFromId(users.getUserId());
            int a = voteTitleMapper.newVoteTitle(voteTitle);
            if (a > 0) {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("新建成功");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("New successfully");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("新建成功");
                }
                toJson.setObject(voteTitle.getVoteId());
                toJson.setFlag(0);
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("新建失败");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("New failed");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("新建失敗");
                }
                toJson.setFlag(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl newVoteTitle:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> updateVoteTitle(HttpServletRequest request, VoteTitle voteTitle) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        VoteTitle voteTitle1 = new VoteTitle();
//        获取投票人可能会写的填写原因
        String voteMsg = request.getParameter("voteMsg");
        SmsBody smsBody = new SmsBody();
        try {
            if (voteTitle.getParentId() == null) {
                voteTitle.setParentId(0);
            }
            if (voteTitle.getBeginDate() == null) {
                voteTitle.setBeginDate(DateFormat.getCurrentTime());
            }
            if ("2".equals(voteTitle.getPublish())) {
                voteTitle.setEndDate(DateFormat.getCurrentTime());
            }
            /*if(voteTitle.getEndDate()==null){
                voteTitle.setEndDate(DateFormat.getCurrentTime());
            }*/
            if ("1".equals(voteTitle.getPublish())) {
                voteTitle.setEndDate("0000-00-00 00:00:00");
            }
            if (voteTitle.getSendTime() == null) {
                voteTitle.setSendTime(DateFormat.getCurrentTime());
            }
            int a = voteTitleMapper.updateVoteTitle(voteTitle);
            if (a > 0) {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("修改成功");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Modify successfully");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("修改成功");
                }
                toJson.setFlag(0);
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("修改失败");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Modify failed");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("修改失敗");
                }
                toJson.setFlag(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl updateVoteTitle:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> getChildVoteList(HttpServletRequest request, VoteTitle voteTitle, Integer voteId) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            //根据voteId查询投票项目信息。
            VoteTitle voteTitle1 = this.getVoTitle(voteId);
            if (!StringUtils.checkNull(voteTitle1.getSendTime())) {
                voteTitle1.setSendTime(voteTitle1.getSendTime().substring(0, voteTitle1.getSendTime().length() - 2));
            }
            List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteId);
            for (VoteItem voteItem : voteItemList) {
                String attachmentId   = voteItem.getAttachmentId();
                String attachmentName = voteItem.getAttachmentName();
                if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                    voteItem.setAttachmentList(atts);
                }
            }
            voteTitle1.setVoteItemList(voteItemList);
            //根据voteId查询子投票信息
            List<VoteTitle> list = voteTitleMapper.getChildVoteList(voteId);
            if (list != null) {
                for (VoteTitle voteTitle2 : list) {
                    List<VoteItem> voteItemList1 = voteItemMapper.getVoteItemList(voteTitle2.getVoteId());
                    for (VoteItem voteItem : voteItemList1) {
                        String attachmentId   = voteItem.getAttachmentId();
                        String attachmentName = voteItem.getAttachmentName();
                        if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                            List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                            voteItem.setAttachmentList(atts);
                        }
                    }
                    voteTitle2.setVoteItemList(voteItemList1);
                }
            }
            voteTitle1.setVoteTitleList(list);
            toJson.setFlag(0);
            toJson.setMsg("OK");
            toJson.setObject(voteTitle1);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
            L.e("VoteTitleServiceImpl getChildVoteList:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> addChildVoteTitle(HttpServletRequest request, VoteTitle voteTitle) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            voteTitle.setFromId(user.getUserId());
            voteTitle.setParentId(voteTitle.getVoteId());
            if (voteTitle.getBeginDate() == null) {
                voteTitle.setBeginDate(DateFormat.getCurrentTime());
            }
            if (voteTitle.getEndDate() == null) {
                voteTitle.setEndDate(DateFormat.getCurrentTime());
            }
            if (voteTitle.getSendTime() == null) {
                voteTitle.setSendTime(DateFormat.getCurrentTime());
            }
            int a = voteTitleMapper.newVoteTitle(voteTitle);
            if (a > 0) {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("新建子投票成功");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("The sub-vote has been successfully created");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("新建子投票成功");
                }
                toJson.setFlag(0);
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("新建子投票失败");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Failed to create a sub-vote");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("新建子投票失敗");
                }
                toJson.setFlag(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl addChildVoteTitle:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> getChilddetail(HttpServletRequest request, Integer voteId) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            VoteTitle voteTitle = voteTitleMapper.getChilddetail(voteId);
            voteTitle.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle.getSendTime(), 0, voteTitle.getSendTime().length() - 2));
            if (voteTitle.getEndDate() != null && voteTitle.getEndDate() != "") {
                voteTitle.setEndDate(org.apache.commons.lang3.StringUtils.substring(voteTitle.getEndDate(), 0, voteTitle.getEndDate().length() - 2));
            }
            voteTitle.setAttachment(GetAttachmentListUtil.returnAttachment(
                    voteTitle.getAttachmentName(), voteTitle.getAttachmentId(), sqlType,
                    "voteTitle"));
            //获取所有部门信息
            if (voteTitle != null) {
                String toID = departmentService.getDeptNameByDeptId(voteTitle.getToId(), ",");
                voteTitle.setToId(toID);
                //获取所有角色信息
                String privId = usersPrivService.getPrivNameByPrivId(voteTitle.getPrivId(), ",");
                voteTitle.setPrivId(privId);
                //获取所有用户信息
                String userId = usersService.getUserNameById(voteTitle.getUserId(), ",");
                voteTitle.setUsersName(userId);
                //获取所有查看所有权限范围的角色
                String viewResultPrivId = usersPrivService.getPrivNameByPrivId(voteTitle.getViewResultPrivId(), ",");
                voteTitle.setViewResultPrivId(viewResultPrivId);
                //获取所有查看所有权限范围的用户
                String viewResultUserId = usersService.getUserNameById(voteTitle.getViewResultUserId(), ",");
                voteTitle.setViewResultUserName(viewResultUserId);
            }
            if (voteTitle != null) {
                toJson.setObject(voteTitle);
                toJson.setMsg("ok");
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("投票信息为空");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("The voting information is empty");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("投票資訊為空");
                }
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl getChilddetail:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> deleteByVoteId(HttpServletRequest request, String[] voteIds) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            if (voteIds.length > 0) {
                voteTitleMapper.deleteByVoteId(voteIds);
                voteItemMapper.deleteByVoteId(voteIds);
                //删除事物提醒
                for (int i = 0; i < voteIds.length; i++) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    String remingUrl = "vote/manage/voteResult?resultId=" + voteIds[i] + "&type=0";
                    map.put("toId", user.getUserId());
                    map.put("smsType", 11);
                    map.put("remindUrl", remingUrl);
                    Integer bodyId = smsMapper.putStringOne(map);
                    if (bodyId != null) {
                        smsMapper.deleteOne(bodyId);
                        smsMapper.deleteOnet(bodyId);
                    }
                }
            }
            if (locale.equals("zh_CN")) {
                toJson.setMsg("删除成功");
            } else if (locale.equals("en_US")) {
                toJson.setMsg("Successfully deleted");
            } else if (locale.equals("zh_TW")) {
                toJson.setMsg("刪除成功");
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl deleteByVoteId:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> getVoteDataByVoteId(HttpServletRequest request, HttpServletResponse response, String export, Integer voteId) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        try {
            if (export == null) {
                export = "0";
            }
            //获取当前用户信息
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
            //根据voteId查询投票基本信息。
            List<VoteTitle> list1 = new ArrayList<>();
            VoteTitle voteTitle = voteTitleMapper.newGetChilddetail(voteId);
            if(Objects.isNull(voteTitle)){
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("未查询到投票");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("No voting information was found");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("未查詢到投票");
                }
                toJson.setFlag(0);
                return toJson;
            }

            //获取当前用户是否是投票创建人或系统管理员
            boolean viewResultFlag = false;
            if(user.getUserId().equals(voteTitle.getFromId()) || user.getUserPriv() == 1){
                viewResultFlag = true;
            }
            //获取有查看投票信息权限的角色和有查看投票信息权限的人员，判断是否包含当前用户的角色ID或用户ID
            if(!viewResultFlag && !StringUtils.checkNull(voteTitle.getViewResultPrivId())){
                viewResultFlag = Arrays.asList(voteTitle.getViewResultPrivId().split(",")).contains(user.getUserPriv().toString());
            }
            if(!viewResultFlag && !StringUtils.checkNull(voteTitle.getViewResultUserId())){
                viewResultFlag = Arrays.asList(voteTitle.getViewResultUserId().split(",")).contains(user.getUserId());
            }

            //没有查看投票信息权限
            if(!viewResultFlag){
                //判断当前用户是否已经投票，判断投票的查看投票结果选项(0-投票后允许查看,1-投票前允许查看,2-不允许查看)
                boolean isVoted = this.isVotite(voteTitle.getVoteId().toString(), user);
                //1.设置为0投票后允许查看&&用户未投票  2.设置为1投票前允许查看&&用户已投票  3.设置为2不允许查看  三种情况都只返回投票基本信息不查询投票结果选项
                if(("0".equals(voteTitle.getViewPriv()) && !isVoted) || ("1".equals(voteTitle.getViewPriv()) && isVoted) || "2".equals(voteTitle.getViewPriv())){
                    toJson.setObject(voteTitle);
                    toJson.setMsg("ok");
                    toJson.setFlag(0);
                    return toJson;
                }
            }


            if (voteTitle != null) {
                String toID = departmentService.getDeptNameByDeptId(voteTitle.getToId(), ",");
                voteTitle.setToId(toID);
                //获取所有角色信息
                String privId = usersPrivService.getPrivNameByPrivId(voteTitle.getPrivId(), ",");
                voteTitle.setPrivId(privId);
                //获取所有用户信息
                String userId = usersService.getUserNameById(voteTitle.getUserId(), ",");
                voteTitle.setUsersName(userId);
                //获取所有查看所有权限范围的角色
                String viewResultPrivId = usersPrivService.getPrivNameByPrivId(voteTitle.getViewResultPrivId(), ",");
                voteTitle.setViewResultPrivId(viewResultPrivId);
                //获取所有查看所有权限范围的用户
                String viewResultUserId = usersService.getUserNameById(voteTitle.getViewResultUserId(), ",");
                voteTitle.setViewResultUserName(viewResultUserId);
            }

            if (voteTitle.getFromId() != null) {
                Users users = usersMapper.getUsersByuserId(voteTitle.getFromId());
                voteTitle.setFromName(users.getUserName());
            }

            String s = voteTitle.getSubject();
            //根据voteId查询投票选项信息。
            List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteId);
            for (VoteItem voteItem : voteItemList) {
                String attachmentId   = voteItem.getAttachmentId();
                String attachmentName = voteItem.getAttachmentName();
                if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                    voteItem.setAttachmentList(atts);
                }
            }
            //获取投票总共投票数
            int countZ = this.count(voteItemList);
            voteTitle.setSum(countZ);
            voteTitle.setVoteItemList(voteItemList);

            for (VoteItem vot : voteItemList) {
                vot.setVoteUserName(vot.getAnonymous());
                VoteTitle v1 = new VoteTitle();
                String s1 = vot.getItemName();
                int s2 = vot.getVoteCount()==null?0:vot.getVoteCount();
                v1.setSubject(s);
                v1.setItemName(s1);
                v1.setVoteCount(s2);
                v1.setName(vot.getVoteUserName());
                list1.add(v1);
            }
            //根据voteId查询子投票信息
            List<VoteTitle> list = voteTitleMapper.getChildVoteList(voteId);
            for (VoteTitle voteTitle1 : list) {
                //根据voteId查询投票选项信息。
                List<VoteItem> voteItemList1 = voteItemMapper.getVoteItemList(voteTitle1.getVoteId());
                for (VoteItem voteItem : voteItemList1) {
                    String attachmentId   = voteItem.getAttachmentId();
                    String attachmentName = voteItem.getAttachmentName();
                    if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                        List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                        voteItem.setAttachmentList(atts);
                    }
                }
                //获取子投票总共投票数
                int countson = this.count(voteItemList1);
                voteTitle1.setSum(countson);
                voteTitle1.setVoteItemList(voteItemList1);
                for (VoteItem voteItem : voteItemList1) {
                    VoteTitle v2 = new VoteTitle();
                    String s1 = voteTitle1.getSubject();
                    v2.setItemName(voteItem.getItemName());
                    v2.setVoteCount(voteItem.getVoteCount());
                    v2.setSubject(s1);
//                    String name=voteItem.getVoteUser();
//                    if(name!=null&&!name.equals("")){
//                        String[] names=name.split(",");
//                        String nameValue="";
//                        for(String nameone: names){
//                            String namevalue=usersMapper.getUsernameByUserId(nameone);
//                            nameValue+=namevalue+",";
//                        }
//                        voteItem.setVoteUserName(nameValue);
//                    }
                    voteItem.setVoteUserName(voteItem.getAnonymous());
                    list1.add(v2);
                }
            }
            voteTitle.setVoteTitleList(list);
            toJson.setObject(voteTitle);
            toJson.setMsg("ok");
            toJson.setFlag(0);
            if (export.equals("1")) {
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("投票结果信息", 3);
                String[] secondTitles = {"投票名称", "投票项目名称", "投票数"};
                if (locale.equals("en_US")) {
                    workbook1 = ExcelUtil.makeExcelHead("Voting result information", 3);
                    secondTitles = new String[]{"Voting Name", "Name of Voting Item", "Number of votes"};
                } else if (locale.equals("zh_TW")) {
                    workbook1 = ExcelUtil.makeExcelHead("投票結果資訊", 3);
                    secondTitles = new String[]{"投票名稱", "投票項目名稱", "投票數"};
                }
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"subject", "itemName", "voteCount"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, list1, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "投票结果信息.xls";//考虑多语言
                if (locale.equals("en_US")) {
                    filename = "Voting result information.xls";
                } else if (locale.equals("zh_TW")) {
                    filename = "投票結果資訊.xls";
                }
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.flush();
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
            L.e("VoteTitleServiceImpl getVoteDataByVoteId:" + e);
        }
        return toJson;
    }

    /*@Override
    public ToJson<VoteTitleModel> getVoteDataByVoteId(HttpServletRequest request, HttpServletResponse response, String export, Integer voteId) {
        ToJson<VoteTitleModel> toJson=new ToJson<VoteTitleModel>(1,"error");
        try{
            if(export==null){
                export="0";
            }
            //根据voteId查询投票基本信息。
            VoteTitle voteTitle = voteTitleMapper.newGetChilddetail(voteId);
            VoteTitleModel voteTitleModel=null;
            voteTitleModel.setVoteName(voteTitle.getSubject());
            //根据voteId查询投票选项信息。
            List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteId);
            for(VoteItem voteItem:voteItemList){
                voteTitleModel.setOptionName(voteItem.getItemName());

            }
            //获取投票总共投票数
            int countZ =this.count(voteItemList);
            voteTitle.setSum(countZ);
            voteTitle.setVoteItemList(voteItemList);

            //根据voteId查询子投票信息
            List<VoteTitle> list = voteTitleMapper.getChildVoteList(voteId);
            for (VoteTitle voteTitle1 : list){
                //根据voteId查询投票选项信息。
                List<VoteItem> voteItemList1 = voteItemMapper.getVoteItemList(voteTitle1.getVoteId());
                //获取子投票总共投票数
                int countson =this.count(voteItemList1);
                voteTitle1.setSum(countson);
                voteTitle1.setVoteItemList(voteItemList1);
            }
            voteTitle.setVoteTitleList(list);
            toJson.setObject(voteTitle);
            toJson.setMsg("ok");
            toJson.setFlag(0);

            if(export.equals("1")){
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("投票结果信息", 3);
                String[] secondTitles = {"投票名称", "投票项目名称", "投票数"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"subject", "itemName", "voteCount"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "投票结果信息.xls";//考虑多语言
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.flush();
                out.close();
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
            L.e("VoteTitleServiceImpl getVoteDataByVoteId:"+e);
        }
        return toJson;
    }*/

    @Override
    public ToJson<VoteTitle> searchVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                                 Integer pageSize, boolean useFlag) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String userId = null;
        String userPriv = null;
        String deptId = null;
        String userPrivOther = null;
        if (user != null && user.getUserId() != null) {
            userId = user.getUserId() + "";
            userPriv = user.getUserPriv() + "";
            deptId = user.getDeptId() + "";
            if (!StringUtils.checkNull(user.getUserPrivOther())){
                userPrivOther = user.getUserPrivOther();
            }
            String deptIds = new String();
            Department department = departmentMapper.selectByDeptId(Integer.parseInt(deptId));
            while (department!=null){
                deptIds+=department.getDeptId()+",";
                department = departmentMapper.selectByDeptId(department.getDeptParent());
            }
            maps.put("deptIds", deptIds.split(","));
        }

        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("userId", userId);
        maps.put("userPriv", userPriv);
        maps.put("userPrivOther", userPrivOther);
        maps.put("bg",new Date());
        try {
//            在查询前先更新投票的状态
            List<VoteTitle> needUpdate = voteTitleMapper.getNeedUpdate();
            for (VoteTitle vote: needUpdate){
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                long l = sdf.parse(vote.getEndDate()).getTime() - (new Date()).getTime();
                if (l>0){
                    vote.setPublish("1");
                    voteTitleMapper.updateVoteTitle(vote);
                }else {
                    vote.setPublish("2");
                    voteTitleMapper.updateVoteTitle(vote);
                }

            }

            //获取所有投票信息
            List<VoteTitle> list = voteTitleMapper.searchVoteTitleList(maps);

            for (VoteTitle voteTitle2 : list) {
                List<Users> returnList = new ArrayList<>();
                //查询已投票 和未投票
                //部门总人数
                if(("ALL_DEPT").equals(voteTitle2.getToId())){
                    //全体用户
                    List<Users> userIds = usersMapper.selectAllUsers();
                    returnList.addAll(userIds);
                }else if (!StringUtils.checkNull(voteTitle2.getToId())){
                    String[] split = voteTitle2.getToId().split(",");
                    String deptIds = new String();
                    for (String string:split){
                        deptIds = getChildList(Integer.parseInt(string),new StringBuffer());//查出所有部门及子部门id
                    }
                    List<Users> userIds = usersMapper.getUsersByDeptIds(deptIds.split(","));
                    returnList.addAll(userIds);
                }
                //角色人数
                if(!StringUtils.checkNull(voteTitle2.getPrivId())){
                    for(String string:voteTitle2.getPrivId().split(",")){
                        Users target = new Users();
                        target.setUserPriv(Integer.valueOf(string));
                        List<Users> userIds = usersMapper.getUserByRoleId(target);
                        for(Users users:userIds){
                            if (!returnList.contains(users)) {
                                returnList.add(user);
                            }
                        }
                    }
                }

                //用户人数
                if(!StringUtils.checkNull(voteTitle2.getUserId())){
                    List<Users> userIds = usersMapper.getUserByUserIds(voteTitle2.getUserId().split(","));
                    for(Users users:userIds){
                        if (!returnList.contains(users)) {
                            returnList.add(users);
                        }
                    }
                }
                //查询已投票人数
                List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteTitle2.getVoteId());
                List<String> voteUser = new ArrayList<>();
                for(VoteItem voteItem:voteItemList){
                    if(!StringUtils.checkNull(voteItem.getVoteUser())){
                        List<String> userList = Arrays.asList(voteItem.getVoteUser().split(","));
                        for(String string:userList){
                            if(!voteUser.contains(string)){ //将已投票的用户去重
                                voteUser.add(string);
                            }
                        }
                    }
                }

                //如果为当前用户创建的 设置查看权限为true
                if (voteTitle2.getFromId().equals(user.getUserId())) {
                    voteTitle2.setRight(true);
                }
                boolean isVotitle = this.isVotite(String.valueOf(voteTitle2.getVoteId()), user);
                voteTitle2.setHave(isVotitle);
                voteTitle2.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle2.getSendTime(), 0, voteTitle2.getSendTime().length() - 10));

                Integer i = voteItemMapper.selVoteCountSum(voteTitle2.getVoteId());
                if (i == null) {
                    i = 0;
                }
                voteTitle2.setVoteCount(i);
                voteTitle2.setSum(returnList.size()-voteUser.size());//未投票总数
                voteTitle2.setCount(voteUser.size());//已投票总数
            }

            if (list != null) {
                toJson.setObj(list);
                maps.remove("page");
                toJson.setTotleNum(voteTitleMapper.searchVoteTitleListCount(maps));
                toJson.setMsg("ok");
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("投票为空");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("The vote is empty");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("投票為空");
                }
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl searchVoteTitleList:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> getVoteTitleCount(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                               Integer pageSize, boolean useFlag) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String userId = null;
        String userPriv = null;
        String deptId = null;
        if (user != null && user.getUserId() != null) {
            userId = user.getUserId() + "";
            userPriv = user.getUserPriv() + "";
            deptId = user.getDeptId() + "";
            String deptIds = new String();
            Department department = departmentMapper.selectByDeptId(Integer.parseInt(deptId));
           //循环获得上一级  分别获得他们的deptId
            while (department!=null){
                deptIds+=department.getDeptId()+",";
                department = departmentMapper.selectByDeptId(department.getDeptParent());
            }
            maps.put("deptIds", deptIds.split(","));
        }
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("userId", userId);
        maps.put("userPriv", userPriv);
        int getcount = 0;
        try {

            List<VoteTitle> list = voteTitleMapper.getVoteTitleCount(maps);
            if (list != null && list.size() > 0) {
                for (VoteTitle voteTitle2 : list) {
                    List<Users> returnList = new ArrayList<>();
                    //查询已投票 和未投票
                    //部门总人数
                    if(("ALL_DEPT").equals(voteTitle2.getToId())){
                        //全体用户
                        List<Users> userIds = usersMapper.selectAllUsers();
                        returnList.addAll(userIds);
                    }else if (!StringUtils.checkNull(voteTitle2.getToId())){
                        String[] split = voteTitle2.getToId().split(",");
                        String deptIds = new String();
                        for (String string:split){
                            deptIds = getChildList(Integer.parseInt(string),new StringBuffer());//查出所有部门及子部门id
                        }
                        List<Users> userIds = usersMapper.getUsersByDeptIds(deptIds.split(","));
                        returnList.addAll(userIds);
                    }
                    //角色人数
                    if(!StringUtils.checkNull(voteTitle2.getPrivId())){
                        for(String string:voteTitle2.getPrivId().split(",")){
                            Users target = new Users();
                            target.setUserPriv(Integer.valueOf(string));
                            List<Users> userIds = usersMapper.getUserByRoleId(target);
                            for(Users users:userIds){
                                if (!returnList.contains(users)) {
                                    returnList.add(user);
                                }
                            }
                        }
                    }

                    //用户人数
                    if(!StringUtils.checkNull(voteTitle2.getUserId())){
                        List<Users> userIds = usersMapper.getUserByUserIds(voteTitle2.getUserId().split(","));
                        for(Users users:userIds){
                            if (!returnList.contains(users)) {
                                returnList.add(users);
                            }
                        }
                    }
                    //查询已投票人数  vote_item
                    List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteTitle2.getVoteId());
                    List<String> voteUser = new ArrayList<>();
                    for(VoteItem voteItem:voteItemList){
                        if(!StringUtils.checkNull(voteItem.getVoteUser())){
                            List<String> userList = Arrays.asList(voteItem.getVoteUser().split(","));
                            for(String string:userList){
                                if(!voteUser.contains(string)){ //将已投票的用户去重
                                    voteUser.add(string);
                                }
                            }
                        }
                    }

                    //如果为当前用户创建的 设置查看权限为true
                    if (voteTitle2.getFromId().equals(user.getUserId())) {
                        voteTitle2.setRight(true);
                    }
                    voteTitle2.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle2.getSendTime(), 0, voteTitle2.getSendTime().length() - 10));

                    int rList = returnList.size();
                    int size = voteUser.size();

                    voteTitle2.setSum(returnList.size()-voteUser.size());//未投票总数\
                    //已经投票总数没有值
                    voteTitle2.setCount(voteUser.size());//已投票总数
                }
                getcount = voteTitleMapper.getcount2();
                toJson.setObj(list);
                toJson.setTotleNum(pageParams.getTotal());
                toJson.setMsg("ok");
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("数据为空");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("The data is empty");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("數據為空");
                }
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl getVoteTitleCount:" + e);
        }
        return toJson;
    }

    /**
     * 张丽军 2017-10-07
     *
     * @param checkString
     * @return
     */
    public String checkAll(String checkString) {
        StringBuffer sb = new StringBuffer("");
        Map<String, Object> mapParam = new HashMap<String, Object>();
        //"|"转义字符串  所以必须用\\进行转义 因为 而且取出数组长度不确定
        //String[] checkStrings=(checkString==null?"":checkString).split(",");
//        if(checkStrings.length==0){
//            return sb.toString();
//        }
        if (checkString != null) {

            String checkUserId = checkString.substring(0, checkString.length() == 0 ? 0 : (checkString.length() - 1));
            if (checkUserId != null && !"".equals(checkUserId)) {
                checkUserId = "'" + checkUserId.replace(",", "','") + "'";
                mapParam.put("checkUserId", checkUserId);
                List<String> listCheckVoteUser = usersMapper.getUserNames(mapParam);
                sb.append(this.getString(listCheckVoteUser));
            } else {
                sb.append("");
            }
        }
        return sb.toString();
    }

    public String getString(List<String> Strings) {
        StringBuffer sb = new StringBuffer("");
        for (String s : Strings) {
            sb.append(s);
            sb.append(",");
        }
        return sb.toString();
    }


    @Override
    public boolean isVotite(String voteId, Users users) {
        //获取所有的投票选项
        List<VoteItem> newlist = new ArrayList<VoteItem>();
        //判断投票前查看结果
        VoteTitle voteTitles = voteTitleMapper.newGetChilddetail(Integer.valueOf(voteId));
        if (voteTitles != null) {
            //   String newStr= new String();
            StringBuffer sb = new StringBuffer();
            //如果不在发布人员，就直接跳结果页面
            String fabuUser = "";
            //是否有全部部门
            boolean allDept = false;
            //部门下人员
            if (!StringUtils.checkNull(voteTitles.getToId())) {
                String[] str = voteTitles.getToId().split(",");
                for (String strs : str) {
                    if (strs.equals("ALL_DEPT")) {
                        allDept = true;
                        break;
                    }
                    List<Users> list = usersMapper.getUsersByDeptId(Integer.valueOf(strs));
                    for (Users user : list) {
                        fabuUser += user.getUserId() + ",";
                    }
                }
            }

            if (!allDept) {
                if (!StringUtils.checkNull(voteTitles.getUserId())) {
                    fabuUser += voteTitles.getUserId();
                }
                //角色下人员
                if (!StringUtils.checkNull(voteTitles.getPrivId())) {
                    String[] str = voteTitles.getPrivId().split(",");
                    for (String strs : str) {
                        List<Users> list = usersMapper.getUsersByUserPriv(strs);
                        for (Users user : list) {
                            fabuUser += user.getUserId() + ",";
                        }
                        //辅助角色
                        List<Users> list1 = usersMapper.getUsersByUSER_PRIV_OTHER(strs);
                        for (Users user : list1) {
                            fabuUser += user.getUserId() + ",";
                        }
                    }
                }
                if (!(fabuUser.contains(users.getUserId() + ","))) {
                    return true;
                }
            }
        }
        List<VoteTitle> childVoteList = voteTitleMapper.getChildVoteList(Integer.valueOf(voteId));
        for (VoteTitle voteTitle : childVoteList) {
            List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteTitle.getVoteId());
                for (VoteItem voteItem : voteItemList) {
                newlist.add(voteItem);
            }
        }
        List<VoteItem> list = voteItemMapper.getVoteItemList(Integer.parseInt(voteId));
        for (VoteItem voteItem : list) {
            newlist.add(voteItem);
        }
        if (newlist != null) {
            for (VoteItem voteItem : newlist) {
                if (!StringUtils.checkNull(voteItem.getVoteUser())) {
                    String[] userAll = voteItem.getVoteUser().split(",");
                    //判断该用户是否投票
                    if (Arrays.asList(userAll).contains(users.getUserId())) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    @Override
    public AjaxJson addVoteTitle(HttpServletRequest request, VoteTitle voteTitle, String options, Integer voteId, String userName) {
        AjaxJson ajaxJson = new AjaxJson();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        voteTitle = voteTitleMapper.getChilddetail(voteId);
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        if (!StringUtils.checkNull(voteTitle.getEndDate()) && DateFormat.getDateTime(voteTitle.getSendTime()) > DateFormat.getDateTime(voteTitle.getEndDate())) {
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(I18nUtils.getMessage("vote.th.theVotingDateDoesNotMatch"));
        } else if (!StringUtils.checkNull(voteTitle.getEndDate()) && DateFormat.getDateTime(DateFormat.getCurrentTime()) > DateFormat.getDateTime(voteTitle.getEndDate())) {
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(I18nUtils.getMessage("vote.th.theVotingDateHasPassed"));
        } else if (isVotite(String.valueOf(voteId), users)) {//已投过
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(I18nUtils.getMessage("vote.th.youHaveAlreadyVotedAndCannotVoteAgain"));
        } else {
            try {
                if ("1".equals(voteTitle.getType())) {
                    int i = options.split(",").length;
                    if (voteTitle.getMinNum() > 0 && voteTitle.getMinNum() > i) {
                        ajaxJson.setMsg(I18nUtils.getMessage("vote.th.votingItemsNotMetMinimumVotingItem"));
                        return ajaxJson;
                    }
                    if (voteTitle.getMinNum() > 0 && voteTitle.getMaxNum() < i) {
                        ajaxJson.setMsg(I18nUtils.getMessage("vote.th.votingItemsNotMetMaximumVotingItem"));
                        return ajaxJson;
                    }
                }
                String voteCon = request.getParameter("voteCon");
                if (voteCon != null && !voteCon.equals("")) {
                    String[] voteConArray = voteCon.split("\\|");
                    for (String vote : voteConArray) {
                        String[] voteArray = vote.split(",");
                        String key = voteArray[0];
                        VoteItem voteItem = new VoteItem();
                        voteItem.setVoteCount(0);
                        voteItem.setVoteId(Integer.parseInt(key));
                        if (voteArray.length > 1 ? true : false){
                            voteItem.setItemName(voteArray[1]); ;
                        }else {
                            voteItem.setItemName("");
                        }
                        voteItem.setVoteUser(users.getUserId());
                        if ("1".equals(voteTitle.getAnonymity()) && userName != null && !"".equals(userName.trim())) {
                            voteItem.setAnonymous("(" + I18nUtils.getMessage("vote.th.anonymous") + ")" + userName);
                        } else {
                            voteItem.setAnonymous(users.getUserName());
                        }
                        voteItemMapper.addVoteItem(voteItem);
                    }

                }
                //去重
                String[] itemIds =  StringUtils.getRemoveStr(options).split(",");
                String voteMsgs=null;
                String[] Msgs=null;
                if (!StringUtils.checkNull(request.getParameter("voteMsg"))){
                    voteMsgs = request.getParameter("voteMsg");
                    Msgs = voteMsgs.split("\\|");
                }

                for (int i = 0; i < itemIds.length; i++) {
                    VoteItem voteItem = voteItemMapper.getVoteItem(Integer.parseInt(itemIds[i]));
                    //        获取投票的原因
                    if(Msgs!=null){
                        for (String voteMsg :Msgs){
                            String[] split = voteMsg.split(",");
                            if (voteMsg!=null&& voteItem.getItemId().equals(Integer.valueOf(split[0]))){
                                if (split.length>1){
                                    voteItem.setVoteReason(voteItem.getVoteReason()==null ? split[1]+";" : voteItem.getVoteReason() + split[1]+";");
                                }
                                else voteItem.setVoteReason(voteItem.getVoteReason()==null ? "" : voteItem.getVoteReason() +" "+";");
                            }
                        }
                    }
                    if (voteItem.getVoteCount() != null) {
                        voteItem.setVoteCount(voteItem.getVoteCount() + 1);
                    } else {
                        voteItem.setVoteCount(1);
                    }
                    String userNames = "";
                    if ("1".equals(voteTitle.getAnonymity()) && userName != null && !"".equals(userName.trim())) {
                        userNames = "(" + I18nUtils.getMessage("vote.th.anonymous") + ")" + userName + ",";
                    } else {
                        userNames = users.getUserName() + ",";
                    }
                    if (StringUtils.checkNull(voteItem.getAnonymous())) {
                        voteItem.setAnonymous(userNames);
                    } else {
                        voteItem.setAnonymous(voteItem.getAnonymous() + userNames);
                    }
                    if (StringUtils.checkNull(voteItem.getVoteUser())) {
                        voteItem.setVoteUser(users.getUserId());
                    } else {
                        voteItem.setVoteUser(voteItem.getVoteUser() + "," + users.getUserId());
                    }
                    voteItemMapper.updateVote(voteItem);
                }
            } catch (Exception e) {
                e.printStackTrace();
                ajaxJson.setMsg(e.getMessage());
                ajaxJson.setFlag(false);
            }
            String remingUrl = "/vote/manage/voteResult?resultId=" + voteId + "&type=1";
            smsService.updatequerySmsByType("11", users.getUserId(), remingUrl);
            ajaxJson.setFlag(true);
            ajaxJson.setMsg("OK");
        }

        return ajaxJson;
    }


    @Override
    public AjaxJson statusUpdate(HttpServletRequest request, Integer voteId) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        SimpleDateFormat sdf1 = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss");
        AjaxJson ajaxJson = new AjaxJson();
        VoteTitle voteTitle1 = new VoteTitle();
        SmsBody smsBody = new SmsBody();
        try {
            //获取所有的投票选项
            List<VoteItem> list = voteItemMapper.getVoteItemList(voteId);

            //根据voteId查询子投票信息
            List<VoteTitle> list1 = voteTitleMapper.getChildVoteList(voteId);
            VoteTitle type = voteTitleMapper.getTextTypeList(voteId);
            if (list.size() == 0 && list1.size() == 0&&!type.getType().equals("2")) {
                ajaxJson.setFlag(false);
                ajaxJson.setObj(voteId);
                ajaxJson.setMsg("No voting items!");
            } else {
                VoteTitle voteTitle = voteTitleMapper.getChilddetail(voteId);
                if ("1".equals(voteTitle.getType()) && voteTitle.getMinNum() > 0 && voteTitle.getMinNum() > list.size()) {
                    ajaxJson.setFlag(false);
                    ajaxJson.setObj(voteId);
                    if (locale.equals("zh_CN")) {
                        ajaxJson.setMsg("最小投票项大于，投票项目数");
                    } else if (locale.equals("en_US")) {
                        ajaxJson.setMsg("The minimum number of voting items is greater than the number of voting items");
                    } else if (locale.equals("zh_TW")) {
                        ajaxJson.setMsg("最小投票項大於，投票項目數");
                    }
                }
                if (voteTitle.getParentId() == null) {
                    voteTitle.setParentId(0);
                }
                if (voteTitle.getBeginDate() == null) {
                    voteTitle.setBeginDate(DateFormat.getCurrentTime());
                }
                //voteTitle.setSendTime(sdf1.format(new Date()));
                voteTitle.setPublish("1");
                voteTitleMapper.updateVoteTitle(voteTitle);
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("OK!");
                //查询修改发布状态记录
                voteTitle1 = voteTitleMapper.voteSelectOne(voteTitle.getVoteId());
                if (voteTitle1 != null) {
                    //选择人员
                    String[] userIdList = null;
                    if (voteTitle1.getUserId() != null && voteTitle1.getUserId() != "") {
                        userIdList = voteTitle.getUserId().split(",");
                    }
                    List<String> userArray = new ArrayList();
                    if (userIdList != null) {
                        for (String userId : userIdList) {
                            userArray.add(userId);
                        }
                    }
                    //选择查看人员
                    String[] viewResultUserIdList = null;
                    if (voteTitle1.getViewResultUserId() != null && voteTitle1.getViewResultUserId() != "") {
                        viewResultUserIdList = voteTitle.getViewResultUserId().split(",");
                    }
                    if (viewResultUserIdList != null) {
                        for (String userId : viewResultUserIdList) {
                            userArray.add(userId);
                        }
                    }
                    //部门人员
                    List<Users> deptList = new ArrayList();
                    if (!StringUtils.checkNull(voteTitle1.getToId())) {
                        if ("ALL_DEPT".trim().equals(voteTitle1.getToId())) {
                            List<Department> deptListArr = departmentMapper.getAllDepartment();
                            StringBuffer stringBuffer = new StringBuffer();
                            for (Department department : deptListArr) {
                                stringBuffer.append(department.getDeptId());
                                stringBuffer.append(",");
                            }
                            deptList = usersService.getUserByDeptIds(stringBuffer.toString(), 1);
                        } else {
                            deptList = usersService.getUserByDeptIds(voteTitle1.getToId(), 5);
                        }


                    }
                    List<String> deptArray = new ArrayList();
                    for (Users users : deptList) {
                        deptArray.add(users.getUserId());
                    }
                    //角色人员
                    List<Users> privList = new ArrayList();
                    if (!StringUtils.checkNull(voteTitle1.getPrivId())) {
                        privList = usersService.getUserByDeptIds(voteTitle1.getPrivId(), 6);
                    }
                    List<String> privArray = new ArrayList();
                    for (Users users : privList) {
                        privArray.add(users.getUserId());
                    }
                    //删除重复的数据
                    if (userArray != null) {
                        for (String userId : userArray) {
                            int f1 = 0;
                            for (String deptUser : deptArray) {
                                if (userId.equals(deptUser)) {
                                    f1 = 1;
                                    break;
                                }
                            }
                            if (f1 == 0) {
                                deptArray.add(userId);
                            }
                        }
                    }
                    for (String temp1 : deptArray) {
                        int f2 = 0;
                        for (String privUser : privArray) {
                            if (temp1.equals(privUser)) {
                                f2 = 1;
                                break;
                            }
                        }
                        if (f2 == 0) {
                            privArray.add(temp1);
                        }
                    }
                    StringBuffer userStr = new StringBuffer();
                    for (String tempUser : privArray) {
                        Map map = new HashMap();
                        map.put("readers", tempUser);
                        map.put("voteId", voteTitle.getVoteId());
                        VoteTitle voteTitle2 = voteTitleMapper.slectUserTd(map);
                        if (voteTitle2 == null) {
                            userStr.append(tempUser + ",");
                        }
                    }
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
                    Date date = sdf.parse(voteTitle1.getSendTime().substring(0, voteTitle1.getSendTime().length() - 2));
                    smsBody.setFromId(voteTitle1.getFromId());
                    smsBody.setContent(voteTitle1.getSubject());
                    smsBody.setSendTime((int) (date.getTime() / 1000));
                    SysCode sysCode = new SysCode();
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName("投票");
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName("vote");
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName("投票");
                    }
                    sysCode.setParentNo("SMS_REMIND");
                    if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                        smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                    }
                    String[] array = userStr.toString().split(",");
                    Set<String> set = new HashSet<>();
                    for (int i = 0; i < array.length; i++) {
                        set.add(array[i]);
                    }
                    String[] arrayResult = (String[]) set.toArray(new String[set.size()]);
                    StringBuffer sb = new StringBuffer();
                    for (int i = 0; i < arrayResult.length; i++) {
                        sb.append(arrayResult[i]);
                        sb.append(",");
                    }
                    String s = sb.toString();
                    smsBody.setRemindUrl("/vote/manage/voteResult?resultId=" + voteTitle1.getVoteId() + "&type=1");
                    smsBody.setSmsType("11");
                    String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    if (locale.equals("zh_CN")) {
                        smsService.saveSms(smsBody, s, "1", "2", "请查看投票！", voteTitle1.getSubject(), sqlType);
                    } else if (locale.equals("en_US")) {
                        smsService.saveSms(smsBody, s, "1", "2", "Please check the vote！", voteTitle1.getSubject(), sqlType);
                    } else if (locale.equals("zh_TW")) {
                        smsService.saveSms(smsBody, s, "1", "2", "請查看投票！", voteTitle1.getSubject(), sqlType);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setFlag(false);
            ajaxJson.setMsg("false");
        }
        return ajaxJson;
    }

    @Override
    public ToJson<VoteTitle> getOptionVoteList(HttpServletRequest request, VoteTitle voteTitle, Integer voteId) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {//当没有子投票时，直接获取主投票的选项
            List<VoteTitle> list = voteTitleMapper.getVoteDataByVoteId(voteId);
            if (list != null) {
                toJson.setObj(list);
                toJson.setMsg("ok");
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("子列表为空");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("The sub-list is empty");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("子列表為空");
                }
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl getOptionVoteList:" + e);
        }
        return toJson;
    }

    //根据投票基本信息返回部门、角色、用户信息
    public VoteTitle getVoTitle(Integer voteId) {
        VoteTitle voteTitle = voteTitleMapper.getChilddetail(voteId);
        //获取所有部门信息
        String toID = departmentService.getDeptNameByDeptId(voteTitle.getToId(), ",");
        voteTitle.setToId(toID);
        //获取所有角色信息
        String privId = usersPrivService.getPrivNameByPrivId(voteTitle.getPrivId(), ",");
        voteTitle.setPrivId(privId);
        //获取所有用户信息
        String userId = usersService.getUserNameById(voteTitle.getUserId(), ",");
        voteTitle.setUserId(userId);
        //获取所有查看所有权限范围的角色
        String viewResultPrivId = usersPrivService.getPrivNameByPrivId(voteTitle.getViewResultPrivId(), ",");
        voteTitle.setViewResultPrivId(viewResultPrivId);
        //获取所有查看所有权限范围的用户
        String viewResultUserId = usersService.getUserNameById(voteTitle.getViewResultUserId(), ",");
        voteTitle.setViewResultUserId(viewResultUserId);
        return voteTitle;
    }

    //统计总票数
    public int count(List<VoteItem> list) {
        int sum = 0;
        for (VoteItem voteItem : list) {
            //获取总票数
            int count = voteItem.getVoteCount()==null?0:voteItem.getVoteCount();
            voteItem.setVoteCount(count);
            sum += count;
        }
        return sum;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月19日
     * 方法介绍:   投票查询（已发布）移动端接口
     *
     * @param request
     * @param voteTitle
     * @return
     */
    @Override
    public ToJson<VoteTitle> getPublishVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                                     Integer pageSize, boolean useFlag) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String userId = null;
        String userPriv = null;
        String deptId = null;
        if (user != null && user.getUserId() != null) {
            userId = user.getUid() + "";
            userPriv = user.getUserPriv() + "";
            deptId = user.getDeptId() + "";
        }
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("userId", userId);
        maps.put("userPriv", userPriv);
        maps.put("deptId", deptId);
        int getcount = 0;
        try {
            List<VoteTitle> list = voteTitleMapper.searchVoteTitleList(maps);
            for (VoteTitle voteTitle2 : list) {
                //根据voteId查询投票选项信息。
                List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteTitle2.getVoteId());
                int sum = 0;
                int voteCount = 0;
                List<String> tempList = new ArrayList<String>();
                for (VoteItem voteItem : voteItemList) {
                    String voteUser = voteItem.getVoteUser();
                    if (!StringUtils.checkNull(voteUser)) {
                        List<String> list1 = new ArrayList<>();
                        String[] voteU = voteUser.split(",");
                        for (int i = 0, len = voteU.length; i < len; i++) {
                            list1.add(voteU[i]);
                        }

                        /* for(int i=0; i<list1.size(); i++){
                             String str = tempList.get(i);  //获取传入集合对象的每一个元素
                             if(!list1.contains(str)){   //查看新集合中是否有指定的元素，如果没有则加入
                                 list1.add(voteU[i]);
                             }
                         }*/
                        for (String i : list1) {
                            if (!tempList.contains(i)) {
                                tempList.add(i);
                                tempList.size();
                            }
                        }

                    }
                    //获取总票数
                    int count = voteItem.getVoteCount();
                    sum += count;
                    //获取投票人总数
                    voteCount = tempList.size();

                    String attachmentId   = voteItem.getAttachmentId();
                    String attachmentName = voteItem.getAttachmentName();
                    if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                        List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                        voteItem.setAttachmentList(atts);
                    }
                }
                voteTitle2.setSum(sum);
                //统计投票人总数
                voteTitle2.setVoteCount(voteCount);
                voteTitle2.setVoteItemList(voteItemList);
                //如果为当前用户创建的 设置查看权限为true
                if (voteTitle2.getFromId().equals(user.getUserId())) {
                    voteTitle2.setRight(true);
                }
                boolean isVotitle = this.isVotite(String.valueOf(voteTitle2.getVoteId()), user);
                voteTitle2.setHave(isVotitle);
                voteTitle2.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle2.getSendTime(), 0, voteTitle2.getSendTime().length() - 10));
            }
            getcount = voteTitleMapper.getcount1();
            voteTitle.setGetCount(getcount);
            if (list != null) {
                toJson.setObj(list);
                toJson.setObject(voteTitle);
                toJson.setMsg("ok");
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("投票为空");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Voting is empty");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("投票為空");
                }
            }
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl searchVoteTitleList:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年11月9日
     * 方法介绍:   投票统计终止查询信息(未发布)移动端接口
     *
     * @param request
     * @param voteTitle
     * @return
     */
    @Override
    public ToJson<VoteTitle> getPublishVoteTitleCount(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps, Integer page,
                                                      Integer pageSize, boolean useFlag) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        String userId = null;
        String userPriv = null;
        String deptId = null;
        if (user != null && user.getUserId() != null) {
            userId = user.getUid() + "";
            userPriv = user.getUserPriv() + "";
            deptId = user.getDeptId() + "";
        }
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("userId", userId);
        maps.put("userPriv", userPriv);
        maps.put("deptId", deptId);
        int getcount = 0;
        try {
            List<VoteTitle> list = voteTitleMapper.getVoteTitleCount(maps);
            /*  String userId=this.checkAll(voteTitle.getViewResultUserId()==null?"":voteTitle.getViewResultUserId());*/
            /*String viewResult= null;*/
            if (list != null && list.size() > 0) {
                for (VoteTitle voteTitle1 : list) {
                    //根据voteId查询投票选项信息。
                    List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(voteTitle1.getVoteId());
                    int sum = 0;
                    int voteCount = 0;
                    List<String> tempList = new ArrayList<String>();
                    for (VoteItem voteItem : voteItemList) {
                        String voteUser = voteItem.getVoteUser();
                        if (!StringUtils.checkNull(voteUser)) {
                            List<String> list1 = new ArrayList<>();
                            String[] voteU = voteUser.split(",");
                            for (int i = 0, len = voteU.length; i < len; i++) {
                                list1.add(voteU[i]);
                            }

                            for (String i : list1) {
                                if (!tempList.contains(i)) {
                                    tempList.add(i);
                                    tempList.size();
                                }
                            }

                        }
                        String attachmentId   = voteItem.getAttachmentId();
                        String attachmentName = voteItem.getAttachmentName();
                        if (!StringUtils.checkNull(attachmentId) && !StringUtils.checkNull(attachmentName)) {
                            List<Attachment> atts = GetAttachmentListUtil.returnAttachment(attachmentName, attachmentId, sqlType, "vote");
                            voteItem.setAttachmentList(atts);
                        }
                        //获取总票数
                        int count = voteItem.getVoteCount();
                        sum += count;
                        //获取投票人总数
                        voteCount = tempList.size();
                    }
                    voteTitle1.setSum(sum);
                    voteTitle1.setVoteCount(voteCount);
                    voteTitle1.setVoteItemList(voteItemList);
                    //如果为当前用户创建的 设置查看权限为true
                    if (voteTitle1.getFromId().equals(user.getUserId())) {
                        voteTitle1.setRight(true);
                    }
                    voteTitle1.setSendTime(org.apache.commons.lang3.StringUtils.substring(voteTitle1.getSendTime(), 0, voteTitle1.getSendTime().length() - 10));
                }
                getcount = voteTitleMapper.getcount2();
                voteTitle.setGetCount(getcount);
                toJson.setObj(list);
                toJson.setObject(voteTitle);
                toJson.setMsg("ok");
            } else {
                toJson.setMsg("err");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl getVoteTitleCount:" + e);
        }
        return toJson;
    }

    @Override
    public ToJson<VoteTitle> clearSave(HttpServletRequest request, VoteTitle voteTitle) {
        ToJson<VoteTitle> toJson = new ToJson<VoteTitle>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            if (voteTitle.getParentId() == null) {
                voteTitle.setParentId(0);
            }
            if (voteTitle.getBeginDate() == null) {
                voteTitle.setBeginDate(DateFormat.getCurrentTime());
            }
            if ("2".equals(voteTitle.getPublish())) {
                voteTitle.setEndDate(DateFormat.getCurrentTime());
            }
            if (voteTitle.getSendTime() == null) {
                voteTitle.setSendTime(DateFormat.getCurrentTime());
            }
            int a = voteTitleMapper.updateVoteTitle(voteTitle);

            if (a > 0) {
                List<VoteTitle> voteTitles = voteTitleMapper.selByParentId(voteTitle.getVoteId());//子投票项目
                voteTitles.add(voteTitleMapper.selectByVoteId(voteTitle.getVoteId()));
                for(VoteTitle vt:voteTitles){
                    List<VoteItem> voteItemList = voteItemMapper.getVoteItemList(vt.getVoteId());
                    for (VoteItem v:voteItemList) {
                        v.setVoteCount(0);
                        v.setVoteUser("");
                        v.setAnonymous("");
                        v.setVoteReason("");
                        if(!StringUtils.checkNull(vt.getType())&&("2").equals(vt.getType())){
                            voteItemMapper.deleteByItemId(v.getItemId());
                            continue;
                        }
                        voteItemMapper.updateVote(v);
                    }
                }
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("修改成功");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Modified successfully");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("修改成功");
                }
                toJson.setFlag(0);
            } else {
                if (locale.equals("zh_CN")) {
                    toJson.setMsg("修改失败");
                } else if (locale.equals("en_US")) {
                    toJson.setMsg("Modification failed");
                } else if (locale.equals("zh_TW")) {
                    toJson.setMsg("修改失敗");
                }
                toJson.setFlag(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("VoteTitleServiceImpl updateVoteTitle:" + e);
        }
        return toJson;
    }

    @Override
    public boolean checkEndTime(String resultId) {
        try {
            VoteTitle voTitle = voteTitleMapper.getChilddetail(Integer.valueOf(resultId));
            if (!StringUtils.checkNull(voTitle.getEndDate())) {
                String substring = voTitle.getEndDate().substring(0, voTitle.getEndDate().length() - 2);
                long end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(substring).getTime();
                long now = new Date().getTime();
                if(end < now){
                    voTitle.setPublish("2");
                    voTitle.setUserId(null);
                    int i = voteTitleMapper.updateVoteTitle(voTitle);
                    return true;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public String getChildList(Integer departmentId,StringBuffer stringBuffer){
        List<Department> departments = departmentMapper.getChDeptPlus(Integer.valueOf(departmentId));
        if (departments.size()!=0 ){
            for (Department dept :departments){
                stringBuffer.append(dept.getDeptId()+",");
                getChildList(dept.getDeptId(),stringBuffer);
            }
        }
        return stringBuffer.toString()+departmentId+",";
    }
}
