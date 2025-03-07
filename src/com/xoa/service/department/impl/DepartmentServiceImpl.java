package com.xoa.service.department.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.hierarchical.HierarchicalGlobalMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.hierarchical.HierarchicalGlobal;
import com.xoa.model.users.UserDeptOrder;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExcelUtil;
import com.xoa.util.LimsJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.netdisk.ZipUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月19日 上午9:41:51
 * 类介绍  :    部门实现类
 * 构造参数:   无
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UsersService usersService;

    @Resource
    private UsersMapper usersMapper;
    @Resource
    private  DepartmentService departmentService;

    @Resource
    private UserDeptOrderMapper userDeptOrderMapper;

    @Resource
    private DutiesManagementMapper dutiesManagementMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private SecurityApprovalService securityApprovalService;

    static int times = 0;

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:42:08
     * 方法介绍:   根据部门id串获取部门名称
     * 参数说明:   @param deptID 部门id
     * 参数说明:   @return
     *
     * @return List<String>    返回部门名称
     */
    @Override
    public List<String> getDeptNameById(int... deptID) {
        //定义返回的list
        List<String> list = new ArrayList<String>();
     /*   //定义用户拼接部门名称的字符串
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < deptID.length; i++) {
            if (deptID.length == 1) {
                String deptName = departmentMapper.getDeptNameById(deptID[i]);
                list.add(deptName);
                return list;
            } else {
                String deptName = departmentMapper.getDeptNameById(deptID[i]);
                if (i < deptID.length - 1) {
                    sb.append(deptName).append(",");
                } else {
                    sb.append(deptName);
                }
            }
        }
        list.add(sb.toString());*/
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<deptID.length;i++){
            sb.append(deptID[i]+",");
        }
        if(!StringUtils.checkNull(sb.toString())){
            String deptIds =sb.toString().substring(0,sb.toString().length()-1);
            if(!StringUtils.checkNull(deptIds)){
                Map<String,Object> map = new HashedMap();
                map.put("deptIds",deptIds);
                List<Department> deptNameByIds = departmentMapper.getDeptNameByIds(map);
                if(deptNameByIds!=null) {
                    StringBuffer deptName = new StringBuffer();
                    for (Department department : deptNameByIds) {
                        deptName.append(department.getDeptName() + ",");
                    }
                    String deptNames=new String();
                    if (!StringUtils.checkNull(deptName.toString())) {
                        deptNames = deptName.toString().substring(0, deptName.toString().length() - 1);
                    }
                    list.add(deptNames);
                }
            }
        }
        return list;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2016年6月3日 下午4:02:05
     * 方法介绍:   根据dept串获取用户姓名
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<String>  返回部门串
     */
    @Override
    public String getDeptNameByDeptId(String deptId, String flag) {
        if (StringUtils.checkNull(deptId)) {
            return null;
        }
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");

        //定义用于拼接部门名称的字符串
        StringBuffer sb = new StringBuffer();
        if ("ALL_DEPT".trim().equals(deptId)) {
            if (locale.equals("zh_CN")) {
                sb.append("全体部门");
            } else if (locale.equals("en_US")) {
                sb.append("All Department");
            } else if (locale.equals("zh_TW")) {
                sb.append("全体部门");
            }

        } else {
            if (flag.equals(String.valueOf(deptId.charAt(deptId.length() - 1)))) {
                deptId = deptId.substring(0, deptId.length() - 1);
            }
            Map<String,Object>map =new HashedMap();
            map.put("deptIds",deptId);
            /* List<Department> deptNames = deparment.getDeptNameByIds(map);*/
            List<Department> deptNameByIds = departmentMapper.getDeptNameByIds(map);
            for(Department department: deptNameByIds){
                String deptName = department.getDeptName();
                if(!StringUtils.checkNull(deptName)){
                    sb.append(deptName+",");
                }
            }
        }
     /*   //定义用于拼接部门
        StringBuffer sb = new StringBuffer();
        if ("ALL_DEPT".trim().equals(deptId)) {
            sb.append("全部部门");
        } else {
            String[] temp = deptId.split(flag);
            for (int i = 0; i < temp.length; i++) {
                if (!StringUtils.checkNull(temp[i])) {
                    String userName = departmentMapper.getDeptNameByDeptId(Integer.parseInt(temp[i]));
                    if (!StringUtils.checkNull(userName)) {
                        if (i < temp.length - 1) {
                            sb.append(userName).append(",");
                        } else {
                            sb.append(userName);
                        }
                    }
                }
            }
        }*/
        String deptName =new String();
        if(!StringUtils.checkNull(sb.toString())){
            if(!sb.toString().equals("全体部门")){
                deptName=sb.toString().substring(0,sb.toString().length()-1);
            }else{
                deptName=sb.toString();
            }
        }

        return deptName;
    }

    //获取部门编号
    @Override
    public String getDeptNoByDeptId(String deptId, String flag) {
        if (StringUtils.checkNull(deptId)) {
            return null;
        }
        //定义用于拼接部门
        StringBuffer sb = new StringBuffer();
        if ("ALL_DEPT".trim().equals(deptId)) {
            sb.append("全体部门");
        } else {

            if (flag.equals(String.valueOf(deptId.charAt(deptId.length() - 1)))) {
                deptId = deptId.substring(0, deptId.length() - 1);
            }
            List<String> deptNos = departmentMapper.getDNoByIds(deptId.split(","));
            int length = deptNos.size();
            for (int i = 0; i < length; i++) {
                if (i < length - 1) {
                    sb.append(deptNos.get(i)).append(",");
                } else {
                    sb.append(deptNos.get(i));
                }
            }

/*
            String[] temp = deptId.split(flag);
            for (int i = 0; i < temp.length; i++) {
                if (!StringUtils.checkNull(temp[i])) {
                    Department dept = departmentMapper.getDeptById(Integer.parseInt(temp[i]));
                    if (dept!=null) {
                        if (i < temp.length - 1) {
                            sb.append(dept.getDeptNo()).append(",");
                        } else {
                            sb.append(dept.getDeptNo());
                        }
                    }
                }
            }*/
        }
        return sb.toString();
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月3日 上午11:39:25
     * 方法介绍:   根据部门id串获取部门名称串
     * 参数说明:   @param deptIds
     * 参数说明:   @return
     *
     * @return String 部门名称串
     */
    @Override
    public String getDpNameById(int... DeptId) {
        //定义用户拼接部门名称的字符串
        StringBuffer sb = new StringBuffer();
      /*  for (int i = 0; i < deptID.length; i++) {
            if (deptID.length == 1) {
                String deptName = departmentMapper.getDeptNameById(deptID[i]);
                return deptName;
            } else {
                String deptName = departmentMapper.getDeptNameById(deptID[i]);
                if (i < deptID.length - 1) {
                    sb.append(deptName).append(",");
                } else {
                    sb.append(deptName);
                }
            }
        }*/
        for(int i=0;i<DeptId.length;i++){
            sb.append(DeptId[i]+",");
        }
        if(!StringUtils.checkNull(sb.toString())){
            String deptIds =sb.toString().substring(0,sb.toString().length()-1);
            if(!StringUtils.checkNull(deptIds)){
                Map<String,Object> map = new HashedMap();
                map.put("deptIds",deptIds);
                List<Department> deptNameByIds = departmentMapper.getDeptNameByIds(map);
                if(deptNameByIds!=null){
                    StringBuffer deptName= new StringBuffer();
                    for(Department department:deptNameByIds){
                        deptName.append(department.getDeptName()+",");
                    }
                    String deptNames=new String();
                    if(!StringUtils.checkNull(deptName.toString())){
                        deptNames=deptName.toString().substring(0,deptName.toString().length()-1);
                    }
                    return deptNames;
                }else{
                    return "";
                }
            }else{
                return "";
            }
        }else{
            return "";
        }
    }

    @Override
    public String getDpNameById(String DeptId) {
        if (StringUtils.checkNull(DeptId)){
            return "";
        }

        if (DeptId.equals("ALL_DEPT")){
            return "全体部门";
        }

        StringBuffer deptName= new StringBuffer();

        //定义用户拼接部门名称的字符串
        if (",".equals(String.valueOf(DeptId.charAt(DeptId.length()-1)))){
            DeptId=DeptId.substring(0,DeptId.length()-1);
        }
        Map<String,Object> map = new HashedMap();
        map.put("deptIds",DeptId);
        List<Department> deptNameByIds = departmentMapper.getDeptNameByIds(map);
        for(Department department:deptNameByIds){
            deptName.append(department.getDeptName()+",");
        }
        return deptName.toString();
    }


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年6月16日 上午11:13:24
     * 方法介绍:   获取所有部门
     * 参数说明:   @return
     *
     * @return List<Department>   返回所有部门
     */
    @Override
    public List<Department> getDatagrid(HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String moduleId = request.getParameter("moduleId");
        Map maps = modulePrivService.getModulePriv(users, moduleId);
        maps.put("deptParent999","true");
        maps.put("deptDisplay","1");
        List<Department> departmentList = departmentMapper.getDatagridByDisplay(maps);
        Map<String,String> map = new HashMap<>();
        Set<String> set = new HashSet<>();
        StringBuffer bb1 = new StringBuffer();
        StringBuffer bb2 = new StringBuffer();
        StringBuffer bb3 = new StringBuffer();
        StringBuffer bb4 = new StringBuffer();
        try {
            for (Department dept : departmentList) {
                String manager = dept.getManager();
                if (manager != null && !manager.equals("")){
                    String[] Ids = manager.split(",");
                    for (String id : Ids) {
                        set.add(id);
                    }
                }
                String assistant = dept.getAssistantId();
                if (assistant != null && !assistant.equals("")){
                    String[] Ids = assistant.split(",");
                    for (String id : Ids) {
                        set.add(id);
                    }
                }
                String leader1 = dept.getLeader1();
                if (leader1 != null && !leader1.equals("")){
                    String[] Ids = leader1.split(",");
                    for (String id : Ids) {
                        set.add(id);
                    }
                }
                String leader2 = dept.getLeader2();
                if (leader2 != null && !leader2.equals("")){
                    String[] Ids = leader2.split(",");
                    for (String id : Ids) {
                        set.add(id);
                    }
                }
            }
            List<Map<String, String>> mapList = usersMapper.getNamesById(set);
            for (Map<String, String> stringStringMap : mapList) {
                map.put(stringStringMap.get("key"),stringStringMap.get("value"));
            }
            mapList = null;
            set = null;

            for (Department dept : departmentList) {
                String manager = dept.getManager();
                if (manager != null && !manager.equals("")){
                    String[] Ids = manager.split(",");
                    for (String id : Ids) {
                        String name2 = map.get(id);
                        if(!"".equals(name2)){
                            bb1.append(name2);
                            bb1.append(",");
                            dept.setManager(bb1.toString().substring(0, bb1.toString().length() - 1));
                        }
                        else{
                            dept.setManager("");
                        }
                    }
                    bb1.delete(0, bb1.length());
                }
                String assistant = dept.getAssistantId();
                if (assistant != null && !assistant.equals("")){
                    String[] Ids = assistant.split(",");
                    for (String id : Ids) {
                        String name3 = map.get(id);
                        if (name3 != null) {
                            if(!"".equals(name3)){
                                bb2.append(name3);
                                bb2.append(",");
                                dept.setAssistantId(bb2.toString().substring(0, bb2.toString().length() - 1));
                            }else{
                                dept.setAssistantId("");
                            }
                        }
                    }
                    bb2.delete(0, bb2.length());
                }
                String leader1 = dept.getLeader1();
                if (leader1 != null && !leader1.equals("")){
                    String[] Ids = leader1.split(",");
                    for (String id : Ids) {
                        String name4 = map.get(id);
                        if (name4 != null) {
                            if(!"".equals(name4)){
                                bb3.append(name4);
                                bb3.append(",");
                                dept.setLeader1(bb3.toString().substring(0, bb3.toString().length() - 1));
                            }else{
                                dept.setLeader1("");
                            }
                        }
                    }
                    bb3.delete(0, bb3.length());
                }
                String leader2 = dept.getLeader2();
                if (leader2 != null && !leader2.equals("")){
                    String[] Ids = leader2.split(",");
                    for (String id : Ids) {
                        String name5 = map.get(id);
                        if (name5 != null) {
                            if(!"".equals(name5)){
                                bb4.append(name5);
                                bb4.append(",");
                                dept.setLeader2(bb4.toString().substring(0, bb4.toString().length() - 1));
                            }else{
                                dept.setLeader2("");
                            }
                        }
                    }
                    bb4.delete(0, bb4.length());
                }
            }
         } catch (Exception e) {
              e.getMessage();
        }
//        StringBuffer bb1 = new StringBuffer();
//        StringBuffer bb2 = new StringBuffer();
//        StringBuffer bb3 = new StringBuffer();
//        StringBuffer bb4 = new StringBuffer();
//        for (Department dept : departmentList) {
//            try {
//                String manag = dept.getManager();
//                String assistant = dept.getAssistantId();
//                String leader1 = dept.getLeader1();
//                String leader2 = dept.getLeader2();
//                if (manag != null && !manag.equals("")) {
//                    String[] mm = manag.split(",");
//                    for (int j = 0; j < mm.length; j++) {
//                        String name2 = usersService.getUserNameById(mm[j]);
//                        if (name2 != null) {
//                            if(!"".equals(name2)){
//                                bb1.append(name2);
//                                bb1.append(",");
//                                dept.setManager(bb1.toString().substring(0, bb1.toString().length() - 1));
//                            }
//                            else{
//                                dept.setManager("");
//                            }
//                        }
//                    }
//                    bb1.delete(0, bb1.length());
//                }
//                if (assistant != null && !assistant.equals("")) {
//                    String[] cc = assistant.split(",");
//                    for (int j = 0; j < cc.length; j++) {
//                        String name3 = usersService.getUserNameById(cc[j]);
//                        if (name3 != null) {
//                            if(!"".equals(name3)){
//                                bb2.append(name3);
//                                bb2.append(",");
//                                dept.setAssistantId(bb2.toString().substring(0, bb2.toString().length() - 1));
//                            }else{
//                                dept.setAssistantId("");
//                            }
//                        }
//                    }
//                    bb2.delete(0, bb2.length());
//                }
//                if (leader1 != null && !leader1.equals("")) {
//                    String[] dd = leader1.split(",");
//                    for (int j = 0; j < dd.length; j++) {
//                        String name4 = usersService.getUserNameById(dd[j]);
//                        if (name4 != null) {
//                            if(!"".equals(name4)){
//                                bb3.append(name4);
//                                bb3.append(",");
//                                dept.setLeader1(bb3.toString().substring(0, bb3.toString().length() - 1));
//                            }else{
//                                dept.setLeader1("");
//                            }
//                        }
//                    }
//                    bb3.delete(0, bb3.length());
//                }
//                if (leader2 != null && !leader2.equals("")) {
//                    String[] ee = leader2.split(",");
//                    for (int j = 0; j < ee.length; j++) {
//                        String name5 = usersService.getUserNameById(ee[j]);
//                        if (name5 != null) {
//                            if(!"".equals(name5)){
//                                bb4.append(name5);
//                                bb4.append(",");
//                                dept.setLeader2(bb4.toString().substring(0, bb4.toString().length() - 1));
//                            }else{
//                                dept.setLeader2("");
//                            }
//                        }
//                    }
//                    bb4.delete(0, bb4.length());
//                }
//            }catch (Exception e){
//
//            }
//
//        }
        return departmentList;
    }



    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:42:50
     * 方法介绍:   根据部门id获取部门
     * 参数说明:   @param deptId  部门id
     * 参数说明:   @return
     *
     * @return Department   返回部门信息
     */
    @Override
    public Department getDeptById(Integer deptId) {
        Department department = departmentMapper.getDeptById(deptId);
        if (department!=null){
            department.setDeptParentName(departmentMapper.getDeptNameByDeptId(department.getDeptParent()));
        }
        return department;
    }

    //根据部门id获取部门 返回map
    @Override
    public Map<String, Object> getDeptMapById(Integer deptId) {
        Map<String, Object> deptMapById = departmentMapper.getDeptMapById(deptId);
        return deptMapById;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:43:07
     * 方法介绍:   根据部门id删除部门
     * 参数说明:   @param deptId  部门id
     *
     * @return void   无
     */
    @Override
    public void deleteDept(Integer deptId) {
        departmentMapper.deleteDept(deptId);

    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:43:23
     * 方法介绍:   修改部门
     * 参数说明:   @param department 部门信息
     *
     * @return void   无
     */
    @Override
    public void editDept(Department department) {
        if(department.getDeptParent()!=null && department.getDeptParent()!=0){
            Department dept=departmentMapper.getDeptById(department.getDeptParent());
            department.setDeptNo(dept.getDeptNo()+department.getDeptNo());
        }
        departmentMapper.editDept(department);
    }

    //修改部门 传递map
    @Override
    public void editDeptMap(Map department) {
        departmentMapper.editDeptMap(department);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:43:34
     * 方法介绍:   保存部门
     * 参数说明:   @param department 部门信息
     *
     * @return void    无
     */
    @Override
    public void insertDept(Department department) {
        departmentMapper.insertDept(department);
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:43:51
     * 方法介绍:   多条件查询部门信息
     * 参数说明:   @param department  部门信息
     * 参数说明:   @return
     *
     * @return List<Department>    返回部门信息
     */
    @Override
    public List<Department> getDeptByMany(Department department) {
        List<Department> list = departmentMapper.getDeptByMany(department);
        return list;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 上午10:50:37
     * 方法介绍:   获取子目录
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize 页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<Department>   返回子目录
     */
    @Override
    public List<Department> getChDept(int deptId) {
        List<Department> list = departmentMapper.getChDept(deptId);

        return list;
    }


    @Override
    public List<Department> getChDept(Map<String,Object> map) {
        List<Department> list = departmentMapper.getChDeptByDisplay(map);
        return list;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 下午1:55:52
     * 方法介绍:   递归获取所有本部门一级部门
     * 参数说明:   @param deptParent 部门
     * 参数说明:   @return
     *
     * @return List<Department>  返回父级部门信息
     */
    @Override
    public Department getFatherDept(int deptParent) {
        Department dep = departmentMapper.getFatherDept(deptParent);
        if(dep!=null){
            if (dep.getDeptParent()==0) {
                return dep;
            }
            return getFatherDept(dep.getDeptParent());
        }
        return null;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 下午1:55:52
     * 方法介绍:   递归获取所有父级部门信息
     * 参数说明:   @param deptParent 部门
     * 参数说明:   @param list 用于存储父级部门信息
     * 参数说明:   @return
     *
     * @return List<Department>  返回父级部门信息
     */
    @Override
    public List<Department> getFatherDept(int deptParent, List<Department> list) {
        Department dep = departmentMapper.getFatherDept(deptParent);
        if(dep==null){
            return list;
        }
        if (dep.getDeptParent() != 0) {
            list.add(dep);
        } else {
            list.add(dep);
            return list;
        }
        return getFatherDept(dep.getDeptParent(), list);
    }
    @Override
    public String longDepName(int deptId){
        Department department = departmentMapper.getFatherDept(deptId);
        List<Department> l = new ArrayList<Department>();
        List<Department> list = this.getFatherDept(department.getDeptId(),l);
        StringBuffer sb = new StringBuffer();
        for (int i = list.size() - 2; i >=0; i--) {
            sb.append(list.get(i).getDeptName());
            if (i > 0) {
                sb.append("/");
            }
        }
        return sb.toString();
    }

    @Override
    public String longDepNames(Integer deptId) {// 部门人员排序时的长名称
        Department department = departmentMapper.getFatherDept(deptId);
        List<Department> l = new ArrayList<Department>();
        List<Department> list = new ArrayList<>();
        if (department != null) {
            list = this.getFatherDept(department.getDeptId(), l);
        }
        StringBuffer sb = new StringBuffer();
        for (int i = list.size() - 1; i >= 0; i--) {
            sb.append(list.get(i).getDeptName());
            if (i > 0) {
                sb.append("/");
            }
        }
        return sb.toString();
    }


    @Override
    public List<Department> getChDeptByNo(String deptNo) {
        List<Department> list = departmentMapper.getBydeptNo(deptNo);
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月2日 下午3:52:49
     * 方法介绍:   获取部门人员
     * 参数说明:   @param deptId 部门id
     * 参数说明:   @return
     *
     * @return List<Department> 返回部门信息
     */
    @Override
    public List<Department> getChDtUser(int deptId) {
        List<Department> list = departmentMapper.getChDeptUser(deptId);

        return list;

    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月25日 下午2:13:28
     * 方法介绍:   获取当前部门下子部门与部门人员
     * 参数说明:   @param deptId 部门id
     * 参数说明:   @return
     *
     * @return List<Department> 返回部门编号
     */
    @Override
    public List<Department> getChDeptUser(int deptId) {

        List<Department> list = new ArrayList<Department>();
        String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
        }catch (Exception e){

        }

        list = departmentMapper.getChDeptUser(deptId);



        String order = null;
        try {
            order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
        }catch (Exception e){

        }
        try {
            if ("1".equals(order)) {
                for (Department list5 : list) {   //排序  先获得这个用户在在该部门排序号
                    if (!StringUtils.checkNull(list5.getUserId())){
                        list5.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(list5.getUserId(), deptId).getOrderNo());
                    }
                }
                Collections.sort(list, (Department a, Department b) -> a.getUserDeptNo() - b.getUserDeptNo());
                //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        List<Department> list1 = departmentMapper.getChDept(deptId);
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

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月3日 上午9:04:34
     * 方法介绍:   获取部门下人数
     * 参数说明:   @param deptNo 部门排序号
     * 参数说明:   @return
     *
     * @return int 数量
     */
    @Override
    public int getCountChDeptUser(String deptNo) {
        int count = departmentMapper.getCountChDeptUser(deptNo);
        return count;
    }

    @Override
    public List<Department> listDept() {
        List<Department> allDept = departmentMapper.getDatagrid();
        //获取deptParent=0的部门
        List<Department> deptParent = departmentMapper.getDepartmentByParet();
        for (Department department : deptParent) {
            if (ifChilds(allDept, department.getDeptId())) {//存在子集
                List<Department> resultList = new ArrayList<Department>();
                resultList = getChildList(allDept, department.getDeptId(), resultList);
                department.setChild(resultList);
            }else{
                //无子级设置为true
                department.setIsLeaf(true);
            }
        }

        return deptParent;
    }

    public List<Department> listDept(Map<String,Object> maps) {
        List<Department> allDept = departmentMapper.getDatagridByDisplay(maps);
        return parseTree(allDept);
    }

    /**
     * 格式化成树形结构
     *
     * @param list 要操作的列表
     * @return 树形结果列表
     */
    public List<Department> parseTree(List<Department> list) {
        if(list.isEmpty()){
            return list;
        }
        List<Department> resultList = new ArrayList<>();
        // 知道有多少个元素，那么在创建的时候直接指定长度，避免因扩容而浪费时间
        Map<Integer, Department> tmpMap = new HashMap<>(list.size());
        for (Department t : list) {
            tmpMap.put(t.getDeptId(), t);
        }
        for (Department t : list) {
          /*1、tmpMap存储的是以id为key的键值对。
           2、如果以pid为key可以从tmpMap中取出对象，则说明该元素是子级元素。
           3、如果以pid为key不能从tmpMap中取出对象，则说明该元素是最上层元素。
           4、子级元素放在父级元素的children中。
           5、最上层元素添加到结果中
           */
            Department tmap = tmpMap.get(t.getDeptParent());
            if (tmap != null && t.getDeptParent() != 0) {
                if (null == tmap.getChild()) {
                    tmap.setChild(new ArrayList<>());
                }
                tmap.getChild().add(t);
            } else {
                resultList.add(t);
            }
        }
        return resultList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 8:01
     * @函数介绍: 查询所有部门，子部门存储在父部门的list属性集合中
     * @参数说明: 无
     * @return: List<Department></Department>
     **/
    @Override
    public List<Department> getFatherChildDept() {
        List<Department> allDeptList = departmentMapper.getDatagrid();
        List<Department> departments = addChildDeptToFather(allDeptList);

        return departments;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 8:05
     * @函数介绍: 将子部门存储在父部门的list属性集合中
     * @参数说明: @param List<Department></Department>
     * @return: List<Department>
     **/
    public List<Department> addChildDeptToFather(List<Department> departments) {
        ArrayList<Department> departmentList = new ArrayList<Department>();
        for (int i = 0; i < departments.size(); i++) {
            Department department = departments.get(i);
            department.setChild(new ArrayList<Department>());
            Integer deptId = department.getDeptId();
            for (int j = 0; j < departments.size(); j++) {
                if (departments.get(j).getDeptParent().equals(deptId)) {
                    department.getChild().add(departments.get(j));
                }

            }


            departmentList.add(department);
        }

        ArrayList<Department> fatherDeptList = new ArrayList<Department>();
        //某些部门作为子部门添加后，就从departmentList中移除，因为该部门存存储在父部门的属性中
        for (int i = 0; i < departmentList.size(); i++) {
            Integer deptParrentId = departmentList.get(i).getDeptParent();
            //parentId为0的是顶级部门
            if (deptParrentId == 0) {
                fatherDeptList.add(departmentList.get(i));
            }
        }

        return fatherDeptList;
    }

    /**
     * 获取父id下的子集合
     */
    public static List<Department> getChildList(List<Department> list, int deptId, List<Department> reList) {
        for (Department department : list) {
            if (department.getDeptParent() == deptId) {//查询下级菜单
                //List<Department> l = department.getChild();
                reList.add(department);
                if (ifChilds(list, department.getDeptId())) {
                    getChildList(list, department.getDeptId(), reList);
                }else{
                    department.setIsLeaf(true);
                }
            }
        }
        return reList;
    }


    /**
     * 判断是否存在子集
     */
    public static boolean ifChilds(List<Department> list, int deptId) {
        boolean flag = false;
        for (Department department : list) {
            if (department.getDeptParent() == deptId) {
                flag = true;
                break;
            }
        }
        return flag;
    }

    @Override
    public Department getFirstDept(String deptNo) {
        Department dep = departmentMapper.getFirstDept(deptNo);
        return dep;

    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月3日 下午19:21:05
     * 方法介绍:   根据部门id进行批量修改部门主管和部门助理
     * 参数说明:   @param departments
     * 参数说明:   @return int 修改条数
     *
     * @return List<String>  返回用户姓名串
     */
    @Transactional
    @Override
    public ToJson<Department> batchUpdateDeptById(String departments) {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        int count = 0;
        try {
            JSONArray jsonArray = JSONArray.parseArray(departments);
            List<Department> departmentList = new ArrayList<Department>();
            Department department = new Department();
            for (int i = 0, len = jsonArray.size(); i < len; i++) {
                JSONObject jsonJ = jsonArray.getJSONObject(i);
                Integer deptId = jsonJ.getInteger("deptId");
                String manager = jsonJ.getString("manager");
                String assistantId = jsonJ.getString("assistantId");
                // if(deptId!=null&&(!StringUtils.checkNull(manager)||!StringUtils.checkNull(assistantId))){
                department.setDeptId(deptId);
                department.setManager(manager);
                department.setAssistantId(assistantId);
                count += departmentMapper.batchUpdateDeptById(department);
                //    departmentList.add(department);
                //     }
            }
            //  count=departmentMapper.batchUpdateDeptById(departmentList);
            if (count != 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl batchUpdateDeptById:" + e);
        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月3日 下午19:21:05
     * 方法介绍:   修正部门级次（排序号）
     * 参数说明:   @param departments
     *
     * @return ToJson
     */
    @Transactional
    @Override
    public void updateDeptNo(Integer deptParent, String deptParentNo) {
        int deptNo = 0;
        List<Department> list = departmentMapper.getChDept(deptParent);
        if (list.size() != 0) {
            for (Department department : list) {
                int deptId = department.getDeptId();
                deptNo += 5;
                StringBuffer sb = new StringBuffer();
                sb.append(deptParentNo).append(org.apache.commons.lang3.StringUtils.repeat("0", 3 - String.valueOf(deptNo).length())).append(String.valueOf(deptNo));
                String deptNostr = sb.toString();
                Department department1 = new Department();
                department1.setDeptId(deptId);
                department1.setDeptNo(deptNostr);
                departmentMapper.updateDeptNoByDeptId(department1);
                updateDeptNo(deptId, deptNostr);
            }
        }
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午10:10:00
     * 方法介绍:   部门信息导出
     */
    @Override
    public ToJson<Department> outputDepartment(HttpServletRequest request, HttpServletResponse response) {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try {
            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("OA部门信息导出", 9);
            String[] secondTitles = {"部门名称", "部门排序号", "上级部门", "部门电话", "部门传真", "部门地址", "部门职能", "是否分级机构", "是否全局部门"};
            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
            Department userPriv = new Department();
            List<Department> departmentList = departmentMapper.getAllDepartment();
            for (Department department : departmentList) {
                int deptParent = department.getDeptParent();
                String deptParentName = departmentMapper.getFatherDeptName(deptParent);
                if (StringUtils.checkNull(deptParentName) || deptParentName.equals("离职")) {
                    department.setDeptParentName("");
                } else {
                    department.setDeptParentName(deptParentName);
                }
            }
            // String[] beanProperty = {user.getDep().getDeptName(),"userName","userPrivName", "roleAuxiliaryName","online","sex","online","telNoDept","telNoDept","departmentPhone","email"};
            String[] beanProperty = {"deptName", "deptNo", "deptParentName", "telNo", "faxNo", "deptAddress", "deptFunc", "isOrg", "gDept"};
            HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, departmentList, beanProperty);
            ServletOutputStream out = response.getOutputStream();

            String filename = "OA部门导出.xls"; //考虑多语言
            filename = FileUtils.encodeDownloadFilename(filename,
                    request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition",
                    "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl outputDepartment:" + e);
        }
        return json;
    }

    @Override
    public List<Department> getAllDep(int deptId, int deptParent, List<Department> allDep) {
        List<Department> list = departmentMapper.getChDept(deptParent);
        if (list.size() != 0) {
            for (Department department : list) {
                deptId = department.getDeptId();
                Department department1 = new Department();
                department1.setDeptId(deptId);
                allDep.add(department);
                getAllDep(deptId, deptId, allDep);
            }
        }
        return allDep;
    }


    @Override
    public boolean checkDep(Department dep,int edit) {//edit==1修改，0添加 ,返回值不存在为true
        List<Department> list = departmentMapper.checkDep(dep.getDeptName());
        if (edit == 0) {
            if (list != null && list.size() > 0) {
                for (Department d : list) {
                    if (d.getDeptParent().equals(dep.getDeptParent())) {
                        return false;
                    }
                }
                return true;
            } else {
                return true;
            }
        } else {
            Department old = departmentMapper.getDeptById(dep.getDeptId());
            if (list != null && list.size() > 0) {
                for (Department d : list) {
                    if (d.getDeptParent().equals(dep.getDeptParent()) && !d.getDeptName().equals(old.getDeptName())) {
                        return false;
                    }
                }
                return true;
            } else {
                return true;
            }
        }
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午18:00:05
     * 方法介绍:   获取所有部门信息
     *
     * @return List<Department>
     */
    @Override
    public ToJson<Department> getAllDepartment() {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try {
            List<Department> departmentList = departmentMapper.getAllDepartment();
            for (Department department : departmentList) {
                StringBuffer manager = new StringBuffer();
                StringBuffer assistant = new StringBuffer();
                if (!StringUtils.checkNull(department.getManager())) {
                    String[] managerArray = department.getManager().split(",");
                    for (String managerId : managerArray) {
                        Users users = usersService.getUsersByuserId(managerId);
                        if (users != null) {
                            manager.append(users.getUserName() + ",");
                        }
                    }
                }
                if (!StringUtils.checkNull(department.getAssistantId())) {
                    String[] assistantArray = department.getAssistantId().split(",");
                    for (String assistantId : assistantArray) {
                        Users users = usersService.getUsersByuserId(assistantId);
                        if (users != null) {
                            assistant.append(users.getUserName() + ",");
                        }
                    }
                }
                department.setManagerStr(manager.toString());
                department.setAssistantStr(assistant.toString());
            }
            json.setObj(departmentList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl getAllDepartment:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月19日 下午18:00:05
     * 方法介绍:   判断该部门是否有人
     *
     * @return ToJson<Department>
     */
    @Override
    public int judgeHashUser(String deptId) {
        int flag = 0;
        try {
            int count = usersMapper.judgeHashUser(deptId);
            if (count != 0) {
                flag = 1;
            }
        } catch (Exception e) {

            L.e("DepartmentServiceImpl judgeHashUser:" + e);
        }
        return flag;
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/25
     * @介绍：获取部门和全部人员信息并生成XML
     * @参数：
     */
    @Override
    public ToJson<Department> getAllDepartAndUsers(HttpServletRequest request, HttpServletResponse response) {
        ToJson<Department> json = new ToJson<Department>();
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        //String name = rb.getString("mysql.driverClassName");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer=new StringBuffer();
      /*  if (os.toLowerCase().startsWith("win")) {
            sb = sb.append(rb.getString("upload.win"));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
        }*/
        if(osName.toLowerCase().startsWith("win")){
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if(uploadPath.indexOf(":")==-1){
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath()+File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if(basePath.indexOf("/xoa")!=-1){
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2=basePath.substring(0,index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
            buffer=buffer.append(rb.getString("upload.win"));
        }else{
            sb=sb.append(rb.getString("upload.linux"));
            buffer=buffer.append(rb.getString("upload.linux"));
        }
        InputStream inputStream = null;
        OutputStream os = null;
        try {
            // 查询第一级部门
            List<Department> firstDeparts = departmentMapper.getChDept(0);
            // 递归获取所有部门和人员信息
            getChildAndUsers(firstDeparts);
            // 生成xml文件
            // 创建根节点 并设置它的属性 ;
            Element root = new Element("org").setAttribute("a", "0").setAttribute("b", "北京高速波软件有限公司");
            // 将根节点添加到文档中；
            Document Doc = new Document(root);

            writeXML(firstDeparts, root);

            String path = sb.append("/org.xml").toString();

            // 使xml文件 缩进效果
            Format format = Format.getPrettyFormat();
            XMLOutputter XMLOut = new XMLOutputter(format);
            XMLOut.output(Doc, new FileOutputStream(path));

            File file = new File(path);
            // 如果文件不存在
            if (!file.exists()) {
                json.setFlag(1);
                json.setMsg("xml文件不存在");
                return json;
            }
            String zipPath = path.replace("org.xml","org.zip");

            ZipUtils.zip(path,zipPath);

            File zipFile = new File(path);
            // 如果文件不存在
            if (!zipFile.exists()) {
                json.setFlag(1);
                json.setMsg("zip文件不存在");
                return json;
            }

            response.setContentType("application/x-zip-compressed");
            response.setHeader("content-disposition", "attachment;filename=" + "org.zip");

            inputStream = new FileInputStream(new File(zipPath));
            os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }

            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        } finally {
            // 这里主要关闭。
            try {
                if (os != null) {
                    os.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return json;
    }


    /**
     * @作者：张航宁
     * @时间：2017/7/26
     * @介绍：写入XML
     * @参数：
     */
    private void writeXML(List<Department> firstDeparts, Element root) throws Exception {
        if (firstDeparts != null && firstDeparts.size() > 0) {
            for (Department d : firstDeparts) {
                // 创建节点 book;
                Element elements = new Element("d");
                elements.setAttribute("a", d.getDeptId().toString()).setAttribute("b", d.getDeptName()).setAttribute("c", "0");
                root.addContent(elements);
                if (d.getUsers() != null && d.getUsers().size() > 0) {
                    for (Users u : d.getUsers()) {
                        Element elementU = new Element("u");
                        elementU.setAttribute("a", u.getUid().toString()).setAttribute("b", u.getUserName())
                                .setAttribute("c", u.getUserPriv().toString()).setAttribute("d", u.getSex())
                                .setAttribute("e", u.getOnStatus() == null ? "" : u.getOnStatus().trim()).setAttribute("h", u.getByname())
                                .setAttribute("i", u.getDeptId().toString()).setAttribute("k", u.getMobilNo() == null ? "" : u.getMobilNo().trim())
                                .setAttribute("m", u.getOicqNo() == null ? "" : u.getOicqNo().trim()).setAttribute("l", u.getEmail() == null ? "" : u.getEmail().trim())
                                .setAttribute("p1", u.getNotLogin().toString());
                        elements.addContent(elementU);
                    }
                }
                if (d.getChild() != null && d.getChild().size() > 0) {
                    // 递归
                    writeXML(d.getChild(), elements);
                } else {
                    continue;
                }
            }
        }
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/25
     * @介绍：递归获取部门和用户信息的封装方法
     * @参数：
     */
    private void getChildAndUsers(List<Department> departs) throws Exception {
        for (Department d : departs) {
            List<Department> chDept = departmentMapper.getChDept(d.getDeptId());
            List<Users> usersByDeptId = usersMapper.getUsersByDeptId(d.getDeptId());
            if (usersByDeptId != null && usersByDeptId.size() > 0) {
                d.setUsers(usersByDeptId);
            }
            if (chDept != null && chDept.size() > 0) {
                d.setChild(chDept);
                getChildAndUsers(chDept);
            } else {
                continue;
            }
        }
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午10:05:05
     * 方法介绍:   根据部门id设置分级机构和分级机构管理员
     * @return String
     */
    @Override
    public ToJson<Department> setClassifyOrgByDeptId(String deptIds,String classifyOrgAdmin,int classifyOrg){
        ToJson<Department> json = new ToJson<Department>(1, "error");
        int count=0;
        Department department=new Department();
        department.setClassifyOrgAdmin(classifyOrgAdmin);
        department.setClassifyOrg(classifyOrg);
        try{
            if(!StringUtils.checkNull(deptIds)){
                String[] deptIdArray=deptIds.split(",");
                for(String deptId:deptIdArray){
                    department.setDeptId(Integer.valueOf(deptId));
                    count+=departmentMapper.setClassifyOrgByDeptId(department);
                }
            }
            if(count>0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl setClassifyOrgByDeptId:"+e);
        }
        return  json;
    }

    /**
     * 递归删除分级机构
     * @param deptIds
     * @param department
     * @param count
     * @return
     */
    void delClassify(String deptIds,Department department,int count){
        List<Integer> deptIdList=departmentMapper.getDeptIdByParent(Integer.valueOf(deptIds));
        if(deptIdList.size()>0){
            for(int deptId:deptIdList){
                department.setDeptId(deptId);
                count+=departmentMapper.setClassifyOrgByDeptId(department);
                delClassify(String.valueOf(deptId),department,count);
            }
        }

    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午10:14:05
     * 方法介绍:   获取分级机构信息
     * @return String
     */
    @Override
    public ToJson<Department> getAllClassifyOrg(){
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try{
            List<Department> fenDeptList=departmentMapper.getAllClassifyOrg();
            Set<Integer> romoveDept =new HashSet<Integer>();
            for(Department fen:fenDeptList){//主分级
                List<Department> tempList=new ArrayList<>();
                for(Department dept:fenDeptList){//获取子部门
                    if(fen.getDeptId().intValue()==dept.getDeptParent().intValue()){
                        romoveDept.add(dept.getDeptId().intValue());
                        tempList.add(dept);
                    }
                }
                fen.setChild(tempList);
            }
            List<Department> removeChildList = new ArrayList<Department>(); ;
            for(Integer romveDeptId:romoveDept){
                for(Department a:fenDeptList){
                    if(a.getDeptId().intValue()==romveDeptId){
                        removeChildList.add(a);
                    }
                }
            }
            fenDeptList.removeAll(removeChildList);
            json.setObj(fenDeptList);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl getAllClassifyOrg:"+e);
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午16:57:05
     * 方法介绍:   根据权限获取分级机构信息(分级机构管理员)
     * @return String
     */
    @Override
    public ToJson<Department> getClassifyOrgByAdmin(HttpServletRequest request){
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
//            List<Department> departs = new ArrayList<>();
//            Department orgbyDeptId = getClassifyOrgbyDeptId(user.getDeptId());
//            departs.add(orgbyDeptId);
//            Map<String,Object> map=new HashMap<>();
//            map.put("uid",user.getUid());

//            List<Department> result = new ArrayList<>();
//            List<Department> fendepartmentList=departmentMapper.getClassifyOrgByAdmin(map);
//            if("OA管理员".equals(user.getUserPrivName())){
//                result =departmentMapper.getAllDepartment();
//            }else if(""){
//
//            }else {
//
//            }
            //需要增加分级机构管理员或管理员的过滤条件，展示下级部门
//            Map<String,Object> map=new HashMap<>();
//            map.put("uid",user.getUid());
//            List<Department> departments =departmentMapper.getAllDepartment();
//            List<Department> fendepartmentList=departmentMapper.getClassifyOrgByAdmin(map);
//            List result=getDiguiOrg(departments,fendepartmentList);

//            Collections.sort(result, new Comparator<Department>() {
//                @Override
//                public int compare(Department o1, Department o2) {
//                    //升序
//                    return o2.getDeptNo().compareTo(o1.getDeptNo());
//                }
//            });

            //List<Department> result = getDepartmentByClassifyOrg(user,false,false);

            //2019-12-09修改为，只能查看属于分级机构的部门。部门不是分级机构则不在此接口的返回数据范围内
            List<Department> departs = new ArrayList<>();
            //是否开启分级机构设置.如没有直接返回()
            String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
            if(StringUtils.checkNull(sysPara) || sysPara.equals("0")){
                departs.clear();
            }

            //判断用户的部门以及辅助部门中是否包含不是分级机构的部门，去查询此离部门最近的上级分级机构
            //拼接用户的部门和辅助部门
            //2020/4/30 修改为只有管理员才能查看分级机构
            String deptIds = "";
            List<String> org = departmentMapper.getOrg(String.valueOf(user.getUid()));
            for (String s:org){
                deptIds = deptIds + s+",";
            }
            //String deptIds = user.getDeptId() + "," + user.getDeptIdOther();
            //判断用户的部门和辅助部门中不是分级机构的，就去查询此离部门最近的上级分级机构替换此部门
            String[] deptIdSplit = deptIds.split(",");
            for (int i = 0; i < deptIdSplit.length; i++) {
                if (!StringUtils.checkNull(deptIdSplit[i])) {
                    Department classifyOrgbyDeptId = getClassifyOrgbyDeptId(Integer.valueOf(deptIdSplit[i]));
                    //如果到了最上级依旧不是分级机构，返回空
                    if (classifyOrgbyDeptId!=null && classifyOrgbyDeptId.getClassifyOrg()!=null && classifyOrgbyDeptId.getClassifyOrg() == 0) {
                        departs.clear();

                    }
                    //将此部门添加到返回值中
                    departs.add(classifyOrgbyDeptId);
                    //将此部门的下级部门添加到返回值中
                    //获取deptParent为当前部门的部门
                    List<Department> deptParent = departmentMapper.selectObjectByParent(classifyOrgbyDeptId.getDeptId());
                    if(!Objects.isNull(deptParent) && deptParent.size() > 0) {
                        //设置了不包含下级分支机构，只保留不是分级机构的部门
                        if("0".equals(classifyOrgbyDeptId.getIsSubOrg())){
                            deptParent = deptParent.stream().filter(department -> department.getClassifyOrg() == 0).collect(Collectors.toList());
                        }
                        getChilds(deptParent,classifyOrgbyDeptId.getIsSubOrg());
                        classifyOrgbyDeptId.setChild(deptParent);
                    }
                }
            }
            // 去重 https://www.timeit.cn/post-180.html
            List<Department> distinctUsers = departs.stream()
                    .filter(distinctByKey(Department::getDeptId))
                    .collect(Collectors.toList());

            json.setObj(distinctUsers);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl getClassifyOrgByAdmin:"+e);
        }
        return  json;
    }

    public static <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor) {
        Map<Object, Boolean> seen = new ConcurrentHashMap<>();
        return object -> seen.putIfAbsent(keyExtractor.apply(object), Boolean.TRUE) == null;
    }

    @Override
    public List<Department> getDepartmentByParet(){
        return departmentMapper.getDepartmentByParet();
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月28日 下午11:25:05
     * 方法介绍:   根据父部门id判断是否有分级机构
     * @return String
     */
    @Override
    public int selClaNumByParentId(int deptId){
        return departmentMapper.selClaNumByParentId(deptId);
    }


    @Override
    public List<Department> getDepByNo(String deptNo){
        List<Department> list = departmentMapper.getDepByNo(deptNo);
        return list;
    }

    @Override
    public List<Department> getDepByCode(String deptCode) {
        List<Department> list = departmentMapper.getBydeptCode(deptCode);
        return list;
    }

    @Override
    public ToJson<Department> importDepartment(HttpServletRequest request, HttpServletResponse response, MultipartFile file) {
        ToJson<Department> json = new ToJson<Department>();
        try {
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
            StringBuffer buffer=new StringBuffer();
      /*  if (os.toLowerCase().startsWith("win")) {
            sb = sb.append(rb.getString(""));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
        }*/
            if(osName.toLowerCase().startsWith("win")){
                //sb=sb.append(rb.getString(""));
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if(uploadPath.indexOf(":")==-1){
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath()+File.pathSeparator;
                    //获取截取后的路径
                    String str2 = "";
                    if(basePath.indexOf("/xoa")!=-1){
                        //获取字符串的长度
                        int length = basePath.length();
                        //返回指定字符在此字符串中第一次出现处的索引
                        int index = basePath.indexOf("/xoa");
                        //从指定位置开始到指定位置结束截取字符串
                        str2=basePath.substring(0,index);
                    }
                    path = path.append(str2 + "/xoa");
                }
                path.append(uploadPath);
                buffer=buffer.append(rb.getString("upload.win"));
            }else{
                path=path.append(rb.getString("upload.linux"));
                buffer=buffer.append(rb.getString("upload.linux"));
            }
            // 判断是否为空文件
            if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                json.setFlag(1);
                return json;
            } else {
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                    int pos = fileName.indexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    File dest = new File(path.toString(), newFileName);
                    File pathfile= new File(String.valueOf(path));
                    if (!pathfile.exists()) {// 如果目录不存在
                        pathfile.mkdirs();// 创建文件夹
                    }
                    file.transferTo(dest);

                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径
                    String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                    InputStream in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    Row row = sheetObj.getRow(0);
                    int colNum = row.getPhysicalNumberOfCells();
                    int lastRowNum = sheetObj.getLastRowNum();
                    Department entity = null;
                    int successCount = 0;
                    int updateCount = 0;
                    int failCount = 0;
                    for (int i = 1; i <= lastRowNum; i++) {
                        entity = new Department();
                        row = sheetObj.getRow(i);
                        if (row != null) {
                            for (int j = 0; j < colNum; j++) {
                                Cell cell = row.getCell(j);
                                if (cell != null) {
                                    cell.setCellType(CellType.STRING);
                                    switch (j) {
                                        case 0:
                                            // 部门名称
                                            entity.setDeptName(cell.getStringCellValue());
                                            break;
                                        case 1:
                                            // 部门序号
                                            entity.setDeptNo(cell.getStringCellValue());
                                            break;
                                        case 2:
                                            // 上级部门
                                            entity.setDeptParentName(cell.getStringCellValue());
                                            break;
                                        case 3:
                                            // 部门电话
                                            entity.setTelNo(cell.getStringCellValue());
                                            break;
                                        case 4:
                                            // 部门传真
                                            entity.setFaxNo(cell.getStringCellValue());
                                            break;
                                        case 5:
                                            // 部门地址
                                            entity.setDeptAddress(cell.getStringCellValue());
                                            break;
                                        case 6:
                                            // 部门职能
                                            entity.setDeptFunc(cell.getStringCellValue());
                                            break;
                                        case 7:
                                            // 是否为分支机构
                                            if("是".equals(cell.getStringCellValue().trim())){
                                                entity.setClassifyOrg(1);
                                            }else if("否".equals(cell.getStringCellValue().trim())||"不是".equals(cell.getStringCellValue().trim())){
                                                entity.setClassifyOrg(0);
                                            }
                                            break;
                                        case 8:
                                            // 是否全局部门
                                            if("是".equals(cell.getStringCellValue().trim())){
                                                entity.setgDept(1);
                                            }else if("否".equals(cell.getStringCellValue().trim())||"不是".equals(cell.getStringCellValue().trim())){
                                                entity.setgDept(0);
                                            }
                                            break;
                                    }
                                }
                            }
                        }

                        // 部门名称和部门编号不能为空，部门排序号的长度是3的倍数
                        if(StringUtils.checkNull(entity.getDeptName()) || StringUtils.checkNull(entity.getDeptNo()) || entity.getDeptNo().length() % 3 != 0){
                            failCount++;
                            entity.setNameRoNoNull(1);
                            continue;
                        }

                        // 判断上级部门名称匹配且排序号去掉后三位后相等，才是父级部门
                        if (!StringUtils.checkNull(entity.getDeptParentName()) && entity.getDeptNo().length() > 3) {
                            List<Department> deptParentList = departmentMapper.getDeptByName(entity.getDeptParentName());
                            if (!CollectionUtils.isEmpty(deptParentList)) {
                                for (Department parent : deptParentList) {
                                    if (entity.getDeptParentName().equals(parent.getDeptName())
                                            && entity.getDeptNo().substring(0, entity.getDeptNo().length() - 3).equals(parent.getDeptNo())) {
                                        entity.setDeptParent(parent.getDeptId());
                                    }
                                }
                            }

                            // 要导入的上级部门不存在
                            if (entity.getDeptParent() == null) {
                                failCount++;
                                entity.setNoParent(1);
                                continue;
                            }
                        }


                        // 新增或者修改
                        List<Department> departmentList = departmentMapper.getDepByNo(entity.getDeptNo());
                        if (CollectionUtils.isEmpty(departmentList)) {
                            departmentMapper.insertDept(entity);
                            successCount++;
                        } else {
                            entity.setDeptId(departmentList.get(0).getDeptId());
                            departmentMapper.editDept(entity);
                            updateCount++;
                        }
                    }

                    Department result = new Department();
                    result.setImportCount(lastRowNum);
                    result.setSuccessCount(successCount);
                    result.setUpdateCount(updateCount);
                    result.setFailCount(failCount);
                    json.setFlag(0);
                    json.setObject(result);
                    dest.delete();
                } else {
                    json.setMsg("文件类型不正确！");
                    json.setFlag(1);
                    return json;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("数据保存异常");
            json.setFlag(1);
        }
        return json;
    }


    /**
     * 根据父部门查询其子部门编号是否重复
     * @param deptParent
     * @return
     */
    @Override
    public ToJson<Department> selDeptNoByDeptParent(String deptParent, String deptNo, int editFlag, String proDeptNo){
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try{
            if(!StringUtils.checkNull(deptParent) && deptParent.contains(",")){
                deptParent=deptParent.substring(0,deptParent.length()-1);
            }
            Map<String,Object> map=new HashMap<>();
            map.put("deptParent",deptParent);
            if(editFlag==1){
                if(!StringUtils.checkNull(deptParent) && !deptParent.equals("0")){
                    Department dept=departmentMapper.getDeptById(Integer.valueOf(deptParent));
                    proDeptNo=dept.getDeptNo()+proDeptNo;
                    map.put("deptNo",proDeptNo);
                }else{
                    map.put("deptNo",proDeptNo);
                }
            }
            List<String> deptNoList=departmentMapper.selDeptNoByDeptParent(map);
            for (String deptNoStr : deptNoList) {
                if (deptNoStr.equals(deptNo)) {
                    json.setFlag(1);
                    json.setMsg("repeat");
                    return json;
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl selDeptNoByDeptParent:"+e);
        }
        return  json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年11月4日 下午10:22:51
     * 方法介绍:   获取根据部门名称模糊查询
     * 参数说明:   @return
     * @return     List<Department> 返回部门信息
     */
    @Override
    public ToJson<Department> selByLikeDeptName(String deptName) {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try {
            List<Department> departmentList = departmentMapper.selByLikeDeptName(deptName);
            StringBuffer bb1 = new StringBuffer();
            StringBuffer bb2 = new StringBuffer();
            StringBuffer bb3 = new StringBuffer();
            StringBuffer bb4 = new StringBuffer();
            for (Department dept : departmentList) {
                String manag = dept.getManager();
                String assistant = dept.getAssistantId();
                String leader1 = dept.getLeader1();
                String leader2 = dept.getLeader2();
                if (manag != null && !manag.equals("")) {
                    String[] mm = manag.split(",");
                    for (int j = 0; j < mm.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(mm[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb1.append(usersByuserId.getUserName());
                            bb1.append(",");
                            dept.setManager(bb1.toString().substring(0, bb1.toString().length() - 1));
                        }
                    }
                    bb1.delete(0, bb1.length());
                }
                if (assistant != null && !assistant.equals("")) {
                    String[] cc = assistant.split(",");
                    for (int j = 0; j < cc.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(cc[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb2.append(usersByuserId.getUserName());
                            bb2.append(",");
                            dept.setAssistantId(bb2.toString().substring(0, bb2.toString().length() - 1));

                        }
                    }
                    bb2.delete(0, bb2.length());
                }
                if (leader1 != null && !leader1.equals("")) {
                    String[] dd = leader1.split(",");
                    for (int j = 0; j < dd.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(dd[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb3.append(usersByuserId.getUserName());
                            bb3.append(",");
                            dept.setLeader1(bb3.toString().substring(0, bb3.toString().length() - 1));

                        }
                    }
                    bb3.delete(0, bb3.length());
                }
                if (leader2 != null && !leader2.equals("")) {
                    String[] ee = leader2.split(",");
                    for (int j = 0; j < ee.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(ee[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb4.append(usersByuserId.getUserName());
                            bb4.append(",");
                            dept.setLeader2(bb4.toString().substring(0, bb4.toString().length() - 1));

                        }
                    }
                    bb4.delete(0, bb4.length());
                }
            }
            json.setObj(departmentList);
            json.setMsg("ok");
            json.setFlag(0);
        }catch (Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl selByLikeDeptName:"+e);
        }
        return json;
    }

    private List<Department> getDiguiOrg(List<Department> allDepartments,List<Department> fenDepartments) {

        List<Department> resultList = new ArrayList<Department>();
        if (fenDepartments == null && fenDepartments.size() < 1) {
            return resultList;
        }

        Department department = null;
        Set<Integer> romoveDept =new HashSet<Integer>();
        for (Department fendepartment : fenDepartments) {
            department = getChDeptByDigui(allDepartments, fendepartment.getDeptId(), fendepartment,romoveDept);
            resultList.add(department);
        }
        List<Department> removeChildList = new ArrayList<Department>(); ;
        for(Integer romveDeptId:romoveDept){
            for(Department a:resultList){
                if(a.getDeptId().intValue()==romveDeptId){
                    removeChildList.add(a);
                }
            }
        }
        resultList.removeAll(removeChildList);
        return resultList;
    }


    private Department getChDeptByDigui(List<Department> allDepartments, Integer deptId,Department mine,Set<Integer> set) {
        List<Department> childList =new ArrayList<Department>();
        for(Department department:allDepartments){
            if(department.getDeptParent().intValue()==deptId.intValue()){
                Department parentDept= getParentDept(allDepartments,department.getDeptParent());
                set.add(department.getDeptId().intValue());
                if(parentDept!=null){
                    if("1".equals(parentDept.getIsSubOrg())){
                        department = getChDeptByDigui(allDepartments,department.getDeptId(),department,set);
                        childList.add(department);
                    }else{
                        if(!"1".equals(String.valueOf(department.getClassifyOrg()))){
                            department = getChDeptByDigui(allDepartments,department.getDeptId(),department,set);
                            childList.add(department);
                        }
                    }
                }else{
                    department = getChDeptByDigui(allDepartments,department.getDeptId(),department,set);
                    childList.add(department);
                }
            }
        }
        mine.setChild(childList);
        return mine;
    }

    private  Department getParentDept(List<Department> allDepartments, Integer parentId){
        for(Department department:allDepartments){
            if(department.getDeptId().intValue()==parentId.intValue()){
                return department;
            }
        }
        return  null;
    }

    @Override
    public ToJson<Department> getAllChildDept(Integer deptId){
        ToJson<Department> toJson=new ToJson<>(1,"error");
        if(deptId==null){
            toJson.setMsg("参数不正确");
            return toJson;
        }
        List<Department> resultList=new ArrayList<>();
        try{
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String moduleId = request.getParameter("moduleId");
            Map maps = modulePrivService.getModulePriv(users, moduleId);
            maps.put("deptParent999","true");
            maps.put("deptDisplay","1");
            List<Department> list=departmentMapper.getDatagridByDisplay(maps);
            maps.put("deptId",deptId);
            List<Department> data = departmentMapper.getDatagridByDisplay(maps);
            if(!Objects.isNull(data) && data.size() > 0){
                toJson.setObj1(data.get(0));
            }
            //所有部门
            if(deptId!=0){
                resultList=getChildList(list,deptId,resultList);
            }else{
                resultList.addAll(list);
            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
            toJson.setObj(resultList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
    @Override
    public ToJson<Department> getDepartmentYj(){
        ToJson<Department> toJson=new ToJson<>();
        try{
            List<Department> list= departmentMapper.getDepartmentYj();
            toJson.setObj(list);
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<Department> settingInfoList() {
        ToJson<Department> toJson=new ToJson<>();
        try{
            List<Department> list=departmentMapper.settingInfoList();
            if(list.size()>0){
                toJson.setObject(list);
            }
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("flase");
        }
        return toJson;
    }

    @Override
    public ToJson settingAdd(String  deptId,String smsGateAccount) {
        ToJson toJson=new ToJson<>();
        try{
            if(deptId==null||deptId.equals("")){
                toJson.setMsg("请选择部门");
                toJson.setFlag(1);
                return toJson;
            }
            String [] id=deptId.split(",");
            int line=departmentMapper.settingAdd(id,smsGateAccount);
            if(line>0){
                toJson.setMsg("新增成功");
                toJson.setFlag(0);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("flase");
        }
        return toJson;
    }

    @Override
    public ToJson settingDel(String deptId) {
        ToJson toJson=new ToJson<>();
        try{
            String [] id=deptId.split(",");
            int line=departmentMapper.settingDel(id);
            if(line>0){
                toJson.setMsg("删除成功");
                toJson.setFlag(0);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("flase");
        }
        return toJson;
    }

    @SuppressWarnings("all")
    @Override
    public String getDpNameByIds(String userIds, String flag) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接部门名称的字符串
        StringBuffer sb = new StringBuffer();
        String[] temp = userIds.split(flag);

        List<Department> deptByUserIds = departmentMapper.getDeptNameByUserIds(temp);

        for (int i = 0,length=deptByUserIds.size(); i < length; i++){
            Integer userName = deptByUserIds.get(i).getDeptParent();
            if (i < temp.length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }

        return sb.toString();
    }
    @SuppressWarnings("all")
    @Override
    public String getDParentNameByIds(String userIds, String flag) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接父级部门名称的字符串
        StringBuffer sb = new StringBuffer();
        String[] temp = userIds.split(flag);

        List<Department> deptPNameByUserIds = departmentMapper.getDParentNameByIds(temp);

        for (int i = 0,length=deptPNameByUserIds.size(); i < length; i++){
            String userName = deptPNameByUserIds.get(i).getDeptName();
            if (i < temp.length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }

        return sb.toString();
    }
    //查找最近的部门
    @Override
    public Department queryDeptParent(Integer deptId) {
        Department dept = departmentMapper.getFatherDept(deptId);
        if(dept.getDeptParent()==0){ //如果是一级菜单
            if(dept.getClassifyOrg()==1) {//又是分级机构
                return dept;
            }else{
                return null; //返回所有
            }
        }else{ //有父部门且不是一级部门
            //如果该部门是分级机构
            if(dept.getClassifyOrg()==1){
                return dept;
            }else{
                return queryDeptParent(dept.getDeptParent());
            }
        }

    }

    @Override
    public ToJson getDepartment(Integer deptId) {
        ToJson json = new ToJson<>();
        try {
            List<Department> list = departmentService.getDepartmentByParet();
            for (Department department1 : list) {
                int a = departmentService.getCountChDeptUser(department1.getDeptNo());
                List<Department> list2 = departmentService.getChDept(department1.getDeptId());
                if (list2.size() != 0) {
                    department1.setIsHaveCh("1");
                } else {
                    department1.setIsHaveCh("0");
                }
            }
            json.setFlag(0);
            json.setObj(list);
            json.setMsg("success");
            return json;
        }catch (Exception e){
            e.printStackTrace();
        }
        return json;
    }

    //递归查询父部门----废弃
    @Override
    public String getByDeptName(Integer deptId,String resultName) {
        String name ="";
        //获得上级部门
        Department departmentParent = departmentMapper.getFatherDept(deptId);
        if(departmentParent!=null){//兼容特殊部门父级dept_id为空异常
            resultName = departmentParent.getDeptName()+"/"+resultName;
            if(departmentParent.getDeptParent()!=0){
                name = getByDeptName(departmentParent.getDeptParent(),resultName);
                System.out.print(name);
            }else{
                return resultName;
            }
        }else{
            return resultName;
        }
        return name;
    }

    //查询父部门列表
    @Override
    public String getByDeptName(Integer deptParentId,String deptNo,String resultName) {
        //如果deptNo长度等于3,证明是最顶级部门,不需要找父部门,直接返回
        if(deptNo.length() <= 3 || deptParentId == 0){
            return resultName;
        }
        //根据deptNo每去掉最后三位为一个in条件去查询部门层级一条线列表
        int arrayLength = deptNo.length() / 3;
        int index = arrayLength - 1;
        String[] deptNos = new String[arrayLength];
        for(int i = 0; i < index; i++){
            int length = deptNo.length();
            if(length > 3) {
                deptNos[i] = deptNo.substring(0, length - 3);
                deptNo = deptNos[i];
            }else {
                deptNos[i] = deptNo;
            }
        }
        List<Department> list =  departmentMapper.selectDeptNameByDeptNos(deptNos);
        //为了兼容项目中有重复的deptNo,所以需要使用deptParentId来参与匹配
        if(!Objects.isNull(list) && list.size() > 0) {
            for (int i = 0; i < index; i++) {
                for (Department department : list) {
                    if (deptParentId.equals(department.getDeptId()) && deptNos[i].equals(department.getDeptNo())) {
                        resultName = department.getDeptName()+"/"+resultName;
                        deptParentId = department.getDeptParent();
                    }
                }
            }
        }
        return resultName;
    }

    @Override
    public ToJson<Department> selByLikeDeptNameAndDeptNo(String deptName, String deptNo) {
        ToJson<Department> json = new ToJson<Department>(1, "error");
        try {
            String[] deptNoStr = deptNo.split(",");
            //List<Department> departmentList = departmentMapper.selByLikeDeptName(deptName);
            Map map = new HashMap();
            map.put("deptName",deptName);
            map.put("deptNo",deptNoStr);
            List<Department> departmentList = departmentMapper.selByLikeDeptNameAndDeptNo(map);
            StringBuffer bb1 = new StringBuffer();
            StringBuffer bb2 = new StringBuffer();
            StringBuffer bb3 = new StringBuffer();
            StringBuffer bb4 = new StringBuffer();
            for (Department dept : departmentList) {
                String manag = dept.getManager();
                String assistant = dept.getAssistantId();
                String leader1 = dept.getLeader1();
                String leader2 = dept.getLeader2();
                if (manag != null && !manag.equals("")) {
                    String[] mm = manag.split(",");
                    for (int j = 0; j < mm.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(mm[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb1.append(usersByuserId.getUserName());
                            bb1.append(",");
                            dept.setManager(bb1.toString().substring(0, bb1.toString().length() - 1));
                        }
                    }
                    bb1.delete(0, bb1.length());
                }
                if (assistant != null && !assistant.equals("")) {
                    String[] cc = assistant.split(",");
                    for (int j = 0; j < cc.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(cc[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb2.append(usersByuserId.getUserName());
                            bb2.append(",");
                            dept.setAssistantId(bb2.toString().substring(0, bb2.toString().length() - 1));

                        }
                    }
                    bb2.delete(0, bb2.length());
                }
                if (leader1 != null && !leader1.equals("")) {
                    String[] dd = leader1.split(",");
                    for (int j = 0; j < dd.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(dd[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb3.append(usersByuserId.getUserName());
                            bb3.append(",");
                            dept.setLeader1(bb3.toString().substring(0, bb3.toString().length() - 1));

                        }
                    }
                    bb3.delete(0, bb3.length());
                }
                if (leader2 != null && !leader2.equals("")) {
                    String[] ee = leader2.split(",");
                    for (int j = 0; j < ee.length; j++) {
                        Users usersByuserId = usersService.findUsersByuserId(ee[j]);
                        if (usersByuserId!=null&&usersByuserId.getUserName() != null) {
                            bb4.append(usersByuserId.getUserName());
                            bb4.append(",");
                            dept.setLeader2(bb4.toString().substring(0, bb4.toString().length() - 1));

                        }
                    }
                    bb4.delete(0, bb4.length());
                }
            }
            json.setObj(departmentList);
            json.setMsg("ok");
            json.setFlag(0);
        }catch (Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentServiceImpl selByLikeDeptName:"+e);
        }
        return json;
    }
    @Override
    public List<Integer> getDeptByDeptNoStr(String[] deptNo){
        return departmentMapper.getDeptByDeptNoStr(deptNo);

    }



    @Autowired
    private HierarchicalGlobalMapper hierarchicalGlobalMapper;
    @Autowired
    private ModulePrivService modulePrivService;

    //flag 设置为true，返回没有树结构的结果集，deptIdOtherFlag为true 则拼接辅助部门
    @Override
    public List<Department>  getDepartmentByClassifyOrg(Users user, boolean flag, boolean deptIdOtherFlag){

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //增加部门管理范围过滤，moduleId不为空，根据模块id和用户uid查询用户是否设置了模块管理范围
        String moduleId = request.getParameter("moduleId");
        Map maps = modulePrivService.getModulePriv(user, moduleId);

        //增加是否查询失效部门判断,默认只查询有效部门，deptDisplay参数有值则有效和失效部门都在查询范围
        String deptDisplay = request.getParameter("deptDisplay");
        if(!Objects.isNull(user.getDeptDisplay())){
            deptDisplay = null;
        }else {
            deptDisplay = "1";
        }
        maps.put("deptDisplay",deptDisplay);

        List<Department> departs = new ArrayList<>();
        //是否开启分级机构设置.如没有直接返回
        String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
        //流程选人控件 是否允许选择本分支机构之外人员，默认是允许（0-否，1-是）
        String isSelectBranch = request.getParameter("isSelectBranch");
        if (!StringUtils.checkNull(isSelectBranch) && isSelectBranch.equals("1")) {
            if(flag) {
                departs = departmentMapper.getDatagridByDisplay(maps);
                for (int i = 0; i < departs.size(); i++) {
                    Department o = departs.get(i);
                    if (o.getDeptId() == 0) {
                        departs.remove(i);
                    }
                }
            }else {
                departs = listDept(maps);
            }
            securityApprovalService.removeSecrecyDept(departs);
            return departs;
        } else {
            if(StringUtils.checkNull(sysPara) || sysPara.equals("0") || (!StringUtils.checkNull(request.getParameter("allType")) && "1".equals(request.getParameter("allType")))){
                if(flag) {
                    departs = departmentMapper.getDatagridByDisplay(maps);
                    for (int i = 0; i < departs.size(); i++) {
                        Department o = departs.get(i);
                        if (o.getDeptId() == 0) {
                            departs.remove(i);
                        }
                    }
                }else {
                    departs = listDept(maps);
                }
                securityApprovalService.removeSecrecyDept(departs);
                return departs;
            }
        }

        //查询该用户是否被设置了全局查看权限
        HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(user.getUserId(), user.getDeptId(), user.getUserPriv());

        //用户是管理员，或者设置了用户拥有全局查看权限，返回全部部门
        if(user.getUserPriv()==1 || globalId != null){
            if(flag) {
                departs = departmentMapper.getDatagridByDisplay(maps);
                for (int i = 0; i < departs.size(); i++) {
                    Department o = departs.get(i);
                    if (o.getDeptId() == 0) {
                        departs.remove(i);
                    }
                }
            }else {
                departs = listDept(maps);
            }
            securityApprovalService.removeSecrecyDept(departs);
            return departs;
        }

        //判断用户的部门以及辅助部门中是否包含不是分级机构的部门，去查询此离部门最近的上级分级机构，如果最上级部门也不是分级机构，则返回全部部门
        //拼接用户的部门和辅助部门
        String deptIds = "";
        if(deptIdOtherFlag && !StringUtils.checkNull(user.getDeptIdOther())){
            deptIds = user.getDeptId() + "," + user.getDeptIdOther();
        }else {
            deptIds = user.getDeptId().toString();
        }
        //判断用户的部门和辅助部门中不是分级机构的，就去查询此离部门最近的上级分级机构替换此部门
        String[] deptIdSplit = deptIds.split(",");
        /*List<Department> allDept = new ArrayList<>();
        if(!flag){
            allDept = departmentMapper.getDatagrid();
        }*/

        for (int i = 0; i < deptIdSplit.length; i++) {
            if (!StringUtils.checkNull(deptIdSplit[i])) {
                Department classifyOrgbyDeptId = getClassifyOrgbyDeptId(Integer.valueOf(deptIdSplit[i]));
                //如果到了最上级依旧不是分级机构，返回全部部门
                if (classifyOrgbyDeptId.getClassifyOrg() == 0) {
                    if(flag) {
                        departs = departmentMapper.getDatagridByDisplay(maps);
                        securityApprovalService.removeSecrecyDept(departs);
                        return departs;
                    }else {
                        departs = listDept(maps);
                        securityApprovalService.removeSecrecyDept(departs);
                        return departs;
                    }
                }
                //将此部门添加到返回值中
                departs.add(classifyOrgbyDeptId);

                //设置了不包含下级分支机构，只保留不是分级机构的部门
                if("0".equals(classifyOrgbyDeptId.getIsSubOrg())){
                    maps.put("classifyOrg",0);
                }
                //将此部门的下级部门添加到返回值中
                if(flag) {
                    getChild(departs, classifyOrgbyDeptId.getDeptId(),maps);
                }else {
//                    if (ifChilds(allDept, classifyOrgbyDeptId.getDeptId())) {//存在子集
//                        List<Department> resultList = new ArrayList<Department>();
//                        resultList = getChildList(allDept, classifyOrgbyDeptId.getDeptId(), resultList);
//                        classifyOrgbyDeptId.setChild(resultList);
//                    }

                    //获取deptParent为当前部门的部门
                    maps.put("deptParent",classifyOrgbyDeptId.getDeptId());
                    List<Department> deptParent = departmentMapper.selectObjectByParentAndDisplay(maps);
                    if(!Objects.isNull(deptParent) && deptParent.size() > 0) {
                        getChilds(deptParent,classifyOrgbyDeptId.getIsSubOrg());
                        classifyOrgbyDeptId.setChild(deptParent);
                    }
                }
            }
        }

        //去重
        List<Department> distinctList = new ArrayList();
        departs.stream().filter(distinctByKey(d -> d.getDeptId())) //filter保留true的值
                .forEach(distinctList::add);
        securityApprovalService.removeSecrecyDept(distinctList);
        return distinctList;
    }

    private void getChilds(List<Department> departs,String isSubOrg) {
        for (Department d : departs) {
            List<Department> chDept = departmentMapper.getChDept(d.getDeptId());
            //设置了不包含下级分支机构，只保留不是分级机构的部门
            if("0".equals(isSubOrg)){
                chDept = chDept.stream().filter(department -> department.getClassifyOrg() == 0).collect(Collectors.toList());
            }
            if (chDept != null && chDept.size() > 0) {
                d.setChild(chDept);
                getChilds(chDept,isSubOrg);
            } else {
                continue;
            }
        }
    }

    private Department getClassifyOrgbyDeptId(Integer deptId){
        Department classifyOrgbyDeptId = departmentMapper.getClassifyOrgbyDeptId(deptId);

        //判断是否是分支机构 （0：不是，1：是）为空的话默认不是
        if (classifyOrgbyDeptId.getClassifyOrg()==null){
            classifyOrgbyDeptId.setClassifyOrg(0);
        }
        if(classifyOrgbyDeptId != null
                && classifyOrgbyDeptId.getClassifyOrg()!=null && classifyOrgbyDeptId.getClassifyOrg() != 1
                && classifyOrgbyDeptId.getDeptParent()!=null && classifyOrgbyDeptId.getDeptParent() != 0){
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

    private void getChild(List<Department> departs,Integer detpd,Map<String,Object> maps) {
        maps.put("deptParent",detpd);
        List<Department> chDept = departmentMapper.selectObjectByParentAndDisplay(maps);
        if (chDept.size() >= 0) {
            for (Department de : chDept) {
                if (!departs.contains(de)) {
                    departs.add(de);
                    getChild(departs, de.getDeptId(),maps);
                }
            }
        }
    }

    /**
     *  返回值为0，则系统没有开启分级机构
     *  返回值为1，系统开启了分级机构并且用户为管理员或是拥有全局查看权限
     *  返回值为2，系统开启了分级机构但用户不是管理员并且没有全局查看权限
     */
    @Override
    public int checkOrgFlag(Users user){
        //是否开启分级机构设置.如没有直接返回
        String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
        if(StringUtils.checkNull(sysPara) || sysPara.equals("0")){
            return 0;
        }

        //查询该用户是否被设置了全局查看权限
        HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(user.getUserId(), user.getDeptId(), user.getUserPriv());

        //用户是管理员，或者设置了用户拥有全局查看权限，返回全部部门
        if(user.getUserPriv()==1 || globalId != null){
            return 1;
        }
        return 2;
    }

    @Override
    public LimsJson<Department> userDeptOrder(Integer userId) {
        LimsJson<Department> json = new LimsJson<Department>(1, "error");
        try {
            Users users = usersMapper.getByUserId(String.valueOf(userId));
            String[] split = (users.getDeptId()+","+users.getDeptIdOther()).split(",");
            List<Department> departmentList= departmentMapper.userDeptOrder(split);

            json.setCode(0);
            json.setObject(departmentList);
            json.setMsg("ok");

        } catch (Exception e) {
            json.setCode(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }
    @Override
    public LimsJson<Department> userUpdata() {//把user里的数据全部同步到userdeptorder
        LimsJson<Department> json = new LimsJson<Department>(1, "error");
        try {
            List<Users> users = usersMapper.userUpdata();
            for (Users user:users){
                String[] split = (user.getDeptId()+","+user.getDeptIdOther()).split(",");
                List<Department> departmentList= departmentMapper.userDeptOrder(split);
                for (Department department:departmentList){
                    UserDeptOrder userDeptOrder = new UserDeptOrder();
                    userDeptOrder.setDeptId(department.getDeptId());
                    userDeptOrder.setUserId(user.getUserId());
                    userDeptOrder.setOrderNo(user.getUserNo());
                    userDeptOrder.setPostId(user.getPostId());
                    UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(user.getUserId(), department.getDeptId());
                    if (userDeptOrder1==null){// 防止部门 和辅助部门设置同一个
                        userDeptOrderMapper.insertSelective(userDeptOrder);
                    }
                }
            }


            json.setCode(0);
            //json.setObject(departmentList);
            json.setMsg("ok");

        } catch (Exception e) {
            json.setCode(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }


    @Override
    public LimsJson<UserDeptOrder> deptOrder(String userId) {
        LimsJson<UserDeptOrder> json = new LimsJson<UserDeptOrder>(1, "error");
        try {
            List<UserDeptOrder> userDeptOrders = userDeptOrderMapper.selectUser(userId);
            for (UserDeptOrder userDeptOrder:userDeptOrders){
                //userDeptOrder.setDeptName(departmentService.longDepName(userDeptOrder.getDeptId()));
                userDeptOrder.setDeptName(departmentService.longDepNames(userDeptOrder.getDeptId()));
                //userDeptOrder.setDeptFatherName(departmentMapper.getFatherDept(departmentMapper.getDeptById(userDeptOrder.getDeptId()).getDeptParent()).getDeptName());
                try {
                    if (0!=userDeptOrder.getPostId()){//除去数据库默认值0
                        userDeptOrder.setPostName(dutiesManagementMapper.getUserPostId(userDeptOrder.getPostId()).getPostName());
                    }
                }catch (Exception e){
                    json.setMsg("职务被删除");
                }

                userDeptOrder.setUserName(usersMapper.findUsersByuserId(userDeptOrder.getUserId()).getUserName());
            }
            json.setCode(0);
            json.setObject(userDeptOrders);
            //json.setMsg("");

        } catch (Exception e) {
            json.setCode(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }

    @Override
    public LimsJson<UserDeptOrder> updeptOrder(String userDeptOrders) {
        LimsJson<UserDeptOrder> json = new LimsJson<UserDeptOrder>(1, "error");
        List<UserDeptOrder> userDeptOrders1 = JSONArray.parseArray(userDeptOrders,UserDeptOrder.class);
        try {
            for (UserDeptOrder userDeptOrder:userDeptOrders1){
                userDeptOrderMapper.updateByPrimaryKeySelective(userDeptOrder);
                Users usersByuserId = usersMapper.findUsersByuserId(userDeptOrder.getUserId());
                if (usersByuserId.getDeptId().equals(userDeptOrder.getDeptId())){//说明是主部门
                    usersByuserId.setUserNo(userDeptOrder.getOrderNo());
                    usersByuserId.setPostId(userDeptOrder.getPostId());
                    usersMapper.updateByUserId(usersByuserId);
                }
            }
            json.setCode(0);
            //json.setObject(departmentList);
            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {
            json.setCode(1);
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }
    //查询是否存在未分配部门
    @Override
    public ToJson<Department> selectUnallocated() {
        ToJson json=new ToJson();
        try {
            Department department = departmentMapper.selectUnallocated();
            if(department==null){
                json.setFlag(0);
                json.setMsg("false");
            }else {
                json.setFlag(0);
                json.setMsg("ok");
                json.setObject(department);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }
    //将部门设置未未分配部门
    @Override
    public ToJson updateDept(Integer deptId) {
        ToJson json=new ToJson();
        try {
            List departments = departmentMapper.selectChildDept();//获取所有可以设置的部门
            if(departments.contains(deptId)){
                //修改
                Department department=new Department();
                department.setDeptId(deptId);
                department.setDeptParent(99999998);
                department.setDeptFunc("NOT_ASSIGN_DEPT");
                department.setDeptName("未分配部门人员");
                departmentMapper.updateDept(department);
                json.setMsg("设置成功！");
            }else{
                json.setMsg("此部门含有子集部门，禁止设置！");
            }
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }

    @Override
    public ToJson getDeptTop(HttpServletRequest request) {
        ToJson json=new ToJson();
        try {
            List<Department> departments = departmentMapper.getDepartmentYj();
            json.setObj(departments);
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson getChildDept(HttpServletRequest request,Integer deptId) {
        ToJson toJson = new  ToJson();
        if (deptId==null){
            List<Department> obj = getDeptTop(request).getObj();
            for (Department department:obj){
                List<Department> childDeptPlus = getChildDeptPlus(department.getDeptId());
                department.setChild(childDeptPlus);
            }
            toJson.setObject(obj);
            toJson.setFlag(0);
            return toJson;
        }
        Department deptById = departmentMapper.getDeptByIdPlus(deptId);
        List<Department> departmentList = getChildDeptPlus(deptById.getDeptId());
        deptById.setChild(departmentList);
        List<Department> list = new ArrayList<Department>();
        list.add(deptById);
        toJson.setObject(list);
        toJson.setFlag(0);
        return toJson;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/11
     * 方法介绍: 查询本部门的所有上级
     * 参数说明: [request, deptId]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @Override
    public ToJson<Department> selectDepartmentTop(Integer deptId) {
        ToJson<Department> json = new ToJson<>(1, "error");
        Map<String, Object> map = new HashMap<>();
        String deptParent = deptId + ",";
        deptParent += selectDepartmentTopData(deptId);
        if (!StringUtils.checkNull(deptParent)){
            map.put("deptTop", deptParent);
        }
        json.setFlag(0);
        json.setMsg("ok");
        json.setObject(map);
        return json;
    }

    private List<Department> getChildDeptPlus(Integer deptById) {
        List<Department> list1 = departmentMapper.getChDeptPlus(deptById);
        for (Department dep : list1) {
                List<Department> childDeptPlus = getChildDeptPlus(dep.getDeptId());
                dep.setChild(childDeptPlus);
            }
        return list1;
    }

    //获取部门类型的判断
    @Override
    public ToJson getDeptByType(HttpServletRequest request,Department department) {
        ToJson json=new ToJson();

        return json;
    }

    @Override
    public ToJson exportDeptInfo(HttpServletRequest request, HttpServletResponse response) {
        ToJson toJson = new ToJson<>();
        try {
            //源数据
            List<Department> departmentByClassifyOrg = listGetStree(departmentMapper.getDatagrid());
            //创建poi导出数据对象
            HSSFWorkbook workbookTemp = ExcelUtil.makeExcelHead("部门信息", 6);//40
            String[] secondTitles = {"部门id", "部门排序号", "部门编码","部门名称"};
            HSSFWorkbook workbook = ExcelUtil.makeSecondHead(workbookTemp, secondTitles);
            HSSFSheet sheet = workbook.getSheet("部门信息");
            //设置第n列 宽度
            sheet.setColumnWidth(0, 20 * 256);
            sheet.setColumnWidth(1, 20 * 256);
            sheet.setColumnWidth(2, 20 * 256);
            sheet.setColumnWidth(3, 20 * 512);
            // 遍历上面数据库查到的数据
            for (Department testDomain : departmentByClassifyOrg) {
                //填充数据
                HSSFRow dataRow = sheet.createRow(sheet.getLastRowNum() + 1);
                //进行填充
                dataRow.createCell(0).setCellValue(testDomain.getDeptId());
                dataRow.createCell(1).setCellValue(testDomain.getDeptNo());
                dataRow.createCell(2).setCellValue(testDomain.getDeptCode());
                dataRow.createCell(3).setCellValue(testDomain.getDeptName());
                testDomain.setColNumber(1);
                if (testDomain.getChild() != null) {
                    child(testDomain.getChild(), sheet, testDomain);
                }
            }
            ServletOutputStream out = response.getOutputStream();
            String filename = "部门信息.xls"; //考虑多语言
            filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition",
                    "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public List<Map<String, Object>> getDeptByManyMap(Map map) {
       return departmentMapper.getDeptByManyMap(map);
    }

    //list转为树结构---子项目
    public static List<Department> listGetStree(List<Department> list) {
        List<Department> treeList = new ArrayList<Department>();
        for (Department tree : list) {
            //找到根
            if (tree.getDeptParent() == 0) {
                treeList.add(tree);
            }
            //找到子
            for (Department treeNode : list) {
                if (treeNode.getDeptParent().equals(tree.getDeptId())) {
                    if (tree.getChild() == null) {
                        tree.setChild(new ArrayList<Department>());
                    }
                    tree.getChild().add(treeNode);
                }
            }
        }
        return treeList;
    }

    public void child(List<Department> childList, HSSFSheet sheet, Department parentDomain) {
        for (Department testDomain : childList) {
            HSSFRow childRow = sheet.createRow(sheet.getLastRowNum() + 1);
            // 填充数据
            StringBuffer stringBuffer = new StringBuffer();
            for (Integer integer = 0; integer < parentDomain.getColNumber(); integer++) {
                stringBuffer.append("       ");
            }
            childRow.createCell(0).setCellValue(testDomain.getDeptId());
            childRow.createCell(1).setCellValue(testDomain.getDeptNo());
            childRow.createCell(2).setCellValue(testDomain.getDeptCode());
            childRow.createCell(3).setCellValue(stringBuffer.toString() + testDomain.getDeptName());
            testDomain.setColNumber(parentDomain.getColNumber() + 2);
            if (testDomain.getChild() != null) {
                child(testDomain.getChild(), sheet, testDomain);
            }
        }
    }

    @Override
    public ToJson ifJurisdiction(HttpServletRequest request, String updateUserId, Integer deptId, String deptIdOther) {
        ToJson json = new ToJson();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        boolean ifSave = true;
        List<String> org = departmentMapper.getOrg(String.valueOf(users.getUid()));
        if (org.size() > 0) {//分级机构管理员
            Users userId = usersMapper.getUserId(updateUserId);
            //著部门
            String updateUserLongDeptName = longDepName(userId.getDeptId());
            if (!updateUserLongDeptName.contains("本部") && deptId != null) {
                String s = longDepName(deptId);
                if (s.contains("本部")) {
                    ifSave = false;
                    json.setData(ifSave);
                    return json;
                }
            }
            if (!StringUtils.checkNull(deptIdOther)) {
                for (String dept : deptIdOther.split(",")) {
                    String updateUserLongDeptOtherName = longDepName(Integer.parseInt(dept));
                    if (updateUserLongDeptOtherName.contains("本部")) {
                        ifSave = false;
                        json.setData(ifSave);
                        return json;
                    }
                }
            }
        }
        json.setData(ifSave);
        return json;
    }

    public String selectDepartmentTopData(Integer deptId){
        String deptParent = "";
        Department department = departmentMapper.selectByDeptId(deptId);
        if (department != null && department.getDeptParent() != null && department.getDeptParent() != 0){
            deptParent += department.getDeptParent().toString();
            deptParent += "," + selectDepartmentTopData(Integer.valueOf(deptParent));
        }
        return deptParent;
    }

    // 获取当前用户，管理的分支机构（包含管理范围）
    // flag是否需要返回部门
    public List<Department>  getDepartmentByClassifyOrg1(Users user, boolean flag){

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        // 增加部门管理范围过滤，moduleId不为空，根据模块id和用户uid查询用户是否设置了模块管理范围
        String moduleId = request.getParameter("moduleId");
        Map<String,Object> maps = modulePrivService.getModulePriv(user, moduleId);

        // 增加是否查询失效部门判断,默认只查询有效部门，deptDisplay参数有值则有效和失效部门都在查询范围
        Integer deptDisplay = 1;
        if(!Objects.isNull(user.getDeptDisplay())){
            deptDisplay = null;
        }
        maps.put("deptDisplay",deptDisplay);

        // 是否开启分级机构设置.如没有直接返回
        String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
        if(StringUtils.checkNull(sysPara) || sysPara.equals("0") || (!StringUtils.checkNull(request.getParameter("allType")) && "1".equals(request.getParameter("allType")))){
            return null;
        }

        // 查询该用户是否被设置了全局查看权限
        HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(user.getUserId(), user.getDeptId(), user.getUserPriv());

        // 角色或者辅助角色是管理员，或者设置了用户拥有全局查看权限，返回全部部门
        if(user.getUserPriv() == 1 || (!StringUtils.checkNull(user.getUserPrivOther()) && Arrays.asList(user.getUserPrivOther().split(",")).contains("1")) || globalId != null){
            if (flag) {
                return departmentMapper.getDatagridByDisplay(maps);
            }else {
                return null;
            }
        }

        // 获取当前用户，管理的分支机构
        Map<String, Object> map = new HashMap<>();
        map.put("uid", user.getUid());
        List<Department> departmentList = departmentMapper.getClassifyOrgByAdmin(map);
        List<Department> resultList = new ArrayList<>();// 最终返回数据
        if (!CollectionUtils.isEmpty(departmentList)) {
            // 递归获取全部下属部门
            for (Department department : departmentList) {
                resultList.add(department);
                getAllChDept(department, resultList, department.getIsSubOrg());
            }
        } else {
            resultList = departmentList;
        }
        return resultList;
    }

    // 递归获取全部下属部门
    public void getAllChDept(Department department, List<Department> resultList, String isSubOrg) {
        //获取下属部门
        List<Department> chDept = departmentMapper.getChDept(department.getDeptId());
        if (!CollectionUtils.isEmpty(chDept)) {
            //设置了不包含下级分支机构，只保留不是分级机构的部门
            if("0".equals(isSubOrg)){
                chDept = chDept.stream().filter(department1 -> department1.getClassifyOrg() == 0).collect(Collectors.toList());
            }
            resultList.addAll(chDept);
            for (Department department1 : chDept) {
                getAllChDept(department1, resultList, isSubOrg);
            }
        }
    }

    // 获取用户的部门使用权限（这个方法不处理OA管理员）
    // OA管理员，可以使用全部部门
    // 分支机构管理员，可以使用本分支机构及下属部门
    // 普通用户（总部人员、分支机构人员），可以使用本部门
    public List<Department> getUseDepartmentByUser(Users users) {
        List<Department> resultList = new ArrayList<>();
        // 是否开启分级机构设置.如没有直接返回
        String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();

        // 部门ID集合
        List<String> deptIds = new ArrayList<>();
        deptIds.add(String.valueOf(users.getDeptId()));// 存入本部门

        if (!StringUtils.checkNull(users.getDeptIdOther()) && users.getDeptIdOther().split(",").length > 0) {
            deptIds.addAll(Arrays.asList(users.getDeptIdOther().split(","))); // 存入辅助部门
        }

        List<Department> departments = departmentMapper.selDeptByIds(deptIds.toArray(new String[deptIds.size()]));
        for (Department department : departments) {
            resultList.add(department);// 存入本部门 (普通用户)
            // 判断是否是分支机构
            if (!StringUtils.checkNull(sysPara) && sysPara.equals("1") && department.getClassifyOrg() != null && department.getClassifyOrg() == 1) {
                // 判断是否是分支机构的管理员
                if (!StringUtils.checkNull(department.getClassifyOrgAdmin()) && Arrays.asList(department.getClassifyOrgAdmin().split(",")).contains(String.valueOf(users.getUid()))) {
                    // 是分支机构管理员，存入下属部门（分支机构管理员）
                    getAllChDept(department, resultList, department.getIsSubOrg());
                }
            }
        }

        return resultList;
    }


    @Transactional
    public ToJson addOtherDeptByUserIds(String userId, String deptIds){
        ToJson toJson = new ToJson(1,"error");
        try {
            List<Users> users = usersMapper.selUserByIds(userId.split(","));
            if (users != null && users.size() > 0) {
                for (Users user : users) {
                    String deptIdOther = user.getDeptIdOther();
                    //修改辅助部门，并且使其不能重复
                    String newDept= deptIdOther + deptIds;

                    TreeSet<String> ts=new TreeSet<>();
                    int len=newDept.split(",").length;
                    String ss[]=newDept.split(",");
                    for(int i=0;i<len;i++){
                        ts.add(ss[i]+"");
                    }

                    //2.循环遍历TreeSet
                    Iterator<String> i=ts.iterator();
                    StringBuilder sb=new StringBuilder();
                    while(i.hasNext()){
                        sb.append(i.next()+",");
                    }

                    Users u = new Users();
                    u.setUserId(user.getUserId());
                    u.setDeptIdOther(sb.toString());
                    usersMapper.updateByUserId(u);
                }
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }



    @Override
    @Transactional
    public ToJson deleteOtherDeptByUserIds(String userId, String deptIds) {
        ToJson toJson = new ToJson(1,"error");
        try{
            List<Users> users = usersMapper.selUserByIds(userId.split(","));
            if (users != null && users.size() > 0) {
                for (Users usersByuserId : users) {
                    if (!Objects.isNull(usersByuserId) && !StringUtils.checkNull(usersByuserId.getDeptIdOther()) && !StringUtils.checkNull(deptIds)) {
                        String[] deptIdArr = deptIds.split(",");
                        String deptIdOther = usersByuserId.getDeptIdOther();
                        for (String deptId : deptIdArr) {
                            //包含
                            if (deptIdOther.contains(",".concat(deptId).concat(",")) || deptIdOther.startsWith(deptId.concat(","))|| deptIdOther.endsWith(",".concat(deptId))) {
                                if(deptIdOther.endsWith(",".concat(deptId))){
                                    deptIdOther = deptIdOther.replace(",".concat(deptId), ",");
                                }else {
                                    deptIdOther = deptIdOther.replace(deptId.concat(","), "");
                                }
                            }
                        }
                        Users u = new Users();
                        u.setUserId(userId);
                        u.setDeptIdOther(deptIdOther);
                        usersMapper.updateByUserId(u);
                    }
                }
            }
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Department> getUseDepartmentByUser(HttpServletRequest request) {
        ToJson<Department> json = new ToJson<>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users(), redisSessionId);

        List<Department> list;

        Users managePriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_OPS_PRIV");//管理员
        // 判断是否是系统管理员或系统安全管理员
        if (users.getUserPriv().equals(1) || (!Objects.isNull(managePriv) && users.getUserId().equals(managePriv.getUserId()))
                || (!StringUtils.checkNull(users.getUserPrivOther()) && Arrays.asList(users.getUserPrivOther().split(",")).contains("1"))) {
            Map<String, Object> map = new HashMap<>();
            map.put("deptDisplay", "1");
            list = departmentMapper.getDatagridByDisplay(map);
            for (int i = 0; i < list.size(); i++) {
                Department o = list.get(i);
                if (o.getDeptId() == 0) {
                    list.remove(i);
                }
            }
        } else {
            list = getUseDepartmentByUser(users);
        }

        json.setFlag(0);
        json.setMsg("ok");
        json.setObj(list);
        return json;
    }

    @Override
    public ToJson selectDeptOther(HttpServletRequest request,String userId) {
        ToJson toJson = new ToJson(1,"error");
        try{
            Users users = usersMapper.seleById(userId);
            List<Department> list = new ArrayList<>();
            if(!Objects.isNull(users) && !StringUtils.checkNull(users.getDeptIdOther())){
                list = departmentMapper.userDeptOrder(users.getDeptIdOther().split(","));
            }
            toJson.setData(list);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setData(e.getMessage());
        }
        return toJson;
    }
}
