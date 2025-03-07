package com.xoa.webservice;
import com.xoa.model.department.Department;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.jws.WebService;

@WebService
public interface DeptWS {
    BaseWrapper insert(String orgId, Department department);
    BaseWrapper delete(String orgId, String deptid);
    BaseWrapper update(String orgId, Department department);

}
