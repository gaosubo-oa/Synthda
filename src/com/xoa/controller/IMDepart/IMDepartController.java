package com.xoa.controller.IMDepart;

import com.xoa.dao.IMUser.IMUsersMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.hierarchical.HierarchicalGlobalMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.dao.users.UserGroupMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.model.users.UsersIm;
import com.xoa.service.IMDepart.IMDepartService;
import com.xoa.service.IMUser.IMUsersService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.users.UserGroupService;
import com.xoa.util.AjaxJson;
import com.xoa.util.CookiesUtil;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.http.entity.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.*;

@Controller
public class IMDepartController {
    @Autowired
    private DepartmentService departmentService;
    @Autowired
    private IMDepartService imDepartService;
    @Autowired
    private IMUsersService usersService;
    @Autowired
    private UserGroupService userGroupService;
    @Autowired
    private UsersMapper usersMapper;
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private UserPrivMapper userPrivMapper;

    @Resource
    private IMUsersMapper imUsersMapper;

    @Resource
    private UserGroupMapper userGroupMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Autowired
    private HierarchicalGlobalMapper hierarchicalGlobalMapper;

    @Resource
    UserDeptOrderMapper userDeptOrderMapper;
    @Resource
    private ModulePrivService modulePrivService;

    @Resource
    private SecurityApprovalService securityApprovalService;

