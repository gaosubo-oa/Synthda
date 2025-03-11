package com.xoa.service.users.impl;

import com.xoa.dao.users.UserModulePageMapper;
import com.xoa.model.users.UserModulePage;
import com.xoa.model.users.UserModulePageExample;
import com.xoa.service.users.UserModulePageService;


import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserModulePageServiceImpl implements UserModulePageService {

    @Autowired
    UserModulePageMapper userModulePageMapper;

    @Override
    public BaseWrapper save(UserModulePage userModulePage) {
        BaseWrapper baseWrapper = new BaseWrapper();

        UserModulePageExample userModulePageExample = new UserModulePageExample();
        UserModulePageExample.Criteria criteria = userModulePageExample.createCriteria();
        criteria.andModuleTableEqualTo(userModulePage.getModuleTable());
        criteria.andUserIdEqualTo(userModulePage.getUserId());

        // 查询是否存在
        List<UserModulePage> userModulePages = userModulePageMapper.selectByExample(userModulePageExample);
        // 如果存在就更新
        if(userModulePages!=null&&userModulePages.size()>0){
            userModulePages.forEach(userModulePage1 -> {
                userModulePage1.setPages(userModulePage.getPages());
                userModulePageMapper.updateByPrimaryKey(userModulePage1);
            });
        } else {
            // 不存在就插入
            userModulePageMapper.insertSelective(userModulePage);
        }

        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        baseWrapper.setMsg("ok");
        return baseWrapper;
    }

    @Override
    public BaseWrapper selectPage(UserModulePage userModulePage) {
        BaseWrapper baseWrapper = new BaseWrapper();

        UserModulePageExample userModulePageExample = new UserModulePageExample();
        UserModulePageExample.Criteria criteria = userModulePageExample.createCriteria();
        criteria.andModuleTableEqualTo(userModulePage.getModuleTable());
        criteria.andUserIdEqualTo(userModulePage.getUserId());

        // 查询是否存在
        List<UserModulePage> userModulePages = userModulePageMapper.selectByExample(userModulePageExample);
        if(userModulePages!=null&&userModulePages.size()>0){
            baseWrapper.setData(userModulePages.get(0));
        }
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        baseWrapper.setMsg("ok");
        return baseWrapper;
    }


}
