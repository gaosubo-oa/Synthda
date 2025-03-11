package com.xoa.service.IMDepart.impl;

import com.xoa.dao.IMDepart.IMDepartmentMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.model.department.Department;
import com.xoa.model.users.Users;
import com.xoa.service.IMDepart.IMDepartService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.Collator;
import java.util.*;
@Service
public class IMDepartServiceIml implements IMDepartService{
    @Autowired
    private IMDepartmentMapper departmentMapper;
    @Resource
    private UsersService usersService;
    @Autowired
    private SysParaMapper sysParaMapper;
    @Resource
    private UserDeptOrderMapper userDeptOrderMapper;
    @Resource
    private ModulePrivService modulePrivService;


    public List<Department> getChDeptUserBai(int deptId, HttpServletRequest request ,String queryType) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        String moduleId = request.getParameter("moduleId");
        Map<String, Object> map = modulePrivService.getModulePriv(user, moduleId);

        map.put("deptId",deptId);
        map.put("privIds", user.getUserPriv());
        map.put("userIds",user.getUserId());
        map.put("deptIds",user.getDeptId());

        String deptDisplay = request.getParameter("deptDisplay");
        List<Department> list = new ArrayList<Department>();

        String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
        }catch (Exception e){

        }

        list = departmentMapper.getChDeptUserBai(map);


        String order = null;
        try {
            order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
        }catch (Exception e){

        }
        try {
            if ("1".equals(order)) {
                for (Department list5 : list) {   // 先获得这个用户在在该部门排序号
                    if (!StringUtils.checkNull(list5.getUserId())) {
                        list5.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(list5.getUserId(), deptId).getOrderNo());
                    }
                }
                Collections.sort(list, (Department a, Department b) -> a.getUserDeptNo() - b.getUserDeptNo());
                //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
            }
        }catch (Exception e){

        }


        List<Department> list1 = departmentMapper.getChDeptByDisplay(deptId,StringUtils.checkNull(deptDisplay) ? 1 : null);
        for (Department dep : list1) {
            Department department = this.getDeptById(dep.getDeptParent());
            dep.setDeptParentName(department.getDeptName());
            List<Department> list2 = new ArrayList<Department>();
            list2 = this.getChDept(dep.getDeptId());
            if (list2.size() != 0) {
                dep.setIsHaveCh("1");
            } else {
                dep.setIsHaveCh("0");
            }
        }

        if("online".equals(queryType)){
            ToJson<Object> onlineMap = usersService.getOnlineMap(request);
            Map<String, Object> onlineMapObject = (Map<String, Object>) onlineMap.getObject();
            List<Department> list2 = new ArrayList<Department>();
            for (int i=0,size=list.size();i<size;i++){
                if(onlineMapObject.get(list.get(i).getUserId())!=null){
                    list2.add(list.get(i));
                }
            }
            list = list2;
            // 判断子部门是否包含在线用户
            ToJson<Users> onlinePeople = usersService.getOnlinePeople(request);
            if(onlinePeople!=null&&onlinePeople.getObj()!=null){
                List<Users> usersOnline = onlinePeople.getObj();
                Map<Integer, String> onLineDeptMap = getOnLineDeptMap(usersOnline);
                List<Department> list3 = new ArrayList<Department>();
                for (int i=0,size=list1.size();i<size;i++){
                    if(onLineDeptMap.get(list1.get(i).getDeptId())!=null&&onLineDeptMap.get(list1.get(i).getDeptId()).equals(list1.get(i).getDeptName())){
                        list3.add(list1.get(i));
                    }
                }
                list1 = list3;
            }
        }

        if (list.size() != 0 && list1.size() != 0) {
            for (int i = 0; i < list1.size(); i++) {
                list.add(list1.get(i));
            }
            return list;
        }
        if (list.size() != 0 && list1.size() == 0) {
            return list;
        }
        if (list.size() == 0 && list1.size() != 0) {
            return list1;
        }
        if (list.size() == 0 && list1.size() == 0) {
            return list;
        }
        return list;
    }


    @Override
    public List<Department> getOnlineDepartments(HttpServletRequest request) {
        ToJson<Users> onlinePeople = usersService.getOnlineByuser();
        // ToJson<Users> onlinePeople = usersService.getOnlinePeople(request);
        if(onlinePeople.isFlag()&&onlinePeople.getObj().size()>0){
            List<Users> obj = onlinePeople.getObj();
            List<Department> onLinePeopleAndDept = getOnLinePeopleAndDept(obj);
            // 去重判断
            if(onLinePeopleAndDept!=null){
                for (int i = 0; i < onLinePeopleAndDept.size(); i++) {
                    for (int j = onLinePeopleAndDept.size() - 1; j  > i; j--) {
                        if (onLinePeopleAndDept.get(j).getDeptId().equals(onLinePeopleAndDept.get(i).getDeptId())) {
                            //onLinePeopleAndDept.remove(j);
                        }
                    }
                }
                return onLinePeopleAndDept;
            }
        }
        return null;
    }

    public Department getDeptById(Integer deptId) {
        Department department = departmentMapper.getDeptById(deptId);
        if (department!=null){
            department.setDeptParentName(departmentMapper.getDeptNameByDeptId(department.getDeptParent()));
        }
        return department;
    }

    public List<Department> getChDept(int deptId) {
        List<Department> list = departmentMapper.getChDept(deptId);

        return list;
    }

    public List<Department> getOnLinePeopleAndDept(List<Users> list){
        List<Department> departmentList = new ArrayList<Department>();
        // 排序用户
        list.sort((o1,o2) ->{
            // 根据角色号排序
            if (o1.getUserPrivNo()!=null && o2.getUserPrivNo()!=null) {
                if(!o1.getUserPrivNo().equals(o2.getUserPrivNo())){
                    return o1.getUserPrivNo() - o2.getUserPrivNo();
                } else {
                    // 根据用户排序号排序
                    if(o1.getUserNo()!=null&&o2.getUserNo()!=null){
                        if(!o1.getUserNo().equals(o2.getUserNo())){
                            return o1.getUserNo() - o2.getUserNo();
                        } else {
                            Comparator<Object> compare = Collator.getInstance(java.util.Locale.CHINA);
                            if(!StringUtils.checkNull(o1.getUserName())&&!StringUtils.checkNull(o2.getUserName())){
                                return compare.compare(o1.getUserName(), o2.getUserName());
                            }
                        }
                    }
                }
            }
            return 0;
        });

        if(list!=null){
            for (int i=0,size = list.size();i<size;i++){
                Users users = list.get(i);
                Department userDept = new Department();
                userDept.setUserId(users.getUserId());
                userDept.setUserName(users.getUserName());
                userDept.setUserPrivName(users.getUserPrivName());
                userDept.setType("people");
                userDept.setUid(users.getUid());
                userDept.setBirthday(users.getBirthday() == null ?"":users.getBirthday().toString());
                userDept.setSex(users.getSex() == null ? "":users.getSex());
                userDept.setMobilNo(users.getMobilNo() == null ? "": users.getMobilNo());
                userDept.setMystatus(users.getMyStatus() == null ?"": users.getMyStatus());
                userDept.setAvatar(users.getAvatar() == null ? users.getSex() : users.getAvatar());

                //查询主部门和辅助部门
                //Department deptById = departmentMapper.getDeptById(users.getDeptId());
                Set<String> set=new HashSet();
                if (!StringUtils.checkNull(users.getDeptIdOther())){
                    set = new HashSet<String>(Arrays.asList(users.getDeptIdOther().split(",")));
                }
                set.add(users.getDeptId().toString());
                List<Department> deptByIds= departmentMapper.selDeptByListIds(new ArrayList(set));
                for (Department deptById:deptByIds) {
                    if(deptById!=null){
                        // 注释掉掉内容是为了以后仿照通达 一次加载并展开全部数据 现在没有用到 所以注释了 下面的递归同理
                        ArrayList<Department> userDepts = new ArrayList<>();
                        userDepts.add(userDept);
                        deptById.setChild(userDepts);
                        // 递归获取所有的父级部门,顶级部门
                        Department allParentDept = new Department();
                        allParentDept = getAllParentDept(allParentDept,deptById);
                        allParentDept.setType("dep");
                        //使用递归的方式找到所在的部门
                        boolean deparFlag = forDepar(true, departmentList, allParentDept,userDept,deptById);
                        if (deparFlag){
                            departmentList.add(allParentDept);
                        }
                    }
                }
            }
        }

        // 通过部门排序号进行排序
        departmentList.sort((o1, o2) -> {
            if (!StringUtils.checkNull(o1.getDeptNo()) && !StringUtils.checkNull(o2.getDeptNo())) {
                return Integer.parseInt(o1.getDeptNo()) - Integer.parseInt(o2.getDeptNo());
            }
            return 0;
        });

        return departmentList;
    }

    private boolean forDepar(boolean check,List<Department> departmentList,Department allParentDept,Department userDept,Department deptById){
        for(Department department:departmentList){
            //判断用户部门的最上级部门如果和当前部门一样，说明用户在当前部门分支下（还没有确定具体部门）
            if(department.getDeptId().equals(allParentDept.getDeptId())){
                //判断用户的部门是否是当前部门，是则直接将不带部门的用户添加进数据集中
                if(deptById.getDeptId().equals(department.getDeptId())) {
                    department.getChild().add(userDept);
                }else {
                    //如果不是当前部门，则需要用此部门分支一级一级往下判断
                    childDept(department.getChild(),allParentDept.getChild().get(0),userDept,deptById);
                }
                check = false;
            }
        }
        return check;


    }


    private void childDept(List<Department> dept,Department dept2,Department userDept,Department deptById){
        //遍历部门子集合
        for (Department department : dept) {
            //判断部门id是否和用户部门分支id相同，相同的则为一支部门分支
            if(department.getDeptId()!=null && department.getDeptId().equals(dept2.getDeptId())){
                List<Department> child = new ArrayList<>();

                //判断部门的子集是否为空，为空就直接将用户部门加到部门子集(上面已经判断了部门和用户部门为同一部门分支)
                if(department.getChild() == null){
                    child.add(dept2);
                    department.setChild(child);
                    return;
                }

                //部门子集不为空，则判断用户的部门是否为当前部门，是则直接将不带部门的用户添加进结果集
                if(deptById.getDeptId().equals(department.getDeptId())) {
                    department.getChild().add(userDept);
                    return;
                }

                //用户的部门不是当前部门，则递归调用，将当前部门的下级部门取出来带上部门用户的下级（只会有一个，所以取0）继续对比判断
                childDept(department.getChild(),dept2.getChild().get(0),userDept,deptById);

                //到这里可以说明部门子集中目前不存在部门用户的分支。直接添加
//                child.add(dept2);
//                department.setChild(child);
                return;
            }
        }

        //到这里可以说明部门子集中目前不存在部门用户的分支。直接添加
//        List<Department> departments = new ArrayList<>();
//        departments.add(dept2);
        dept.add(dept2);
        return;

    }



    // 根据子部门获取所有上级部门
    public Department getAllParentDept(Department fatherDept,Department department){
        if(!department.getDeptParent().equals(0)){
            department.setType("dep");
            // 查询父部门
            Department deptById1 = departmentMapper.getDeptById(department.getDeptParent());
            if(deptById1!=null){
                deptById1.setType("dep");
                // 这里是上面说的下面的递归
                ArrayList<Department> departments = new ArrayList<>();
                departments.add(department);
                deptById1.setChild(departments);
                fatherDept = deptById1;
                return getAllParentDept(fatherDept,deptById1);
            }
        }else {
            fatherDept = department;
        }
        return fatherDept;
    }


    // 获取所有拥有在线用户的部门Map
    public Map<Integer,String> getOnLineDeptMap(List<Users> list){
        Map<Integer,String> allOnlineDeptMap = new HashMap<Integer, String>();
        if(list!=null){
            for (int i=0,size = list.size();i<size;i++){
                Users users = list.get(i);
                Department deptById = departmentMapper.getDeptById(users.getDeptId());
                if(deptById!=null){
                    allOnlineDeptMap.put(deptById.getDeptId(),deptById.getDeptName());
                    // 递归获取所有的父级部门
                    Department allParentDept = getAllOnlineParentDept(allOnlineDeptMap,deptById);
                }
            }
        }
        return allOnlineDeptMap;
    }

    // 根据子部门获取所有上级部门
    public Department getAllOnlineParentDept(Map<Integer,String> allOnlineDeptMap ,Department department){
        if(!department.getDeptParent().equals(0)){
            // 查询父部门
            Department deptById1 = departmentMapper.getDeptById(department.getDeptParent());
            if(deptById1!=null){
                allOnlineDeptMap.put(deptById1.getDeptId(),deptById1.getDeptName());
                getAllOnlineParentDept(allOnlineDeptMap,deptById1);
            }
        }
        return department;
    }


}
