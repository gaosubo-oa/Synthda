package com.xoa.controller.hierarchical;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.model.department.Department;
import com.xoa.model.hierarchical.HierarchicalGlobal;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.hierarchical.HierarchicalGlobalService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-8-31 上午17:22:15
 * 类介绍:    分级机构设置
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/hierarchicalGlobal")
public class HierarchicalGlobalController {
    @Resource
    private HierarchicalGlobalService hierarchicalGlobalService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UsersService usersService;

    @Autowired
    private UserPrivMapper userPrivMapper;

    @Autowired
    private SysParaMapper sysParaMapper;

    @Autowired
    private UsersPrivService usersPrivService;



    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月26日 下午10:05:05
     * 方法介绍:   在分级机构中设置全局管理员
     *
     * @return String
     */
    @ResponseBody
    @RequestMapping("/setHierarchicalGlobalPerson")
    public ToJson<HierarchicalGlobal> setHierarchicalGlobalPerson(String globalJson) {
        return hierarchicalGlobalService.setHierarchicalGlobalPerson(globalJson);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月26日 下午10:05:05
     * 方法介绍:  查询分级机构中的全局管理员
     *
     * @return String
     */
    @ResponseBody
    @RequestMapping("/selGlobalPerson")
    public AjaxJson selGlobalPerson() {
        return hierarchicalGlobalService.selGlobalPerson();
    }

    /**
     * 按分级机构获取所有新增人员
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/getGlobalPerson")
    public AjaxJson getGlobalPerson(HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //获取分级机构对应的所有部门id
            List<Integer> listDepId = this.getListDeptId(request);

            //获取所有新增用户
            ToJson<Users> toJsonUser = usersService.getNewUsers("");
            List<Users> userList = toJsonUser.getObj();
            if (null != userList && userList.size() > 0) {
                Iterator it = userList.iterator();
                while (it.hasNext()) {
                    Users stu = (Users) it.next();
                    if (!listDepId.contains(stu.getDeptId())) {
                        it.remove(); //移除该对象
                    }
                }
            }
            ajaxJson.setObj(userList);
            ajaxJson.setFlag(true);
        }catch (Exception e){
            ajaxJson.setMsg("false");
            ajaxJson.setFlag(false);
        }
        return ajaxJson;
    }

    /**
     * 获取分级机构对应的角色
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/getGlobalPersonPriv")
    public AjaxJson getGlobalPersonPriv(HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        try {
            List<UserPriv>   list= null;
            String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
            String allType = request.getParameter("allType");

            Map<String,Object> maps = new HashMap<String,Object>();
            if(StringUtils.checkNull(sysPara) || sysPara.equals("0")||"1".equals(allType)){
                list = usersPrivService.getAllPriv(maps, null, null, false);
            }else{
                //获取分级机构对应的所有部门id
                List<Integer> listDepId = this.getListDeptId(request);
                maps.put("deptIds",listDepId.stream().toArray(Integer[]::new));
                list = userPrivMapper.getPrivNameByDeptIds(maps);
            }
            ajaxJson.setObj(list);
            ajaxJson.setFlag(true);
        }catch (Exception e){
            ajaxJson.setFlag(false);
            ajaxJson.setMsg("false");
        }
        return ajaxJson  ;
    }

    /**
     * 分级机构用户导入
     * @param request
     * @param response
     * @param session
     * @param file
     * @param ifUpdate
     * @param psWord
     * @param userPriv
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/GlobalinsertImportUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> GlobalinsertImportUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String psWord, String userPriv) {
        //获取分级机构对应的所有部门id
        List<Integer> listDepId = this.getListDeptId(request);
        request.setAttribute("globalDeptIds",listDepId);
        return usersService.insertImportUsers(request, response, session, file,ifUpdate, psWord, userPriv);
    }




    public List<Integer> getAllGlobaldeptId(List<Department> depList, List<Integer> listDepId) {
        for (Department d : depList) {
            listDepId.add(d.getDeptId());
            if (d.getChild() != null) {
                getAllGlobaldeptId(d.getChild(), listDepId);
            }
        }
        return listDepId;
    }


    public List<Integer> getListDeptId(HttpServletRequest request){
        //获取分级机构所有部门
        ToJson<Department> toJsonDep = departmentService.getClassifyOrgByAdmin(request);
        List<Department> depList = toJsonDep.getObj();
        List<Integer> listDepId = new ArrayList<Integer>();
        //获取分级机构对应的所有部门id
        listDepId = getAllGlobaldeptId(depList, listDepId).stream().distinct().collect(Collectors.toList());
        return listDepId;
    }
}
