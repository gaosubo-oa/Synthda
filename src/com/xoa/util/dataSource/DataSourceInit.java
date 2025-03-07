package com.xoa.util.dataSource;

import com.xoa.dao.users.OrgManageMapper;
import com.xoa.model.users.OrgManage;
import com.xoa.util.common.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class DataSourceInit {

    public static List<String> orgIds = new ArrayList<>();

    @Autowired
    private OrgManageMapper orgManageMapper;

    @PostConstruct
    public void init() {
        String dataSource = "";
        // 1.先查询主组织即 org_manage 中的 is_org =1 的库 如果存在的话  直接使用该库
        List<OrgManage> orgManages = orgManageMapper.selOrgManageIsOrg();

        if(orgManages!=null&&orgManages.size()>0){
            OrgManage orgManage = orgManages.get(0);
            if(orgManage!=null){
                Integer oid = orgManage.getOid();
                dataSource = oid.toString();
            }
        }

        // 2.如果没有主组织的情况下 获取列表中的第一个组织
        if(StringUtils.checkNull(dataSource)){
            OrgManage orgManage = orgManageMapper.selFirstOrg();
            if(orgManage!=null&&orgManage.getOid()>0){
                dataSource = orgManage.getOid().toString();
            }
        }

        ContextHolder.setConsumerType("xoa"+dataSource);
        List<OrgManage> org = orgManageMapper.queryId();
        orgIds = org.stream().map(OrgManage::getOid).map(String::valueOf).collect(Collectors.toList());
    }
}