    //白名单
    @ResponseBody
    @RequestMapping(value = "/getChDeptBai", produces = {"application/json;charset=UTF-8"})
    public AjaxJson getChDeptUser(HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            // 选人控件，点击部门，如果没有下级部门树，会再调用一次，由于一开始已经把所有部门树构造完成，所以不需要再查询数据
            String id = request.getParameter("id");
            if (!StringUtils.checkNull(id)) {
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("ok");
                return ajaxJson;
            }

            int count =0;
            String deptId = request.getParameter("deptId");
            String queryType = request.getParameter("queryType");
            String deptDisplay = request.getParameter("deptDisplay");
            if (StringUtils.checkNull(deptId)){
                // 判断是否是查询在线用户
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
                if("online".equals(queryType)){
                    List<Users> users = new ArrayList<Users>();
                    //Map<String, Object> userCountMap = loginController.userCountMap;
                    List<String> userCountMap = usersMapper.getOnline(); //获取在线人员
                    int orgFlag = departmentService.checkOrgFlag(usersTemp);
                    boolean flag = orgFlag==2 ? false : true;
                    if (userCountMap != null) {
                        if (flag) {
                            for (String userId:userCountMap) {
                                Users usersByuserId = usersMapper.getUsersByuserId(userId);
                                UserPriv userPriv = userPrivMapper.getUserPriv(usersByuserId.getUserPriv());
                                if(userPriv!=null){
                                    usersByuserId.setUserPrivNo(userPriv.getPrivNo());
                                }
                                users.add(usersByuserId);
                            }
                        } else {
                            List<Department> departs = new ArrayList<>();
                            Department classifyOrg = getClassifyOrgbyDeptId(usersTemp.getDeptId());
                            departs.add(classifyOrg);
                            getChild(departs, classifyOrg.getDeptId());
                            for (String userId:userCountMap) {
                                Users usersByuserId = usersMapper.getUsersByuserId(userId);
                                for (Department depart : departs) {
                                    if(usersByuserId.getDeptId().equals(depart.getDeptId())){
                                        UserPriv userPriv = userPrivMapper.getUserPriv(usersByuserId.getUserPriv());
                                        if(userPriv!=null){
                                            usersByuserId.setUserPrivNo(userPriv.getPrivNo());
                                        }
                                        users.add(usersByuserId);
                                    }
                                }
                            }
                        }
                    }
                    if(users.size()>0){
                        // 去重判断
                        List<Department> onLinePeopleAndDept = imDepartService.getOnLinePeopleAndDept(users);
                        if(onLinePeopleAndDept.size()>0){
                            ajaxJson.setObj(onLinePeopleAndDept);
                            ajaxJson.setFlag(true);
                            ajaxJson.setMsg("Initialize query");
                            return ajaxJson;
                        }
                    }

                }
                if(!StringUtils.checkNull(deptDisplay)){
                    usersTemp.setDeptDisplay(1);
                }
                List<Department> list = departmentService.getDepartmentByClassifyOrg(usersTemp,false,true);
                //List<Department> list = departmentService.getDepartmentByParet();
                for (Department department : list){
                    int a = departmentService.getCountChDeptUser(department.getDeptNo());
                    count = count+a;
                    List<Department>  list2 = departmentService.getChDept(department.getDeptId());
                    if (list2.size() != 0) {
                        department.setIsHaveCh("1");
                    } else {
                        department.setIsHaveCh("0");
                    }
                }

                String order = null;
                try {
                    order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
                }catch (Exception e){

                }
                if (!StringUtils.checkNull(deptId)) {
                    try {
                        if ("1".equals(order)) {
                            for (Department list5 : list) {
                                if (!StringUtils.checkNull(list5.getUserId()) && null != deptId) {
                                    list5.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(list5.getUserId(), Integer.parseInt(deptId)).getOrderNo());
                                }
                            }
                            Collections.sort(list, (Department a, Department b) -> a.getUserDeptNo() - b.getUserDeptNo());
                            //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                        }
                    } catch (Exception e) {
                        //e.printStackTrace();
                    }
                }

                ajaxJson.setObj(list);
                ajaxJson.setTotleNum(count);
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("Initialize query");
                Map<String,Object> map=new HashedMap();
                map.put("claNum",0);
                ajaxJson.setAttributes(map);
                return ajaxJson;
            }
            //int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));

            //处理头像问题
            String realPath = request.getSession().getServletContext().getRealPath("/"); //获取项目路径
            List<Department> list1 = imDepartService.getChDeptUserBai(Integer.parseInt(deptId),request,queryType);
            for(Department entity1:list1){
                if(!StringUtils.checkNull(entity1.getAvatar())  && !entity1.getAvatar().equals("0") && !entity1.getAvatar().equals("1")) {
                    //小头像不为空，大头像不为空，判断小头像长宽是否超过128
                    String avatarPath=realPath+"ui"+System.getProperty("file.separator")
                            +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                            +entity1.getAvatar();
                    File file=new File(avatarPath);
                    if(!file.exists()){
                        //file.mkdirs();
                        break;
                    }
                    BufferedImage sourceImg = ImageIO.read(new FileInputStream(file));
                    if ((sourceImg.getWidth()!=128) && (sourceImg.getHeight()!=128)){
                        //重新修改小头像
                        MultipartFile multipartFile = new MockMultipartFile(
                                file.getName(),
                                file.getName(),
                                ContentType.APPLICATION_OCTET_STREAM.toString(),
                                new FileInputStream(file));
                        //上传图片并进行修改数据库数据
                        String fileName = FileUploadUtil.rename(multipartFile.getOriginalFilename());
                        File dir = new File(realPath + "ui/img/user");
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }
                        File realfile = new File(dir, fileName);
                        multipartFile.transferTo(realfile);
                        String fileName128 = FileUploadUtil.rename(fileName, "s");
                        FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, fileName128, dir.getAbsolutePath());
                        Users users1 = new Users();
                        users1.setAvatar(fileName128);
                        users1.setAvatar128(fileName);
                        users1.setUid(entity1.getUid());
                        usersMapper.editUser(users1);
                    }
                }
            }


        List<Department> list = imDepartService.getChDeptUserBai(Integer.parseInt(deptId),request,queryType);
        Department dep = departmentService.getDeptById(Integer.parseInt(deptId));
        //count = departmentService.getCountChDeptUser(dep.getDeptNo());

        for (Department department : list){
            List<Department>  l = departmentService.getChDept(dep.getDeptId());
            if (l.size() != 0) {
                department.setIsHaveCh("1");
            } else {
                department.setIsHaveCh("0");
            }

            if("people".equals(department.getType())){
                count++;
            }
            if (department.getAvatar() == null) {
                department.setAvatar(department.getSex());
            }
            if (("0").equals(department.getAvatar()) || ("1").equals(department.getAvatar())) {
                department.setAvatar(department.getSex());
            }
        }
        Map<String,Object> map=new HashedMap();
        int classifyCount=departmentService.selClaNumByParentId(Integer.valueOf(deptId));
        if(classifyCount>0){
            map.put("claNum",1);
        }else{
            map.put("claNum",0);
        }

            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            }catch (Exception e){

            }
            try {
                if ("1".equals(order)) {
                    for (Department list5 : list) {   //排序  先获得这个用户在在该部门排序号
                        if (!StringUtils.checkNull(list5.getUserId())) {
                            list5.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(list5.getUserId(), Integer.parseInt(deptId)).getOrderNo());
                        }
                    }
                    Collections.sort(list, (Department a, Department b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            }catch (Exception e){
                //e.printStackTrace();
            }

        ajaxJson.setAttributes(map);
        ajaxJson.setTotleNum(count);
        ajaxJson.setObj(list);
        ajaxJson.setMsg("OK");
        ajaxJson.setFlag(true);
    } catch (Exception e) {
        e.printStackTrace();
        ajaxJson.setFlag(false);
        ajaxJson.setMsg(e.getMessage());
    }
        return ajaxJson;
}

    /**
     * 查询用户最近的分级机构
     * 王禹萌
     * 2018/12/27
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getUserOrg", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> getUserAndDept(HttpServletRequest request){
        ToJson<Department> json = new ToJson<Department>(0, null);
        List<Department> departmentList = new ArrayList<Department>();
        List<Department> departmentResult = new ArrayList<Department>();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users u= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        Users user = usersMapper.getUsersByuserId(u.getUserId());

        // 选人控件，点击部门，如果没有下级部门树，会再调用一次，由于一开始已经把所有部门树构造完成，所以不需要再查询数据
        String id = request.getParameter("id");
        if (!StringUtils.checkNull(id)) {
            json.setFlag(0);
            json.setMsg("success");
            return json;
        }

//        HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(user.getUserId(), user.getDeptId(), user.getUserPriv());
//        if("OA管理员".equals(user.getUserPrivName()) || globalId != null){
//            return departmentService.getDepartment(user.getDeptId());
//        }
//        user.setDeptId(getClassifyOrgbyDeptId(user.getDeptId()).getDeptId());
//        String[] split = user.getDeptIdOther().split(",");
//        String
//        for (int i = 0; i < split.length; i++) {
//            getClassifyOrgbyDeptId(Integer.valueOf(split[i])).getDeptId();
//        }
        departmentList = departmentService.getDepartmentByClassifyOrg(user,false,true);
        json.setFlag(0);
        json.setObj(departmentList);
        json.setMsg("success");
        return json;
//
//        Integer deptId = user.getDeptId();
//        String otherDeptId = user.getDeptIdOther();
//        if(!"".equals(otherDeptId)&&otherDeptId!=null){
//            if(",".equals(otherDeptId.substring(otherDeptId.length()-1,otherDeptId.length()))){
//                otherDeptId +=deptId;
//            }else{
//                otherDeptId += ","+deptId;
//            }
//        }else if("".equals(otherDeptId)||otherDeptId==null){
//            otherDeptId = deptId+",";
//        }
//
//        //将部门和辅助部门拼接
//        if(!"".equals(otherDeptId)&&otherDeptId!=null){
//            String[] deptIdStr = otherDeptId.split(",");
//            for(int i=0;i<deptIdStr.length;i++){
//                //递归查询父部门
//                Department department = departmentService.queryDeptParent(Integer.valueOf(deptIdStr[i]));
//                if(department==null){
//                    List<Department> list = departmentService.getDepartmentByParet();
//                    for (Department department1 : list){
//                        int a = departmentService.getCountChDeptUser(department1.getDeptNo());
//                        List<Department>  list2 = departmentService.getChDept(department1.getDeptId());
//                        if (list2.size() != 0) {
//                            department1.setIsHaveCh("1");
//                        } else {
//                            department1.setIsHaveCh("0");
//                        }
//                    }
//                    json.setFlag(0);
//                    json.setObj(list);
//                    json.setMsg("success");
//                    return json;
//                }else{
//                    if(departmentList.size()==0){
//                        departmentList.add(department);
//                    }else{
//                        Iterator <Department> it = departmentList.iterator();
//                        while(it.hasNext()){
//                            Department d = it.next();
//                            //如果部门结果中没有与当前部门有父子部门关系直接加入结果集中
//                            int deptParent = department.getDeptParent();
//                            int deptID = department.getDeptId();
//                            int dID = d.getDeptId();
//                            int dParent = d.getDeptParent();
//                            if(deptParent!=dID&&deptID!=dParent){
//                                departmentResult.add(department);
//                            }
//                            //如果部门结果集中有父部门则取当前子部门的结果，将父部门结果在结果集中删掉
//                            if(d.getDeptId()==department.getDeptParent()){
//                                String dId = department.getDeptId()+"";
//                                if(otherDeptId.indexOf(dId)==-1){
//                                    it.remove();
//                                    departmentResult.add(department);
//                                }
//                            }
//                        }
//                        //如果部门中有子部门则不添加新部门结果集
//                        for(Department dd:departmentResult){
//                            departmentList.add(dd);
//                        }
//                    }
//                }
//            }
//            json.setFlag(0);
//            json.setObj(departmentList);
//            json.setMsg("success");
//            return json;
//        }
//        return json;
    }


    @ResponseBody
    @RequestMapping(value = "/getUserAndDeptBai", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getUserAndDept(Map<String, Object> maps, Integer page,
                                        Integer pageSize, boolean useFlag, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            List<Users> list = usersService.getUserAndDeptBai(maps, page, pageSize, useFlag,user);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());

        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "/getUserAndDeptAndroid", produces = {"application/json;charset=UTF-8"})
    public ToJson<UsersIm> getUserAndDeptAndroid(Map<String, Object> maps, Integer page,
                                                 Integer pageSize, boolean useFlag, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UsersIm> json = new ToJson<UsersIm>(0, null);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            maps.put("page", pageParams);
            maps.put("deptIds",user.getDeptId());
            maps.put("privIds",user.getUserPriv());
            maps.put("userIds",user.getUserId());
            List<UsersIm> list = imUsersMapper.getUserAndDeptIm(maps);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());

        }
        return json;
    }

    /**
     *
     * 作者：贾志敏
     * 日期 2018/9/11
     * 说明：获取当前用户以及子部门用户
     * @return
     */

    @ResponseBody
    @RequestMapping("/user/selNewNowUsersBai")
    public ToJson<Users> selNewNowUsersBai(HttpServletRequest request){
        return usersService.selNewNowUsersBai(request);
    }

    @ResponseBody
    @RequestMapping("/department/getNewChDeptBai")
    public ToJson<Users> getNewChDeptBai(HttpServletRequest request, Integer deptId){
        return usersService.getNewChDeptBai(request,deptId);
    }

    @ResponseBody
    @RequestMapping(value = "/user/getBySearchBai", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getBySearchBai(HttpServletRequest request, Map<String, Object> maps) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            request.setCharacterEncoding("UTF-8");
            String search = request.getParameter("search");
            //String search=URLEncoder.encode(request.getParameter("search"),"utf-8");

            String moduleId = request.getParameter("moduleId");
            maps = modulePrivService.getModulePriv(user, moduleId);
            maps.put("byName", search);
            maps.put("userId", search);
            maps.put("userName", search);
            maps.put("userPrivName", search);
            maps.put("deptName", search);
            if(!StringUtils.checkNull(search)){
                StringBuilder searchIndex = new StringBuilder();
                char[] split = search.toCharArray();
                for (int i = 0; i < split.length; i++) {
                    searchIndex.append(split[i]).append("*");
                }
                maps.put("userNameIndex", searchIndex.toString());
            }

            //增加分级机构过滤
            int orgFlag=departmentService.checkOrgFlag(user);
            String sysPara = null;
            try {
                sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
            }catch (Exception e){

            }
            if(!StringUtils.checkNull(sysPara) && "muping".equals(sysPara)){
                orgFlag= 0;
            }
            if( orgFlag== 2) {
                List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(user, true, true);
                int[] deptIds = new int[departmentByClassifyOrg.size()];
                for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                    deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                }
                maps.put("deptIds", deptIds);
            }

            String sql = "";
            // school_type
            if(!StringUtils.checkNull(search)){
                sql = " AND ";
            }
            String school_type = request.getParameter("school_type");
            if(!StringUtils.checkNull(school_type)){
                sql+=" d.school_type = " + school_type;
            }
            // state_private_id
            // state_private_id2
            String state_private_id = request.getParameter("state_private_id");
            String state_private_id2 = request.getParameter("state_private_id2");
            if(!StringUtils.checkNull(state_private_id)&&!StringUtils.checkNull(state_private_id2)){
                sql+=" AND ( d.state_private_id="+state_private_id+" and d.state_private_id2 = " +state_private_id2+")";
            } else if(!StringUtils.checkNull(state_private_id)&&StringUtils.checkNull(state_private_id2)) {
                sql+=" AND d.state_private_id="+state_private_id;
            }

            // userPriv
            String userPriv = request.getParameter("userPriv");
            if(!StringUtils.checkNull(userPriv)){
                sql+=" AND u.user_Priv="+userPriv;
            }

            maps.put("searchSql",sql);
            List<Users> list = usersService.getBySearchBai(maps);

            for(Users u:list){
//                String deptName = "";
                String deptNameResult = "";
//                //获取该部门
//                Department department = departmentMapper.getDeptById(u.getDeptId());
                String deptName = u.getDeptName();
                if(u.getDeptParent()!=0){
                    deptNameResult = departmentService.getByDeptName(u.getDeptParent(),u.getDeptNo(),deptNameResult);
                    if(!StringUtils.checkNull(deptNameResult)){//兼容特殊部门父级dept_id为空异常
                        if("/".equals(deptNameResult.substring(deptNameResult.length()-1,deptNameResult.length()))){
                            deptNameResult+=deptName;
                        }else{
                            deptNameResult+="/"+deptName;
                        }
                    }else{
                        deptNameResult+="/"+deptName;
                    }
                }else{
                    deptNameResult =deptName;
                }
                u.setRemark(deptNameResult);
            }

            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(list,null);

            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            //System.out.println(e.getMessage());
        }
        return json;
    }

    /**
     * 移动端选人搜索
     * wangyumeng
     * 2019/01/28
     */
    @ResponseBody
    @RequestMapping(value = "/user/getBySearchBaiOrgYDD", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getBySearchBaiOrgYDD(HttpServletRequest request,String search) {
        ToJson<Users> json = new ToJson<Users>(0, null);
        List<Department> departmentList = new ArrayList<Department>();
        List<Department> departmentResult = new ArrayList<Department>();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users u= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            Users user = usersMapper.getUsersByuserId(u.getUserId());
            if("admin".equals(user.getUserId())){
                departmentList = departmentService.getDepartmentByParet();
                for (Department department1 : departmentList) {
                    int a = departmentService.getCountChDeptUser(department1.getDeptNo());
                    List<Department> list2 = departmentService.getChDept(department1.getDeptId());
                    if (list2.size() != 0) {
                        department1.setIsHaveCh("1");
                    } else {
                        department1.setIsHaveCh("0");
                    }
                }
            }
            Integer deptId = user.getDeptId();
            String otherDeptId = user.getDeptIdOther();
            if(!"".equals(otherDeptId)&&otherDeptId!=null){
                if(",".equals(otherDeptId.substring(otherDeptId.length()-1,otherDeptId.length()))){
                    otherDeptId +=deptId;
                }else{
                    otherDeptId += ","+deptId;
                }
            }else if("".equals(otherDeptId)||otherDeptId==null){
                otherDeptId = deptId+",";
            }

            //将部门和辅助部门拼接
            if(!"".equals(otherDeptId)&&otherDeptId!=null) {
                String[] deptIdStr = otherDeptId.split(",");
                for (int i = 0; i < deptIdStr.length; i++) {
                    //递归查询父部门
                    Department department = departmentService.queryDeptParent(Integer.valueOf(deptIdStr[i]));
                    if (department == null) {
                        departmentList = departmentService.getDepartmentByParet();
                        for (Department department1 : departmentList) {
                            int a = departmentService.getCountChDeptUser(department1.getDeptNo());
                            List<Department> list2 = departmentService.getChDept(department1.getDeptId());
                            if (list2.size() != 0) {
                                department1.setIsHaveCh("1");
                            } else {
                                department1.setIsHaveCh("0");
                            }
                        }
                    } else {
                        if (departmentList.size() == 0) {
                            departmentList.add(department);
                        } else {
                            Iterator<Department> it = departmentList.iterator();
                            while (it.hasNext()) {
                                Department d = it.next();
                                //如果部门结果中没有与当前部门有父子部门关系直接加入结果集中
                                int deptParent = department.getDeptParent();
                                int deptID = department.getDeptId();
                                int dID = d.getDeptId();
                                int dParent = d.getDeptParent();
                                if (deptParent != dID && deptID != dParent) {
                                    departmentResult.add(department);
                                }
                                //如果部门结果集中有父部门则取当前子部门的结果，将父部门结果在结果集中删掉
                                if (d.getDeptId() == department.getDeptParent()) {
                                    String dId = department.getDeptId() + "";
                                    if (otherDeptId.indexOf(dId) == -1) {
                                        it.remove();
                                        departmentResult.add(department);
                                    }
                                }
                            }
                            //如果部门中有子部门则不添加新部门结果集
                            for (Department dd : departmentResult) {
                                departmentList.add(dd);
                            }
                        }
                    }
                }
                String deptNo = "";
                for (Department dd : departmentList) {
                    deptNo += dd.getDeptNo() + ",";
                }
                String string = deptNo.substring(deptNo.length() - 1, deptNo.length());
                if (",".equals(string)) {
                    deptNo = deptNo.substring(0, deptNo.length() - 1);
                }
                String[] deptNoStr = deptNo.split(",");

                String moduleId = request.getParameter("moduleId");
                Map maps = modulePrivService.getModulePriv(user, moduleId);
                maps.put("byName", search);
                maps.put("userId", search);
                maps.put("userName", search);
                maps.put("userPrivName", search);
                maps.put("deptName", search);
                maps.put("deptIdss", search);
                maps.put("privIds", user.getUserPriv());
                maps.put("userIds", user.getUserId());
                maps.put("deptNo", deptNoStr);
                maps.put("user", user);


                //增加分级机构过滤
                if(departmentService.checkOrgFlag(user) == 2) {
                    List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(user, true, true);
                    int[] deptIds = new int[departmentByClassifyOrg.size()];
                    for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                        deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                    }
                    maps.put("deptIds", deptIds);
                }
                List<Users> list = usersService.getBySearchBaiOrg(maps);
            /*    if (list.size() == 0) {
                    Map map = new HashMap();
                    map.put("privIds", user.getUserPriv());
                    map.put("userIds", user.getUserId());
                    map.put("deptIdss", user.getDeptId());
                    //查询出所有公共定义组
                    String limits = "0";
                    String userIdStr = "";
                    String userNameStr = "";
                    List<UserGroup> userGroupList = userGroupMapper.getAllUserGroup(limits, null);
                    for (UserGroup gu : userGroupList) {
                        UserGroup userGroupByGroupId = userGroupMapper.getUserGroupByGroupId(String.valueOf(gu.getGroupId()));
                        String ui = userGroupByGroupId.getUserStr();
                        if (!"".equals(ui) && ui != null) {
                            // String[] uii = ui.split(",");
                            //根据取出的userId取出userName
                            String str = ui.substring(ui.length() - 1, ui.length());
                            if (",".equals(str)) {
                                ui = ui.substring(0, ui.length() - 1);
                            }
                            userIdStr = ui;
                            String[] st = userIdStr.split(",");
                            Map map1 = new HashMap();
                            map1.put("userNames",st);
                            List<String> userNames = usersMapper.getbyUserNameAll(map1);
                            for (int i = 0; i < userNames.size(); i++) {
                                userNameStr += userNames.get(i) + ",";
                            }

                        }
                    }
                    if(!"".equals(userNameStr)&&userNameStr!=null){
                        userNameStr = userNameStr.substring(0,userNameStr.length()-1);
                    }
                    if(userNameStr.contains(search)){
                        List<Users> users = usersMapper.getUserByUserName1(search);
                        list.add(users.get(0));
                    }else if(userIdStr.contains(search)){
                        list.add(usersMapper.findUsersByuserId(search));
                    }

                }*/
                for(Users us:list){
//                    String deptName = "";
                    String deptNameResult = "";
//                    //获取该部门
//                    Department department = departmentMapper.getDeptById(us.getDeptId());
//                    deptName = department.getDeptName();
//                    us.setDeptName(deptName);
                    if(us.getDeptParent()!=0 && us.getDeptId()!=0){
                        deptNameResult = departmentService.getByDeptName(us.getDeptParent(),us.getDeptNo(),deptNameResult);
                        if("/".equals(deptNameResult.substring(deptNameResult.length()-1,deptNameResult.length()))){
                            deptNameResult+=us.getDeptName();
                        }else{
                            deptNameResult+="/"+us.getDeptName();
                        }
                    }else{
                        deptNameResult =us.getDeptName();
                    }
                    us.setRemark(deptNameResult);
                }

                //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
                securityApprovalService.removeSecrecyUsers(list,null);

                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            //System.out.println(e.getMessage());
        }
        return json;

    }

    /*
     *选人控件搜索人员（该用户的分支机构基础上）
     * 王禹萌
     * 2019/1/8
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/getBySearchBaiOrg", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getBySearchBaiOrg(HttpServletRequest request,String deptNo,String search) {
        ToJson<Users> json = new ToJson<>();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            String[] deptNoStr = deptNo.split(",");

            String moduleId = request.getParameter("moduleId");
            Map maps = modulePrivService.getModulePriv(user, moduleId);
            maps.put("byName", search);
            maps.put("userId", search);
            maps.put("userName", search);
            maps.put("userPrivName", search);
            maps.put("deptName", search);
            maps.put("deptIdss",search);
            maps.put("privIds",user.getUserPriv());
            maps.put("userIds",user.getUserId());
            maps.put("deptNo",deptNoStr);
            maps.put("user",user);

            //增加分级机构过滤
            int orgFlag=departmentService.checkOrgFlag(user);
            String sysPara = null;
            try {
                sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
            }catch (Exception e){

            }
            if(!StringUtils.checkNull(sysPara) && "muping".equals(sysPara)){
                orgFlag= 0;
            }
            if(orgFlag == 2) {
                List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(user, true, true);
                int[] deptIds = new int[departmentByClassifyOrg.size()];
                for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                    deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                }
                maps.put("deptIds", deptIds);
            }
            List<Users> list = usersService.getBySearchBaiOrg(maps);
            for(Users us:list){
//                String deptName = "";
                String deptNameResult = "";
//                //获取该部门
//                Department department = departmentMapper.getDeptById(us.getDeptId());
//                deptName = department.getDeptName();
//                us.setDeptName(deptName);
                if(us.getDeptParent()!=0 && us.getDeptId()!=0){
                    deptNameResult = departmentService.getByDeptName(us.getDeptParent(),us.getDeptNo(),deptNameResult);
                    if(StringUtils.checkNull(deptNameResult) || "/".equals(deptNameResult.substring(deptNameResult.length()-1,deptNameResult.length()))){
                        deptNameResult+=us.getDeptName();
                    }else{
                        deptNameResult+="/"+us.getDeptName();
                    }
                }else{
                    deptNameResult =us.getDeptName();
                }
                us.setRemark(deptNameResult);
            }
        /*    if(list.size()==0){
                Map map=new HashMap();
                map.put("privIds", user.getUserPriv());
                map.put("userIds",user.getUserId());
                map.put("deptIdss",user.getDeptId());
                //查询出所有公共定义组
                String limits = "0";
                String userIdStr = "";
                String userNameStr ="";
                List<UserGroup> userGroupList=userGroupMapper.getAllUserGroup(limits,null);
                for(UserGroup gu:userGroupList){
                    UserGroup userGroupByGroupId = userGroupMapper.getUserGroupByGroupId(String.valueOf(gu.getGroupId()));
                    String ui = userGroupByGroupId.getUserStr();
                    if(!"".equals(ui)&&ui!=null){
                        // String[] uii = ui.split(",");
                        //根据取出的userId取出userName
                        String str = ui.substring(ui.length()-1,ui.length());
                        if(",".equals(str)){
                            ui = ui.substring(0,ui.length()-1);
                        }
                        userIdStr =ui;
                        String[] st = userIdStr.split(",");
                        Map map1 = new HashMap();
                        map1.put("userNames",st);
                        List<String>userNames = usersMapper.getbyUserNameAll(map1);
                        for(int i=0;i<userNames.size();i++){
                            userNameStr +=  userNames.get(i)+",";
                        }

                    }
                }
                if(!"".equals(userNameStr)&&userNameStr!=null){
                    userNameStr = userNameStr.substring(0,userNameStr.length()-1);
                }
                if(userNameStr.contains(search)){
                    List<Users>users = usersMapper.getUserByUserName1(search);
                    list.add(users.get(0));
                }else if(userIdStr.contains(search)){
                    list.add(usersMapper.findUsersByuserId(search));
                }

            }*/
            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(list,null);

            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
           // System.out.println(e.getMessage());
        }
        return json;

    }
    @ResponseBody
    @RequestMapping("/user/getUserByUserPrivBai")
    public ToJson<UserPriv> getUserByUserPrivBai(HttpServletRequest request, Integer userPriv){
        return usersService.getUserByUserPrivBai(request,userPriv);
    }

    @ResponseBody
    @RequestMapping(value = "/getUsersByGroupIdBai")
    public ToJson<Users> getUsersByGroupIdBai(HttpServletRequest request, String groupId){
        return userGroupService.getUsersByGroupIdBai(request,groupId);
    }

    /**
     * 选人控件中角色按分级机构条件显示
     * 王禹萌
     * 2019/1/7
     * @param request
     * @param userPriv
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/getUserByUserPrivBaiOrg")
    public ToJson<UserPriv> getUserByUserPrivBaiOrg(HttpServletRequest request, String userPriv,String deptNo){
        return usersService.getUserByUserPrivBaiOrg(request,userPriv,deptNo);
    }


    @ResponseBody
    @RequestMapping("/getOnlinePeopleBai")
    public ToJson<Users> getOnlinePeopleBai(HttpServletRequest request){
        return usersService.getOnlinePeopleBai(request);
    }

    @ResponseBody
    @RequestMapping(value = "/todoList/queryUserByUserIdBai")
    public ToJson<Users> queryUserByUserId(HttpServletRequest request,String userName){
        if(StringUtils.checkNull(userName)){
            userName="";
        }
        return  usersService.queryUserByUserIdBai(request,userName);
    }

    /**
     * 查询用户最近的分级机构以及下面的部门
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getOrgList", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> getOrgList(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        if(user != null && StringUtils.checkNull(user.getUserId()) && user.getDeptId() != null && user.getUserPriv() != null){
            json.setMsg("err,用户信息获取失败");
            return json;
        }
        String queryType = request.getParameter("queryType");
        List<Department> departs = new ArrayList<>();
        try {
            int orgFlag = departmentService.checkOrgFlag(user);
            //HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(user.getUserId(), user.getDeptId(), user.getUserPriv());
            if (orgFlag ==0 || orgFlag ==1 ||"all".equals(queryType)) {
                // try {
                departs = departmentService.getDatagrid(request);
                for(int i=0;i<departs.size();i++){
                    Department o= departs.get(i);
                    if(o.getDeptId() == 0){
                        departs.remove(i);
                    }
                }
            }else {
                Integer deptId = user.getDeptId();
                Department classifyOrg = getClassifyOrgbyDeptId(deptId);
                departs.add(classifyOrg);
                getChild(departs, classifyOrg.getDeptId());
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        json.setObj(departs);
        json.setMsg("success");
        return json;
    }

    private Department getClassifyOrgbyDeptId(Integer deptId){
        Department classifyOrgbyDeptId = departmentMapper.getClassifyOrgbyDeptId(deptId);
        if(classifyOrgbyDeptId != null && classifyOrgbyDeptId.getClassifyOrg() != 1  && classifyOrgbyDeptId.getDeptParent() != 0){
            classifyOrgbyDeptId = getClassifyOrgbyDeptId(classifyOrgbyDeptId.getDeptParent());
        }
        return classifyOrgbyDeptId;
    }

    private void getChild(List<Department> departs,Integer detpd) {
        List<Department> chDept = departmentMapper.selectObjectByParent(detpd);
        if (chDept.size() >= 0) {
            for (Department de : chDept) {
                if (!departs.contains(de)) {
                    departs.add(de);
                    getChild(departs, de.getDeptId());
                }
            }
        }
    }
}
