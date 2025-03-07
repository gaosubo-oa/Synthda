package com.xoa.service.position;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.position.PositionManagementMapper;
import com.xoa.dao.position.UserJobDutyHistoryMapper;
import com.xoa.dao.position.UserJobDutyMapper;
import com.xoa.model.position.UserJobDutyHistoryWithBLOBs;
import com.xoa.model.position.UserJobDutyWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @Author 李善澳
 * @Date 2021-01-15 14:45
 * @Dnnotation:
 */
@Service
public class UserJobDutyService {
    @Autowired
    UserJobDutyMapper userJobDutyMapper;
    @Autowired
    UserJobDutyHistoryMapper userJobDutyHistoryMapper;
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private UsersService usersService;

    @Autowired
    PositionManagementMapper positionManagementMapper;
    //新增
    public ToJson addUserJobDuty(HttpServletRequest request, UserJobDutyWithBLOBs userJobDuty) {
        ToJson json = new ToJson();
        try {
            userJobDuty.setIsFinalNode("0");
            int insert = userJobDutyMapper.insert(userJobDuty);
            if (insert > 0 && userJobDuty.getDutyParent() != 0) {//新建成功后 若上级节点不为0则将其改为不是最终节点
                userJobDutyMapper.saveIsFinalNode(userJobDuty.getDutyParent());
            }
            json.setFlag(0);
            json.setMsg("succ");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    //修改
    public ToJson updateUserJobDuty(HttpServletRequest request, UserJobDutyWithBLOBs userJobDuty) {
        ToJson json = new ToJson();
        try {
            Calendar now = Calendar.getInstance();
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            int update = userJobDutyMapper.updateByPrimaryKeySelective(userJobDuty);
            if (update > 0) {
                UserJobDutyHistoryWithBLOBs userJobDutyHistoryWithBLOBs = new UserJobDutyHistoryWithBLOBs();
                userJobDutyHistoryWithBLOBs.setUserId(sessionInfo.getUserId());
                userJobDutyHistoryWithBLOBs.setDeptId(sessionInfo.getDeptId());
                userJobDutyHistoryWithBLOBs.setDutyDesc(userJobDuty.getDutyDesc());
                userJobDutyHistoryWithBLOBs.setDutyGrade(userJobDuty.getDutyGrade());
                userJobDutyHistoryWithBLOBs.setDutyId(userJobDuty.getDutyId());
                userJobDutyHistoryWithBLOBs.setDutyParent(userJobDuty.getDutyParent());
                userJobDutyHistoryWithBLOBs.setDutyType(userJobDuty.getDutyType());
                userJobDutyHistoryWithBLOBs.setDutyName(userJobDuty.getDutyName());
                userJobDutyHistoryWithBLOBs.setCreateTime(new Date());
                userJobDutyHistoryWithBLOBs.setJobIds(userJobDuty.getJobIds());
                userJobDutyHistoryWithBLOBs.setIsFinalNode(userJobDuty.getIsFinalNode());
                //版本用当前时间来组合
                userJobDutyHistoryWithBLOBs.setDutyVersion(
                        String.valueOf(now.get(Calendar.YEAR)) +
                                String.valueOf((now.get(Calendar.MONTH) + 1)) +
                                String.valueOf(now.get(Calendar.DAY_OF_MONTH)) +
                                String.valueOf(now.get(Calendar.HOUR_OF_DAY)) +
                                String.valueOf(now.get(Calendar.MINUTE)) + String.valueOf(now.get(Calendar.SECOND)));
                userJobDutyHistoryMapper.insert(userJobDutyHistoryWithBLOBs);
            }
            json.setFlag(0);
            json.setMsg("succ");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    //删除
    public ToJson<UserJobDutyWithBLOBs> delUserJobDuty(HttpServletRequest request, int dutyId) {
        ToJson json = new ToJson();
        try {
            int del = userJobDutyMapper.deleteByPrimaryKey(dutyId);
            json.setFlag(0);
            json.setMsg("succ");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    //获取数据形成树
    public ToJson<UserJobDutyWithBLOBs> getUserJobDutyTree(HttpServletRequest request, String dutyType, String dutyName) {
        ToJson json = new ToJson();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("dutyType", dutyType);
            map.put("dutyName", dutyName);
            List<UserJobDutyWithBLOBs> userJobDutyWithBLOBs = userJobDutyMapper.selectAllDataByDutyType(map);
            if (StringUtils.checkNull(dutyName)) {
                for (UserJobDutyWithBLOBs userJob : userJobDutyWithBLOBs) {
                    if (!StringUtils.checkNull(userJob.getJobIds())) {
                        userJob.setJobNames(positionManagementMapper.getJobNameByIds(userJob.getJobIds().split(",")));
                    }
                }
                json.setData(listGetStree(userJobDutyWithBLOBs));
            } else {
                json.setData(searchTree(userJobDutyWithBLOBs));
            }
            json.setFlag(0);
            json.setMsg("succ");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    //获取数据形成树
    public List<UserJobDutyWithBLOBs> searchTree(List<UserJobDutyWithBLOBs> userJobDutyWithBLOBs) {
        List<UserJobDutyWithBLOBs> returnData = new ArrayList<>();
        for (UserJobDutyWithBLOBs userJob : userJobDutyWithBLOBs) {
            returnData.add(userJob);
            if (userJob.getDutyParent() != 0) {
                UserJobDutyWithBLOBs userJobs = null;
                do {
                    if (userJobs == null) {
                        userJobs = userJobDutyMapper.selectByPrimaryKey(userJob.getDutyParent());
                    } else {
                        userJobs = userJobDutyMapper.selectByPrimaryKey(userJobs.getDutyParent());
                    }
                    if (returnData.contains(userJobs)) {
                        continue;
                    }
                    returnData.add(userJobs);
                } while (userJobs.getDutyParent() != 0);
            }
            if (!StringUtils.checkNull(userJob.getJobIds())) {
                userJob.setJobNames(positionManagementMapper.getJobNameByIds(userJob.getJobIds().split(",")));
            }
        }
        return listGetStree(returnData);
    }

    private static List<UserJobDutyWithBLOBs> listGetStree(List<UserJobDutyWithBLOBs> list) {
        List<UserJobDutyWithBLOBs> treeList = new ArrayList<UserJobDutyWithBLOBs>();
        for (UserJobDutyWithBLOBs tree : list) {
            //找到根
            if (tree.getDutyParent() == 0) {
                treeList.add(tree);
            }
            //找到子
            for (UserJobDutyWithBLOBs treeNode : list) {
                if (treeNode.getDutyParent().equals(tree.getDutyId())) {
                    if (tree.getChild() == null) {
                        tree.setChild(new ArrayList<UserJobDutyWithBLOBs>());
                    }
                    tree.getChild().add(treeNode);
                }
            }
        }
        return treeList;
    }

    //根据主职责主键获取职责历史版本
    public ToJson<UserJobDutyHistoryWithBLOBs> getUserJobDutyHistory(HttpServletRequest request, int dutyId, PageParams pageParams) {
        ToJson json = new ToJson();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("dutyId", dutyId);
            map.put("page", pageParams);
            List<UserJobDutyHistoryWithBLOBs> userJobDutyHistory = userJobDutyHistoryMapper.getUserJobDutyHistory(map);
            for (UserJobDutyHistoryWithBLOBs jobDutyHistoryWithBLOBs : userJobDutyHistory) {
                if (jobDutyHistoryWithBLOBs.getDeptId() != null) {//责任部门
                    jobDutyHistoryWithBLOBs.setDeptName(departmentMapper.getDeptNameById(jobDutyHistoryWithBLOBs.getDeptId()));
                }
                if (!StringUtils.checkNull(jobDutyHistoryWithBLOBs.getUserId())) {//审批人
                    jobDutyHistoryWithBLOBs.setUserName(usersService.getUserNamesByUserIds(jobDutyHistoryWithBLOBs.getUserId()));
                }
                if (!StringUtils.checkNull(jobDutyHistoryWithBLOBs.getJobIds())) {//岗位
                    jobDutyHistoryWithBLOBs.setJobNames(positionManagementMapper.getJobNameByIds(jobDutyHistoryWithBLOBs.getJobIds().split(",")));
                }
            }
            json.setFlag(0);
            json.setObject(userJobDutyHistory);
        } catch (Exception e) {
            json.setFlag(1);
        }
        return json;
    }

    //展示7层级职责数结构
    public ToJson shouJobDuty(HttpServletRequest request) {
        ToJson json = new ToJson();
        try {
            //对应部门名称
            String mergerDeptName = request.getParameter("mergerDeptName");
            //对应职责类别
            String dutyJobType = request.getParameter("dutyJobType");
            //（总部-01，分公司-02、项目部-03）
            String dutyType = request.getParameter("dutyType");
            //（0-单个部门查询  1-整体查询）
            String queryType = request.getParameter("queryType");
            List<UserJobDutyWithBLOBs> userJobDutyWithBLOBs = new ArrayList<>();
            if (!StringUtils.checkNull(queryType) && queryType.equals("1")) {//整体查询
                Map<String, Object> map = new HashMap<>();
                map.put("dutyType", "01");
                map.put("mergerDeptName", StringUtils.checkNull(mergerDeptName) ? null : mergerDeptName);
                List<UserJobDutyWithBLOBs> data = userJobDutyMapper.getData(map);
                userJobDutyWithBLOBs = listGetStree(data);
                for (UserJobDutyWithBLOBs dutyWithBLOBs : userJobDutyWithBLOBs) {//一级职责
                    returnDataInfo(dutyWithBLOBs);
                    if (dutyWithBLOBs.getChild() != null) {
                        List<UserJobDutyWithBLOBs> child = dutyWithBLOBs.getChild();
                        for (UserJobDutyWithBLOBs duty : child) {//二级职责
                            if (duty.getChild() != null) {//三级职责---需要去挂接四级职责
                                List<UserJobDutyWithBLOBs> childThree = duty.getChild();
                                StringBuffer str = new StringBuffer();
                                for (UserJobDutyWithBLOBs jobDutyWithBLOBs : childThree) {
                                    returnDataInfo(jobDutyWithBLOBs);
                                    str.append(jobDutyWithBLOBs.getDutyId() + ",");
                                }
                                //已挂接上四级和五级数据
                                List<UserJobDutyWithBLOBs> userJobDutyWithBLOBs1 = fourAndFive("02", duty.getDutyJobType(), str.toString());
                                childThree.get(0).setChild(userJobDutyWithBLOBs1);
                            }
                        }
                    }
                }
            } else {//单个部门查询
                Map<String, Object> map = new HashMap<>();
                map.put("dutyType", dutyType);
                map.put("dutyJobType", dutyJobType);
                map.put("mergerDeptName", mergerDeptName);
                List<UserJobDutyWithBLOBs> data = userJobDutyMapper.getData(map);
                for (UserJobDutyWithBLOBs jobDutyWithBLOBs : data) {
                    returnDataInfo(jobDutyWithBLOBs);
                }
                userJobDutyWithBLOBs = listGetStree(data);
            }
            json.setFlag(0);
            json.setData(userJobDutyWithBLOBs);
        } catch (Exception e) {
            json.setFlag(1);
        }
        return json;
    }

    //四级、六级职责特殊处理接口
    public List<UserJobDutyWithBLOBs> fourAndFive(String dutyType, String dutyJobType, String dutyIds) {
        Map<String, Object> map = new HashMap<>();
        map.put("dutyType", dutyType);
        map.put("dutyJobType", dutyJobType);
        map.put("dutyIds", dutyIds);
        //查出四级职责
        List<UserJobDutyWithBLOBs> data = userJobDutyMapper.getData(map);
        for (UserJobDutyWithBLOBs userJobDutyWithBLOBs : data) {
            returnDataInfo(userJobDutyWithBLOBs);
            //五级职责
            List<UserJobDutyWithBLOBs> data1 = userJobDutyMapper.getChildByDutyId(userJobDutyWithBLOBs.getDutyId());
            if (data1 != null && data1.size() > 0) {
                //遍历五级的id串，用于获取六级使用。
                StringBuffer str = new StringBuffer();
                for (UserJobDutyWithBLOBs jobDutyWithBLOBs : data1) {
                    returnDataInfo(jobDutyWithBLOBs);
                    str.append(jobDutyWithBLOBs.getDutyId() + ",");
                }
                if (dutyType.equals("02")) {
                    List<UserJobDutyWithBLOBs> userJobDutyWithBLOBs1 = fourAndFive("03", dutyJobType, str.toString());
                    data1.get(0).setChild(userJobDutyWithBLOBs1);
                    userJobDutyWithBLOBs.setChild(data1);
                } else {
                    userJobDutyWithBLOBs.setChild(data1);
                    break;
                }
            }
        }
        return data;
    }

    //返回具体信息
    public UserJobDutyWithBLOBs returnDataInfo(UserJobDutyWithBLOBs userJobDutyWithBLOBs) {
        if (!StringUtils.checkNull(userJobDutyWithBLOBs.getJobIds())) {//岗位
            userJobDutyWithBLOBs.setJobNames(positionManagementMapper.getJobNameByIds(userJobDutyWithBLOBs.getJobIds().split(",")));
        }
        return userJobDutyWithBLOBs;
    }
}
