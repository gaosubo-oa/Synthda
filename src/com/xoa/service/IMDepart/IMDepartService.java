package com.xoa.service.IMDepart;

import com.xoa.model.department.Department;
import com.xoa.model.users.Users;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IMDepartService {

    //白名单
    public List<Department> getChDeptUserBai(int deptId, HttpServletRequest request , String queryType);

    //获取在线用户的所有父级部门
    public List<Department> getOnlineDepartments(HttpServletRequest request);

    public List<Department> getOnLinePeopleAndDept(List<Users> list);
}
