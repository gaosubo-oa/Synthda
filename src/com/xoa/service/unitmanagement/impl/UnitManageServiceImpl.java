package com.xoa.service.unitmanagement.impl;

import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.model.unitmanagement.UnitManage;
import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.unitmanagement.UnitManageService;
import com.xoa.util.GetAttachmentListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Service
public class UnitManageServiceImpl implements UnitManageService {

    @Resource
    private UnitManageMapper unitManageMapper;
    @Resource
    private SystemInfoService systemInfoService;

    @Autowired
    private OrgManageMapper orgManageMapper;

    @Override
    public UnitManage showUnitManage(String sqlType, HttpServletRequest request) {
        UnitManage UnitManage = unitManageMapper.showUnitManage();
        if (UnitManage.getAttachmentName() != null && UnitManage.getAttachmentId() != null) {
            UnitManage.setAttachment(GetAttachmentListUtil.returnAttachment(UnitManage.getAttachmentName(), UnitManage.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_SYS));
        }

        return UnitManage;
    }


    @Override
    public void addUnitManage(UnitManage unitManage) {
        unitManageMapper.addUnitManage(unitManage);
    }


    @Override
    public void update(UnitManage unitManage,String sqlType, HttpServletRequest request) {

        Map<String, String> stringStringMap = systemInfoService.getAuthorization(request);
        if ("xoa1001".equals(sqlType)) {
            if ("true".equals(stringStringMap.get("isAuthStr"))) {
                if (!unitManage.getUnitName().equals(stringStringMap.get("company"))) {
                    unitManage.setUnitName(stringStringMap.get("company"));

                }
            }else{
                OrgManage orgManage = new OrgManage();
                orgManage.setOid(1001);
                orgManage.setName(unitManage.getUnitName());
                int a = orgManageMapper.editOrgManage(orgManage);
            }
        }

        UnitManage unitManage1 = unitManageMapper.showUnitManage();
        if (unitManage1 != null) {
            unitManage.setUnitId(1);
            unitManageMapper.update(unitManage);
        } else {
            unitManageMapper.addUnitManage(unitManage);
        }

    }

}
