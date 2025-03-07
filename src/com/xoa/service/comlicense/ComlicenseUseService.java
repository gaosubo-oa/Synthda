package com.xoa.service.comlicense;

import com.xoa.model.comlicense.ComlicenseUseWithBLOBs;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;

import javax.servlet.http.HttpServletRequest;

public interface ComlicenseUseService {
    ToJson getDataByCondition(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs, PageParams pageParams);
//    管理员去审批借阅订单
    ToJson approvalStatus(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs);
//    提交人修改证照借阅信息
    ToJson updateComlicenseUse(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs);
//    申请人申请提交证照借阅信息
    ToJson addComlicenseUse(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs);
//    申请人取消证照借阅
    ToJson delComlicenseUse(HttpServletRequest request, String licenseUseIds);

    ToJson getDataByLicenseUseId(HttpServletRequest request, Integer licenseUseId);
}
