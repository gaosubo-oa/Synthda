package com.xoa.webservice.impl;

import com.xoa.model.department.Department;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.users.UsersService;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.edu.ConstantsInfo;
import com.xoa.util.edu.WrapperUtil;
import com.xoa.webservice.DeptWS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptWSImpl implements DeptWS {

    @Autowired
    DepartmentService departmentService;

    @Autowired
    UsersService usersService;

    @Override
    public BaseWrapper insert(String orgId, Department department) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(orgId.isEmpty() || department == null){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        List<Department> depByCode = departmentService.getDepByCode(department.getDeptCode());
        if(depByCode.size() > 0){
            return update(orgId,department);
        }
        try {
            if (!departmentService.checkDep(department,0)){
                WrapperUtil.setError(baseWrapper, ConstantsInfo.ADD_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
                return baseWrapper;
            }
            Department departParent = null;
            if (department.getDeptParent()!=0){

                List<Department> deptparentlist = departmentService.getDepByCode(department.getDeptParent().toString());
                if(deptparentlist.size() > 0){
                    departParent = deptparentlist.get(0);
                    department.setDeptParent(departParent.getDeptId());
//                    department.setDeptNo(departParent.getDeptNo()+department.getDeptNo());
                    //排序号为空和排序号重复的问题
                    department.setDeptNo(verdictDept(StringUtils.checkNull(departParent.getDeptNo())?"":departParent.getDeptNo()
                            +(Integer.parseInt(department.getDeptNo())+100)));
                }else {
                    department.setDeptParent(0);
                    department.setDeptNo((Integer.parseInt(department.getDeptNo())+100)+"");
                }
            }else {
                List<Department> listByNo = departmentService.getDepByNo(department.getDeptNo());
                if (listByNo.size()>0){
                    WrapperUtil.setError(baseWrapper, ConstantsInfo.ADD_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
                    return baseWrapper;
                }
                department.setDeptNo((Integer.parseInt(department.getDeptNo())+100)+"");
            }
            departmentService.insertDept(department);
//            departmentService.updateDeptNo(0,"");
            WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.ADD_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
            return baseWrapper;
        } catch (Exception e) {
            e.printStackTrace();
            WrapperUtil.setError(baseWrapper, ConstantsInfo.ADD_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }

    }

    @Override
    public BaseWrapper delete(String orgId, String deptCode) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(orgId.isEmpty() || deptCode.isEmpty()){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        try {
            List<Department> deptList = departmentService.getDepByCode(deptCode);
            if(deptList.size() > 0){
                int deptid = deptList.get(0).getDeptId();
                Department dep = departmentService.getDeptById(deptid);
                List<Department> list = departmentService.getChDeptByNo(dep.getDeptNo());
                for (Department d : list) {
                    List<Users> l = usersService.getUsersByDeptId(d.getDeptId());
                    if (l.size() > 0) {
                        WrapperUtil.setError(baseWrapper, ConstantsInfo.DELETE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
                        return baseWrapper;
                    }
                }
                for (Department d : list) {
                    departmentService.deleteDept(d.getDeptId());
                }

                WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.DELETE_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
                return baseWrapper;
            }
            WrapperUtil.setError(baseWrapper, ConstantsInfo.DELETE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        } catch (Exception e) {
            WrapperUtil.setError(baseWrapper, ConstantsInfo.DELETE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
    }
    @Override
    public BaseWrapper update(String orgId, Department department ) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(orgId.isEmpty() || department == null){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        List<Department> depByCode = departmentService.getDepByCode(department.getDeptCode());
        if(depByCode.size() == 0){
            return insert(orgId,department);
        }
        try {
            List<Department> deptList = departmentService.getDepByCode(department.getDeptCode());
            if(deptList.size() > 0){
                department.setDeptId(deptList.get(0).getDeptId());
                List<Department> deptparentList = departmentService.getDepByCode(department.getDeptParent().toString());
                if(deptparentList.size() > 0){
                    department.setDeptParent(deptparentList.get(0).getDeptId());
                }else {
                    department.setDeptParent(0);
                }
                if (!departmentService.checkDep(department,1)){
                    WrapperUtil.setError(baseWrapper, ConstantsInfo.UPDATE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
                    return baseWrapper;
                }
                //排序号
                department.setDeptNo((Integer.parseInt(department.getDeptNo())+100)+"");
                departmentService.editDept(department);
//                departmentService.updateDeptNo(0,"");
                WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.UPDATE_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
                return baseWrapper;
            }

            WrapperUtil.setError(baseWrapper, ConstantsInfo.UPDATE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        } catch (Exception e) {
            WrapperUtil.setError(baseWrapper, ConstantsInfo.UPDATE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }


    }

    //此方法用于获取一个不重复的deptNo
    public String verdictDept(String deptNo){
        if(StringUtils.checkNull(deptNo))
            return "";
        List<Department> list = departmentService.getDepByNo(deptNo);
        if(list != null && list.size() > 0){
            verdictDept((Integer.valueOf(deptNo)+1)+"");
        }
        return deptNo;
    }

}