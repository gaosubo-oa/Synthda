package com.xoa.service.comlicense;

import com.xoa.model.comlicense.ComlicenseInfoWithBLOBs;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;

import javax.servlet.http.HttpServletRequest;

public interface ComlicenseInfoService {
    ToJson addComlicenseInfo(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfo);

    ToJson deleteComlicenseType(HttpServletRequest request, Integer licenseId);

    ToJson updateComlicenseInfo(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfo);

    ToJson queryAll(HttpServletRequest request, PageParams pageParams);

    ToJson queryByInfoId(HttpServletRequest request, Integer licenseId);
//    通过licenseId查询该证照的历史日志数据
    ToJson getLogById(HttpServletRequest request, Integer licenseId);
//    根据条件获取证照信息
    ToJson getDataByCondition(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfoWithBLOBs,PageParams pageParams);
//    根据版本的主键id查询某个证照的版本
    ToJson getLogDetailById(HttpServletRequest request, Integer logId);
}
